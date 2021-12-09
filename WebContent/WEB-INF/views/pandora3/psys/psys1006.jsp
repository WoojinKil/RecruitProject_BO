<%-- 
   1. 파일명   : psys1006
   2. 파일설명 : 시스템권한관리
   3. 작성일   : 2018-03-28
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var role_grid;

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
		gridid    : 'role_grid',	    	// 그리드 id
        pagerid   : 'role_grid_pager',		// 그리드 페이지 id
        gridBtnYn : 'Y',					// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
		columns	  : [
			          {name:'STATUS', label:'상태', align:'center', editable:false, width:20},
			          {name : 'SYS_CD', label : '시스템명', align : 'center', editable : true, edittype : 'select', formatter : 'select', editoptions : {value:'<c:out value="<%=CodeUtil.getSitGridComboList()%>" />'}, width : 100, required : true},
			          {name : 'ROL_ID', label : '권한ID', editable : false, align : 'center', sorttype : 'int', hidden:true},
			          {name : 'ROL_NM', label : '권한명', editable : true, align : 'left', required : true, edittype : 'text', width : 200, editoptions : {maxlength:300}, classes:'class1 class2'},
			          {name:  'SRT_SEQ', width:50,label:'정렬순서', editable:true},
			          {name : 'US_YN', label : '사용여부', align : 'center', editable : true, edittype : 'select', formatter : 'select', editoptions : {value:'Y:사용;N:미사용'}, width : 80, required : true},
			          {name : 'F_APL_ST_DT', label : '적용시작일자', align : 'center', editable : true, width : 120, required : true, editoptions : {maxlength : 10, dataInit : fn_datePicker}}, 
			          {name : 'F_APL_ED_DT', label : '적용종료일자', align : 'center', editable : true, width : 120, required : true, editoptions : {maxlength : 10, dataInit : fn_datePicker}},
			          {name : 'F_UPD_DTTM', label : '변경일자', align : 'center', editable : false, width : 100}
                     ],
		initval		: {US_YN:'Y', APL_ED_DT:'9999-12-31'},		// 컬럼 add 시 초기값
		editmode	: true,										// 그리드 editable 여부
		gridtitle	: '시스템권한목록',									// 그리드명
		multiselect	: true,										// checkbox 여부
		formid		: 'search',									// 조회조건 form id
		height		: 480,										// 그리드 높이
        shrinkToFit	: true,										// true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl	: '/psys/getPsys1006List.adm',				// 그리드 조회 URL
        saveurl		: '/psys/savePsys1006List.adm',				// 그리드 입력/수정/삭제 URL
        search      : true,
		events		: {
				            onCellSelect: function(event, rowIdx, colIdx, value){
		                      	// 추가된 row만 edit 가능하게 셋팅
		                      	var row = $('#role_grid').getRowData(rowIdx);
		                     
		                      	// editable 제어
		                      	if(row.JQGRIDCRUD == "C") {
		                      		
// 			                    		$('#role_grid').setCell(rowIdx, 'SYS_CD', $("#sys_info").val());
			                    		
		                      	} 
				            }
		               }
	};
    
    role_grid = new UxGrid(grid_config);
    role_grid.init();
    role_grid.setGridWidth($('.tblType1').width());
    
  	//사이트 리스트 취득
    getSystemList();
     
    $("#sys_info").on("change", function () {
    	fn_Search();
    });
});

// grid resizing
$(window).resize(function() {
	role_grid.setGridWidth($('.tblType1').width());
});

// 저장 전 유효성 체크
function fn_ValidtaionCheck() {
	
	var data = role_grid.getRowData();
	
	for(var i=0 ; i<data.length ; i++) {
		
		if(data[i].JQGRIDCRUD == "")
			continue;
		
		if(data[i].F_APL_ST_DT > data[i].F_APL_ED_DT) {
			alert("적용 종료일자는 적용 시작일자보다 크거나 같아야 합니다.");
			role_grid.setCellFocus(i+1, 6);
			return false;
		}
	}
	
	return true;
}

//조회: 내부 로직 사용자 정의
function fn_Search(){
	
	var sys_cd = $("#sys_info").val();
	$("#sys_cd").val(sys_cd);
	
	role_grid.retreive();
}

