<%-- 
   1. 파일명 : psys1013
   2. 파일설명 : BO본인인증
   3. 작성일 : 2018-04-11
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3Front/js/common/jquery.bpopup.min.js"></script>
<script>

$(document).ready(function() {
	var b_popup = window.parent.b_popup // 부모창 b_popup 변수 가져오기 

	$("#EmailCertButton").click(function(){
		b_popup.close();
		parent.callPopupEmailCert();
	});
	
	$("#PhoneCertButton").click(function(){
		b_popup.close();
	});
	
	$("#ClosePopup").click(function(){
		b_popup.close();
	})
});

</script>

<!-- contents -->
<div class="subCon hidden">
	<h1 class="page-header">본인 인증 수단 선택</h1>
	<!--// button -->
	<div class="buttons" style="text-align: center">
		<div style="display: inline-block;">
			<button class="btn-small btn-primary" id="EmailCertButton" style="display: inline-block;">이메일 인증</button>
			<button class="btn-small btn-primary" id="PhoneCertButton" style="display: inline-block;">휴대폰 인증</button>
			<button class="btn-small btn-primary" id="ClosePopup" style="display: inline-block;">닫기</button>
		</div>
	</div>
</div>
<!-- // contents -->

<%@ include file="/WEB-INF/views/pandora3/common/include/pop_footer.jsp" %>
