<%-- 
   1. 파일명 : pdsp1004
   2. 파일설명: 메뉴전시관리
   3. 작성일 : 2018-03-29
   4. 작성자 : TANINE
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var disp_menu_grid;
// zTree Setting
var setting = {
	view: {
		selectedMulti: false
	},
	edit: {
		enable: true,
		showRemoveBtn: true,
		showRenameBtn: true
	},
	data: {
		keep: {
			parent:true,
			leaf:true
		},
		simpleData: {
			enable: true
		}
	},
	callback: {
		beforeDrag: beforeDrag,
		beforeRemove: beforeRemove,
		beforeRename: beforeRename,
		beforeClick:beforeClick,
		onRemove: onRemove,
		onRename: onRename,
		onClick: onClick
	}
};
// 전역변수
var zNodes;					// 트리노드
var newCount = 1;			// 임시Id SEQ
var editMenuFlag = false;	// 메뉴편집 진행 플래그
var cutMenuFlag = false;	// 메뉴 자르기 진행 플래그
var copyMenuFlag = false;	// 메뉴 복사 진행 플래그
var editMenuInfo;			// 편집 진행중인 메뉴 정보
var tmpMappingInfoList;		// 템플릿 매핑 정보 목록
var isSavedMenu = false;	// 저장된 메뉴 여부
var selected_level;			// 클릭된 계층
var selected_tmp_type;		// 클릭된 템플릿 타입
var curSrcNode; 
var curType;
var copyNodesObj;

// 드래그 방지
function beforeDrag(treeId, treeNodes) {
	return false;
}

// 메뉴 클릭 이벤트 발화 전 이벤트
function beforeClick(treeId, treeNode) {
	// 편집 플래그가 true 인 경우 | 자르기 | 복사 플래그가 true 인 경우
	if(editMenuFlag || cutMenuFlag || copyMenuFlag) {
		// 현재 선택 중인 메뉴 확인
		var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getSelectedNodes();
		
		// 현재 선택 중인 메뉴와 새로 선택하려는 메뉴가 다르면
		
		var action;
		if(editMenuFlag) action = "편집";
		else if(cutMenuFlag) action = "이동";
		else if(copyMenuFlag) action = "복사";
		
		if(nodes[0] != treeNode) alert("현재 " +action+ "중인 메뉴가 있습니다.\n내용을 저장 하신 후 다시 진행해주세요.");
		return false;
	}	
}

//click zTree Node Event
function onClick(event, treeId) {
	// form 활성화
	formControl(false);
	
	// 현재 선택 메뉴 확인
	var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
		nodes = zTree.getSelectedNodes(),
		treeNode = nodes[0];
	//console.log(treeNode);
	// 선택 전시메뉴 데이터를 상세정보 Form에 설정
	
	$("#tmp_type").val(treeNode.tmpl_tp_cd).prop("selected", true).trigger('change');;
	$("#mnu_seq").val(treeNode.mnu_seq);
	$("#mnu_nm").val(treeNode.name);
	$("#dsply_no").val(treeNode.dsply_no);
	$("#url").val(treeNode.url);
	$("#up_tmpl_seq").val(treeNode.pId);
	$("input[name='dsply_yn']:radio[value='"+treeNode.dsply_yn+"']").prop('checked',true);
	$("input[name='mnu_yn']:radio[value='"+treeNode.mnu_yn+"']").prop('checked',true);
	$("input[name='us_yn']:radio[value='"+treeNode.us_yn+"']").prop('checked',true);
	// 선택 전시메뉴 데이터 조회용 키값 설정
	disp_menu_grid.retreive({data:{up_tmpl_seq:treeNode.id}});
	
	// 선택 전시메뉴의 설정정보(DB저장여부)를 전역변수에 저장(복사의 경우 예외)
	if("Y" == treeNode.isSaved && "copy" != curType) {
		isSavedMenu = true;
		selected_level = treeNode.level;
	} else {
		isSavedMenu = false;
	}
	zTree.selectNode(treeNode);
}

// 템플릿 리스트(메뉴 매핑여부 포함) 취득
function getTmpMappingInfoList() {
	$.ajax({
		url: _context + '/pdsp/getPdsp1004List2',
		type: 'POST',
		contentType: false,
		cache: false,
		processData:false,
		success: function(data) {
			tmpMappingInfoList = JSON.parse(data).mapList;
		}
	});
}

//시스템 리스트 취득
function getSystemList() {
    var html = "";
    ajax({
        url     : "/pdsp/getPdsp1011ListSit",
        data    : {sys_cd : _sys_cd}, 
        success : function (data) {
            if (data.RESULT == "S") {
                var sitListCnt = data.rows.length;
                $(data.rows).each(function (index) {
                    // 조회 건수가 하나일 경우 사이트 하나
                    if(sitListCnt == 1) {
                        html += "<option  class='passOption' value="+ this.SYS_CD +" selected='selected' >"+ this.SYS_NM +"</option>"
                        return false;
                    } else {
                        html += "<option class='passOption' value="+ this.SYS_CD +">"+ this.SYS_NM +"</option>"
                        $("#sys_info").closest('div').show();
                    }
                });
                $("#sys_info").append(html);
            }
        }
    });
}

// input,select form control
function formControl(flag) {
	$('input').attr("disabled", flag);
	$('.select').attr("disabled", flag);
}

// input,select form clear
function formClear() {
	$('input[type=text],input[type=hidden]').val('');
	$('option').not('.passOption').attr('selected', false);
}
// 전시 메뉴 리스트 취득
function getTemplateDispTree(initFlag, tmpl_seq) {
	if(!initFlag) return false;
	
	$.ajax({
		url: _context + '/pdsp/getPdsp1004List1',
		type: 'POST',
		data: {sys_cd : $('#sys_info').val()},
		success: function(data) {
			data = JSON.parse(data);
			zNodes = data.mapList;
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			if(isNotEmpty(tmpl_seq)) {
				var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
				var nodes = treeObj.getNodesByParam("id", parseInt(tmpl_seq, 10), null)
				if(nodes.length > 0) $("#" + nodes[0].tId + "_a").trigger('click');
			}
		}
	});
}

