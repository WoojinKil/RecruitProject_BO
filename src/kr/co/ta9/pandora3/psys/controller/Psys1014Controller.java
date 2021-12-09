package kr.co.ta9.pandora3.psys.controller;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import kr.co.ta9.pandora3.common.util.MD5Util;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.pcommon.dto.TmbrAdmLgnInf;
import kr.co.ta9.pandora3.psys.manager.Psys1014Mgr;
/**
 * <pre>
 * 1. 클래스명 : Psys1014Controller
 * 2. 설명 : BO정보 변경 Controller
 * 3. 작성일 : 2018-04-11
 * 4. 작성자 : TANINE
 * </pre>
 */
@Controller
public class Psys1014Controller extends CommonActionController{

	@Autowired
	private Psys1014Mgr psys1014Mgr;

	/**
	 * 회원정보 저장
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	@RequestMapping("/psys/savePsys1014")
	public void savePsys1014(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// json 선언
		JSONObject json = new JSONObject();

		TmbrAdmLgnInf tmbrAdmLgnInf = new TmbrAdmLgnInf();

		try {
			UserInfo userInfo = parameterMap.getUserInfo();

			if(userInfo != null){
				tmbrAdmLgnInf.setUsr_id(userInfo.getUser_id());
				// tmbrAdmLgnInf.setLgn_id(userInfo.getLogin_id());
				tmbrAdmLgnInf.setDtl_addr(parameterMap.getValue("dtl_addr"));
				tmbrAdmLgnInf.setRod_addr(parameterMap.getValue("rod_addr"));
				
				
				tmbrAdmLgnInf.setUpdr_id(userInfo.getUser_id());

				psys1014Mgr.updateTmbrAdmLgnInf(tmbrAdmLgnInf);
			}



			/*
			if(!checkLoginAjax(request, response) || parameterMap.getValue("certKey") == null
				|| !parameterMap.getValue("certKey").equals((String)session.getAttribute("certPassword"))){
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

	/**
	 * 이메일 변경 인증(회원정보 수정)
	 * 작성일 : 2017-12-05
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/psys/psys1014certEmailVw")
	public ModelAndView psys1014certEmailVw(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// ModelAndView 선언
		ModelAndView mav = new ModelAndView();

		// parameterMap 선언
 		ParameterMap parameterMap = getParameterMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_FAIL;

		try {
			parameterMap.put("email_cert_key", parameterMap.get("email_cert_key"));

			// 회원 조회 : 이메일 인증 대상 회원
			TmbrAdmLgnInf tmbrAdmLgnInf = psys1014Mgr.selectTmbrAdmLgnInfInfo(parameterMap);

			// 로그인 체크 key
			mav.addObject("certKey", parameterMap.getValue("certKey"));

			// 인증키 유효기간 18분
			if(tmbrAdmLgnInf != null){

				TmbrAdmLgnInf updTmbrAdmLgnInf = new TmbrAdmLgnInf();
				updTmbrAdmLgnInf.setUsr_id(tmbrAdmLgnInf.getUsr_id());
				updTmbrAdmLgnInf.setUpdr_id(tmbrAdmLgnInf.getUsr_id());
				updTmbrAdmLgnInf.setUsr_eml_addr(tmbrAdmLgnInf.getTem_eml_addr());

				psys1014Mgr.updateTmbrAdmLgnInf(updTmbrAdmLgnInf);

				result = Const.BOOLEAN_SUCCESS;
			}
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// 결과값 반환
		mav.addObject("RESULT", result);
		mav.setViewName("/pandora3/psys/psys1014certEmail");

		// 결과값 반환
		return mav;
	}

	/**
	 * 이메일 인증메일 전송
	 * 작성일 : 2017-12-05
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked"})
	@RequestMapping(value="/psys/updatePsys1014", method = RequestMethod.POST)
	public void updatePsys1014(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);

		// json 선언
		JSONObject json = new JSONObject();

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		try {
			UserInfo userInfo = parameterMap.getUserInfo();
			if(userInfo != null){
				parameterMap.put("usr_id", userInfo.getUser_id());

				if(!checkLoginAjax(request, response) || parameterMap.getValue("usr_eml_addr") == null){
					result = Const.BOOLEAN_FAIL;
				}

				if(result.equals(Const.BOOLEAN_SUCCESS)){

					String ms = String.valueOf(System.currentTimeMillis());
					String certKey = new MD5Util().hexDigest(ms);

					TmbrAdmLgnInf tmbrAdmLgnInf = new TmbrAdmLgnInf();
					tmbrAdmLgnInf.setUsr_id(userInfo.getUser_id());

					tmbrAdmLgnInf.setEml_ctf_key(certKey);
					tmbrAdmLgnInf.setEml_ctf_dttm(new Timestamp(System.currentTimeMillis()));
					tmbrAdmLgnInf.setTem_eml_addr(parameterMap.getValue("usr_eml_addr"));
					tmbrAdmLgnInf.setUpdr_id(userInfo.getUser_id());
					psys1014Mgr.updateTmbrAdmLgnInf(tmbrAdmLgnInf);

				}
			}
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 비밀번호 변경 전 비밀번호 재확인
	 * 작성일 : 2017-12-05
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/psys/getPsys1014p01ChkLgnPw", method = RequestMethod.POST)
	public void getPsys1014p01ChkLgnPw(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);

		// json 선언
		JSONObject json = new JSONObject();

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		try {

			String chkLgnPw = psys1014Mgr.selectTmbrAdmLgnInfLgnPw(parameterMap);

			if("N".equals(chkLgnPw))
				result = Const.BOOLEAN_FAIL;

			/*
			if (!checkLoginAjax(request, response) || parameterMap.getValue("certKey") == null
				|| !parameterMap.getValue("certKey").equals((String)session.getAttribute("certPassword"))) {
				result = Const.BOOLEAN_FAIL;
			}
			*/

		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 회원정보 조회
	 * 작성일 : 2017-12-05
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/psys/getPsys1014UsrInf", method = RequestMethod.POST)
	public void getPsys1014UsrInf(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);

		// json 선언
		JSONObject json = new JSONObject();

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		try {
			UserInfo userInfo = parameterMap.getUserInfo();
			if(userInfo != null){
				parameterMap.put("usr_id", userInfo.getUser_id());
				json = psys1014Mgr.selectTmbrAdmLgnInf(parameterMap);
			}


			/*
			if (!checkLoginAjax(request, response) || parameterMap.getValue("certKey") == null
				|| !parameterMap.getValue("certKey").equals((String)session.getAttribute("certPassword"))) {
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
