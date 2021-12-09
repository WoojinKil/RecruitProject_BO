<%-- 
   1. 파일명 : psys1007
   2. 파일설명 : 시스템사용자관리
   3. 작성일 : 2018-03-28
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>

<script type="text/javascript">
var admin_grid;

$(document).ready(function(){
	// 공통코드 복수 설정
	$("#mst_cd_arr").val(new Array('MSTS'));
	
	ajax({
		url		: '/psys/getPsysCommon',
		data	: $("form[name=frm_sysCdDtl]").serialize(),
		success	: function(data) {
			for(i=0; i<data.selectData.length; i++)
				$("#usr_stat_cd").append("<option value='" + data.selectData[i].CD+ "'>" + data.selectData[i].CD_NM + "</option> ");
		}
	});
	
	//페이징 없이 전체 데이터를 표출을 원할 경우 pageId에 값을 ''  
	var grid_config = { 
		gridid	  : 'admin_grid',
 		pagerid	  : '',
 		gridBtnYn : 'Y',						// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
		columns	  : [
			{name : 'USR_ID', label :'사용자ID', hidden : true},
			{name : 'CRTR_ID', label :'등록자', hidden : true},
			{name : 'UPDR_ID', label :'수정자', hidden : true},
			{name : 'STATUS', label : '상태', align : 'center', editable : false, width:30},
			{name : 'USR_EML_ADDR', label : '이메일', sortable : false, editable : false},
			{name : 'LGN_ID', label : '아이디', required : true, sortable:false, editable : false},
			{name : 'USR_STAT_CD', label : '상태', align : 'center', sortable:false, editable : false, formatter : 'select', editoptions : {value:'<%=CodeUtil.getGridComboList("MSTS")%>'}},
			{name : 'USR_NM', label : '이름', required : true, sortable:false, editable : false},
			{name : 'ACTV_YN', label : '계정활성화', align : 'center', editable : true, edittype:'select', formatter : 'select', editoptions : {value:'Y:활성화;N:비활성화'}},
			{name : 'SYS_CD', label : '시스템 구분', align : 'center', editable : false, edittype:'select', formatter : 'select', editoptions : {value:'<c:out value="<%=CodeUtil.getSitGridComboList()%>" />'}},
			{name : 'F_CRT_DTTM', label : '가입일자', 	align : 'center', editable : false},
			{name : 'F_UPD_DTTM', label : '수정일자', 	align : 'center', editable : false},
			{name : 'PWD_FAIL_CNT', label : '비밀번호 틀린 횟수', align : 'right', editable : true},
			{name : 'PWD_RESET', label : '비밀번호 초기화', align : 'center', formatter : setPasswordResetBtn}
		],          
// 		initval		: {US_YN : 'Y', SORT_ORD : 999, MST_CD : 'A00'}, // 컬럼 add 시 초기값
		editmode	: true, 								// 그리드 editable 여부
		gridtitle	: '사용자관리 목록', 						// 그리드명
		multiselect	: true, 								// checkbox 여부
		formid		: 'search', 							// 조회조건 form id
		height		: '500', 								// 그리드 높이
		shrinkToFit	: true, 								// true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
		selecturl	: '/sample/getSample1013List', 			// 그리드 조회 URL
		saveurl		: '/psys/savePsys1007', 			// 그리드 입력/수정/삭제 URL
		events		: {
			onSelectRow : function(event, rowid){
				var row = admin_grid.getRowData(rowid);
			},
			onCellSelect : function(event, rowid, icol){	// 해당 셀 선택시
				var row = admin_grid.getRowData(rowid);
			},
			gridComplete : function(data){  

            }
		}
	};
 
	admin_grid = new UxGrid(grid_config);
	admin_grid.init();
	admin_grid.setGridWidth($('.tblType1').width());
    
	// 시스템사용자정보 등록 후의 목록 조회
	if(isNotEmpty(_param) && "CHG" == _param)
		$("#btn_retreive").trigger("click");

	// 검색조건 : 날짜 설정
	setDatepicker("#sch", "_st_dt", "_ed_dt");
	
	fn_Search();
	
});

// grid resizing
$(window).resize(function(){
	admin_grid.setGridWidth($('.tblType1').width());
});

// jqgrid 내 버튼 생성 이벤트
function setPasswordResetBtn(value, options, rowJson)
{      
  	return "<button id='pwResetBtn_" + options.rowId + "' onclick='fn_passwordReset(" + options.rowId + ")' class='btn_common btn_default' style='float:center;'>초기화</button>";﻿﻿﻿﻿﻿
}

// formatter 버튼 이벤트
function fn_passwordReset(rowId)
{
	var usr_id		= $("#admin_grid").jqGrid('getCell', rowId, 'USR_ID');
	var usr_nm		= $("#admin_grid").jqGrid('getCell', rowId, 'USR_NM');
	var usr_eml_addr	= $("#admin_grid").jqGrid('getCell', rowId, 'USR_EML_ADDR');
	
	ajax({
		url		: '/psys/updatePsys1007.adm',
		data	: {usr_id : usr_id, usr_nm : usr_nm, usr_eml_addr : usr_eml_addr},
		async	: false,
		success	: function(data){
			if(data.RESULT == "S")
				alert('이메일로 임시 비밀번호를 발송하였습니다.');
			else
			{
				if(isNotEmpty(data.MSG))
					alert("일시적 오류입니다.\n잠시후 다시 시도하세요.")
				else
					alert(data.MSG);
			}
		},
	});
}

