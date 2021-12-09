package kr.co.ta9.pandora3.app.interceptor;

import java.net.URLEncoder;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.co.ta9.pandora3.app.conf.AppConst;
import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.main.manager.MainMgr;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmMnu;
import kr.co.ta9.pandora3.pcommon.dto.TsysLogInf;
import kr.co.ta9.pandora3.psys.manager.PsysCommonMgr;



public class BOCheckInterceptor extends HandlerInterceptorAdapter {


    protected Log logger = LogFactory.getLog(this.getClass());


	@Autowired
	private PsysCommonMgr  psysCommonMgr;
	@Autowired
	private MainMgr  mainMgr;

	public static final String[] notInsertUrl = {
		"/main/downloadErrExcelList"
	};

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
    	if (handler == null) {
            return false;
        }

		String message = null;
//		String action = null;
//		boolean isAjax = "XMLHttpRequest".equals(request.getHeader("x-requested-with"));

    	try{
        	ParameterMap parameterMap = new ParameterMap(request);
        	String url = request.getServletPath();
        	String preUrl = request.getParameter("_pre_url");
        	HttpSession session = request.getSession();
        	logger.debug("--------------------------------------------------------");
        	logger.debug("URL : "+url);
        	logger.debug("_pre_url : " + preUrl);

        	StringBuilder buffer3 = new StringBuilder();
        	buffer3.append("PARAMETER INFO : ");
    		Enumeration<String> enumeration3 = request.getParameterNames();
    		while (enumeration3.hasMoreElements()) {
    			String key = enumeration3.nextElement();
    			buffer3.append("["+key+" : "+request.getParameter(key)+"]");
    		}
    		logger.debug(buffer3.toString());

    		//그리드가 아닌 순수 조회일 경우 _pre_url 을 입력함으로써 이전 페이지 구현
    		if(preUrl == null) {
    			preUrl = request.getParameter("_pre_url");
    		}

        	session.setAttribute("checkAdmin", AppConst.ADMIN_GB);

        	boolean bInsert = true;
        	for(String chkUrl : notInsertUrl) {
    			if(url.equals(chkUrl)) {
    				bInsert = false;
    				break;
    			}
    		}
        	if(bInsert){
        	 	String ip_addr = request.getRemoteAddr();
        	 	TsysLogInf tsysLogInf = new TsysLogInf();
        	 	StringBuilder buffer = new StringBuilder();
        	 	StringBuilder buffer2 = new StringBuilder();
        		Enumeration<String> enumeration = request.getParameterNames();
        		String menuIdStr = "";
        		String title = "";

        		while (enumeration.hasMoreElements()) {
        			String key = enumeration.nextElement();

        			// 파라미터로 넘어온 mnu_seq값 저장
        			if("_mnu_seq".equals(key)) {
        				menuIdStr = request.getParameter(key);
        			}
        			// 파라미터로 넘어온 mnu_seq값 저장
        			if("_title".equals(key)) {
        				title = request.getParameter(key);
        			}

        			buffer.append("["+key+" : "+request.getParameter(key)+"]");
        			buffer2.append(key + "=" + request.getParameter(key)+"&");
        		}

        		/*String strParm = "";
        		if(buffer2.toString().length()>0){
        			strParm = buffer2.toString().substring(0, buffer2.toString().length()-1);
        			List<SysAdminMenu> adminMenuURL = psys1002Mgr.url(url);

            		for(int i=0; i < adminMenuURL.size(); i++){
            			SysAdminMenu menuUrl = adminMenuURL.get(i);

            			if(menuUrl.getUrl().indexOf(strParm)>=0){
            				url = menuUrl.getUrl();
            				break;
            			}
            		}
        		}*/


    			UserInfo userInfo = parameterMap.getUserInfo();
        		tsysLogInf.setUsr_id(userInfo.getUser_id());
        		tsysLogInf.setRqst_url(url);
        		tsysLogInf.setIp_addr(ip_addr);
        		tsysLogInf.setRqst_para(buffer.toString());
        		tsysLogInf.setSys_cd(AppConst.SYS_CD);

            	// 2019-01-08 시스템로그저장 시, 컬럼 mnu_seq 추가
            	String requestUrl = url;

            	// mnu_seq가 없는 경우 조회
            	if("".equals(menuIdStr)) {

            		if(buffer2.length() > 0) {
            			buffer2.deleteCharAt(buffer2.length() - 1);
            			requestUrl = requestUrl.concat("?");
            			requestUrl = requestUrl.concat(buffer2.toString());
            		}

            		parameterMap.put("url", requestUrl);
            		menuIdStr = mainMgr.selectMenuId(parameterMap);

            		int menuId = Integer.parseInt(isNumeric(menuIdStr) ? menuIdStr : "0");
	            	tsysLogInf.setMnu_seq(menuId);
	            	tsysLogInf.setMnu_nm(title);

            	} else {
            		//mnu_seq 가 있을 경우 ->
            		if(menuIdStr.indexOf("sub") > -1) {
            			int menuId = Integer.parseInt(isNumeric(menuIdStr) ? menuIdStr : "0");
		            	tsysLogInf.setMnu_seq(menuId);
		            	tsysLogInf.setMnu_nm(title);
            		} else {
            			parameterMap.put("mnu_seq", menuIdStr);
            			TsysAdmMnu tsysAdmMnu = psysCommonMgr.selectTsysAdmMnu(parameterMap);
            			tsysLogInf.setMnu_seq(tsysAdmMnu.getMnu_seq());
            			tsysLogInf.setMnu_nm(tsysAdmMnu.getMnu_nm());
            		}
            	}

            	tsysLogInf.setCrtr_id(userInfo.getUser_id());
            	tsysLogInf.setUpdr_id(userInfo.getUser_id());
            	//psysCommonMgr.insertTsysLogInf(tsysLogInf);
        	}


    	}catch(Exception ex){
    		logger.debug(ex.toString());
    	}
        return true;
    }

    /**
     * 숫자형 문자열인지 판단
     * @param s
     * @return
     */
    public static boolean isNumeric(String s) {
	  try {
	      Double.parseDouble(s);
	      return true;
	  } catch(NumberFormatException e) {
	      return false;
	  }
	}
}
