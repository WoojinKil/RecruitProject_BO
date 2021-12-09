package kr.co.ta9.pandora3.psys.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.MD5Util;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.psys.manager.Psys1012Mgr;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * <pre>
 * 1. 클래스명 : Psys1012Controller
 * 2. 설명: BO비밀번호 변경 Controller
 * 3. 작성일 : 2018-04-11
 * 4.작성자   : TANINE
 * </pre>
 */
@Controller
public class Psys1012Controller extends CommonActionController{

	@Autowired
	private Psys1012Mgr psys1012Mgr;

	/**
	 * 로그인 상태(세션) 확인
	 * 작성일 : 2017-12-05
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public ModelAndView chkLgn(HttpServletRequest request, HttpServletResponse response) throws Exception{

		ModelAndView mav = new ModelAndView();

		ParameterMap parameterMap = getParameterMap(request, response);

		UserInfo userInfo = parameterMap.getUserInfo();

		if (userInfo == null || !userInfo.isLogin()) {
			mav.setViewName("redirect:/");
		}

		return mav;
	}

	/**
	 * 비밀번호 변경
	 * 작성일 : 2017-12-05
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/psys/psys1012Vw")
	public ModelAndView psys1012Vw(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// ModelAndView 선언
		ModelAndView mav = chkLgn(request, response);

        if (mav.getViewName() != null) {
        	return mav;
        }

		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);

		// result 선언
		//String result = Const.BOOLEAN_SUCCESS;

		try {
			mav.addObject("CERTKEY", parameterMap.getValue("certKey"));
			mav.setViewName("/pandora3/psys/psys1012");
		}
		catch (Exception e) {
			//result = Const.BOOLEAN_FAIL;
		}

		return mav;
	}

	/**
	 * 비밀번호 변경 처리
	 * 작성일 : 2017-12-05
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/psys/updatePsys1012", method = RequestMethod.POST)
	public void updatePsys1012(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);

		// json 선언
		JSONObject json = new JSONObject();

		// result 선언
		String result = "";

		try {
			// 비밀번호 변경
			result = psys1012Mgr.updateTmbrAdmLgnInfPwChg(parameterMap);

			/*
			HttpSession session = request.getSession();

			if(!checkLoginAjax(request, response) || parameterMap.getValue("certKey") == null || !parameterMap.getValue("certKey").equals((String)session.getAttribute("certPassword"))){
				result = Const.BOOLEAN_FAIL;
			}
			*/
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

}
