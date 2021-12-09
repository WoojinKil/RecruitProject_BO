<%-- 
   1. 파일명 : psys1034p001
   2. 파일설명 : 반려사유 조회
   3. 작성일 : 2018-04-27
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>
<script type="text/javascript">



$(document).ready(function(){
	
	
	
	$("#btn_select").on("click", function () {
		
		//직접 입력 시 
		if($("#apvl_rfs_rsn_cd").val() == "10" ) {
			if($("#apvl_rfs_rsn").val().trim().length < 10 ) {
				alert("반려 사유를 10자 이상 입력해주세요.")
				return false;
			}
			$("#apvl_rfs_rsn_cont").val($("#apvl_rfs_rsn").val());
		} else {
			$("#apvl_rfs_rsn_cont").val($("#apvl_rfs_rsn_cd option:selected").text());
		}
		
		//호출된 iframe id 획득
		var iframeId = '#tab-' + '<%= parameterMap.getValue("target_id") %>';
		
		//ifram 객체 획득
		var $frame = parent.$(iframeId)[0];
		
		//ifram 접근
		var gocoderFrameGo = $frame.contentWindow || $frame.contentDocument ;
		
		//callback 함수 실행
		gocoderFrameGo.<%= parameterMap.getValue("callback") %>($("#apvl_rfs_rsn_cont").val());
		
		parent.$('.layer_popup').bPopup().close();
		
	});
		
	$("#apvl_rfs_rsn_cd").on("change", function () {
		
		// 직접 입력 시 
		if($(this).val() == "10") {
			$("#apvl_rfs_rsn").attr( 'disabled', false );
		} else {
			$("#apvl_rfs_rsn").val("");
			$("#apvl_rfs_rsn").attr( 'disabled', true );
		}
	})
	
	// 닫기버튼 클릭 시
	$(".btn_layer_close").click(function() {
		parent.$('.layer_popup').bPopup().close();
	}); 
	

});

//grid resizing
$(window).resize(function() {
	menu_grid.setGridWidth($('.tblType1').width());
});

</script>
</head>
<body id="pop">
	<div class="frameWrap">
		<div class="subCon">
			<h1><%=_title %></h1>
			<div class="subConIn">
				<div class="subConScroll">
				  <%--   
					반려 사유 : <%=CodeUtil.getSelectComboList("GVBK_RSN_CD","apvl_rfs_rsn_cd") %>
					직접 입력 : <textarea rows="20" cols="30" name="apvl_rfs_rsn" id="apvl_rfs_rsn"></textarea> --%>
					<form name="search" id="search" onsubmit="return false">
						<input type="hidden" name="apvl_rfs_rsn_cont" id="apvl_rfs_rsn_cont" />
						<div class="frameTopTable">
							<table class="tblType1">
								<colgroup>
									<col width="85px;">
									<col width="">
								</colgroup>
								<tbody>
									<tr>
										<th>반려 사유 : </th>
										<td>
											<span class="txt_pw"><%=CodeUtil.getSelectComboList("GVBK_RSN_CD","apvl_rfs_rsn_cd") %></span>
										</td>
									</tr>
									<tr>
										<th>직접 입력 : </th>
										<td> 
											<textarea rows="8" cols="30" name="apvl_rfs_rsn" id="apvl_rfs_rsn" class="w100 pop_textarea"></textarea>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="grid_btn">
			<button type="button" class="btn_common btn_black" id="btn_select" name="btn_select">선택</button>
			<button type="button" class="btn_layer_close btn_common btn_gray" name="btn_close">닫기</button>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>
