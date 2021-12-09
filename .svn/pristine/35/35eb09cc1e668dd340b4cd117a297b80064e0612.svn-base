<%-- 
   1. 파일명 : sample1010
   2. 파일설명 : 고객별 정보 조회
   3. 작성일 : 2019-07-15
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>
<script type="text/javascript">
var adm_grid;
var adm_mnu_grid;
var curr_row_idx = 0;
var area_width = 0.0;
var def_mpp_btn_inf_html = "";
var def_btn_inf_arr = new Array();
var curr_usr_id = "";
var curr_mnu_seq = "";
var curr_usr_stat_cd = "";
var curr_actv_yn = "";
var org_mpp_btn_inf = "";

$(document).ready(function() {
	// 공통코드 호출 : 시스템회원상태코드, 공통버튼
	var mst_cd_str_arr = "MSTS,SYS001";
	getCommonCodeNm(mst_cd_str_arr, function callBackFunc(data) {
		for(var i in data) {
			if(data[i].MST_CD == "MSTS") {
				$("#usr_stat_cd").append("<option value='" + data[i].CD + "'>" + data[i].CD_NM + "</option>");	
			}
			if(data[i].MST_CD == "SYS001") {
				def_mpp_btn_inf_html += '<span class="spBtnInf" id="spBtnInf_' + data[i].CD + '"><input type="checkbox" name="btnInf" id="btnInf_' + data[i].CD +'" value="' + data[i].CD + '" disabled="disabled" /><label for="btnInf_' + data[i].CD + '">'+ data[i].CD_NM + '</label></span>';
				def_btn_inf_arr.push("btnInf_" + data[i].CD);
			}
		}
		$("#mpp_btn_inf").html(def_mpp_btn_inf_html);
	});
	
	// 그리드 초기화 : 시스템 회원 목록
	var adm_grid_config = {
		gridid	    : 'adm_grid',
		pagerid	    : 'adm_grid_pager',
		columns	    : [{name : 'USR_ID', label :'사용자ID', hidden : true},
			           {name : 'LGN_ID', label : '아이디', align : 'left', sortable : false, editable : false},
			           {name : 'USR_NM', label : '이름', align : 'left', sortable : false, editable : false},
			           {name : 'USR_EML_ADDR', label : '이메일', align : 'left', sortable : false, editable : false},
			           {name : 'USR_STAT_CD', label : '상태', align : 'center', sortable : false, editable : false, formatter : 'select', editoptions : {value : '<%=CodeUtil.getGridComboList("MSTS")%>'}},
			           {name : 'ACTV_YN', label : '계정활성화', align : 'center', sortable : false, editable : false, edittype:'select', formatter : 'select', editoptions : {value : 'Y:활성화;N:비활성화'}}],
		editmode	: false, 								// 그리드 editable 여부
		gridtitle	: '회원 목록', 							// 그리드명
		multiselect	: false, 								// checkbox 여부
		formid		: 'search', 							// 조회조건 form id
		height		: 201,	 								// 그리드 높이
		shrinkToFit	: true, 								// true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현
		selecturl	: '/sample/getSample1010List', 			// 그리드 조회 URL
		events		: {
			onCellSelect : function(event, rowIdx) {
				if(curr_row_idx == rowIdx) return;
        		else curr_row_idx = rowIdx;
                var row = adm_grid.getRowData(rowIdx);
                if(isNotEmpty(row.USR_ID)) {
                	// 현재 사용자ID, 상태, 계정활성화 여부 셋팅
                	curr_usr_id = row.USR_ID;
                	curr_usr_stat_cd = row.USR_STAT_CD;
                	curr_actv_yn = row.ACTV_YN;
                	
                	// 프로그램 상세 입력폼 초기화
                	initPgmDtlInf();
                	$("#mpp_btn_inf").html(def_mpp_btn_inf_html);
                	
                	// 맵핑 메뉴 목록 조회
                	adm_mnu_grid.retreive({data:{usr_id:curr_usr_id}});
                	
                	getAdmInf(row);
                }
            },
			gridComplete : function() {
				if($('#adm_grid').jqGrid('getGridParam', 'records') > 0) {
					if(isEmpty(curr_mnu_seq)) {
						adm_grid.setCellFocus(1, 2);
					}else {
						var idx = adm_grid.getRowIndexByValue("USR_ID", curr_usr_id);
						if(idx.length < 1) {
							adm_grid.setCellFocus(1, 2);
						}else {
							adm_grid.setCellFocus(idx[0], 2);
						}
					}
				}
			}
		}
	};
	adm_grid = new UxGrid(adm_grid_config);
	adm_grid.init();
	
	// 그리드 초기화 : 맵핑 메뉴 목록
	var adm_mnu_grid_config = { 
		gridid	    : 'adm_mnu_grid',
		pagerid	    : 'adm_mnu_grid_pager',
		columns	    : [
			           {name : 'UP_MNU_SEQ', label : '항목', align : 'left', sortable : false, editable : false},
			           {name : 'UP_MNU_NM', label : '매출정보', align : 'left', sortable : false, editable : false},
			           {name : 'MNU_SEQ', label : '매출가격', align : 'left', sortable : false, editable : false},
			           ],
		editmode	: true, 								// 그리드 editable 여부
		gridtitle	: '매출 목록', 							// 그리드명
		multiselect	: true, 								// checkbox 여부
		height		: 201,	 								// 그리드 높이
		shrinkToFit	: true, 								// true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현
		selecturl	: '/psys/getPsys1029AdmMnuList',	// 그리드 조회 URL
		saveurl		: '/psys/deletePsys1029AdmMnuList',	// 그리드 입력/수정/삭제 URL
		events		: {
			onCellSelect : function(event, rowIdx, icol) {
				var row = adm_mnu_grid.getRowData(rowIdx);
                if(isNotEmpty(row.USR_ID) && isNotEmpty(row.MNU_SEQ) && isNotEmpty(row.PGM_ID) && adm_mnu_grid.getColName(icol) != "cb") {
                	// 현재 메뉴ID 셋팅
                	curr_mnu_seq = row.MNU_SEQ;
                	
                	// 프로그램 상세 조회
                	getPgmDtlInf(row);
                }
            },
			gridComplete : function() {
				if($('#adm_mnu_grid').jqGrid('getGridParam', 'records') > 0) {
					if(isEmpty(curr_mnu_seq)) {
						adm_mnu_grid.setCellFocus(1, 2);
					}else {
						var idx = adm_mnu_grid.getRowIndexByValue("MNU_SEQ", curr_mnu_seq);
						if(idx.length < 1) {
							adm_mnu_grid.setCellFocus(1, 2);
						}else {
							adm_mnu_grid.setCellFocus(idx[0], 2);
						}
					}
				}else {
					// 프로그램 상세 입력폼 초기화
                	initPgmDtlInf();
                	$("#mpp_btn_inf").html(def_mpp_btn_inf_html);
				}
			}
		}
	};
	adm_mnu_grid = new UxGrid(adm_mnu_grid_config);
	adm_mnu_grid.init();
	
	// 맵핑 메뉴 목록 : 행추가버튼 클릭 시
    $("#btn_menu_add").click(function() {
    	var selRow = adm_grid.getSelectRowIDs();
        var selRowLen = selRow.length;
        var sys_cd = $("#sys_info").val();
        
        
    	if(!(curr_usr_stat_cd == "1" && _boolean_true == curr_actv_yn)) {
        	alert("시스템 회원 상태 또는 계정활성화 정보를 확인하세요.\n(※ 해당 기능 조건 : 회원상태 → 가입, 계정활성화)");
    		return;
        }
        if(selRowLen == 0) {
            alert('시스템 회원을 선택하세요.');
            return;
        }
        
        if(isEmpty(sys_cd)){
        	alert("시스템을 선택해 주세요.");
        	return;
        }
        
        
       	// 메뉴 조회 팝업 호출
   		popup({
   			  url        : "/psys/forward.psys1030p001.adm"
   			, params	 : {callback:"fn_addAdmMnu", sys_cd:sys_cd}
   			, winname	 : "_menu_pop"
   			, title		 : "메뉴 조회"                          
   			, type		 : "m"
   			, width      : 600
   			, height     : 580
   			, scrollbars : false
   			, autoresize : false
   		});
	});
	
	// 맵핑 메뉴 목록 : 행삭제버튼 클릭 시
    $("#btn_menu_del").click(function() {
    	if(!(curr_usr_stat_cd == "1" && _boolean_true == curr_actv_yn)) {
    		alert("시스템 회원 상태 또는 계정활성화 정보를 확인하세요.\n(※ 해당 기능 조건 : 회원상태 → 가입, 계정활성화)");
    		return;
        }
    	var rowIds = adm_mnu_grid.getSelectRowIDs();
    	var chkCnt1 = 0;
    	var chkCnt2 = 0;
    	for(var i = 0; i < rowIds.length; i++) {
			var row = $("#adm_mnu_grid").jqGrid('getRowData', rowIds[i]);
			if(row.JQGRIDCRUD != 'C') chkCnt1++;
    	}
    	var rows = adm_mnu_grid.getRowData();
    	for(var i = 0; i < rows.length; i++) {
			if(rows[i].JQGRIDCRUD == 'C') chkCnt2++; 
		}
    	
    	if(chkCnt1 > 0) {
    		if(chkCnt2 > 0) {
    			if(confirm("저장하지 않은 데이터가 존재합니다.\n행삭제 시 저장되지 않은 데이터들은 함께 삭제됩니다.\n그래도 삭제하시겠습니까?")) adm_mnu_grid.remove();
    		}else {
    			adm_mnu_grid.remove();
    		}
    	}else {
    		adm_mnu_grid.remove();
    	}
    });
	
	// 맵핑 메뉴 목록 : 저장버튼 클릭 시
    $("#btn_menu_save1").click(function(e) {
    	if(!(curr_usr_stat_cd == "1" && _boolean_true == curr_actv_yn)) {
        	alert("시스템 회원 상태 또는 계정활성화 정보를 확인하세요.\n(※ 해당 기능 조건 : 회원상태 → 가입, 계정활성화)");
    		return;
        }
    	// 강제 포커스 OUT
		var rows = adm_mnu_grid.getRowData();
		for(var i = 0; i < rows.length; i++) {
			$("#adm_mnu_grid").editCell(i, 0, false);
		}
		
		// 저장 데이터 추가
		var rowIds = adm_mnu_grid.getDataIDs();
		var saveList = [];
		for(var i = 0; i < rowIds.length; i++) {
			var row = $("#adm_mnu_grid").getRowData(rowIds[i]);
			if(row.JQGRIDCRUD == 'C') {
				saveList.push(row);
			}
		}
		
		// 저장할 데이터이 없는 경우
		var saveListLen = saveList.length;
		if(saveListLen == 0) {
			alert('저장할 데이터가 없습니다. 확인해주세요.');
			return;
		}
		
		// 저장
		var savConf = confirm("저장하시겠습니까?");
		if(savConf) {
			setTimeout(function() {
				ajax({
					url : '/psys/insertPsys1029AdmMnuList.adm',
					method : 'POST',
					data : {JQGRIDSIZE:saveListLen, JQGRIDDATA:JSON.stringify(saveList)},
					success : function(data) {
						if(_boolean_success == data.RESULT) {
							alert("정상적으로 저장 되었습니다.");
							
							// 맵핑 메뉴 목록 조회
		                	adm_mnu_grid.retreive({data:{usr_id:curr_usr_id}});
						}else {
							alert("정상적으로 실행되지 않았습니다. 잠시후 다시 시도하세요.");
							e.preventDefault();
							return;
						}
					}
				});	
			});
			e.preventDefault();
		}else {
			e.preventDefault();
			return;
		}
    });
	
	// 프로그램 상세 : 저장버튼 클릭 시
    $("#btn_menu_save2").click(function(e) {
    	if(!(curr_usr_stat_cd == "1" && _boolean_true == curr_actv_yn)) {
        	alert("시스템 회원 상태 또는 계정활성화 정보를 확인하세요.\n(※ 해당 기능 조건 : 회원상태 → 가입, 계정활성화)");
    		return;
        }
    	var btn_inf = "";
    	$("input[name=btnInf]:checked").each(function () {
    		if(btn_inf != "") btn_inf += ","; 
    		btn_inf += $(this).val();
    	});
    	
    	var sp_org_mpp_btn_inf = isEmpty(org_mpp_btn_inf) ? [] : org_mpp_btn_inf.split(",");
    	var sp_org_mpp_btn_inf_len = sp_org_mpp_btn_inf.length;
		var sp_btn_inf = isEmpty(btn_inf) ? [] : btn_inf.split(",");
		var sp_btn_inf_len = sp_btn_inf.length;
		var chk_cnt = 0;
		var chg_flag = false;
		if(sp_org_mpp_btn_inf_len > 0) {
			for(var i in sp_org_mpp_btn_inf) {
				for(var j in sp_btn_inf) {
					if(sp_org_mpp_btn_inf[i] == sp_btn_inf[j]) chk_cnt++;
				}
			}
			if(sp_org_mpp_btn_inf_len != chk_cnt || sp_org_mpp_btn_inf_len != sp_btn_inf_len) chg_flag = true;
		}else if(sp_btn_inf_len > 0) chg_flag = true;
		
		if(!chg_flag) {
			alert("변경된 데이터가 없습니다. 확인해주세요.");
			e.preventDefault();
			return;
		}else {
			var formData = new FormData();
			formData.append("usr_id", curr_usr_id);
			formData.append("mnu_seq", curr_mnu_seq);
			formData.append("pgm_id", $("#h_pgm_id").val());
			formData.append("mpp_btn_inf", btn_inf);
		    $.ajax({
				url:_context+'/psys/savePsys1029AdmMnuBtnList',
				type:'POST',
				data:formData,
				mimeType:"multipart/form-data",
				contentType:false,
				cache:false,
				processData:false,
				async: false,
				success:function(data) {
					var json = eval("(" + data + ")");
					if(_boolean_success == json.RESULT) {
						alert("정상적으로 저장 되었습니다.");
						
						// 재조회
						var idx = adm_mnu_grid.getRowIndexByValue("MNU_SEQ", curr_mnu_seq);
						if(idx.length < 1) {
							adm_mnu_grid.setCellFocus(1, 2);
						}else {
							adm_mnu_grid.setCellFocus(idx[0], 2);
						}
					}else {
						alert("정상적으로 실행되지 않았습니다. 잠시후 다시 시도하세요.");
						e.preventDefault();
						return;
					}
				}
		    });
		    e.preventDefault();
		}
    });
	
  	//사이트 리스트 취득
    getSystemList();
    
  	//시스템 변경 시 재 검색
	$("#sys_info").on("change", function () {
		fn_Search();
	});  
  	
  	
  	
	
	/* 테스트  */
	
	$(".tab-wrap li a").on('click', function () {
		
		$(".tab-wrap > div").hide();
		$(this).closest('ul').find('li').removeClass("active");
		$(this).closest('li').addClass("active");
		
		var hash = $(this)[0].hash;
		$(hash).show();
		
	});
	
	/* 테스트  끝 */
	
});

