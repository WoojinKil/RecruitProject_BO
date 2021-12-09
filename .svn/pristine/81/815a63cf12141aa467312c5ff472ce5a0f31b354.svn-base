package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.util.CommonUtil;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmMnuBtnRtnn;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmMnuRtnn;
import kr.co.ta9.pandora3.psys.dao.TbLgapMnurtnnHDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmMnuBtnRtnnDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmMnuRtnnDao;

/**
 * <pre>
 * 1. 클래스명 : Psys1029Mgr
 * 2. 설명 : 시스템회원 메뉴 권한관리 서비스
 * 3. 작성일 : 2019-03-12
 * 4. 작성자 : TANINE
 * </pre>
 */

@Service
public class Psys1029Mgr {

	@Autowired
	private TsysAdmMnuRtnnDao tsysAdmMnuRtnnDao;

	@Autowired
	private TsysAdmMnuBtnRtnnDao tsysAdmMnuBtnRtnnDao;

	@Autowired
	private TbLgapMnurtnnHDao tbLgapMnurtnnHDao;

	/**
	 * 관리자메뉴할당 그리드 조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject getTsysAdmMnuRtnnGrdList(ParameterMap parameterMap) throws Exception {
		return tsysAdmMnuRtnnDao.getTsysAdmMnuRtnnGrdList(parameterMap);
	}



	/**
	 * 권리자메뉴버튼할당 정보 조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject getTsysAdmMnuBtnRtnnInf(ParameterMap parameterMap) throws Exception {
		return tsysAdmMnuBtnRtnnDao.getTsysAdmMnuBtnRtnnInf(parameterMap);
	}

	/**
	 * 권리자메뉴버튼할당 정보 삭제 후 저장
	 * @param  parameterMap
	 * @throws Exception
	 */
	public void saveTsysAdmMnuBtnRtnnList(ParameterMap parameterMap) throws Exception {
		// 권리자메뉴버튼할당 정보 삭제
		TsysAdmMnuBtnRtnn tsysAdmMnuBtnRtnn = new TsysAdmMnuBtnRtnn();
		tsysAdmMnuBtnRtnn.setUsr_id(parameterMap.getValue("usr_id"));
		tsysAdmMnuBtnRtnn.setMnu_seq(parameterMap.getInt("mnu_seq"));
		tsysAdmMnuBtnRtnn.setPgm_id(parameterMap.getValue("pgm_id"));
		UserInfo userInfo = parameterMap.getUserInfo();
		if(userInfo != null){
			String user_id = userInfo.getUser_id();
			tsysAdmMnuBtnRtnn.setUpdr_id(user_id);
			tsysAdmMnuBtnRtnn.setCrtr_id(user_id);
			tsysAdmMnuBtnRtnnDao.deleteTsysAdmMnuBtnRtnnInf(tsysAdmMnuBtnRtnn);// 삭제 이력은 남기지 않는다. 왜냐 이건 다시 넣기때문에 수정이라고 하는게 맞음 .고로 삭제 이력을 넣지 않는다.두둥탁


			// 권리자메뉴버튼할당 정보 저장
			String mpp_btn_inf = StringUtils.isNotEmpty(parameterMap.getValue("mpp_btn_inf")) ? parameterMap.getValue("mpp_btn_inf") : "";
			String mpp_btn_inf_nm = StringUtils.isNotEmpty(parameterMap.getValue("mpp_btn_inf_nm")) ? parameterMap.getValue("mpp_btn_inf_nm") : "";
			parameterMap.put("apvl_usr_id", user_id);
			parameterMap.put("pgm_btn_cd", mpp_btn_inf);
			parameterMap.put("pgm_btn_nm", mpp_btn_inf_nm);
			parameterMap.put("hist_stat_cd", "30");
			parameterMap.put("hist_stat_nm", "수정");

			if(!"".equals(mpp_btn_inf)) {
				String[] mpp_btn_inf_arr = mpp_btn_inf.split(",");
				for(int i = 0; i < mpp_btn_inf_arr.length; i++) {
					tsysAdmMnuBtnRtnn.setPgm_btn_cd(String.valueOf(mpp_btn_inf_arr[i]));
					tsysAdmMnuBtnRtnnDao.insert(tsysAdmMnuBtnRtnn);
				}
			}
			tbLgapMnurtnnHDao.insertTbLgapMnurtnnHMap(parameterMap);
		}
	}

