<%-- 
   1. 파일명 : psys1018
   2. 파일설명: BO팝업 관리
   3. 작성일 : 2018-04-13
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<style>
.layer_popup {background-color:#fff;border-radius:0;border:1px solid #000;color:#000;display:none;padding:0px;min-width:400px;min-height: 180px}
.layer_popup .btn_close{cursor:pointer;position:absolute;right:10px;top:5px}
</style>
<script type="text/javascript">

var mnu_seq = '<%=parameterMap.getValue("_mnu_seq")%>';
var pop_grid;
var b_popup;

$(document).ready(function(){
	var grid_config = {
		gridid		: 'pop_grid',
		pagerid		: 'pop_grid_pager',
		gridBtnYn   : 'Y',						// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
		columns		: [
			{name : 'MN_POP_SEQ', width : 100, label : '팝업번호', hidden : true},
			{name : 'TOP_TXT', width : 100, label : '상단문구', hidden : true},
			{name : 'MID_TXT', width : 100, label : '중단문구', hidden : true},
			{name : 'BTM_TXT', width : 100, label : '하단문구', hidden : true},
			{name : 'BKG_TP_CD', width : 100, label : '배경타입', hidden : true},
			{name : 'POP_NM', width:100, label:'팝업명', sortable:false,
			 cellattr : function(rowId, tv, rowObject, cm, rdata){
				 	if(isNotEmpty(rowObject.POP_NM))
				 		return 'style="cursor: pointer; text-decoration: underline;"';
			 	}
			},
			{name : 'POP_TP_CD', width : 70, label : '팝업유형', align : 'center', formatter : 'select', editoptions : {value:'01:팝업크기(대);02:팝업크기(소)'}},
			{name : 'F_ST_DTTM', width : 100, label : '전시시작일시', align : 'center', sortable : false},
			{name : 'F_ED_DTTM', width : 100, label : '전시종료일시',align : 'center', sortable : false},
			{name : 'DSPLY_YN', width : 50, label : '전시여부', align : 'center', formatter : 'select', editoptions : {value:'Y:전시;N:비전시;'}},
			{name : 'CRTR_ID', width : 50, label : '등록자', align : 'center', editable : false},
			{name : 'PREVIEW', width : 50, label :'미리보기', align : 'center',
			 formatter : function(cellValue, options, rowObject){
					return "<input type='button' value='보기' class='in_grid_button preview' onclick=\"fn_previewPopup(\'"
							+ rowObject.POP_TP_CD + "\', \'"
							+ rowObject.BKG_TP_CD + "\', \'"
							+ rowObject.TOP_TXT.replace(/(\n|\r\n)/g, '<br>') + "\', \'"
							+ rowObject.MID_TXT.replace(/(\n|\r\n)/g, '<br>') + "\', \'"
							+ rowObject.BTM_TXT.replace(/(\n|\r\n)/g, '<br>') + "\')\"></button>";
				}
			}, 
			{name : 'F_CRT_DTTM', width : 70, label : '등록일', align : 'center', editable : false}
		],
		editmode	: true,							// 그리드 editable 여부
		gridtitle	: '메인팝업관리',					// 그리드명
		multiselect	: true,							// checkbox 여부
		formid		: 'search',						// 조회조건 form id
		shrinkToFit	: true,							// 컬럼 width 자동조정
		autowidth	: true,
		height		: 430,						// 그리드 높이
		cellEdit	: false,
		selecturl	: '/psys/getPsys1018List',	// 그리드 조회 URL
		saveurl		: '/psys/savePsys1018',		// 그리드 입력/수정/삭제 URL
		events		: {
			onCellSelect: function(event, rowIdx, colIdx, value){
				
				if(pop_grid.getColName(colIdx) != 'POP_NM')
					return;
				
				var row = pop_grid.getRowData(rowIdx);

				parent.addTab('sub_' + mnu_seq, '시스템팝업상세', '/psys/forward.psys1019.adm', row.MN_POP_SEQ);
			}
		}
	};
	pop_grid = new UxGrid(grid_config);
	pop_grid.init();
	pop_grid.setGridWidth($('.tblType1').width());

	// 전시|비전시 처리
	$(".chg_status").click(function(){
		
		var btnId = $(this).attr("id");
		var chgFlag = "";
		var confirmMsg = "";
		var resultMsg = "";
		var errorMsg = "";
		var chgFlag = "";
		var cnt = 0;
		
		if (btnId == "btn_mainpop_disp_y")
		{
			chgFlag = "Y";
			confirmMsg = "선택한 팝업을 전시하시겠습니까?";
			resultMsg = "해당 팝업이 전시상태로 변경되었습니다.";
			errorMsg = "비전시중인 팝업이 없습니다.";
		}
		else if (btnId == "btn_mainpop_disp_n")
		{
			chgFlag = "N";
			confirmMsg = "선택한 팝업을 비전시하시겠습니까?";
			resultMsg = "해당 팝업이 비전시상태로 변경되었습니다.";
			errorMsg = "전시중인 팝업이 없습니다.";
		}
		
		// JQ GRID CHECK BOX 선택대상 확인
		var params = new Array();	// 전송 파라미터 설정
		var rows = $("#pop_grid").jqGrid('getDataIDs'); // grid의 id 값을 배열로 가져옴
		
		for (var i=0; i < rows.length; i++)
		{
			if($("input:checkbox[id='jqg_pop_grid_"+rows[i]+"']").is(":checked"))
			{
				cnt++;
				
				var rowdata = $("#pop_grid").getRowData(rows[i]);
				
				// 전시 비전시 처리
				if		(chgFlag == "Y" && rowdata.DSPLY_YN == "N") params.push(rowdata.MN_POP_SEQ);
				else if	(chgFlag == "N" && rowdata.DSPLY_YN == "Y") params.push(rowdata.MN_POP_SEQ);
			}
		}
		
		if(cnt == 0)
		{
			var msg = (chgFlag == "Y") ? "전시" : "비전시";
			alert(msg + "할 행을 선택해주세요.");
			return;
		}
		else if(params.length == 0)
		{
			alert(errorMsg);
			return;
		}
		
		if(confirm(confirmMsg))
		{
			// 선택된 행 가운데 복원대상 문서만 복원
			ajax({
				url : "/psys/savePsys1018.adm",
				data: {seq_no_arr:params, chgFlag:chgFlag},
				success: function(data) {
					if(data.RESULT = "S") {
						alert(resultMsg);
						pop_grid.retreive();
					}
				}
			});
		}
	});
	
	// 조회조건 : 전시기간
	setDatepicker("#sch", "_st_dt", "_ed_dt");

	// 조회조건 : 전시기간 시분초 셋팅
	initSelectNumbers();
	
	// 전시기간 날짜 초기화 셋팅
    $("#sch_st_dt").val(formatDate(new Date()));
    $("#sch_ed_dt").val(formatDate(addMonth(new Date())));
    
    // FO/BO 구분 조회조건 설정
    $("#frnt_yn").val("N");

	// 팝업정보 등록/수정 후의 목록 조회
	if(isNotEmpty(_param) && "CHG" == _param)
		$("#btn_search").trigger("click");
});

// grid resizing
$(window).resize(function(){
	pop_grid.setGridWidth($('.tblType1').width());
});


function fn_validationCheck()
{
	var st_dt = $("#sch_st_dt").val();
	var ed_dt = $("#sch_ed_dt").val();
	
	// 날짜 + 시분초 (검색조건 전시기간 입력시)
	if(isEmpty(st_dt) || isEmpty(ed_dt)){
		alert("전시기간을 입력해주세요.");
		return false;
	}

	fn_SetDateTime(true, "sch");
	
	// 팝업 전시시작일시, 종료일시 유효성 검사
	if(!validDateChk($("#h_sch_st_dt").val(), $("#h_sch_ed_dt").val()))
		return false;

	fn_SetDateTime(false, "sch");
	
	return true;
}

//팝업 미리보기
function fn_previewPopup(type, type_bg, txt_top, txt_mid, txt_btm)
{
	var popImgUrl;
	var popOption = null;
    var popSize;
    
	//type : - 01 : 대, 02 : 소
    if(type == '01')
    {
        popOption = {width:"500", height:"700"};
        popSize = "mainPopLong";
    }
    else if(type == '02')
    {
        popOption = {width:"500", height:"400"};
        popSize = "mainPopShort";
    }
    
	var popVer;

	if(type_bg == "01") {
		popVer = 'mainPopVer1'	// 파랑(패턴)
	} else if(type_bg == "02") {
		popVer = 'mainPopVer2';	// 노랑
	} else if(type_bg == "03") {
		popVer = 'mainPopVer3';	// 파랑(이미지)
	}

    var $layer_popup1 = $('<div class="layer_popup"></div>');
    var $layer_img = $('<div class="mainPopWrap ' + popSize + ' ' + popVer + '">'
    				  +	  '<div class="mainPopCon">'
    				  +		'<h1 class="fix">PANDORA3</h1>'
    				  +		'<h2 class="tit">' + txt_top + '</h2>'
    				  +		'<h3 class="subTit">' + txt_mid + '</h3>'
    				  +		'<div class="txt">' + txt_btm + '</div>'
    				  +	  '</div>'
    				  +   '<p class="logo"><img src="${pageContext.request.contextPath}/resources/pandora3/images/common/popLogo.png" alt="pandora3" /></p>'
    				  +   '<p class="btn_mainPopClose"><img src="${pageContext.request.contextPath}/resources/pandora3/images/common/main_popup_btn.png" alt="닫기" /></p>'
    				  +'</div>');
    $("body").append($layer_popup1);
    $layer_popup1.append($layer_img);
    $(".layer_popup").css(popOption);
    
    b_popup = $(".layer_popup").bPopup({
        opacity : 0,
        closeClass : "btn_mainPopClose",
        position : ['50%', '50%']
    });
    
    $(".layer_popup").draggable();
}

function closePop(b_popup){
    b_popup.close();
}

function fn_Search(){
	if(!fn_validationCheck())
		return;
	
	// 페이징이 1page를 초과할 시 초기화
	if($("#pop_grid").jqGrid('getGridParam', 'page') > 1)
		$("#pop_grid").jqGrid('setGridParam', {'page' : 1});

	pop_grid.retreive();	

}

function fn_AddRow(){
	addTabInFrame("/psys/forward.psys1020.adm");
}

function fn_DelRow(){
	pop_grid.remove();
}

function fn_ExcelDownload(){
	var grid_id	= "pop_grid";
	var rows	= $('#pop_grid').jqGrid('getGridParam', 'records');
	var page	= $('#pop_grid').jqGrid('getGridParam', 'page');
	var total	= $('#pop_grid').jqGrid('getGridParam', 'total');
	var title	= $('#pop_grid').jqGrid('getGridParam', 'gridtitle');
	var url		= "/psys/getPsys1018XlsxDwld";  //페이징 존재
	var param	= {};
	param.page	= page;
	param.rows	= rows;
	param.fileName ="시스템 팝업 목록";
	AdvencedExcelDownload(grid_id, url, param);
}

</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
			<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp"%>
			<form name="search" id="search" onsubmit="return false">
				<input type="hidden" id="frnt_yn" name="frnt_yn" />
				<table class="tblType1 mB60">
					<colgroup>
						<col width="15%" />
						<col width="25%" />
						<col width="15%" />
						<col width="15%" />
						<col width="15%" />
						<col width="15%" />
					</colgroup>
					<tr>
						<th>팝업명</th>
						<td><span class="txt_pw"><input type="text" name="pop_nm" id="pop_nm" class="w100" /></span></td>
						<th>팝업유형</th>
						<td>
							<span class="txt_pw">
								<select class="select " name="pop_tp_cd" id="pop_tp_cd">
									<option value="">전체	</options>
									<option value="01">팝업크기(대)</option>
									<option value="02">팝업크기(중)</option>
									<option value="03">팝업크기(소)</option>
								</select>
							</span>
						</td>
						<th>전시여부</th>
						<td>
							<span class="txt_pw">
								<select class="select " name="dsply_yn" id="dsply_yn">
									<option value="">전체</options>
									<option value="Y">전시</option>
									<option value="N">비전시</option>
								</select>
							</span>
						</td>
					</tr>
					<tr>
						<th>전시기간</th>
						<td colspan="5">
							<span class="txt_pw">
								<input type="text" id="sch_st_dt" maxlength="10" />
								<select id="_st_dt_hh" class="select"></select> : 
								<select	id="_st_dt_mm" class="select"></select> : 
								<select id="_st_dt_ss" class="select"></select> ~ 
								<input type="text" id="sch_ed_dt" maxlength="10" />
								<select	id="_ed_dt_hh" class="select"></select> : 
								<select id="_ed_dt_mm" class="select"></select> : 
								<select id="_ed_dt_ss" class="select"></select>
							</span>
							<input type="hidden" id="h_sch_st_dt" name="sch_st_dt" />
							<input type="hidden" id="h_sch_ed_dt" name="sch_ed_dt" />
						</td>
					</tr>
				</table>
			</form>
			<div class="tableBtnWrap gridBtn">
				<div class="tableBtn">
					<button class="btn_common btn_default chg_status" id="btn_mainpop_disp_y">전시</button>
					<button class="btn_common btn_default chg_status" id="btn_mainpop_disp_n">비전시</button>
				</div>
			</div>
			<!-- Grid -->
			<table id="pop_grid"></table>
			<div id="pop_grid_pager"></div>
			<!-- Grid // -->
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
