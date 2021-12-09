package kr.co.ta9.pandora3.psys.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.psys.manager.Psys1010Mgr;

/**
 * <pre>
 * 1. 클래스명 : Psys1010Controller
 * 2. 설명 : BO아이디 찾기 Controller
 * 3. 작성일 : 2018-03-28
 * 4. 작성자 : TANINE
 * </pre>
 */

@Controller
public class Psys1010Controller extends CommonActionController{

	@Autowired
	private Psys1010Mgr psys1010Mgr;

	/**
	 * BO아이디 찾기 페이지
	 * 작성일 : 2018-03-28
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/psys/psys1010Vw")
	public ModelAndView psys1010Vw(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// ModelAndView 선언
		ModelAndView mav = new ModelAndView();

		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);

		// result 선언
		//String result = Const.BOOLEAN_SUCCESS;

		try {
			mav.addObject("CERTKEY", parameterMap.getValue("certKey"));
			mav.setViewName("pandora3/psys/psys1010");
		}
		catch (Exception e) {
			// Exception 일 경우
			//result = Const.BOOLEAN_FAIL;
		}
		// 결과값 반환
		return mav;
	}

	/**
	 * BO회원 아이디 찾기
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getPsys1010LgnId")
	public void getPsys1010LgnId(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// json 선언
		JSONObject json = new JSONObject();

		String lgnId ="";

		try {
			// 정보 조회
			lgnId = psys1010Mgr.getTmbrAdmLgnInfLgnId(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		json.put("lgnId", lgnId);
		ResponseUtil.write(response, json.toJSONString());
	}
}
