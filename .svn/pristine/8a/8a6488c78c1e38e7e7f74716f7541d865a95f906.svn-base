<%-- 
   1. 파일명 : psys1012
   2. 파일설명 : BO비밀번호 변경
   3. 작성일 : 2018-04-10
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3Front/js/common/jquery.bpopup.min.js"></script>
<script>

$(document).ready(function() {
	var b_popup = window.parent.b_popup; // 부모창 b_popup 변수 가져오기 
	
    $("#cancelButton").click(function(){
		b_popup.close();
	});
	
	$("#changeButton").click(function(){

		if ($("#curr_pwd").val() == "")
		{
			alert("현재 비밀번호를 입력해 주세요.");
			$("#curr_pwd").focus();
			return;
		}
				
		if ($("#new_pwd").val() == "") {
			alert("새 비밀번호를 입력해 주세요.");
			$("#new_pwd").focus();
			return;
		}
		
		if(!chkPwd($("#new_pwd").val())){
			$("#new_pwd").focus();
			return;
		}
		
		if ($("#new_pwd_cfm").val() == "") {
			alert("새 비밀번호 확인을 입력해 주세요.");
			$("#new_pwd_cfm").focus();
			return;
		}
		
		if ($("#new_pwd").val() != $("#new_pwd_cfm").val()) {
			alert("비밀번호 확인이 일치하지 않습니다");
			$("#new_pwd_cfm").focus();
			return;
		}
		
		if ($("#new_pwd").val().length > 20 || $("#new_pwd").val().length < 6) {
			alert("비밀번호는 6자이상 20자이하로 입력해 주세요");
			$("#new_pwd").focus();
			return;
		}
        
        jQuery.ajax({
			url		: _context + "/psys/updatePsys1012.do",
			type	: "POST",
			data	: {new_pwd : $("#new_pwd").val(), curr_pwd : $("#curr_pwd").val()},
			dataType: 'json',
			async	: false,
			success	: function(data){
				if(data.RESULT == _boolean_success)
				{
					alert("비밀번호가 변경되었습니다.");
					b_popup.close();
				}
				else if(data.RESULT == 'P1')
				{
					alert("현재 사용중인 비밀번호가 일치하지 않습니다.");   
				}
				else if(data.RESULT == 'P2')
				{
					alert("현재사용중인 비밀번호와 새 비밀번호가 동일합니다."); 	
				}
				else
				{
					alert("비밀번호 변경작업이 정상적으로 처리되지 않았습니다.");
				}
			}
		});
	});
});
</script>

<!-- contents -->
<div class="subCon hidden framePopWrap">
	<h1>비밀번호 변경</h1>
	<table class="w100">
		<colgroup>
			<col width="25%">
			<col width="75%">
		</colgroup>
		<tr>
			<td>현재 비밀번호</td>
			<td><span class="txt_pw"><input type="password" id="curr_pwd" class="text w100" onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);"></span></td>
		</tr>
		<tr>
			<td>새 비밀번호</td>
			<td>
				<span class="txt_pw">
					<input type="password" id="new_pwd" class="text w100" onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);">
				</span>
				<!--
					<p>비밀번호는 6~20자로 되어야 합니다.</p>
					<p>현재 사용하는 비밀번호와는 반드시 다른 비밀번호를 입력해 주세요.</p>
				-->
			</td>
		</tr>
		<tr>
			<td>새 비밀번호 확인</td>
			<td>
				<span class="txt_pw"><input type="password" id="new_pwd_cfm" class="text w100" onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);"></span>
			</td>
		</tr>
	</table>
	<br>
	<div class="buttons" style="text-align: center">
		<div style="display: inline-block;">
			<button class="btn-small btn-primary" id="changeButton" style="display: inline-block;">변경</button>
			<button class="btn-small btn-danger" id="cancelButton" style="display: inline-block;">취소</button>
		</div>
	</div>
</div>
<!-- // contents -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_footer.jsp" %>
