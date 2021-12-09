<%-- 
    작성자 : 임홍섭
    개요 : 팝업 헤더
    수정사항 :
        2016-09-01 최초작성
--%>
<!-- java.jsp include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/java.jsp" %>
<!-- jstl include -->
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!-- jstl include -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<%
	//layer popup이 아닐경우 meta.jsp include하기
	String layerYn = parameterMap.getValue("layer_yn");
	if(!"Y".equals(layerYn)) {
%>
<!-- mete include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/meta.jsp" %>
<%		
	}
%>
<title><%=_title %></title>
<script type="text/javascript">
    //pop_header 최초 로딩시 호출 되는 ready
    $(document).ready(function() {        
        // button 권한 check
    });
</script>