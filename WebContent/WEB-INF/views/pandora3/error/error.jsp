<%-- 
    작성자 : 조성대
    개요 : 에러페이지
    수정사항 :
        2015-04-07 최초작성
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- jstl include -->
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!-- jstl include -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">   
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<!-- 헤더 파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<title>오류페이지</title>
<script type="text/javascript">
var nowUrl = window.location.href;
var errUrl = '/error/forward.error';
$(document).ready(function() {
	var errMsg = $("#errMsg").val();
	//console.log(errMsg);
	if(nowUrl.indexOf(errUrl)) {
		alert(errMsg);
		window.top.location.href= _context + '/login/forward.login.adm?_pre_url=' + '<%=request.getParameter("_pre_url") == null ? "" : request.getParameter("_pre_url")%>';
	}

});
</script>
</head>
<body>
	<input type="hidden" id="errMsg" value="<%=request.getParameter("message") == null? "알수없는 오류가 발생하였습니다":request.getParameter("message")%>" style="display:none;"/>
</body>
</html>