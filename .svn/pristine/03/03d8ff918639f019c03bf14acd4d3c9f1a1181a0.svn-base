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
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmRolRtnn;
import kr.co.ta9.pandora3.psys.dao.TbLgapRolrtnnHDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmRolRtnnDao;

/**
 * <pre>
 * 1. 클래스명 : Psys1008Mgr
 * 2. 설명 : 시스템사용자권한관리 서비스
 * 3. 작성일 : 2018-03-28
 * 4. 작성자 : TANINE
 * </pre>
 */

@Service
public class Psys1008Mgr {

	@Autowired
	private TsysAdmRolRtnnDao tsysAdmRolRtnnDao;
	@Autowired
	private TbLgapRolrtnnHDao tbLgapRolrtnnHDao;
	/**
	 * 시스템 사용자 권한 목록
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmRolRtnnGridList(ParameterMap parameterMap) throws Exception {
		return tsysAdmRolRtnnDao.selectTsysAdmRolRtnnGridList(parameterMap);
	}

	/**
	 * 시스템 사용자 권한 저장
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTsysAdmRolRtnnList(ParameterMap parameterMap) throws Exception {

		List<TsysAdmRolRtnn> insertList = new ArrayList<TsysAdmRolRtnn>();
		List<TsysAdmRolRtnn> updateList = new ArrayList<TsysAdmRolRtnn>();
		List<TsysAdmRolRtnn> deleteList = new ArrayList<TsysAdmRolRtnn>();
		parameterMap.populates(TsysAdmRolRtnn.class, insertList, updateList, deleteList);

		TsysAdmRolRtnn[] insert = insertList.toArray(new TsysAdmRolRtnn[0]);
		TsysAdmRolRtnn[] update = updateList.toArray(new TsysAdmRolRtnn[0]);
		TsysAdmRolRtnn[] delete = deleteList.toArray(new TsysAdmRolRtnn[0]);
		UserInfo userInfo = parameterMap.getUserInfo();
		if(userInfo != null){
			for (TsysAdmRolRtnn tsysAdmRolRtnn : insert) {

				tsysAdmRolRtnnDao.insert(tsysAdmRolRtnn);


				Map<String,Object> tsysAdmRolRtnnMap = CommonUtil.convertObjectToMap(tsysAdmRolRtnn);

				tsysAdmRolRtnnMap.put("rol_stat_cd", "10");
				tsysAdmRolRtnnMap.put("rol_stat_nm", "추가");
				tsysAdmRolRtnnMap.put("crtr_id",parameterMap.getUserInfo().getUser_id());
				tsysAdmRolRtnnMap.put("updr_id",parameterMap.getUserInfo().getUser_id());

				//삭제에 대한 로그 insert 필요.
//				tbLgapRolrtnnHDaoTrx.insertTbLgapRolrtnnH(tsysAdmRolRtnnMap);

			}

			for (TsysAdmRolRtnn tsysAdmRolRtnn : update) {

				tsysAdmRolRtnnDao.update(tsysAdmRolRtnn);

				Map<String,Object> tsysAdmRolRtnnMap = CommonUtil.convertObjectToMap(tsysAdmRolRtnn);

				tsysAdmRolRtnnMap.put("rol_stat_cd", "30");
				tsysAdmRolRtnnMap.put("rol_stat_nm", "수정");
				tsysAdmRolRtnnMap.put("crtr_id",parameterMap.getUserInfo().getUser_id());
				tsysAdmRolRtnnMap.put("updr_id",parameterMap.getUserInfo().getUser_id());

//				tbLgapRolrtnnHDaoTrx.insertTbLgapRolrtnnH(tsysAdmRolRtnnMap);

			}

			for (TsysAdmRolRtnn tsysAdmRolRtnn : delete) {
				tsysAdmRolRtnnDao.delete(tsysAdmRolRtnn);

				Map<String,Object> tsysAdmRolRtnnMap = CommonUtil.convertObjectToMap(tsysAdmRolRtnn);

				tsysAdmRolRtnnMap.put("rol_stat_cd", "20");
				tsysAdmRolRtnnMap.put("rol_stat_nm", "삭제");
				tsysAdmRolRtnnMap.put("crtr_id",parameterMap.getUserInfo().getUser_id());
				tsysAdmRolRtnnMap.put("updr_id",parameterMap.getUserInfo().getUser_id());

//				tbLgapRolrtnnHDaoTrx.insertTbLgapRolrtnnH(tsysAdmRolRtnnMap);
			}
		}
	}

	/**
	 * 시스템관리 > 샘플 > 그리드 공통 팝업 호출에서 사용자 정보
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmRolRtnnInfo(ParameterMap parameterMap) throws Exception {
		return tsysAdmRolRtnnDao.selectTsysAdmRolRtnnInfo(parameterMap);
	}

}
