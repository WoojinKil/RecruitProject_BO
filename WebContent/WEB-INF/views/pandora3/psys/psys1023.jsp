<%-- 
   1. 파일명 : psys1023
   2. 파일설명 : 약관이력
   3. 작성일 : 2018-04-26
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">

var term_grid;
var term_editor;

$(document).ready(function(){
	
	$("#ds_mst_cd").val('MBR0002');
	$("#tp_mst_cd").val('MBR0001');
	
	var grid_config = { 
		gridid	: 'term_grid',
		pagerid	: '',
		columns	: [
			{name : 'CLU_SEQ', label : '약관순번', hidden : true},
			{name : 'CLU_CTS', label : '약관내용', hidden : true},
			{name : 'CLU_TP_CD', label : '약관구분코드', hidden : true},						// MBR0001 코드
			{name : 'CLU_TP_CD_NM', label : '사이트', align : 'center', sortable : false},	// MBR0001 코드명
			{name : 'CLU_CLS_CD', label : '약관유형코드', hidden : true},						// MBR0002 코드
			{name : 'CLU_CLS_CD_NM', label : '약관명', width : 200, sortable : false,			// MBR0002 코드명
			 cellattr : function(rowIdx, value, rowJson, colAttr, rowData){
					if(isNotEmpty(rowJson.CLU_CLS_CD_NM))
						return 'style="cursor:pointer; text-decoration:underline;"';
				}
			},
			{name : 'US_YN', label : '사용여부', align : 'center', sortable : false, formatter : 'select', editoptions : {value:'Y:사용;N:미사용'}},
			{name : 'CRT_DTTM', label : '등록일시', align : 'center', sortable : true, editable : false, sorttype : "date", formatter : "date", formatoptions : {srcformat : 'U', newformat: "Y-m-d H:i:s"}},
			{name : 'UPD_DTTM', label : '수정일시', align : 'center', sortable : true, editable : false, sorttype : "date", formatter : "date", formatoptions : {srcformat : 'U', newformat: "Y-m-d H:i:s"}},
		],
        editmode	: false,							// 그리드 editable 여부
        gridtitle	: '약관 목록',							// 그리드명
        multiselect	: false,							// checkbox 여부
        formid		: 'search',							// 조회조건 form id
        shrinkToFit	: true,								// 컬럼 width 자동조정
        autowidth	: true,
        height		: 200,								// 그리드 높이
        cellEdit	: false,
        selecturl	: '/psys/getPsys1023List',		// 그리드 조회 URL
        events		: {
			onCellSelect : function(event, rowIdx, colIdx, value){

				if(term_grid.getColName(colIdx) != 'CLU_CLS_CD_NM')
					return
				
				var row = term_grid.getRowData(rowIdx);

				if(row.CLU_SEQ != 0)
				{
					$("#terms_type").val(row.CLU_CLS_CD_NM);			
					term_editor.instances['terms_contents'].setData(row.CLU_CTS);
				}
				else
				{
					$("#terms_type").val("");
					term_editor.instances['terms_contents'].setData("");
				}
			}
		}
	};
    
	term_grid = new UxGrid(grid_config);
	term_grid.init();
	term_grid.setGridWidth($('.tblType1').width());
    
	// CKEDITOR 세팅
	term_editor = CKEDITOR;
	term_editor.replace('terms_contents', {	// 해당 이름으로 된 textarea에 에디터를 적용
		width	: '100%',
		height	: '200px',
// 		enterMode : CKEDITOR.ENTER_BR,
		filebrowserImageUploadUrl : _context +'/board/updateImageUpload.adm' // 해당 경로로 파일을 전달하여 업로드
	});
     
	term_editor.on('dialogDefinition', function(e){
		var dialogName = e.data.name;
		var dialogDefinition = e.data.definition;
      
		// Image Properties dialog
		if(dialogName == 'image')
		{
			dialogDefinition.removeContents('Link');
			dialogDefinition.removeContents('advanced');
// 			console.log(dialogDefinition);
			var infoTab = dialogDefinition.getContents( 'info' )
			infoTab.remove('txtHSpace'); // info 탭 내에 불필요한 엘레멘트 제거
			infoTab.remove('txtVSpace');
			infoTab.remove('txtBorder');
			infoTab.remove('txtWidth');
			infoTab.remove('txtHeight');
			infoTab.remove('ratioLock');
// 			console.log(infoTab);
		}
	});
});

// grid resizing
$(window).resize(function(){
	term_grid.setGridWidth($('.tblType1').width());
});


/**************************************************
 * 공통 버튼 
 **************************************************/
 
// 조회: 내부 로직 사용자 정의
function fn_Search(){
	// 페이징이 1page를 초과할 시 초기화
	if($("#term_grid").jqGrid('getGridParam', 'page') > 1)
		$("#term_grid").jqGrid('setGridParam', {'page' : 1});

	// 하단 Editor 영역 타이틀 조기화
	$("#terms_type").val("");
	
	// 하단 Editor 영역 내용 초기화
	term_editor.instances['terms_contents'].setData("");

	// 데이터 조회
	term_grid.retreive(); //{success:function(){alert('retreive success');}}
}

// 추가: 내부 로직 사용자 정의
function fn_AddRow() {

}

// 저장: 내부 로직 사용자 정의
function fn_Save() {

}

// 삭제: 내부 로직 사용자 정의
function fn_DelRow() {
	//term_grid.remove(); // {success:function(){alert('remove success');}}
}

//프린트: 내부 로직 사용자 정의
function fn_Print(){

}

//엑셀다운로드: 내부 로직 사용자 정의
function fn_ExcelDownload(){
	var grid_id = "term_grid";
	var rows	= $('#term_grid').jqGrid('getGridParam', 'rowNum');
	var page	= $('#term_grid').jqGrid('getGridParam', 'page');
	var total	= $('#term_grid').jqGrid('getGridParam', 'total');
	var title	= $('#term_grid').jqGrid('getGridParam', 'gridtitle');
	var url		= "/psys/getPsys1023XlsxDwld";  //페이징 존재
	
	var param	= {};
	param.page	= page;
	param.rows	= rows;
	param.fileName = "약관이력";
	AdvencedExcelDownload(grid_id, url, param);
}

</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">

			<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp"%>
			<form name="search" id="search" onsubmit="return false">
				<input type="hidden" name="ds_mst_cd" id="ds_mst_cd" class="w45" />
				<input type="hidden" name="tp_mst_cd" id="tp_mst_cd" class="w45" />
				<table class="tblType1 txt_pw">
					<colgroup>
						<col width="15%" />
						<col width="85%" />
					</colgroup>
					<tr>
						<th><span class="term_nm">약관명</span></th>
						<td><input type="text" name="sch_cd_nm" id="sch_cd_nm" class="w45" /></td>
					</tr>
				</table>
			</form>
			<br />

			<table id="term_grid"></table>
			<div id="term_grid_pager"></div>

			<div class="table_bottom mT60">
				<div class="tableBtnWrap">
					<p class="tableTitle">약관 상세</p>
				</div>
	
				<table class="tblType1">
					<colgroup>
						<col width="15%"/>
						<col width="*"/>
					</colgroup>
					<tr>
						<th>약관명</th>
						<td>
							<span class="txt_pw">
							<input type="text" name="terms_type" id="terms_type" class="w100" readonly="readonly"/>
							</span>
						</td>
					</tr>
					<tr>
						<th><span class="vv">상세내용</span>
						<td colspan=7><textarea name="terms_contents" id="terms_contents" readonly="readonly"></textarea></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
