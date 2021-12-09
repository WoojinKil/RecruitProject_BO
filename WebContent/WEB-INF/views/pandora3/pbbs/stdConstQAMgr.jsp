<%-- 
    개요 : 표준시장단가QA관리
    수정사항 :
        2017-12-28 최초작성
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var menu_id = '<%=parameterMap.getValue("_menu_id")%>';
var stdConstQA_grid;
	
$(document).ready(function(){
	var stdConstQA_config = { 
	// grid id
	gridid: 'stdConstQA_grid',
	pagerid: 'stdConstQA_grid_pager',
	// column info
	columns:[ {name:'DOCUMENT_SRL',	width:100, label:'문서SRL', hidden:true},
			{name:'MODULE_SRL',		width:100, label:'모듈SRL', hidden:true},
			{name:'TITLE',			width:300, label:'제목', sortable:false, cellattr: function(rowId, tv, rowObject, cm, rdata) {if(isNotEmpty(rowObject.TITLE)){ return 'style="cursor: pointer; text-decoration: underline;"'}}},
			{name:'USER_NM',		width:100, label:'작성자명',align:'center', sortable:false},
			{name:'LOGIN_ID',		width:100, label:'아이디', align:'center', sortable:false},
			{name:'STATUS',			width:100, label:'공개설정', align:'center', sortable:false, formatter:'select', editoptions:{value:'PUBLIC:공개;SECRET:비공개;'}},
			{name:'PROC_CD',		width:100, label:'처리상태', align:'center', sortable:false, formatter:'select', editoptions:{value:'1:등록완료;2:답변준비중;3:답변완료;'}},
			{name:'READED_COUNT',	width:80, label:'조회수', align:'center', editable:false, sortable:true,formatter:'number', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}},
			{name:'REGDATE',		width:100, label:'작성일', align:'center', editable:false, sortable:true},
			{name:'DEL_YN',			width:80, label:'글상태', align:'center', sortable:false, formatter:'select', editoptions:{value:'Y:삭제;N:일반;'}}
		],
		editmode: true,                   // 그리드 editable 여부
		gridtitle: '질문답변형게시판 목록',      // 그리드명
		multiselect: true,                // checkbox 여부
		formid: 'search',                 // 조회조건 form id
		shrinkToFit: true,                // 컬럼 width 자동조정
		autowidth: true,
		height: 400,                      // 그리드 높이
		cellEdit:false,
		selecturl: '/content/selectBoardType3List',   // 그리드 조회 URL
		saveurl: '/content/changeBoardType3List',     // 그리드 삭제 URL
		events: { onCellSelect: function(event, rowid, icol, conts) {
					var row = stdConstQA_grid.getRowData(rowid);
					if (stdConstQA_grid.getColName(icol) == 'TITLE') {
						if(row.DEL_YN == "Y") {
							alert("삭제된 Q&A글입니다. \n게시글 복원 후 열람 가능합니다.");
							return false;
						}
						parent.addTab('sub'+menu_id, '질문답변형게시판 답변관리', '/content/forward.stdConstQAMgrDtl.adm', row.MODULE_SRL, row.DOCUMENT_SRL);
					}
				}
		}
	};
	stdConstQA_grid = new UxGrid(stdConstQA_config);
	stdConstQA_grid.init();
	stdConstQA_grid.setGridWidth($('.tblType1').width());
	
	$("#btn_retreive").click(function() {
		// 페이징이 1page를 초과할 시 초기화
		if($("#stdConstQA_grid").jqGrid('getGridParam', 'page') > 1) $("#stdConstQA_grid").jqGrid('setGridParam', {'page' : 1});
		stdConstQA_grid.retreive(); //{success:function(){alert('retreive success');}}
	});
	
	// 복원
	$("#btn_document_chg").click(function() {
		var params = new Array();  
		var idArry = $("#stdConstQA_grid").jqGrid('getDataIDs'); //grid의 id 값을 배열로 가져옴
		for (var i = 0; i < idArry.length; i++) {
			if($("input:checkbox[id='jqg_stdConstQA_grid_"+idArry[i]+"']").is(":checked")){
				var rowdata = $("#stdConstQA_grid").getRowData(idArry[i]);
				if(rowdata.DEL_YN == "Y")
				params.push(rowdata.DOCUMENT_SRL);
			}
		}
		if(params.length == 0) {
			alert("복원할 질문글이 없습니다. 삭제상태의 글을 선택해주세요.");
			return;
		}
		if(confirm("선택한 질문글을 복원하시겠습니까?")) {
			// 선택된 행 가운데 복원대상 문서만 복원
			ajax({
				url : "/content/changeBoardType3List",
				data: {doc_srl_arr:params},
				success: function(data) {
					if(data.RESULT = "S") {
						alert("해당 질문글이 복원되었습니다.");
						stdConstQA_grid.retreive();	
					}
				}
			});
		}
	});
	
	// 삭제
	$("#btn_document_del").click(function() {
		stdConstQA_grid.remove(); // {success:function(){alert('remove success');}}
	});

	// 검색조건 : 작성기간
	setDatepicker("#reg_date", "_from", "_to");
});

