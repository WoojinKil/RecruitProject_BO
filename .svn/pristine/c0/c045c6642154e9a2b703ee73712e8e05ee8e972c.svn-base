package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.util.CommonUtil;
import kr.co.ta9.pandora3.common.exception.UtilException;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmMnuRolRtnn;
import kr.co.ta9.pandora3.pcommon.dto.TsysOrgBtnRolRtnn;
import kr.co.ta9.pandora3.psys.dao.TbLgapMnurolrtnnHDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmMnuDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmMnuRolRtnnDao;
import kr.co.ta9.pandora3.psys.dao.TsysOrgBtnRolRtnnDao;

/**
* <pre>
* 1. 클래스명 : Psys1003Mgr
* 2. 설명 : 메뉴권한관리 서비스
* 3. 작성일 : 2018-03-27
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Psys1003Mgr {

	@Autowired
	private TsysAdmMnuRolRtnnDao tsysAdmMnuRolRtnnDao;
	@Autowired
	private TsysAdmMnuDao tsysAdmMnuDao;
	@Autowired
	private TbLgapMnurolrtnnHDao tbLgapMnurolrtnnHDao;
	@Autowired
	private TsysOrgBtnRolRtnnDao tsysOrgBtnRolRtnnDao;
	
	/**
	 * 권한메뉴목록
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmMnuRolRtnnGridList(ParameterMap parameterMap) throws Exception {
		return tsysAdmMnuRolRtnnDao.selectTsysAdmMnuRolRtnnGridList(parameterMap);
	}

	/**
	 * 메뉴권한 저장
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTsysAdmMnuRolRtnnList(ParameterMap parameterMap) throws Exception {

		List<TsysAdmMnuRolRtnn> insertList = new ArrayList<TsysAdmMnuRolRtnn>();
		List<TsysAdmMnuRolRtnn> updateList = new ArrayList<TsysAdmMnuRolRtnn>();
		List<TsysAdmMnuRolRtnn> deleteList = new ArrayList<TsysAdmMnuRolRtnn>();
		parameterMap.populates(TsysAdmMnuRolRtnn.class, insertList, updateList, deleteList);

		TsysAdmMnuRolRtnn[] insert = insertList.toArray(new TsysAdmMnuRolRtnn[0]);

		
		if (insert != null) {
			for (TsysAdmMnuRolRtnn tsysAdmMnuRolRtnn : insert) {
				// 메뉴 권한 중복체크 조회
				int result = tsysAdmMnuRolRtnnDao.selectTsysAdmMnuRolRtnnCnt(tsysAdmMnuRolRtnn);
				
				if(result > 0) {
					throw new UtilException("중복된 데이터입니다.");
				} else {
					Map<String, Object> tsysAdmMnuRolRtnnMap = CommonUtil.convertObjectToMap(tsysAdmMnuRolRtnn);
					tsysAdmMnuRolRtnnDao.insert(tsysAdmMnuRolRtnn);
					tsysAdmMnuRolRtnnMap.put("hist_stat_cd", "10");
					tsysAdmMnuRolRtnnMap.put("hist_stat_nm", "추가");
					
					//권한 매핑이력 추가
					//tbLgapMnurolrtnnHDaoTrx.insertTbLgapMnurolrtnnH(tsysAdmMnuRolRtnnMap);
				}
				
			}
		}
		TsysAdmMnuRolRtnn[] update = updateList.toArray(new TsysAdmMnuRolRtnn[0]);
		
		//update
		for (TsysAdmMnuRolRtnn tsysAdmMnuRolRtnn: update) {
			Map<String, Object> tsysAdmMnuRolRtnnMap = CommonUtil.convertObjectToMap(tsysAdmMnuRolRtnn);
			tsysAdmMnuRolRtnnDao.update(tsysAdmMnuRolRtnn);
			
			tsysAdmMnuRolRtnnMap.put("hist_stat_cd", "20");
			tsysAdmMnuRolRtnnMap.put("hist_stat_nm", "수정");
			
			//권한 매핑이력 추가
//			tbLgapMnurolrtnnHDaoTrx.insertTbLgapMnurolrtnnH(tsysAdmMnuRolRtnnMap);
			
		}
		TsysAdmMnuRolRtnn[] delete = deleteList.toArray(new TsysAdmMnuRolRtnn[0]);
		//delete
		for (TsysAdmMnuRolRtnn tsysAdmMnuRolRtnn: delete) {
			Map<String, Object> tsysAdmMnuRolRtnnMap = CommonUtil.convertObjectToMap(tsysAdmMnuRolRtnn);
			tsysAdmMnuRolRtnnDao.delete(tsysAdmMnuRolRtnn);
			
			//삭제 메뉴 정보 갖고 오기.
			TsysOrgBtnRolRtnn tsysOrgBtnRolRtnn = new TsysOrgBtnRolRtnn();
			tsysOrgBtnRolRtnn.setRol_id(tsysAdmMnuRolRtnn.getRol_id());
			tsysOrgBtnRolRtnn.setMnu_seq(tsysAdmMnuRolRtnn.getMnu_seq());
			List<TsysOrgBtnRolRtnn> tsysOrgBtnRolRtnnList = tsysOrgBtnRolRtnnDao.selectTsysOrgBtnRolRtnn(tsysOrgBtnRolRtnn);
			List<String> pgm_btn_cds = new ArrayList<String>();
			List<String> pgm_btn_nms = new ArrayList<String>();
			
			for(TsysOrgBtnRolRtnn tsysOrgBtnRtnn : tsysOrgBtnRolRtnnList) {
				
				pgm_btn_cds.add(tsysOrgBtnRtnn.getPgm_btn_cd());
				pgm_btn_nms.add(tsysOrgBtnRtnn.getPgm_btn_nm());
				
			}
			
			tsysOrgBtnRolRtnnDao.deleteTsysOrgBtnRolRtnn(tsysOrgBtnRolRtnn);
			
			tsysAdmMnuRolRtnnMap.put("hist_stat_cd", "30");
			tsysAdmMnuRolRtnnMap.put("hist_stat_nm", "삭제");
			tsysAdmMnuRolRtnnMap.put("pgm_btn_cd", String.join(",", pgm_btn_cds));
			tsysAdmMnuRolRtnnMap.put("pgm_btn_nm", String.join(",", pgm_btn_nms));
			//권한 매핑이력 추가
//			tbLgapMnurolrtnnHDaoTrx.insertTbLgapMnurolrtnnH(tsysAdmMnuRolRtnnMap);
			
		}
		
	}

	/**
	 * 메뉴 리스트 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmMnuGridList(ParameterMap parameterMap) throws Exception {
		return tsysAdmMnuDao.selectTsysAdmMnuGridList(parameterMap);
	}
}
