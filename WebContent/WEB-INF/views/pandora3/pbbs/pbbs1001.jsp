<%--
   1. 파일명 : pbbs1001
   2. 파일설명 : 통합게시판관리
   3. 작성일 : 2018-04-06
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var targetRowId = "";
var menu_id = _menu_id;
var module_grid;
var _ctgMstInfo;
var _cteMstSet="없음:없음;";

$(document).ready(function() {
	
	//카테고리마스터 목록 
	ajax({
		type:"post",
		url:"/pbbs/getCtegryMstList",
		success:function(data){
			_ctgMstInfo = data.ctegrymstList;
			for(var i=0; i < _ctgMstInfo.length; i++){
				_cteMstSet += _ctgMstInfo[i].CTEGRY_MST_CD+ ":" +_ctgMstInfo[i].CTEGRY_MST_NM+ ";";
			}
			_cteMstSet = _cteMstSet.substr(0, _cteMstSet.length -1);
		}
	});
	 
	// 그리드 초기화
	var module_config = {
		// 그리드, 페이징 ID
		gridid:'module_grid',
		pagerid:'module_grid_pager',
		gridBtnYn : 'Y',						// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
		// 컬럼 정보
		columns:[{name:'MODL_SEQ', width:100, label:'모듈번호'},
				 {name:'TMP_SEQ', width:100, label:'템플릿ID', hidden:true},
				 {name:'MAPPED_YN', width:90, label:'매핑여부', hidden:true},
				 {name:'STATUS', label:'상태', align:'center', editable:false , width:10},
				 {name:'MODL_TP', width:100, label:'게시판유형', required:true, editable:false , sortable:false, edittype:'select', formatter:'select', editoptions:{value:':선택;B_TYPE2:공통 게시판;B_TYPE3:질문답변형 게시판'}, defaultValue:null},
				 {name:'MODL_NM', width:100, label:'게시판명', required:true, editable:true},
				 /* {name:'MAPPED_MENU_NM', width:100, label:'매핑메뉴', editable:false, sortable:false}, */
				 {name : 'SYS_CD', label : '시스템명', align : 'center', required:true, editable : false, edittype : 'select', formatter : 'select', editoptions : {value:'<c:out value="<%=CodeUtil.getSitGridComboList()%>" />'}, width : 100},
				 {name:'CTEGRY_MST_CD', label:'카테고리마스터명', editable:false , edittype : 'select', formatter:'select', editoptions:{value: _cteMstSet}, width:80},
				 {name:'MAPPED_MENU_NM', width:100, label:'매핑메뉴', editable:false, sortable:false},
				 {name:'US_YN', width:50, label:'사용여부', align:'center', required:true, sortable:false, editable:true, edittype:'select', formatter:'select', editoptions:{value:'Y:사용;N:미사용'}}],
		editmode:true,			// 그리드 editable 여부
		gridtitle:'게시판 목록',	// 그리드명
		multiselect:true,		// checkbox 여부
		formid:'search',		// 조회조건 form id
		shrinkToFit:true,		// width 고정여부
		autowidth:true,         // 컬럼 width 자동조정여부
		height:'401',			// 그리드 높이
		cellEdit:false,
		selecturl:'/pbbs/getPbbs1001MdlList',	// 그리드 조회 URL
		saveurl:'/pbbs/savePbbs1001ModlInf',	// 그리드 삭제 URL
		events:{
			 onCellSelect: function(e, rowid, icol, conts) {
				var row = module_grid.getRowData(rowid);
				
				if('MAPPED_MENU_NM' == module_grid.getColName(icol)) {
					// 템플릿 맵핑 추가 팝업 호출
					bpopup({
						  url:"/pbbs/forward.pbbs1001p01.adm"
						, params    : {callback : "getTemplateMapped", target_id : _menu_id, rowId:rowid, modlSeq:row.MODL_SEQ}
						, title		: '메뉴 맵핑 추가'
						, height    : "500px"
						, id        : "psys1002p1"
						, type:'m'
			            , scrollbars:false
			            , autoresize:false

						
					});
					
				}
				
                if(row.JQGRIDCRUD == "C") {
                	if(icol == 9){
			 			$("#module_grid").jqGrid('setColProp', 'SYS_CD', { editable: true ,edittype : 'select', formatter : 'select', 
												editoptions : {value:'<c:out value="<%=CodeUtil.getSitGridComboList()%>" />'
			 			 						, dataEvents:[{
			 			 							 type:'change',
			 			 							 fn:function(){$("#module_grid").jqGrid("setCell",rowid,"CTEGRY_MST_CD","0")}
			 			 						 }]
			 			 					 }, width : 100 });
			 		}
					if(icol == 10){
						$("#module_grid").editCell(0, 0, false);
                		grid_SelectBox_Change(this,rowid);
                	}
			 		$("#module_grid").jqGrid('setColProp', 'MODL_TP', {editable: true , sortable:false, edittype:"select", formatter:'select', editoptions:{value:':선택;B_TYPE1:보고서형게시판;B_TYPE2:공통 게시판;B_TYPE3:질문답변형 게시판;B_TYPE4:이미지 게시판;B_TYPE5:동영상 게시판'}, defaultValue:null});
				}else{
					$("#module_grid").jqGrid('setColProp', 'SYS_CD', { editable: false });	
					$("#module_grid").jqGrid('setColProp', 'MODL_TP', { editable: false });	
					$("#module_grid").jqGrid('setColProp', 'CTEGRY_MST_CD', { editable: false });	
				}
			 },
		}
	};
	module_grid = new UxGrid(module_config);
	module_grid.init();
	module_grid.setGridWidth($('.tblType1').width());

	// 맵핑메뉴 삭제 버튼 클릭 시
	$("#btn_mapping_delete").click(function() {
		var rowIds = module_grid.getGridParam("selarrrow");
		var rowIdsLen = rowIds.length;
		if(rowIdsLen > 0) {
			if(confirm("선택한 행들의 맵핑메뉴 정보를 삭제하시겠습니까?")) {
				var strMsg = "";
				for(var i = 0; i < rowIds.length; i++) {
					if(!isEmpty(module_grid.getCell(rowIds[i], 'TMP_SEQ'))) {
						module_grid.setCell(rowIds[i], 'TMP_SEQ', null);
						module_grid.setCell(rowIds[i], 'MAPPED_MENU_NM', null);
						if(isEmpty(module_grid.getCell(rowIds[i], 'MODL_SEQ'))) {
							$("#module_grid").setCell(rowIds[i], 'JQGRIDCRUD', 'C');
						}else {
							$("#module_grid").setCell(rowIds[i], 'JQGRIDCRUD', 'U');
						}
					}else {
						if(strMsg != "") strMsg += ", ";
						strMsg += rowIds[i];
					}
				}
				if(strMsg != "") {
					alert(strMsg + " 행에 맵핑된 메뉴가 존재하지 않습니다.");
				}
			}
		}else {
			alert("삭제할 행을 선택해 주세요.");
			return;
		}
	})
	
});

