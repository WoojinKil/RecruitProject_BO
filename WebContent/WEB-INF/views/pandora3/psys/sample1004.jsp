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
.mT20 {margin-top:20px;}
.mT15 {margin-top:15px;}
.mR10 {margin-right:10px;}
</style>
<script type="text/javascript">
var role_grid;
var menu_grid;


var _row_idx = 0;
var _rol_mnu_seq = "";
var tbWidth = 0;

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
			{name : 'SYS_CD', label:'시스템', hidden:true},
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
                {
                	menu_grid.retreive({data:{rol_id:row.ROL_ID,sys_cd:row.SYS_CD}});
                	$("#mnu_btn").data("row", 0);
                	_rol_mnu_seq = "";
                }
            }
		}
	};
    
    var menu_config = { 
		gridid		: 'menu_grid',
		pagerid		: '',
		columns		: [
			{name : 'ROL_ID', label : '권한ID', hidden : true},
			{name : 'PGM_ID', label : '프로그램ID', hidden : true},
			{name : 'BTN_CD', label : '버튼저장대상', hidden : true},
			{name : 'MIDD_MNU_SEQ' , label : '상위메뉴ID', editable : false, width : 60},
			{name : 'MIDD_MNU_NM' , label : '상위메뉴명', editable : false, align:'left', width : 100},
			{name : 'MNU_SEQ' , label : '메뉴ID',editable : false, width : 60},
			{name : 'MNU_NM' , label : '메뉴명', editable : false, align:'left', width : 200}
		],
		initval		: {},								// 컬럼 add 시 초기값
		editmode	: true,								// 그리드 editable 여부
		gridtitle	: '권한 메뉴 목록',						// 그리드명
		multiselect	: true,								// checkbox 여부
		height		: '240',							// 그리드 높이
		shrinkToFit	: true,								// true인경우 column의 width 자동조정, false인경우 정해진 width데로 구현(가로스크롤바필요시 false)
		selecturl	: '/psys/getPsys1030MnuList',	// 그리드 조회 URL
		saveurl		: '/psys/savePsys1030',		// 그리드 입력/수정/삭제 URL
		events		: {  
			onCellSelect: function(event, rowIdx, colIdx, value){
				var row = menu_grid.getRowData(rowIdx);
				$("#mnu_btn").data("row", rowIdx);
				
				// 현재 메뉴ID 셋팅
            	_rol_mnu_seq = row.MNU_SEQ;
				
				// 체크박스가 아닌 셀을 클릭했을 때 조회함수 발생
				if(menu_grid.getColName(colIdx) != "cb"){
					fn_retreiveBtn(row);	
				}
			},
			gridComplete : function(){
				// 조회 후 초기화 인 경우 버튼 초기화
				if(isEmpty(_rol_mnu_seq)) {
					$("#mnu_btn input").prop("checked", false);
					$("#mnu_btn").children().show();
					menu_grid.setCellFocus(1, 2);
				} else {
					var idx = menu_grid.getRowIndexByValue("MNU_SEQ", _rol_mnu_seq);
					if(idx.length < 1) {
						menu_grid.setCellFocus(1, 2);
					}else {
						menu_grid.setCellFocus(idx[0], 2);
					}
				}
				
			}
		}
	};
    
    role_grid = new UxGrid(role_config);
    role_grid.init();
    
    menu_grid = new UxGrid(menu_config);
    menu_grid.init();
    
    tbWidth = parseFloat($('.tblType1').width() * (49.5/100));
    role_grid.setGridWidth($('.tblType1').width());
    menu_grid.setGridWidth(tbWidth);
    /* $("#btn_list").css("width", tbWidth); */
    
    
	// 메뉴 그리드 - 저장 버튼 클릭
    $("#btn_menu_save").click(function() {
        menu_grid.save();
    });
    
    // 메뉴 그리드 - 검색 버튼 클릭
    $("#btn_menu_add").click(function(){
    	
    	var sys_cd = $("#sys_info").val();

        var role = role_grid.getSelectRowIDs();
        
        if(role.length < 1) {
            alert('권한을 선택하세요');
            return;
        }
        else if(role.length > 1) {
            alert('권한을 하나만 선택하세요');
            return;
        }
        
		bpopup({
			  url:"/psys/forward.sample1004p001.adm"
			, params	: {callback : "fn_addRoleMenuBtn", sys_cd : sys_cd, target_id : _menu_id}
			, title		: "메뉴 조회"                          
			, type		: "l"
			, id        : "sample1004p1"
		});
         
	});
    
 	// 메뉴 그리드 - 검색 버튼 클릭
    $("#btn_menu_add2").click(function(){
    	
    	var sys_cd = $("#sys_info").val();

        var role = role_grid.getSelectRowIDs();
        
        if(role.length < 1) {
            alert('권한을 선택하세요');
            return;
        }
        else if(role.length > 1) {
            alert('권한을 하나만 선택하세요');
            return;
        }
        
		bpopup({
			  url:"/psys/forward.sample1004p001.adm"
			, params	: {callback : "fn_addRoleMenuBtn", sys_cd : sys_cd, target_id : _menu_id}
			, title		: "메뉴 조회"                          
			, type		: "l"
			, id        : "sample1004p1"
		});
         
	});
    
    // 메뉴 그리드 - 삭제 버튼 클릭
    $("#btn_menu_del").click(function() {
        menu_grid.remove();
    });

    // 메뉴 버튼 클릭 시 이벤트 바인딩
    $("#mnu_btn input").on("click", fn_setRoleButton);
    
    // 메뉴 버튼 저장
    $("#btn_mnu_btn_save").click(function() {
    	fn_saveBtn();
    });
    
  	//사이트 리스트 취득
    getSystemList();
    
  	//시스템 변경 시 재 검색
	$("#sys_info").on("change", function () {
		fn_Search();
	});   
  	
});

