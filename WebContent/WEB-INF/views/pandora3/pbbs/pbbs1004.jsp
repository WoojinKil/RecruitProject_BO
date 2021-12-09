<%--
   1. 파일명 : pbbs1004
   2. 파일설명: 질문답변게시글 관리
   3. 작성일 : 2018-04-09
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var menu_id = _menu_id;
var pbbs1004_grid;

var obj = {
	autoUpdateInput	: false,
	showDropdowns: true,
	/* 날짜/일시 선택 start */
//     timePicker: true,
    locale: {
        format: 'YYYY-MM-DD'
    }
	/* 날짜/일시 선택 end */
};

$(document).ready(function() {
	// 조회조건 : 게시판명 콤보 생성
	ajax({
		url:'/pbbs/getPbbs1004ModlTpList.adm',
		type:'POST',
		data:{modl_tp:$("#modl_tp").val()},
		success:function(data) {
			var boardList = data.boardList;
			for(var i = 0; i < boardList.length; i++) {
				$("#modl_seq").append("<option value='" + boardList[i].MODL_SEQ + "'" + " modl_tp='" + boardList[i].MODL_TP + "'>" + boardList[i].MODL_NM + "</option>");
			}
		}
	});

	// 게시판유형 파라미터 존재 시 처리
	if(_type != "") {
		$("#modl_seq").val(_type).prop("selected", true);
		$("#modl_seq option[value!="+_type+"]").remove();
		var modl_tp = $("#modl_seq option:selected").attr("modl_tp");
		$("#modl_tp").val(modl_tp).prop("selected", true);
		$("#modl_tp option[value!="+modl_tp+"]").remove();
	}

	// 그리드 초기화
	var module_config = {
		// 그리드, 페이징 ID
		gridid:'pbbs1004_grid',
		pagerid:'pbbs1004_grid_pager',
		// 컬럼 정보
		columns:[{name:'SYS_NM', width:50, label:'시스템', align:'center', sortable:false, editable:false},
				 {name:'MODL_NM', width:90, label:'게시판명', sortable:false},
				 {name:'CTEGRY_MST_NM', width:90, label:'마스터 카테고리', sortable:false},
				 {name:'CTEGRY_DTL_NM', width:90, label:'상세 카테고리', sortable:false},
				 {name:'MODL_SEQ', width:100, label:'게시판순번', hidden:true},
		         {name:'DOC_SEQ', width:100, label:'문서번호', hidden:true},
		         {name:'TMP_SEQ', width:100, label:'템플릿ID', hidden:true},
				 {name:'MAPPED_YN', width:100, label:'매핑여부', hidden:true},
				 {name:'MODL_TP', width:100, label:'게시판유형', hidden:true},
				 {name:'REF_1', width:100, label:'게시판URL', hidden:true},
// 				 {name:'STATUS', label:'상태', align:'center', editable:false, width:20},
				 {name:'CD_NM', width:100, label:'게시판유형명', sortable:false, hidden:true},
				 
				 {name:'TITL', width:280, label:'제목', sortable:false, cellattr:function(rowId, tv, rowObject, cm, rdata) {
					 if(isNotEmpty(rowObject.TITL)) {
						 return 'style="cursor: pointer; text-decoration: underline;"'
					 }
				 }},
				 {name:'LGN_ID', width:50, label:'질문자 사번', align:'center', sortable:false},
				 {name:'USR_NM', width:50, label:'질문자 성명', align:'center', sortable:false},
				 {name:'TREATMENT_CD', width:50, label:'답변여부', align:'center', sortable:false, editable:false, formatter:'select', edittype:'select', editoptions:{value:'1:등록완료;2:답변준비중;3:답변완료;-:-;'}},
				 {name:'', width:50, label:'답변자 사번', align:'center', sortable:false},
				 {name:'', width:50, label:'답변자 성명', align:'center', sortable:false},
				 {name:'', width:50, label:'답변 작성일', align:'center', sortable:false}
				 ],
		editmode:true,			// 그리드 editable 여부
		gridtitle:'게시글 목록',	// 그리드명
		multiselect:false,		// checkbox 여부
		formid:'search',		// 조회조건 form id
		shrinkToFit:true,		// width 고정여부
		autowidth:true,         // 컬럼 width 자동조정여부
		height:321,				// 그리드 높이
		cellEdit:false,
		selecturl:'/pbbs/getPbbs1004DocList', // 그리드 조회 URL
		saveurl:'/pbbs/savePbbs1004DocList',  // 그리드 삭제 URL
		events:{
			//onCellSelect:function(event, rowid, icol, conts) {
			ondblClickRow: function(event, rowid, irow, icol) {
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
							otp_stat			: $("#otp_stat").val(),
							viewNm			: "pbbs1004"
					}


// 					parent.addTab('sub'+menu_id, row.CD_NM+" 상세", url, row.MODL_SEQ, row.DOC_SEQ, encodeURIComponent(JSON.stringify(param3)));
					parent.addTab('sub'+menu_id, "질문답변게시글 상세", url, row.MODL_SEQ, row.DOC_SEQ, encodeURIComponent(JSON.stringify(param3)));
				} 
			}
		}
	};
	pbbs1004_grid = new UxGrid(module_config);
	pbbs1004_grid.init();
	pbbs1004_grid.setGridWidth($('.tblType1').width());

	// 게시글정보 등록/수정 후의 목록 조회
	if(isNotEmpty(_param) && "CHG" == _param) {
		var jObj = JSON.parse(_param3);
		//param3 가 있을때만
		if(isNotEmpty(jObj) ) {

			$("#modl_tp").val(jObj.modl_tp).prop("selected", true);
			$("#modl_seq").val(jObj.modl_seq).prop("selected", true);
			$("#sch_type").val(jObj.sch_type).prop("selected", true);
			$("#sch_type_txt").val(jObj.sch_type_txt);
			$("#lgn_id").val(jObj.lgn_id);
			$("#sch_st_dt").val(jObj.sch_st_dt);
			$("#sch_ed_dt").val(jObj.sch_ed_dt);
			$("#notc_yn").val(jObj.notc_yn).prop("selected", true);
			$("#treatment_cd").val(jObj.treatment_cd).prop("selected", true);
			$("#otp_stat").val(jObj.otp_stat).prop("selected", true);

		}
		$("#btn_search").trigger("click");
	}

	// 조회조건 : 작성기간 날짜 초기화
	/* setDatepicker("#sch", "_st_dt", "_ed_dt"); */
    var today = new Date();
