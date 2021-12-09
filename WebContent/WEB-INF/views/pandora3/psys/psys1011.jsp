<%-- 
   1. 파일명 : psys1011
   2. 파일설명 : BO비밀번호 찾기
   3. 작성일 : 2018-03-28
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3Front/js/common/jquery.bpopup.min.js"></script>
<script>

$(document).ready(function(){
	var b_popup=window.parent.b_popup // 부모창 b_popup 변수 가져오기
	
	$("#cancelButton").click(function(){
		b_popup.close();
	});
    
	$("#changeButton").click(function(){

		if(fn_validationCheck())
		{
			jQuery.ajax({
				url		: _context + "/psys/updatePsys1011.do",
				type	: "POST",
				data	: {usr_eml_addr : $("#sch_usr_eml_addr").val(), lgn_id : $("#sch_lgn_id").val()},
				dataType: 'json',
				async	: false,
				success	: function(data){
	            	if(data.RESULT == "S")
	            	{
	            		alert("귀하의 메일로 임시 비밀번호를 발송했습니다.");
	            		b_popup.close();
	            	}
	            	else if(data.RESULT == "F")
	            	{
	            		var msg = "임시비밀번호 발급 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.";
	            		
	            		if(isNotEmpty(data.MSG))
	            			msg = data.MSG;
	            		
	            		alert(msg);
	            	}
	            }
	        }); 
		}

    });
	
	
	// 입력값 유효성/필수 체크
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
    		alert("로그인ID를 입력 해주세요.");
    		$("#sch_lgn_id").focus();
    		return false;
    	}
    	return true;
    }

});
</script>

<!-- contents -->
<div class="subCon hidden framePopWrap">
	<button type="button" class="framePopWrap popClose" onclick="framePopClose(this)">
		<img src="${pageContext.request.contextPath}/resources/pandora3/images/img-pop-close.png" alt="팝업 닫기" />닫기
	</button>
	<h1 class="page-header">비밀번호 찾기</h1>
	<form name="form_search" onsubmit="return false;">
		<table class="w100">
			<colgroup>
				<col width="25%">
				<col width="75%">
			</colgroup>
			<tr>
				<td>이메일주소<span class="required">*</span></td>
				<td><span class="txt_pw"><input name="usr_eml_addr" id="sch_usr_eml_addr" class="text w100" type="text" value="" placeholder="이메일 주소를 입력하세요."></span></td>
			</tr>
			<tr>
				<td>아이디<span class="required">*</span></td>
				<td><span class="txt_pw"><input name="lgn_id" id="sch_lgn_id" class="text w100" type="text" value="" placeholder="로그인ID를 입력하세요." maxlength="15"></span></td>
			</tr>
		</table>
	</form>
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