// Window Onload
window.onload = function() {
	adm_grid.setGridWidth($('.tblType1').width());
	adm_mnu_grid.setGridWidth($("#table1").width());
}

// 그리드 리사이징
$(window).resize(function() {
	adm_grid.setGridWidth($('.tblType1').width());
	adm_mnu_grid.setGridWidth($("#table1").width());
});

// 조회 : 내부 로직 사용자 정의
function fn_Search() {
	
	var sys_cd = $("#sys_info").val();
	$("#sys_cd").val(sys_cd);
	
	curr_row_idx = 0;
	curr_mnu_seq = 0;
	
	//시스템(사이트) 구분 필수
	if(isEmpty(sys_cd)){
    	alert("시스템을 선택해 주세요.");
    	adm_grid.clearGridData();
    	adm_mnu_grid.clearGridData();
    	initPgmDtlInf();
    	return false;
	}
	adm_grid.retreive();
}

// 메뉴 조회 팝업 콜백 함수
function fn_addAdmMnu(rows) {
	var list = rows || {};
	var errMsg = "";
	var lstMnuSeq = "";
	for(var i = 0; i < list.length; i++) {
		var rtnnYn = getTsysAdmMnuRtnnYn(curr_usr_id, list[i].MNU_SEQ);
		var isExist = false;
		if(adm_mnu_grid.getRowIndexByValue('MNU_SEQ', list[i].MNU_SEQ).length > 0) isExist = true; 
		if(_boolean_true == rtnnYn || isExist) {
			if(errMsg != "") errMsg += ", "; 
			errMsg += list[i].MNU_NM;
		}else {
			adm_mnu_grid.add({
				USR_ID	   : curr_usr_id,
				PGM_ID	   : list[i].PGM_ID,
				UP_MNU_SEQ : list[i].MIDD_MNU_SEQ,
				UP_MNU_NM  : list[i].MIDD_MNU_NM,
				MNU_SEQ    : list[i].MNU_SEQ,
				MNU_NM	   : list[i].MNU_NM
			});
			lstMnuSeq = list[i].MNU_SEQ;
		}
	}
	if(errMsg != "") alert("선택하신 메뉴 중에 " + errMsg + " 메뉴는\n이미 맵핑되어 있어 추가에서 제외하였습니다.");
	if(!isEmpty(lstMnuSeq)) {
		setTimeout(function() {
			var idx = adm_mnu_grid.getRowIndexByValue("MNU_SEQ", lstMnuSeq);
			adm_mnu_grid.setCellFocus(idx[0], 2);
		}, 500);
	}
}

