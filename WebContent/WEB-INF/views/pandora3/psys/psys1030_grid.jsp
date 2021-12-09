<%-- 
   1. 파일명	: psys1030
   2. 파일설명	: 권한 관리
   3. 작성일	: 2019-03-12
   4. 작성자	: TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<style>
.none {display:none;}
</style>
<script type="text/javascript">
var role_grid;
var menu_grid;

var _row_idx = 0;
var _mnu_seq = "";

// 10 조회, 20 저장, 30 엑셀다운로드, 40 삭제, 50 인쇄, 60 추가, 70 승인, 80 도움말, 90 목록
var _btn = ['10', '20', '30', '40', '50', '60', '70', '80', '90'];
var _col = ['SCH', 'SV', 'XLS', 'DEL', 'ADD', 'PRN', 'APV', 'HCO', 'LST'];

// 한글 입력 방지
function fn_onKeyUp(e)
{
	$(e).keyup(function(){
        element.value = element.value.replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' );
    });
}

function fn_datePicker(e){
	$(e).datepicker({dateFormat:'yy-mm-dd',changeYear:true,changeMonth:true});
}

$(document).ready(function(){
    var role_config = {
		gridid		: 'role_grid',
		pagerid		: 'role_grid_pager',
		columns:[
			{name : 'ROL_ID', label:'권한ID', align : 'center',  sorttype : 'int', width : 60, editoptions : {dataInit : fn_onKeyUp}},
			{name : 'ROL_NM', label:'권한명', align : 'left', edittype : 'text', width : 200},
			{name : 'US_YN', label:'사용여부', align : 'center',  edittype : 'select', formatter : 'select', editoptions : {value:'Y:사용;N:미사용'}, width : 80, required : true},
			{name : 'F_APL_ST_DT', label : '적용시작일자', align : 'center',  width : 120, editoptions : {dataInit:fn_datePicker}},
			{name : 'F_APL_ED_DT', label : '적용종료일자', align : 'center', width : 120, editoptions : {dataInit:fn_datePicker}},
			{name : 'UPD_DTTM', label : '변경일자', align : 'center', width : 100, formatter : 'date', formatoptions : {srcformat: 'U',newformat:'Y-m-d'}}
		],
        initval		: {US_YN:'Y', F_APL_ED_DT:'9999-12-31'},	// 컬럼 add 시 초기값
        editmode	: false,										// 그리드 editable 여부
        gridtitle	: '권한 목록',									// 그리드명
        multiselect	: false,									// checkbox 여부
        formid		: 'search',									// 조회조건 form id
        height		: '150',									// 그리드 높이
        selecturl	: '/psys/getPsys1030List',				// 그리드 조회 URL
        events		: {
        	onCellSelect: function(event, rowIdx){
        		
        		if(_row_idx == rowIdx)
        			return;
        		else
        			_row_idx = rowIdx

                var row = role_grid.getRowData(rowIdx);
                
                if(isNotEmpty(row.ROL_ID))
                     menu_grid.retreive({data:{rol_id:row.ROL_ID}});
            }
		}
	};
    
    var menu_config = { 
		gridid		: 'menu_grid',
		pagerid		: '',
		columns		: [
			{name : 'ROL_ID', label : '권한ID', hidden : true},
			{name : 'PGM_ID', label : '프로그램ID', hidden : true},
			{name : 'PGM_BTN', label : '프로그램버튼목록', hidden : true},
			{name : 'ROL_BTN', label : '메뉴버튼목록', hidden : true},
			{name : 'BTN_CD', label : '버튼저장대상', hidden : true},
			{name : 'MIDD_MNU_SEQ' , label : '상위메뉴ID', editable : false, width : 60, hidden : true},
			{name : 'MIDD_MNU_NM' , label : '상위메뉴명', editable : false, align:'left', width : 100},
			{name : 'MNU_SEQ' , label : '메뉴ID',editable : false, width : 60, hidden : true},
			{name : 'MNU_NM' , label : '메뉴명', editable : false, align:'left', width : 200},
			{name : 'SCH', label : '조회', editable : true, width : 80, align:'center', edittype: 'checkbox', formatter:'checkbox', formatoptions:{disabled:false}},
			{name : 'SV', label : '저장', editable : true,  width : 80, align:'center', edittype: 'checkbox', formatter:'checkbox', formatoptions:{disabled:false}},
			{name : 'XLS', label : '엑셀다운로드', editable : true, width : 80, align:'center', edittype: 'checkbox', formatter:'checkbox', formatoptions:{disabled:false}},
			{name : 'DEL', label : '삭제', editable : true, width : 80, align:'center', edittype: 'checkbox', formatter:'checkbox', formatoptions:{disabled:false}},
			{name : 'ADD', label : '추가', editable : true, width : 80, align:'center', edittype: 'checkbox', formatter:'checkbox', formatoptions:{disabled:false}},
			{name : 'PRN', label : '인쇄', editable : true, widtㅠh : 80, align:'center', edittype: 'checkbox', formatter:'checkbox', formatoptions:{disabled:false}},
			{name : 'APV', label : '승인', editable : true, width : 80, align:'center', edittype: 'checkbox', formatter:'checkbox', formatoptions:{disabled:false}},
			{name : 'HCO', label : '도움말', editable : true, width : 80, align:'center', edittype: 'checkbox', formatter:'checkbox', formatoptions:{disabled:false}},
			{name : 'LST', label : '목록', editable : true, width : 80, align:'center', edittype: 'checkbox', formatter:'checkbox', formatoptions:{disabled:false}}
		],
		initval		: {},								// 컬럼 add 시 초기값
		editmode	: true,								// 그리드 editable 여부
		gridtitle	: '권한 메뉴 목록',						// 그리드명
		multiselect	: true,								// checkbox 여부
		height		: '500',							// 그리드 높이
		shrinkToFit	: true,								// true인경우 column의 width 자동조정, false인경우 정해진 width데로 구현(가로스크롤바필요시 false)
		selecturl	: '/psys/getPsys1030MnuList',	// 그리드 조회 URL
		saveurl		: '/psys/savePsys1030',		// 그리드 입력/수정/삭제 URL
		events		: {  
			onCellSelect: function(event, rowIdx, colIdx, value){
				event.preventDefault();				
				
				var colNm = menu_grid.getColName(colIdx);
				
				if(colNm == 'MNU_NM')
					return;
				
				var row = menu_grid.getRowData(rowIdx);
				
				// console.log(row.PGM_BTN, "- - - - -", _btn[jQuery.inArray(colNm, _col)]);
				
				if(isEmpty(row.PGM_BTN) || row.PGM_BTN.indexOf(_btn[jQuery.inArray(colNm, _col)]) < 0)
					$('#menu_grid').setColProp(colNm, {editable:false});
			},
			gridComplete : function(){

				// 행추가인 경우
				if(isNotEmpty(_mnu_seq))
				{
					fn_setCheckBox(menu_grid.getRowIndexByValue('MNU_SEQ', _mnu_seq)[0]);
				}
				// 조회 후 초기 설정인 경우
				else 
				{
					var idx = $("#menu_grid").jqGrid('getDataIDs');
					
						// 전체 데이터를 한바퀴 돌면서 프로그램에서 사용하지 않는 버튼인 경우 보이지 않도록 한다
					for(var i=0 ; i<idx.length ; i++)
						fn_setCheckBox(idx[i]);
				}
			}
		}
	};
    
    role_grid = new UxGrid(role_config);
    role_grid.init();
    
    menu_grid = new UxGrid(menu_config);
    menu_grid.init();
    
    role_grid.setGridWidth($('.tblType1').width());
    menu_grid.setGridWidth($('.tblType1').width());
    
	// 메뉴 그리드 - 저장 버튼 클릭
    $("#btn_menu_save").click(function() {
        menu_grid.save(); 
    });
    
    // 메뉴 그리드 - 행추가 버튼 클릭
    $("#btn_menu_add").click(function(){

        var role = role_grid.getSelectRowIDs();
        
        if(role.length < 1)
        {
            alert('권한을 선택하세요');
            return;
        }
        else if(role.length > 1)
        {
            alert('권한을 하나만 선택하세요');
            return;
        }
        
		popup({
			  url:"/psys/forward.psys1030p001.adm"
			, params	: {callback : "fn_addRoleMenuBtn"}
			, winname	: "_menu_pop"
			, title		: "메뉴 조회"                          
			, type		: "m"
			, height	: "460"
			, scrollbars: false
			, autoresize: false
		});   
	});
    
    // 메뉴 그리드 - 삭제 버튼 클릭
    $("#btn_menu_del").click(function() {
        menu_grid.remove();
    });

    $(document).on("click", "#menu_grid input:visible", fn_setRoleButton);
});

