<%-- 
   1. 파일명 : sample1016
   2. 파일설명: 공지사항 조회
   3. 작성일 : 2019-09-09
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var menu_id = _menu_id;
var pbbs1004_grid;

$(document).ready(function() {
	
	
	// 그리드 초기화
	var module_config = {
		// 그리드, 페이징 ID
		gridid:'pbbs1004_grid',
		pagerid:'pbbs1004_grid_pager',
		// 컬럼 정보
		columns:[{name:'MODL_SEQ', width:100, label:'게시판순번', hidden:true},
		         {name:'DOC_SEQ', width:100, label:'문서번호', hidden:true},
		         {name:'TMP_SEQ', width:100, label:'템플릿ID', hidden:true},
				 {name:'MAPPED_YN', width:100, label:'매핑여부', hidden:true},
				 {name:'MODL_TP', width:100, label:'게시판유형', hidden:true},
				 {name:'REF_1', width:100, label:'게시판URL', hidden:true},
				 {name:'STATUS', label:'상태', align:'center', editable:false, width:20},
				 {name:'CD_NM', width:100, label:'게시판유형명', sortable:false},
				 {name:'MODL_NM', width:90, label:'게시판명', sortable:false},
				 {name:'TITL', width:280, label:'제목', sortable:false, cellattr:function(rowId, tv, rowObject, cm, rdata) {
					 if(isNotEmpty(rowObject.TITL)) {
						 return 'style="cursor: pointer; text-decoration: underline;"'
					 }
				 }},
				 {name:'LGN_ID', width:50, label:'작성자ID', align:'center', sortable:false},
				 {name:'INQ_CNT', width:40, label:'조회수', align:'right', editable:false, formatter:'number', formatoptions:{thousandsSeparator:",",decimalPlaces:0}},
				 {name:'F_UPD_DTTM', width:80, label:'수정일', align:'center', editable:false},
				 {name:'NOTC_YN', width:50, label:'공지여부', align:'center', sortable:false, editable:true, formatter:'select',edittype:'select', editoptions:{value:'Y:공지;N:일반'}},
				 {name:'TREATMENT_CD', width:50, label:'답변여부', align:'center', sortable:false, editable:false, formatter:'select', edittype:'select', editoptions:{value:'1:등록완료;2:답변준비중;3:답변완료;-:-;'}},
				 {name:'OTP_STAT', width:50, label:'공개설정', align:'center', sortable:false, editable:true, formatter:'select',edittype:'select', editoptions:{value:'PUBLIC:공개;SECRET:비공개'}}],
		editmode:true,			// 그리드 editable 여부
		gridtitle:'게시글 목록',	// 그리드명
		multiselect:true,		// checkbox 여부
		formid:'search',		// 조회조건 form id
		shrinkToFit:true,		// width 고정여부
		autowidth:true,         // 컬럼 width 자동조정여부	
		height:321,				// 그리드 높이
		cellEdit:false,
		selecturl:'/pbbs/getPbbs1004DocList', // 그리드 조회 URL
		saveurl:'/pbbs/savePbbs1004DocList',  // 그리드 삭제 URL
		events:{
			onCellSelect:function(event, rowid, icol, conts) {
				var row = pbbs1004_grid.getRowData(rowid);
				if(pbbs1004_grid.getColName(icol) == 'TITL') {
					var url = row.REF_1;
					if(_type != "") {
						url = row.REF_1+"?type="+_type;
					}
					
					var param3 = {
							modl_tp			: $("#modl_tp").val(),
							modl_seq		: $("#modl_seq").val(),
							sch_type		: $("#sch_type").val(),
							sch_type_txt	: $("#sch_type_txt").val(),
							lgn_id			: $("#lgn_id").val(),
							sch_st_dt		: $("#sch_st_dt").val(),
							sch_ed_dt		: $("#sch_ed_dt").val(),
							notc_yn			: $("#notc_yn").val(),
							treatment_cd	: $("#treatment_cd").val(),
							otp_stat			: $("#otp_stat").val()	
					}
					
 					parent.addTab('sub'+menu_id, row.CD_NM+" 상세", url, row.MODL_SEQ, row.DOC_SEQ, encodeURIComponent(JSON.stringify(param3)));
				}
			}
		}
	};
	pbbs1004_grid = new UxGrid(module_config);
	pbbs1004_grid.init();
	pbbs1004_grid.setGridWidth($('.tblType1').width());
	
	// 게시글정보 등록/수정 후의 목록 조회
	if(isNotEmpty(_param) && "CHG" == _param) $("#btn_search").trigger("click");

	// 조회조건 : 작성기간 날짜 초기화
	setDatepicker("#sch", "_st_dt", "_ed_dt");
    var today = new Date();
//     $("#sch_st_dt").val(formatDate(today));
    var addMonthDay = addMonth(today);
//     $("#sch_ed_dt").val(formatDate(addMonthDay));
});

