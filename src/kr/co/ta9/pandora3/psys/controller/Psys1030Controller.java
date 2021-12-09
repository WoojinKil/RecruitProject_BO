package kr.co.ta9.pandora3.psys.controller;

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
import kr.co.ta9.pandora3.psys.manager.Psys1030Mgr;

/**
* <pre>
* 1. 클래스명 : Psys1030Controller
* 2. 설명 : 권한관리 컨트롤러
* 3. 작성일 : 2019-03-12
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class Psys1030Controller extends CommonActionController{

	@Autowired
	private Psys1030Mgr psys1030Mgr;

	/**
	 * 메뉴권한관리 > 권한 목록 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1030List", method = RequestMethod.POST)
	public void getPsys1030List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		
		// json 선언
		JSONObject json = new JSONObject();
		
		try {
			// 메뉴권한 그리드 목록 조회
			json = psys1030Mgr.selectTsysAdmRolGridList(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 메뉴권한관리 > 권한의 메뉴조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1030MnuList", method = RequestMethod.POST)
	public void getPsys1030MnuList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		
		// json 선언
		JSONObject json = new JSONObject();
		
		try {
			// 메뉴권한 그리드 목록 조회
			json = psys1030Mgr.selectTsysAdmMnuRolRtnnGridList(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 메뉴권한관리 > 권한 추가 대상 메뉴&버튼 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1030p001List", method = RequestMethod.POST)
	public void getPsys1030p001List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		
		// json 선언
		JSONObject json = new JSONObject();
		
		try {
			// 메뉴권한 그리드 목록 조회
			json = psys1030Mgr.selectTsysAdmMnuBtnList(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 메뉴권한관리 > 권한 메뉴&버튼 저장
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/savePsys1030", method = RequestMethod.POST)
	public void savePsys1008(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		
		// json 선언
		JSONObject json = new JSONObject();
		
		try {
			// 사용자 권한 저장
			psys1030Mgr.saveTsysAdmMnuBtnList(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
			logger.error(e);
		}
		
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 메뉴권한관리 > 권한 메뉴의 버튼조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1030BtnList", method = RequestMethod.POST)
	public void getPsys1030BtnList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		
		// json 선언
		JSONObject json = new JSONObject();
		
		try {
			// 메뉴권한 그리드 목록 조회
			json = psys1030Mgr.selectTsysAdmMnuRolRtnnBtnGridList(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 메뉴권한관리 > 권한 메뉴의 버튼조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/savePsys1030BtnList", method = RequestMethod.POST)
	public void savePsys1030BtnList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		
		// json 선언
		JSONObject json = new JSONObject();
		
		try {
			psys1030Mgr.savePsys1030BtnList(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
}
