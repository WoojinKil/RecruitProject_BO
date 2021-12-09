<%--
   1. 파일명   : pdsp1011
   2. 파일설명 : 시스템 관리
   3. 작성일   : 2018-04-17
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var menu_id = '<%=parameterMap.getValue("_menu_id")%>';
var pvcont_grid;

$(document).ready(function(){
	var pvcont_config = {
		// grid id
		gridid: 'pvcont_grid',
		pagerid: 'pvcont_grid_pager',
		gridBtnYn : 'Y',
		// column info
		columns:[
                 {name:'SYS_CD', width:50, label:'시스템 번호', align:'center', editable:false, sortable : false},
				 {name:'STATUS', label:'상태', align:'center', editable:false, width:20},
			     {name:'SYS_NM', width:150, label:'시스템 명', align:'left', editable:true, required:true, editoptions:{maxlength:50}, sortable : false},
				 {name:'SYS_PTH', width:70, label:'시스템 PATH', align:'left', editable:true, editoptions:{maxlength:100}, sortable : false},
				 {name:'SYS_URL', label:'시스템 URL', align:'left', editable:true, editoptions:{maxlength:500}, sortable : false},
			     {name:'SRT_SEQ', width:50,label:'정렬순서', editable:true},
				 {name:'US_YN', width:50, label:'사용유무', align:'center', editable:true, edittype:'select', formatter:'select', editoptions:{value:'Y:사용;N:미사용'}, required:true, sortable : false},
				 {name:'DSPLY_YN', width:70, label:'화면출력여부', align:'center', editable:true, edittype:'select', formatter:'select', editoptions:{value:'Y:사용;N:미사용'}, required:true, sortable : false},
				 {name:'ROL_YN', width:70, label:'권한사용여부', align:'center', editable:true, edittype:'select', formatter:'select', editoptions:{value:'Y:사용;N:미사용'}, required:true, sortable : false},
				 {name:'SYS_DESC', width:210, label:'사이트설명내용', align:'center',  editable:true, editoptions:{maxlength:500}, sortable : false},
				 {name:'SYS_ABRV', width:70, label:'약어명', align:'left', editable:true, required:true, editoptions:{maxlength:100}, sortable : false},
				 {name:'F_CRT_DTTM', width:100, label:'작성일시', align:'center', editable:false, sortable : false}
		],
		editmode: true,                   // 그리드 editable 여부
		gridtitle: '사이트 목록',             // 그리드명
		multiselect: true,                // checkbox 여부
		formid: 'search',                 // 조회조건 form id
		shrinkToFit: true,                // 컬럼 width 자동조정
		autowidth: true,
		height: 530,                      // 그리드 높이
		cellEdit:false,
		loadonce:true,
		selecturl: '/pdsp/getPdsp1011List',   // 그리드 조회 URL
		saveurl: '/pdsp/savePdsp1011',    // 그리드 입력/수정/삭제 URL
	};
	pvcont_grid = new UxGrid(pvcont_config);
	pvcont_grid.init();
	pvcont_grid.setGridWidth($('.tblType1').width());

});


//조회: 내부 로직 사용자 정의
function fn_Search(){
	// 페이징이 1page를 초과할 시 초기화
	if($("#pvcont_grid").jqGrid('getGridParam', 'page') > 1) $("#pvcont_grid").jqGrid('setGridParam', {'page' : 1});
	pvcont_grid.retreive();
}

//추가: 내부 로직 사용자 정의
function fn_AddRow(){
	pvcont_grid.add();
}

//저장: 내부 로직 사용자 정의
function fn_Save(){
	pvcont_grid.save();
}

//삭제: 내부 로직 사용자 정의
function fn_DelRow(){
	pvcont_grid.remove();
}

//엑셀다운로드: 내부 로직 사용자 정의
function fn_ExcelDownload(){
	var grid_id = "pvcont_grid";
	var rows = $('#pvcont_grid').jqGrid('getGridParam', 'rowNum');
	var page = $('#pvcont_grid').jqGrid('getGridParam', 'page');
	var total = $('#pvcont_grid').jqGrid('getGridParam', 'total');
	var title = $('#pvcont_grid').jqGrid('getGridParam', 'gridtitle');
	var url = "/pdsp/getPdsp1011XlsxDwld.adm";  //페이징 존재
	var param ={};
	param.page=page;
	param.rows=rows;
	param.filename ="사이트 목록";
	AdvencedExcelDownload(grid_id,url,param);
}

// grid resizing
$(window).resize(function(){
	pvcont_grid.setGridWidth($('.tblType3').width());
});
</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
		<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
			<table class="tblType1">
			</table>

			<!-- Grid -->
			<table id="pvcont_grid"></table>
			<div id="pvcont_grid_pager"></div>
			<!-- Grid // -->

		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
