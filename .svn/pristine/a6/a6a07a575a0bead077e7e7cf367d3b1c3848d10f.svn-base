<%-- 
   1. 파일명 : bpcm3001p001
   2. 파일설명 : 요약정보 팝업
   3. 작성일 : 2019-10-10
   4. 작성자 : 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_header.jsp" %>
<script type="text/javascript">
var menu_grid;

$(document).ready(function() {
 	// 닫기버튼 클릭 시
	$("#btn_close").click(function() {
		parent.$('.layer_popup').bPopup().close();
	}); 
 	
	fn_getEvtInfo();
	
 });


//사은행사 유형 콤보 조회하기
function fn_getEvtInfo(){
	var html = "";
		
	ajax({
		url 	: "/bpcm/getEvntDtl",
		data    : { THKU_EVNT_NO : <%= parameterMap.getValue("thku_evnt_no") %> },
		success : function (data) {
			if (data.RESULT == "S") {
				html += "<textarea readonly='readonly' style='width:100% ; height:260px; overflow:auto;'>"+data.rows[0].EVNT_SMRY_2_INFO+"</textarea>"
				$(".subConScroll").append(html);
			}
		}
	});
}
</script>
</head>
<body id="pop">
	<div class="frameWrap">
		<div class="subCon">
			<h1>사은행사 요약정보</h1>
			<div class="subConIn" >
				<div class="subConScroll">	 									
					
				</div>		
			</div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_footer.jsp" %>
