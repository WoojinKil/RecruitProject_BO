<%-- 
   1. 파일명 : psys1035
   2. 파일설명 : 사용자 메뉴 권한 신청
   3. 작성일 : 2019-10-22
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>

<script type="text/javascript">
var athr_grid;
var columsArray;
var sysCdDtlMap;

$(document).ready(function(){
	
	 getAccessSitList();
	
 	 $("#sys_cd option[value='" + parent._sys_cd + "']").prop("selected", true);
	 
	 
 	// 공통코드 복수 설정 SYS001 : 메뉴버튼코드
 	$("#mst_cd_arr").val(new Array('SYS001'))
 	ajax({
 		url: '/psys/getPsysCommon.adm',
 		data : $("form[name=frm_sysCdDtl]").serialize(),
 		success: function(data) {
 			
 			sysCdDtlMap = data.selectData;
 		},
 	});
 
	
	$("#sch_st_dt").daterangepicker({
		autoUpdateInput	: false,
		showDropdowns: true,
		linkedCalendars: false,
	    timePicker: false,
	    locale: {
	        format: 'YYYY-MM-DD'
	    }
	}, function(start, end, separator) {
		$("#sch_st_dt").val(start);
	    $("#sch_ed_dt").val(end);
	});
	
	 $("#sch_ed_dt").on('click', function () {
    	 $("#sch_st_dt").trigger('click');
    });
	
	

	$("#athr_grid").on("click","input", function () {
		
		var rowId = $(this).closest("tr").attr("id");
		
		fn_setApplNo(rowId);
		
	});
 
	
	
	
	ajax({
		url		: '/psys/getPsysCommon',
		data	: $("form[name=frm_sysCdDtl]").serialize(),
		success	: function(data) {
			for(i=0; i<data.selectData.length; i++)
				$("#usr_stat_cd").append("<option value='" + data.selectData[i].CD+ "'>" + data.selectData[i].CD_NM + "</option> ");
		}
	});
	
	var grid_config = { 
		gridid	  : 'athr_grid',
 		pagerid	  : 'athr_grid_pager',
 		gridBtnYn : 'Y',						// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
		columns	  : [
        	{name : 'PGM_ID', label : '프로그램ID', hidden : true},
        	{name : 'APPL_BTN_LIST', label : '메뉴 신청 버튼', hidden : true},
			{name : 'ROL_BTN', label : '권한 버튼', hidden : true},
			{name : 'ROL_ID', label : '권한 아이디', hidden : true},
			{name : 'USR_PGM_BTN', label : '사용자 버튼', hidden : true},
			{name : 'MIDD_MNU_SEQ', label : '상위메뉴ID', align : 'center', width : 40},
			{name : 'MIDD_MNU_NM', label : '상위메뉴명', width : 80},
			{name : 'MNU_SEQ', label : '메뉴ID', align : 'center', width : 40},
			{name : 'MNU_NM', label : '메뉴명', width : 150},
			{name : 'PGM_BTN', label : '시스템 버튼', width : 150, formatter: fn_makeCheckbox},
			{name : 'APPL_STAT_CD', label : '상태', width : 150},
		],          
// 		initval		: {US_YN : 'Y', SORT_ORD : 999, MST_CD : 'A00'}, // 컬럼 add 시 초기값
		editmode	: true, 								// 그리드 editable 여부
		gridtitle	: '사용자관리 목록', 						// 그리드명
		multiselect	: true, 								// checkbox 여부
		formid		: 'search', 							// 조회조건 form id
		height		: '300', 								// 그리드 높이
		shrinkToFit	: true, 								// true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
		selecturl	: '/psys/getPsys1035AdmMnuList', 				// 그리드 조회 URL
		saveurl		: '/psys/savePsys1035ApplMnuBtnList', 		// 그리드 입력/수정/삭제 URL
		events		: {
			onSelectRow : function(event, rowId, status){
				
				
				if(status) {
					
					// true 일때 신청 권한 번호 저장
					$("input:checkbox[id='jqg_athr_grid_"+ rowId +"']").closest("tr").find("input").not(":disabled").prop("checked", true);

				} else {
					
					$("input:checkbox[id='jqg_athr_grid_"+ rowId +"']").closest("tr").find("input").not(":disabled").prop("checked", false);
				}
				
				
				fn_setApplNo(rowId);
				// 체크 박스 클릭 시 해당 행 권한 전체 선택
			
				
			},
			onSelectAll : function(event, rowids, status){	// 해당 셀 선택시
				
				if(rowids.length > 0) {
					
					$(rowids).each(function (index) {
						
						if(status) {
							
							// true 일때 신청 권한 번호 저장
							$("input:checkbox[id='jqg_athr_grid_"+ this +"']").closest("tr").find("input").not(":disabled").prop("checked", true);

						} else {
							
							$("input:checkbox[id='jqg_athr_grid_"+ this +"']").closest("tr").find("input").not(":disabled").prop("checked", false);
						}
						
						fn_setApplNo(this);
						
					});
					
				}
				
			}
		}
	};
 
	athr_grid = new UxGrid(grid_config);
	athr_grid.init();
	athr_grid.setGridWidth($('.tblType1').width());
	
	//multiselect header checkbox 제거
	var myGrid = $("#athr_grid");
	$("#cb_"+myGrid[0].id).hide();
    
    
	// 시스템사용자정보 등록 후의 목록 조회
	if(isNotEmpty(_param) && "CHG" == _param)
		$("#btn_retreive").trigger("click");
	
	
	$("#athr_grid").on("click","input", function () {
		
		var rowId = $(this).closest("tr").attr("id");
		
		fn_setApplNo(rowId);
		
	});
	
	
});

