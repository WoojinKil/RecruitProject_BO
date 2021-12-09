package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.conf.AppConst;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.util.CommonUtil;
import kr.co.ta9.pandora3.common.util.MD5Util;
import kr.co.ta9.pandora3.pcmn.dao.TcmnCdDtlDao;
import kr.co.ta9.pandora3.pcommon.dto.TbBcpcAthrApp;
import kr.co.ta9.pandora3.pcommon.dto.TcmnCdDtl;
import kr.co.ta9.pandora3.pcommon.dto.TmbrAdmLgnInf;
import kr.co.ta9.pandora3.pcommon.dto.TmbrClu;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmRol;
import kr.co.ta9.pandora3.pmbr.dao.TmbrAdmLgnInfDao;
import kr.co.ta9.pandora3.pmbr.dao.TmbrCluDao;
import kr.co.ta9.pandora3.psys.dao.TbBcpcAthrAppDao;
import kr.co.ta9.pandora3.psys.dao.TbLgapAthrappHDao;
import kr.co.ta9.pandora3.psys.dao.TbLgjbAdmlgninfHDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmRolDao;

/**
 * <pre>
 * 1. 클래스명 : Psys1017Mgr
 * 2. 설명 : BO회원가입 서비스
 * 3. 작성일 : 2018-04-16
 * 4. 작성자 : TANINE
 * </pre>
 */

@Service
public class Psys1017Mgr {
	
	
	@Autowired
	private TmbrCluDao tmbrCluDao;
	
	@Autowired
	private TmbrAdmLgnInfDao tmbrAdmLgnInfDao;
	
	@Autowired
	private TbLgjbAdmlgninfHDao tbLgjbAdmlgninfHDao;
	
	@Autowired
	private TcmnCdDtlDao tcmnCdDtlDao;
	
	@Autowired
	private TsysAdmRolDao tsysAdmRolDao;
	
	@Autowired
	private TbLgapAthrappHDao tbLgapAthrappHDao;
	
	@Autowired
	private TbBcpcAthrAppDao tbBcpcAthrAppDao;
	
	
	/**
	 * 회원가입
	 * @param parameterMap
	 * @return int
	 * @throws Exception
	 */	
	public String insertTmbrAdmLgnInf(ParameterMap parameterMap) throws Exception{
		
		//실제 권한 신청에 대한 검증
		boolean athrAppValidRolId = false;

		// 패스워드 파라미터 설정 시 패스워드 정보 암호화
		if(!StringUtils.isEmpty(parameterMap.getValue("lgn_pwd")))
			parameterMap.put("lgn_pwd", new MD5Util().hexDigest(parameterMap.getValue("lgn_pwd")));
		
		/* ---------  */
		
		TmbrAdmLgnInf tmbrAdmLgnInf = (TmbrAdmLgnInf)parameterMap.populate(TmbrAdmLgnInf.class);
		
		//자동 승인으로 처리 요청
		tmbrAdmLgnInf.setActv_yn("Y");
		tmbrAdmLgnInf.setUsr_stat_cd("3");
		tmbrAdmLgnInf.setMngr_tp_cd("99");
		tmbrAdmLgnInf.setApvl_yn("N");
		tmbrAdmLgnInf.setCtf_yn("Y");
		tmbrAdmLgnInf.setApvl_rfs_rsn("회원가입 권한 자동 신청");
		
		String result = "";
		
			
		tmbrAdmLgnInf.setUsr_id(tmbrAdmLgnInf.getLgn_id());
		tmbrAdmLgnInf.setCrtr_id(tmbrAdmLgnInf.getUsr_id());
		tmbrAdmLgnInf.setUpdr_id(tmbrAdmLgnInf.getUsr_id());
			
		tmbrAdmLgnInfDao.insert(tmbrAdmLgnInf);
		
		Map<String, Object> tmbrAdmLgnInfMap = CommonUtil.convertObjectToMap(tmbrAdmLgnInf);
		ParameterMap paramMap = new ParameterMap(); 
		
		paramMap.put("mst_cd", "MSTS");
		paramMap.put("cd", tmbrAdmLgnInfMap.get("usr_stat_cd"));
		
		TcmnCdDtl tcmnCdDtl = tcmnCdDtlDao.selectDTO("TcmnCdDtl.select", paramMap);
		
		
		tmbrAdmLgnInfMap.put("hist_stat_cd", "10");
		tmbrAdmLgnInfMap.put("hist_stat_nm", "추가");
		if(tcmnCdDtl != null) {
			tmbrAdmLgnInfMap.put("usr_ss_nm", tcmnCdDtl.getCd_nm());
		}
		
		// 이력 insert
		tbLgjbAdmlgninfHDao.insertTbLgjbAdmlgninfH(tmbrAdmLgnInfMap);
		parameterMap.put("usr_id", tmbrAdmLgnInf.getUsr_id());
		parameterMap.put("crtr_id", tmbrAdmLgnInf.getUsr_id());
		parameterMap.put("updr_id", tmbrAdmLgnInf.getUsr_id());
		
		
		String rol_id = parameterMap.getValue("rol_id");
		
		//신청 가능한 권한 조회
		List<TsysAdmRol> tsysAdmRolList = tsysAdmRolDao.selectTsysAdmVIPRolList(parameterMap);
		
		//신청한 권한이 실제 권한 신청이 가능한 권한인지 확인.
		for(TsysAdmRol tsysAdmRol : tsysAdmRolList) {
			if(rol_id.equals(tsysAdmRol.getRol_id())) {
				athrAppValidRolId = true;
				
			}
		}
		
		if(athrAppValidRolId) {
			List<TbBcpcAthrApp> insertTbBcpcAthrAppList = new ArrayList<TbBcpcAthrApp>();
			parameterMap.populatesForForceUpdate(TbBcpcAthrApp.class, insertTbBcpcAthrAppList);
			
			TbBcpcAthrApp tbBcpcAthrApp = (TbBcpcAthrApp) parameterMap.populate(TbBcpcAthrApp.class);
			
			//신청 목록 insert
			tbBcpcAthrApp.setAppl_stat_nm("미승인");
			tbBcpcAthrApp.setAppl_stat_cd("20");
			tbBcpcAthrApp.setAppl_rsn_cont("시스템 자동 신청");
			tbBcpcAthrApp.setApvl_yn("N");
			tbBcpcAthrAppDao.insertTbBcpcAthrApp(tbBcpcAthrApp);
			tbLgapAthrappHDao.insertTbLgapAthrappH(tbBcpcAthrApp);
		
		}

		result = tmbrAdmLgnInf.getUsr_id();
		return result;
	}
	
	/**
	 * 약관 코드 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */	
	public List<TmbrClu> getTmbrCluCode(ParameterMap parameterMap) throws Exception{
		return tmbrCluDao.getTmbrCluCode(parameterMap);
	}

	/**
	 * vip 회원가입 > 권한 목록
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectVipRolList(ParameterMap parameterMap) throws Exception {
		parameterMap.put("sys_cd", AppConst.SYS_CD);
		return tsysAdmRolDao.selectVipRolList(parameterMap);
	}
}
