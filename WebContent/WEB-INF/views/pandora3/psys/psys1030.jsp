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
	
	// 공통코드 복수 설정 SYS001 : 메뉴버튼코드
	$("#mst_cd_arr").val(new Array('SYS001'))
	ajax({
		url: '/psys/getPsysCommon.adm',
		data : $("form[name=frm_sysCdDtl]").serialize(),
		success: function(data) {
			makeData(data.selectData);
		},
	});
	
    var role_config = {
		gridid    : 'role_grid',	    	// 그리드 id
        pagerid   : 'role_grid_pager',		// 그리드 페이지 id
        gridBtnYn : 'Y',					// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
		columns   : [
			          {name : 'SYS_CD', label:'시스템', hidden:true},
			          {name : 'ROL_ID', label:'권한ID', align : 'center',  sorttype : 'int', width : 60, editoptions : {dataInit : fn_onKeyUp}},
			          {name : 'ROL_NM', label:'권한명', align : 'left', edittype : 'text', width : 200},
			          {name : 'US_YN', label:'사용여부', align : 'center',  edittype : 'select', formatter : 'select', editoptions : {value:'Y:사용;N:미사용'}, width : 80},
			          {name : 'F_APL_ST_DT', label : '적용시작일자', align : 'center',  width : 120, editoptions : {dataInit:fn_datePicker}},
			          {name : 'F_APL_ED_DT', label : '적용종료일자', align : 'center', width : 120, editoptions : {dataInit:fn_datePicker}},
			          {name : 'UPD_DTTM', label : '변경일자', align : 'center', width : 100, formatter : 'date', formatoptions : {srcformat: 'U',newformat:'Y-m-d'}}
		             ],
        initval		: {US_YN:'Y', F_APL_ED_DT:'9999-12-31'},	// 컬럼 add 시 초기값
        editmode	: false,									// 그리드 editable 여부
        gridtitle	: '시스템 권한 목록',									// 그리드명
        multiselect	: false,									// checkbox 여부
        formid		: 'search',									// 조회조건 form id
        height		: '150',									// 그리드 높이
        selecturl	: '/psys/getPsys1030List.adm',				// 그리드 조회 URL
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
			            {name : 'ROL_NM', label : '권한명', hidden : true},
			            {name : 'SYS_CD', label : '사이트번호', hidden : true},
			            {name : 'SYS_NM', label : '사이트명', hidden : true},
			            {name : 'PGM_ID', label : '프로그램ID', hidden : true},
			            {name : 'BTN_CD', label : '버튼저장대상', hidden : true},
			            {name : 'STATUS', label:'상태', align:'center', editable:false, width:20},
			            {name : 'MIDD_MNU_SEQ' , label : '상위메뉴ID', editable : false, width : 60},
			            {name : 'MIDD_MNU_NM' , label : '상위메뉴명', editable : false, align:'left', width : 100},
			            {name : 'MNU_SEQ' , label : '메뉴ID',editable : false, width : 60},
			            {name : 'MNU_NM' , label : '메뉴명', editable : false, align:'left', width : 180}
		               ],
		initval		: {},								// 컬럼 add 시 초기값
		editmode	: true,								// 그리드 editable 여부
		gridtitle	: '시스템 권한 별 메뉴 목록',				// 그리드명
		multiselect	: true,								// checkbox 여부
		height		: '240',							// 그리드 높이
		shrinkToFit	: true,								// true인경우 column의 width 자동조정, false인경우 정해진 width데로 구현(가로스크롤바필요시 false)
		selecturl	: '/psys/getPsys1030MnuList.adm',	// 그리드 조회 URL
		saveurl		: '/psys/savePsys1030',		// 그리드 입력/수정/삭제 URL
		rowNum		: 0,
		events		: {  
			ondblClickRow: function(event, rowid, irow, icol){
				var row = menu_grid.getRowData(rowid);
				$("#mnu_btn").data("row", rowid);
				
				// 현재 메뉴ID 셋팅
            	_rol_mnu_seq = row.MNU_SEQ;
				
				// 체크박스가 아닌 셀을 클릭했을 때 조회함수 발생
				if(menu_grid.getColName(icol) != "cb"){
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
    $("#menu_btn_list").css("width", tbWidth);
    
	// 메뉴 그리드 - 저장 버튼 클릭
    $("#btn_menu_save").click(function() {
        menu_grid.save();
    });
    
    // 메뉴 그리드 - 추가 버튼 클릭
    $("#btn_menu_add").click(function(){
    	
    	var sys_cd = $("#sys_info").val();

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
		
		bpopup({
			  url:"/psys/forward.psys1030p001.adm"
			, params	: {callback : "fn_addRoleMenuBtn", sys_cd : sys_cd, target_id : _menu_id}
			, title		: "메뉴 조회"                          
			, type		: "l"
			, scrollbars: false
			, autoresize: false
			, id        : "psys1030p1"
		});
		
	});
 // 메뉴 그리드 - 추가 버튼 클릭
    $("#btn_menu_add2").click(function(){
    	
    	var sys_cd = $("#sys_info").val();

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
		
		bpopup({
			  url:"/psys/forward.psys1030p001.adm"
			, params	: {callback : "fn_addRoleMenuBtn", sys_cd : sys_cd, target_id : _menu_id}
			, title		: "메뉴 별 버튼 목록"
			, type		: "l"
			, scrollbars: false
			, autoresize: false
			, id        : "psys1030p1"
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

//grid resizing
$(window).resize(function() {
	tbWidth = parseFloat($('.tblType1').width() * (49.5/100));
	role_grid.setGridWidth($('.tblType1').width());
	menu_grid.setGridWidth(tbWidth);
    $("#menu_btn_list").css("width", tbWidth);
});

// 버튼 사용여부 변경 시 저장 데이터 생성
function fn_setRoleButton(e) {
	var rowIdx = $(e.target).parents("#mnu_btn").data("row");
	var row    = menu_grid.getRowData(rowIdx);
	var temp   = [];
	
	$("#mnu_btn input[name=mnu_btn]:checked").each(function(idx, item) {
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
	var row    = menu_grid.getRowData(rowIdx);
	if(isNotEmpty(row.MNU_SEQ) && isNotEmpty(row.ROL_ID) && isNotEmpty(row.PGM_ID)) {
		
		if (row.JQGRIDCRUD == "C") {
			alert("권한 메뉴를 먼저 등록해주세요.");
			$("#mnu_btn input").prop("checked", false);
			return;
		}
		var temp = row.BTN_CD;
		
		var params = {
			rol_id     : row.ROL_ID,
			rol_nm     : row.ROL_NM,
			pgm_id     : row.PGM_ID,
			mnu_seq    : row.MNU_SEQ,
			mnu_nm     : row.MNU_NM,
			sys_nm     : row.SYS_NM,
			sys_cd    : row.SYS_CD,
			pgm_btn_cd : temp
		};
		ajax({
				  url     : '/psys/savePsys1030BtnList.adm',
				  data    : params,
				  success : function(data) {
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

// 메뉴 버튼 목록 체크박스 표시 (프로그램 버튼별로 checkBox show 하고, 권한메뉴 버튼별로 check해준다.)
function fn_setCheckBox(row) {
	var btnInf = row.PGM_BTN;	// 프로그램버튼별
	var rolBtn = row.ROL_BTN;	// 권한메뉴버튼별
	
	// 버튼정보 세팅
	$("input:checkbox[name=mnu_btn]").prop("checked",false);
	
	var cnt = $("input:checkbox[name=mnu_btn]").length;
	
	for(var i =0; i < cnt; i++){
		
		var objBtnInfo  = $('#mnu_btn'+(i+1));
		var objBtnLabel = $("label[for='mnu_btn"+(i+1)+"']");
		var val         = objBtnInfo.val();
		
		
		if(btnInf.indexOf(val) > -1) {
			//버튼 show
			objBtnInfo.closest("div").show().children().show();
			
			if(isNotEmpty(rolBtn)){
				if (rolBtn.indexOf(val) > -1) {
					objBtnInfo.prop("checked", true);
				} else { 
					objBtnInfo.prop("checked", false);
				}
			} else {
				objBtnInfo.prop("checked", true);
			}
				
		} else {
			
			objBtnInfo.hide();
			objBtnLabel.hide();
			objBtnInfo.prop("checked", false);
		}
	}
	
	return false;
}


// 메뉴 조회  팝업 콜백 함수
function fn_addRoleMenuBtn(rows)
{
    var role = role_grid.getSelectRows();
    var existMnuNm = "";
    var notExistMnuCnt = 0;
    var existMnuCnt = 0;
    var exist = false;
    
    if(role.length < 1) {
        alert('권한을 선택하세요');
        return;
    } else if(role.length > 1) {
        alert('권한을 하나만 선택하세요');
        return;
    }

    var menu_list = rows || {};
    
    for(var i=0; i < menu_list.length ; i++) {
        var isExist = false;

        // 기존에 추가되어있는지 확인  
        if(menu_grid.getRowIndexByValue('MNU_SEQ', menu_list[i].MNU_SEQ).length > 0) {
            isExist = true;
            exist = true;
            existMnuNm = "[" + menu_list[i].MNU_NM + "]";
            existMnuCnt ++;
        }

        _rol_mnu_seq = "";
        
        if(!isExist) {
        	_rol_mnu_seq = menu_list[i].MNU_SEQ;
        	
			menu_grid.add({
				ROL_ID		: role[0].ROL_ID,
				ROL_NM      : role[0].ROL_NM,
				PGM_ID		: menu_list[i].PGM_ID,
				MNU_SEQ		: menu_list[i].MNU_SEQ,
				MNU_NM		: menu_list[i].MNU_NM,
				MIDD_MNU_SEQ: menu_list[i].MIDD_MNU_SEQ,
				MIDD_MNU_NM	: menu_list[i].MIDD_MNU_NM,
				SYS_CD     : menu_list[i].SYS_CD,
				SYS_NM     : menu_list[i].SYS_NM
			});
		   notExistMnuCnt ++ ;
		}
	}
    existMnuCnt = existMnuCnt > 0 ? --existMnuCnt : 0;
    if(exist) {
    	alert(existMnuNm + "외 " + existMnuCnt + "건 중복 제거 후 \n" + notExistMnuCnt + "건 추가 완료했습니다.");
    } else {
    	alert(notExistMnuCnt + "건 추가 완료했습니다.");
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

//공통코드 조회 후  checkBox 데이터 세팅
function makeData(sysCdDtlMap) {
	var index=1;
	var spnBtn = $('#mnu_btn');
	for(i=0; i<sysCdDtlMap.length; i++) {
		if("SYS001" == sysCdDtlMap[i].MST_CD) {
			/* spnBtn.append('<input type="checkbox" name="mnu_btn"  id=mnu_btn'+(index) +' value="'+ sysCdDtlMap[i].CD+'"/><label for=mnu_btn'+(index)+'>'+ sysCdDtlMap[i].CD_NM+'</label>'); */
			spnBtn.append('<div class="tableCheck"><label for="mnu_btn'+ (index) +'" class="container typeInspect">'+ sysCdDtlMap[i].CD_NM+'<input type="checkbox" name="mnu_btn"  id=mnu_btn'+(index) +' value="'+ sysCdDtlMap[i].CD+'"/><span class="checkmark"></span></label></div>');
			if(i == 10)	spnBtn.append('<br/>');
			index++;
		}
	}
}

</script>
</head>
<body id="app">
	<div class="frameWrap">
	    <div class="subCon">
	    	<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
	    	<div class="tableTopLeft gridBtn">
				<div class="selectInner" style="display: none;">
					<label for="sys_info">시스템 : </label>
					<select id="sys_info" name="sys_info" class="select" >
						<option value="">선택</option>
					</select>
				</div>
			</div>    
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
	        
	        <!-- Master Grid -->
	        <table id="role_grid"></table> 
			<div id="role_grid_pager"></div>
	        <!-- Master Grid // -->
			
			<div class="bgBorder"></div>
	        <!-- Detail Grid -->
	        <div class="gd_row">
	    		<div class="gd_inner">
					
			        <!-- 권한메뉴목록 -->
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
<!-- 								<button class="btn_common btn_default" id="btn_menu_add"> -->
<%-- 									<img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/bg_magnify.png" alt="검색버튼" /> --%>
<!-- 								</button> -->
								<button class="btn_common btn_default" id="btn_menu_add2">추가</button>
								<button class="btn_common btn_default" id="btn_menu_del">삭제</button>
								<button class="btn_common btn_default" id="btn_menu_save">저장</button>
							</div>
						</div>
						<table id="menu_grid"></table> 
			        	<div id="menu_grid_pager"></div>
		        	</div>
			        <!-- 권한메뉴목록 //-->
		        	
			        <!-- 메뉴버튼목록-->
		        	<div class="gd_col_6">
					  <div class="grid_right_btn">
						  <div id="btn_menu_grid" class="grid_right_btn_in">
							  <button class="btn_common btn_default" id="btn_mnu_btn_save">저장</button>
						  </div>
					  </div>
		        		<div id="menu_btn_list" class="tableType">
							<div class="tableBtnWrap">
			                  <p class="tableTitle">메뉴 버튼 목록</p>
			               </div>
							<table class="tblType1 w100">
								<colgroup>
									<col width="20%" />
									<col width="*%" />
								</colgroup>
								<tr>
									<th><label for="">버튼</label></th>
									<td>
										<span id="mnu_btn">
										</span>
									</td>
								</tr>
							</table>
						</div>
		        	</div>
		        	<!-- 메뉴버튼목록 // -->
	    		</div>
			</div>
	        <!-- Detail Grid // -->
	        <form name="frm_sysCdDtl" id="frm_sysCdDtl" onsubmit="return false;">
				<input type="hidden" name="mst_cd_arr" id="mst_cd_arr" />
			</form>
	    </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
