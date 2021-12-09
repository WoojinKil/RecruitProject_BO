/**
exception* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명 : kr.co.ta9.pandora3.app.servlet.filter
* 3. 파일명 : AccessFilter
* 4. 작성일 : 2017-10-27
* </pre>
*/
package kr.co.ta9.pandora3.app.servlet.filter;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Enumeration;

import javax.servlet.FilterChain;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.FrameworkServlet;

import kr.co.ta9.pandora3.app.conf.AppConst;
import kr.co.ta9.pandora3.app.entry.EntryFactory;
import kr.co.ta9.pandora3.app.entry.SessionEntryFactory;
import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.exception.DuplicateLoginException;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.util.CommonUtil;
import kr.co.ta9.pandora3.common.conf.Configuration;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.exception.AuthorityException;
import kr.co.ta9.pandora3.app.exception.InvalidCookieException;
import kr.co.ta9.pandora3.common.exception.LoginTimeoutException;
import kr.co.ta9.pandora3.common.servlet.filter.BaseFilter;
import kr.co.ta9.pandora3.common.util.CookieUtil;
import kr.co.ta9.pandora3.common.util.CryptUtil;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.main.manager.MainMgr;
import kr.co.ta9.pandora3.pcommon.dto.TmbrUsrLgnInf;
/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.app.servlet.filter
* 2. 타입명 : class
* 3. 작성일 : 2017-10-27
* 4. 설명 : 접근 권한 필터
* </pre>
*/
public class AccessFilter extends BaseFilter {
    
	protected static final Log log = LogFactory.getLog(AccessFilter.class);
	// 로그인체크 없이 접근 가능한 페이지
	public final static String FRONT_MAIN_URL = "/";
	public final static String LOGIN_URL = "/login/forward.login.adm";
	public final static String ERROR_URL = "/error/forward.error.adm";
	
	public static final String[] freeActions = {
		FRONT_MAIN_URL,
		LOGIN_URL,
		ERROR_URL,
		"/main/login.do",
		"/main/login.adm"
	};
	

