<%--
   1. 파일명 : psys1013email
   2. 파일설명: BO본인인증 이메일 페이지
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

	$("#cancelButton").click(function(){
		b_popup.close();
	});

	$("#changeButton").click(function(){
		jQuery.ajax({
			url		: _context + "/psys/getPsys1013ChkEml",
			type	: "POST",
			data	: {usr_eml_addr : $("#sch_usr_eml_addr").val(), lgn_id : $("#sch_lgn_id").val(), lgn_pwd : $("#sch_lgn_pwd").val()},
			dataType: 'json',
			async	: false,
			success	: function(data){
				if(isNotEmpty(data.chkEmlResult))
					fn_sendCertEmail(data.chkEmlResult);
				else if(isEmpty(data.chkEmlResult))
					alert("조회결과가 없습니다.");
				else
					alert("본인인증 처리 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.");
            }
		});
	});

	//입력값 유효성/필수 체크
	function fn_validationCheck()
	{
		var reg_exp = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		if(!reg_exp.test($("#sch_usr_eml_addr").val()))
		{
			alert("정확한 이메일 주소를 입력해 주세요.");
			$("#sch_usr_eml_addr").focus();
			return false;
		}

		// 로그인 아이디 : 필수체크
		if($("#sch_lgn_id").val().length < 4)
		{
    		alert("로그인ID를 입력해 주세요.");
    		$("#sch_lgn_id").focus();
    		return false;
    	}

    	// 패스워드
    	var pwd = $("#sch_lgn_id").val();
    	if(pwd.length < 6 || pwd.length > 20) {
    		alert("비밀번호를 입력해 주세요.");
    		$("#sch_lgn_pwd").focus();
    		return false;
    	}

    	return true;
    }


	function fn_sendCertEmail(usr_id)
	{
		if(isNotEmpty(usr_id))
		{
			jQuery.ajax({
				url		: _context + "/psys/sndCertEml",
				type	: "POST",
				data	: {usr_id : usr_id},
    		    dataType: 'json',
    		    async	: false,
    		    success	: function(data){
					if (data.RESULT == _boolean_success)
					{
						alert("이메일을 전송하였습니다. 확인하여 주시길 바랍니다.");
						b_popup.close();
					}
					else
						alert("인증메일 발송 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.");
				}
			});
		}
	}
});
</script>

<!-- contents -->
<div class="subCon hidden">
	<h1 class="page-header">이메일 인증</h1>
	<form name="userSignForm" onsubmit="return false;">
		<table class="w100">
			<colgroup>
				<col width="25%">
				<col width="75%">
			</colgroup>
			<tr>
				<td>이메일주소<span class="required">*</span></td>
				<td><span class="txt_pw"><input name="sch_usr_eml_addr" id="sch_usr_eml_addr" class="text w100" type="text" value="" placeholder="이메일 주소를 입력하세요."></span></td>
			</tr>
			<tr>
				<td>아이디<span class="required">*</span></td>
				<td><span class="txt_pw"><input name="sch_lgn_id" id="sch_lgn_id" class="text w100" type="text" value="" placeholder="아이디를 입력하세요." maxlength="15"></span></td>
			</tr>
			<tr>
				<td>비밀번호<span class="required">*</span></td>
				<td><span class="txt_pw"><input name="sch_lgn_pwd" id="sch_lgn_pwd" class="text w100" type="password" value="" placeholder="비밀번호를 입력하세요." maxlength="20" autocomplete="off"></span></td>
			</tr>
		</table>
	</form>
	<br>
	<!--// button -->
	<div class="buttons" style="text-align: center">
		<div style="display: inline-block;">
			<button class="btn-small btn-primary" id="changeButton" style="display:inline-block;">인증</button>
			<button class="btn-small btn-danger" id="cancelButton" style="display:inline-block;">취소</button>
		</div>
	</div>
</div>
<!-- // contents -->


<%@ include file="/WEB-INF/views/pandora3/common/include/pop_footer.jsp" %>
