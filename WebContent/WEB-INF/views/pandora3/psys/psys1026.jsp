<%-- 
   1. 파일명   : psys1026
   2. 파일설명 : 엑셀 업로드 샘플
   3. 작성일   : 2019-01-23
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/fileControl.js"></script>
<script type="text/javascript">
var menu_id = '<%=parameterMap.getValue("_menu_id")%>';
var grdId = 'upexcl_grid'; // 그리드ID
var upexcl_grid;

$(document).ready(function() {
	var upexcl_config = { 
		gridid      : grdId,
		pagerid     : 'upexcl_grid_pager',
		gridBtnYn   : 'Y',						// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
		columns     :[{name:'COL1', width:50, label:'컬럼1', align:'center', editable:true, required:true},
			          {name:'COL2', width:50, label:'컬럼2', align:'center', editable:true},
			          {name:'COL3', width:50, label:'컬럼3', align:'center', editable:true, required:true}
		],
		editmode    : true,			// 그리드 editable 여부
		gridtitle   : '엑셀업로드 목록', // 그리드명
		multiselect : false,        // checkbox 여부
		shrinkToFit : true,         // row width 자동조정
		autowidth   : true,         // 컬럼 width 자동조정
		height      : 439,          // 그리드 높이
		cellEdit    : false
	};
	upexcl_grid = new UxGrid(upexcl_config);
	upexcl_grid.init();
	upexcl_grid.setGridWidth($('.tblType1').width());
	
	// 엑셀업로드 버튼 클릭 시
    $("#btnUploadExcel").click(function(e) {
    	// 파일 유효성 체크
    	var validFlag = true;
    	$('input[type="text"]').each(function() {
    		if(isEmpty($(this).val())) {
    			var id = $(this).attr("id");
    			if(!(id.indexOf("url") > -1 || id.indexOf("title") > -1)) {
    				var label = $('label');
    				for(var i = 0; i < label.length; i++) {
    					if($(label[i]).attr("for") == id) {
    						validFlag = false;
    						break;
    					}
    				}
    			}
    		}
    	});
    	
    	if(!validFlag) {
    		if(confirm("업로드할 엑셀 파일이 존재하지 않습니다.\n엑셀 파일을 선택하시겠습니까?")) {
    			$('#upload_excl_file').click();
    		}
    	}else {
    		// 엑셀업로드
        	fn_ExcelUpload();
    	}
    });
	
	// 엑셀양식다운로드 버튼 클릭 시 
    $("#btnDownloadExcelForm").click(function() {
    	// 파라미터 셋팅 : 엑셀양식 다운로드 할 헤더 Array
    	var exclHeaderArr = new Array();
    	exclHeaderArr[0] = "COL1";
    	exclHeaderArr[1] = "COL2";
    	exclHeaderArr[2] = "COL3";
    	
    	// 엑셀양식다운로드
    	downloadExcelForm(grdId, "", exclHeaderArr);
    });
});

// 조회: 내부 로직 사용자 정의
function fn_Search() {
}
// 추가: 내부 로직 사용자 정의
function fn_AddRow() {
	upexcl_grid.add();
}
// 저장: 내부 로직 사용자 정의
function fn_Save() {
}
// 삭제: 내부 로직 사용자 정의
function fn_DelRow() { 
}
// 프린트: 내부 로직 사용자 정의
function fn_Print() {
}
// 엑셀다운로드: 내부 로직 사용자 정의
function fn_ExcelDownload() {
}

// 엑셀업로드
// fileControl.js 내 함수 호출
// 파라미터
// 1. 업로드할 파일 id
// 2. 업로드 후 로드할 그리드 id
function fn_ExcelUpload() {
	var fileId = 'upload_excl_file'; // 파일ID
	
	// 파라미터 셋팅
	var startStr = '{';
	// 파라미터 셋팅 : 엑셀 업로드 할 헤더 Array
	var exclHeaderArr = new Array();
	exclHeaderArr[0] = "COL1";
	exclHeaderArr[1] = "COL2";
	exclHeaderArr[2] = "COL3";
	
	// 파라미터 셋팅 : 유효성 체크
	var validJsonStr = startStr; // 유효성 체크 : 필수값
   	var colCount = 0;
   	var cols = $('#'+grdId).getGridParam().colModel;
   	for(var i = 0; i < cols.length; i++) {
   		if(cols[i].name == 'rn' || cols[i].name == 'cb' || cols[i].label == undefined) {
			continue; 
		}			
   		
   		if(cols[i].hidden == false) {
	   		if(colCount != 0) {
	   			if(typeof cols[i].required != "undefined" && cols[i].required != null) {
	   				if(validJsonStr != startStr) {
	   					for(var j = 0; j < exclHeaderArr.length; j++) {
	   	   					if(exclHeaderArr[j] == cols[i].name) validJsonStr = validJsonStr + ','; 
	   	   				}	
	   				}
	   			}
	   		}
	   		colCount++;
   			if(typeof cols[i].required != "undefined" && cols[i].required != null) {
   				for(var j = 0; j < exclHeaderArr.length; j++) {
   					if(exclHeaderArr[j] == cols[i].name) validJsonStr = validJsonStr + '"' + cols[i].name + '":"' + (cols[i].required == true ? 'Y' : 'N') + '"'; 
   				}
   			}
   		}
	}
	validJsonStr = validJsonStr + '}';
	
	uploadExcel(fileId, grdId, "", exclHeaderArr, validJsonStr);
}

// 그리드 리사이징
$(window).resize(function() {
	upexcl_grid.setGridWidth($('.tblType1').width());
});
</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
			<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
			<form name="frm_upexcl" id="frm_upexcl" enctype="multipart/form-data" method="post" onsubmit="return false;">
			<table class="tblType1 mB60">
				<colgroup>
					<col width="15%"/>
					<col width="*"/>
				</colgroup>
				<tr>
				<th class="category" colspan="2">√. 엑셀 업로드할 파일 선택</th>
				</tr>
				<tr>
				<th><label for="file_txt" class="vv">엑셀</label></th>
				<td>
					<span class="fileAdd w100">
						<input id="file_txt" type="text" class="fileTxt w30" value="" placeholder="선택된 파일 없음" readonly />
						<input type="button" id="btnFindExcel" value="엑셀파일찾기" class="btn_common btn_default" onclick="javascript:$('#upload_excl_file').click();" />
						<input id="btnUploadExcel" type="button" value="엑셀업로드▼" class="btn_common btn_default" />
						<input id="upload_excl_file" type="file" class="img_file" style='visibility:hidden;width:0px;' name="excl_file" onchange="ChangeText(this, 'file_txt');" accept=".xls, .xlsx" />
						<input id="btnDownloadExcelForm" type="button" value="엑셀양식다운로드" class="btn_common btn_default" />
					</span>
				</td>
				</tr>
			</table>
			</form>
			<!-- Grid -->
			<table id="upexcl_grid"></table>
			<div id="upexcl_grid_pager"></div>
			<!-- Grid // -->
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>