// grid resizing
$(window).resize(function(){
	athr_grid.setGridWidth($('.tblType1').width());
});



/**************************************************
 * 공통 버튼 
 **************************************************/

// 조회 : 내부 로직 사용자 정의
function fn_Search()
{
	
	athr_grid.retreive();
}

// 추가 : 내부 로직 사용자 정의
function fn_AddRow()
{
	// default 값 세팅
	athr_grid.add();
}

// 저장 : 내부 로직 사용자 정의 
function fn_Save() {
    athr_grid.save();  
}






function fn_makeCheckbox(cellValue, option, row){
	
	
	var index=1;
	var btnInf = row.PGM_BTN;	// 프로그램버튼별
	var rolBtn = row.ROL_BTN;	// 권한메뉴버튼별
	var usrBtn = row.USR_PGM_BTN;
	var totalBtn = "";
	//문자열이기 때문에  합쳐도 이상 없음.
	totalBtn = rolBtn + usrBtn;
	
	var checkFlag = false;
	
	//버튼 정보를 항상 디비에서 조회할 수 없기 때문에 직접 엘리먼트 생성
	var spnBtn = $('<span id="mnu_btn"></span>');
	for(i=0; i<sysCdDtlMap.length; i++) {
		if("SYS001" == sysCdDtlMap[i].MST_CD) {
			spnBtn.append('<div class="tableCheck"><label for="mnu_btn'+ (option.rowId) + '' + (index) +'" class="container typeInspect">'+ sysCdDtlMap[i].CD_NM+'<input type="checkbox" name="mnu_btn_' + option.rowId +'"  id=mnu_btn'+ (option.rowId) + '' + (index) +' value="'+ sysCdDtlMap[i].CD+'"/><span class="checkmark"></span></label></div>');
			if(i == 10)	spnBtn.append('<br/>');
			index++;
		}
	}
	
	

	
	// 버튼정보 세팅
	spnBtn.find("input:checkbox[name=mnu_btn_" + option.rowId + "]").attr("checked",false);
	
	var cnt = spnBtn.find("input:checkbox[name=mnu_btn_" + option.rowId + "]").length;
	
	for (var i =0; i < cnt; i++) {
		
		var objBtnInfo  = spnBtn.find("#mnu_btn"+option.rowId+""+(i+1));
		var objBtnLabel = spnBtn.find("label[for='mnu_btn"+option.rowId+""+(i+1)+"']");
		var val         = objBtnInfo.val();
		
		
		//사용자 버튼 및 권한 버튼이 없을 경우  프로그램 전체 버튼을 이용할 수 있기 때문에 전체 체크를 위한 flag 입니다.
			
		if(btnInf.indexOf(val) > -1) {
			//버튼 show
			objBtnInfo.closest("div").css("display", "inline-block").children().css("display", "inline-block");
			
			if(isNotEmpty(totalBtn)){
				
				if (totalBtn.indexOf(val) > -1) {
					objBtnInfo.attr("checked", true);
				}
				else {
					objBtnInfo.attr("checked", false);
				}
			} 
			
							
		} else {
			objBtnInfo.hide();
			objBtnLabel.hide();
			objBtnInfo.attr("checked", false);
			objBtnInfo.addClass("btnHide");
			
		}
		
		//true 경우 전체 체크
		if(isEmpty(totalBtn)) {
			checkFlag = true;
		} 
		
	}
	
	if(checkFlag) {
		if(isEmpty(row.ROL_ID)) {
			spnBtn.find("input:checkbox[name=mnu_btn_" + option.rowId + "]").attr("checked", false);
		} else {
			spnBtn.find("input:checkbox[name=mnu_btn_" + option.rowId + "]").attr("checked", true);
		}
	}
	
	
	return spnBtn.html();
	
	
}


