<%-- 
   1. 파일명 : psys1061
   2. 파일설명 : 시스템사용자별 권한조회
   3. 작성일 : 2018-03-28
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>

<script type="text/javascript">

var admin_grid;
var rol_rtnn_grid;

$(document).ready(function(){
    // 공통코드 복수 설정
    
    function fn_dateFormatter(cellValue, options, rowObject){
        return cellValue.substr(0, 4) + "-" + cellValue.substr(4, 2) + "-" + cellValue.substr(6, 2);
    }

    var admin_config = {
            gridid  : 'admin_grid',
            pagerid : 'admin_grid_pager',
            gridBtnYn : 'Y',
            columns : [
                {name : 'USR_ID', label : '유저ID', width : 100, hidden : true},
                {name : 'USR_CL_NM', label : '사원 구분', width : 100},
                {name : 'APVL_YN', label : '권한확인여부', align:'center', editable:false, edittype:'select', formatter:'select', editoptions:{value:'Y:확인;N:미확인'}, width:80},
                {name : 'LGN_ID', label : '사번', width : 100},
                {name : 'CSTR_NM', label : '소속', width : 100},
                {name : 'POS_NM', label : '직책', width : 100},
                {name : 'JOB_NM', label : '직무', width : 100
                    ,formatter: function(cellValue,options,rowdata,action){
                        var value = "";
                        if(isNotEmpty(cellValue)) {
                            value = cellValue.replace(/[,]/gi, '<br />');
                        } else {
                            value = cellValue;
                        }
                           return value;
                       }
                },
                {name : 'GRP_ROL_NM', label : '권한그룹 명', width : 100
                    ,formatter: function(cellValue,options,rowdata,action){
                        var value = "";
                        if(isNotEmpty(cellValue)) {
                            value = cellValue.replace(/[,]/gi, '<br />');
                        } else {
                            value = cellValue;
                        }
                           return value;
                       }
                },
                {name : 'USR_NM', label : '사원명', width : 100},
                {name : 'MSTRS_USPR_ID', label : 'MSTR 권한', width : 100},
            ],
            initval     : {},                           // 컬럼 add 시 초기값
            editmode    : true,                         // 그리드 editable 여부
            gridtitle   : '사원 목록',                  // 그리드명
            multiselect : false,                         // checkbox 여부
            height      : 200,                          // 그리드 높이
            shrinkToFit : true,                         // true인경우 column의 width 자동조정, false인경우 정해진 width데로 구현(가로스크롤바필요시 false)
            formid        : 'search',                     // 조회조건 form id
            selecturl   : '/psys/selectTmbrAdmLgnInfRolList',  // 그리드 조회 URL
            events      : {
            	
            	ondblClickRow : function(e, rowid, irow, icol) {
            		var row = admin_grid.getRowData(rowid);
            		rol_rtnn_grid.retreive({data:{usr_id:row.USR_ID}});
            	}
            	
            }
    };
 
    admin_grid = new UxGrid(admin_config);
    admin_grid.init();
    admin_grid.setGridWidth($('.tblType1').width());
    
    
    
    var rol_config = {
            gridid  : 'rol_rtnn_grid',
            pagerid : '',
            gridBtnYn : 'Y',
            columns : [
                {name : 'SYS_NM', label : '시스템명', editable:false, align:'center', width:60},
                {name : 'ROL_CL_NM', label : '권한구분', editable:false, align:'center', width:60},
                {name : 'ROL_ID', label : '권한ID', editable:false, align:'center', width:60},
                {name : 'ROL_NM', label : '권한명', editable:false, edittype:'text', width:200},
                {name : 'US_YN', label : '사용여부', align:'center', editable:false, edittype:'select', formatter:'select', editoptions:{value:'Y:사용;N:미사용'}, width:80},
            ],
            initval     : {},                           // 컬럼 add 시 초기값
            editmode    : false,                         // 그리드 editable 여부
            gridtitle   : '권한 목록',                  // 그리드명
            multiselect : false,                         // checkbox 여부
            height      : 300,                          // 그리드 높이
            shrinkToFit : true,                         // true인경우 column의 width 자동조정, false인경우 정해진 width데로 구현(가로스크롤바필요시 false)
            formid        : 'searchRol',                     // 조회조건 form id
            selecturl   : '/psys/selectTmbrAdmLgnInfRolRtnnList',  // 그리드 조회 URL
            events      : {}
    };
    
    rol_rtnn_grid = new UxGrid(rol_config);
    rol_rtnn_grid.init();
    rol_rtnn_grid.setGridWidth($('.tblType1').width());

    
    
    
});

// grid resizing
$(window).resize(function(){
    admin_grid.setGridWidth($('.tblType1').width());
    rol_rtnn_grid.setGridWidth($('.tblType1').width());
});



/**************************************************
 * 공통 버튼 
 **************************************************/

// 조회 : 내부 로직 사용자 정의
function fn_Search()
{
    
    admin_grid.retreive();
    rol_rtnn_grid.clearGridData();
}

// 추가 : 내부 로직 사용자 정의
function fn_AddRow()
{
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
function fn_Print() {
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

</script>
</head>
<body>
    <div class="frameWrap">
        <div class="subCon">
            <%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp"%>
            <!-- search -->
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
                            <th>사번</th>
                            <td><span class="txt_pw"><input type="text" name="usr_id" id="usr_id" class="typeShort" /></span></td>
                            <th>소속</th>
                            <td><span class="txt_pw"><input type="text" name="cstr_nm" id="cstr_nm" class="typeShort" /></span></td>
                            <th>성명</th>
                            <td><span class="txt_pw"><input type="text" name="usr_nm" id="usr_nm" class="typeShort" /></span></td>
                        </tr>
                    </table>
                </form>
            </div>
            <!-- search // -->
            <div class="bgBorder"></div>
            <!-- Grid -->
            <table id="admin_grid"></table>
            <div id="admin_grid_pager"></div>
            <!-- Grid // -->
            <div class="bgBorder"></div>
            <div class="grid_right_btn">
                <div class="grid_right_btn_in">
                    <p style="font-size:13px; font-weight:500; color: #333333;">※권한 우선순위 존재 (1.사원개인권한 2.사원조직권한)</p>
                </div>
            </div>
            <table id="rol_rtnn_grid"></table>
            <div id="rol_rtnn_grid_pager"></div>
            
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>
