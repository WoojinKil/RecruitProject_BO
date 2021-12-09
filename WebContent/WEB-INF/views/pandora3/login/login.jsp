<%--
    개요 : 로그인
    수정사항 : 2017-10-23 최초작성
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- java.jsp include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/java.jsp" %>
<!-- jstl include -->
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!-- jstl include -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- tags include -->
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<!-- login css -->
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/pandora3/css/login.css" />


<!-- 헤더 파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/meta.jsp" %>

<%

 if(!(request.getParameter("v") != null && !"".equals(request.getParameter("v").toString()))) {
	 if(userInfo!=null && userInfo.isLogin()){
         String _path = request.getContextPath();
         _path += "/login/forward.main.adm";
         response.sendRedirect(_path);
	 }
 }


%>
<%
// 아이디 저장
Cookie[] cookie = request.getCookies();
String login_id = "";
if(cookie != null) {
	for(int i = 0; i < cookie.length; i++) {
		if(cookie[i].getName().trim().equals("PANDORA_LOGIN_ID")) {
			login_id = CryptUtil.decode(cookie[i].getValue());
		}
	}
}
%>

<script type="text/javascript">
var v ="<c:out value='${v}' />";
$(document).ready(function(){

	//v가 존재할경우 바로 로그인 시도
	if(isNotEmpty(v)) {
		fn_login();
	}

	// login box position
	loginBox();


	// login button hover
	$(".login").find("input[type='submit']").hover(function(){
		$(this).css("background-color","#1d56c3");
	},function(){
		$(this).css("background-color","#337fd7");
	})

	$("#lgn_pwd").keydown(function(event) {
		if (event.keyCode == '13') {
			$('#login-button').trigger('click');
		}
	});

	$("#lgn_id").keydown(function(event) {
		if (event.keyCode == '13') {
			 $('#login-button').trigger('click');
		}
	});

	$('#login-button').click(function(){
		var lgn_id = $('#lgn_id').val().trim();
		var lgn_pwd = $('#lgn_pwd').val().trim();
		if (isEmpty(lgn_id)) {
			alert('<c:out escapeXml="true"  value='<%= kr.co.ta9.pandora3.common.util.MessageUtil.getMsg("MSG.ALERT.000004")%>' />');
			$('#lgn_id').focus();
		}else if (isEmpty(lgn_pwd)) {
			alert('<c:out escapeXml="true"  value='<%= kr.co.ta9.pandora3.common.util.MessageUtil.getMsg("MSG.ALERT.000005")%>' />');
			$("#lgn_pwd").focus();
		} else {
			v = "";
			fn_login(lgn_id, lgn_pwd);

		}});

	// 아이디 저장 선택시 초기화면 설정
	if ($("#login_id").val() != "") {
		$("#idsave").attr("checked", true);
		$("#lgn_pwd").focus();
	}
});

// for resize window
$(window).resize(function(){
	loginBox();
});

function fn_login(lgn_id, lgn_pwd) {

	//세션이 비정상적으로 끊킬경우 이전 url 정보
	var _pre_url = "<c:out value='${param._pre_url == null ? "" : param._pre_url}' />";
	var lgnId = "<c:out value='${param.lgn_id == null ? "" : param.lgn_id}' />";
	var usrNm = "<c:out value='${param.usr_nm == null ? "" : param.usr_nm}' />";
	var usrEmlAdr = "<c:out value='${param.usr_eml_addr == null ? "" : param.usr_eml_addr}' />";
	var usrSsCd = "<c:out value='${param.usr_stat_cd == null ? "" : param.usr_stat_cd}' />";
	var actvYn = "<c:out value='${param.actv_yn == null ? "" : param.actv_yn}' />";


	ajax({
		url : "/main/login",
		data : {
              lgn_id     : lgn_id
            , lgn_pwd    : lgn_pwd
            , idsave     : $("#idsave").prop("checked")? "<%=Const.BOOLEAN_TRUE%>":"<%=Const.BOOLEAN_FALSE%>"
            , _pre_url   : _pre_url
            , sys_cd    : _sys_cd
            , lgnId      : lgnId
            , usrNm      : usrNm
            , usrEmlAdr  : usrEmlAdr
            , usrSsCd    : usrSsCd
            , actvYn     : actvYn
            , v          : v
		},
		success:function(data) {
			if (data.RESULT == _boolean_success) {
				var msg = "";
				if (data.LOGIN == 1) {
					alert('<%=MessageUtil.getMsg("MSG.ALERT.000006")%>');
				} else if (data.LOGIN == 2 || data.LOGIN == 14) {
					alert('<%=MessageUtil.getMsg("MSG.ALERT.000007", new String[]{kr.co.ta9.pandora3.common.conf.Config.get("user.passwd.wrong.cnt")})%>');
				} else if (data.LOGIN == 5) {
					alert('<s:message code="MSG.LABEL.000008" arguments="' + data.LOGIN_PW_REMAIN + '" />');
				} else if (data.LOGIN == 6) {
					alert('<%=MessageUtil.getMsg("MSG.ALERT.000009")%>');
				} else if (data.LOGIN == 10) {
					alert('<%=MessageUtil.getMsg("MSG.ALERT.000010")%>'+'\n관리자에게 문의 하시거나\n' + data.LAST_ACCESS_DY +' 이후 로그인 시도 해주세요.');
				} else if (data.LOGIN == 12) {
					alert('<%=MessageUtil.getMsg("MSG.ALERT.000011")%>');
				} else if (data.LOGIN == 13) {
					alert('<%=MessageUtil.getMsg("MSG.ALERT.000012")%>');
				} else if (data.LOGIN == 14) {
                    alert('<%=MessageUtil.getMsg("MSG.ALERT.000012")%>');
				} else if (data.LOGIN == 15) {
					alert("유효하지 않은 로그인입니다.");
					window.top.location.href= _context + '/login/forward.login.adm';
				} else if (data.LOGIN == 30) {
					alert("사용할 수 있는 권한이 없습니다.");
				} else if (data.LOGIN == 8) {
					alert("외부 사용자는 접근할 수 없습니다.");
				}  else {
					
		               /* data.LOGIN == 11 : 최근 접속한 IP와 현재 접속 IP가 상이합니다 */
	                // 아이디 비번확인이 완료되면 페이지 이동
	                if (data.LOGIN == 0 ||
	                    data.LOGIN == 5 ||
	                    data.LOGIN == 11) {

	                    // 사용 권한이 없을 경우 0 리스트 표출

	                    popup({url:"/login/forward.main.adm"
	                        , winname:"_top"
	                        , title:"pandora3"
	                        , scrollbars:false
	                        , autoresize:false
	                    });

	                } 
					
				}


			}
			else {
				alert("<s:message code='MSG.ALERT.000013' />");
			}
		}
	});


}

