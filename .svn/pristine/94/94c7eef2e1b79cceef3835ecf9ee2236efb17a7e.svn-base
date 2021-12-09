package kr.co.ta9.pandora3.psys.controller;


import javax.mail.MessagingException;
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
import kr.co.ta9.pandora3.common.exception.UtilException;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.psys.manager.Psys1011Mgr;


/**
 * <pre>
 * 1. 클래스명 : Psys1011Controller
 * 2. 설명: BO비밀번호 찾기 Controller
 * 3. 작성일 : 2018-03-28
 * 4. 작성자 : TANINE
 * </pre>
 */

@Controller
public class Psys1011Controller extends CommonActionController{

	@Autowired
	private Psys1011Mgr psys1011Mgr;

	/**
	 * 비밀번호 찾기 팝업 뷰 호출
	 * 작성일 : 2018-03-28
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/psys/psys1011Vw")
	public ModelAndView fndPwdVw(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// ModelAndView 선언
		ModelAndView mav = new ModelAndView();

		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);

		// result 선언
		//String result = Const.BOOLEAN_SUCCESS;

		try {
			mav.addObject("CERTKEY", parameterMap.getValue("certKey"));
			mav.setViewName("pandora3/psys/psys1011");
		}
		catch (Exception e) {
			// Exception 일 경우
			//result = Const.BOOLEAN_FAIL;
		}
		// 결과값 반환
		return mav;
	}

	/**
	 * 임시 비밀번호 전송
	 * 작성일 : 2018-03-28
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/psys/updatePsys1011")
	public void updatePsys1011(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);

		// json 선언
		JSONObject json = new JSONObject();

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		String message = "";
		try {
			result = psys1011Mgr.updateTmbrAdmLgnInfPwChg(parameterMap, request); // 임시 비밀번호 전송 결과

			if("NO_USER".equals(result))
			{
				result = Const.BOOLEAN_FAIL;
				message = "입력하신 정보와 일치하는 회원이 없습니다.";
			}

		} catch (MessagingException e) {
			result = Const.BOOLEAN_FAIL;
			message = "임시비밀번호 안내 메일 전송에 실패했습니다. 관리자에게 문의 하세요.";
		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
			message = "임시비밀번호 발급 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.";
		}

		// json에 결과 담기
		json.put("RESULT", result);
		json.put("MSG", message);
		ResponseUtil.write(response, json.toJSONString());
	}
}
