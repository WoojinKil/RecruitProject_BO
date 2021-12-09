/**
* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명 : kr.co.ta9.pandora3.app.entry
* 3. 파일명 : EntryFactory
* 4. 작성일 : 2017-10-27
* </pre>
*/
package kr.co.ta9.pandora3.app.entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletWebRequest;



/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.app.entry
* 2. 타입명 : class
* 3. 작성일 : 2017-10-27
* 4. 설명 : 로그인, 쿠키 관련
* </pre>
*/
public final class SessionEntryFactory {
    
    public final static String START_TIME_NAME          = "PANDORA_LOGIN_START";
    public final static String SESSION_NAME             = "PANDORA_SESSION";
    public final static String SESSION_NAME_SMART_MD    = "PANDORA_MD5";
    public final static String SESSION_DELIM            = "!#!";
    public final static String SESSION_DELIM_1          = ":^:";
    public final static String SESSION_LOGIN_ID         = "PANDORA_LOGIN_ID";
    public final static String SESSION_FRONT_NAME       = "PANDORA_FRONT_SESSION";
    public final static String SESSION_FO_BO_SEPARATION = "PANDORA_FO_BO_SEPARATION_SESSION";
    public final static String SESSION_BO               = "BO";
    public final static String SESSION_FO               = "FO";
    
//    private static final Log log = LogFactory.getLog(SessionEntryFactory.class);
    
    /**
     * attribute 값을 가져 오기 위한 method
     *
     * @param String
     *            attribute key name
     * @return Object attribute obj
     */
    private SessionEntryFactory() {
      	throw new IllegalStateException("Utility class");
    }
    
    public static Object getAttribute(String name) {
    	
    	//ServletWebRequest servletContainer = (ServletWebRequest)RequestContextHolder.getRequestAttributes();
    	//HttpServletRequest request = servletContainer.getRequest();
    	//HttpServletResponse response = servletContainer.getResponse();
    	
    	if( RequestContextHolder.getRequestAttributes() !=null){
    		return (Object) RequestContextHolder.getRequestAttributes().getAttribute(name, RequestAttributes.SCOPE_SESSION);
    	}else
    		return null;
        
    }

    /**
     * attribute 설정 method
     *
     * @param String
     *            attribute key name
     * @param Object
     *            attribute obj
     * @return void
     */
    public static void setAttribute(String name, Object object) {
        RequestContextHolder.getRequestAttributes().setAttribute(name, object, RequestAttributes.SCOPE_SESSION);
    }

    /**
     * 설정한 attribute 삭제
     *
     * @param String
     *            attribute key name
     * @return void
     */
    public static void removeAttribute(String name) throws Exception {
        RequestContextHolder.getRequestAttributes().removeAttribute(name, RequestAttributes.SCOPE_SESSION);
    }

    /**
     * 로그인 사용자 정보 얻기
     * 
     * @param req
     * @return
     */
    public static UserInfo getLoginUserInfo(HttpServletRequest req, String sessionName) {
        return getLoginUserInfo(sessionName);
    }

    public static UserInfo getLoginUserInfo(String sessionName) {
        return (UserInfo) getAttribute(sessionName);
    }

    /**
     * 로그인 사용자 정보 세팅
     * 
     * @param req
     * @param userInfo
     */
    public static void setLoginUserInfo(HttpServletRequest req, UserInfo userInfo, String sessionName) {
        setLoginUserInfo(userInfo, sessionName);
    }

    public static void setLoginUserInfo(UserInfo userInfo, String sessionName) {
        setAttribute(sessionName, userInfo);
    }

    /**
     * 세션 vaild
     * 
     * @param req
     */
    public static void removeLoginUserInfo(HttpServletRequest req) {
        HttpSession sess = req.getSession();
        sess.invalidate();
    }

    /**
     * 현재 session id를 얻는다
     * 
     * @param req
     */
    public static String getSessionId(HttpServletRequest req) {
        HttpSession sess = req.getSession();
        return sess.getId();
    }

    public static String getSessionId() {
        return RequestContextHolder.getRequestAttributes().getSessionId();
    }
  
}
