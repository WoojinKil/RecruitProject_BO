<%-- 
    작성자 : 임홍섭
    개요 : jsp에서 사용하는 java 파일 (공통)
    수정사항 :
        2016-09-01 최초작성
--%>
<%@ page import="kr.co.ta9.pandora3.common.util.*" %>
<%@ page import="kr.co.ta9.pandora3.common.conf.*" %>
<%@ page import="kr.co.ta9.pandora3.app.conf.*" %>
<%@ page import="kr.co.ta9.pandora3.app.entry.*" %>
<%@ page import="kr.co.ta9.pandora3.app.util.*" %>
<%@ page import="kr.co.ta9.pandora3.app.servlet.ParameterMap" %>
<%
    ParameterMap parameterMap = new ParameterMap(request);
    Configuration configuration = Configuration.getInstance();
    String user_auth_type = configuration.get("user.auth.type");
    UserInfo userInfo  = new UserInfo();
    if("COOKIE".equals(user_auth_type)){
		userInfo = EntryFactory.getUserInfo(request, EntryFactory.COOKIE_NAME);
	}else if("SESSION".equals(user_auth_type)){
		userInfo = SessionEntryFactory.getLoginUserInfo(request, SessionEntryFactory.SESSION_NAME);
	}
    String _title = parameterMap.getValue("_title");
    String _s3_url = kr.co.ta9.pandora3.common.conf.Config.get("app.amazone.s3.url"); 
    String _s3_bpn_url = _s3_url + kr.co.ta9.pandora3.common.conf.Config.get("app.s3path.bpn.bucketName");

%>