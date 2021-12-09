<%-- 
   1. 파일명 : psys1021
   2. 파일설명 : 로그인이력
   3. 작성일 : 2018-04-24
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/jquery.bpopup.min.js"></script>
<style>
.layer_popup {background-color:#fff;border-radius:0;border:1px solid #000;color:#000;display:none;padding:0px;min-width:400px;min-height: 180px}
.layer_popup .btn_close{cursor:pointer;position:absolute;right:10px;top:5px}
</style>
<script type="text/javascript">
_grid_rows_list = [50,100,500,10000];
var login_log_grid;

$(document).ready(function(){
	var grid_config = {
		gridid	: 'login_log_grid',
		pagerid	: 'login_log_grid_pager',
		gridBtnYn : 'Y',
		columns	: [
			{name:'LGN_DTTM', label:'로그인 일시', hidden:true, align:'center', formatter : 'date', formatoptions : {srcformat : 'U', newformat: 'Y-m-d H:i:s'}},
			{name:'USR_ID', label:'사번'},
			{name:'IP_ADDR', label:'IP주소', align:'center'},
			{name:'F_LGN_DTTM', label:'로그인 일시', align:'center'},
			{name : 'SYS_NM', label : '시스템 명', align : 'center', width : 100}
		],
		gridtitle	: '로그인이력',					// 그리드명
		formid		: 'search',						// 조회조건 form id
		shrinkToFit	: true,							// 컬럼 width 자동조정
		autowidth	: true,
		height		: 400,							// 그리드 높이
		cellEdit	: false,
		selecturl	: '/psys/getPsys1021List.adm',	// 그리드 조회 URL
	};
	login_log_grid = new UxGrid(grid_config);
	login_log_grid.init();
	login_log_grid.setGridWidth($('.tblType1').width());
	
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
   getSystemList();
});

// grid resizing
$(window).resize(function(){
	login_log_grid.setGridWidth($('.tblType1').width());
});

/**************************************************
 * 공통 버튼 
 **************************************************/
 
// 조회 : 내부 로직 사용자 정의
function fn_Search(){
	login_log_grid.retreive();
}
// 추가 : 내부 로직 사용자 정의
function fn_Add(){
	
}
// 저장 : 내부 로직 사용자 정의
function fn_Save(){
	
}
// 삭제 : 내부 로직 사용자 정의
function fn_Delete(){
	
}
// 프린트 : 내부 로직 사용자 정의
function fn_Print(){

}
// 엑셀다운로드 : 내부 로직 사용자 정의
function fn_ExcelDownload(){
	var grid_id	= "login_log_grid";
	var rows	= $('#login_log_grid').jqGrid('getGridParam', 'rowNum');
	var page	= $('#login_log_grid').jqGrid('getGridParam', 'page');
	var total	= $('#login_log_grid').jqGrid('getGridParam', 'total');
	var title	= $('#login_log_grid').jqGrid('getGridParam', 'gridtitle');
	var url		= "/psys/getPsys1021XlsxDwld";  // 페이징 존재
	
	var param	= {};
	param.page	= page;
	param.rows	= rows;
	param.fileName = "로그인이력";
	
	AdvencedExcelDownload(grid_id,url,param);
}

//사이트 리스트 취득
function getSystemList() {
    var html = "";
    ajax({
        url     : "/pdsp/getPdsp1011ListLogSit",
        success : function (data) {
            if (data.RESULT == "S") {
                var sitListCnt = data.rows.length;
                $(data.rows).each(function (index) {
                    // 조회 건수가 하나일 경우 단일 시스템
                    if(sitListCnt == 1) {
                        html += "<option value="+ this.SYS_CD +" selected='selected' >"+ this.SYS_NM +"</option>"
                        return false;
                    } else {
                        html += "<option value="+ this.SYS_CD +">"+ this.SYS_NM +"</option>"
                        $("#sys_info").closest('div').show();
                    }
                });
                $("#sys_cd").append(html);
            }
        }
    });
    
}
</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
		<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
		<div class="frameTopTable">
			<form name="search" id="search" onsubmit="return false">
			<table class="tblType1 typeCal">
				<colgroup>
					<col style="width: 117px;" />
					<col style="" />
					<col style="width: 80px;" />
					<col style="" />
					<col style="width: 117px;" />
					<col style="" />
				</colgroup>
				<tr>
					<th>시스템 명</th>
					<td>
						<select name="sys_cd" id="sys_cd" class="select">
							<option value="">전체</option>
						</select>
					</td>
					<th>IP주소</th> 
					<td><span class="txt_pw"><input type="text" name="ip_addr" id="ip_addr" class="text w100"/></span></td>
					<th>로그인날짜</th>
					<td class="typeCal">
						<span class="cals_div">
							<span class="txt_pw"><input type="text" id="sch_st_dt" name="sch_st_dt" class="cals w100"/></span>
							<span class="w10 space">~</span>
							<span class="txt_pw"><input type="text" id="sch_ed_dt" name="sch_ed_dt" class="cals w100"/></span>
						</span>
					</td>
				</tr>
			</table>
			</form>
		</div>
			<table class="tblType3"><tr><td>&nbsp;</td></tr></table>
			<!-- Grid -->
			<table id="login_log_grid"></table>
			<div id="login_log_grid_pager"></div>
			<!-- Grid // -->
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
