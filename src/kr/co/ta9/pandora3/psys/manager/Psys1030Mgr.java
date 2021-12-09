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
import kr.co.ta9.pandora3.pcmn.dao.TcmnCdDtlDao;
import kr.co.ta9.pandora3.pcommon.dto.TcmnCdDtl;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmMnuRolRtnn;
import kr.co.ta9.pandora3.pcommon.dto.TsysOrgBtnRolRtnn;
import kr.co.ta9.pandora3.psys.dao.TbLgapMnurolrtnnHDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmMnuDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmMnuRolRtnnDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmRolDao;
import kr.co.ta9.pandora3.psys.dao.TsysOrgBtnRolRtnnDao;

/**
* <pre>
* 1. 클래스명 : Psys1030Mgr
* 2. 설명 : 권한관리 서비스
* 3. 작성일 : 2019-03-12
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Psys1030Mgr {

	@Autowired
	private TsysAdmRolDao tsysAdmRolDao;	
	
	@Autowired
	private TsysAdmMnuDao tsysAdmMnuDao;

	@Autowired
	private TsysAdmMnuRolRtnnDao tsysAdmMnuRolRtnnDao;
	
	@Autowired
	private TsysOrgBtnRolRtnnDao tsysOrgBtnRolRtnnDao;
	
	@Autowired
	private TbLgapMnurolrtnnHDao  tbLgapMnurolrtnnHDao;
	
	@Autowired
	private TcmnCdDtlDao tcmnCdDtlDao;
	
	/**
	 * 메뉴권한관리 > 권한 목록 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmRolGridList(ParameterMap parameterMap) throws Exception {
		return tsysAdmRolDao.selectTsysAdmRolGridList(parameterMap);
	}

	/**
	 * 메뉴권한관리 > 권한의 메뉴 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmMnuRolRtnnGridList(ParameterMap parameterMap) throws Exception {
		return tsysAdmMnuDao.selectTsysAdmMnuRolRtnnGridList(parameterMap);
	}
	
	/**
	 * 메뉴권한관리 > 권한 추가 대상 메뉴 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmMnuBtnList(ParameterMap parameterMap) throws Exception {
		return tsysAdmMnuDao.selectTsysAdmMnuBtnList(parameterMap);
	}
	
	/**
	 * 시스템 사용자 권한 저장
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTsysAdmMnuBtnList(ParameterMap parameterMap) throws Exception {

		List<TsysAdmMnuRolRtnn> insertList = new ArrayList<TsysAdmMnuRolRtnn>();
		List<TsysAdmMnuRolRtnn> updateList = new ArrayList<TsysAdmMnuRolRtnn>();
		List<TsysAdmMnuRolRtnn> deleteList = new ArrayList<TsysAdmMnuRolRtnn>();
		parameterMap.populates(TsysAdmMnuRolRtnn.class, insertList, updateList, deleteList);
		
		TsysAdmMnuRolRtnn[] insert = insertList.toArray(new TsysAdmMnuRolRtnn[0]);
		TsysAdmMnuRolRtnn[] update = updateList.toArray(new TsysAdmMnuRolRtnn[0]);
		TsysAdmMnuRolRtnn[] delete = deleteList.toArray(new TsysAdmMnuRolRtnn[0]);
		
		
		
		
		// 1. 메뉴 저장/수정/삭제 
//		int insCnt = tsysAdmMnuRolRtnnDaoTrx.insertMany(insert);
//		int updCnt = tsysAdmMnuRolRtnnDaoTrx.updateMany(update);
//		int delCnt = tsysAdmMnuRolRtnnDaoTrx.deleteMany(delete);
		
		//insert
		for (TsysAdmMnuRolRtnn tsysAdmMnuRolRtnn: insert) { 
			
			Map<String, Object> tsysAdmMnuRolRtnnMap = CommonUtil.convertObjectToMap(tsysAdmMnuRolRtnn);
			tsysAdmMnuRolRtnnDao.insert(tsysAdmMnuRolRtnn);
			
			//권한 매핑이력 추가
//			tbLgapMnurolrtnnHDao.insertTbLgapMnurolrtnnH(tsysAdmMnuRolRtnnMap);
			
			
		}
		//update
		for (TsysAdmMnuRolRtnn tsysAdmMnuRolRtnn: update) {
			Map<String, Object> tsysAdmMnuRolRtnnMap = CommonUtil.convertObjectToMap(tsysAdmMnuRolRtnn);
			tsysAdmMnuRolRtnnDao.update(tsysAdmMnuRolRtnn);
			
			
			//권한 매핑이력 추가
			//tbLgapMnurolrtnnHDao.insertTbLgapMnurolrtnnH(tsysAdmMnuRolRtnnMap);
			
		}
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
			
//			tsysAdmMnuRolRtnnMap.put("hist_stat_cd", "30");
//			tsysAdmMnuRolRtnnMap.put("hist_stat_nm", "삭제");
//			tsysAdmMnuRolRtnnMap.put("pgm_btn_cd", String.join(",", pgm_btn_cds));
//			tsysAdmMnuRolRtnnMap.put("pgm_btn_nm", String.join(",", pgm_btn_nms));
			//권한 매핑이력 추가
//			tbLgapMnurolrtnnHDaoTrx.insertTbLgapMnurolrtnnH(tsysAdmMnuRolRtnnMap);
			
		}
		
		
		// 권한메뉴 삭제 시, 해당 권한 할당된 버튼 삭제
//		if(delCnt > 0)
//		{
//			for(int i=0 ; i<delete.length ; i++){
//				TsysOrgBtnRolRtnn tsysOrgBtnRolRtnn = new TsysOrgBtnRolRtnn();
//				tsysOrgBtnRolRtnn.setRol_id(delete[i].getRol_id());
//				tsysOrgBtnRolRtnn.setMnu_seq(delete[i].getMnu_seq());
//				tsysOrgBtnRolRtnnDaoTrx.deleteTsysOrgBtnRolRtnn(tsysOrgBtnRolRtnn);
//			}
//				
//		}
		
	}

	/**
	 * 메뉴권한관리 > 권한 메뉴의 버튼 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmMnuRolRtnnBtnGridList(ParameterMap parameterMap) throws Exception {
		return tsysAdmMnuDao.selectTsysAdmMnuRolRtnnBtnGridList(parameterMap);
	}

	/**
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public void savePsys1030BtnList(ParameterMap parameterMap) throws Exception {
		TsysOrgBtnRolRtnn tsysOrgBtnRolRtnn = new TsysOrgBtnRolRtnn();
		
		
		
		tsysOrgBtnRolRtnn.setRol_id(parameterMap.getValue("rol_id"));
		tsysOrgBtnRolRtnn.setPgm_id(parameterMap.getValue("pgm_id"));
		tsysOrgBtnRolRtnn.setMnu_seq(parameterMap.getInt("mnu_seq"));
		tsysOrgBtnRolRtnn.setMnu_seq(parameterMap.getInt("mnu_seq"));
		tsysOrgBtnRolRtnn.setCrtr_id(parameterMap.getValue("user_id"));
		tsysOrgBtnRolRtnn.setUpdr_id(parameterMap.getValue("user_id"));
		
		String[] pgm_btn_cd = parameterMap.getValue("pgm_btn_cd").split(",");
		List<String> pgm_btn_nms = new ArrayList<String>(); 
		
		tsysOrgBtnRolRtnnDao.deleteTsysOrgBtnRolRtnn(tsysOrgBtnRolRtnn);
		
		for(int j = 0 ; j< pgm_btn_cd.length ; j++)
		{
			if(TextUtil.isNotEmpty(pgm_btn_cd[j])){
				parameterMap.put("mst_cd", "SYS001");
				parameterMap.put("cd", pgm_btn_cd[j]);
				TcmnCdDtl tcmnCdDtl = tcmnCdDtlDao.selectDTO("TcmnCdDtl.select", parameterMap);
				if (tcmnCdDtl != null) {
					pgm_btn_nms.add(tcmnCdDtl.getCd_nm());
				}
				
				tsysOrgBtnRolRtnn.setPgm_btn_cd(pgm_btn_cd[j]);
				
				tsysOrgBtnRolRtnnDao.insert(tsysOrgBtnRolRtnn);
			}
		}
		
//		parameterMap.put("hist_stat_cd", "20");
//		parameterMap.put("hist_stat_nm", "수정");
//		parameterMap.put("pgm_btn_nm", String.join(",", pgm_btn_nms));
		
		//권한 매핑이력 추가
		tbLgapMnurolrtnnHDao.insertTbLgapMnurolrtnnH(parameterMap);
		
	}
}