/**************************************************
 * 공통 버튼 
 **************************************************/

// 조회 : 내부 로직 사용자 정의
function fn_Search()
{
	var start_dt = $("#sch_st_dt").val().replace(/-/g, "");
	var end_dt	 = $("#sch_ed_dt").val().replace(/-/g, "");
	
	
	if(parseInt(start_dt, 10) > parseInt(end_dt, 10))
	{
		alert("검색 시작일은 검색 종료일 이전이어야합니다.");
		return;
	}
	
	admin_grid.retreive();
}

// 추가 : 내부 로직 사용자 정의
function fn_AddRow()
{
	// default 값 세팅
	addTabInFrame("/psys/forward.psys1009.adm");
}

// 저장 : 내부 로직 사용자 정의 
function fn_Save()
{
	var rowid = admin_grid.getSelectRowIDs();
    var row   = admin_grid.getRowData(rowid);
    admin_grid.save();  
}

// 삭제 : 내부 로직 사용자 정의
function fn_DelRow()
{
	var rowid = admin_grid.getSelectRowIDs();
	var row   = admin_grid.getRowData(rowid);
	admin_grid.remove();
}

// 프린트 : 내부 로직 사용자 정의
function fn_Print()
{
//	var data	  = makePrintXmlData();
	var param	  = makePrintJsonData();    
	var file_name = "/resources/pandora3/ireport/pgm_info_report_xml.jasper";
	var url		  = "/pandora3/print/print_json.jsp";
	var form	  = document.getElementById("printForm");
	
	document.getElementById("data").value = param;
	document.getElementById("fileName").value = file_name;
	
	window.open('', 'printviewer', 'width=1024px,height=768px');
	
	form.action = url;
	form.target = "printviewer";
	form.method = "post";
	form.submit();
}

// 엑셀다운로드 : 내부 로직 사용자 정의
function fn_ExcelDownload()
{
	var grid_id = "admin_grid";
	var rows	= $('#admin_grid').jqGrid('getGridParam', 'rowNum');
	var page	= $('#admin_grid').jqGrid('getGridParam', 'page');
	var total	= $('#admin_grid').jqGrid('getGridParam', 'total');
	var title	= $('#admin_grid').jqGrid('getGridParam', 'gridtitle');
	var url		= "/psys/getPsys1007XlsxDwld";  // 페이징 존재
	var param          = {};
	    param.page     = page;
	    param.rows     = rows;
	    param.fileName = "시스템 사용자 목록";
	AdvencedExcelDownload(grid_id, url, param);
}

function makePrintJsonData()
{
	var rowIds = admin_grid.getDataIDs();
	var printList = []; // 삽입, 갱신할 열 배열
	
	for(var i = 0; i < rowIds.length; i++) {
		var row = admin_grid.getRowData(rowIds[i]);
		printList.push(row);
	}
	return 	JSON.stringify(printList);
}


</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
			<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp"%>
			<!-- search -->
			<form name="search" id="search" onsubmit="return false">
				<input type="hidden" value="" name="sys_cd" id="sys_cd" />
				<table class="tblType1 mB60">
					<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>
					<tr>
						<th>가입일</th>
						<td>
							<span class="txt_pw">
								<input type="text" id="sch_st_dt" name="sch_st_dt" class="" />
								<span style="width:10%; display: inline-block; text-align: center;">~</span>
								<input type="text" id="sch_ed_dt" name="sch_ed_dt" class="" />
							</span>
						</td>
						<th>이메일</th>
						<td><span class="txt_pw"><input type="text" name="usr_eml_addr" id="usr_eml_addr" class="typeShort" /></span></td>
					</tr>
					<tr>
						<th>이름</th>
						<td><span class="txt_pw"><input type="text" name="usr_nm" id="usr_nm" class="typeShort" /></span></td>
						<th>아이디</th>
						<td><span class="txt_pw"><input type="text" name="lgn_id" id="lgn_id" class="typeShort" /></span></td>
					</tr>
					<tr>
						<th>상태</th>
						<td>
							<select id="usr_stat_cd" name="usr_stat_cd" class="select">
								<option value="">전체</option>
							</select>
						</td>
						<th>계정활성화</th>
						<td>
							<span class="txt_pw">
								<select class="select" name="actv_yn" id="actv_yn">
									<option value="">전체</option>
									<option value="Y">활성화</option>
									<option value="N">비활성화</option>
								</select>
							</span>
						</td>
					</tr>
				</table>
			</form>
			<!-- search // -->
			<!-- Grid -->
			<table id="admin_grid"></table>
			<div id="admin_grid_pager"></div>
			<br/>
			<div id="test_paginate"></div>
			<!-- Grid // -->
		</div>
		<form name="frm_sysCdDtl" id="frm_sysCdDtl" onsubmit="return false;">
			<input type="hidden" name="mst_cd_arr" id="mst_cd_arr" />
		</form>
		<form id="printForm">
			<input type="hidden" id="data" name="data" /> <input type="hidden" id="fileName" name="fileName" />
		</form>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>
