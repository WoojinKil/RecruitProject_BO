<%-- 
   1. 파일명 : psys1045
   2. 파일설명 : 권한 신청 이력
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

var rol_app_hist_grid;
_grid_rows_list = [50,100,500,10000];

$(document).ready(function(){
    var grid_config = {
        gridid  : 'rol_app_hist_grid',
        pagerid : 'rol_app_hist_grid_pager',
        gridBtnYn : 'Y',                // 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        columns : [
            {name:'HIST_NO', label:'이력번호', hidden:true, frozen : true},
            {name:'APPL_NO', label:'신청번호', hidden:true, frozen : true},
            {name:'CSTR_NM', label:'점', frozen : true, width: 150},
            {name:'ORG_NM', label:'부서명', frozen : true, width: 150},
            {name:'USR_ID', label:'신청자 사번', frozen : true, width: 150},
            {name:'POS_NM', label:'신청자 직책', frozen : true, width: 150},
            {name:'SYS_NM', label:'시스템', frozen : true, width: 150},
            {name:'ROL_NM', label:'권한명', frozen : true, width: 150},
            {name:'APPL_STAT_NM', label : '승인여부', align : 'center', sortable:false, editable : false, frozen : true, width: 150},
            {name:'APVL_USR_ID', label:'승인자 사번', align:'center', frozen : true, width: 150},
            {name:'F_CRT_DTTM', label:'신청일자', align:'center'},
            {name:'APPL_RSN_CONT', label:'신청사유', frozen : true, width: 150},
            {name:'F_APVL_DTTM', label:'승인일자', align:'center'},
            {name:'ORG_NM', label:'조직명', hidden:true},
            {name:'APVL_YN', label:'처리여부', hidden:true},
            {name:'APVL_RFS_RSN_CONT', label:'반려사유', frozen : true, width: 150},
        ],
        gridtitle   : '권한신청이력',                 // 그리드명
        formid      : 'search',                     // 조회조건 form id
        shrinkToFit : true,                         // 컬럼 width 자동조정
        autowidth   : true,
        height      : 400,                          // 그리드 높이
        cellEdit    : false,
        selecturl   : '/psys/getPsys1045List.adm',  // 그리드 조회 URL
    };
    rol_app_hist_grid = new UxGrid(grid_config);
    rol_app_hist_grid.init();
    rol_app_hist_grid.setGridWidth($('.tblType1').width());

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
    
    $("#sch_crt_st_dt").daterangepicker(obj, function(start, end) {
        
        $("#sch_crt_st_dt").val(start);
        $("#sch_crt_ed_dt").val(end);
        
    }); 
    
    $("#sch_crt_ed_dt").on('click', function () {
        $("#sch_crt_st_dt").trigger('click');
   });
    
    $("#sch_apvl_st_dt").daterangepicker(obj, function(start, end) {
        
        $("#sch_apvl_st_dt").val(start);
        $("#sch_apvl_ed_dt").val(end);
        
    }); 
    
    $("#sch_apvl_ed_dt").on('click', function () {
        $("#sch_apvl_st_dt").trigger('click');
   });
    
    getSystemList();
    
    
    
});

// grid resizing
$(window).resize(function(){
    rol_app_hist_grid.setGridWidth($('.tblType1').width());
});

/**************************************************
 * 공통 버튼 
 **************************************************/
 
// 조회 : 내부 로직 사용자 정의
function fn_Search(){
    rol_app_hist_grid.retreive();
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
    var grid_id = "rol_app_hist_grid";
    var rows    = $('#rol_app_hist_grid').jqGrid('getGridParam', 'rowNum');
    var page    = $('#rol_app_hist_grid').jqGrid('getGridParam', 'page');
    var total   = $('#rol_app_hist_grid').jqGrid('getGridParam', 'total');
    var title   = $('#rol_app_hist_grid').jqGrid('getGridParam', 'gridtitle');
    var url     = "/psys/getPsys1045XlsxDwld";  // 페이징 존재
    
    var param   = {};
    param.page  = page;
    param.rows  = rows;
    param.fileName = "로그인이력";
    
    AdvencedExcelDownload(grid_id,url,param);
}

//사이트 리스트 취득
function getSystemList() {
    var html = "";
    ajax({
        url     : "/pdsp/getPdsp1011ListSit",
        success : function (data) {
            if (data.RESULT == "S") {
                var sitListCnt = data.rows.length;
                $(data.rows).each(function (index) {
                    html += "<option value="+ this.SYS_CD +">"+ this.SYS_NM +"</option>"
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
	                    <col style="width: 117px;" />
	                    <col style="" />
	                    <col style="width: 117px;" />
	                    <col style="" />
	                </colgroup>   
	                <tr>
	                    <th>신청자 사번</th>
	                    <td><span class="txt_pw"><input type="text" name="usr_id" id="usr_id" class="text"/></span></td>
	                    <th>승인자 사번</th>
	                    <td><span class="txt_pw"><input type="text" name="apvl_usr_id" id="apvl_usr_id" class="text"/></span></td>
	                    <th>승인여부</th>
	                    <td>
	                        <%=CodeUtil.getSelectComboList("APPL_STAT_CD","appl_stat_cd", "전체", "1","") %>
	                    </td>
	                </tr>
	                <tr>
	                    <th>신청일자</th>
	                    <td class="typeCal">
	                       <div class="cals_div">
	                            <span class="txt_pw"><input class="cals w100" type="text" value="" name="sch_crt_st_dt" id="sch_crt_st_dt" autocomplete="off" /></span>
	                            <span class="w10 space">~</span>
	                            <span class="txt_pw"><input class="cals w100" type="text" value="" name="sch_crt_ed_dt" id="sch_crt_ed_dt" autocomplete="off" /></span>
	                        </div>
	                    </td>
	                    <th>승인일자</th>
	                    <td class="typeCal">
	                       <div class="cals_div">
	                            <span class="txt_pw"><input class="cals w100" type="text" value="" name="sch_apvl_st_dt" id="sch_apvl_st_dt" autocomplete="off" /></span>
	                            <span class="w10 space">~</span>
	                            <span class="txt_pw"><input class="cals w100" type="text" value="" name="sch_apvl_ed_dt" id="sch_apvl_ed_dt" autocomplete="off" /></span>
	                        </div>
	                    </td>
	                    <th>시스템</th>
	                    <td>
	                        <select name="sys_cd" id="sys_cd" class="select">
	                           <option value="">전체</option>
	                       </select>
	                    </td>
	                </tr>
	                <tr>
	                    <th>권한명</th>
	                    <td><span class="txt_pw"><input type="text" name="rol_nm" id="rol_nm" class="text"/></span></td>
	                </tr>
	            </table>
	            </form>
	        </div>
			<div class="bgBorder"></div> 
            <table class="tblType3"><tr><td>&nbsp;</td></tr></table>
            <!-- Grid -->
            <table id="rol_app_hist_grid"></table>
            <div id="rol_app_hist_grid_pager"></div>
            <!-- Grid // -->
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