// 조회 : 내부 로직 사용자 정의
function fn_Search() {
	if(validChk()) {
		if($("#pbbs1004_grid").jqGrid('getGridParam', 'page') > 1) $("#pbbs1004_grid").jqGrid('setGridParam', {'page':1});
		pbbs1004_grid.retreive();
	}
}
// 저장 : 내부 로직 사용자 정의
function fn_Save() {
	pbbs1004_grid.save();
}
// 삭제: 내부 로직 사용자 정의
function fn_DelRow() {
	pbbs1004_grid.remove();
}
// 엑셀다운로드 : 내부 로직 사용자 정의
function fn_ExcelDownload(){
	var grid_id = "pbbs1004_grid";
	var rows = $('#pbbs1004_grid').jqGrid('getGridParam', 'rowNum');
	var page = $('#pbbs1004_grid').jqGrid('getGridParam', 'page');
	var total = $('#pbbs1004_grid').jqGrid('getGridParam', 'total');
	var title = $('#pbbs1004_grid').jqGrid('getGridParam', 'gridtitle');
	var url = "/pbbs/getPbbs1004XlsxDwld.adm";  //페이징 존재
	var param ={};
	param.page=page;
	param.rows=rows;
	param.filename ="통합게시글 목록";
	AdvencedExcelDownload(grid_id,url,param);
}

// 게시판유형 변경 시 처리
function moduleSelect() {
	$("#modl_seq option").remove();
	$("#modl_seq").append("<option value=''>전체</option>");
	ajax({
		url:'/pbbs/getPbbs1004ModlTpList.adm',
		type:'POST',
		data:{modl_tp:$("#modl_tp option:selected").val()},
		success:function(data) {
			var boardList = data.boardList;
			for(var i = 0; i < boardList.length; i++) {
				$("#modl_seq").append("<option value='" + boardList[i].MODL_SEQ + "'" + " modl_tp='" + boardList[i].MODL_TP + "'>" + boardList[i].MODL_NM + "</option>");
			}
		},
	});
}

// 조회조건 : 입력값 유효성 체크
function validChk() {
	// 작성기간 유효성 체크
	var sch_st_dt = $("#sch_st_dt").val();
	var sch_ed_dt = $("#sch_ed_dt").val();
	if(isEmpty(sch_st_dt) ^ isEmpty(sch_st_dt)) {
		alert("작성기간을 입력하여 주세요");
		return false;
	}
	if(!validDateChk(sch_st_dt, sch_ed_dt)) return false;
	return true;
}

// 그리드 리사이징
$(window).resize(function() {
	pbbs1004_grid.setGridWidth($('.tblType1').width());
});
</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
		<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
			<form name="search" id="search" onsubmit="return false">
			<input type="hidden" value="<%=parameterMap.getValue("modl_seq") %>" name="modl_seq" id="modl_seq" />
			<table class="tblType1 mB60">
				<colgroup>
					<col width="14%" />
					<col width="15%" />
					<col width="14%" />
					<col width="15%" />
					<col width="14%" />
					<col width="15%" />
				</colgroup>
				<tr>
					<th>검색구분</th>
					<td><span class="txt_pw"><select class="select w100" name="sch_type" id="sch_type"><option value="1">제목</option><option value="2">내용</option><option value="3">제목+내용</option></select></span></td>
					<th>검색내용</th>
					<td colspan="3"><span class="txt_pw"><input type="text" name="sch_type_txt" id="sch_type_txt" class="w100"/></span></td>
				</tr>
				<tr>
					<th>작성자ID</th>
					<td><span class="txt_pw"><input type="text" name="lgn_id" id="lgn_id" class="w100"/></span></td>
					<th>작성기간</th>
					<td colspan="3"><span class="txt_pw"><input type="text" id="sch_st_dt" name="sch_st_dt" class="w45"/><span style="width:10%;display: inline-block;text-align: center;">~</span><input type="text" id="sch_ed_dt" name="sch_ed_dt" class="w45"/></span></td>
					
				</tr>
				<tr>
					<th>공개설정</th>
					<td colspan="5"><span class="txt_pw"><select class="select w100" name="otp_stat" id="otp_stat"><option value="">전체</option><option value="PUBLIC">공개</option><option value="SECRET">비공개</option></select></span></td>
					
					
				</tr>
			</table>
			</form>
			<table id="pbbs1004_grid"></table> 
			<div id="pbbs1004_grid_pager"></div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>