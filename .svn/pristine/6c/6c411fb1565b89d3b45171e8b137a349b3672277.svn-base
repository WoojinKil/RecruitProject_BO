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
public class Psys1048Mgr {
	
	@Autowired
	private TbBcpcAthrAppDao tbBcpcAthrAppDao;
	
	@Autowired
	private TbLgapAthrappHDao tbLgapAthrappHDao;
	
	@Autowired
	private TsysAdmRolRtnnDao tsysAdmRolRtnnDao;
	
	@Autowired
	private TbLgapRolrtnnHDao tbLgapRolrtnnHDao;
	
	/**
	 * 권한관리 > VIP 권한승인
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTbBcpcAtharAppVIP(ParameterMap parameterMap) throws Exception {
		
		//미승인 회원만 조회 
		parameterMap.put("appl_stat_cd", "20");
		return tbBcpcAthrAppDao.selectTbBcpcAtharAppVIP(parameterMap);
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
				
				//사용자 권한 매핑
				tsysAdmRolRtnnDao.insertTsysAdmRolRtnnMap(tsysAdmRolRtnnMap);
				tsysAdmRolRtnnMap.put("rol_stat_cd", "10");
				tsysAdmRolRtnnMap.put("rol_stat_nm", "추가");
				
				//사용자 권한 매핑 이력 
				tbLgapRolrtnnHDao.insertTbLgapRolrtnnH(tsysAdmRolRtnnMap);
				
			}
		
		
		}
		
		
	}
	
}

