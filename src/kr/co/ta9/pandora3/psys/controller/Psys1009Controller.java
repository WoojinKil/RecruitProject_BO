package kr.co.ta9.pandora3.psys.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.ta9.pandora3.app.conf.AppConst;
import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.MD5Util;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.psys.manager.Psys1009Mgr;

/**
 * <pre>
 * 1. 클래스명 : Psys1009Controller
 * 2. 설명: 시스템사용자추가 컨트롤러
 * 3. 작성일 : 2018-03-27
 * 4.작성자   : TANINE
 * </pre>
 */


@Controller
public class Psys1009Controller extends CommonActionController{

	@Autowired
	private Psys1009Mgr psys1009Mgr;

	/**
	 * 회원 추가 > 아이디 및 이메일 유효성 체크
	 * 작성일 : 2018-03-27
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/psys/getPsys1009UsrInfVldYn", method = RequestMethod.POST)
	public void getPsys1009UsrInfVldYn(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// json 선언
		JSONObject json = new JSONObject();

		// parameter 취득
		String lgnId = String.valueOf(request.getParameter("lgn_id"));
		String lgnIdVldYn = "";
		String usrEmlAdr = String.valueOf(request.getParameter("usr_eml_addr"));
		String emlAdrVldYn = "";

		try {
			// 회원아이디 유효성 확인(중복/금지어)
			lgnIdVldYn = psys1009Mgr.getTmbrAdmLgnInfDupLgnId(lgnId);

			if("Y".equals(lgnIdVldYn)) {
				// 이메일 확인
				emlAdrVldYn = psys1009Mgr.getTmbrAdmLgnInfDupUsrEmlAdr(usrEmlAdr);
			}
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		json.put("lgnIdVldYn", lgnIdVldYn);
		json.put("emlAdrVldYn", emlAdrVldYn);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * BO사용자 추가 : 1건씩
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/savePsys1009", method = RequestMethod.POST)
	public void savePsys1009(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// json 선언
		JSONObject json = new JSONObject();

		String new_usr_id = "";
		try {
			// BO에서의 접근인지 확인
			HttpSession session = request.getSession();
			UserInfo userInfo = parameterMap.getUserInfo();
			if(userInfo !=null ) {
				
				// 파라미터 설정시 기본값을 파라미터 값으로 교체 (회원정보수정)
				if(userInfo.isLogin() && AppConst.ADMIN_GB.equals(session.getAttribute("checkAdmin")) && parameterMap.containsKey("p_usr_id"))
					parameterMap.put("usr_id", parameterMap.getValue("p_usr_id"));

					// 패스워드 파라미터 설정 시 패스워드 정보 암호화
				if(!StringUtils.isEmpty(parameterMap.getValue("lgn_pwd")))
					parameterMap.put("lgn_pwd", new MD5Util().hexDigest(parameterMap.getValue("lgn_pwd")));

					// 회원 등록/수정
					new_usr_id = psys1009Mgr.savePsys1009(parameterMap);
			}


		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		json.put("NEW_USR_ID", new_usr_id);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 시스템회원관리 > 시스템 회원 추가 > 조직 추가
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1009List", method = RequestMethod.POST)
	public void getPsys1009List(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// json 선언
		JSONObject json = new JSONObject();

		try {

			json = psys1009Mgr.getPsysOrgList(parameterMap);

		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());

	}
}