$(document).ready(function(){
	
	// 적용 템플릿 영역 초기화
	selectBoxReset("#tmpl_seq");
	
	// 폼 입력 제한(전시순위 : 숫자만 입력되도록)
	$('#dsply_no').keydown(function(e){
		var flag = onlyNumber(e);
		return flag;
	}).keyup(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	});
	
	// 전시 메뉴 리스트 취득
	getTemplateDispTree(true);
	
	// 템플릿 리스트(메뉴 매핑여부 포함) 취득
	getTmpMappingInfoList();
	
	// 사이트 리스트 취득
	getSystemList();
	
	// 템플릿 URL 취득
	$("#btn_get_tmp_url").click(function() {
		var tmpl_url = $("#tmpl_seq option:selected").attr("tmpl_url");;
		$("#url").val(tmpl_url);	
	});
	
	// 좌측 네비게이션 버튼 이벤트 설정
	$("#addMenu").bind("click", add);
	$("#copy").bind("click", copy);
	$("#cut").bind("click", cut);
	$("#paste").bind("click", paste);
	$("#removeMenu").bind("click", remove);
	$("#resetEdit").bind("click", resetEdit);

	formControl(true);
	
	/* $("#btn_menuInfo_save").click(function() {
		// 편집창 비활성화시
		if($("input[name='mnu_nm']:disabled").length > 0) {
			alert("편집하실 메뉴를 선택해주세요.")
			return false;
		}
		
		$("#dispMenuTit").removeClass("dispMenuAddTit");
		$("#dispMenuTit").text($("#dispMenuTit").text().replace("추가","상세"));
		if(submitFormCheck()) {
			$("#menuInfoForm").submit();
		}
	}); */
	                                                                  
	// form submit process                                            
	$("#menuInfoForm").submit(function(e) {                           
		var formData = new FormData($(this)[0]);
		formData.append("frnt_yn", "Y");  
		formData.append("sys_cd", $('#sys_info').val());
		formData.append("stf_only_yn", $("input[name='mnu_yn']").val());
		formData.append("lst_mnu_yn", 'N');
		formData.append("mnu_tp_cd" , 10);
		
		// 복사 -> 붙여넣기                                                 
		if(copyMenuFlag) {                                            
			//복사할 데이터를 Json 형식으로                                      
			var jsonTop = JSON.stringify(copyNodesObj.topDataInfo);   
			var jsonMid = JSON.stringify(copyNodesObj.midDataInfo);   
			var jsonBtm = JSON.stringify(copyNodesObj.btmDataInfo);
			formData.append("jsonTop",jsonTop);
			if(isNotEmpty(jsonMid)) formData.append("jsonMid",jsonMid);
			if(isNotEmpty(jsonBtm)) formData.append("jsonBtm",jsonBtm);
			formData.append("copyFlag", "COPY");
		}
		
		$.ajax({
			url: _context + '/pdsp/savePdsp100401',
			type: 'POST',
			data: formData,
			mimeType:"multipart/form-data",
			contentType: false,
			cache: false,
			processData:false,
			success: function(data) {
				data = JSON.parse(data);
				if(data.RESULT == "S") {
					$("#mnu_seq").val(data.mnu_seq);
					alert('저장되었습니다');
					editMenuFlag = false;
					cutMenuFlag = false;
					copyMenuFlag = false;
					editMenuInfo = null;
					disp_menu_grid.retreive({data:{up_tmpl_seq:data.tmpl_seq}});
					getTmpMappingInfoList();
					getTemplateDispTree(true, data.tmpl_seq);
				} else {
					alert("일시적 오류입니다\n잠시후 다시 시도하세요.")
				}
			},
		});
		e.preventDefault(); //Prevent Default action. 
	});
	
	// Grid 영역 설정(하위메뉴)
	var disp_menu_config = { 
		// grid id
		gridid: 'disp_menu_grid',
		pagerid: 'disp_menu_grid_pager',
		// column info
		columns:[{name:'TMPL_SEQ'		, width:100, label:'템플릿ID', hidden:true},
				 {name:'UP_TMPL_SEQ'	, width:100, label:'상위템플릿ID', hidden:true},
				 {name:'TMPL_TP_CD', width:100, label:'템플릿유형',align:'center', hidden:true},
				 {name:'MNU_SEQ', 	width:100, label:'메뉴번호',align:'center', hidden:true},
				 {name:'URL', 		width:100, label:'URL',align:'center', hidden:true},
				 {name:'MNU_NM'	, width:100, label:'메뉴명', sortable:false,
					cellattr: function(rowId, tv, rowObject, cm, rdata) {
						if(isNotEmpty(rowObject.MNU_NM)){
							return 'style="cursor: pointer; text-decoration: underline;"'
						}
					}
			 	 },
				 {name:'TMPL_TP_CD_NM', width:100, label:'템플릿유형명',align:'center', sortable:false},
				 {name:'DSPLY_NO'	, width:50, label:'전시순위',align:'center', sortable:false},
				 {name:'DSPLY_YN'	, width:50, label:'전시여부', align:'center', sortable:false, formatter:'select', editoptions:{value:'Y:전시;N:비전시'}},
				 {name:'MNU_YN'	, width:50, label:'직원전용', align:'center', sortable:false, formatter:'select', editoptions:{value:'Y:공용;N:직원전용'}}
		],
		editmode: true,					// 그리드 editable 여부
		gridtitle: '하위메뉴 목록',			// 그리드명
		multiselect: true,				// checkbox 여부
		shrinkToFit: true,				// 컬럼 width 자동조정
		autowidth: true,
		height: 280,
		cellEdit:false,
		selecturl: '/pdsp/getPdsp1004List3.adm',   // 그리드 조회 URL
		saveurl: '/pdsp/savePdsp100403.adm',     // 그리드 입력/수정/삭제 URL
		events: {
				onCellSelect: function(event, rowid, icol, conts) {
					var row = disp_menu_grid.getRowData(rowid);
					if (disp_menu_grid.getColName(icol) == 'MNU_NM') {
						debugger;
						popup({url:"/pdsp/forward.pdsp1004p01.adm"
								, params: {callback:"getDownMenuInfo" 
										  ,tmpl_seq:row.TMPL_SEQ
										  ,tmp_type:row.TMPL_TP_CD
										  ,up_tmpl_seq:$("#tmpl_seq option:selected").val()
										  ,up_tmp_type:$("#tmp_type option:selected").val()
										  ,mnu_nm:row.MNU_NM
										  ,dsply_no:row.DSPLY_NO
										  ,mnu_yn:row.MNU_YN
										  ,mnu_seq:row.MNU_SEQ
										  ,url:row.URL
										  ,dsply_yn:row.DSPLY_YN}
								, winname:"_down_menu"
								, title:"하위메뉴 상세정보"
								, type: "l"
								, height:"330"
								, scrollbars:false
								, autoresize:false
						}); 
					}
				}
		}
	};
		
	disp_menu_grid = new UxGrid(disp_menu_config);
	disp_menu_grid.init();
	disp_menu_grid.setGridWidth($('#menuInfo').width());
	
	// 하위메뉴저장 버튼 클릭시
	$("#btn_down_menu_add").click(function() {
		disp_menu_grid.save({success:function(){getTemplateDispTree(true, $("#tmpl_seq option:selected").val());}});
	});
	
	// 하위메뉴삭제 버튼 클릭시
	$("#btn_down_menu_del").click(function() {
		// JQ GRID CHECK BOX 선택대상 확인
		var params = new Array();	// 전송 파라미터 설정(MENU_ID)
		var cnt = 0;
		var idArry = $("#disp_menu_grid").jqGrid('getDataIDs'); //grid의 id 값을 배열로 가져옴
		for (var i = 0; i < idArry.length; i++) {
			if($("input:checkbox[id='jqg_disp_menu_grid_"+idArry[i]+"']").is(":checked")){
				cnt++;
				var rowdata = $("#disp_menu_grid").getRowData(idArry[i]);
				params.push(rowdata.MENU_ID);
			}
		}
		if(cnt == 0) {
			alert("삭제할 행을 선택해주세요.");
			return;
		}
		if(confirm("선택한 하위메뉴를 삭제하시겠습니까?")) {
			var up_tmpl_seq = $("#tmpl_seq option:selected").val();
			dbSavedMenuRemoveAjaxCall(params, up_tmpl_seq)
		}
	});
	
	$('#sys_info').change(function(){
		getTemplateDispTree(true);
		editMenuFlag = false;
		cutMenuFlag = false;
		copyMenuFlag = false;
		editMenuInfo = null;
	});
});

