<%-- 
   1. 파일명 : pdsp1005
   2. 파일설명: 메인팝업 관리
   3. 작성일 : 2018-03-29
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/jquery.bpopup.min.js"></script>
<style>
.layer_popup {background-color:#fff;border-radius:0;border:1px solid #000;color:#000;display:none;padding:0px;min-width:400px;min-height: 180px}
.layer_popup .btn_close{cursor:pointer;position:absolute;right:10px;top:5px}
</style>
<script type="text/javascript">
var menu_id = _menu_id;
var popup_grid;
var b_popup;
$(document).ready(function(){
	var obj;
	var popup_config = { 
		// grid id
		gridid: 'popup_grid',
		pagerid: 'popup_grid_pager',
		// column info
		columns:[
				{name:'MN_POP_SEQ',		width:100, label:'팝업번호', hidden:true},
				{name:'TOP_TXT',		width:100, label:'상단문구', hidden:true},
				{name:'MID_TXT',		width:100, label:'중단문구', hidden:true},
				{name:'BTM_TXT',		width:100, label:'하단문구', hidden:true},
				{name:'BKG_TP_CD',		width:100, label:'배경타입', hidden:true},
				{name:'POP_URL',		width:100, label:'POP_URL', hidden:true},
				/* {name:'SIT_NM',		width:50, label:'사이트명'}, */
				{name:'POP_NM',		width:100, label:'팝업명',sortable:false,
					 cellattr: function(rowId, tv, rowObject, cm, rdata) {if(isNotEmpty(rowObject.POP_NM)){ return 'style="cursor: pointer; text-decoration: underline;"'}}},
				{name:'POP_KD_CD',		width:100, label:'팝업종류', align:'center', formatter:'select', editoptions:{value:'10:TEXT 팝업;20:URL 팝업'}},
				{name:'POP_TP_CD',			width:50, label:'팝업유형', align:'center', formatter:'select', editoptions:{value:'01:팝업크기(대);02:팝업크기(소)'}},
				{name:'F_ST_DTTM',		width:100, label:'전시시작일시', align:'center', sortable:false},
				{name:'F_ED_DTTM',		width:100, label:'전시종료일시',align:'center', sortable:false},
				{name:'DSPLY_YN',		width:50, label:'전시여부', align:'center', formatter:'select', editoptions:{value:'Y:전시;N:비전시;'}},
				{name:'CRTR_ID',			width:50, label:'등록자', align:'center', editable:false},
				{name:'PREVIEW',		width:50, label :'미리보기', align : 'center'
					, formatter : function(cellValue, options, rowObject){
						return "<input type='button' value='보기' class='in_grid_button preview' onclick='callPopupPreview("+options.rowId+")'></button>";
						}
				}, 
				{name:'F_CRT_DTTM',		width:70, label:'등록일', align:'center', editable:false}
		],
		editmode: true,                   // 그리드 editable 여부
		gridtitle: '메인팝업관리',            // 그리드명
		multiselect: true,                // checkbox 여부
		formid: 'search',                 // 조회조건 form id
		shrinkToFit: true,                // 컬럼 width 자동조정
		autowidth: true,
		height: 401,                      // 그리드 높이
		cellEdit:false,
		selecturl: '/pdsp/getPdsp1005List.adm',   // 그리드 조회 URL
		saveurl: '/pdsp/savePdsp1005.adm',     // 그리드 입력/수정/삭제 URL
		events: {
			onCellSelect: function(event, rowid, icol, conts) {
				var row = popup_grid.getRowData(rowid);
				if (popup_grid.getColName(icol) == 'POP_NM') {
					parent.addTab('sub'+menu_id, '메인팝업상세', '/pdsp/forward.pdsp1006.adm', row.MN_POP_SEQ);
				}
			}
		}
	};
	popup_grid = new UxGrid(popup_config);
	popup_grid.init();
	popup_grid.setGridWidth($('.tblType1').width());

	// 전시|비전시 처리
	$(".chg_status").click(function() {
		var btnId = $(this).attr("id");
		var chgFlag = "";
		var confirmMsg = "";
		var resultMsg = "";
		var errorMsg = "";
		var chgFlag = "";
		var cnt = 0;
		if (btnId == "btn_mainpop_disp_y") {
			chgFlag = "Y";
			confirmMsg = "선택한 팝업을 전시하시겠습니까?";
			resultMsg = "해당 팝업이 전시상태로 변경되었습니다.";
			errorMsg = "비전시중인 팝업이 없습니다.";
		}
		else if (btnId == "btn_mainpop_disp_n") {
			chgFlag = "N";
			confirmMsg = "선택한 팝업을 비전시하시겠습니까?";
			resultMsg = "해당 팝업이 비전시상태로 변경되었습니다.";
			errorMsg = "전시중인 팝업이 없습니다.";
		}
		// JQ GRID CHECK BOX 선택대상 확인
		var params = new Array();	// 전송 파라미터 설정
		var idArry = $("#popup_grid").jqGrid('getDataIDs'); //grid의 id 값을 배열로 가져옴
		for (var i = 0; i < idArry.length; i++) {
			if($("input:checkbox[id='jqg_popup_grid_"+idArry[i]+"']").is(":checked")){
				cnt++;
				var rowdata = $("#popup_grid").getRowData(idArry[i]);
				// 전시 비전시 처리
				if		(chgFlag == "Y" && rowdata.DSPLY_YN == "N") params.push(rowdata.MN_POP_SEQ);
				else if	(chgFlag == "N" && rowdata.DSPLY_YN == "Y") params.push(rowdata.MN_POP_SEQ);
			}
		}
		if(cnt == 0) {
			var msg = (chgFlag == "Y") ? "전시" : "비전시";
			alert(msg + "할 행을 선택해주세요.");
			return;
		}
		else if(params.length == 0) {
			alert(errorMsg);
			return;
		}
		
		if(confirm(confirmMsg)) {
			// 선택된 행 가운데 복원대상 문서만 복원
			ajax({
				url : "/pdsp/savePdsp1005.adm",
				data: {seq_no_arr:params, chgFlag:chgFlag},
				success: function(data) {
					if(data.RESULT = "S") {
						alert(resultMsg);
						popup_grid.retreive();
					}
				}
			});
		}
	});
	
	// 전시기간(시작일/종료일)
	setDatepicker("#sch", "_st_dt", "_ed_dt");
	initSelectNumbers();
	
	// 전시기간 날짜 초기화 셋팅
    var today  = new Date();
    $("#sch_st_dt").val(formatDate(today));
    
    var addMonthDay = addMonth(today);
    $("#sch_ed_dt").val(formatDate(addMonthDay));
    
 	// 팝업정보 등록/수정 후의 목록 조회
	if(isNotEmpty(_param) && "CHG" == _param) $("#btn_search").trigger("click");
	
});

// grid resizing
$(window).resize(function(){
	popup_grid.setGridWidth($('.tblType1').width());
});

// 한글 체크
function validDate() {
	
	var strFrom = $("#sch_st_dt").val();
	var strTo   = $("#sch_ed_dt").val();
	
	// 날짜 + 시분초 (검색조건 전시기간 입력시)
	if(isEmpty(strFrom) || isEmpty(strTo)){
		alert("전시기간을 입력해주세요.");
		return false;
	}
	
	if(is_hangul_char(strFrom)) {
		alert("잘못된 날짜 형식을 입력하셨습니다."); 
		$("#sch_st_dt").val("");
		$("#sch_st_dt").focus();
		return false;
	}
	if(is_hangul_char(strTo)) {
		alert("잘못된 날짜 형식을 입력하셨습니다."); 
		$("#sch_ed_dt").val("");
		$("#sch_ed_dt").focus();
		return false;
	}
	
	// 스트링타입의 날짜포맷 ex) "2019-01-17 10:13:00"
	var strFromDate = $("#sch_st_dt").val() + " " + $("#_st_dt_hh").val() + ":" + $("#_st_dt_mm").val() + ":" + $("#_st_dt_ss").val();
	var strToDate   = $("#sch_ed_dt").val()   + " " + $("#_ed_dt_hh").val()   + ":" + $("#_ed_dt_mm").val()   + ":" + $("#_ed_dt_ss").val();

	// 팝업 전시시작일시, 종료일시 유효성 검사
	if(!validDateChk(strFromDate, strToDate)) {
		return false;
	}
	
	return true;
}

// Form 전송용 DateTime 설정
function formSetDateTime(id, isFrom, isTo) {
	var idPrefixs = "#h_";
	var idSuffixs = ["_st_dt","_ed_dt"];
	var flagArr = new Array();
	flagArr.push(isFrom);
	flagArr.push(isTo);
	
	for(var i = 0; i < idSuffixs.length; i++) {
		if(flagArr[i]) $(idPrefixs+id+idSuffixs[i]).val($("#"+id+idSuffixs[i]).val().replace(/-/gi, "") + $("#"+idSuffixs[i]+"_hh").val() + $("#"+idSuffixs[i]+"_mm").val() + $("#"+idSuffixs[i]+"_ss").val());
		else $(idPrefixs+id+idSuffixs[i]).val("");
	}
}

//팝업 미리보기
function callPopupPreview(rowid) {
	var row           = popup_grid.getRowData(rowid);
	var type          = row.POP_TP_CD;
	var type_bg       = row.BKG_TP_CD;
	var txt_top       = row.TOP_TXT.replace(/(\n|\r\n)/g, '<br>');
	var txt_mid       = row.MID_TXT.replace(/(\n|\r\n)/g, '<br>');
	var txt_btm       = row.BTM_TXT.replace(/(\n|\r\n)/g, '<br>');
	var pop_kd_cd     = row.POP_KD_CD;
	var pop_url       = row.POP_URL;
	var popImgUrl;
	var popOption     = null;
    var popSize;
    var $layer_popup1 = null;
    var $layer_img    = null;
    
	//type : - 10 : 대, 20 : 소
    if(type == '01') {
        popOption = {width:"500", height:"700"};
        popSize = "mainPopLong";
        pointX = "50%"; 
        pointY = "50%";
    } else if(type == '02') {
        popOption = {width:"500", height:"400"};
        popSize = "mainPopShort";
        pointX = "50%";
        pointY = "50%"; 
    }
    
    $layer_popup1 = $('<div class="layer_popup"></div>');
    
	// popup 종류에 따른 분기처리 10 - text popup 20 - url popup
	if(pop_kd_cd == "10") {
		var popVer;
		if(type_bg == "01") {
			popVer = 'mainPopVer1'	// 파랑(패턴)
		} else if(type_bg == "02") {
			popVer = 'mainPopVer2';	// 노랑
		} else if(type_bg == "03") {
			popVer = 'mainPopVer3';	// 파랑(이미지)
		}
		
		$layer_img = $('<div class="mainPopWrap '+popSize+' '+popVer+'">'
				  +	  '<div class="mainPopCon">'
				  +		'<h1 class="fix">PANDORA3</h1>'
				  +		'<h2 class="tit">'+txt_top+'</h2>'
				  +		'<h3 class="subTit">'+txt_mid+'</h3>'
				  +		'<div class="txt">'+txt_btm+'</div>'
				  +	  '</div>'
				  +   '<p class="logo"><img src="${pageContext.request.contextPath}/resources/pandora3/images/common/popLogo.png" alt="pandora3" /></p>'
				  +   '<p class="btn_mainPopClose"><img src="${pageContext.request.contextPath}/resources/pandora3/images/common/main popup_btn.png" alt="닫기" /></p>'
				  +'</div>');
	}else if(pop_kd_cd == "20") { 
		$layer_img = $('<div class="mainPopWrap '+popSize+' '+popVer+'">'
				  +	  '<div class="mainPopCon">'
				  +   '<iframe src='+ pop_url +'></iframe>'
				  +	  '</div>'
				  +   '<p class="logo"><img src="${pageContext.request.contextPath}/resources/pandora3/images/common/popLogo.png" alt="pandora3" /></p>'
				  +   '<p class="btn_mainPopClose"><img src="${pageContext.request.contextPath}/resources/pandora3/images/common/main popup_btn.png" alt="닫기" /></p>'
				  +'</div>');
	}
    
    $("body").append($layer_popup1);
    $layer_popup1.append($layer_img);
    $(".layer_popup").css(popOption);
    
    b_popup = $(".layer_popup").bPopup({
        opacity: 0,
        closeClass : "btn_mainPopClose",
        position: [pointX, pointY]

    });
}

function closePop(b_popup){
    b_popup.close();
}
function fn_Search(){
	if(validDate()) {
		// 페이징이 1page를 초과할 시 초기화
		if($("#popup_grid").jqGrid('getGridParam', 'page') > 1) $("#popup_grid").jqGrid('setGridParam', {'page' : 1});
		
		formSetDateTime("sch", isNotEmpty($("#sch_st_dt").val()), isNotEmpty($("#sch_ed_dt").val()));

		popup_grid.retreive();	
	}
}
function fn_Add(){
	addTabInFrame("/pdsp/forward.pdsp1007.adm");
}
function fn_Delete(){
	popup_grid.remove(); // {success:function(){alert('remove success');}}
}
function fn_ExcelDownload(){
	var grid_id = "popup_grid";
	var rows = $('#popup_grid').jqGrid('getGridParam', 'rowNum');
	var page = $('#popup_grid').jqGrid('getGridParam', 'page');
	var total = $('#popup_grid').jqGrid('getGridParam', 'total');
	var title = $('#popup_grid').jqGrid('getGridParam', 'gridtitle');
	var url = "/pdsp/getPdsp1005XlsxDwld.adm";  //페이징 존재
	var param ={};
	param.page=page;
	param.rows=rows;
	param.filename ="메인 팝업 목록";
	AdvencedExcelDownload(grid_id,url,param);
}

</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
		<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
			<div class="frameTopTable">
				<form name="search" id="search" onsubmit="return false">
					<table class="tblType1">
	                        <colgroup>
	                            <col style="width: 117px;" />
	                            <col style="" />
	                            <col style="width: 117px;" />
	                            <col style="" />
	                            <col style="width: 117px;" />
	                            <col style="" />
	                        </colgroup>
						<tr> 
							<th>팝업명</th>
							<td><span class="txt_pw"><input type="text" name="pop_nm" id="pop_nm" class="w100"/></span></td>
							<th>팝업유형</th>
							<td><%=CodeUtil.getSelectComboList("POP_TP_CD", "pop_tp_cd", "전체", "", "", "class=\"select\"")%></td>
							<th>팝업종류</th>
							<td><%=CodeUtil.getSelectComboList("POP_KD_CD", "pop_kd_cd", "전체", "", "", "class=\"select\"")%></td>
						</tr>
						<tr>
							<th>전시기간</th>
							<td class="type_show"> 
								<span class="txt_pw">
									<input type="text" id="sch_st_dt"/>
								</span>
								<span class="txt_pw type_three">
									<select id="_st_dt_hh" class="select"></select>
									<span class="colon">:</span>
									<select id="_st_dt_mm" class="select"></select> 
									<span class="colon">:</span>
									<select id="_st_dt_ss" class="select"></select>
								</span>
								<span class="space">~</span>
								<span class="txt_pw">
									<input type="text" id="sch_ed_dt"/>
								</span>
								<span class="txt_pw type_three">
									<select id="_ed_dt_hh" class="select"></select>
									<span class="colon">:</span>
									<select id="_ed_dt_mm" class="select"></select>
									<span class="colon">:</span> 
									<select id="_ed_dt_ss" class="select"></select>
								</span>
								<input type="hidden" id="h_sch_st_dt" name="sch_st_dt" />
								<input type="hidden" id="h_sch_ed_dt" name="sch_ed_dt" />
							</td>
							<th>전시여부</th>
							<td><span class="txt_pw"><select class="select " name="dsply_yn" id="dsply_yn"><option value="">전체</option><option value="Y">전시</option><option value="N">비전시</option></select></span></td>
						</tr>
					</table>
				</form>
			</div>
			<div class="bgBorder"></div> 
			<div class="grid_right_btn">
				<div class="grid_right_btn_in">
					<button class="btn_common btn_default chg_status" id="btn_mainpop_disp_y">전시</button>
					<button class="btn_common btn_default chg_status" id="btn_mainpop_disp_n">비전시</button>
				</div>
			</div> 

			<!-- Grid -->
			<table id="popup_grid"></table>
			<div id="popup_grid_pager"></div>
			<!-- Grid // -->
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
