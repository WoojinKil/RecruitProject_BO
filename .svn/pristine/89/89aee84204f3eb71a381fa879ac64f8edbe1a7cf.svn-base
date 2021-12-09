package kr.co.ta9.pandora3.main.controller;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.ta9.pandora3.app.entry.EntryFactory;
import kr.co.ta9.pandora3.app.entry.SessionEntryFactory;
import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.app.util.CommonUtil;
import kr.co.ta9.pandora3.app.util.SeedUtil;
import kr.co.ta9.pandora3.common.conf.Configuration;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.CookieUtil;
import kr.co.ta9.pandora3.common.util.CryptUtil;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.main.manager.MainMgr;
import kr.co.ta9.pandora3.psys.manager.PsysCommonMgr;
/**
* <pre>
* 1. 클래스명 : SysControllerLogin
* 2. 설명 : 로그인 컨트롤러
* 3. 작성일 : 2018-04-26
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class LoginController extends CommonActionController{
	
	@Autowired
	private MainMgr mainMgr;

	@Autowired
	private PsysCommonMgr psysCommonMgr;

	/**
	 * 공통 > BO 로그인처리
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/main/login", method = RequestMethod.POST)
	public void login(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// parameterMap에 ip_addr 담기
		// json 선언
		JSONObject json = new JSONObject();

		// userInfo 선언
		UserInfo userInfo = new UserInfo();
		// result 선언
		String result =  Const.BOOLEAN_SUCCESS;
		
		//slo 파라미터
		String v = request.getParameter("v");
		
		//로그인 결과 타입 정상..
		String loginResultType = "1";
		try {
			//v가 빈값이 아니라면 slo 로그인 시도 // slo ==> 앞선 프로그램이서 로그인 인증 후 id로만 로그인 허용.
			if( v != null && !"".equals(v) ) {
				
				//slo 로그인 체크
				sloLogin(request, response, parameterMap, v, userInfo, loginResultType);

			}
		} catch (Exception e) {
			loginResultType = "2";
			result = Const.BOOLEAN_FAIL;
			log.error(e.toString());
		}

		if ("1".equals(loginResultType)) {
			HttpSession session = request.getSession();
			session.setAttribute("_pre_url", request.getParameter("_pre_url"));
			session.setAttribute("lgnId", request.getParameter("lgnId"));
			session.setAttribute("usrNm", request.getParameter("usrNm"));
			session.setAttribute("usrEmlAdr", request.getParameter("usrEmlAdr"));
			session.setAttribute("usrSsCd", request.getParameter("usrSsCd"));
			String ip_addr =  CommonUtil.getRemoteIpAddr(request);
			
			parameterMap.put("ip_addr", ip_addr);
			// result 선언
			result = Const.BOOLEAN_SUCCESS;


			String user_auth_type="";
			try {
				// 사용자 로그인  user id가 있으면 userId로 로그인 아니면 lgn_id, lgn_pwd로 로그인 시도
				if("".equals(parameterMap.getValue("usr_id"))) {
					userInfo = mainMgr.registAdminLogin(parameterMap);
				} else {
					//slo 로그인 시도 
					userInfo = mainMgr.userIdAdminLogin(parameterMap);
				}

				if (userInfo.isLogin()) {
					Configuration configuration = Configuration.getInstance();
					user_auth_type = configuration.get("user.auth.type");
					if (Const.BOOLEAN_TRUE.equals(parameterMap.getValue("idsave"))) {
						CookieUtil.setCookie(response, EntryFactory.COOKIE_LOGIN_ID, CryptUtil.encode(userInfo.getLogin_id()), 60 * 60 * 24 * 365);
						// ID저장 미선택시
					}
					if("COOKIE".equals(user_auth_type)){
						// 암호화된 ID값을 쿠기에 저장(보관주기 1년)
						if (Const.BOOLEAN_TRUE.equals(parameterMap.getValue("idsave"))) {
							CookieUtil.setCookie(response, EntryFactory.COOKIE_LOGIN_ID, CryptUtil.encode(userInfo.getLogin_id()), 60 * 60 * 24 * 365);
						// ID저장 미선택시
						} else {
							// 쿠기에서 ID값 삭제
							CookieUtil.setCookie(response, EntryFactory.COOKIE_LOGIN_ID, "", 60 * 60 * 24 * 365);
						}
						EntryFactory.setUserInfo(response, userInfo, EntryFactory.COOKIE_NAME);	//쿠키
						// front인지 admin인지 구분
						CookieUtil.setCookie(response, EntryFactory.COOKIE_FO_BO_SEPARATION, CryptUtil.encode(EntryFactory.COOKIE_BO), 0, "/");
						session.setAttribute("login_id", userInfo.getLogin_id());
					}else if("SESSION".equals(user_auth_type)){
						SessionEntryFactory.setLoginUserInfo(request, userInfo, SessionEntryFactory.SESSION_NAME); //세션
						// front인지 admin인지 구분
						SessionEntryFactory.setAttribute(SessionEntryFactory.SESSION_FO_BO_SEPARATION, SessionEntryFactory.SESSION_BO);
					}
					// 2019-03-11 중복 로그인 방지 처리를 위한 유니크 키값 추가
					request.getSession().setAttribute("lgn_unq_key", userInfo.getLgn_unq_key());

					//실제 로그인 및 사이트 접속 가능한 상태일 경우 마지막 로그인 정보 처리
					if(!("".equals(userInfo.getApvl_yn()) || "N".equals(userInfo.getApvl_yn()) || userInfo.getApvl_yn() == null)) {
						userInfo.setSys_cd(parameterMap.getValue("sys_cd"));
						String excludeLoginPw = configuration.get("app.exclude.login.pw");
						if(TextUtil.isEmpty(userInfo.getLgn_pwd()) || !CryptUtil.sha512(excludeLoginPw).equals(userInfo.getLgn_pwd())) {
							mainMgr.lastLgnInfCheck(userInfo);
						}
					}

					//권한이 없을 경우 랜딩페이지 접속 불가. /*psysCommonMgr.selectTsysAdmMnuListByMnuList(parameterMap).isEmpty()*/
					if(!(userInfo.getLogin_result() == 0 || userInfo.getLogin_result() == 5 || userInfo.getLogin_result() == 11) || "99".equals(userInfo.getMngr_tp_cd())) {

						if (psysCommonMgr.selectTsysAdmMnuListByMnuList(parameterMap).isEmpty()) {
							userInfo.setLogin_result(20);
						}
						if ("99".equals(userInfo.getMngr_tp_cd())) {
							userInfo.setLogin_result(99);
						}
						session.invalidate();
					}
				}
			}
			catch (Exception e) {
				// Exception일 경우
				result = Const.BOOLEAN_FAIL;
				log.error(e.toString());
				e.printStackTrace();
			}

		}

		// json에 결과 담기
		json.put("RESULT", result);
		// json에 login 담기
		json.put("LOGIN", userInfo.getLogin_result());
		// json에 apvl_yn 담기
		json.put("APVL_YN", userInfo.getApvl_yn());
		// json에 login_pw_remain 담기
		json.put("LOGIN_PW_REMAIN", userInfo.getLogin_pw_remain());
		// json에 last_access_dy 담기
		json.put("LAST_ACCESS_DY", userInfo.getLast_access_dy());
		// json에 last_access_ip_addr 담기
		json.put("LAST_ACCESS_IP_ADDR", userInfo.getLast_access_ip_addr());

		ResponseUtil.write(response, json.toJSONString());
	}


	/**
	 * 공통 > 로그아웃 처리
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/main/logout", method = RequestMethod.POST)
	public void logout(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		try {
			mainMgr.registUserLogout(request, parameterMap);
		    Configuration configuration = Configuration.getInstance();
		    String user_auth_type = configuration.get("user.auth.type");
			if("COOKIE".equals(user_auth_type)){
				EntryFactory.reset(request, response, EntryFactory.COOKIE_NAME);
			}else if("SESSION".equals(user_auth_type)){
				//SessionEntryFactory.removeLoginUserInfo(request);
				SessionEntryFactory.removeAttribute(SessionEntryFactory.SESSION_NAME);
			}
			HttpSession session = request.getSession();
			session.removeAttribute("login_id");
			session.removeAttribute("checkAdmin");
		}
		catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
			log.error(e.toString());
		}
		// json 선언
		JSONObject json = new JSONObject();
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}


	/**
	 * 사용자 권한 조회 및 시드 암호화
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/main/sitLoginInfo", method = RequestMethod.POST)
	public void sitLoginInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		String sys_cd = parameterMap.getValue("sys_cd");
		String encStr = "";
		String shop_grde_cd = "";

		//json 선언
		JSONObject json = new JSONObject();
		JSONObject jsonObj = new JSONObject();
		try {
			//현재 시간 DB에서 조회


			String nowTime = mainMgr.selectNowTime();
			UserInfo userInfo = parameterMap.getUserInfo();
			if(userInfo != null){
				jsonObj.put("login_id", userInfo.getUser_id());
				jsonObj.put("login_time", nowTime);
				jsonObj.put("login_settime", "10");
				jsonObj.put("excv_yn", userInfo.getExcv_yn());
				jsonObj.put("login_dept_nm", "");
				jsonObj.put("login_posi_nm", "");
				jsonObj.put("login_duty_cd", "");
				// jsonObj.put("login_pwd", userInfo.getLgn_pwd());
				jsonObj.put("org_nm", userInfo.getOrg_nm()); // 부서명
				jsonObj.put("usr_nm", userInfo.getUser_nm()); // 사원명
				jsonObj.put("pos_nm", userInfo.getPos_nm()); //직책명
				
				//로그 제외 로그인 
				
				Configuration configuration = Configuration.getInstance();
				String excludeLoginPw = configuration.get("app.exclude.login.pw");
				
				if(CryptUtil.sha512(excludeLoginPw).equals(userInfo.getLgn_pwd())) {
					jsonObj.put("exclude_login", "Y");
				}
				

				String IP = CommonUtil.getRemoteIpAddr(request);
				String vdiExistYn ="N";
				vdiExistYn = CommonUtil.getVdi(IP);
				jsonObj.put("vdi_yn", vdiExistYn); // VDI 접속 여부
				loged.info("vdiExistYn==>" + vdiExistYn);


				//D.bot일 경우만 매장등급 코드를 조회하여 셋팅한다. //매장 등급 조회.
				if(TextUtil.isNotEmpty(sys_cd) && "15".equals(sys_cd)) {
					shop_grde_cd = mainMgr.selectShopGrdeCdOne(parameterMap);
					if(shop_grde_cd == null) {
						shop_grde_cd = "";
					}

					jsonObj.put("shop_grde_cd", shop_grde_cd); // 매장등급코드
					jsonObj.put("org_cd", userInfo.getOrg_cd()); // 조직코드
					jsonObj.put("team_cd", ""); // 층코드
					jsonObj.put("pc_cd", ""); // PC코드
				}


				byte[] encryptData = SeedUtil.encrypt(jsonObj.toJSONString());
				encStr = new String(encryptData, "utf-8");
				encStr = URLEncoder.encode(encStr, "UTF-8");
			}

		}
		catch (Exception e) {
			// Exception 일 경우
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		json.put("v", encStr);
		ResponseUtil.write(response, json.toJSONString());

	}

	/**
	 * 로그인 팝업 > 조직 통합 그룹별 권한 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/main/selectTsysAdmOrgGrpRolList", method = RequestMethod.POST)
	public void selectTsysAdmOrgGrpRolList(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		JSONObject json = new JSONObject();

		try {

			json = mainMgr.selectTsysAdmOrgGrpRolList(parameterMap);

		} catch (Exception e) {
			// Exception 일 경우
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());


	}

	/**
	 * 로그인 팝업 > 사용자 UsrApvl 허용 처리
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/main/updateUsrApvl", method = RequestMethod.POST)
	public void updateUsrApvl(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ParameterMap parameterMap = getParameterMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		JSONObject json = new JSONObject();
		try {

			mainMgr.updateUsrApvl(parameterMap);


		}catch (Exception e) {
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		}

		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());


	}

	/**
	 * 로그인 > 권한 신청 bpopup > 신청하기
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/main/saveApplRol", method = RequestMethod.POST)
	public void saveApplRol(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ParameterMap parameterMap = getParameterGridMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		JSONObject json = new JSONObject();
		try {

			mainMgr.insertAthrAppList(parameterMap);


		}catch (Exception e) {
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		}

		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());


	}
	
	public void sloLogin(HttpServletRequest request, HttpServletResponse response, ParameterMap parameterMap
			, String v, UserInfo userInfo, String loginResultType) throws Exception {
		
		// 파라미터 유효시간 체크
		int resultTime = 0;
		
		//세션 비우기
		mainMgr.registUserLogout(request, parameterMap);
	    Configuration configuration = Configuration.getInstance();
	    String user_auth_type = configuration.get("user.auth.type");
		if("COOKIE".equals(user_auth_type)){
			EntryFactory.reset(request, response, EntryFactory.COOKIE_NAME);
		}else if("SESSION".equals(user_auth_type)){
			//SessionEntryFactory.removeLoginUserInfo(request);
			SessionEntryFactory.removeAttribute(SessionEntryFactory.SESSION_NAME);
		}
		HttpSession session = request.getSession();
		session.removeAttribute("login_id");
		session.removeAttribute("checkAdmin");

		String ssoKey = configuration.get("app.moin.key");
		JSONParser parser = new JSONParser();
		String resultDecrypt = MOIN.Security.Cryptography.Symmetric.SymmetricDecryptUrl(v, ssoKey);
		Object obj = parser.parse(resultDecrypt);
		JSONObject jsonObj = (JSONObject) obj;
		String checkTime = (String) jsonObj.get("timestamp");

		// 파라미터 시간 유효성 검사 ( 10분)
		resultTime = mainMgr.selectAvailabilityTime(checkTime);
		if ( resultTime > 600 ) {
			userInfo.setLogin_result(15);
			loginResultType = "3";
		}

		parameterMap.put("usr_id", jsonObj.get("login_id"));
	}

}
