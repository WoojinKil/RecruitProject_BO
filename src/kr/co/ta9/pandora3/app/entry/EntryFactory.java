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

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import kr.co.ta9.pandora3.common.conf.Config;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.CookieUtil;
import kr.co.ta9.pandora3.common.util.CryptUtil;
import kr.co.ta9.pandora3.common.util.MD5Util;
import kr.co.ta9.pandora3.common.util.TextUtil;

/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.app.entry
* 2. 타입명 : class
* 3. 작성일 : 2017-10-27
* 4. 설명 : 로그인, 쿠키 관련
* </pre>
*/
public final class EntryFactory {
    
    public final static String START_TIME_NAME         = "PANDORA_LOGIN_START";
    public final static String COOKIE_NAME             = "PANDORA_COOKIE";
    public final static String COOKIE_NAME_SMART_MD    = "PANDORA_MD5";
    public final static String COOKIE_DELIM            = "!#!";
    public final static String COOKIE_DELIM_1          = ":^:";
    public final static String COOKIE_LOGIN_ID         = "PANDORA_LOGIN_ID";
    public final static String COOKIE_FRONT_NAME       = "PANDORA_FRONT_COOKIE";
    public final static String COOKIE_FO_BO_SEPARATION = "PANDORA_FO_BO_SEPARATION_COOKIE";
    public final static String COOKIE_BO               = "BO";
    public final static String COOKIE_FO               = "FO";
    
    private static final Log log = LogFactory.getLog(EntryFactory.class);
    
    private EntryFactory() {
    	throw new IllegalStateException("Utility class");
    }
    
    public static UserInfo getUserInfo(HttpServletRequest request, String cookieName) {        
        UserInfo userInfo = new UserInfo();
        String value = CryptUtil.decode(request, cookieName);
        
        if (value != null && !"".equals(value)) {        	
            String[] values = TextUtil.split(value, EntryFactory.COOKIE_DELIM);
            userInfo.setLogin(values[0]);
            userInfo.setUser_id(values[1]);
            userInfo.setUser_nm(values[2]);
            userInfo.setLogin_id(values[3]);
            userInfo.setUsr_stat_cd(values[4]);
            userInfo.setLast_access_ip_addr(values[5]);
            userInfo.setUser_auth_type(values[6]);
            userInfo.setMngr_tp_cd(values[7]);
            userInfo.setSys_cd(values[8]);
        	userInfo.setOrg_cd(values[9]);
        	userInfo.setPos_cd(values[10]);
        	userInfo.setJob_cd(values[11]);
        	userInfo.setApvl_yn(values[12]);
            
            /* ERIK 미 사용 컬럼 : 2017-10-27
            userInfo.setDept_id(values[3]);
            userInfo.setDept_nm(values[4]);
            userInfo.setEmp_no(values[7]);
            userInfo.setTel_no(values[8]);
            userInfo.setCell_no(values[9]);		*/
        }
        userInfo.fixNull(); 
        
        return userInfo;
    }    
    
    public static void setUserInfo(HttpServletResponse response, UserInfo userInfo, String cookieName) {
        setUserInfo(response, userInfo, 0, cookieName);
    }
    
    public static void setUserInfo(HttpServletResponse response, UserInfo userInfo, int age, String cookieName) {
        setUserInfo(response, userInfo, age, "/", cookieName);
    }
    
    public static void setUserInfo(HttpServletResponse response, UserInfo userInfo, int age, String path, String cookieName) {
    	setUserInfo(response, userInfo, age, "/", Config.get(Const.COOKIE_DOMAIN), cookieName);
    }
    
