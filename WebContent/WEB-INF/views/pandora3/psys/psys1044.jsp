<%-- 
   1. 파일명 : psys1045
   2. 파일설명 : 권한 이력
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

var rol_hist_grid;

$(document).ready(function(){
    var grid_config = {
        gridid  : 'rol_hist_grid',
        pagerid : 'rol_hist_grid_pager',
        columns : [
            {name:'HIST_NO', label:'이력번호', hidden:true},
            {name:'ROL_ID', label:'권한ID', editable : false},
            {name:'ROL_NM', label:'권한명', editable : false},
            {name:'ROL_STAT_CD', label : '변경상태', align : 'center', sortable:false, editable : false, formatter : 'select', editoptions : {value:'<%=CodeUtil.getGridComboList("ROL_STAT_CD")%>'}},
            {name:'F_CRT_DTTM', label:'이력생성일자', align:'center', editable : false},
            {name:'CRTR_ID', label:'수정자ID', editable : false},
            {name:'ROL_TYPE', label:'권한 타입', editable : false, formatter : 'select', editoptions : {value:'<%=CodeUtil.getGridComboList("ROL_TYPE")%>'}}
        ],
        gridtitle   : '권한 이력',                 // 그리드명
        formid      : 'search',                     // 조회조건 form id
        shrinkToFit : true,                         // 컬럼 width 자동조정
        autowidth   : true,
        height      : 400,                          // 그리드 높이
        cellEdit    : false,
        selecturl   : '/psys/getPsys1044List.adm',  // 그리드 조회 URL
    };
    rol_hist_grid = new UxGrid(grid_config);
    rol_hist_grid.init();
    rol_hist_grid.setGridWidth($('.tblType1').width());

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
    
});

// grid resizing
$(window).resize(function(){
    rol_hist_grid.setGridWidth($('.tblType1').width());
});

/**************************************************
 * 공통 버튼 
 **************************************************/
 
// 조회 : 내부 로직 사용자 정의
function fn_Search(){
    rol_hist_grid.retreive();
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
    var grid_id = "rol_hist_grid";
    var rows    = $('#rol_hist_grid').jqGrid('getGridParam', 'rowNum');
    var page    = $('#rol_hist_grid').jqGrid('getGridParam', 'page');
    var total   = $('#rol_hist_grid').jqGrid('getGridParam', 'total');
    var title   = $('#rol_hist_grid').jqGrid('getGridParam', 'gridtitle');
    var url     = "/psys/getPsys1021XlsxDwld";  // 페이징 존재
    
    var param   = {};
    param.page  = page;
    param.rows  = rows;
    param.fileName = "로그인이력";
    
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
            <table class="tblType1 typeCal">
                <colgroup>
                    <col style="width: 117px;" />
                    <col style="" />
                    <col style="width: 117px;" />
                    <col style="" />
                </colgroup>   
                <tr>
                    <th>권한ID</th>
                    <td><span class="txt_pw"><input type="text" name="rol_id" id="" class="text"/></span></td>
                    <th>권한명</th>
                    <td><span class="txt_pw"><input type="text" name="rol_nm" id="" class="text"/></span></td>
                    <th>권한타입</th>
                    <td>
                       <select name="rol_type" id="rol_type" class="select">
                           <option value="">전체</option>
                           <option value="GRP_ROL">통합그룹권한</option>
                           <option value="SIT_ROL">사이트권한</option>
                       </select>
                    </td>
                </tr>
                <tr>
                    <th>수정자ID</th>
                    <td><span class="txt_pw"><input type="text" name="sch_crtr_id" id="" class="text"/></span></td>
                    <th>변경상태</th>
                    <td>
                       <select name="rol_stat_cd" id="rol_stat_cd" class="select">
                           <option value="">전체</option>
                           <option value="10">추가</option>
                           <option value="20">삭제</option>
                           <option value="30">수정</option>
                       </select>
                    </td>
                    <th>이력생성일자</th>
                    <td class="typeCal">
                       <div class="cals_div">
                            <span class="txt_pw"><input class="cals w100" type="text" value="" name="sch_crt_st_dt" id="sch_crt_st_dt" autocomplete="off" /></span>
                            <span class="w10 space">~</span>
                            <span class="txt_pw"><input class="cals w100" type="text" value="" name="sch_crt_ed_dt" id="sch_crt_ed_dt" autocomplete="off" /></span>
                        </div>
                    </td>
                </tr>
            </table>
            </form>
        </div>
        <div class="bgBorder"></div>
            <table class="tblType3"><tr><td>&nbsp;</td></tr></table>
            <!-- Grid -->
            <table id="rol_hist_grid"></table>
            <div id="rol_hist_grid_pager"></div>
            <!-- Grid // -->
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
