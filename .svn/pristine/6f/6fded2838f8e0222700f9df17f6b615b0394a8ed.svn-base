package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmMnuBtnRtnn;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmMnuRtnn;
import kr.co.ta9.pandora3.psys.dao.TsysAdmMnuBtnRtnnDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmMnuDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmMnuRtnnDao;


/**
* <pre>
* 1. 클래스명 : Psys1034Mgr
* 2. 설명 : 권한 승인 관리
* 3. 작성일 : 2019-10-18
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Psys1036Mgr {

	@Autowired
	private TsysAdmMnuDao tsysAdmMnuDao;

	@Autowired
	private TsysAdmMnuRtnnDao tsysAdmMnuRtnnDao;

	@Autowired
	private TsysAdmMnuBtnRtnnDao tsysAdmMnuBtnRtnnDao;


	/**
	 * 사용자 권한 메뉴 신청 승인 목록 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmMnuUsrRtnnApplGrdList(ParameterMap parameterMap) throws Exception {
		return tsysAdmMnuDao.selectTsysAdmMnuUsrRtnnApplGrdList(parameterMap);
	}

	/**
	 * 사용자 메뉴 버튼 신청
	 * @param parameterMap
	 * @throws Exception
	 */
	public void savePsys1035ApplMnuBtnList(ParameterMap parameterMap) throws Exception {

		List<TsysAdmMnuRtnn> insertList = new ArrayList<TsysAdmMnuRtnn>();
		List<TsysAdmMnuRtnn> updateList = new ArrayList<TsysAdmMnuRtnn>();
		List<TsysAdmMnuRtnn> deleteList = new ArrayList<TsysAdmMnuRtnn>();
		parameterMap.populates(TsysAdmMnuRtnn.class, insertList, updateList, deleteList);

		TsysAdmMnuRtnn[] update = updateList.toArray(new TsysAdmMnuRtnn[0]);

		for(TsysAdmMnuRtnn tsysAdmMnuRtnn : update) {
			UserInfo userInfo = parameterMap.getUserInfo();
			if(userInfo != null){
				tsysAdmMnuRtnn.setUsr_id(userInfo.getUser_id());
				// 삭제 후 재입력
				tsysAdmMnuRtnnDao.delete(tsysAdmMnuRtnn);

				tsysAdmMnuRtnnDao.insertApplMnu(tsysAdmMnuRtnn);

				TsysAdmMnuBtnRtnn tsysAdmMnuBtnRtnnDel = new TsysAdmMnuBtnRtnn();

				tsysAdmMnuBtnRtnnDel.setUsr_id(tsysAdmMnuRtnn.getUsr_id());
				tsysAdmMnuBtnRtnnDel.setMnu_seq(tsysAdmMnuRtnn.getMnu_seq());
				tsysAdmMnuBtnRtnnDel.setPgm_id(tsysAdmMnuRtnn.getPgm_id());
				tsysAdmMnuBtnRtnnDao.delete(tsysAdmMnuBtnRtnnDel);
			}

			if(!"".equals(tsysAdmMnuRtnn.getAppl_btn_list()) ) {

				String[] appl_btn_list = tsysAdmMnuRtnn.getAppl_btn_list().split(",");

				for(String applBtn : appl_btn_list ) {

					TsysAdmMnuBtnRtnn tsysAdmMnuBtnRtnn = new TsysAdmMnuBtnRtnn();

					tsysAdmMnuBtnRtnn.setUsr_id(tsysAdmMnuRtnn.getUsr_id());
					tsysAdmMnuBtnRtnn.setMnu_seq(tsysAdmMnuRtnn.getMnu_seq());
					tsysAdmMnuBtnRtnn.setPgm_id(tsysAdmMnuRtnn.getPgm_id());
					tsysAdmMnuBtnRtnn.setPgm_btn_cd(applBtn);
					tsysAdmMnuBtnRtnn.setCrtr_id(tsysAdmMnuRtnn.getUsr_id());
					tsysAdmMnuBtnRtnn.setUpdr_id(tsysAdmMnuRtnn.getUsr_id());

					tsysAdmMnuBtnRtnnDao.insert(tsysAdmMnuBtnRtnn);

				}
			}
		}
	}


}