// 그리드 리사이징
$(window).resize(function() {
	module_grid.setGridWidth($('.tblType1').width());
});

// 조회 : 내부 로직 사용자 정의
function fn_Search() {
	if($("#module_grid").jqGrid('getGridParam', 'page') > 1) $("#module_grid").jqGrid('setGridParam', {'page':1});
	module_grid.retreive();
	$("#module_grid").jqGrid('setColProp', 'CTEGRY_MST_CD', { editable: true ,edittype : 'select', formatter : 'select' , editoptions:{value: _cteMstSet }, defaultValue: "선택" });
}
// 저장 : 내부 로직 사용자 정의
function fn_Save() {
	module_grid.save();
 	$("#module_grid").jqGrid('setColProp', 'CTEGRY_MST_CD', { editable: true ,edittype : 'select', formatter : 'select' , editoptions:{value: _cteMstSet }, defaultValue: "선택" });
}
// 삭제 : 내부 로직 사용자 정의
function fn_DelRow() {
	module_grid.remove();
}
// 추가 : 내부 로직 사용자 정의
function fn_AddRow() {
	targetRowId = module_grid.add();
	var data = module_grid.getRowData(targetRowId);
}
// 엑셀다운로드
function fn_ExcelDownload() {
	var grid_id = 'module_grid';
	var rows = $('#module_grid').jqGrid('getGridParam', 'rowNum');
	var page = $('#module_grid').jqGrid('getGridParam', 'page');
	var total = $('#module_grid').jqGrid('getGridParam', 'total');
	var title = $('#module_grid').jqGrid('getGridParam', 'gridtitle');
	var url = '/pbbs/getPbbs1001XlsxDwld';
	var param ={};
	param.page = page;
	param.rows = rows;
	param.filename ="통합 게시판 목록";
	AdvencedExcelDownload(grid_id, url, param);
}

