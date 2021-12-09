package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.util.CommonUtil;
import kr.co.ta9.pandora3.pcommon.dto.TbBcpcAthrApp;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmRolRtnn;
import kr.co.ta9.pandora3.psys.dao.TbBcpcAthrAppDao;
import kr.co.ta9.pandora3.psys.dao.TbLgapAthrappHDao;
import kr.co.ta9.pandora3.psys.dao.TbLgapRolrtnnHDao;
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
public class Psys1034Mgr {
	
	@Autowired
	private TbBcpcAthrAppDao tbBcpcAthrAppDao;
	
	@Autowired
	private TbLgapAthrappHDao tbLgapAthrappHDao;
	
	@Autowired
	private TbLgapRolrtnnHDao tbLgapRolrtnnHDao;
	
	@Autowired
	private TsysAdmRolRtnnDao tsysAdmRolRtnnDao;
	
	/**
	 * 권한관리 > 권한 승인 관리
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTbBcpcAthrApp(ParameterMap parameterMap) throws Exception {
		
		//미승인 회원만 조회
		parameterMap.put("appl_stat_cd", "20");
		
		return tbBcpcAthrAppDao.selectTbBcpcAtharApp(parameterMap);
	}

	/**
	 * 권한관리 > 신청 권한 승인 관리
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTbBcpcAthrApp(ParameterMap parameterMap) throws Exception {
		
		List<TbBcpcAthrApp> insertList = new ArrayList<TbBcpcAthrApp>();
		List<TbBcpcAthrApp> updateList = new ArrayList<TbBcpcAthrApp>();
		List<TbBcpcAthrApp> deleteList = new ArrayList<TbBcpcAthrApp>();
		
		parameterMap.populates(TbBcpcAthrApp.class, insertList, updateList, deleteList);
		
		//신청 권한에 대한 update 처리 (승인/반려) 처리.
		TbBcpcAthrApp[] update = updateList.toArray(new TbBcpcAthrApp[0]);
		for(TbBcpcAthrApp tbBcpcAthrApp : update) {
			
			tbBcpcAthrApp.setApvl_yn("Y");
			tbBcpcAthrApp.setApvl_usr_id(parameterMap.getUserInfo().getUser_id());
			
			// 신청 테이블 update
			tbBcpcAthrAppDao.updateTbBcpcAthrApp(tbBcpcAthrApp);
			//이력 insert			
			tbLgapAthrappHDao.insertTbLgapAthrappH(tbBcpcAthrApp);
			
			//승인 시 실제 사용자 권한 매핑 처리 및 로그 insert
			if("10".equals(tbBcpcAthrApp.getAppl_stat_cd())) {
				
				Map<String, Object> tsysAdmRolRtnnMap  = CommonUtil.convertObjectToMap(tbBcpcAthrApp);
				
				List<TsysAdmRolRtnn> tsysAdmRolRtnnList = tsysAdmRolRtnnDao.selectSitTsysAdmRolRtnnList(tsysAdmRolRtnnMap);
				if(tsysAdmRolRtnnList != null) {
					for(TsysAdmRolRtnn tsysAdmRolRtnn : tsysAdmRolRtnnList) {
						tsysAdmRolRtnn.setCrtr_id(parameterMap.getUserInfo().getUser_id());
						tsysAdmRolRtnn.setUpdr_id(parameterMap.getUserInfo().getUser_id());
						Map<String, Object> map  = CommonUtil.convertObjectToMap(tsysAdmRolRtnn);
						tsysAdmRolRtnnDao.delete(tsysAdmRolRtnn); //이전 권한 삭제
						
						map.put("rol_stat_cd", "20");
						map.put("rol_stat_nm", "삭제");
						tbLgapRolrtnnHDao.insertTbLgapRolrtnnH(map);
					}
				}
				
				
				//사용자 권한 매핑
				tsysAdmRolRtnnDao.insertTsysAdmRolRtnnMap(tsysAdmRolRtnnMap);
				
				//사용자 권한 매핑 이력 
				tsysAdmRolRtnnMap.put("rol_stat_cd", "10");
				tsysAdmRolRtnnMap.put("rol_stat_nm", "추가");
				tbLgapRolrtnnHDao.insertTbLgapRolrtnnH(tsysAdmRolRtnnMap);
				
			}
		
		
		}
		
		
	}
	
}