    public static void setUserInfo(HttpServletResponse response, UserInfo userInfo, int age, String path, String domain, String cookieName) {
        
    	StringBuilder buf = new StringBuilder();
        String md5Value = "";

        buf.append(TextUtil.toEmpty(userInfo.getLogin())).append(EntryFactory.COOKIE_DELIM)
        .append(TextUtil.toEmpty(userInfo.getUser_id())).append(EntryFactory.COOKIE_DELIM)
        .append(TextUtil.toEmpty(userInfo.getUser_nm())).append(EntryFactory.COOKIE_DELIM)
        .append(TextUtil.toEmpty(userInfo.getLogin_id())).append(EntryFactory.COOKIE_DELIM)
        .append(TextUtil.toEmpty(userInfo.getUsr_stat_cd())).append(EntryFactory.COOKIE_DELIM)
    	.append(TextUtil.toEmpty(userInfo.getLast_access_ip_addr())).append(EntryFactory.COOKIE_DELIM)
    	.append(TextUtil.toEmpty(userInfo.getUser_auth_type())).append(EntryFactory.COOKIE_DELIM)
    	.append(TextUtil.toEmpty(userInfo.getMngr_tp_cd())).append(EntryFactory.COOKIE_DELIM)
    	.append(TextUtil.toEmpty(userInfo.getSys_cd())).append(EntryFactory.COOKIE_DELIM)
    	.append(TextUtil.toEmpty(userInfo.getOrg_cd())).append(EntryFactory.COOKIE_DELIM)
    	.append(TextUtil.toEmpty(userInfo.getPos_cd())).append(EntryFactory.COOKIE_DELIM)
    	.append(TextUtil.toEmpty(userInfo.getJob_cd())).append(EntryFactory.COOKIE_DELIM)
    	.append(TextUtil.toEmpty(userInfo.getApvl_yn())).append(EntryFactory.COOKIE_DELIM);
        
        
        /* ERIK 미 사용 컬럼 : 2017-10-27
        buf.append(TextUtil.toEmpty(userInfo.getDept_id())).append(EntryFactory.COOKIE_DELIM);
        buf.append(TextUtil.toEmpty(userInfo.getDept_nm())).append(EntryFactory.COOKIE_DELIM);
        buf.append(TextUtil.toEmpty(userInfo.getEmp_no())).append(EntryFactory.COOKIE_DELIM);
        buf.append(TextUtil.toEmpty(userInfo.getTel_no())).append(EntryFactory.COOKIE_DELIM);
        buf.append(TextUtil.toEmpty(userInfo.getCell_no())).append(EntryFactory.COOKIE_DELIM);	*/
        
        log.debug("==================================== userInfoString = ["+buf.toString()+"]");
        //사용자 정보 저장
        MD5Util md5 = new MD5Util();
        md5Value = md5.setCertKey(buf.toString());
        log.debug("MD5[[[" + md5Value + "]]]");
        String cookieString = TextUtil.replaceString(CryptUtil.encode(buf.toString() + EntryFactory.COOKIE_DELIM_1 + md5Value), Config.get(Const.COOKIE_CRLF), "");
        log.debug("==================================== cookieString = ["+cookieString+"]");

        // debug
        String[] values = TextUtil.split(CryptUtil.decode(cookieString), EntryFactory.COOKIE_DELIM);
        log.debug("==================================== decryptedvalues="+values);
        for (String v : values) {
        	log.debug(v);
        }
        
        // domain 필요시 세팅
        //String cookieDomain = Config.get(domain);
        CookieUtil.setCookie(response, cookieName, cookieString, age, path); 
        CookieUtil.setCookie(response, EntryFactory.COOKIE_NAME_SMART_MD, TextUtil.replaceString(CryptUtil.encode(md5Value), Config.get(Const.COOKIE_CRLF), ""), age, path);
        CookieUtil.setCookie(response, EntryFactory.START_TIME_NAME, CryptUtil.encode(String.valueOf(System.currentTimeMillis())), age, path);
    }
    
    /**
     * 작성자:goodbug
     * 개요:쿠기 삭제
     */
    public static void reset(HttpServletRequest request, HttpServletResponse response, String cookieName) {
        CookieUtil.setCookie(response, cookieName, null);    //사용자정보 초기화
    }
    
}
