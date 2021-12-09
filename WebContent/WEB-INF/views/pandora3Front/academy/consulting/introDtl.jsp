<%-- 
   1. 파일명 : introDtl
   2. 파일설명: 수강소개 상세
   3. 작성일 : 2019-04-03
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/meta.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=_resourcePath%>/common/css/style.css">
<body>
	<div id="wrap">
		<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/header.jsp" %>
		<!-- Container -->
		<div id="container">
			<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/breadCrumb.jsp" %>
					<div class="detailArea typeNoneTitle">
						<div class="contentArea">${tbbsDocInf.cts}</div>
					</div>
				</div>
			</div>
			<!-- //Content -->
		</div>
		<!-- //Container -->
        <%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/footer.jsp" %>
	</div>
</body>
</html>