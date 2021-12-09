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
import kr.co.ta9.pandora3.psys.manager.Psys1061Mgr;

/**
 * <pre>
 * 1. 클래스명 : Psys1008Controller
 * 2. 설명 : 사용자별 권한 조회
 * 3. 작성일 : 2018-03-28
 * 4. 작성자 : TANINE
 * </pre>
 */
@Controller
public class Psys1061Controller extends CommonActionController{

	@Autowired
	private Psys1061Mgr psys1061Mgr;

	/**
	 * 사원관리 > 사용자별 권한 조회 > 사원조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/selectTmbrAdmLgnInfRolList", method = RequestMethod.POST)
	public void selectTmbrAdmLgnInfRolList(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// json 선언
		JSONObject json = new JSONObject();

		try {
			// 사용자목록 조회
			json = psys1061Mgr.selectTmbrAdmLgnInfRolList(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	@RequestMapping(value = "/psys/selectTmbrAdmLgnInfRolRtnnList" , method=RequestMethod.POST)
	public void selectTmbrAdmLgnInfRolRtnnList(HttpServletRequest request, HttpServletResponse response ) throws Exception {
		
		ParameterMap parameterMap = getParameterGridMap(request, response);
		
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
	
		// json 선언
		JSONObject json = new JSONObject();
	
		try {
			// 사용자목록 조회
			json = psys1061Mgr.selectTmbrAdmLgnInfRolRtnnList(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
	
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

}