//grid resizing
$(window).resize(function(){
	stdConstQA_grid.setGridWidth($('.tblType1').width());
});
</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
		<h1><%=_title %></h1>	
			<form name="search" id="search" onsubmit="return false">
			<table class="tblType1">
				<colgroup>
					<col width="14%" />
					<col width="15%" />
					<col width="14%" />
					<col width="15%" />
					<col width="13%" />
					<col width="15%" />
					<col width="14%" />
				</colgroup>
				<tr>
					<th>검색구분</th>
					<td><span class="txt_pw"><select class="select w100" name="sch_type" id="sch_type"><option value="1">제목</option><option value="2">내용</option><option value="3">제목+내용</option></select></span></td>
					<th>검색내용</th>
					<td colspan="3"><span class="txt_pw"><input type="text" name="sch_type_txt" id="sch_type_txt" class="w100"/></span></td>
					<td><div class="grid_btn"><button type="button" class="btn_common btn_darkGray" id="btn_retreive">조회</button></div></td>
				</tr>
				<tr>
					<th>처리상태</th>
					<td><span class="txt_pw"><select class="select w100" name="proc_cd" id="proc_cd"><option value="">전체</options><option value="1">등록완료</option><option value="2">답변준비중</option><option value="3">답변완료</option></select></span></td>
					<th>공개설정</th>
					<td><span class="txt_pw"><select class="select w100" name="status" id="status"><option value="">전체</options><option value="PUBLIC">공개</option><option value="SECRET">비공개</option></select></span></td>
					<th>글상태</th>
					<td><span class="txt_pw"><select class="select w100" name="del_yn" id="del_yn"><option value="">전체</options><option value="Y">삭제</option><option value="N">일반</option></select></span></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><span class="txt_pw"><input type="text" name="user_nm" id="user_nm" class="w100"/></span></td>
					<th>아이디</th>
					<td><span class="txt_pw"><input type="text" name="login_id" id="login_id" class="w100"/></span></td>
					<th>작성기간</th>
					<td colspan="2"><span class="txt_pw"><input type="text" id="reg_date_from" name="reg_date_from" class="w45"/>&nbsp;~&nbsp;<input type="text" id="reg_date_to" name="reg_date_to" class="w45"/></span></td>
				</tr>
				<tr>
				</tr>
			</table>
			<table class="tblType3">
				<tr><td><div class="grid_btn">
					<button class="btn_common btn_darkGray" id="btn_document_chg">선택복원</button>
					<button class="btn_common btn_darkGray" id="btn_document_del">완전삭제</button>
				</div></td></tr>
			</table>
			</form>

		<!-- Grid -->
		<table id="stdConstQA_grid"></table>
		<div id="stdConstQA_grid_pager"></div>
		<!-- Grid // -->
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