// 하위 메뉴 정보 설정
function getDownMenuInfo(pin) { 
	var pos = disp_menu_grid.getCellLastPosition();
	disp_menu_grid.setCell(pos.rowid, 'MNU_NM', pin.MNU_NM, '', {}, true);
	disp_menu_grid.setCell(pos.rowid, 'TMPL_TP_CD', pin.TMP_TYPE, '', {}, true);
	disp_menu_grid.setCell(pos.rowid, 'TMP_TYPE_NM', pin.TMP_TYPE_NM, '', {}, true);
	disp_menu_grid.setCell(pos.rowid, 'DSPLY_NO', pin.DSPLY_NO, '', {}, true);
	disp_menu_grid.setCell(pos.rowid, 'DSPLY_YN', pin.DSPLY_YN, '', {}, true);
	disp_menu_grid.setCell(pos.rowid, 'MNU_YN', pin.MNU_YN, '', {}, true);
	disp_menu_grid.setCell(pos.rowid, 'URL', pin.URL, '', {}, true);
	// 편집용 CHECK BOX 클릭
	$("#disp_menu_grid").setCell(pos.rowid, 'JQGRIDCRUD', 'U');
	$("input:checkbox[id='jqg_disp_menu_grid_"+pos.rowid+"']").prop("checked", true);
}

//grid resizing
$(window).resize(function() {
	disp_menu_grid.setGridWidth($('#menuInfo').width());
});

//입력값 필수 체크
function requiredCheck(arrId) {
	var flag = true;
	for(i=0; i<arrId.length; i++) {
		if(isEmpty($("#"+arrId[i]).val())) {
			var tgtName = $("label[for='"+arrId[i]+"']").text();
			alert("["+tgtName+"] - "+"필수항목을 입력해주세요.");
			$("#"+arrId[i]).focus();
			flag = false;
			return false;
		}
	}
	return flag;
}

