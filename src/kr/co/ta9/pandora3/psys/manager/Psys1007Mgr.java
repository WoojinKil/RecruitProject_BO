package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.util.CommonUtil;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.pcmn.dao.TcmnCdDtlDao;
import kr.co.ta9.pandora3.pcommon.dto.TcmnCdDtl;
import kr.co.ta9.pandora3.pcommon.dto.TmbrAdmLgnInf;
import kr.co.ta9.pandora3.pmbr.dao.TmbrAdmLgnInfDao;
import kr.co.ta9.pandora3.psys.dao.TbLgjbAdmlgninfHDao;

/**
 * <pre>
 * 1. 클래스명 : Psys1007Mgr
 * 2. 설명 : 시스템사용자관리 서비스
 * 3. 작성일 : 2018-03-28
 * 4. 작성자 : TANINE
 * </pre>
 */

@Service
public class Psys1007Mgr {

	@Autowired
	private TmbrAdmLgnInfDao tmbrAdmLgnInfDao;
	
	@Autowired
	private TbLgjbAdmlgninfHDao tbLgjbAdmlgninfHDao;
	
	@Autowired
	private TcmnCdDtlDao tcmnCdDtlDao;
	
	
	/**
	 * BO 사용자 리스트 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTmbrAdmLgnInfGridList(ParameterMap parameterMap) throws Exception {
		return tmbrAdmLgnInfDao.selectTmbrAdmLgnInfGridList(parameterMap);
	}
	
	/**
	 * BO 사용자 입력/수정/삭제
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTmbrAdmLgnInfList(ParameterMap parameterMap) throws Exception {

		List<TmbrAdmLgnInf> insertList = new ArrayList<TmbrAdmLgnInf>();
		List<TmbrAdmLgnInf> updateList = new ArrayList<TmbrAdmLgnInf>();
		List<TmbrAdmLgnInf> deleteList = new ArrayList<TmbrAdmLgnInf>();
		
		parameterMap.populates(TmbrAdmLgnInf.class, insertList, updateList, deleteList);
		
		TmbrAdmLgnInf[] insert = insertList.toArray(new TmbrAdmLgnInf[0]);
		TmbrAdmLgnInf[] update = updateList.toArray(new TmbrAdmLgnInf[0]);
		TmbrAdmLgnInf[] delete = deleteList.toArray(new TmbrAdmLgnInf[0]);
			
		tmbrAdmLgnInfDao.insertMany(insert);
		tmbrAdmLgnInfDao.updateMany(update);
		tmbrAdmLgnInfDao.deleteMany(delete); 
	}
	
	/**
	 * BO 초기화 버튼
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public String updateTmbrAdmLgnInfPwChg(ParameterMap parameterMap) throws Exception {
		
		String result = "";
		int updateCnt = 0;
		
		UserInfo userInfo = parameterMap.getUserInfo();
		
		TmbrAdmLgnInf tmbrAdmLgnInf = tmbrAdmLgnInfDao.selectTmbrAdmLgnInfInfo(parameterMap);
		tmbrAdmLgnInf.setUsr_id(parameterMap.getValue("usr_id")); 
		tmbrAdmLgnInf.setUpdr_id(userInfo.getUser_id());
		tmbrAdmLgnInf.setActv_yn(Const.BOOLEAN_TRUE);
		
		updateCnt = tmbrAdmLgnInfDao.updateTmbrAdmLgnInfInitAdminPwInfo(tmbrAdmLgnInf);
		
		//이력을 위한.
		tmbrAdmLgnInf.setCrtr_id(userInfo.getUser_id());
		tmbrAdmLgnInf.setUpdr_id(userInfo.getUser_id()); 
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
		
		
		if(updateCnt > 0) {
			result = Const.BOOLEAN_SUCCESS;
		} else {
			result = Const.BOOLEAN_FAIL;
		}
		
		return result;
	}
}