	public void savePsys1029AdmMnuList(ParameterMap parameterMap) throws Exception {

		List<TsysAdmMnuRtnn> insertList = new ArrayList<TsysAdmMnuRtnn>();
		List<TsysAdmMnuRtnn> deleteList = new ArrayList<TsysAdmMnuRtnn>();
		parameterMap.populates(TsysAdmMnuRtnn.class, insertList, null, deleteList);

		TsysAdmMnuRtnn[] insert = insertList.toArray(new TsysAdmMnuRtnn[0]);
		TsysAdmMnuRtnn[] delete = deleteList.toArray(new TsysAdmMnuRtnn[0]);


		// 사용자 메뉴 매핑 작업.
		for (TsysAdmMnuRtnn tsysAdmMnuRtnn : insert) {

			Map<String, Object> tsysAdmMnuRtnnMap = CommonUtil.convertObjectToMap(tsysAdmMnuRtnn);

			tsysAdmMnuRtnnMap.put("hist_stat_cd", "10");
			tsysAdmMnuRtnnMap.put("hist_stat_nm", "추가");
			tsysAdmMnuRtnnMap.put("apvl_usr_id", parameterMap.getUserInfo().getUser_id());

			//매핑 테이블 입력.
			tsysAdmMnuRtnnDao.insert(tsysAdmMnuRtnn);

			//매핑되는 이력 insert
//			tbLgapMnurtnnHDaoTrx.insertTbLgapMnurtnnHMap(tsysAdmMnuRtnnMap);

		}


		for(TsysAdmMnuRtnn tsysAdmMnuRtnn : delete) {
			List<String> tsysAdmMnuBtnCdList = new ArrayList<String>();
			List<String> tsysAdmMnuBtnNmList = new ArrayList<String>();
			Map<String, Object> tsysAdmMnuRtnnMap = CommonUtil.convertObjectToMap(tsysAdmMnuRtnn);

			tsysAdmMnuRtnnMap.put("hist_stat_cd", "20");
			tsysAdmMnuRtnnMap.put("hist_stat_nm", "삭제");
			tsysAdmMnuRtnnMap.put("apvl_usr_id", parameterMap.getUserInfo().getUser_id());
			//매핑된 메뉴 삭제
			tsysAdmMnuRtnnDao.delete(tsysAdmMnuRtnn);

			TsysAdmMnuBtnRtnn tsysAdmMnuBtnRtnn = new TsysAdmMnuBtnRtnn();
			tsysAdmMnuBtnRtnn.setUsr_id(tsysAdmMnuRtnn.getUsr_id());
			tsysAdmMnuBtnRtnn.setMnu_seq(tsysAdmMnuRtnn.getMnu_seq());
			tsysAdmMnuBtnRtnn.setPgm_id(tsysAdmMnuRtnn.getPgm_id());

			List<TsysAdmMnuBtnRtnn> tsysAdmMnuBtnRtnnList = tsysAdmMnuBtnRtnnDao.selectTsysAdmMnuBtnRtnnList(tsysAdmMnuBtnRtnn);

			for (TsysAdmMnuBtnRtnn tsysAdmMnuBtnRtnnInfo : tsysAdmMnuBtnRtnnList) {
				tsysAdmMnuBtnCdList.add(tsysAdmMnuBtnRtnnInfo.getPgm_btn_cd());
				tsysAdmMnuBtnNmList.add(tsysAdmMnuBtnRtnnInfo.getPgm_btn_nm());
			}
			tsysAdmMnuRtnnMap.put("pgm_btn_cd", String.join(",", tsysAdmMnuBtnCdList));
			tsysAdmMnuRtnnMap.put("pgm_btn_nm", String.join(",", tsysAdmMnuBtnNmList));

			//삭제시 매핑된 버튼 정보 삭제
//			tsysAdmMnuBtnRtnnDaoTrx.deleteTsysAdmMnuBtnRtnnInf(tsysAdmMnuBtnRtnn);
			//매핑되는 이력 insert
//			tbLgapMnurtnnHDaoTrx.insertTbLgapMnurtnnHMap(tsysAdmMnuRtnnMap);


		}

	}

}