$(window).resize(function() {
	role_grid.setGridWidth($('.tblType1').width());
	menu_grid.setGridWidth($('.tblType1').width());
});

// 버튼 사용여부 변경 시 저장 데이터 생성
function fn_setRoleButton(e)
{
	var rowIdx = $(e.target).parent().data("row");
		
	var row = menu_grid.getRowData(rowIdx);
	
	var temp = [];
	
	$("#menu_grid #" + rowIdx + " input:visible").not(".cbox").each(function(idx, item){
		if($(this).is(":checked"))
			temp.push($(this).parent().data("value"));
	});
	
	temp = temp.join(",");
	
	// 체크 된 행만 INSERT 처리
	menu_grid.setRowData(rowIdx, {BTN_CD : temp});
	
	// 신규인 경우 행 상태 변경하지 않음
	if(row.JQGRIDCRUD != "C")
	{
		if(temp != row.ROL_BTN)
			menu_grid.setRowData(rowIdx, {JQGRIDCRUD : 'U'});
		else
			menu_grid.setRowData(rowIdx, {JQGRIDCRUD : ''});
	}
			
}

function fn_setCheckBox(rowIdx)
{
	var row = menu_grid.getRowData(rowIdx);
	
	for(var j=0 ; j<_btn.length ; j++)
	{
		// $("#menu_grid #1 td[aria-describedby='menu_grid_SCH'] input[type='checkbox']")
		var target = "#menu_grid #" + rowIdx + " td[aria-describedby='menu_grid_" + _col[j] +"'] input[type='checkbox']";
		
		// 프로그램에 사용되는 버튼이 아예 없거나, 해당 버튼이 미사용인 경우
		if(isEmpty(row.PGM_BTN) || row.PGM_BTN.indexOf(_btn[j]) < 0) 
		{
			$(target).addClass("none");
			continue;
		}
		
		$(target).parent().data("row", rowIdx);
		$(target).parent().data("value", _btn[j]);
		
		// 따로 설정한 버튼이 없는경우 디폴트 체크 상태
		// if(isEmpty(row.ROL_BTN)) 
		// 	$(target).prop("checked", true);
		
		// 권한에서 특정 버튼만 사용하면 해당 버튼만 체크
		// else if(row.ROL_BTN.indexOf(_btn[j]) > -1)
		if(row.ROL_BTN.indexOf(_btn[j]) > -1)
			$(target).prop("checked", true);
	}
}