// 전송 폼 유효성 체크
function validationForm(obj) {
 	// 템플릿유형 유효성 체크

 	var tmpTypeOk = true;
	var tmp_type = $("#tmp_type").val();

	if		(selected_level == 0)
		tmpTypeOk = (tmp_type == "1" ) ? tmpTypeOk : false;
	else if (selected_level == 1)
		tmpTypeOk = (tmp_type == "2" || tmp_type=="8") ? tmpTypeOk : false;
	else if (selected_level == 2)
		tmpTypeOk = ((tmp_type == "3" || tmp_type == "4" || tmp_type == "5")) ? tmpTypeOk : false;
	else if (selected_level == 3)
		tmpTypeOk = ((tmp_type == "6" || tmp_type == "7")) ? tmpTypeOk : false;
	
	// 템플릿유형 유효성 결과 확인
	if (!tmpTypeOk) {
		
		alert("생성하실 메뉴의 계층과 선택한 템플릿유형의 계층이 일치하지 않습니다.");
		menuInfoForm.tmp_type.focus();
		return false;
	}
	// 직원전용 페이지 유효성 확인
	if(!(tmp_type == "2" || tmp_type == "4" || tmp_type == "5")) {
		var menu_yn = $(":input:radio[name=menu_yn]:checked").val();
		if("N" == menu_yn) {
			alert("직원전용 페이지는 2층 페이지/게시판 메뉴까지만 허용됩니다.");
			return false;
		}
	}  
	
 	var arrId = (tmp_type == "1" || tmp_type == "2" || tmp_type == "3") ? ["tmp_type","tmpl_seq","mnu_nm","dsply_no"] : ["tmp_type","tmpl_seq","mnu_nm","dsply_no", "url"];
	var arrId = ["tmp_type","tmpl_seq","mnu_nm","dsply_no"];
	
	// 입력값 필수 체크
	return requiredCheck(arrId);
}

function submitFormCheck() {
// 	console.log(editMenuInfo);
	 // menuInfoForm form값 취득
	var f_tmp_type = $("#tmp_type option:selected").val();	// 템플릿유형
	
	// 신규 추가한 메뉴가 편집 중인 경우 [Tree에 "메뉴추가"]
 	if(editMenuInfo) {
		// 템플릿유형 유효성 체크
		var tmpTypeOk = true;
		if		(editMenuInfo.level == 0 || editMenuInfo.level == 1)
			tmpTypeOk = (f_tmp_type == editMenuInfo.tmp_type || f_tmp_type == "8") ? tmpTypeOk : false;
		else if	(editMenuInfo.level == 2)
			tmpTypeOk = ((f_tmp_type == "3" || f_tmp_type == "4" || f_tmp_type == "5")) ? tmpTypeOk : false;
		else if (editMenuInfo.level == 3)
			tmpTypeOk = ((f_tmp_type == "6" || f_tmp_type == "7")) ? tmpTypeOk : false;
		
		// 템플릿유형 유효성 결과 확인
		if (!tmpTypeOk) {
			alert("생성하실 메뉴의 계층과 선택한 템플릿유형의 계층이 일치하지 않습니다.");
			menuInfoForm.tmp_type.focus();
			return false;
		}
		
		// 직원전용 페이지 유효성 확인
		if(!(f_tmp_type == "2" || f_tmp_type == "4" || f_tmp_type == "5")) {
			var menu_yn = $(":input:radio[name=menu_yn]:checked").val();
			if("N" == menu_yn) {
				alert("직원전용 페이지는 2층 페이지/게시판 메뉴까지만 허용됩니다.");
				return false;
			}
		} 
		var arrId = (f_tmp_type == "1" || f_tmp_type == "2" || f_tmp_type == "3") ? ["tmp_type","tmpl_seq","mnu_nm","dsply_no"] : ["tmp_type","tmpl_seq","mnu_nm","dsply_no", "url"]; 
		return requiredCheck(arrId)
 	}
	// 기존 메뉴에 대한 편집 중인 경우 (DB에 저장된 메뉴에 대한 편집)
	else if(isSavedMenu) {
		return validationForm();
	} 
	
	return true;
}

// 템플릿유형 변경
function changeTmpType(obj, param) {
	// 템플릿 유형 변동 시 : 적용 템플릿 영역 초기화
	selectBoxReset("#tmpl_seq");
	// 템플릿 유형을 선택 시 
	if(!isEmpty(obj.value) || !isEmpty(param)) {
		// 좌측 트리 정보 갱신
		var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getSelectedNodes();
		
		var selectedTmpType = (!isEmpty(param)) ? param : obj.value;
// 		if(selectedTmpType == "1" || selectedTmpType == "2") $("#required_yn").removeClass("vv");
// 		else $("#required_yn").addClass("vv");

		// 적용 템플릿 영역 Option값 입력
		for(i=0; i<tmpMappingInfoList.length; i++) {
			if(selectedTmpType == tmpMappingInfoList[i].tmpl_tp_cd) {
				var optionTxt = tmpMappingInfoList[i].tmpl_nm;
				var optionVal = tmpMappingInfoList[i].tmpl_seq;
				var mapped_yn = tmpMappingInfoList[i].mapped_yn;
				var tmpl_url = isEmpty(tmpMappingInfoList[i].tmpl_url) ? "" : tmpMappingInfoList[i].tmpl_url;
				// 현재 매핑되지 않은 템플릿 or 해당 메뉴에 적용중인 템플릿에 한해서 적용템플릿을 설정
				if("N" == mapped_yn || optionVal == nodes[0].id) {
					$("#tmpl_seq").append("<option value='" + optionVal + "' tmpl_url='"+tmpl_url+"'>" + optionTxt + "</option> ");
				} 
			}
		}
		if(!isEmpty(nodes[0]) && nodes[0].isSaved == 'Y') {
			if(nodes[0].tmpl_tp_cd == selectedTmpType) {
				$("#tmpl_seq").val(nodes[0].id).prop("selected", true).trigger('change');	
			}
		}
		// 적용 템플릿 영역 Option 값이 없을 때 : 영역 Disabled 
		if($('#tmpl_seq > option').length > 1) $("#tmpl_seq").attr("disabled", false);
	} 
}

