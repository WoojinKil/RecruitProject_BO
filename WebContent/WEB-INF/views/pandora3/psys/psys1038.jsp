<%--
   1. 파일명   : psys1038
   2. 파일설명 : 시스템 그룹별 권한 관리
   3. 작성일   : 2018-10-28
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var grp_role_grid;
var adm_rol_info;

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

 // 동적 컬럼 기본값 설정
	var defaultCol = new Array();
	/* 특정 컬럼 옵션값 설정
	tgt : 옵션 설정할 컬럼 (해당 컬럼의 NAME)
	opt : 설정할 옵션 값 (배열로 설정)
	*/
	var optionalCol = new Array();
    ajax({
	        url     : "/pdsp/getPdsp1011ListSit",
	        data : {rol_yn:'Y'},
	        success : function (data) {
	            if (data.RESULT == "S") {
	                var sitListCnt = data.rows.length;
	                defaultCol.push( {name:'STATUS', label:'상태', align:'center', editable:false, width:50},
	                                     {name : 'GRP_ROL_ID', label : '그룹 권한ID', editable : false, hidden:true},
	                                     {name : 'GRP_ROL_IDS', label : '그룹 매핑 권한들  ', editable : false, hidden:true},
	                                     {name : 'GRP_ROL_NM', label : '통합 그룹명', editable : false, align : 'center'}
	                                  );
	                $(data.rows).each(function (index) {
	                	defaultCol.push(  {name :this.SYS_ABRV, label : this.SYS_NM});
	                	optionalCol.push({tgt: this.SYS_ABRV, opt:{editable:false, edittype:'select', formatter: fn_makeRolSelectbox,unformat : fn_makeRolUnSelectbox, formatoptions:{sys_cd:this.SYS_CD,sys_abrv:this.SYS_ABRV} }});
	                });
					makeGrid();
	            }
	        }
	    });

    ajax({
        url     : "/psys/selectRolListAll",
        data : {sys_cd :0},
        success : function (data) {
            if (data.RESULT == "S") {
            	adm_rol_info = data.rows;
            }
        }
    });

	function makeGrid(){
    	// 공통 그리드 옵션
    	var config = {
            gridid        : 'grp_role_grid',	    	// 그리드 id
            pagerid      : 'grp_role_grid_pager',	// 그리드 페이지 id
            gridBtnYn    : 'Y',							// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
    		editmode    : true,
    		gridtitle      : '통합그룹 별 시스템 권한 목록',
    		multiselect  : true,
    		formid       : 'search',
    		height       : '480',
    		shrinkToFit  : true,
    		selecturl     : '/psys/getPsys103801List',
   	        saveurl      : '/psys/savePsys1038List',             // 그리드 입력/수정/삭제 URL
    		setCol       : '',
    		events       : {
    		}
    	};

    	// 동적 그리드 생성
    	grp_role_grid = fn_UxGrid(config, '', defaultCol);
    	grp_role_grid.init();
    	grp_role_grid.setcolprop(optionalCol);
    	grp_role_grid.setGridWidth($('.tblType1').width());
	}

});

// grid resizing
$(window).resize(function() {
    grp_role_grid.setGridWidth($('.tblType1').width());
});

// 저장 전 유효성 체크

//조회: 내부 로직 사용자 정의
function fn_Search(){

    grp_role_grid.retreive();
}


//저장: 내부 로직 사용자 정의
function fn_Save(){
    grp_role_grid.save();  // {success:function(){alert('save success');}}
}

//삭제: 내부 로직 사용자 정의
function fn_DelRow(){
    grp_role_grid.remove(); // {success:function(){alert('remove success');}}
}

//엑셀다운로드: 내부 로직 사용자 정의
function fn_ExcelDownload(){
    var grid_id = "grp_role_grid";
    var rows    = $('#grp_role_grid').jqGrid('getGridParam', 'rowNum');
    var page    = $('#grp_role_grid').jqGrid('getGridParam', 'page');
    var total   = $('#grp_role_grid').jqGrid('getGridParam', 'total');
    var title   = $('#grp_role_grid').jqGrid('getGridParam', 'gridtitle');
    var url     = "/psys/getPsys1037XlsxDwld";  //페이징 존재
    var param          = {};
        param.page     = page;
        param.rows     = rows;
        param.filename = "시스템 그룹 권한 목록";
    AdvencedExcelDownload(grid_id, url, param);
}

function fn_makeRolSelectbox(cellValue, options, row) {
	var rol_id ="";
	$.each(row, function(key, value){
	    if(key == options.colModel.formatoptions.sys_abrv){
	    	rol_id = value;
	    }
	});
	var selectHtml = "<select class='w100'  onchange='fn_dupCheck(this)'>";
	selectHtml += "<option value='0'>선택안함</option>"
	for(var i=0; i < adm_rol_info.length; i++){
	   var selected ="";
		if(options.colModel.formatoptions.sys_cd == adm_rol_info[i].SYS_CD ){
			if(rol_id ==  adm_rol_info[i].ROL_ID){
				  selected ="selected";
			  }
			selectHtml += "<option value='" + adm_rol_info[i].ROL_ID +"'" + selected+ ">"+adm_rol_info[i].ROL_NM+"</option>"
		}

	}
	selectHtml +="</select>"
	return selectHtml;
}

function fn_makeRolUnSelectbox( cellvalue, options, cell) {
	return $("select",cell).find("option:selected").val();

}

//현재 신청할 권한에 대한 검색
function fn_dupCheck (target) {
	var findStr = $(target).find("option:selected").val() + ":" + $(target).find("option:selected").text();
	var rowId = $(target).closest("tr").attr("id");
	var targetRow = grp_role_grid.getRowData(rowId);

    var chk = $("input:checkbox[id='jqg_grp_role_grid_"+ rowId +"']").is(":checked");
    if(chk != true) {
        $("#grp_role_grid").jqGrid('setSelection', rowId, true);
    }

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
            <!-- Grid -->
            <table id="grp_role_grid"></table>
            <div id="grp_role_grid_pager"></div>
            <!-- Grid // -->
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