//권한 신청 저장 데이터 생성
function fn_setApplNo(rowId) {
	
	var temp = [];
	
	$("input:checkbox[id='jqg_athr_grid_"+ rowId +"']").closest("tr").find("input[name=mnu_btn_" + rowId + "]:checked").not(".btnHide").each(function(idx, item) {
 		if($(this).is(":checked"))
 			temp.push($(this).val());
 	});
	
	
	temp = temp.join(",");
	
	athr_grid.setRowData(rowId, {APPL_BTN_LIST : temp});
	athr_grid.setRowData(rowId, {JQGRIDCRUD : 'U'});
	athr_grid.setRowData(rowId, {APPL_STAT_CD : '메뉴 권한 신청 중..'});
	
}

//사이트 접속 리스트 취득
function getAccessSitList() {
	
	var html = "";
	
	ajax({
		url 	: "/pdsp/getAccessSitList",
		success : function (data) {
			if (data.RESULT == "S") {
				$(data.rows).each(function (index) {
					
					if(this.SYS_URL != "#") {
						html += "<option value="+ this.SYS_CD +" selected='selected' >"+ this.SYS_NM +"</option>"
					} 
					
				});
				
				$("#sys_cd").append(html);
			}
		}
	});
}



</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
			<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp"%>
			<div class="frameTopTable">
				<form name="search" id="search" onsubmit="return false">
					<table class="tblType1 typeShort typeCal">
		            	<colgroup>
							<col style="width: 70px;" />
							<col style="" />
							<col style="width: 70px;" />
							<col style="" />
							<col style="width: 70px;" />
							<col style="" />
						</colgroup>   
						<tr>
							<th>사이트</th>
			                <td>
			                	<span class="txt_pw">
			                		<select name="sys_cd" id="sys_cd" class="select">
			                			
			                   		</select>
			                 	</span>
			                </td>
							<th>메뉴이름</th>
							<td><span class="txt_pw"><input type="text" name="mnu_nm" id="mnu_nm" class="typeShort" /></span></td>
							<th>이름</th>
							<td><span class="txt_pw"><input type="text" name="usr_nm" id="usr_nm" class="typeShort" /></span></td>
						</tr>
					</table>
				</form>
			</div>
			<div class="bgBorder"></div>
			<!-- search // -->
			<!-- Grid -->
			<table id="athr_grid"></table>
			<div id="athr_grid_pager"></div>
			<br/>
			<div id="test_paginate"></div>
			<!-- Grid // -->
		</div>
		<form name="frm_sysCdDtl" id="frm_sysCdDtl" onsubmit="return false;">
			<input type="hidden" name="mst_cd_arr" id="mst_cd_arr" />
		</form>
		<form id="printForm">
			<input type="hidden" id="data" name="data" /> <input type="hidden" id="fileName" name="fileName" />
		</form>
        <form name="frm_sysCdDtl" id="frm_sysCdDtl" onsubmit="return false;">
			<input type="hidden" name="mst_cd_arr" id="mst_cd_arr" />
		</form>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>
