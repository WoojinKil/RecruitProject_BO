package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pcommon.dto.TbBcpcAthrApp;
import kr.co.ta9.pandora3.psys.dao.TbBcpcAthrAppDao;
import kr.co.ta9.pandora3.psys.dao.TbLgapAthrappHDao;
import kr.co.ta9.pandora3.psys.dao.TsysUsrRolRtnnDao;

/**
* <pre>
* 1. 클래스명 : Psys1006Mgr
* 2. 설명 : 권한관리 서비스
* 3. 작성일 : 2018-03-28
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Psys1039Mgr {
	
	@Autowired
	private TsysUsrRolRtnnDao tsysUsrRolRtnnDao;

	@Autowired
	private TbBcpcAthrAppDao tbBcpcAthrAppDao;
	
	@Autowired
	private TbLgapAthrappHDao tbLgapAthrappHDao;
	/**
	 * 권한신청관리 > 개별 권한 신청 목록 
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTsysUsrRolRtnnAppGridList(ParameterMap parameterMap) throws Exception {
		return tsysUsrRolRtnnDao.selectTsysUsrRolRtnnAppGridList(parameterMap);
	}
	
	/**
	 * 권한신청 관리 > 개인 권한 신청
	 * @param parameterMap
	 * @throws Exception
	 */
	public void insertTbbcpcAthrApp(ParameterMap parameterMap) throws Exception {
		/*
		
		List<TbBcpcAthrApp> insertList = new ArrayList<TbBcpcAthrApp>();
		List<TbBcpcAthrApp> updateList = new ArrayList<TbBcpcAthrApp>();
		List<TbBcpcAthrApp> deleteList = new ArrayList<TbBcpcAthrApp>();
		
		parameterMap.populates(TbBcpcAthrApp.class, insertList, updateList, deleteList);
		
		String rgn_ldr_yn = parameterMap.getUserInfo().getRgn_ldr_yn(); //지역장 여부
		String blstr_cd = parameterMap.getUserInfo().getBlstr_cd(); // 소속점 코드
		String mstr_cd = parameterMap.getUserInfo().getMstr_cd(); //모점 코드
		String cstr_cd = parameterMap.getUserInfo().getCstr_cd(); //자점 코드
		String shop_grde_cd = parameterMap.getUserInfo().getShop_grde_cd();// 매입 등급 코드
		String grp_rol_id =  parameterMap.getUserInfo().getGrp_rol_id();// 권한 등급 코드
				
		// 방문자 수 는 본사면 본점,  본점 -> 본점 , 직
		
		//cstr_cd 가 비워있거나 본사.
		if(TextUtil.isEmpty(cstr_cd)) {
			cstr_cd = "";
		} else if("Y".equals(rgn_ldr_yn)) { //지역 여부가 Y일 경우 소속점을 본다.
			cstr_cd =  "";
		} else { //본사, 본점, 지역장 제외 모점코드
			
			if(TextUtil.isNotEmpty(shop_grde_cd) && (shop_grde_cd.indexOf('L') > -1 || "9".equals(grp_rol_id))) {
				cstr_cd =  blstr_cd;
			} else {
				cstr_cd =  mstr_cd;
			}
			
		}
		
		TbBcpcAthrApp[] insert = updateList.toArray(new TbBcpcAthrApp[0]);
		for(TbBcpcAthrApp tbBcpcAthrApp : insert) {
			
			if(!"".equals(tbBcpcAthrApp.getRol_ids())) {
				
				tbBcpcAthrApp.setRol_id(tbBcpcAthrApp.getRol_ids());
				tbBcpcAthrApp.setRol_nm(tbBcpcAthrApp.getApp_rol_nm());
				tbBcpcAthrApp.setApvl_yn("N");
				tbBcpcAthrApp.setAppl_stat_cd("20");
				tbBcpcAthrApp.setHr_org_cd(parameterMap.getUserInfo().getHr_org_cd());
				tbBcpcAthrApp.setMstr_cd(cstr_cd);
				tbBcpcAthrApp.setCstr_cd(cstr_cd);
				tbBcpcAthrApp.setHr_emp_pos_cd(parameterMap.getUserInfo().getHr_emp_pos_cd());
				// 신청 테이블 insert
				tbBcpcAthrAppDao.insertTbBcpcAthrApp(tbBcpcAthrApp);
				
				tbBcpcAthrApp.setAppl_stat_cd("20");
				tbBcpcAthrApp.setAppl_stat_nm("미승인");
				tbBcpcAthrApp.setHr_org_nm(parameterMap.getUserInfo().getHr_org_nm());
				tbBcpcAthrApp.setMstr_nm(parameterMap.getUserInfo().getMstr_nm());
				tbBcpcAthrApp.setCstr_nm(parameterMap.getUserInfo().getCstr_nm());
				tbBcpcAthrApp.setHr_emp_pos_nm(parameterMap.getUserInfo().getHr_emp_pos_nm());
				
				tbLgapAthrappHDao.insertTbLgapAthrappH(tbBcpcAthrApp);
					
			}
		}*/
	}

}

