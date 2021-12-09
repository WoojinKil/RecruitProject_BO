package kr.co.ta9.pandora3.psys.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.MD5Util;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.psys.manager.Psys1013Mgr;

import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * <pre>
 * 1. 클래스명 : Psys1013Controller
 * 2. 설명 : BO인증 Controller
 * 3. 작성일 : 2018-04-11
 * 4. 작성자 : TANINE
 * </pre>
 */
@Controller
public class Psys1013Controller extends CommonActionController{
	@Autowired
	private Psys1013Mgr psys1013Mgr;

	/**
	 * 비밀번호 변경
	 * 작성일 : 2017-12-05
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/psys/psys1013Vw")
	public ModelAndView psys1013Vw(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// ModelAndView 선언
        ModelAndView mav = new ModelAndView();
		mav.setViewName("/pandora3/psys/psys1013");

		// 결과값 반환
		return mav;
	}

	/**
	 * 비밀번호 변경
	 * 작성일 : 2017-12-05
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/psys/psys1013emailVw")
	public ModelAndView psys1013emailVw(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// ModelAndView 선언
        ModelAndView mav = new ModelAndView();
		mav.setViewName("/pandora3/psys/psys1013email");

		// 결과값 반환
		return mav;
	}

	/**
	 * 인증 가능 여부 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getPsys1013ChkEml", method = RequestMethod.POST)
	public void getPsys1013ChkEml(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// json 선언
		JSONObject json = new JSONObject();

		String usrId = "";

		try {

			// 패스워드 파라미터 설정 시 패스워드 정보 암호화
			if(TextUtil.isNotEmpty(parameterMap.getValue("lgn_pwd")))
				parameterMap.put("lgn_pwd", new MD5Util().hexDigest(parameterMap.getValue("lgn_pwd")));

			// 정보 조회
			usrId = psys1013Mgr.getTmbrAdmLgnInfUsrId(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		json.put("chkEmlResult", usrId);
		ResponseUtil.write(response, json.toJSONString());
	}
}
