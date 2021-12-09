<%-- 
   1. 파일명 : psys1022
   2. 파일설명 : VIP 화면 조회 이력
   3. 작성일 : 2019-12-13
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3Front/js/common/jquery.bpopup.min.js"></script>
<style>
.layer_popup {background-color:#fff;border-radius:0;border:1px solid #000;color:#000;display:none;padding:0px;min-width:400px;min-height: 180px}
.layer_popup .btn_close{cursor:pointer;position:absolute;right:10px;top:5px}
</style>
<script type="text/javascript">

var menu_log_grid;

$(document).ready(function(){
	
	var grid_config = { 
		gridid	: 'menu_log_grid',
		pagerid	: 'menu_log_grid_pager',
		columns	:[
			{name : 'USR_ID', label : '사원번호' },
			{name : 'IP_ADDR', label : 'IP주소', width : 50, align : 'center'},
			{name : 'MNU_NM', label : '메뉴명', width : 50},
			{name : 'RQST_URL', label : '요청URL', width : 100},
			{name : 'RQST_PARA', label : '요청 파라미터', width : 200},
			{name : 'CRT_DTTM', label : '등록일시'	 , width : 80, align : 'center', formatter : "date", formatoptions : {srcformat : 'U', newformat: "Y-m-d H:i:s"}}
		],
		gridtitle	: 'VIP개인정보조회이력',					// 그리드명
		formid		: 'search',						// 조회조건 form id
		shrinkToFit	: true,							// 컬럼 width 자동조정
		autowidth	: true,
		height		: 600,							// 그리드 높이
		cellEdit	: false,
		selecturl	: '/psys/getPsys1046List',	// 그리드 조회 URL
	};
	
	menu_log_grid = new UxGrid(grid_config);
	menu_log_grid.init();
	menu_log_grid.setGridWidth($('.tblType1').width());
	
    var obj = {
            
            autoUpdateInput : false,
            showDropdowns: true,
            linkedCalendars: false,
            /* 날짜/일시 선택 start */
            timePicker: true,
            timePicker24Hour: true,
            //viewModel : 'month',
            locale: {
                format: 'YYYY-MM-DD HH:mm'
            }
    }
	
	$("#sch_st_dt").daterangepicker(obj, function(start, end) {
	       
	       $("#sch_st_dt").val(start);
	       $("#sch_ed_dt").val(end);
	       
	}); 
	    
	$("#sch_ed_dt").on('click', function () {
	    $("#sch_st_dt").trigger('click');
	});
	
});

// grid resizing
$(window).resize(function(){
	menu_log_grid.setGridWidth($('.tblType1').width());
});

/**************************************************
 * 공통 버튼 
 **************************************************/
// 조회 : 내부 로직 사용자 정의
function fn_Search(){
	menu_log_grid.retreive();
}

// 추가 : 내부 로직 사용자 정의
function fn_AddRow(){
}

// 저장 : 내부 로직 사용자 정의
function fn_Save(){
}

// 삭제 : 내부 로직 사용자 정의
function fn_DelRow(){
}

// 프린트 : 내부 로직 사용자 정의
function fn_Print(){
}
	
// 엑셀다운로드 : 내부 로직 사용자 정의
function fn_ExcelDownload(){
	var grid_id	= "menu_log_grid";
	var rows	= $('#menu_log_grid').jqGrid('getGridParam', 'rowNum');
	var page	= $('#menu_log_grid').jqGrid('getGridParam', 'page');
	var total	= $('#menu_log_grid').jqGrid('getGridParam', 'total');
	var title	= $('#menu_log_grid').jqGrid('getGridParam', 'gridtitle');
	var url		= "/psys/getPsys1022XlsxDwld";  //페이징 존재
	
	var param	= {};
	param.page	= page;
	param.rows	= rows;
	param.fileName ="메뉴 접속 이력";
	AdvencedExcelDownload(grid_id, url, param);
}
</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
			<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp"%>
			 <div class="frameTopTable">
				<form name="search" id="search" onsubmit="return false">
					<table class="tblType1 typeCal mB60">
						<colgroup>
							<col width="10%" />
							<col width="20%" />
							<col width="10%" />
							<col width="20%" />
							<col width="10%" />
							<col width="30%" />
						</colgroup>
						<tr>
							<th>IP주소</th>
							<td>
								<span class="txt_pw"><input type="text" name="ip_addr" id="ip_addr" class="text w100" /></span>
							</td>
							<th>요청URL</th>
							<td>
								<span class="txt_pw"><input type="text" name="rqst_url" id="rqst_url" class="text w100" /></span>
							</td>
							<th>등록일</th>
	                        <td class="typeCal">
	                           <div class="cals_div">
	                                <span class="txt_pw"><input class="cals w100" type="text" value="" name="sch_st_dt" id="sch_st_dt" autocomplete="off" /></span>
	                                <span class="w10 space">~</span>
	                                <span class="txt_pw"><input class="cals w100" type="text" value="" name="sch_ed_dt" id="sch_ed_dt" autocomplete="off" /></span>
	                            </div>
	                        </td>
						</tr>
					</table>
				</form>
			</div>
        	<div class="bgBorder"></div>
			
			<!-- Grid -->
			<table id="menu_log_grid"></table>
			<div id="menu_log_grid_pager"></div>
			<!-- Grid // -->
			
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
