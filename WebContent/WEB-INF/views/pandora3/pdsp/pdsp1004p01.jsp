<%-- 
   1. 파일명 : pdsp1004p01
   2. 파일설명: 메뉴전시관리 상세보기
   3. 작성일 : 2018-03-29
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var tmpMappingList		// 템플릿 매핑 정보 목록
var selected_tmpl_seq = '<%= parameterMap.getValue("tmpl_seq") %>';
var selected_tmp_type = '<%= parameterMap.getValue("tmp_type") %>';
var selected_up_tmpl_seq = '<%= parameterMap.getValue("up_tmpl_seq") %>';
var selected_up_tmp_type = '<%= parameterMap.getValue("up_tmp_type") %>';
var selected_mnu_seq = '<%= parameterMap.getValue("mnu_seq") %>';
var selected_mnu_nm = '<%= parameterMap.getValue("mnu_nm") %>';
var selected_dsply_no = '<%= parameterMap.getValue("dsply_no") %>';
var selected_mnu_yn = '<%= parameterMap.getValue("mnu_yn") %>';
var selected_url = '<%= parameterMap.getValue("url") %>';
var selected_dsply_yn = '<%= parameterMap.getValue("dsply_yn") %>';

debugger;
$(document).ready(function(){
	// 템플릿 리스트(메뉴 매핑여부 포함) 취득
	getTmpMappingInfoList();
	
	// 확인버튼 클릭 시
	$("#btn_down_menu_add").click(function() {
		if(validationForm()) {
			var obj = new Object();
			obj.TMP_TYPE = $("#tmp_type").val();
			obj.TMP_TYPE_NM = $("#tmp_type option:selected").text();
			obj.TMPL_SEQ = $("#tmpl_seq").val();
			obj.MNU_NM = $("#mnu_nm").val();
			obj.DSPLY_NO = $("#dsply_no").val();
			obj.MNU_YN = $(":input:radio[name=mnu_yn]:checked").val();
			obj.DSPLY_YN = $(":input:radio[name=dsply_yn]:checked").val();
			obj.MNU_SEQ = $("#mnu_seq").val();
			obj.URL = $("#url").val();
			eval('opener.<%= parameterMap.getValue("callback") %>')(obj);
			window.close();
		}
	});
});

// 입력값 필수 체크
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
function validationForm() {
	var tmp_type = $("#tmp_type").val();
	var arrId = ["tmp_type","tmpl_seq","mnu_nm","dsply_no"];
	// 템플릿 유형별 유효성 체크
	if(selected_up_tmp_type == tmp_type) {
		alert("상위 메뉴의 템플릿보다 동일한 템플릿은 사용할 수 없습니다.");
		return false;
	}
	else if(selected_up_tmp_type == "1") {
		if(tmp_type != "2") {
			alert("0층 메인 메뉴의 하위는 1층 일반메뉴만 사용 가능합니다.");
			return false;
		}
	} 
	else if(selected_up_tmp_type == "2") {
		if(!(tmp_type == "3" || tmp_type == "4" || tmp_type =="5")) {
			alert("1층 일반 메뉴의 하위는 2층 일반/게시판/페이지메뉴만 사용 가능합5니다.");
			return false;
		}
	}
	else if(selected_up_tmp_type == "3") {
		if(!(tmp_type == "6" || tmp_type == "7")) {
			alert("2층 일반 메뉴의 하위는 3층 게시판/페이지메뉴만 사용 가능합니다.");
			return false;
		} 
	} 
	else if(!(f_tmp_type == "2" || f_tmp_type == "4" || f_tmp_type == "5")) {
		var mnu_yn = $(":input:radio[name=mnu_yn]:checked").val();
		if("N" == mnu_yn) {
			alert("직원전용 페이지는 2층 페이지/게시판 메뉴까지만 허용됩니다.");
			return false;
		}
	}
	// 입력값 필수 체크
	return requiredCheck(arrId);
}

//템플릿 리스트(메뉴 매핑여부 포함) 취득
function getTmpMappingInfoList() {
	$.ajax({
		url: _context + '/pdsp/getPdsp1004List2',
		type: 'POST',
		contentType: false,
		cache: false,
		processData:false,
		success: function(data) {
			tmpMappingList = JSON.parse(data).mapList;
			// 초기값 설정
			$("#tmp_type").val(selected_tmp_type).trigger('change');
			$("#tmpl_seq").val(selected_tmpl_seq)
			$("#mnu_nm").val(selected_mnu_nm);
			$("#dsply_no").val(selected_dsply_no);
			$("input[name='mnu_yn']:radio[value='"+selected_mnu_yn+"']").attr('checked',true);
			$("input[name='dsply_yn']:radio[value='"+selected_dsply_yn+"']").attr('checked',true);
			$("#mnu_seq").val(selected_mnu_seq);
			$("#url").val(selected_url);
		}
	});
}