// 매핑메뉴 셋팅
function getTemplateMapped(data, rowId, modlSeq) {
	debugger;
	// 중복체크
	var rows = module_grid.getRowData();
	var tmplSeq = data.TMPL_SEQ;
	var overlapYn = false;
	for(var i = 0; i < rows.length; i++) {
		if(tmplSeq == rows[i].TMP_SEQ) {
			overlapYn = true;
			break;
		}
	}
	if(overlapYn) {
		alert("맵핑하려는 메뉴가 중복됩니다. 확인해 주세요.");
		return;
	}
	if(isEmpty(rows.BOT_MENU_NM)) {
		module_grid.setCell(rowId, 'MAPPED_MENU_NM', data.MID_MENU_NM, '', {}, true);
	}else {
		module_grid.setCell(rowId, 'MAPPED_MENU_NM', data.BOT_MENU_NM, '', {}, true);
	}
	module_grid.setCell(rowId, 'TMP_SEQ', tmplSeq, '', {}, true);
	if(isEmpty(modlSeq)) {
		$("#module_grid").setCell(rowId, 'JQGRIDCRUD', 'C');
	}else {
		$("#module_grid").setCell(rowId, 'JQGRIDCRUD', 'U');
	}
}


//시스템명을 선택했을때 카테고리마스터명 목록 만들기
function grid_SelectBox_Change(id,rowid) {
	var sys_cd = module_grid.getRowData(rowid).SYS_CD;
	ctemstList(sys_cd);
	$("#module_grid").editCell(0, 0, false);
}

//editoption value 값 만드는 함수
function ctemstList(sys_cd){
	var cteString ="없음:없음;";
	var num = 0;
	
	for(var i=0; i < _ctgMstInfo.length; i++){
		if(sys_cd == _ctgMstInfo[i].SYS_CD){
			cteString += _ctgMstInfo[i].CTEGRY_MST_CD+ ":" +_ctgMstInfo[i].CTEGRY_MST_NM+ ";";
			num ++;
		}
	}
	if(num >0 ){
		cteString = cteString.substr(0, cteString.length -1);
	}else{
		cteString ="없음:없음";
	}
	
	$("#module_grid").jqGrid('setColProp', 'CTEGRY_MST_CD', { editable: true ,edittype : 'select', formatter : 'select' , editoptions:{value: cteString, 
		dataEvents:[{type:'blur', fn:function(){
			$("#module_grid").jqGrid('setColProp', 'CTEGRY_MST_CD', { editable: true ,edittype : 'select', formatter : 'select' , editoptions:{value: _cteMstSet }})
			}}] }, defaultValue: "" });
}

</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
        <%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
			<div class="frameTopTable">
				<form name="search" id="search" onsubmit="return false">
						<table class="tblType1">
							<colgroup>
								<col style="width: 117px;" />
								<col style="" />
								<col style="width: 117px;" />
								<col style="" />
								<col style="width: 117px;" />
								<col style="" />
							</colgroup>
							<tr>
								<th>게시판유형</th>
								<td>
									<span class="txt_pw">
										<select class="select" name="modl_tp" id="modl_tp">
											<option value="">전체</option>
											<option value="B_TYPE1">보고서형 게시판</option>
											<option value="B_TYPE2">공통 게시판</option>
											<option value="B_TYPE3">질문답변형 게시판</option>
											<option value="B_TYPE4">이미지 게시판</option>
											<option value="B_TYPE5">동영상 게시판</option>
										</select>
									</span>
								</td>
								<th>게시판명</th>
								<td><span class="txt_pw"><input type="text" name="modl_nm" id="modl_nm" class="w100"/></span></td>
<!-- 							</tr> -->
<!-- 							<tr> -->
								<!-- <th>매핑메뉴명</th>
								<td><span class="txt_pw"><input type="text" name="mapped_menu_nm" id="mapped_menu_nm" class="w100"/></span></td> -->
								<th>사용여부</th>
								<td>
									<span class="txt_pw">
										<select class="select" name="us_yn" id="us_yn">
											<option value="">전체</option>
											<option value="Y">사용</option>
											<option value="N">미사용</option>
										</select>
									</span>
								</td>
							</tr>
						</table>
					<!-- <div class="tableBtnWrap gridBtn">
						<div class="tableBtn">
						</div>
					</div> -->
				</form>
			</div>
			<div class="bgBorder"></div>
			<!-- <div class="grid_right_btn">
				<div class="grid_right_btn_in">
					<a href="#" id="btn_module_add" class="btn_common btn_default">행 추가</a>
					<a href="#" id="btn_mapping_delete" class="btn_common btn_default">맵핑메뉴 삭제</a>
				</div>
			</div> -->
			<table id="module_grid"></table>
			<div id="module_grid_pager"></div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>