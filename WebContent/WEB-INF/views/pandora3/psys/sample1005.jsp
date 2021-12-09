<%-- 
   1. 파일명   : sample1005
   2. 파일설명 : 데이터 별 그리드 샘플
   3. 작성일   : 2018-07-15
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>




<script type="text/javascript">
var role_grid;
// 한글 입력 방지

// 달력
function fn_datePicker(e,row) {
	
	$(e).daterangepicker({
		linkedCalendars: false,			//캘린더 날짜 분리
		showDropdowns: true,				//날짜 선택번튼
		singleDatePicker : true,
		viewModel : 'day',
		autoUpdateInput : true
	});
	
	  
}

function fn_datePicker2(e,row) {
	
	$(e).datepicker({dateFormat:'yy-mm-dd', changeYear : true, changeMonth : true});
	
}

$(document).ready(function(){
	
	    var sample_grid_config = {
    		gridid		: 'sample_grid',
    		pagerid		: 'sample_grid_pager',
    		gridBtnYn : 'Y',				// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
	    	columns		: [
	    		{name : 'SAMPLE_TEXT2', label : 'TEXT', editable : true},
	    		{name : 'SAMPLE_AREA', label : 'TEXT AREA', editable : true, edittype : 'textarea'},
	    		{name : 'SAMPLE_DATE1', label : 'DATE PICKER1', editable : true, editoptions : {dataInit : fn_datePicker}},
	    		{name : 'SAMPLE_DATE2', label : 'DATE PICKER2', editable : true, editoptions : {dataInit : fn_datePicker2}},
	    		{name : 'SELECT BOX', label : 'SELECT BOX', align:'center', editable : true, edittype : 'select', formatter : 'select', editoptions : {value:'Y:사용;N:미사용'}},
	    		{name : 'SELECT BOX2', label : 'SELECT BOX2', align:'center', editable : true, edittype : 'select', formatter : 'select', editoptions : {value:'<%=CodeUtil.getGridComboList("MSTS")%>'}},
	    		{name : 'CHECKBOX1', label : 'CHECKBOX1', align:'center',  formatter: function(cellValue, option){return "<input type='checkbox' name='sample_checkbox' /> <input type='checkbox' name='sample_checkbox' />"; }},
	    		{name : 'CHECKBOX2', label : 'CHECKBOX2', align:'center',  formatter: function(cellValue, option){return "<input type='checkbox' name='sample_checkbox' />"; }},
	    		{name : 'RADIO1', label : 'RADIO1', align:'center',  formatter: function (cellValue, option) { return "<input type='text' placeholder = 'aaa' name='sample_radio' />"; }, },
	    		{name : 'RADIO2', label : 'RADIO2', align:'center',  formatter: function (cellValue, option) { return "<input type='radio' name='sample_radio' />"; }, },
	    		
	    	],
	    	initval		: {CHECKBOX1:'Y', CHECKBOX2:'N'},			// 그리드 추가 시 초기 값.
	    	editmode	: true,										// 그리드 editable 여부
			gridtitle	: '타입별 그리2드',									// 그리드명
			multiselect	: true,										// checkbox 여부
			height		: 680,										// 그리드 높이
	        shrinkToFit	: true,										// true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
	        selecturl	: '',										// 그리드 조회 URL
	        saveurl		: '',										// 그리드 입력/수정/삭제 URL
	        rownumbers  : false,									// 그리드 로우 넘버 표시 여부
	    	events 		: {
	    		
	    		onCellSelect: function(event, rowIdx, colIdx, value){ // 셀클릭 시 콜백
					
	            	// 추가된 row만 edit 가능하게 셋팅
	            	var row = $('#sample_grid').getRowData(rowIdx);
					//console.log(row);
	            	
				}
	    		
	    		
	    	}
	    		
	    		
	    }
	    
	    sample_grid = new UxGrid(sample_grid_config);
	    sample_grid.init();
	    sample_grid.setGridWidth($('.tblType1').width());
	    
	    $("#cal").daterangepicker({
			linkedCalendars: false,			//캘린더 날짜 분리
			showDropdowns: true,				//날짜 선택번튼
			timePicker: true,
			singleDatePicker : false,
			viewModel : 'day',
			drops : 'up',
			autoUpdateInput: false
		});
	    
	
});

function fn_AddRow() {
		
	sample_grid.add();
}

</script>
</head>
<body id="app">
	<div class="frameWrap">
	    <div class="subCon">
	    	<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
	            
	        <table id="sample_grid"></table> 
	        <div id="sample_grid_pager"></div>
	        
	    </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
