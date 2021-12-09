package kr.co.ta9.pandora3.psys.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.pcommon.dto.TsysOrg;
import kr.co.ta9.pandora3.psys.manager.Psys1002Mgr;
import kr.co.ta9.pandora3.psys.manager.Psys1006Mgr;
import kr.co.ta9.pandora3.psys.manager.Psys1030Mgr;
import kr.co.ta9.pandora3.psys.manager.Psys1031Mgr;

/**
* <pre>
* 1. 클래스명 : Psys1030Controller
* 2. 설명 : 조직별권한관리 컨트롤러
* 3. 작성일 : 2019-03-12
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class Psys1031Controller extends CommonActionController{

	@Autowired
	private Psys1031Mgr psys1031Mgr;

	@Autowired
	private Psys1002Mgr psys1002Mgr;
	
	@Autowired 
	private Psys1006Mgr psys1006Mgr;
	
	
	/**
	 * 조직별권한관리 > 조직(트리) 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1031List01", method = RequestMethod.POST)
	public void getPsys1030List01(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		
		// json 선언
		JSONObject json = new JSONObject();
		
		try {
			List<TsysOrg> dataList = psys1031Mgr.selectTsysOrgTreeList(parameterMap);
			json.put("mapList", psys1002Mgr.convertObjectToMapList(dataList));
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 조직별권한관리 > 하위 조직(그리드) 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1031List02", method = RequestMethod.POST)
	public void getPsys1031List02(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		
		// json 선언
		JSONObject json = new JSONObject();
		
		try {
			json = psys1031Mgr.selectTsysOrgList(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 조직별권한관리 > 권한 그룹 조회 팝업
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1031p001List", method = RequestMethod.POST)
	public void getPsys1031p001List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 권한 그리드 목록 조회
			json = psys1031Mgr.selectTsysAdmGrpRolGridList(parameterMap);
		}
		catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);		
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 조직별권한관리 > 조직별 권한 저장
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/savePsys1031", method = RequestMethod.POST)
	public void savePsys1031(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		
		
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		
		// json 선언
		JSONObject json = new JSONObject();
		
		try {
			psys1031Mgr.saveTsysAdmOrgGrpRolRtnn(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 조직별권한관리 > 조직별 시스템 회원 리스트 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1031OrgAdmList", method = RequestMethod.POST)
	public void getPsys1031OrgAdmList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		
		
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		
		// json 선언
		JSONObject json = new JSONObject();
		
		try {
			json = psys1031Mgr.selectTsysOrgAdmList(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 조직별권한관리 > 조직별 시스템 회원 목록 저장
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/savePsys1031AdmList", method = RequestMethod.POST)
	public void savePsys1031AdmList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		
		// json 선언
		JSONObject json = new JSONObject();
		
		try {
			psys1031Mgr.saveTsysAdmList(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 조직 권한 그룹 삭제
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/deleteTsysAdmOrgGrpRolRtnn", method = RequestMethod.POST)
	public void deleteTsysAdmOrgGrpRolRtnn(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		
		// json 선언
		JSONObject json = new JSONObject();
		
		try {
			psys1031Mgr.deleteTsysAdmOrgGrpRolRtnn(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());	
	}
	
	
}
