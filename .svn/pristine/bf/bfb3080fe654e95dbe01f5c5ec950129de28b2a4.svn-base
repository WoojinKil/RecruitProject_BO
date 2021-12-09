<%-- 
   1. 파일명 : comPopupPreview
   2. 파일설명 : 공통팝업미리보기
   3. 작성일 : 2019-02-08
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_header.jsp" %>
<script type="text/javascript">
var menu_id = '<%=parameterMap.getValue("_menu_id")%>';
var comPopup_grid;

$(document).ready(function(){
	
	var popupNm   = $("#popup_nm"  , opener.document).val();
	var popupId   = $("#popup_id"  , opener.document).val();
	var popupDesc = $("#popup_desc", opener.document).val();
	$("#popup_id").val(popupId);
	$("#popup_nm").html(popupNm);
	$("#popup_desc").html(popupDesc);
	
	// 조건콤보 생성
	var searchCombo = $("#sch_box", opener.document).val();
	var decodeSearchCombo = removeScript(decodeURIComponent(searchCombo));
	$("#searchCombo").html(decodeSearchCombo);
	
	// 동적 그리드 생성
	var grd_conf = decodeURIComponent($("#grd_conf", opener.document).val());
	//grd_conf = grd_conf.replace(/&#34;/gi,'\"');
	
	var comPopup_config       = JSON.parse(grd_conf);
	comPopup_config.gridid    = "comPopup_grid";
	comPopup_config.pagerid   = "comPopup_grid_pager";
	comPopup_config.editmode  = false;
	comPopup_config.formid    = "comPopupSearch";
	comPopup_config.height    = 150;
	comPopup_config.selecturl = "/main/selectCommonPopupList";
	
	comPopup_grid = new UxGrid(comPopup_config);
	comPopup_grid.init();
	comPopup_grid.setGridWidth($('.tblType1').width());
	
	// 조회 버튼 클릭 시 이벤트 발생
	$("#btn_retreive").click(function() {
		comPopup_grid.retreive(); 
    });
	
	// 로딩 되자마자 조회
    $("#btn_retreive").trigger("click");
	
});

// grid resizing
$(window).resize(function(){
	comPopup_grid.setGridWidth($('.tblType1').width());
});

</script>
</head>
<body id="pop">
	<div class="frameWrap">
	    <div class="subCon">
	        <h1 id="popup_nm"></h1>
	        <div class="subConIn">
	        	<div class="subConScroll">
	        		<p id="popup_desc"></p>
			        <form name="search" id="comPopupSearch" name="comPopupSearch" onsubmit="return false"  style="margin-top:10px;margin-bottom:10px;">
			        	<input type="hidden" id="leaf_menu_yn" name="leaf_menu_yn" value="Y"/>
			        	<input type="hidden" name="popup_id" id="popup_id" value=""/>
			        	<div class="frameTopTable">
							<table class="tblType1">   
				         		<!-- <colgroup>
									<col width="10%" />
									<col width="27%" />
									<col width="15%" />
									<col width="28%" />
									<col width="20%" />
								</colgroup>  -->  
								<colgroup>
									<col width="85px;">
									<col width="">
								</colgroup>
				          		<tr>
				              		<th id="searchCombo"></th>
					              	<td>
					                 	<span class="txt_pw"> <input type="text" name="searchValue" id="searchValue" class="text" style="width:100%;" value="<%=parameterMap.getValue("searchValue")%>" /></span>
					              	</td> 
				              		<!-- <td>
				               			<div class="grid_btn">
				              				<button class="btn_common btn_default" id="btn_retreive">조회</button>
				              			</div>
				              		</td> -->
				          		</tr>
				         	</table>
			        	</div>
			        	<div class="btnWrap">
							<button type="button" class="btn_common btn_gray" id="btn_retreive">조회</button>
						</div>
			       </form>
			       <!-- search // -->
			
			       <!-- Grid -->
			       <table id="comPopup_grid"></table> 
			       <div id="comPopup_grid_pager"></div>
			       <!-- Grid // -->    
	        	</div>
	        </div>
	    </div>
	</div>
</body>
