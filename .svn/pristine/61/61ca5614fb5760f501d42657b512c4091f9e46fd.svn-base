<%--
    작성자 : 조성대
    개요 : 버튼조회 팝업
    수정사항 :
        2015-04-03 최초작성
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3Front/js/common/jquery.bpopup.min.js"></script>
<script>
$(document).ready(function() {
	var b_popup=window.parent.b_popup //부모창 b_popup 변수 가져오기
    $("#cancelButton").click(function(){

        b_popup.close();
    });
    $("#changeButton").click(function(){


        jQuery.ajax({
            url: _context + "/system/chkUserInfoCert.do",
            type: "POST",
            data: {email : $("#email").val(), login_id : $("#login_id").val(), pw : $("#pw").val()},
            dataType:'json',
            async:false,
            success: function(data){
            	if(data.chkUserInfo_result== 0){
            		alert("조회결과 없음")
            	}else if(data.chkUserInfo_result>0){
            		alert("이메일을 전송하였습니다. 확인하여 주시길 바랍니다.")
           			sendCertEmail(data.chkUserInfo_result);
            		b_popup.close();
            	}

            }
        });
    });
  //입력값 유효성/필수 체크
    function validationChk() {

    	// 이메일 형식 및 중복 체크
    	var mailMsg1 = "정확한 이메일 주소를 입력해 주세요.";
    	var email = $("#email").val();
    	var reg = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    	if (!reg.test(email)){
    		$("#email").parent().parent().find('p').text(mailMsg1).show();
    		$("#email").focus();
    		return false;
    	}
    	// 패스워드
    	var pw = $("#pw").val();
    	if(pw.length < 6 || pw.length > 20) {
    		$("#pw").parent().parent().find('p').show();
    		$("#pw").focus();
    		return false;
    	}

    	// 로그인 아이디 : 필수체크
    	if($("#login_id").val().length < 4) {
    		var msg1 = "아이디를 입력 해주세요.";
    		$("#login_id").parent().parent().find('p').text(msg1).show();
    		$("#login_id").focus();
    		return false;
    	}

    	return true;
    }


    function sendCertEmail(user_id) {
    	if(isNotEmpty(user_id)) {
    		jQuery.ajax({
    		    url: _context + "/system/sendCertEmail",
    		    type: "POST",
    		    data: {
    		    	   user_id : user_id
    		    },
    		    dataType:'json',
    		    async:false,
    		    success: function(data){
    		       if (data.RESULT == _boolean_success) {
    		       //console.log("EMAIL SEND SUCCESS")
    		       }
    		    }
    		});
    	}
    }
});
</script>



		<!-- contents -->
		<div class="subCon">
			<h1 class="page-header">이메일 인증</h1>
				<table class="w100">
				<colgroup>
             	<col width="25%">
             	<col width="75%">
             </colgroup>
				<form name="userSignForm" onsubmit="return false;">
						<tr>
						<td>이메일주소<span class="required">*</span></td>
						<td><span class="txt_pw"><input name="email" id="email"  class="text w100" type="text" value="" placeholder="이메일 주소를 입력하세요."></span></td>
						</tr>
						<tr>
							<td>아이디<span class="required">*</span></td>
							<td><span class="txt_pw"><input name="login_id" id="login_id" class="text w100" type="text" value="" placeholder="아이디를 입력하세요." maxlength="15"></span></td>
						</tr>
						<tr>
							<td>비밀번호<span class="required">*</span></td>
							<td><span class="txt_pw"><input name="pw" id="pw" class="text w100" type="password" value="" placeholder="비밀번호를 입력하세요." maxlength="20" autocomplete="off"></span></td>
						<tr>


					</table>
				</form>
				<br>
				<!--// button -->
				<div class="buttons" style="text-align: center">
			    <div style="display: inline-block;">
				<button class="btn-small btn-primary" id="changeButton" style="display: inline-block;">인증</button>
				<button class="btn-small btn-danger" id="cancelButton" style="display: inline-block;">취소</button>
				</div>
				</div>
				</div>


		<!-- // contents -->


<%@ include file="/WEB-INF/views/pandora3/common/include/pop_footer.jsp" %>
