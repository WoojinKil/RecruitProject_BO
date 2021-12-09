<%-- 
   1. 파일명   : psys1043
   2. 파일설명 : 조직 관리
   3. 작성일   : 2019-11-06
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var org_grid;

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
        gridid    : 'org_grid',            // 그리드 id
        pagerid   : '',      // 그리드 페이지 id
        gridBtnYn : 'Y',                    // 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        columns   : [
		             {name : 'id', label : '조직코드', editable : false, hidden: true},
		             {name : 'org_nm', label : '조직 명', editable : false, align : 'left'},
                     ],
        gridtitle   : '조직 목록',                                  // 그리드명
        formid      : 'search',                                 // 조회조건 form id
        height      : 480,                                      // 그리드 높이
        shrinkToFit : true,                                     // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl   : '/psys/getPsys1043List.adm',              // 그리드 조회 URL
        search      : true,
        rownumbers  : false,
        multiSort   : false,
        treeGrid    : true,
         treeGridModel: 'adjacency',
         treedatatype: "local",
         ExpandColumn: 'org_nm',
        events      : {}
    };
    
    org_grid = new UxGrid(grid_config);
    org_grid.init();
    org_grid.setGridWidth($('.tblType1').width());
    
    
    org_grid.retreive();
    
    
    //전체 펼치기
    $("#expand-all").on("click", function () {
    	
		var rData = $("#org_grid").jqGrid('getGridParam','data');
		if (rData[0]) {
			for( var i=0; i<rData.length; i++ ) {
				$("#org_grid").jqGrid('expandRow',rData[i]);
				$("#org_grid").jqGrid('expandNode',rData[i]);
			}
		}
    	
    });
    //전체 닫기
    $("#collapse-all").on("click", function () {
		var rData = $("#org_grid").jqGrid('getGridParam','data');
		if (rData[0]) {
			for( var i=0; i<rData.length; i++ ) {
				$("#org_grid").jqGrid('collapseRow',rData[i]);
				$("#org_grid").jqGrid('collapseNode',rData[i]);
			}
		}
    });
});

// grid resizing
$(window).resize(function() {
    org_grid.setGridWidth($('.tblType1').width());
});

// 저장 전 유효성 체크

//조회: 내부 로직 사용자 정의
function fn_Search(){
    
    org_grid.retreive();
}


//저장: 내부 로직 사용자 정의
function fn_Save(){
}

//삭제: 내부 로직 사용자 정의
function fn_DelRow(){
}

//엑셀다운로드: 내부 로직 사용자 정의
function fn_ExcelDownload(){
    var grid_id = "org_grid";
    var rows    = $('#org_grid').jqGrid('getGridParam', 'rowNum');
    var page    = $('#org_grid').jqGrid('getGridParam', 'page');
    var total   = $('#org_grid').jqGrid('getGridParam', 'total');
    var title   = $('#org_grid').jqGrid('getGridParam', 'gridtitle');
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
                        </tbody>
                    </table>
               </form>
            </div>
            <!-- search // -->
            <div class="bgBorder"></div>
            <div class="grid_right_btn">
                <div class="grid_right_btn_in">
                    <button id="expand-all" class="btn_common btn_default">전체펼치기</button>
                    <button id="collapse-all" class="btn_common btn_default">전체닫기</button>
                </div>
            </div>
            <!-- Grid -->
            <table id="org_grid"></table> 
            <div id="org_grid_pager"></div>
            <!-- Grid // -->    
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
