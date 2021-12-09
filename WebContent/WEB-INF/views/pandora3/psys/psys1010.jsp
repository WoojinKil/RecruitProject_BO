<%-- 
   1. 파일명 : psys1009
   2. 파일설명: BO아이디 찾기
   3. 작성일 : 2018-03-28
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3Front/js/common/jquery.bpopup.min.js"></script>
<script>
$(document).ready(function() {
	
	var b_popup=window.parent.b_popup // 부모창 b_popup 변수 가져오기
    $("#cancelButton").click(function(){
        b_popup.close();
    });
	$("#rebutton #cancelButton").click(function(){
		b_popup.close();
	})
	
	$("#refindButton").click(function(){
		$("#form_search").reset();
		$("#div_search").show();
		$("#div_result").hide();
	})
	
	$("#changeButton").click(function(){

		if(fn_validationCheck())
		{
			jQuery.ajax({
				url		: _context + "/psys/getPsys1010LgnId",
				type	: "POST",
				data	: {usr_eml_addr : $("#sch_usr_eml_addr").val(), usr_nm : $("#sch_usr_nm").val()},
				dataType: 'json',
				async	: false,
				success	: function(data){
					
					$("#div_search").hide();
					$("#div_result").show();
					$("#rebutton").show();	
					
					if(data.lgnId.length > 0)
						$("#div_result .txt_pw p").text("아이디 : " + data.lgnId);
					else
						$("#div_result .txt_pw p").text("일치하신 결과값이 없습니다.");
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
		if($("#sch_usr_nm").val().length < 2)
		{
    		alert("이름을 입력 해주세요.");
    		$("#sch_usr_nm").focus();
    		return false;
    	}
    	return true;
    }

   
});
</script>
<!-- contents -->
<div class="subCon hidden framePopWrap">
	<button type="button" class="framePopWrap popClose" onclick="framePopClose(this)">
		<img src="${pageContext.request.contextPath}/resources/pandora3/images/img-pop-close.png" alt="팝업 닫기" />
		닫기
	</button>
	<h1 class="page-header">아이디 찾기</h1>
	<div id="div_search">
		<form id="form_search" name="form_search" onsubmit="return false;">
			<table class="w100">
				<colgroup>
					<col width="25%">
					<col width="75%">
				</colgroup>
				<tr>
					<th>이메일주소<span class="required">*</span></th>
					<td><span class="txt_pw"><input name="usr_eml_addr" id="sch_usr_eml_addr" class="text w100" type="text" value="" placeholder="이메일 주소를 입력하세요."></span></td>
				</tr>
				<tr>
					<th>이름<span class="required">*</span></th>
					<td><span class="txt_pw"><input name="usr_nm" id="sch_usr_nm" class="text w100" type="text" value="" placeholder="이름을 입력하세요."maxlength="15"></span></td>
				</tr>
			</table>
		</form>

		<!-- button -->
		<div class="buttons" style="text-align: center">
			<div style="display: inline-block;">
				<button class="btn-small btn-primary" id="changeButton" style="display: inline-block;">찾기</button>
				<button class="btn-small btn-danger" id="cancelButton" style="display: inline-block;">취소</button>
			</div>
		</div>
		<!-- // button -->
	</div>

	<div id="div_result" sytle="display:none">
		<span class="txt_pw" style="text-align: center">
			<p align="center"></p>
		</span>
		<div id="rebutton" class="buttons" style="text-align: center; display: none">
			<div style="display: inline-block;">
				<button class="btn-small btn-primary" id="refindButton" style="display: inline-block;">다시 찾기</button>
				<button class="btn-small btn-danger" id="cancelButton" style="display: inline-block;">취소</button>
			</div>
		</div>
	</div>
</div>
<br>
<!-- // contents -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_footer.jsp" %>
