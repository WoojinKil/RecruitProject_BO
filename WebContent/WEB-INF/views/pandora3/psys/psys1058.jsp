<%-- 
   1. 파일명 : psys1058
   2. 파일설명 : 메뉴별 클릭 수
   3. 작성일 : 2020-04-06
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
_grid_rows_list = [50,100,500,10000];
var menuacs_tot_grid;

$(document).ready(function(){
	
	var grid_config = { 
		gridid	: 'menuacs_tot_grid',
		gridBtnYn : 'Y',              // 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
		pagerid	: 'menuacs_tot_grid_pager',
		columns	:[
			{name : 'SYS_NM', label : '시스템 구분', align : 'center'},
			{name : 'DEPTH_FULLNAME', label : '메뉴 명', align : 'center'},
			{name : 'MENU_ACS', label : '메뉴 접속자수', align : 'center',formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' }},
			{name : 'MENU_VST_CUST_CNT', label : '메뉴 클릭수(*)', align : 'center',formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' }},
			{name : 'UV_VST_CUST_CNT', label : '인당 클릭수', align : 'center',formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' }},
			
		],
		gridtitle	: '시스템별 접속자수',					// 그리드명
		formid		: 'search',						// 조회조건 form id
		shrinkToFit	: true,							// 컬럼 width 자동조정
		autowidth	: true,
		height		: 400,							// 그리드 높이
		cellEdit	: false,
		selecturl	: '/psys/selectPsys1058List',	// 그리드 조회 URL
		events        : {
        }
	};
	
	menuacs_tot_grid = new UxGrid(grid_config);
	menuacs_tot_grid.init();
	menuacs_tot_grid.setGridWidth($('.tblType1').width());
	
    var obj = {
            
            autoUpdateInput : false,
            showDropdowns: true,
            linkedCalendars: false,
            /* 날짜/일시 선택 start */
            timePicker: false,
            timePicker24Hour: false,
            //viewModel : 'month',
            locale: {
                format: 'YYYY-MM-DD'
            }
    }
    

    var yesterday = moment().add(-1, "day").format("YYYY-MM-DD");
    $("#sch_st_dt").val(yesterday);
    $("#sch_ed_dt").val(yesterday);
	
	$("#sch_st_dt").daterangepicker(obj, function(start, end) {
	       
	       $("#sch_st_dt").val(start);
	       $("#sch_ed_dt").val(end);
	       
	}); 
	    
	$("#sch_ed_dt").on('click', function () {
	    $("#sch_st_dt").trigger('click');
	});
	
	
	
	ajax({
		url : '/psys/selectPsys1057TsysAdmGrpRolList',
		success : function(data) {
			if(data.RESULT == _boolean_success) {
				
				$("#grp_rol_id").empty();
				$("#grp_rol_id").append("<option value=''>전체</option> ");
				
				$(data.rows).each(function(itm, idx) {
					$("#grp_rol_id").append("<option value='" + this.GRP_ROL_ID+ "'>" + this.GRP_ROL_NM + "</option> ");
				});
				
				$("#grp_rol_id").append("<option value='etc'>etc</option> ");
			}
		}
	})
	
	getSystemList();
	
});

// grid resizing
$(window).resize(function(){
	menuacs_tot_grid.setGridWidth($('.tblType1').width());
});

//사이트 리스트 취득
function getSystemList() {
    var html = "";
    ajax({
        url     : "/pdsp/getPdsp1011ListLogSit",
        data    : {sys_cd : _sys_cd, ref_2 : "pandora_use"} ,
        success : function (data) {
            if (data.RESULT == "S") {
                var sitListCnt = data.rows.length;
                $(data.rows).each(function (index) {
                    // 조회 건수가 하나일 경우 단일 하나의 시스템
                    if(sitListCnt == 1) {
                        $("#sys_cd option").remove();
                        html += "<option  class='passOption' value="+ this.SYS_CD +" selected='selected' >"+ this.SYS_NM +"</option>"
                        return false;
                    } else {
                        html += "<option class='passOption' value="+ this.SYS_CD +">"+ this.SYS_NM +"</option>"
                    }
                });
                $("#sys_cd").append(html);
            }
        }
    });
}

/**************************************************
 * 공통 버튼 
 **************************************************/
// 조회 : 내부 로직 사용자 정의
function fn_Search(){
	menuacs_tot_grid.retreive();
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
	var grid_id	= "menuacs_tot_grid";
	var rows	= $('#menuacs_tot_grid').jqGrid('getGridParam', 'rowNum');
	var page	= $('#menuacs_tot_grid').jqGrid('getGridParam', 'page');
	var total	= $('#menuacs_tot_grid').jqGrid('getGridParam', 'total');
	var title	= $('#menuacs_tot_grid').jqGrid('getGridParam', 'gridtitle');
	var url		= "/psys/getPsys1058XlsxDwld";  
	
	var param	= {};
	param.page	= page;
	param.rows	= rows;
	param.fileName ="시스템별 접속자수";
	gridExcelDownload(grid_id, url, param);
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
                            <col style="width: 117px;" />
                            <col style="" />
                            <col style="width: 117px;" />
                            <col style="" />
                            <col style="width: 117px;" />
                            <col style="" />
	                    </colgroup>
						<tr>
						    <th>시스템명</th>
                            <td>
                                <select name="sys_cd" id="sys_cd" class="select">
                                    <option value="">전체</option>
                                </select>
                            </td>
							<th>기간</th>
	                        <td class="typeCal">
	                           <div class="cals_div">
	                                <span class="txt_pw"><input class="cals w100" type="text" value="" name="sch_st_dt" id="sch_st_dt" autocomplete="off" /></span>
	                                <span class="w10 space">~</span>
	                                <span class="txt_pw"><input class="cals w100" type="text" value="" name="sch_ed_dt" id="sch_ed_dt" autocomplete="off" /></span>
	                            </div>
	                        </td>
							<th>통합 그룹</th>
							<td>
								<select id="grp_rol_id" name="grp_rol_id" class="select">
								
								</select>
							</td>
						</tr>
					</table>
				</form>
			</div>
        	<div class="bgBorder"></div>
			
			<!-- Grid -->
			<table id="menuacs_tot_grid"></table>
			<div id="menuacs_tot_grid_pager"></div>
			<!-- Grid // -->
			
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
