<%-- 
   1. 파일명 : comPopup
   2. 파일설명 : 공통팝업
   3. 작성일 : 2019-01-29
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_header.jsp"%>
<%
	// window open popup인 경우만 meta tag include A - window open popup default, B - layer popup
	String popupType = parameterMap.getValue("popupType");
%>
<script type="text/javascript">
var menu_id = '<%=parameterMap.getValue("_menu_id")%>';
var comPopup_grid;

$(document).ready(function(){
	
	// 그리드 설정 값 조회
	var popup_id = '<%=parameterMap.getValue("popup_id")%>';
	ajax({
		url    :'/main/selectCommonPopupGrid',
		data   : {"popup_id" : popup_id},
		async  : true,
		success: function(data) {
			// 공통 팝업 셋팅
			comPopupInit(data);
		}
	});
});

// grid resizing
$(window).resize(function(){
	comPopup_grid.setGridWidth($('#comPopupTbl').width());
});

// 공통 팝업 셋팅
function comPopupInit(data) {
	// 조건콤보 생성
	var searchCombo = data.sch_box;
	$("#searchCombo").html(searchCombo);
	
	// title 생성
	$("#comPopupTitle").text(data.popup_nm);
	$("#comPopupTxt").text(data.popup_desc);
	
	// 동적 그리드 생성
	var grd_conf = data.grd_conf;
	//grd_conf = grd_conf.replace(/&#34;/gi,'\"');
	
	var comPopup_config       = JSON.parse(grd_conf);
	comPopup_config.gridid    = "comPopup_grid";
	comPopup_config.pagerid   = "comPopup_grid_pager";
	comPopup_config.editmode  = false;
	comPopup_config.formid    = "comPopupSearch";
	comPopup_config.height    = 150;
	comPopup_config.selecturl = "/main/selectCommonPopupList";
	comPopup_config.events    = {
		// 더블 클릭 이벤트			
		ondblClickRow : function(obj, irow, icol) {
			var rows             = comPopup_grid.getSelectRows();
			var callType         = "<%= parameterMap.getValue("callType")%>";
			var callbackParamVal = "<%= parameterMap.getValue("callbackParamVal") %>";
			var callbackFunc     = "<%= parameterMap.getValue("callbackFunc") %>";
			var popupType        = "<%= parameterMap.getValue("popupType") %>";
			var popupMenuId      = "<%= parameterMap.getValue("popupMenuId") %>";

			// 공통팝업 호출이 grid인 경우
			if(callType == "grid") {
				callbackParamVal = parseInt(callbackParamVal);
			}
			
			// layer popup인 경우
			if(popupType == "B") {
				//var b_popup = window.parent.b_popup //부모창 b_popup 변수 가져오기 
				var obj     = parent.document.getElementById("tab-"+ popupMenuId).contentWindow;
				eval('obj.' + callbackFunc)(rows, callbackParamVal);
				b_popup.close();
			} else { // window open popup인 경우
				eval('opener.' + callbackFunc)(rows, callbackParamVal);
		        window.close();	
			}
		}		
	}
	comPopup_grid = new UxGrid(comPopup_config);
	comPopup_grid.init();
	comPopup_grid.setGridWidth($('#comPopupTbl').width());
	
	// 조회 버튼 클릭 시 이벤트 발생
	$("#btn_retreive").click(function() {
		comPopup_grid.retreive(); 
    });
	
	// 로딩 되자마자 조회
    $("#btn_retreive").trigger("click");
}

</script>
</head>
<body>
	<div class="subCon">
		<h1 id="comPopupTitle"></h1>
		<p id="comPopupTxt"></p>
		<form name="search" id="comPopupSearch" name="comPopupSearch" onsubmit="return false" style="margin-top: 10px; margin-bottom: 10px;">
			<input type="hidden" name="popup_id" id="popup_id" value="<%=parameterMap.getValue("popup_id")%>" />
			<table class="tblType1" id="comPopupTbl">
				<colgroup>
					<col width="30%" />
					<col width="50%" />
					<col width="20%" />
				</colgroup>
				<tr>
					<th id="searchCombo"></th>
					<td>
						<span class="txt_pw">
							<input type="text" name="searchValue" id="searchValue" class="text" style="width: 100%;" value="<%=NetUtil.decode(parameterMap.getValue("searchValue"))%>" />
						</span>
					</td>
					<td>
						<div class="grid_btn">
							<button class="btn_common btn_default" id="btn_retreive">조회</button>
						</div>
					</td>
				</tr>
			</table>
		</form>
		<!-- search // -->

		<!-- Grid -->
		<table id="comPopup_grid"></table>
		<div id="comPopup_grid_pager"></div>
		<!-- Grid // -->
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_footer.jsp"%>