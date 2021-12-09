<%-- 
   1. 파일명 : pbbs1009
   2. 파일설명: 게시글 등록(동영상게시판)
   3. 작성일 : 2018-04-11
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/bFileControl.js"></script>
<script type="text/javascript">
var newFileFlag = true;
var doc_seq;
var save_url_inf;
var board_editor;

$(document).ready(function() {
	// 조회조건 : 게시판종류 콤보
	ajax({
		url:'/pbbs/getPbbs1007MpiList.adm',
		success: function(data) {
			var boardModuleList = data.boardModuleList;
			for(var i=0; i < boardModuleList.length; i++) {
				$("#modl_seq").append(
						"<option value='" + boardModuleList[i].MODL_SEQ
							              + "' module_type='" + boardModuleList[i].MODL_TP+ "'>"
							              + boardModuleList[i].MODL_NM 
					                      +"</option>"
				);
			}
		}
	});
	
	// 쓰기 서브밋
	$("#frm_regist").submit(function(e) {
		// 동영상 정보 셋팅
		var cts = board_editor.instances['cts'].getData();
		$("#cts").val(cts);
		$("#url_inf").val(save_url_inf);
		
		// 파라미터 셋팅
		var formData = new FormData($(this)[0]); 
		formData.append("newFileFlag", newFileFlag);
		formData.append("chg_flag", "INSERT");
		formData.append("doc_seq", doc_seq);
		formData.append("modl_seq", $("#modl_seq option:selected").val());
		formData.append("notc_yn", "N");
		formData.append("cmt_pms_stat", "DENY");
		formData.append("otp_stat", "PUBLIC");
		
		// 동영상 등록
		$.ajax({
			url:_context + '/pbbs/savePbbs1007PvInf',
			type:'POST',
			data:formData,
			mimeType:"multipart/form-data",
			contentType:false,
			cache:false,
			processData:false,
			success:function(data) {
				var json = eval('('+data+')');
				if(_boolean_success == json.RESULT) {
					alert("동영상이 등록되었습니다.");
					// 통합게시글조회 화면 추가
					addTabInFrame("/pbbs/forward.pbbs1004.adm", "CHG");
				}else {
					alert('작업이 정상적으로 실행되지 않았습니다. 잠시후 다시 시도하세요');
				}
			}
		});
		e.preventDefault();
	});
	
	// 초기화
	doInit();
	
	$("#saveBtn").on("click", function () {
		fn_Save();
	});
});

// 목록: 내부 로직 사용자 정의
function fn_List() {
	addTabInFrame("/pbbs/forward.pbbs1004.adm", "CHG");
}
// 저장: 내부 로직 사용자 정의
function fn_Save() {
	if(validChk()) {
		submitFormWrite();
	}
}

// 초기화
function doInit() {
	// CKEDITOR 세팅
	board_editor = CKEDITOR;
	board_editor.replace('cts', {
		width : '100%',
		height : '325px',
		draggable : false,
		filebrowserImageUploadUrl : _context +'/board/updateImageUpload.adm',
	});
	board_editor.on('dialogDefinition', function(event) {
		event.data.definition.resizable = CKEDITOR.DIALOG_RESIZE_NONE;
		var dialogName = event.data.name;
		var dialogDefinition = event.data.definition;
		
		switch(dialogName) {
			case 'image':
				dialogDefinition.removeContents('Link');
				dialogDefinition.removeContents('advanced');
				var infoTab = dialogDefinition.getContents( 'info' );
				var upload = dialogDefinition.getContents( 'Upload' );
				infoTab.remove('txtHSpace');
				infoTab.remove('txtVSpace');
				infoTab.remove('txtBorder');
				infoTab.remove('cmbAlign');
				break;
		}
	});
	
	// 최초 FOCUS
	$("#titl").focus();
}

