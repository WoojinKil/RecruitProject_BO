package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.util.CommonUtil;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.mbsv.dao.MbsvStrSrvMgmDao;
import kr.co.ta9.pandora3.pcmn.dao.TcmnCdDtlDao;
import kr.co.ta9.pandora3.pcommon.dto.TbBcpcAthrApp;
import kr.co.ta9.pandora3.pcommon.dto.TcmnCdDtl;
import kr.co.ta9.pandora3.pcommon.dto.TmbrAdmLgnInf;
import kr.co.ta9.pandora3.pmbr.dao.TmbrAdmLgnInfDao;
import kr.co.ta9.pandora3.psys.dao.TbBcpcAthrAppDao;
import kr.co.ta9.pandora3.psys.dao.TbLgapAthrappHDao;
import kr.co.ta9.pandora3.psys.dao.TbLgapRolrtnnHDao;
import kr.co.ta9.pandora3.psys.dao.TbLgjbAdmlgninfHDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmRolRtnnDao;

/**
* <pre>
* 1. 클래스명 : Psys1006Mgr
* 2. 설명 : 권한관리 서비스
* 3. 작성일 : 2018-03-28
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Psys1047Mgr {

	@Autowired
	private TbBcpcAthrAppDao tbBcpcAthrAppDao;

	@Autowired
	private TbLgapAthrappHDao tbLgapAthrappHDao;

	@Autowired
	private TmbrAdmLgnInfDao tmbrAdmLgnInfDao;

	@Autowired
	private TbLgjbAdmlgninfHDao tbLgjbAdmlgninfHDao;

	@Autowired
	private TcmnCdDtlDao tcmnCdDtlDao;

	@Autowired
	private TsysAdmRolRtnnDao tsysAdmRolRtnnDao;

	@Autowired
	private TbLgapRolrtnnHDao tbLgapRolrtnnHDao;

	@Autowired
	private MbsvStrSrvMgmDao mbsvStrSrvMgmDao;



	/**
	 * 사원관리 > 외부사원 승인 관리 목록
	 * @param parameterMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public JSONObject selectExtnTmbrAdmLgnInfGridList(ParameterMap parameterMap) throws Exception {

		return null;
	}
	/**
	 * 권한신청 관리 > 개인 권한 신청
	 * @param parameterMap
	 * @throws Exception
	 */
	public void insertTbbcpcAthrApp(ParameterMap parameterMap) throws Exception {

		


	}
	public void updateExtnTmbrAdmLgnInf(ParameterMap parameterMap) throws Exception {
		parameterMap.put("apvl_rfs_rsn_cont", parameterMap.getValue("APVL_RFS_RSN"));


		List<TmbrAdmLgnInf> insertList = new ArrayList<TmbrAdmLgnInf>();
		List<TmbrAdmLgnInf> updateList = new ArrayList<TmbrAdmLgnInf>();
		List<TmbrAdmLgnInf> deleteList = new ArrayList<TmbrAdmLgnInf>();

		List<TbBcpcAthrApp> tbBcpcAthrUpdateList = new ArrayList<TbBcpcAthrApp>();



		parameterMap.populatesForForceUpdate(TbBcpcAthrApp.class, tbBcpcAthrUpdateList);

		parameterMap.populates(TmbrAdmLgnInf.class, insertList, updateList, deleteList);

		//update -> 승인
		TmbrAdmLgnInf[] update = updateList.toArray(new TmbrAdmLgnInf[0]);
		//delete -> 반려 -> 삭제
		TmbrAdmLgnInf[] delete = deleteList.toArray(new TmbrAdmLgnInf[0]);

		TbBcpcAthrApp[] tbBcpcAthrUpdate = tbBcpcAthrUpdateList.toArray(new TbBcpcAthrApp[0]);


		//회원 승인 처리
		for (TmbrAdmLgnInf tmbrAdmLgnInf : update) {
			//외부 사용자 승인 처리.
			tmbrAdmLgnInfDao.updateExtnTmbrAdmLgnInfApvl(tmbrAdmLgnInf);

			Map<String, Object> tmbrAdmLgnInfMap = CommonUtil.convertObjectToMap(tmbrAdmLgnInf);
			ParameterMap paramMap = new ParameterMap();

			paramMap.put("mst_cd", "MSTS");
			paramMap.put("cd", tmbrAdmLgnInfMap.get("usr_stat_cd"));

			TcmnCdDtl tcmnCdDtl = tcmnCdDtlDao.selectDTO("TcmnCdDtl.select", paramMap);


			tmbrAdmLgnInfMap.put("hist_stat_cd", "20");
			tmbrAdmLgnInfMap.put("hist_stat_nm", "수정");
			if(tcmnCdDtl != null) {
				tmbrAdmLgnInfMap.put("usr_ss_nm", tcmnCdDtl.getCd_nm());
			}

			// 이력 insert
			tbLgjbAdmlgninfHDao.insertTbLgjbAdmlgninfH(tmbrAdmLgnInfMap);
		}

		//반려 처리 > 회원 삭제  처리
		for (TmbrAdmLgnInf tmbrAdmLgnInf : delete) {
			tmbrAdmLgnInfDao.deleteExtnTmbrAdmLgnInfApvl(tmbrAdmLgnInf);

			Map<String, Object> tmbrAdmLgnInfMap = CommonUtil.convertObjectToMap(tmbrAdmLgnInf);
			ParameterMap paramMap = new ParameterMap();

			paramMap.put("mst_cd", "MSTS");
			paramMap.put("cd", tmbrAdmLgnInfMap.get("usr_stat_cd"));

			TcmnCdDtl tcmnCdDtl = tcmnCdDtlDao.selectDTO("TcmnCdDtl.select", paramMap);

			tmbrAdmLgnInfMap.put("hist_stat_cd", "30");
			tmbrAdmLgnInfMap.put("hist_stat_nm", "삭제");

			if(tcmnCdDtl != null) {
				tmbrAdmLgnInfMap.put("usr_ss_nm", tcmnCdDtl.getCd_nm());
			}

			//문자전송 로직 필요

			// 이력 insert
			tbLgjbAdmlgninfHDao.insertTbLgjbAdmlgninfH(tmbrAdmLgnInfMap);
		}


		//신청 권한에 대한 update 처리 (승인/반려) 처리.
		for(TbBcpcAthrApp tbBcpcAthrApp : tbBcpcAthrUpdate) {

			tbBcpcAthrApp.setApvl_yn("Y");
			tbBcpcAthrApp.setApvl_usr_id(parameterMap.getUserInfo().getUser_id());

			// 신청 테이블 update
			tbBcpcAthrAppDao.updateTbBcpcAthrApp(tbBcpcAthrApp);

			parameterMap.put("mst_cd", "APPL_STAT_CD");
			parameterMap.put("cd", tbBcpcAthrApp.getAppl_stat_cd());

			TcmnCdDtl tcmnCdDtl = tcmnCdDtlDao.selectDTO("TcmnCdDtl.select", parameterMap);

			tbBcpcAthrApp.setAppl_stat_nm(tcmnCdDtl.getCd_nm());

			//이력 insert
			tbLgapAthrappHDao.insertTbLgapAthrappH(tbBcpcAthrApp);

			//승인 시 실제 사용자 권한 매핑 처리 및 로그 insert
			if("10".equals(tbBcpcAthrApp.getAppl_stat_cd())) {

				Map<String, Object> tsysAdmRolRtnnMap  = CommonUtil.convertObjectToMap(tbBcpcAthrApp);

				//사용자 권한 매핑
				tsysAdmRolRtnnDao.insertTsysAdmRolRtnnMap(tsysAdmRolRtnnMap);
				tsysAdmRolRtnnMap.put("rol_stat_cd", "10");
				tsysAdmRolRtnnMap.put("rol_stat_nm", "추가");

				//사용자 권한 매핑 이력
				tbLgapRolrtnnHDao.insertTbLgapRolrtnnH(tsysAdmRolRtnnMap);

			}


		}


	}


   

    /**
     * 서비스접점 정보 조회
     * @param parameterMap
     * @return List<Map>
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    public List<Map> selectPocCdInfoList(ParameterMap parameterMap) throws Exception {
        return mbsvStrSrvMgmDao.selectPocCdInfoList(parameterMap);
    }

}

