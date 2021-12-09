<%-- 
    개요 : BO 사용자 관리
    수정사항 :
        2017-11-09 최초작성
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>
<script type="text/javascript">
var admin_grid;
$(document).ready(function(){
	// 공통코드 복수 설정
	$("#mst_cd_arr").val(new Array( 'USER_AUTH', 'MSTS'))
	ajax({
		url: '/system/selectMultiSysCdDtlList',
		data : $("form[name=frm_sysCdDtl]").serialize(),
		success: function(data) {
			makeSelectBoxSysCdDtl(data.selectData);
		},
	});
	
    var admin_config = { 
        // grid id
        gridid: 'admin_grid',
        pagerid: 'admin_grid_pager',
        // column info
        columns:[{name:'USER_ID', label:'사용자SRL', hidden:true},
        		{name:'REG_ID', label:'등록자', hidden:true},
        		{name:'MOD_ID', label:'수정자', hidden:true},
        		{name:'EMAIL',label:'이메일', align:'center',required:true, sortable:false,editable:true,
			 	cellattr: function(rowId, tv, rowObject, cm, rdata) {if(isNotEmpty(rowObject.EMAIL)){ return 'style="cursor: pointer; text-decoration: underline;"'}}},
			 	{name:'LOGIN_ID', label:'아이디',align:'center',required:true, sortable:false,editable:true},
			 	{name:'USER_STATUS', label:'상태', align:'center', editable:false, sortable:false, formatter:'select',editoptions:{value:'<%=CodeUtil.getGridComboList("MSTS")%>'}},
			 	{name:'USER_NM', label:'이름', align:'center',required:true, sortable:false,editable:true},
				{name:'ACTIVE_YN', label:'계정활성화', align:'center', editable:true, edittype:'select', formatter:'select', editoptions:{value:'Y:활성화;N:비활성화'}},
				{name:'REG_DATE', label:'가입일', align:'center', editable:false, formatter:'date', formatoptions: {srcformat: 'U',newformat:'Y-m-d'}},
				{name:'MOD_DATE', label:'수정일자', align:'center', editable:false, formatter:'date', formatoptions: {srcformat: 'U',newformat:'Y-m-d'}}
				
		],          
        //initval: {US_YN:'Y', SORT_ORD:999, MST_CD:'A00'},             // 컬럼 add 시 초기값
        editmode: false,                                  // 그리드 editable 여부
        gridtitle: '사용자관리 목록',                         // 그리드명
        multiselect: true,                              // checkbox 여부
        formid: 'search',                                // 조회조건 form id
        height: 200,                                     // 그리드 높이
        shrinkToFit: true,                               // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl: '/system/selectSysAdminGridList.do',  // 그리드 조회 URL
        saveurl: '/system/updateSysAdminList.do',        // 그리드 입력/수정/삭제 URL
        events: {
                 onSelectRow: function(event, rowid) {
                     var row = admin_grid.getRowData(rowid);
                     
                 },
                 onCellSelect: function(event, rowid, icol) {        // 해당 셀 선택시
                     var row = admin_grid.getRowData(rowid);
                 	//row.JQGRIDCRUD='U';
                 	//alert(row.JQGRIDCRUD)
                 /* 	admin_grid.setCell(rowid, 'JQGRIDCRUD', 'U') */
                 //admin_grid.setCell(rowid,"ACTIVE_YN","N");
                 }
        }
    };
    
      
    admin_grid = new UxGrid(admin_config);
    admin_grid.init();
    admin_grid.setGridWidth($('.tblType1').width());
    
    $("#btn_retreive").click(function() {
        admin_grid.retreive();
    });
    
    $("#btn_admin_save").click(function() {
    	var rowid = admin_grid.getSelectRowIDs();
        var row = admin_grid.getRowData(rowid);

        admin_grid.save();  

    });
 // 검색조건 : 가입일 설정
	setDatepicker("#reg_date", "_from", "_to");
    
    $("#btn_admin_add").click(function() {
    	// default 값 세팅
    	addTabInFrame("/system/admin/forward.adminInfoReg.adm");

    });
    
    $("#btn_admin_del").click(function() {
    	var rowid = admin_grid.getSelectRowIDs();
    	var row = admin_grid.getRowData(rowid);
    	
    	admin_grid.remove();
    	
    });
});

//grid resizing
$(window).resize(function() {
	admin_grid.setGridWidth($('.tblType1').width());
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
					<col width="13%" />
					<col width="30.5%" />
					<col width="13%" />
					<col width="30.5%" />
					<col width="13%" />
				</colgroup>
				<tr>
					<th>가입일</th>
					<td><span class="txt_pw"><input type="text" id="reg_date_from" name="reg_date_from" class="w45"/><span style="width:10%;display: inline-block;text-align: center;">~</span><input type="text" id="reg_date_to" name="reg_date_to" class="w45"/></span></td>
					<th>이메일</th>
					<td><span class="txt_pw"><input type="text" name="email" id="email" class="w100"/></td>
					<td><div class="grid_btn"><button type="button" class="btn_common btn_darkGray" id="btn_retreive">조회</button></div></td>
				</tr>
				<tr>
					
					<th>이름</th>
					<td><span class="txt_pw"><input type="text" name="user_nm" id="user_nm" class="w100"/></span></td>
					<th>아이디</th>
					<td><span class="txt_pw"><input type="text" name="login_id" id="login_id" class="w100"/></span></td>
					<td></td>
				</tr>
				<tr>
					<th>상태</th><td><select id="user_status", name="user_status" class="select"><option value="">전체</options></select></td>
					<th>계정활성화</th>
					<td><span class="txt_pw"><select class="select" name="active_yn" id="active_yn"><option value="">전체</options><option value="Y">활성화</option><option value="N">비활성화</option></select></span></td>
					<td></td>
				</tr>
				
			</table>
			<table class="tblType3">
				<tr>
					<td>
						<div class="grid_btn">
						<button class="btn_common btn_darkGray" id="btn_admin_add">추가</button>
						<button class="btn_common btn_darkGray" id="btn_admin_del">삭제</button>
						</div>
					</td>
				</tr>
			</table>
			</form>
			<!-- search // -->
			<!-- Grid -->
			<table id="admin_grid"></table>
			<div id="admin_grid_pager"></div>
			<!-- Grid // -->
		</div>
		<form name="frm_sysCdDtl" id="frm_sysCdDtl" submit="return false;">
		<input type="hidden" name="mst_cd_arr" id="mst_cd_arr" />
	</form>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>
