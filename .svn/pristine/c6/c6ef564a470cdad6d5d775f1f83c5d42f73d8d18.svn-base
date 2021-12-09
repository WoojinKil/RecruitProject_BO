<%-- 
   1. 파일명   : psys1037
   2. 파일설명 : 시스템권한관리
   3. 작성일   : 2018-10-28
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var grp_role_grid;

var obj = {
	autoUpdateInput	: false,
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
		gridid    : 'grp_role_grid',	    	// 그리드 id
        pagerid   : 'grp_role_grid_pager',		// 그리드 페이지 id
        gridBtnYn : 'Y',					// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
		columns	  : [
			          {name:'STATUS', label:'상태', align:'center', editable:false, width:20},
			          {name : 'GRP_ROL_ID', label : '그룹 권한ID', editable : false, align : 'center', sorttype : 'int', hidden:true},
			          {name : 'GRP_ROL_NM', label : '통합 그룹명', editable : true, align : 'left', required : true, edittype : 'text', width : 200, editoptions : {maxlength:300}, classes:'class1 class2'},
			          {name:  'SRT_SEQ', width:50,label:'정렬순서', editable:true},
			          {name : 'US_YN', label : '사용여부', align : 'center', editable : true, edittype : 'select', formatter : 'select', editoptions : {value:'Y:사용;N:미사용'}, width : 80, required : true},
			          {name : 'F_APL_ST_DT', label : '적용시작일자', align : 'center', editable : true, width : 120, required : true, editoptions : {maxlength : 10, dataInit : fn_datePicker}}, 
			          {name : 'F_APL_ED_DT', label : '적용종료일자', align : 'center', editable : true, width : 120, required : true, editoptions : {maxlength : 10, dataInit : fn_datePicker}},
			          {name : 'F_UPD_DTTM', label : '변경일자', align : 'center', editable : false, width : 100}
                     ],
		initval		: {US_YN:'Y', APL_ED_DT:'9999-12-31'},		// 컬럼 add 시 초기값
		editmode	: true,										// 그리드 editable 여부
		gridtitle	: '통합그룹 목록',								// 그리드명
		multiselect	: true,										// checkbox 여부
		formid		: 'search',									// 조회조건 form id
		height		: 480,										// 그리드 높이
        shrinkToFit	: true,										// true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl	: '/psys/getPsys1037List.adm',				// 그리드 조회 URL
        saveurl		: '/psys/savePsys1037List.adm',				// 그리드 입력/수정/삭제 URL
        search      : true,
		events		: {
				            onCellSelect: function(event, rowIdx, colIdx, value){
		                      	// 추가된 row만 edit 가능하게 셋팅
		                      	var row = $('#grp_role_grid').getRowData(rowIdx);
		                     
		                      	// editable 제어
		                      	if(row.JQGRIDCRUD == "C") {
		                      		
// 			                    		$('#role_grid').setCell(rowIdx, 'SYS_CD', $("#sys_info").val());
			                    		
		                      	} 
				            }
		               }
	};
    
    grp_role_grid = new UxGrid(grid_config);
    grp_role_grid.init();
    grp_role_grid.setGridWidth($('.tblType1').width());
     
});

// grid resizing
$(window).resize(function() {
	grp_role_grid.setGridWidth($('.tblType1').width());
});

// 저장 전 유효성 체크
function fn_ValidtaionCheck() {
	
	var data = grp_role_grid.getRowData();
	
	for(var i=0 ; i<data.length ; i++) {
		
		if(data[i].JQGRIDCRUD == "")
			continue;
		
		if(data[i].F_APL_ST_DT > data[i].F_APL_ED_DT) {
			alert("적용 종료일자는 적용 시작일자보다 크거나 같아야 합니다.");
			grp_role_grid.setCellFocus(i+1, 6);
			return false;
		}
	}
	
	return true;
}

//조회: 내부 로직 사용자 정의
function fn_Search(){
	
	grp_role_grid.retreive();
}

//추가: 내부 로직 사용자 정의
function fn_AddRow(){
	
	
	grp_role_grid.add({APLY_START_DATE:$.timestampToString(new Date())});
}

//저장: 내부 로직 사용자 정의
function fn_Save(){

	// 그리드 입력중인 경우 포커스 제거
	$("#grp_role_grid").editCell(0, 0, false);
	
	if(fn_ValidtaionCheck())
		grp_role_grid.save();  // {success:function(){alert('save success');}}
}

//삭제: 내부 로직 사용자 정의
function fn_DelRow(){
	grp_role_grid.remove(); // {success:function(){alert('remove success');}}
}

//엑셀다운로드: 내부 로직 사용자 정의
function fn_ExcelDownload(){
	var grid_id = "grp_role_grid";
	var rows	= $('#grp_role_grid').jqGrid('getGridParam', 'rowNum');
	var page	= $('#grp_role_grid').jqGrid('getGridParam', 'page');
	var total	= $('#grp_role_grid').jqGrid('getGridParam', 'total');
	var title	= $('#grp_role_grid').jqGrid('getGridParam', 'gridtitle');
	var url		= "/psys/getPsys1037XlsxDwld";  //페이징 존재
	var param	       = {};
	    param.page	   = page;
	    param.rows	   = rows;
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
				                <th>통합 그룹명</th>
				                <td>
				                    <span class="txt_pw">
				                    	<input type="text" name="grp_rol_nm" id="grp_rol_nm" class="text" value="" />                    	
			                       	</span>	                       	
				                </td>                
				                <th>사용여부</th>
				                <td>
				                 <span class="txt_pw">
				                   <select name="us_yn" id="us_yn" class="select">
				                       <option value="">전체</option>
				                       <option value="Y">사용</option>
				                       <option value="N">미사용</option>
				                   </select>
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
	        <table id="grp_role_grid"></table> 
	        <div id="grp_role_grid_pager"></div>
	        <!-- Grid // -->    
	    </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