// 메뉴 추가 EVENT
function add(e) {
	
	var sysCd = $('#sys_info').val();
	
	if(sysCd == "") {
		alert("사이트를 선택해주세요.");
		return false;
	}
	
	formControl(false);
	//메뉴편집 진행 플래그 확인
	if(editMenuFlag) {
		alert("현재 편집 중인 신규 메뉴가 있습니다.\n편집내용을 저장 하신 후 다시 진행해주세요.");
		return false;
	}
	// 현재 선택된 메뉴의 정보를 취득
	var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
		nodes = zTree.getSelectedNodes(),
		treeNode = nodes[0];
	
	// 신규 생성될 메뉴의 설정값
	var menuName = "새 메뉴";		// 메뉴명 기본값
	var isParent = true;		// 하위 메뉴 허용값 (기본 허용)
	var parentId = null;		// 상위 템플릿 ID
	var tmp_type = "1";			// 템플릿 유형 기본값 : (1:[메인])
	
	// 메뉴 추가 허용값 : 기본 허용
	var addMenuOkFlag = true;
	
	// 현재 등록된 메뉴가 있는지 체크
	/* if(zNodes.length > 0) {
	} */
	// 선택된 메뉴가 존재하면
	if (treeNode) {
		// 선택된 메뉴의 템플릿 정보 확인 (하위허용여부)
		isParent = treeNode.isParent;
		
		// 하위허용일 경우
		if(isParent) {
			// 생성될 메뉴의 상위 메뉴 취득
			parentId = treeNode.id;
			// 메인 메뉴 선택 시
			if (treeNode.level == 0) {
				// 생생될 신규 메뉴의 템플릿 유형 기본값 설정 : 1층 일반메뉴(2)
				tmp_type = "2";
			} 
			// 1Depth 메뉴 선택 시
			else if (treeNode.level == 1){
				// 생생될 신규 메뉴의 템플릿 유형 기본값 설정 : 2층 일반메뉴(3)
				tmp_type = "3";
			}
			// 2Depth 메뉴 선택 시 
			else if (treeNode.level == 2){
				// 신규 생성될 3Depth 메뉴는 하위 생성 불가
				isParent = false;
				// 생생될 신규 메뉴의 템플릿 유형 기본값 설정 : 3층 페이지(7)
				tmp_type="7";
			} 
		} 
		// 하위불가일 경우
		else {
			addMenuOkFlag = false;
		}
	}
	// 선택된 메뉴가 없는 경우(최상층 메뉴 추가 시 : 메인메뉴의 유무를 판단)
	else if(zTree.getNodes()[0]) {
		alert("메인 메뉴는 한개만 설정이 가능합니다. \n등록된 메인 메뉴를 선택하시고 [메뉴추가] 버튼을 눌러주세요.");
		addMenuOkFlag = false;
		formControl(true);
		return false;
	}
	// 메뉴 추가 허용값이 유효하면 
	if(addMenuOkFlag) {
		// 새 메뉴 추가
		treeNode = zTree.addNodes(treeNode, {id:("TMP" + newCount++)
											,pId:parentId
											,name:menuName
											,isParent:isParent
											,tmp_type:tmp_type
											,isSaved:"N"
											,mnu_yn:"Y"
											,dsply_yn:"Y"
											,mnu_yn:"N"
											,us_yn:"Y"});
		// 전시메뉴 상세정보 문구 변경
		$("#dispMenuTit").addClass("dispMenuAddTit");
		$("#dispMenuTit").text($("#dispMenuTit").text().replace("상세","추가"));
		
		// 전시메뉴 상세정보 Form값 초기화
		formClear();
		// 전시메뉴 상세정보 Hidden값 설정
		$("#up_tmpl_seq").val(parentId);
		// 새로 생성한 메뉴로 포커스
		zTree.editName(treeNode[0]);
		// 새로 생성한 메뉴의 정보를 전역변수에 임시 저장
		editMenuInfo = treeNode[0];
		// 정상적으로 메뉴추가가 완료되면 메뉴추가진행플래그를 진행중으로 변경
		editMenuFlag = true;
	} else {
		alert("선택하신 메뉴는 하위 메뉴를 추가할 수 없는 메뉴입니다.");
	}
};

// DB 저장 메뉴 삭제
function dbSavedMenuRemove(treeNode, directFlag) {
	if(treeNode.tmp_type == "1") {
		alert("메인 메뉴는 삭제하실 수 없습니다.");
		return false;
	}
	
	var params = new Array();
	params.push(treeNode.mnu_seq);

	if(!directFlag) {
		if(confirm("[" + treeNode.name + "] 메뉴를 삭제하시겠습니까? \n(상위메뉴 삭제시 하위메뉴도 같이 삭제됩니다.)")) {
			dbSavedMenuRemoveAjaxCall(params, '');	
		}	
	} else {
		dbSavedMenuRemoveAjaxCall(params, '');
	}
}

// DB 저장메뉴 삭제 Ajax Call
function dbSavedMenuRemoveAjaxCall(params, up_tmpl_seq) {
	ajax({
		url : "/pdsp/savePdsp100403.adm",
		data: {mnu_seq_arr:params, chgFlag:"DELETE"},
		success: function(data) {
			if(data.RESULT = "S") {
				alert("메뉴가 삭제되었습니다.");
				getTemplateDispTree(true);
				disp_menu_grid.retreive({data:{up_tmpl_seq:up_tmpl_seq}});
				if(isEmpty(up_tmpl_seq)) formClear();
				getTmpMappingInfoList();
			}
		}
	});
}

