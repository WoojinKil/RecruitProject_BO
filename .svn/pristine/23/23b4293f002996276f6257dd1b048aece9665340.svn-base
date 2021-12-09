<%-- 
 	1. 파일명 : psys1014certEmail
 	2. 파일설명 :메인 > 회원정보 수정 > 이메일인증
 	3. 작성일 :
 	4. 작성자 : 
--%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/pandora3/common/include/meta.jsp" %>
</head>
<script>
function certComplete(){
	window.close();
}
</script>
	<body style="margin: 20px; padding: 20px">
		<c:if test="${RESULT eq 'S'}">
			<div style="width: 770px; border: 1px solid #ddd; margin: 0 auto; padding:">
				<div style="padding: 50px">
					<div style="text-align: center">
						<img src="${pageContext.request.contextPath}/resources/pandora3/images/logo.png" />
					</div>
					<br /> <br />
					<div style="background: #f6f6f6; padding: 40px; text-align: center">
						<p style="font-size: 24px; color: #666; font-weight: 400">이메일 인증 완료</p>
						<p style="font-size: 16px; color: #666; font-weight: 400; margin-top: 40px">
							이메일 주소 : <font style="color: #337fd7">${myPageUserInfoMap.email}</font>의<br />
						</p>
						<p style="font-size: 16px; color: #666; font-weight: 400; margin-top: 40px">인증이 완료되었습니다.</p>
						<div style="margin: 40px 0px 20px 0px">
							<a href="javascript:certComplete();" style="color: #fff; background: #666; padding: 10px 40px;">닫기</a>
						</div>
					</div>
				</div>
			</div>
		</c:if>
		<c:if test="${RESULT eq 'F'}">
			<div style="width: 770px; border: 1px solid #ddd; margin: 0 auto; padding:">
				<div style="padding: 50px">
					<div style="text-align: center">
						<img src="${pageContext.request.contextPath}/resources/pandora3/images/logo.png" />
					</div>
					<br /> <br />
					<div style="background: #f6f6f6; padding: 40px; text-align: center">
						<p style="font-size: 24px; color: #666; font-weight: 400">이메일 인증 실패</p>
						<p style="font-size: 16px; color: #666; font-weight: 400; margin-top: 40px">발급된 인증키의 유효기간이 만료되었습니다.</p>
						<p style="font-size: 16px; color: #666; font-weight: 400; margin-top: 40px">이메일 인증 절차를 다시 진행해주세요.</p>
						<div style="margin: 40px 0px 20px 0px">
							<a href="javascript:certComplete();" style="color: #fff; background: #666; padding: 10px 40px;">닫기</a>
						</div>
					</div>
				</div>
			</div>
		</c:if>
	</body>
</html>