//     $("#sch_st_dt").val(formatDate(today));
    var addMonthDay = addMonth(today);
//     $("#sch_ed_dt").val(formatDate(addMonthDay));

    $("#sch_st_dt").daterangepicker(obj, function(start, end, separator) {

	    $("#sch_st_dt").val(start);
	    $("#sch_ed_dt").val(end);

	});

    $("#sch_ed_dt").on('click', function () {
    	 $("#sch_st_dt").trigger('click');
    });

  //사이트 리스트 취득
    getSystemList();
    function getSystemList() {
    	var html = "";
    	ajax({
    		url 	: "/pdsp/getPdsp1011ListSit",
    		data 	: {sys_cd : _sys_cd},
    		success : function (data) {
    			if (data.RESULT == "S") {
    				var sitListCnt = data.rows.length;
    				console.log(data);
    				$(data.rows).each(function (index) {
    					// 조회 건수가 하나일 경우 단일 하나의 시스템
    					if(sitListCnt == 1) {
    						html += "<option value="+ this.SYS_CD +" selected='selected' >"+ this.SYS_NM +"</option>"
    						return false;
    					} else {
    						html += "<option value="+ this.SYS_CD +">"+ this.SYS_NM +"</option>"
    						//$("#sys_info").closest('div').show();
    					}
    				});
    				//alert(html);
    				$("#sys_cd").append(html);
    			}
    		}
    	});
    }

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
			<div class="frameTopTable">
				<form name="search" id="search" onsubmit="return false">
					<input type="hidden" value="B_TYPE3" name="modl_tp" id="modl_tp"/>
					<table class="tblType1 typeCal">
						<colgroup>
							<col style="width: 117px;" />
							<col style="" />
							<col style="width: 117px;" />
							<col style="" />
							<col style="width: 117px;" />
							<col style="" />
						</colgroup>
						<tr>
							<th>시스템</th>
							<td><span class="txt_pw"><select id="sys_cd" name="sys_cd" class="select" ><option value="">전체</option></select></span></td>
							<th><label for="modl_seq">게시판명</label></th>
							<td><span class="txt_pw"><select class="select w100" name="modl_seq" id="modl_seq" ><option value="">전체</option></select></span></td>
							<th><label for="ctegry_dtl_nm">카테고리</label></th>
							<td><span class="txt_pw"><select class="select w100" name="ctegry_dtl_nm" id="ctegry_dtl_nm" ><option value="">전체</option></select></span></td>
							<!-- <th>게시판유형</th>
							<td>
								<span class="txt_pw">
									<select class="select w100" name="modl_tp" id="modl_tp" onchange="javascript:moduleSelect();">
										<option value="">전체</option>
										<option value="B_TYPE2">공통 게시판</option>
										<option value="B_TYPE3">질문답변형 게시판</option>
									</select>
								</span>
							</td> -->
							
						</tr>
						<tr>
							<th>검색구분</th>
							<td><span class="txt_pw"><select class="select w100" name="sch_type" id="sch_type"><option value="1">제목</option><option value="2">내용</option><option value="3">제목+내용</option></select></span></td>
							<th>검색내용</th>
							<td><span class="txt_pw"><input type="text" name="sch_type_txt" id="sch_type_txt" class="w100"/></span></td>
							<th>답변여부</th>
							<td>
								<span class="txt_pw">
									<select class="select w100" name="treatment_cd" id="treatment_cd">
										<option value="">전체</option>
										<option value="1">등록완료</option>
										<option value="2">답변준비중</option>
										<option value="3">답변완료</option>
									</select>
								</span>
							</td>
							<!-- <th>작성자ID</th>
							<td><span class="txt_pw"><input type="text" name="lgn_id" id="lgn_id" class="w100"/></span></td> -->
						</tr>
						<tr>
							<!-- <th>공지여부</th>
							<td><span class="txt_pw"><select class="select w100" name="notc_yn" id="notc_yn"><option value="">전체</option><option value="Y">중요</option><option value="N">일반</option></select></span></td> -->
							<th>질문자 사번/성명</th>
							<td><span class="txt_pw"><input type="text" name="lgn_id" id="lgn_id" class="w100"/></span></td>
							<th>답변자 사번/성명</th>
							<td><span class="txt_pw"><input type="text" name="" id="" class="w100"/></span></td>
							<th>작성기간</th>
							<td class="typeCal">
								<!-- <span class="txt_pw">
									<input type="text" id="sch_st_dt" name="sch_st_dt" class="w45"/>
									<span style="width:10%;display: inline-block;text-align: center;">~</span>
									<input type="text" id="sch_ed_dt" name="sch_ed_dt" class="w45"/>
								</span> -->
								<div class="cals_div">
									<span class="txt_pw ">
										<input type="text" id="sch_st_dt" name="sch_st_dt" class="cals w100">
									</span>
									<span class="w10 space">~</span>
									<span class="txt_pw ">
										<input type="text" id="sch_ed_dt" name="sch_ed_dt" class="cals w100" >
									</span>
								</div>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="bgBorder"></div>
			<table id="pbbs1004_grid"></table>
			<div id="pbbs1004_grid_pager"></div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>