//메뉴 삭제 Event
function remove(e) {
	// 현재 선택 중인 메뉴 확인
	var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
		nodes = zTree.getSelectedNodes(),
		treeNode = nodes[0];
	
	// 선택된 메뉴가 하나도 없으면
	if (nodes.length == 0) {
		alert("삭제하실 메뉴를 선택해 주세요.");
		return false;
	} 
	// 선택된 메뉴가 DB에 저장된 메뉴인 경우
	if("Y" == treeNode.isSaved) {
		dbSavedMenuRemove(treeNode, false);
	} 
	// 선택된 메뉴가 DB저장 전의 메뉴인 경우
	else {
		// 전시 메뉴 트리정보 삭제
		$("#"+treeNode.tId).find("span.button.remove").trigger('click');
		// 삭제 후 전시메뉴 상세정보 Form값 초기화
		formClear();
	}
	
};

// 삭제 전 EVENT
function beforeRemove(treeId, treeNode) {
	return confirm("[" + treeNode.name + "] 메뉴를 삭제하시겠습니까? \n(상위메뉴 삭제시 하위메뉴도 같이 삭제됩니다.)");
}

// 삭제 후 EVENT
function onRemove(e, treeId, treeNode) {
	// 선택되었던 메뉴가 DB에 저장된 메뉴인 경우
	if("Y" == treeNode.isSaved) {
		dbSavedMenuRemove(treeNode, true);
	} 
	formClear();
}

//이름 변경 후 EVENT
function onRename(e, treeId, treeNode) {
	$("#mnu_nm").val(treeNode.name);
	$("#tmp_type").val(treeNode.tmp_type).prop("selected", true);
	$("input[name='disply_yn']:radio[value='"+treeNode.disply_yn+"']").prop('checked',true);
	$("input[name='menu_yn']:radio[value='"+treeNode.menu_yn+"']").prop('checked',true);
	changeTmpType("", treeNode.tmp_type);
}

//적용템플릿 영역 초기화
function selectBoxReset(id) {
	$(id).attr("disabled", true);
	$(id).find("option").remove();
	$(id).append("<option value url>#선택</option> ");
} 

// 이름 변경 전 EVENT
function beforeRename(treeId, treeNode, newName) {
	if (newName.length == 0) {
		setTimeout(function() {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.cancelEditName();
			alert("메뉴명을 입력 해주세요");
		}, 0);
		return false;
	}
	return true;
}

// 편집중단
function resetEdit(e) {
	if(!confirm("편집을 중단하시면 저장된 메뉴까지만 반영됩니다.\n편집을 중단하시겠습니까?")) return false;
	window.location.reload();
}

// 자르기
function cut(e) {
	var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
	nodes = zTree.getSelectedNodes();
	if (nodes.length == 0) {
		alert("이동할 메뉴를 선택 후 [자르기]버튼을 클릭주세요.");
		return;
	}
	curType = "cut";
	setCurSrcNode(nodes[0]);
}

// 복사
function copy(e) {
	var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
	nodes = zTree.getSelectedNodes();
	if (nodes.length == 0) {
		alert("복사할 메뉴를 선택 후 [복사]버튼을 클릭주세요.");
		return;
	}
	curType = "copy";
	setCurSrcNode(nodes[0]);
}

// 복사(자르기)의 임시값 설정
function setCurSrcNode(treeNode) {
	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	if (curSrcNode) {
		delete curSrcNode.isCur;
		var tmpNode = curSrcNode;
		curSrcNode = null;
		fontCss(tmpNode);
	}
	curSrcNode = treeNode;
	if (!treeNode) return;

	curSrcNode.isCur = true;			
	zTree.cancelSelectedNode();
	fontCss(curSrcNode);
}

// 붙이기
function paste(e) {
// 	console.log(curSrcNode);
	if (!curSrcNode) {
		alert("메뉴를 선택 후 [복사]나 [자르기] 버튼을 클릭 후 진행해주세요.");
		return;
	}
	var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
	nodes = zTree.getSelectedNodes(),
	targetNode = nodes.length>0? nodes[0]:null;
	// 붙이기할 메뉴가 선택되지 않은 경우
	if (!targetNode) {
		alert("붙여넣을 상위메뉴를 선택 해주세요.");
		$("#" + curSrcNode.tId + "_a").trigger('click');
		return false;
	} else if (curSrcNode === targetNode) {
		alert("기존메뉴와 동일한 위치로는 복사/붙이기를 사용하실 수 없습니다.");
		return false;
	}
	// 1Depth에 사용불가 메뉴 체크
	else if(!!targetNode && targetNode.level == 0 && !curSrcNode.isParent) {
		// 현재 선택된 메뉴(이동할 메뉴)가 메인 메뉴인 경우
		alert("메인 메뉴의 하위로 지정가능한 메뉴가 아닙니다.");
		return false;
	}
	// 다른계층간의 이동을 제한(부모의 계층이 동일한 경우만 이동을 허용)
	else if(!!targetNode && targetNode.tmp_type != curSrcNode.up_tmp_type) {
		alert("상위메뉴의 템플릿유형이 동일한 경우만 복사/이동이 가능합니다.");
		$("#" + curSrcNode.tId + "_a").trigger('click');
		return false;
	}
	else if (curType === "copy") {
		var curSrcNodeChg = getChangedNodes(curSrcNode, targetNode.id);
		targetNode = zTree.copyNode(targetNode, curSrcNodeChg, "inner");
		$("#" + targetNode.tId + "_a").trigger('click');
		copyMenuFlag = true;
	}
	else if (curType === "cut") {
		// 동일한 상위 메뉴를 가진 하위 메뉴간의 이동은 불가
		if((!!targetNode && curSrcNode.parentTId === targetNode.tId) || (!targetNode && !curSrcNode.parentTId)) {
			alert("이미 선택된 메뉴의 하위메뉴로 지정되어 있습니다.");
			$("#" + curSrcNode.tId + "_a").trigger('click');
			return false;
		}
		// 이동할 메뉴 데이터 설정(상위 템플릿 아이디)
		if(isNotEmpty(targetNode)) $("#up_tmpl_seq").val(targetNode.id);
		targetNode = zTree.moveNode(targetNode, curSrcNode, "inner");
		targetNode = curSrcNode;
		$("#" + targetNode.tId + "_a").trigger('click');
		cutMenuFlag = true;
	}
	setCurSrcNode();
	delete targetNode.isCur;
	
// 	zTree.selectNode(targetNode);
}