// 관리자메뉴할당 여부 조회
function getTsysAdmMnuRtnnYn(usr_id, mnu_seq) {
	var isExist = _boolean_false;
	var formData = new FormData();
	formData.append("usr_id", usr_id);
	formData.append("mnu_seq", mnu_seq);
    $.ajax({
		url:_context+'/psys/getTsysAdmMnuRtnnYn',
		type:'POST',
		data:formData,
		mimeType:"multipart/form-data",
		contentType:false,
		cache:false,
		processData:false,
		async: false,
		success:function(data) {
			var json = eval("(" + data + ")");
			if(_boolean_success == json.RESULT) {
				isExist = json.rtnnYn;
			}else {
				alert("정상적으로 실행되지 않았습니다. 잠시후 다시 시도하세요.");
				return;
			}
		}
    });
    return isExist;
} 

// 프로그램 상세 조회
function getPgmDtlInf(row) {
	// 프로그램 상세 입력폼 초기화
	initPgmDtlInf();
	
	// 프로그램 상세 조회
	var formData = new FormData();
	formData.append("usr_id", row.USR_ID);
	formData.append("mnu_seq", row.MNU_SEQ);
	formData.append("pgm_id", row.PGM_ID);
	
	// 프로그램 상세 조회
	$.ajax({
		url:_context+'/psys/getPsys1029AdmMnuBtnInf',
		type:'POST',
		data:formData,
		mimeType:"multipart/form-data",
		contentType:false,
		cache:false,
		processData:false,
		success:function(data) {
			var json = eval("(" + data + ")");
			if(_boolean_success == json.RESULT) {
				var pgmDtlInf = json.TsysAdmMnuBtnRtnnInf;
				if(isNotEmpty(pgmDtlInf)) {
					// 저장 버튼 활성화
					if(row.JQGRIDCRUD == "C") {
						$("#btn_menu_save2").hide();
						$(".tableTitle").html("프로그램 상세 (※ 맵핑 메뉴 저장 후 저장 버튼이 활성화됩니다.)");
					}else {
						$("#btn_menu_save2").show();
						$(".tableTitle").html("프로그램 상세");
					}
					
					// 입력폼 데이터 로드
					$("#sys_nm").html(pgmDtlInf.SYS_NM);
					$("#pgm_id").html(pgmDtlInf.PGM_ID);
					$("#h_pgm_id").val(pgmDtlInf.PGM_ID);
					$("#pgm_nm").html(pgmDtlInf.PGM_NM);
					$("#pgm_desc").html(pgmDtlInf.PGM_DESC);
					$("#us_yn").html(pgmDtlInf.US_YN);
					
					// 버튼 정보 초기화
					$(".spBtnInf").hide();
					for(var i in def_btn_inf_arr) {
						$("#" + def_btn_inf_arr[i]).attr("disabled", true);
						if($("input:checkbox[id='" + def_btn_inf_arr[i] + "']").is(":checked")) {
							$("input:checkbox[id='" + def_btn_inf_arr[i] + "']").prop("checked", false);
						}
					}
					// 버튼 정보 셋팅
					var btn_inf = pgmDtlInf.BTN_INF;
					var mpp_btn_inf = pgmDtlInf.MPP_BTN_INF;
					org_mpp_btn_inf = mpp_btn_inf;
					var sp_btn_inf = isEmpty(btn_inf) ? [] : btn_inf.split(",");
					var sp_mpp_btn_inf = isEmpty(mpp_btn_inf) ? [] : mpp_btn_inf.split(",");
					for(var i in sp_btn_inf) {
						$("#spBtnInf_" + sp_btn_inf[i]).show();
						$("#btnInf_" + sp_btn_inf[i]).attr("disabled", false);
						for(var j in sp_mpp_btn_inf) {
							if(sp_btn_inf[i] == sp_mpp_btn_inf[j]) {
								$("#btnInf_" + sp_mpp_btn_inf[j]).prop("checked", true);
							}
						}
					}
				}else {
					// 프로그램 상세 입력폼 초기화
					initPgmDtlInf();
					$(".tableTitle").html("프로그램 상세 (※ 프로그램 데이터가 존재하지 않습니다.)");
					$("#sys_nm").html("-");
					$("#pgm_id").html("-");
					$("#pgm_nm").html("-");
					$("#pgm_desc").html("-");
					$("#us_yn").html("-");
					$("#btn_menu_save2").hide();
					$("#mpp_btn_inf").html(def_mpp_btn_inf_html);
				}
			}else {
				alert("정상적으로 실행되지 않았습니다. 잠시후 다시 시도하세요.");
				return;
			}
   		}
   	});
}