// 입력값 유효성 체크
function validChk() {
	// 유효성 Flag
	var validFlag = true;
	
	// 1. 입력폼 체크
	$('input[type="text"], input[type="hidden"], textarea').each(function() {
		var id = $(this).attr("id");
		var value = $(this).val();
		// 필수체크
		if(isEmpty(value)) {
			var label = $('label');
			for(var i = 0; i < label.length; i++) {
				if($(label[i]).attr("for") == id) {
					validFlag = false;
					alert($(label[i]).text()+"를 입력해주세요");
					$("#"+id).focus();
					break;
				}
			}
			return false;
		}else if(id == "url_inf") {
			// 동영상 URL양식 체크
			var url_inf = $("#url_inf").val();
			if(-1 != url_inf.indexOf("src")) {
				url_inf = $(url_inf);
				url_inf.attr({width:"100%", height:"100%"});
				save_url_inf = url_inf[0].outerHTML;
			}else {
				alert("올바른 양식의 동영상URL을 입력해주세요.");
				$("#"+id).focus();
				validFlag = false;
			}
		}
	});
	
	if (!validFlag) return validFlag;
	
	// 2. Data Byte 체크
	$("input[data-byte]").each(function(index, item) {
		var maxByte = $(item).data("byte");
		var target  = "#" + $(item).attr("id");
		var title   = $(item).attr("title");
		if(byteCheck($(target)) > maxByte){
	        alert(title + "은(는) " + maxByte + "자를 넘을 수 없습니다.");
	        validFlag = false;
	        return false;
	    }
	});
	
	return validFlag;
}

// 쓰기 서브밋
function submitFormWrite() {
	if(!confirm("작성내용을 저장하시겠습니까?")) {
		return false;
	}else {
		// 게시글 등록
		ajax({
			url:"/pbbs/getPbbsDocSeq.adm",
			data:{modl_seq : $("#modl_seq option:selected").val()},
			success:function(data) {
				if(isNotEmpty(data.doc_seq)) {
					doc_seq = data.doc_seq;
					$("#frm_regist").submit();
				}
			}
		});
	}
}
</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
		<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
			<form name="frm_regist" id="frm_regist" enctype="multipart/form-data" method="post" onsubmit="return false;">
				<table class="tblType1">
					<colgroup>
						<col style="width: 117px;">
						<col style="width: ">
						<col style="width: ">
						<col style="width: 117px;">
						<col style="width: ">
						<col style="width: ">
					</colgroup>
					<tr>
						<th><label for="modl_seq" class="vv">게시판종류</label></th>
						<td colspan="2"><span class="txt_pw"><select class="select w100" name="modl_seq" id="modl_seq"></select></span></td>
						<td class="b_type2" colspan="3"></td>
					</tr>
					<tr>
						<th><label for="titl" class="vv">동영상 명</label></th>
						<td colspan="5">
							<span class="txt_pw"><input type="text" name="titl" id="titl" class="w100" data-byte="250" title="동영상명"/></span>
						</td>
					</tr>
					<tr>
						<th><label for="url_inf" class="vv">동영상URL</label></th>
						<td colspan="5">
							<span class="txt_pw"><textarea name="url_inf" id="url_inf" class="textarea w100 h100"></textarea></span>
						</td>
					</tr>
					<tr>
						<th><label for="fileTxt" class="vv">썸네일 이미지</label></th>
						<td colspan="3">
							<span class="fileAdd w100">
								<input id="fileTxt" type="text" class="w70" value="" placeholder="선택된 파일 없음" readonly>
								<input type="button" value="파일첨부" class="btn_common btn_default" onclick="javascript:document.getElementById('img_files').click();">
								<input id="img_files" type="file" style='visibility:hidden;' name="img_files" onchange="ChangeText(this, 'fileTxt');" accept=".jpg, .jpeg, .bmp, .gif, .png"/>
							</span>
						</td>
						<td colspan="2"><p><b class="required">*허용확장자 :</b> .jpg, .jpeg, .png, .gif, .bmp</p></td>
					</tr>
					<tr>
						<td colspan="6" class="editorTd">
							<div class="editor"><textarea name="cts" id="cts"></textarea></div>
						</td>
					</tr>
				</table>
			</form>
			<div class="bottomBtnWrap nonFloating">
				<button type="button" id="saveBtn" class="btn_common btn_dark">저장</button>
			</div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>