// 복사 대상 데이터 변경
function getChangedNodes(tgtNodes, parentId) {
	// 복사할 데이터 최상위 변경
	tgtNodes.id = "";
	tgtNodes.url = "";
	tgtNodes.mnu_seq = "";
	tgtNodes.name = tgtNodes.name + "_복사본";
	// 복사할 데이터 필수 요소 Object 설정
	var topDataArray = new Array();
	var midDataArray = new Array();
	var btmDataArray = new Array();
	var obj = new Object();
	obj.tmpl_tp_cd = tgtNodes.tmpl_tp_cd;
// 	obj.up_tmpl_seq = tgtNodes.pId;
	obj.up_tmpl_seq = parentId;
	obj.us_yn = "Y";
	obj.lgn_esn_yn = "N";
	obj.mnu_nm = tgtNodes.name+"_복사본";
	obj.tmpl_nm = tgtNodes.name+"_템플릿복사본";
	obj.tmp_url = tgtNodes.tmp_url;
	obj.mnu_yn = tgtNodes.mnu_yn;
	obj.stf_only_yn = tgtNodes.mnu_yn;
	topDataArray.push(obj);
	
	// 하위메뉴가 존재하는지 판단(최대 Depth가 3Depth이므로 3Depth까지 판단)
	if(isNotEmpty(tgtNodes.children)) {
		// 2Depth판단
		for(i=0; i<tgtNodes.children.length; i++) {
			// 복사할 데이터 변경
			tgtNodes.children[i].id = "";
			tgtNodes.children[i].url = "";
			tgtNodes.children[i].mnu_seq = "";
			tgtNodes.children[i].name = tgtNodes.children[i].name + "_복사본";
			
			// 복사할 데이터 필수요소 Object 설정
			var obj2 = new Object();
			obj2.tmpl_tp_cd = tgtNodes.children[i].tmpl_tp_cd;
			obj2.us_yn = "Y";
			obj2.mnu_yn = "N";
			obj2.lgn_esn_yn = "N";
			obj2.mnu_nm = tgtNodes.children[i].name;
			obj2.tmpl_nm = tgtNodes.children[i].name+"_템플릿복사본";
			obj2.tmp_url = tgtNodes.children[i].tmp_url;
			obj2.dsply_no = tgtNodes.children[i].dsply_no;
			obj2.mnu_yn = tgtNodes.children[i].mnu_yn;
			obj2.stf_only_yn = tgtNodes.children[i].mnu_yn;
			midDataArray.push(obj2);
			
			// 3Depth판단
			if(isNotEmpty(tgtNodes.children[i].children)) {
				for(j=0; j<tgtNodes.children[i].children.length; j++) {
					// 복사할 데이터 변경
					tgtNodes.children[i].children[j].id = "";
					tgtNodes.children[i].children[j].url = "";
					tgtNodes.children[i].children[j].mnu_seq = "";
					tgtNodes.children[i].children[j].name = tgtNodes.children[i].children[j].name + "_복사본";
					
					// 복사할 데이터 필수요소 Object 설정
					var obj3 = new Object();
					obj3.tmpl_tp_cd = tgtNodes.children[i].children[j].tmpl_tp_cd;
					obj3.us_yn = "Y";
					obj3.mnu_yn = "N";
					obj3.lgn_esn_yn = "N";
					obj3.mnu_nm = tgtNodes.children[i].children[j].name;
					obj3.tmpl_nm = tgtNodes.children[i].children[j].name+"_템플릿복사본";
					obj3.tmp_url = tgtNodes.children[i].children[j].tmp_url;
					obj3.dsply_no = tgtNodes.children[i].children[j].dsply_no;
					obj3.mnu_yn = tgtNodes.children[i].children[j].mnu_yn;
					obj3.stf_only_yn = tgtNodes.children[i].children[j].mnu_yn;
					btmDataArray.push(obj3);
				}
			}
		}
	}
	var totalInfo = new Object();
	if(topDataArray.length > 0) totalInfo.topDataInfo = topDataArray;
	if(midDataArray.length > 0) totalInfo.midDataInfo = midDataArray;
	if(btmDataArray.length > 0) totalInfo.btmDataInfo = btmDataArray;
	copyNodesObj = totalInfo;
// 	copyNodesJsonObj = JSON.stringify(totalInfo);
	
	return tgtNodes
}