	@SuppressWarnings("unchecked")
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException{
		request.setCharacterEncoding(encoding);
		
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		
		HttpSession session = httpRequest.getSession();
		// clear session if session id in URL
		if (httpRequest.isRequestedSessionIdFromURL() && (session != null)) {
			session.invalidate();
		}
		
		String url = httpRequest.getServletPath();
		String preUrl = request.getParameter("_pre_url");
		String lgnId = request.getParameter("lgn_id");
		String usrNm = request.getParameter("usr_nm");
		String usrEmlAdr = request.getParameter("usr_eml_addr");
		String usrSsCd = request.getParameter("usr_stat_cd");
		String actvYn = request.getParameter("actv_yn");
		String prevParam = "";
		
		//NULL 이면 이전페이지 정보 저장 
		preUrl = preUrl == null ? url : preUrl;
		
		prevParam = "&_pre_url=" + preUrl + "&lgn_id=" + lgnId + "&usr_nm=" + usrNm + "&usr_eml_addr=" + usrEmlAdr + "&usr_stat_cd=" + usrSsCd +"&actv_yn=" + actvYn;
		
		
		StringBuilder buffer = new StringBuilder();
		buffer.append("PARAMETER INFO : ");
		Enumeration<String> enumeration = request.getParameterNames();
		while (enumeration.hasMoreElements()) {
			String key = enumeration.nextElement();
			buffer.append("["+key+" : "+request.getParameter(key)+"]");
		}
		log.debug(buffer.toString());  
		


		// skip non-http requests
		if (!(request instanceof HttpServletRequest)) {
			chain.doFilter(request, response);
			return;
		}
		
		
		boolean isBackOffice = false;
		
		if(url.indexOf(AppConst.ADMIN_EXT) > -1) {
			//SESSION :: Admin 구분값 보존
			session.setAttribute("checkAdmin", AppConst.ADMIN_GB);
			isBackOffice = true;
		} else {
			session.removeAttribute("checkAdmin");
		}
		
		for (String action : freeActions) {
			if (action.equals(url)) {
				// 로그인체크/권한체크 없이 접근가능
				allowAccess(request, response, chain);
				return;
			}
		}
		
		String message = null;
		String action = null;
		boolean isAjax = "XMLHttpRequest".equals(httpRequest.getHeader("x-requested-with"));
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		try {
			// web context 정보 가져옴
			
			ServletContext servletContext = request.getServletContext();
			WebApplicationContext applicationContext = WebApplicationContextUtils.getWebApplicationContext(servletContext, FrameworkServlet.SERVLET_CONTEXT_PREFIX+"appServlet");
			MainMgr mainMgr = applicationContext.getBean(MainMgr.class);
			ParameterMap parameterMap = new ParameterMap(httpRequest);
			UserInfo userInfo = parameterMap.getUserInfo();
			
			// 파라미터 설정
			parameterMap.put("url", url);
			parameterMap.put("ip_addr", CommonUtil.getRemoteIpAddr(httpRequest));
			parameterMap.put("userAgent", httpRequest.getHeader("User-Agent"));
			// 진입로그 저장(Front의 경우만)
//			if(!isBackOffice) mainMgr.saveCounterLog(parameterMap);
			
			// 로그인
			if (userInfo != null && userInfo.isLogin()) {
				Configuration configuration = Configuration.getInstance();
				String LoginControl = configuration.get("app.duplicate.login.control");
				//비밀번호 111111 일 경우 중복 체크 하지 않는다.
				String excludeLoginPw = configuration.get("app.exclude.login.pw");
				
				if("true".equals(LoginControl) && (TextUtil.isEmpty(userInfo.getLgn_pwd()) || !CryptUtil.sha512(excludeLoginPw).equals(userInfo.getLgn_pwd()))) {
					// 중복 로그인 방지 처리 
					parameterMap.put("sys_cd", AppConst.SYS_CD);
					TmbrUsrLgnInf tmbrUsrLgnInf = mainMgr.getTmbrUsrLgnInfUnqKey(parameterMap);
					// 세션 유니크 키값
					String usrSessionLgnUnqKey  = (String) session.getAttribute("lgn_unq_key");
					if(tmbrUsrLgnInf != null && usrSessionLgnUnqKey != null && !"".equals(usrSessionLgnUnqKey)){
						// 최신 로그인 유니크 키값
						String usrLastLgnUnqKey = tmbrUsrLgnInf.getLgn_unq_key();
						if(!usrLastLgnUnqKey.equals(usrSessionLgnUnqKey)) {
							// 중복로그인 기존 사용자 로그아웃 처리
							mainMgr.registUserLogout(httpRequest, parameterMap);
							String user_auth_type = configuration.get("user.auth.type");
							if("COOKIE".equals(user_auth_type)){
								EntryFactory.reset(httpRequest, httpResponse, EntryFactory.COOKIE_NAME);
							}else if("SESSION".equals(user_auth_type)){
								SessionEntryFactory.removeAttribute(SessionEntryFactory.SESSION_NAME);
							}
							session.removeAttribute("lgn_unq_key");
							session.removeAttribute("login_id");
							session.removeAttribute("checkAdmin");
							
							throw new DuplicateLoginException("Duplicate Login!");
						}
					}
				}
				
				
				// 타임아웃 설정 체크
//				long previous = NumUtil.toLong(CryptUtil.decode(httpRequest, EntryFactory.START_TIME_NAME));
//				long current = System.currentTimeMillis();
//				long limit = Config.getLong("user.logout.timeout");	
				/*
				if ( current - previous > limit ) {	//timeout!!!!				
					systemMgr.registUserLogoutExceed(parameterMap);
					EntryFactory.reset((HttpServletRequest)request, (HttpServletResponse)response);
					session.removeAttribute("login_id");
					session.removeAttribute("checkAdmin");
					throw new LoginTimeoutException("System timeout !"); 
				}
				*/
				// 쿠키변조 체크
				String chkKey = CryptUtil.decode(httpRequest, EntryFactory.COOKIE_NAME_SMART_MD);
				String[] values = TextUtil.split(CryptUtil.decode(httpRequest, EntryFactory.COOKIE_NAME), EntryFactory.COOKIE_DELIM);    		
				if (values != null && values.length == 2 && !chkKey.equals(values[1])) {
					throw new InvalidCookieException("invalid cookie!");
				}
				// Front Access
				if(!AppConst.ADMIN_GB.equals((String)session.getAttribute("checkAdmin"))) {
					// 메뉴 접속 기록
					// systemMgr.checkAdminMenuAccess(parameterMap);
					// Front Page는 로그인체크/권한체크 없이 접근가능
					allowAccess(request, response, chain);
					return;
				}
				// BO Access
				else {
					// 관리자 권한 체크
//					if(!"10".equals(userInfo.getUser_auth_type())) {
//						throw new AuthorityException("Login required !");
//					}
				}
			}
			// 비로그인
			else {
				// BO
				if(AppConst.ADMIN_GB.equals((String)session.getAttribute("checkAdmin"))) {
					throw new AuthorityException("Login required !");
				} else {
					// Front Page는 로그인체크/권한체크 없이 접근가능
					allowAccess(request, response, chain);
					return;
				}
			}
			
			// 관리자 메뉴 권한 체크
//			systemMgr.checkAdminMenuAccess(parameterMap);
			
			// 쿠키시간 재설정
			CookieUtil.setCookie(httpResponse, EntryFactory.START_TIME_NAME, CryptUtil.encode(String.valueOf(System.currentTimeMillis())), 0, "/");            
		}
		catch (LoginTimeoutException e) {
			action = AppConst.ACTION_LOGIN;
			message = "로그아웃 시간이 초과되었습니다\n재로그인 하시기 바랍니다";
			log.error(e.toString());
		}
		catch (DuplicateLoginException e) {
			action = AppConst.ACTION_LOGIN;
			message = "다른 사용자가 로그인 하였습니다.";
			log.error(e.toString());
		}
		catch (AuthorityException e) {
			action = isAjax? AppConst.ACTION_NONE : AppConst.ACTION_ERROR;
			message = "다시 로그인 해주세요.";
			log.error(e.toString());
		}
		catch (InvalidCookieException e) {
			action = AppConst.ACTION_LOGIN;
			message = "유효하지 않은 쿠키입니다\n재로그인 하시기 바랍니다";
			log.error(e.toString());
		}
		catch (Exception e) {
			action = isAjax? AppConst.ACTION_NONE : AppConst.ACTION_ERROR;
			message = "일시적 오류입니다\n잠시후 다시 시도하세요";
			log.error(e.toString());
		}
		log.debug("ACTION : "+action);
		if (action != null) {
			log.debug("AJAX : "+isAjax);
			log.debug("ACTION : "+action);
			log.debug("MESSAGE : "+message);
			// ajax call
			if (isAjax) {
				JSONObject json = new JSONObject();
				json.put("AUTH_CHECK_RESULT", Const.BOOLEAN_FAIL);
				json.put("AUTH_CHECK_ACTION", action);
				json.put("AUTH_CHECK_MESSAGE", message);
				
				try {
					ResponseUtil.write(httpResponse, json.toJSONString());
				}
				catch (Exception e) {
					log.debug("json write exception");
				}
			}
			else {
				if(isBackOffice) {
					if (AppConst.ACTION_LOGIN.equals(action) || AppConst.ACTION_ERROR.equals(action)) {
						httpResponse.sendRedirect(httpRequest.getContextPath() + ERROR_URL+"?message="+URLEncoder.encode(message, "UTF-8") + prevParam);
					}
				} else {
					if (AppConst.ACTION_LOGIN.equals(action)) {
						httpResponse.sendRedirect(httpRequest.getContextPath() + FRONT_MAIN_URL);
					}
				}
//				if (AppConst.ACTION_LOGIN.equals(action)) {
//					httpResponse.sendRedirect(httpRequest.getContextPath() + FRONT_MAIN_URL);
//				}
//				else if (AppConst.ACTION_ERROR.equals(action)) {
//					httpResponse.sendRedirect(httpRequest.getContextPath() + ERROR_URL+"?message="+URLEncoder.encode(message, "UTF-8"));
//				}
//				else {
//					httpResponse.sendRedirect(httpRequest.getContextPath() + ERROR_URL);
//				}
			}
		}
		else {
			log.debug("--------------------------------------------------------");
			allowAccess(request, response, chain);
		}
    }
    
    // 접근허용
 	private void allowAccess(ServletRequest request, ServletResponse response,
 			FilterChain chain) throws IOException, ServletException {
 		((HttpServletResponse)response).addHeader( "Pragma", "no-cache" );
 		((HttpServletResponse)response).addHeader( "Expires", "-1" );
         chain.doFilter( request, response );
 	}
}