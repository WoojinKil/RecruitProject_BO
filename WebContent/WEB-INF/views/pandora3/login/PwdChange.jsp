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
    	
        if ($("#currentPswd").val() == "") {
            alert("현재 비밀번호를 입력해 주세요");
            $("#currentPswd").focus();
            return;
        }
        if ($("#newPswd").val() == "") {
            alert("새 비밀번호를 입력해 주세요");
            $("#newPswd").focus();
            return;
        }
        if ($("#confirmPswd").val() == "") {
            alert("새 비밀번호 확인를 입력해 주세요");
            $("#confirmPswd").focus();
            return;
        }
        
        if ($("#newPswd").val() != $("#confirmPswd").val()) {
            alert("비밀번호 확인이 일치하지 않습니다");
            $("#confirmPswd").focus();
            return;
        }
        
        if ($("#newPswd").val().length > 20 || $("#newPswd").val().length < 6) {
        	alert("비밀번호는 6자이상 20자이하로 입력해 주세요");
        	$("#newPswd").focus();
            return;
        }
        
        jQuery.ajax({
            url: _context + "/system/PwdChangeProcess.do",
            type: "POST",
            data: {passwd : $("#newPswd").val(), certKey : $("#certKey").val(), oldwd : $("#currentPswd").val()},
            dataType:'json',
            async:false,
            success: function(data){
               if (data.RESULT == _boolean_success) {
                	alert("비밀번호가 변경되었습니다");
                	   b_popup.close();
               }
               else if (data.RESULT == 'P1') {
                   alert("현재 사용중인 비밀번호가 일치하지 않습니다");   
               }
               else if (data.RESULT == 'P2') {
                   alert("현재사용중인 비밀번호와 새 비밀번호가 동일합니다"); 	
               }
               else {
                   alert('비밀번호가 변경작업이 정상적으로 처리되지 않았습니다');
               }
            }
        }); 
    });
    
});
</script>

	
	
		<!-- contents -->
		<div class="subCon">
			<h1>비밀번호 변경</h1>
	 		<table class="w100">   
             <colgroup>
             	<col width="25%">
             	<col width="75%">
             </colgroup>
            <tr>
                <td>현재 비밀번호 </td>
                <td>
                   <span class="txt_pw"><input type="password" id="currentPswd" class="text w100"></span>
                </td> 
            </tr>
            <tr>
                <td>새 비밀번호</td>
                <td>
                    <span class="txt_pw"><input type="password" id="newPswd" class="text w100"></span>
                <!-- 	<p>비밀번호는 6~20자로 되어야 합니다.</p>
					<p>현재 사용하는 비밀번호와는 반드시 다른 비밀번호를 입력해 주세요.</p>		 -->	
                </td>
             </tr>
             <tr>
                <td>새 비밀번호 확인</td>
                <td> <span class="txt_pw"><input type="password" id="confirmPswd" class="text w100"></span></td>
             
            </tr>
      
			</table>	
			<br>
			     <div class="buttons" style="text-align: center">
			     <div style="display: inline-block;">
                 	<button class="btn-small btn-primary" id="changeButton" style="display: inline-block;">변경</button>
			     	<button class="btn-small btn-danger" id="cancelButton" style="display: inline-block;">취소</button>
			   	</div>
            	</div>
			
			
		<!-- // contents -->
	</div>

<%@ include file="/WEB-INF/views/pandora3/common/include/pop_footer.jsp" %>