// 메뉴 상태 구분(복사/자르기)
function fontCss(treeNode) {
	var aObj = $("#" + treeNode.tId + "_a");
	aObj.removeClass("copy").removeClass("cut");
	if (treeNode === curSrcNode) {
		if (curType == "copy") {
			aObj.addClass(curType);
		} else {
			aObj.addClass(curType);
		}			
	}
}
function fn_Search(){
	getTemplateDispTree(true);
}
function fn_Save(){
	// 편집창 비활성화시
	if($("input[name='mnu_nm']:disabled").length > 0) {
		alert("편집하실 메뉴를 선택해주세요.")
		return false;
	}
	
	$("#dispMenuTit").removeClass("dispMenuAddTit");
	$("#dispMenuTit").text($("#dispMenuTit").text().replace("추가","상세"));
	if(submitFormCheck()) {
		$("#menuInfoForm").submit();
	}
}
function fn_Delete(){
	
}
function fn_ExcelDownload(){
	
}
function fn_Print(){
	
}
</script>
</head>
<body>
<div class="frameWrap">
	<!-- tab1 contents -->
	<div class="subCon on clear">
		<%@ include file="/WEB-INF/views/pandora3/common/include/btnList2.jsp" %>
		<div class="tableTopLeft gridBtn">
            <div class="selectInner" style="display: none;">
                <label for="sys_info">사이트 : </label>
                <select id="sys_info" name="sys_info" class="select" >
                    <option  class="passOption" value="">선택</option>
                </select>
            </div>
        </div>
        <div class="treeWrap">
        	<div class="treeInner">
			<!-- 전시 메뉴 구성 -->
			<div class="tblType1 menuEdit treeList">
				<div class="leftTop">
                     <h3>전시메뉴구성</h3>
                     <button class="btn_common btn_gray" id="addMenu" onclick="return false;">추가</button>
                     <div class="treeBtn">
                         <button class="btn_common btn_default treeOpen" data-type="expandAll" id="tree_all" onclick="tree_all(this)">
                              	전체열기
                         </button>
                         <button class="btn_common btn_default" id="removeMenu" onclick="return false;">메뉴삭제</button>
                         <button class="btn_common btn_default" id="resetEdit" onclick="return false;">편집중단</button>
                         <button class="btn_common btn_default" id="copy" onclick="return false;">복사</button>
                         <button class="btn_common btn_default" id="cut" onclick="return false;">자르기</button>
                         <button class="btn_common btn_default" id="paste" onclick="return false;">붙이기</button>
                     </div>
                 </div>
                 <div class="leftBottom">
                     <ul id="treeDemo" class="ztree menuEdit h590">
                         
                     </ul>
                 </div>
			</div>
			<!--// 전시 메뉴 구성 -->
		<!-- 전시 메뉴 상세 정보 -->
		<div class="detailInfo">
			<div class="menuInfo">
				<form name="menuInfoForm" id="menuInfoForm" enctype="multipart/form-data" method="post" submit="return false;">
				<input type="hidden" name="up_tmpl_seq" id="up_tmpl_seq" />
				<table id="menuInfo" class="tblType1 mB60">
					<colgroup>
						<col width="20%" />
						<col width="30%" />
						<col width="20%" />
						<col width="30%" />
					</colgroup>
					<tr>
						<th colspan="4">전시메뉴 상세정보</th>
					</tr>
					<tr>
						<td colspan="4" class="detailTitle">
							<b id="dispMenuTit">전시메뉴 상세</b>
						</td>
					</tr>
					<tr>
						<th><label for="tmp_type" class="vv">템플릿유형</label></th>
						<td>
							<%=CodeUtil.getSelectComboList("TMP_TYPE", "tmp_type", "#선택", "", "", "class=\"select\" onchange=\"changeTmpType(this)\"")%>
						</td>
						<th><label for="tmpl_seq" class="vv">적용템플릿</label></th>
						<td>
							<select name="tmpl_seq" id="tmpl_seq" name="tmpl_seq" class="select"></select>
						</td>
					</tr>
					<tr>
						<th><label for="mnu_nm" class="vv">메뉴명</label></th>
						<td>
							<span class="txt_pw"><input type="text" id="mnu_nm" name="mnu_nm" class="w100"/></span>
						</td>
						<th class="">메뉴코드</th>
						<td>
							<span class="txt_pw"><input type="text" id="mnu_seq" name="mnu_seq" class="w100 readonlyTxt" readonly/></span>
						</td>
					</tr>
					<tr>
						<th class="vv">전시여부</th>
						<td>
							<div class="radio">
								<span><input type="radio" id="dsply_y" name="dsply_yn" value="Y" /><label for="dsply_y">전시</label></span>
								<span><input type="radio" id="dsply_n" name="dsply_yn" value="N" /><label for="dsply_n">비전시</label></span>
							</div>
						</td>
						<th class="vv">직원전용</th>
						<td>
							<div class="radio">
								<span><input type="radio" id="menu_y" name="mnu_yn" value="Y" /><label for="menu_y">공용</label></span>
								<span><input type="radio" id="menu_n" name="mnu_yn" value="N" /><label for="menu_n">직원전용</label></span>
							</div>
						</td> 
					</tr>
					<tr>
						<th><label for="dsply_no" class="vv">전시순위</label></th>
						<td>
							<span class="txt_pw"><input type="text" id="dsply_no" name="dsply_no" class="w10" maxlength="3"/> 번째</span>
						</td>
						<th class="">사용여부</th>
						<td>
							<div class="radio">
								<span><input type="radio" id="us_y" name="us_yn" value="Y" /><label for="us_y">사용</label></span>
								<span><input type="radio" id="us_n" name="us_yn" value="N" /><label for="us_n">미사용</label></span>
							</div>
						</td>
						
					</tr>
					<tr>
						<th class="">URL</th>
						<td colspan="3">
							<span class="txt_pw"><input type="text" id="url" name="url" class="w80" /></span>
							<a href="#" id="btn_get_tmp_url" class="btn_common btn_default btn_input_right">템플릿URL취득</a>
						</td>
					</tr>
				</table>
				</form>
			</div>
			<div class="grid_right_btn">
				<div class="grid_right_btn_in">
					<button class="btn_common btn_default" id="btn_menu_del">하위메뉴삭제</button>
					<button class="btn_common btn_default" id="btn_down_menu_add">하위메뉴저장</button>
				</div>
			</div>
			<!-- Grid : TOP GRID-->
			<table id="disp_menu_grid"></table> 
			<div id="disp_menu_grid_pager"></div>
			<!-- Grid : TOP GRID-->
			
			<!--// 전시 메뉴 상세 정보 -->
		</div>
			</div>
        </div>
	</div>
</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>