//템플릿유형 변경
function changeTmpType(obj) {
	// 템플릿 유형 변동 시 : 적용 템플릿 영역 초기화
	$("#tmpl_seq").attr("disabled", true);
	$("#tmpl_seq").find("option").remove();
	$("#tmpl_seq").append("<option value url>#선택</option> ");

	// 템플릿 유형을 선택 시 
	if(!isEmpty(obj.value)) {
		// 필수값 정의(게시판/페이지 타입에 한해서만 URL이 필수값)
// 		if(obj.value == "1" || obj.value == "2" || obj.value == "3") $("#required_yn").removeClass("vv");
// 		else $("#required_yn").addClass("vv");
		
		// 적용 템플릿 영역 Option값 입력
		for(i=0; i<tmpMappingList.length; i++) {
			debugger;
			if(obj.value == tmpMappingList[i].tmpl_tp_cd) {
				var optionTxt = tmpMappingList[i].tmpl_nm;
				var optionVal = tmpMappingList[i].tmpl_seq;
				var mapped_yn = tmpMappingList[i].mapped_yn;
				var url = tmpMappingList[i].url;
				// 현재 매핑되지 않은 템플릿 or 해당 메뉴에 적용중인 템플릿에 한해서 적용템플릿을 설정
				if("N" == mapped_yn || selected_tmpl_seq == optionVal) {
					$("#tmpl_seq").append("<option value='" + optionVal + "' url='"+url+"'>" + optionTxt + "</option> ");
				} 
			}
		}
		// 적용 템플릿 영역 Option 값이 없을 때 : 영역 Disabled 
		if($('#tmpl_seq > option').length > 1) $("#tmpl_seq").attr("disabled", false);
	} 
}
function fn_Sereach(){
	
}
function fn_Save(){
	
}
function fn_Delete(){
	
}
function fn_ExcelDownload(){
	
}
function fn_Print(){
	
}
</script>
</head>
<body style="min-width:500px">
	<form name="search" id="search" name="search" onsubmit="return false">
		<table class="tblType1 w100">
			<colgroup>
				<col width="20%" />
				<col width="30%" />
				<col width="20%" />
				<col width="30%" />
			</colgroup>
			<tr>
				<th colspan="4">하위메뉴 상세정보</th>
			</tr>
			<tr>
				<th><label for="tmp_type" class="vv">템플릿유형</label></th>
				<td>
					<%=CodeUtil.getSelectComboList("TMP_TYPE", "tmp_type", "#선택", "", "", "class=\"select\" onchange=\"changeTmpType(this)\"")%>
				</td>
				<th><label for="tmpl_seq" class="vv">적용템플릿</label></th>
				<td>
					<select name="tmpl_seq" id="tmpl_seq" class="select"></select>
				</td>
			</tr>
			<tr>
				<th><label for="mnu_nm" class="vv">메뉴명</label></th>
				<td>
					<span class="txt_pw"><input type="text" id="mnu_nm" name="mnu_nm" class="w100"/></span>
				</td>
				<th>메뉴코드</th>
				<td>
					<span class="txt_pw"><input type="text" id="mnu_seq" name="mnu_seq" class="w100 readonlyTxt" readonly/></span>
				</td>
			</tr>
			<tr>
				<th>전시여부</th>
				<td>
					<div class="radio">
						<span><input type="radio" id="disply_y" name="dsply_yn" value="Y" /><label for="disply_y">전시</label></span>
						<span><input type="radio" id="disply_n" name="dsply_yn" value="N" checked="checked" /><label for="disply_n">비전시</label></span>
					</div>
				</td>
				<th>직원전용</th>
				<td>
					<div class="radio">
						<span><input type="radio" id="menu_y" name="mnu_yn" value="Y" /><label for="menu_y">공용</label></span>
						<span><input type="radio" id="menu_n" name="mnu_yn" value="N" checked="checked" /><label for="menu_n">직원전용</label></span>
					</div>
				</td>
			</tr>
			<tr>
				<th><label for="dsply_no" class="vv">전시순위</label></th>
				<td colspan="3">
					<span class="txt_pw"><input type="text" id="dsply_no" name="dsply_no" class="w10" maxlength="3"/> 번째</span>
				</td>
			</tr>
			<tr>
				<th>URL</th>
				<td colspan="3">
					<span class="txt_pw"><input type="text" id="url" name="url" class="w100" /></span>
				</td>
			</tr>
		</table>
	</form>
		<table class="tblType3">
			<tr>
				<td>
					<div class="grid_btn">
					<a href="#" id="btn_down_menu_add" class="btn_common btn_darkGray">확인</a>
					</div>
				</td>
			</tr>
		</table>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
