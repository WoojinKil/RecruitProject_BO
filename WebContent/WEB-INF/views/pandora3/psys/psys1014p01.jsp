<%-- 
   1. 파일명 : psys1014
   2. 파일설명: BO정보 변경비밀번호 확인창
   3. 작성일 : 2018-04-11
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->

<script>

$(document).ready(function(){
	
	var b_popup=window.parent.b_popup //부모창 b_popup 변수 가져오기 
    
	$("#cancelButton").click(function(){
		b_popup.close();
	});
	
	$("#changeButton").click(function(){
    	
        if($("#curr_pwd").val() == "")
        {
			alert("현재 비밀번호를 입력해 주세요");
			$("#curr_pwd").focus();
			return;
        }
		
		jQuery.ajax({
			url		: _context + "/psys/getPsys1014p01ChkLgnPw.do",
			type	: "POST",
			data	: {lgn_pwd : $("#curr_pwd").val()},
			dataType: 'json',
			async	: false,
			success	: function(data){
				if(data.RESULT == _boolean_success)
				{
					parent.adminInfoTab();
					b_popup.close();
				}
				else
				{
					alert('비밀번호가 틀렸습니다.');
				}
			}
        }); 
    });
    
});
</script>

		<!-- contents -->
		<div class="subCon hidden framePopWrap">
			<button type="button" class="framePopWrap popClose" onclick="framePopClose(this)"><img src="${pageContext.request.contextPath}/resources/pandora3/images/img-pop-close.png" alt="팝업 닫기"/> 닫기</button>
			<h1>비밀번호 확인</h1>
	 		<table class="w100">   
	             <colgroup>
	             	<col width="25%">
	             	<col width="75%">
	             </colgroup>
	            <tr>
	                <td>비밀번호 </td>
	                <td>
	                   <span class="txt_pw"><input type="password" id="curr_pwd" class="text w100" onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);"></span>
	                </td> 
	            </tr>
			</table>
		    <div class="buttons" style="text-align: center">
			     <div style="display: inline-block;">
                 	<button class="btn-small btn-primary" id="changeButton" style="display: inline-block;">확인</button>
			     	<button class="btn-small btn-danger" id="cancelButton" style="display: inline-block;">취소</button>
			   	</div>
           	</div>
			
			
		<!-- // contents -->
	</div>