// 메뉴 조회  팝업 콜백 함수
function fn_addRoleMenuBtn(rows)
{
    var role = role_grid.getSelectRows();
    
    if(role.length < 1)
    {
        alert('권한을 선택하세요');
        return;
    }
    else if(role.length > 1)
    {
        alert('권한을 하나만 선택하세요');
        return;
    }

    var menu_list = rows || {};
    
    for(var i=0; i < menu_list.length ; i++)
	{
        var isExist = false;

        // 기존에 추가되어있는지 확인  
        if(menu_grid.getRowIndexByValue('MNU_SEQ', menu_list[i].MNU_SEQ).length > 0)
        	isExist = true;

        _mnu_seq = "";
        
        if(!isExist)
        {
        	_mnu_seq = menu_list[i].MNU_SEQ;
        	
        	// console.log(menu_list);
        	// ★★★★★ 확인필요 : PGM_ID가 없는 경우 처리 
        	
			menu_grid.add({
				ROL_ID		: role[0].ROL_ID,
				PGM_ID		: menu_list[i].PGM_ID,
				MNU_SEQ		: menu_list[i].MNU_SEQ,
				MNU_NM		: menu_list[i].MNU_NM,
				MIDD_MNU_SEQ: menu_list[i].MIDD_MNU_SEQ,
				MIDD_MNU_NM	: menu_list[i].MIDD_MNU_NM,
				PGM_BTN		: menu_list[i].PGM_BTN,
				ROL_BTN		: '',
			});
		}
	}
    
    _mnu_seq = "";
}
    
// 조회 : 내부 로직 사용자 정의
function fn_Search()
{
	_row_idx = 0;
	
	role_grid.retreive(); 
	menu_grid.clearGridData();      
}

// 엑셀다운로드 : 내부 로직 사용자 정의
function fn_ExcelDownload(){
}

</script>
</head>
<body id="app">
	<div class="frameWrap">
	    <div class="subCon">
	    	<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>    
            <form name="search" id="search" name="search" onsubmit="return false">
	            <table class="tblType1 mB60">   
		            <colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>   
		            <tr>
		                <th>권한명</th>
		                <td>
		                    <span class="txt_pw"><input type="text" name="rol_nm" id="rol_nm" class="text w50" value="" maxlength="12" maxbyte="300"/></span>
		                </td>                
		                <th>사용여부</th>
		                <td>
		                   <select name="us_yn" id="us_yn" class="select">
		                       <option value="">전체</options>
		                       <option value="Y">사용</option>
		                       <option value="N">미사용</option>
		                   </select>
		                </td>
		            </tr>
	            </table>
            </form>
			<br/>
	        <!-- search // -->
	        <!-- Grid -->
	        <table id="role_grid"></table> 
	        <div id="role_grid_pager"></div>
	        <div class="mB60"></div>
			<div class="tableBtnWrap gridBtn">
				<div id="btn_menu_grid" class="tableBtn">
					<button class="btn_common btn_default" id="btn_menu_save">저장</button>
					<button class="btn_common btn_default" id="btn_menu_add">행추가</button>
					<button class="btn_common btn_default" id="btn_menu_del">행삭제</button>
				</div>
			</div>
	        <table id="menu_grid"></table> 
	        <div id="menu_grid_pager"></div>
	        <br/>
	        <!-- Grid // -->    
	    </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
