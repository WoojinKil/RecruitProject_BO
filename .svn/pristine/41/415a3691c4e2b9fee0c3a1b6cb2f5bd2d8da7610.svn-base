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
        url     : '/psys/getPsysCommon',
        data    : $("form[name=frm_sysCdDtl]").serialize(),
        success : function(data) {
            for(i=0; i<data.selectData.length; i++)
                $("#usr_stat_cd").append("<option value='" + data.selectData[i].CD+ "'>" + data.selectData[i].CD_NM + "</option> ");
        }
    });
    
    var grid_config = { 
        gridid    : 'admin_grid',
        pagerid   : 'admin_grid_pager',
        gridBtnYn : 'Y',                        // 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        columns   : [
            {name : 'LGN_ID', label : '아이디', sortable:false, editable : false, hidden : true},
            {name : 'CRTR_ID', label :'등록자', hidden : true},
            {name : 'UPDR_ID', label :'수정자', hidden : true},
            {name : 'STATUS', label : '상태', align : 'center', editable : false, width:30},
            {name : 'USR_ID', label :'사번', sortable:false, editable : false},
            /* {name : 'USR_EML_ADDR', label : '이메일', sortable : false, editable : false}, */
            {name : 'USR_STAT_CD', label : '계정상태', align : 'center', sortable:false, editable : false, formatter : 'select', editoptions : {value:'<%=CodeUtil.getGridComboList("MSTS")%>'}},
            {name : 'USR_NM', label : '성명', sortable:false, editable : false},
            {name : 'ACTV_YN', label : '계정활성화', align : 'center', editable : false, edittype:'select', formatter : 'select', editoptions : {value:'Y:활성화;N:비활성화'}},
            {name : 'F_CRT_DTTM', label : '가입일자',   align : 'center', editable : false},
            {name : 'F_UPD_DTTM', label : '수정일자',   align : 'center', editable : false},
            {name : 'PWD_FAIL_CNT', label : '비밀번호 틀린 횟수', align : 'right', editable : false},
            {name : 'PWD_RESET', label : '잠금 해제', align : 'center', formatter : setFailDateResetBtn}
        ],          
//      initval     : {US_YN : 'Y', SORT_ORD : 999, MST_CD : 'A00'}, // 컬럼 add 시 초기값
        editmode    : true,                                 // 그리드 editable 여부
        gridtitle   : '사원관리 목록',                        // 그리드명
        multiselect : true,                                 // checkbox 여부
        formid      : 'search',                             // 조회조건 form id
        height      : '300',                                // 그리드 높이
        shrinkToFit : true,                                 // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl   : '/psys/getPsys1007List',          // 그리드 조회 URL
        saveurl     : '/psys/savePsys1007',             // 그리드 입력/수정/삭제 URL
        events      : {
            onSelectRow : function(event, rowid){
                var row = admin_grid.getRowData(rowid);
            },
            onCellSelect : function(event, rowid, icol){    // 해당 셀 선택시
                var row = admin_grid.getRowData(rowid);
            },
            gridComplete : function(data){  

               // 페이지 셋팅
               // initPage("admin_grid", "test_paginate", true, 10 );
            }
        }
    };
 
    admin_grid = new UxGrid(grid_config);
    admin_grid.init();
    admin_grid.setGridWidth($('.tblType1').width());
    
    // 시스템사용자정보 등록 후의 목록 조회
    if(isNotEmpty(_param) && "CHG" == _param)
        $("#btn_retreive").trigger("click");
    
    
   var obj = {
            
            autoUpdateInput : false,
            showDropdowns: true,
            linkedCalendars: false,
            /* 날짜/일시 선택 start */
            timePicker: true,
            timePicker24Hour: true,
            //viewModel : 'month',
            locale: {
                format: 'YYYY-MM-DD'
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
    admin_grid.setGridWidth($('.tblType1').width());
});

// jqgrid 내 버튼 생성 이벤트
function setFailDateResetBtn(value, options, rowJson)
{      
    return "<button id='pwResetBtn_" + options.rowId + "' onclick='fn_FailDateReset(" + options.rowId + ")' class='btn_common btn_default' style='float:center;'>초기화</button>";﻿﻿﻿﻿﻿
}

// formatter 버튼 이벤트
function fn_FailDateReset(rowId)
{
    var usr_id      = $("#admin_grid").jqGrid('getCell', rowId, 'USR_ID');
    var usr_nm      = $("#admin_grid").jqGrid('getCell', rowId, 'USR_NM');
    
    ajax({
        url     : '/psys/updatePsys1007.adm',
        data    : {usr_id : usr_id, usr_nm : usr_nm},
        async   : false,
        success : function(data){
            if(data.RESULT == "S") {
                alert('초기화가 완료되었습니다.');
                admin_grid.retreive();
            } else {
                if(isNotEmpty(data.MSG)) {
                    alert("일시적 오류입니다.\n잠시후 다시 시도하세요.")
                } else {
                    alert(data.MSG);
                }
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
    var end_dt   = $("#sch_ed_dt").val().replace(/-/g, "");
    
    
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
//  var data      = makePrintXmlData();
    var param     = makePrintJsonData();    
    var file_name = "/resources/pandora3/ireport/pgm_info_report_xml.jasper";
    var url       = "/pandora3/print/print_json.jsp";
    var form      = document.getElementById("printForm");
    
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
    var rows    = $('#admin_grid').jqGrid('getGridParam', 'rowNum');
    var page    = $('#admin_grid').jqGrid('getGridParam', 'page');
    var total   = $('#admin_grid').jqGrid('getGridParam', 'total');
    var title   = $('#admin_grid').jqGrid('getGridParam', 'gridtitle');
    var url     = "/psys/getPsys1007XlsxDwld";  // 페이징 존재
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
    return  JSON.stringify(printList);
}


</script>
</head>
<body>
    <div class="frameWrap">
        <div class="subCon">
            <%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp"%>
            <!-- search -->
            <div class="frameTopTable">
                <form name="search" id="search" onsubmit="return false">
                    <input type="hidden" value="" name="sys_cd" id="sys_cd" />
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
                            <th>가입일자</th>
                            <td class="typeCal">
                                <div class="cals_div">
                                    <span class="txt_pw"><input class="cals w100" type="text" value="" name="sch_st_dt" id="sch_st_dt" autocomplete="off" /></span>
                                    <span class="w10 space">~</span>
                                    <span class="txt_pw"><input class="cals w100" type="text" value="" name="sch_ed_dt" id="sch_ed_dt" autocomplete="off" /></span>
                                </div>
                            </td>
                            <th>성명</th>
                            <td><span class="txt_pw"><input type="text" name="usr_nm" id="usr_nm" class="typeShort" /></span></td>
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
                        <tr>
                            <th>아이디</th>
                            <td><span class="txt_pw"><input type="text" name="lgn_id" id="lgn_id" class="typeShort" /></span></td>
                            <th>상태</th>
                            <td>
                                <select id="usr_stat_cd" name="usr_stat_cd" class="select">
                                    <option value="">전체</option>
                                </select>
                            </td>
                            
                        </tr>
                    </table>
                </form>
            </div>
			<div class="bgBorder"></div> 
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
