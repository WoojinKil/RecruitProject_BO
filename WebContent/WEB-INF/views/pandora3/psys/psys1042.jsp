<%-- 
   1. 파일명   : psys1042
   2. 파일설명 : 직책 관리
   3. 작성일   : 2019-11-05
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var pos_grid;

var obj = {
    autoUpdateInput : false,
    showDropdowns: true,
    singleDatePicker: true,
    locale: {
        format: 'YYYY-MM-DD'
    }
};

// 한글 입력 방지
function fn_onKeyUp(e)
{
    $(e).keyup(function(){
        e.value = e.value.replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' );
    });
}

// 달력
function fn_datePicker(e)
{ 
    $(e).daterangepicker(obj, function(start, end, separator) {
        $(e).val(start);
    });
}



$(document).ready(function(){
    var grid_config = {
        gridid    : 'pos_grid',            // 그리드 id
        pagerid   : '',      // 그리드 페이지 id
        gridBtnYn : 'Y',                    // 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        columns   : [
		             {name : 'HR_CD', label : '직책코드', editable : false},
		             {name : 'HR_CD_NM', label : '직책명', editable : false},
		             {name : 'HR_CD_ORDER', label : '순서', editable : false},
                      
                     ],
        editmode    : true,                                     // 그리드 editable 여부
        gridtitle   : '직책 목록',                                  // 그리드명
        multiselect : false,                                     // checkbox 여부
        formid      : 'search',                                 // 조회조건 form id
        height      : 480,                                      // 그리드 높이
        shrinkToFit : true,                                     // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl   : '/psys/getPsys1042List.adm',              // 그리드 조회 URL
        search      : true,
        events      : {}
    };
    
    pos_grid = new UxGrid(grid_config);
    pos_grid.init();
    pos_grid.setGridWidth($('.tblType1').width());
    
    
    pos_grid.retreive();
});

// grid resizing
$(window).resize(function() {
    pos_grid.setGridWidth($('.tblType1').width());
});

// 저장 전 유효성 체크

//조회: 내부 로직 사용자 정의
function fn_Search(){
    
    pos_grid.retreive();
}


//저장: 내부 로직 사용자 정의
function fn_Save(){
}

//삭제: 내부 로직 사용자 정의
function fn_DelRow(){
}

//엑셀다운로드: 내부 로직 사용자 정의
function fn_ExcelDownload(){
    var grid_id = "pos_grid";
    var rows    = $('#pos_grid').jqGrid('getGridParam', 'rowNum');
    var page    = $('#pos_grid').jqGrid('getGridParam', 'page');
    var total   = $('#pos_grid').jqGrid('getGridParam', 'total');
    var title   = $('#pos_grid').jqGrid('getGridParam', 'gridtitle');
    var url     = "/psys/getPsys1037XlsxDwld";  //페이징 존재
    var param          = {};
        param.page     = page;
        param.rows     = rows;
        param.filename = "시스템 그룹 권한 목록";
    AdvencedExcelDownload(grid_id, url, param);
}


</script>
</head>
<body id="app">
    <div class="frameWrap">
        <div class="subCon">
            <%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
            <div class="frameTopTable">
                <form name="search" id="search" name="search" onsubmit="return false">
                    <table class="tblType1">   
                        <colgroup>
                            <col style="width: 117px;" />
                            <col style="" />
                            <col style="width: 117px;" />
                            <col style="" />
                        </colgroup>   
                        <tbody>
                            <tr>
                                <th>직책명</th>
                                <td>
                                    <span class="txt_pw">
                                        <input type="text" name="hr_cd_nm" id="hr_cd_nm" class="text" value="" />
                                    </span>                         
                                </td>                
                            </tr>
                        </tbody>
                    </table>
               </form>
            </div>
            <!-- search // -->
            <div class="bgBorder"></div>
            <!-- Grid -->
            <table id="pos_grid"></table> 
            <div id="pos_grid_pager"></div>
            <!-- Grid // -->    
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