// 프로그램 상세 입력폼 초기화
function initPgmDtlInf() {
	$("#sys_nm").html("");
	$("#pgm_id").html("");
	$("#pgm_nm").html("");
	$("#pgm_desc").html("");
	$("#us_yn").html("");
	$("#btn_menu_save2").hide();
	$(".tableTitle").html("프로그램 상세");
	
	
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
					// 조회 건수가 하나일 경우 단일 시스템
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


//사용자 정보
function getAdmInf(row) {
	//input 초기화
	
	$("#sampleName").val(row.USR_NM);
	$("#sampleId").val(row.LGN_ID);
	$("#sampleUseYn").val(row.ACTV_YN);
	$("#sampleEmail").val(row.USR_EML_ADDR);
	
}



</script>

<style>
	/* .tab-wrap {
		width: 98%;
		border-top: 2px solid #666;
		-webkit-box-sizing:border-box;
		box-sizing:border-box;
	}

	.tab-wrap ul{
		font-size:0;
		line-height:0;
		border-left: 1px solid #bbb;
		margin: 2px 0 -1px;
	}
	.tab-wrap ul li {
		display: inline-block;
		vertical-align:top;
		font-weight: 600;
		text-align: center;
		color: #bbb;
	}
	.tab-wrap ul li.active {
		height:32px;
    	background-color: #fbfbfb;
    	margin-bottom: -1px;
	}
	.tab-wrap ul li.active{
		border-right: 1px solid #bbb;
	}
	.tab-wrap > div {
		display: none;
		height: 300px;
		padding: 15px;
		border: 1px solid #bbb;
		overflow:auto;   
	}
	.tab-wrap > div:first-of-type {
		display: block;
	}
	.tab-wrap .tab-list-wrap{padding: 15px;}
    
 	.tab-wrap ul li .tab-link{
 		display:block; font-size: 12px; padding: 15px 25px;outline: none;border: 1px #efefef outset; border-top: 1px solid #bbb; background-color: #efefef; color: black; cursor: pointer;
 		 background: linear-gradient(to bottom, #fbfbfb, #d8dcdf 80%);

 	}
 	.tab-wrap ul li.active .tab-link{border: 0 none; border-top: 1px solid #bbb; background-color: #fbfbfb; background:none;}
 	 */
</style>

</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
			<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp"%>
			<div class="tableTopLeft gridBtn" style="display:none;">
				<div class="selectInner">
					<label for="sys_info">시스템 : </label>
					<select id="sys_info" name="sys_info" class="select" >
						<option value="">전체</option>
					</select>
				</div>
			</div>
			<!-- search -->
			
			<div class="frameTopTable">   
				<form name="search" id="search" onsubmit="return false">
					<input type="hidden" name="sys_cd" id="sys_cd" value="" />
					<table class="tblType1" id="tblType1"> 
		            	<colgroup>
							<col style="width: 117px;" />
							<col style="" />
							<col style="width: 117px;" />
							<col style="" />
							<col style="width: 117px;" />
							<col style="" />
						</colgroup>
						<tr>
							<th>아이디</th>
							<td><span class="txt_pw"><input type="text" name="lgn_id" id="lgn_id" class="w100" /></span></td>
							<th>이름</th>
							<td><span class="txt_pw"><input type="text" name="usr_nm" id="usr_nm" class="w100" /></span></td>
							<th>이메일</th>
							<td><span class="txt_pw"><input type="text" name="usr_eml_addr" id="usr_eml_addr" class="w100" /></span></td>
						</tr>
						<tr>	
							<th>상태</th>
							<td>
								<select class="select" name="usr_stat_cd" id="usr_stat_cd">
									<option value="">전체</option>
								</select>
							</td>
							<th>계정활성화</th>
							<td>
								<span class="txt_pw">
									<select class="select" name="actv_yn" id="actv_yn">
										<option value="">전체</option>
										<option value="Y">활성화</option>
										<option value="N">비활성화</option>
									</select>
								</span>
							</td>
							<th></th>
			                <td></td>
						</tr>
					</table>
				</form>
			</div>
			<!-- search // -->
			<div class="bgBorder"></div>
			<!-- Grid -->
			<table id="adm_grid"></table>
			<div id="adm_grid_pager"></div>		
			<!-- Grid // -->
			<div class="bgBorder"></div>
			
			<div class="mB60"></div>
			
			<div class="tab-wrap">
				<ul class="tab-list">
					<li class="active"><a href="#tab1" class="tab-link" onclick="return false;" >기본정보</a></li>
					<li><a href="#tab2" class="tab-link" onclick="return false;" >매출정보</a></li>
					<li><a href="#tab3" class="tab-link" onclick="return false;" >선정이력</a></li>
					<li><a href="#tab4" class="tab-link" onclick="return false;" >캠페인대상</a></li>
				</ul>
		       	<div id="tab1" class="tabMore active">
		       		<div class="tableType">
			       		<table border="1" class="tblType1" style="border: 1px solid #bbb" id="table1">
			       			<tr>
			       				<th>이름</th>
			       				<td>
			       					<input type="text" name="sampleName" id="sampleName" readonly="readonly"/>
			       				</td>
			       			</tr>
			       			<tr>
			       				<th>아이디</th>
			       				<td>
			       					<input type="text" name="sampleId"  id="sampleId" readonly="readonly"/>
			       				</td>
			       			</tr>
			       			<tr>
			       				<th>사용여부</th>
			       				<td>
			       					<input type="text" name="sampleUseYn" id="sampleUseYn" readonly="readonly" />
			       				</td>
			       			</tr>
			       			<tr>
			       				<th>이메일</th>
			       				<td>
			       					<input type="text" name="sampleEmail" id="sampleEmail"  readonly="readonly"/>
			       				</td>
			       			</tr>
			       		</table>
		       		</div>
		       	</div>
		       	<div id="tab2" class="tabMore">
		       	
		       		<div class="tableBtnWrap gridBtn" >
					</div>
					<!-- Grid Button // -->
					<!-- Grid -->
					<table id="adm_mnu_grid"></table>
					<div id="adm_mnu_grid_pager"></div>
		       		
				   
		       	</div>
		       	<div id="tab3" class="tabMore">
		       		선정이력 화면입니다.
		       	</div>
		       	<div id="tab4" class="tabMore">
		       		캠페인대상 화면입니다.
		       	</div>
				
			</div>
		</div>
	</div>
	<input type="hidden" name="mst_cd_arr" id="mst_cd_arr" />
	<input type="hidden" name="h_pgm_id" id="h_pgm_id" />
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>