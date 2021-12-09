<%-- 
    작성자 : 
    개요 : 메인 > 회원가입 > [STEP3] 이메일인증
    수정사항 :
        2017-11-28 최초작성
--%>
<?xml version="1.0" encoding="UTF-8" ?>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>pandora3</title>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/pandora3/common/include/meta.jsp" %>
</head>
<script>
var cert_key_status = '${CERT_KEY_STATUS}'
$(document).ready(function() {
	init();
});

function init() {
	if(cert_key_status == "EXPIRED_CERT_KEY"){
		alert("인증키 유효기간이 종료 되었습니다.\n인증 메일을 다시 전송후 진행해주세요.");
		window.location.replace("${pageContext.request.contextPath}/main/login/userFindProcess.do?tab_id=tab3_");
	} 
	else if(cert_key_status == "ALREADY_CERT_KEY") {
		alert("이미 인증이 완료된 회원입니다.");
		window.location.replace("${pageContext.request.contextPath}");
	} 
}

function updateUserCertInfo() {
	var login_id = '${LOGIN_ID}';
	var email = '${EMAIL}';
	var join_cert_key = '${JOIN_CERT_KEY}';
	
	ajax({
		url : "/system/updateUserCertInfo", 
		data : {email : email,
			    login_id : login_id,
			    join_cert_key : join_cert_key},
		success:function(data) {
			//console.log(data);
			//console.log(cert_key_status);
			if(data.RESULT == "S") {
				alert("인증처리가 완료되었습니다. 가입을 환영합니다.");
				window.location.replace("${pageContext.request.contextPath}");
			}
			else if(data.RESULT == "EXPIRED_CERT_KEY"){
				alert("인증키 유효기간이 종료 되었습니다.\n인증 메일을 다시 전송후 진행해주세요.");
				window.location.replace("${pageContext.request.contextPath}/main/login/userFindProcess.do?tab_id=tab3_");
			} else if(data.RESULT == "ALREADY_CERT_KEY") {
				alert("이미 인증이 완료된 회원입니다.");
				window.location.replace("${pageContext.request.contextPath}");
			}
		}
	});	
}
	
</script>
<body style="margin:20px;padding:20px">
	<c:choose>
	<c:when test="${CERT_KEY_STATUS eq 'EXPIRED_CERT_KEY'}">
	</c:when>
	<c:when test="${CERT_KEY_STATUS eq 'ALREADY_CERT_KEY'}">
	</c:when>
	<c:otherwise>
	<div style="width:770px;border:1px solid #ddd;margin:0 auto;padding:">
		<div style="padding:50px">
			<div style="text-align:center">
			
			</div>
			<div style="margin:25px 0px;text-align:center">
				<p style="font-size:24px;color:#666">판도라 홈페이지 회원가입을 축하합니다.</p>
			</div>
			<div style="background:#f6f6f6;padding:40px;text-align:center">
				<p style="font-size:24px;color:#666;font-weight:400">이메일 인증</p>
				<p style="font-size:20px;color:#666;font-weight:300;margin-top:5px">회원가입 완료를 위해 이메일 인증을 해 주세요.</p>
				<p style="font-size:16px;color:#666;font-weight:400;margin-top:40px">
					안녕하세요. <font style="color:#337fd7">${LOGIN_ID}(${EMAIL})님!</font><br />
					<font style="color:#337fd7">${JOIN_MAX_TERM}</font>까지 아래의 버튼을 클릭하여 가입을 완료하세요.
				</p>
				<div style="margin:40px 0px 20px 0px">
					<a href="javascript:updateUserCertInfo();" style="color:#fff;background:#666;padding:10px 40px;">인증하기</a>
				</div>
			</div>
			<div style="margin:40px 0px 20px 0px;text-align:center">
				본 메일은 메일 수신 동의에 의한 발신 전용 메일입니다.<br />
				자세한 문의 사항은 <font style="color:#337fd7">~~~</font>으로 문의 주시기 바랍니다.
			</div>
		</div>
	</div>
	</c:otherwise>
	</c:choose>
	
</body>
</html>