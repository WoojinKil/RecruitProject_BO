<%-- 
   1. 파일명 : psys1030p001
   2. 파일설명 : 권한 검색 팝업
   3. 작성일 : 2018-03-27
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_header.jsp" %>
<script type="text/javascript">
var rol_grid;
$(document).ready(function() {
	var rol_config = { 
		gridid		: 'rol_grid',
		pagerid		: 'rol_grid_pager',
        columns		: [
			{name : 'GRP_ROL_ID', label : '권한ID', editable : false, align : 'center', sorttype : 'int', hidden:true},
			{name : 'GRP_ROL_NM', label : '권한명', editable : false, align : 'left', required : true, edittype : 'text', width : 200, editoptions : {maxlength:300}},
			{name : 'US_YN', label : '사용여부', align : 'center', editable : false, edittype : 'select', formatter : 'select', editoptions : {value:'Y:사용;N:미사용'}, width : 80, required : true},
			{name : 'F_APL_ST_DT', label : '적용시작일자', align : 'center', editable : false, width : 120, required : true}, 
			{name : 'F_APL_ED_DT', label : '적용종료일자', align : 'center', editable : false, width : 120, required : true},
			{name : 'F_UPD_DTTM', label : '변경일자', align : 'center', editable : false, width : 100},
		],
		editmode	:  false,							// 그리드 editable 여부
		gridtitle	: '권한 목록',							// 그리드명
		multiselect	:  false,							// checkbox 여부
		formid		: 'search',							// 조회조건 form id
		height		: 150,								// 그리드 높이
		selecturl	: '/psys/getPsys1031p001List',      // 그리드 조회 URL
		events      : {
			
			ondblClickRow: function (event, rowid, irow, icol) {
				
				var row = rol_grid.getRowData(rowid);
				
			    //호출된 iframe id 획득
		        var iframeId = '#tab-' + '<%= parameterMap.getValue("target_id") %>';

		        //ifram 객체 획득
		        var $frame = parent.$(iframeId)[0];
		        
		        //ifram 접근
		        var gocoderFrameGo = $frame.contentWindow || $frame.contentDocument ;
		        
		        //callback 함수 실행
		        gocoderFrameGo.<%= parameterMap.getValue("callback") %>(row);
		        
		        parent.$('.layer_popup').bPopup().close();
		        
			},
		}
	};
	rol_grid = new UxGrid(rol_config);
	rol_grid.init();
	rol_grid.setGridWidth($('.tblType1').width());
    
	// 조회버튼 클릭 시
	$("#btn_retreive").click(function() {
		rol_grid.retreive();
	});
	

    $("#btn_close").click(function() {
    	parent.$('.layer_popup').bPopup().close();
    });    
	
    $("#btn_select").click(function() {
        var rowId = rol_grid.getSelectRowIDs(); // multiselect가 false 이면 단건 조회
        
        if(isEmpty(rowId)) {
        	alert("권한을 선택해 주세요.");
        	return false;
        }
        
        var row = rol_grid.getRowData(rowId);
        
        //호출된 iframe id 획득
        var iframeId = '#tab-' + '<%= parameterMap.getValue("target_id") %>';

        //ifram 객체 획득
        var $frame = parent.$(iframeId)[0];
        
        //ifram 접근
        var gocoderFrameGo = $frame.contentWindow || $frame.contentDocument ;
        
        //callback 함수 실행
        gocoderFrameGo.<%= parameterMap.getValue("callback") %>(row);
        
        parent.$('.layer_popup').bPopup().close();
        
    });
});

$(window).resize(function() {
	rol_grid.setGridWidth($('.tblType1').width());
});
</script>
</head>
<body id="pop">
	<div class="frameWrap">
		<div class="subCon">
			<h1><%=_title %></h1>
			<div class="subConIn">
				<div class="subConScroll">
					<!-- 조회조건 -->
					<form name="search" id="search" name="search" onsubmit="return false">
					    <input type="hidden" name="us_yn" value="Y" />
						<div class="frameTopTable">
							<table class="tblType1">
								<colgroup>
									<col width="85px;" />
									<col width="" />
								</colgroup>
								<tr>
									<th>권한명</th>
									<td>
										<span class="txt_pw"><input type="text" name="grp_rol_nm" id="grp_rol_nm" class="text w100" style="" maxlength="100" /></span>
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
					<!-- 조회조건  // -->
					<!-- Grid -->
					<table id="rol_grid"></table>
					<div id="rol_grid_pager"></div>
					<!-- Grid // -->
				</div>
			</div>
			<div class="grid_btn">
			    <button type="button" class="btn_common btn_gray" id="btn_select" name="btn_select">선택</button>
				<button type="button" class="btn_common btn_gray" id="btn_close" name="btn_close">닫기</button>
			</div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_footer.jsp" %>
