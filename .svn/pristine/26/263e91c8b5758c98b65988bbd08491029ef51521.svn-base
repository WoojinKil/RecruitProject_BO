<%-- 
   1. 파일명 : indvDtl
   2. 파일설명: 개인정보취급방침 페이지
   3. 작성일 : 2019-04-05
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/meta.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=_resourcePath%>/common/css/style.css">
<script type="text/javascript">
// iFrame 높이 계산
function calcHeight() {
	var ifr_plcy_height = document.getElementById('ifr_plcy').contentWindow.document.body.scrollHeight;
	document.getElementById('ifr_plcy').height = ifr_plcy_height;
	document.getElementById('ifr_plcy').style.overflow = "hidden";
}
</script>
<body>
	<div id="wrap">
		<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/header.jsp" %>
		<!-- Container -->
		<div id="container">
			<!-- Content -->
			<div id="content">
				<div class="subContent typeNon">
					<h3 class="title typeBoard">개인정보 취급방침</h3>
					<iframe src="<%=_resourcePath%>/common/html/policy_content.html" onload="calcHeight();" id="ifr_plcy" frameborder="0" scrolling="no" style="width: 100%; min-height: 500px; overflow-x: hidden; overflow: auto; margin-top: 70px; border:0 none; border-top: 1px solid #333;"></iframe>
				</div>
			</div>		
			<!-- //Content -->
		</div>
		<!-- //Container -->
        <%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/footer.jsp" %>
	</div>
</body>
</html>