//추가: 내부 로직 사용자 정의
function fn_AddRow(){
	
	var sys_cd = $("#sys_info").val();
	
	role_grid.add({APLY_START_DATE:$.timestampToString(new Date())});
}

//저장: 내부 로직 사용자 정의
function fn_Save(){

	// 그리드 입력중인 경우 포커스 제거
	$("#role_grid").editCell(0, 0, false);
	
	if(fn_ValidtaionCheck())
		role_grid.save();  // {success:function(){alert('save success');}}
}

//삭제: 내부 로직 사용자 정의
function fn_DelRow(){
	role_grid.remove(); // {success:function(){alert('remove success');}}
}

//엑셀다운로드: 내부 로직 사용자 정의
function fn_ExcelDownload(){
	var grid_id = "role_grid";
	var rows	= $('#role_grid').jqGrid('getGridParam', 'rowNum');
	var page	= $('#role_grid').jqGrid('getGridParam', 'page');
	var total	= $('#role_grid').jqGrid('getGridParam', 'total');
	var title	= $('#role_grid').jqGrid('getGridParam', 'gridtitle');
	var url		= "/psys/getPsys1006XlsxDwld";  //페이징 존재
	var param	       = {};
	    param.page	   = page;
	    param.rows	   = rows;
	    param.filename = "시스템 권한 목록";
	AdvencedExcelDownload(grid_id, url, param);
}

//사이트 리스트 취득
function getSystemList() {
	var html = "";
	ajax({
		url 	: "/pdsp/getPdsp1011ListSit",
		data 	: {sys_cd : _sys_cd} , 
		success : function (data) {
			if (data.RESULT == "S") {
				var sitListCnt = data.rows.length;
				$(data.rows).each(function (index) {
					// 조회 건수가 하나일 경우 단일 하나의 시스템
					if(sitListCnt == 1) {
						html += "<option value="+ this.SYS_CD +" selected='selected' >"+ this.SYS_NM +"</option>"
						return false;
					} else {
						html += "<option value="+ this.SYS_CD +">"+ this.SYS_NM +"</option>"
						$("#sys_info").closest('div').show();
					}
				});
				$("#sys_info").append(html);
			}
		}
	});
}

</script>
</head>
<body id="app">
	<div class="frameWrap">
	    <div class="subCon">
			<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
			<div class="tableTopLeft gridBtn">
				<div class="selectInner" style="display:none">
					<label for="sys_info">시스템 : </label>
					<select id="sys_info" name="sys_info" class="select">
						<option value=''>전체</option>
					</select>
				</div>
			</div>
	        <!-- search -->
			<!-- <form name="search" id="search" name="search" onsubmit="return false">
				<input type="hidden" name="sys_cd" id="sys_cd" value="" />
	            <table class="tblType1 mB60" >
	            	<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>   
		            <tr>
		                <th>권한명</th>
		                <td>
		                  <span class="txt_pw"><input type="text" name="rol_nm" id="rol_nm" class="text" value="" />
		                  </span>
		                </td>                
		                <th>사용여부</th>
		                <td>
		                   <select name="us_yn" id="us_yn" class="select">
		                       <option value="">전체</option>
		                       <option value="Y">사용</option>
		                       <option value="N">미사용</option>
		                   </select>
		                </td>
		            </tr>
	            </table>
			</form> -->
			<div class="frameTopTable">
				<form name="search" id="search" name="search" onsubmit="return false">
					<input type="hidden" name="sys_cd" id="sys_cd" value="" />
		            <table class="tblType1">   
		            	<colgroup>
							<col style="width: 117px;" />
							<col style="" />
							<col style="width: 117px;" />
							<col style="" />
						</colgroup>   
						<tbody>
				            <tr>
				                <th>권한명</th>
				                <td>
				                    <span class="txt_pw">
				                    	<input type="text" name="rol_nm" id="rol_nm" class="text" value="" />                    	
			                       	</span>	                       	
				                </td>                
				                <th>사용여부</th>
				                <td>
				                 <span class="txt_pw">
				                   <select name="us_yn" id="us_yn" class="select">
				                       <option value="">전체</options>
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
	        <table id="role_grid"></table> 
	        <div id="role_grid_pager"></div>
	        <!-- Grid // -->    
	    </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