//login box position
function loginBox(){
	// 변수
	var winWidth = $(window).width();
	var winHeight = $(window).height();
	var boxWidth = $(".login").width();
	var boxHeight = $(".login").height();
};
function noSpaceForm(obj) { // 공백사용못하게
    var str_space = /\s/;  // 공백체크
    if(str_space.exec(obj.value)) { //공백 체크
        obj.value = obj.value.replace(' ',''); // 공백제거
        return false;
    }
}


</script>
</head>
<body>
    <c:choose>
        <c:when test="${empty v}">
            <div id="loginWrap">
                <h1 class="screen_out"><s:message code="MSG.LABEL.000003" /></h1>
                <!-- login -->
                <div class="login">
                    <h2 class="companyLogo"><img src="${pageContext.request.contextPath}/resources/pandora3/images/login/img_default_login_logo.png" alt="판도라3 로고" /></h2>
                    <form name="loginForm" id="loginForm" method="post">
                        <!-- input -->
                        <fieldset>
                            <legend class="screen_out"><s:message code="MSG.LABEL.000004" /></legend>
                            <div class="loginInput">
                                <label class="screen_out" for="id"><s:message code="MSG.LABEL.000005" /></label><input type="text" name="lgn_id" id="lgn_id" value="<%=login_id%>" onkeyup="noSpaceForm(this)" onchange="noSpaceForm(this)" placeholder="<s:message code='MSG.LABEL.000005' />" />
                                <label class="screen_out" for="pw"><s:message code="MSG.LABEL.000006" /></label><input type="password" name="lgn_pwd" id="lgn_pwd" value="" onkeyup="noSpaceForm(this)" onchange="noSpaceForm(this)" placeholder="<s:message code='MSG.LABEL.000006' />" />
                            </div>
                            <!-- id save -->
                            <div class="idSave">
                                <div class="saveId">
                                    <input type="checkbox" name="idsave" id="idsave" value="Y" /><label for="idsave"><s:message code="MSG.LABEL.000007" /></label>
                                </div>
                                <!-- <div class="saveMore type_right">
                                    <a href="javascript:callPopupFindId()" class="">아이디</a>/<a href="javascript:callPopupFindPasswd()">비밀번호찾기</a>
                                </div> -->
                            </div>
                            <!--// id save -->
                            <button type="button" name="login-button" id="login-button"><s:message code="MSG.LABEL.000010" /></button>
                        </fieldset>
                        <!--// input -->

                    </form>
                    <p class="login_copy_right">
                    	COPYRIGHT (C) 2020. PANDORA3.
                    </p>
                </div>
                <div id="bpopup"></div>

                <!-- 메세지 Layer : Global -->
                <%@ include file="/WEB-INF/views/pandora3/common/include/msg_global.jsp" %>
            </div>
        </c:when>
        <c:otherwise>
            <div class="mMovingWrap">
                <div class="mMoving">
                    <div class="moveContent">
                        <p class="moveMsg">요청하신 페이지로 <strong>이동 중</strong> 입니다.</p>
                        <%-- <a href="${pageContext.request.contextPath}/" class="mainBtn">판도라홈</a> --%>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</body>
</html>