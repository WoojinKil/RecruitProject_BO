package kr.co.ta9.pandora3.psys.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.CryptUtil;
import kr.co.ta9.pandora3.common.util.MD5Util;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.pcommon.dto.TmbrClu;
import kr.co.ta9.pandora3.pmbr.dao.TmbrCluDao;
import kr.co.ta9.pandora3.psys.manager.Psys1017Mgr;

/**
 * <pre>
 * 1. 클래스명 : Psys1017Controller
 * 2. 설명: BO회원가입 Controller
 * 3. 작성일 : 2018-04-16
 * 4.작성자   : TANINE
 * </pre>
 */
@Controller
public class Psys1017Controller extends CommonActionController{

	@Autowired
	private Psys1017Mgr psys1017Mgr;

	/**
	 * 메인 > 회원가입 - Process
	 * 작성일 : 2017-12-05
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/psys/psys1017Vw")
	public ModelAndView psys1017Vw(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// ModelAndView 선언
        ModelAndView mav = new ModelAndView();

        // parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);

		// 사용자 정보
		UserInfo userInfo = parameterMap.getUserInfo();


		if(userInfo != null && userInfo.isLogin()){
			mav.setViewName("redirect:/");
			return mav;
		}

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		try {
			// 이용약관 및 개인정보 취급방침 취득
			parameterMap.put("clu_tp_cd", "10");

			// 약관 코드 조회
			List<TmbrClu> tmbrClu = psys1017Mgr.getTmbrCluCode(parameterMap);

			if(!tmbrClu.isEmpty()){
				mav.addObject("tmbrCluArr", tmbrClu);
			}

		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// 결과값 반환
		mav.setViewName("/pandora3/psys/psys1017");
		mav.addObject("RESULT", result);

		return mav;
	}

	/**
	 * 회원가입완료 > 등록 (신규 아이디 취득)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/savePsys1017", method = RequestMethod.POST)
	public void savePsys1017(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// json 선언
		JSONObject json = new JSONObject();

		String new_usr_id = "";

		try {
			// 파라미터 설정시 기본값을 파라미터 값으로 교체
			if(parameterMap.containsKey("p_usr_id"))
				parameterMap.put("usr_id", parameterMap.getValue("p_usr_id"));

			// 패스워드 파라미터 설정 시 패스워드 정보 암호화
			if(!StringUtils.isEmpty(parameterMap.getValue("lgn_pwd")))
				parameterMap.put("lgn_pwd", CryptUtil.sha512(parameterMap.getValue("lgn_pwd")));

			// 회원 등록
			new_usr_id = psys1017Mgr.insertTmbrAdmLgnInf(parameterMap);
		}
		catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		json.put("NEW_USR_ID", new_usr_id);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 회원 가입 권한 목록
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/psys/selectVipRolList", method = RequestMethod.POST)
	public void selectVipRolList(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ParameterMap parameterMap = getParameterMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// json 선언
		JSONObject json = new JSONObject();

		try {
			json = psys1017Mgr.selectVipRolList(parameterMap);
		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());


	}
}