// [SAMPLE] 입력한 select id에 속한 데이터목록을 조회하는 함수
var params = {
	  	            "sel_id"        : "selectPsysList"
	  	           , "p1"           : "BBS0001"                                     	
	  	           , "p2"           : "p2"                                     	
	  	           , "p3"           : "p3"                                     	
	  	           , "p4"           : "p4"                                     	
	  	           , "p5"           : "p5"                                     	
              };
	
getPsysCommonInfoList(params, function callBackFunc(data) {
	for(var i in data) {
		console.log( i + " CODE_CD :: " + data[i].CODE_NM_1 );
	}
});

$(window).resize(function() {
	tbWidth = parseFloat($('.tblType1').width() * (49.5/100));
	role_grid.setGridWidth($('.tblType1').width());
	menu_grid.setGridWidth(tbWidth);
    /* $("#btn_list").css("width", tbWidth); */
});

// 버튼 사용여부 변경 시 저장 데이터 생성
function fn_setRoleButton(e) {
	var rowIdx = $(e.target).parent().data("row");
		
	var row = menu_grid.getRowData(rowIdx);
	
	var temp = [];
	
	$("#mnu_btn input:visible").each(function(idx, item) {
		if($(this).is(":checked"))
			temp.push($(this).val());
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
// 권한 메뉴 목록 저장 버튼 클릭 시
function fn_saveBtn() {
	var rowIdx = $("#mnu_btn").data("row");
	
	var row = menu_grid.getRowData(rowIdx);
	
	if(isNotEmpty(row.MNU_SEQ) && isNotEmpty(row.ROL_ID) && isNotEmpty(row.PGM_ID)) {
		if (row.JQGRIDCRUD == "C") {
			alert("권한 메뉴를 먼저 등록해주세요.");
			$("#mnu_btn input").prop("checked", false);
			return;
		}
		var temp = row.BTN_CD;
		
		var params = {
			rol_id     : row.ROL_ID,
			pgm_id     : row.PGM_ID,
			mnu_seq    : row.MNU_SEQ,
			pgm_btn_cd : temp
		};
		ajax({
			url:'/psys/savePsys1030BtnList.adm',
			data: params,
			success: function(data) {
				
				if(data.RESULT == _boolean_success) {
					alert("정상적으로 저장되었습니다.");
				}
			}
		});	
	}
		
}

// 권한 메뉴 클릭 시, 메뉴 버튼 목록 조회
function fn_retreiveBtn(row) {
	
	// 모든 자식 체크 해제 & 숨김
	$("#mnu_btn input").prop("checked", false);
	$("#mnu_btn").children().hide();
	
	if(isNotEmpty(row.MNU_SEQ) && isNotEmpty(row.ROL_ID) && isNotEmpty(row.PGM_ID)) {
		var params = {
				rol_id : row.ROL_ID,
				pgm_id : row.PGM_ID,
				mnu_seq: row.MNU_SEQ
		};
		ajax({
			url:'/psys/getPsys1030BtnList.adm',
			data: params,
			success: function(data) {
				if(data.rows.length > 0) {
					fn_setCheckBox(data.rows[0]);
				}
			}
		});	
	}
	
}

// 메뉴 버튼 목록 체크박스 표시
function fn_setCheckBox(row)
{
	var pgm_btn = row.PGM_BTN;
	var rol_btn = row.ROL_BTN;
	
	// 대상이 없는 경우
	if(isEmpty(pgm_btn))
		return;
	
	pgm_btn = pgm_btn.split(",");

	for(var i in pgm_btn)
	{
		$("#mnu_btn #mnu_btn_" + pgm_btn[i]).show();
		$("#mnu_btn label[for='mnu_btn_" +  pgm_btn[i] + "']").show();
		
		if(isNotEmpty(rol_btn))
			if (rol_btn.indexOf(pgm_btn[i]) > -1)
				$("#mnu_btn #mnu_btn_" + pgm_btn[i]).prop("checked", true);
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

        _rol_mnu_seq = "";
        
        if(!isExist)
        {
        	_rol_mnu_seq = menu_list[i].MNU_SEQ;
        	
			menu_grid.add({
				ROL_ID		: role[0].ROL_ID,
				PGM_ID		: menu_list[i].PGM_ID,
				MNU_SEQ		: menu_list[i].MNU_SEQ,
				MNU_NM		: menu_list[i].MNU_NM,
				MIDD_MNU_SEQ: menu_list[i].MIDD_MNU_SEQ,
				MIDD_MNU_NM	: menu_list[i].MIDD_MNU_NM,
			});
		}else {
			alert("이미 존재하는 메뉴입니다.");
		}
	}
}
    
// 조회 : 내부 로직 사용자 정의
function fn_Search()
{
	var sys_cd = $("#sys_info").val();
	_row_idx = 0;
	
	$("#sys_cd").val(sys_cd);
	$("#mnu_btn input").prop("checked", false);
	$("#mnu_btn").children().show();

	//시스템(사이트) 구분 필수
	if(isEmpty(sys_cd)) {
		role_grid.clearGridData();
		menu_grid.clearGridData();
    	alert("시스템을 선택해 주세요.");
    	return false;
	}
	role_grid.retreive(); 
	menu_grid.clearGridData();      
}

// 엑셀다운로드 : 내부 로직 사용자 정의
function fn_ExcelDownload(){
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
	    	<div class="tableTopLeft gridBtn" style="display: none;">
				<div class="selectInner">
					<label for="sys_info">시스템 : </label>
					<select id="sys_info" name="sys_info" class="select" >
						<option value="">선택</option>
					</select>
				</div>
			</div>
            <!-- <form name="search" id="search" name="search" onsubmit="return false">
            	<input type="hidden" name="sys_cd" id="sys_cd" value="" />
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
		                    <span class="txt_pw"><input type="text" name="rol_nm" id="rol_nm" class="text w50" value="" maxlength="12" maxlength="300"/></span>
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
				<form id="search" name="search" onsubmit="return false">
					<input type="hidden" name="sys_cd" id="sys_cd" value="" />
		            <table class="tblType1 typeShort">   
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
				                    <span class="txt_pw"><input type="text" name="rol_nm" id="rol_nm" class="text" value="" maxlength="12" maxlength="300"/></span>
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
						</tbody>
		            </table>
		       </form>
			</div>
			<div class="bgBorder"></div>
	        <!-- search // -->
	        
	        <table id="role_grid"></table> 
			<div id="role_grid_pager"></div>
			
			<div class="bgBorder"></div>
	        <!-- Grid -->
	        <div class="gd_row">
	    		<div class="gd_inner">
					<div class="gd_col_6"> 
						<!-- <div class="tableBtnWrap gridBtn">
							<div id="btn_menu_grid" class="tableBtn">
								<button class="btn_common btn_default" id="btn_menu_add">행추가</button>
								<button class="btn_common btn_default" id="btn_menu_del">행삭제</button>
								<button class="btn_common btn_default" id="btn_menu_save">저장</button>
							</div>
						</div> -->
						<div class="grid_right_btn">
							<div id="btn_menu_grid" class="grid_right_btn_in">
								<button class="btn_common btn_default" id="btn_menu_add">
									<img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/bg_magnify.png" alt="검색버튼" />
								</button>
								<button class="btn_common btn_default" id="btn_menu_add2">검색</button>
								<button class="btn_common btn_default" id="btn_menu_del">삭제</button>
								<button class="btn_common btn_default" id="btn_menu_save">저장</button>
								<!-- <button class="btn_common btn_default" id="btn_code_master_excel" name="_btnList" value="30"><img src="/vip/resources/pandora3/images/common_new/img_download.png" alt="다운로드"></button>
								<button class="btn_common btn_default" id="" name="_btnList"><img src="/vip/resources/pandora3/images/common_new/img_upload.png" alt="업로드"></button> -->
							</div>
						</div>
						<table id="menu_grid"></table> 
			        	<div id="menu_grid_pager"></div>
		        	</div>
		        	<div class="gd_col_6">
		        		<div id="btn_list" class="tableType">
							<div class="tableBtnWrap">
			                  <p class="tableTitle">메뉴 버튼 목록</p>
			                  <div class="tableBtn">
			                     <button class="btn_common btn_default" id="btn_mnu_btn_save">저장</button>
			                  </div>
			               	</div>
							<table class="tblType1">
								<colgroup>
									<col width="20%" />
									<col width="*%" />
								</colgroup>
								<tr>
									<th colspan="2"><span class="necessary">버튼을 선택하지 않는 경우, 전체 버튼 [사용]으로 적용됩니다.</span></th>
								</tr>
								<tr>
									<th><label for="">버튼</label></th>
									<td>
										<div  id="mnu_btn"><!-- class="check" -->
											<div class="tableCheck">
												<label class="container typeInspect" for="mnu_btn_10">조회
													<input type="checkbox" value="10" id="mnu_btn_10">
													<span class="checkmark"></span>
												</label>
											</div>
											<div class="tableCheck">
												<label class="container typeInspect" for="mnu_btn_20">저장
													<input type="checkbox" id="mnu_btn_20" value="20">
													<span class="checkmark"></span>
												</label>
											</div>
											<div class="tableCheck">
												<label class="container typeInspect" for="mnu_btn_30">
													<input type="checkbox" id="mnu_btn_30" value="30">엑셀다운로드
													<span class="checkmark"></span>
												</label>
											</div>
											<div class="tableCheck">
												<label class="container typeInspect" for="mnu_btn_40">삭제
													<input type="checkbox" id="mnu_btn_40" value="40">
													<span class="checkmark"></span>
												</label>
											</div>
											<div class="tableCheck">
												<label class="container typeInspect" for="mnu_btn_50">인쇄
													<input type="checkbox" id="mnu_btn_50" value="50">
													<span class="checkmark"></span>
												</label>
											</div>
											<div class="tableCheck">
												<label class="container typeInspect" for="mnu_btn_60">추가
													<input type="checkbox" id="mnu_btn_60" value="60">
													<span class="checkmark"></span>
												</label>
											</div>
											<div class="tableCheck">
												<label class="container typeInspect" for="mnu_btn_70">승인
													<input type="checkbox" id="mnu_btn_70" value="70">
													<span class="checkmark"></span>
												</label>
											</div>
											<div class="tableCheck">
												<label class="container typeInspect" for="mnu_btn_80">도움말
													<input type="checkbox" id="mnu_btn_80" value="80">
													<span class="checkmark"></span>
												</label>
											</div>
											<div class="tableCheck">
												<label class="container typeInspect">목록
													<input type="checkbox" id="mnu_btn_90" value="90">
													<span class="checkmark"></span>
												</label>
											</div>
										</div>
									</td>
								</tr>
							</table>
						</div>
		        	</div>
	    		</div>
			</div>
	        <!-- Grid // -->
	    </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
