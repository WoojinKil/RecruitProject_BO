<%-- 
   1. 파일명 : pbbs1007
   2. 파일설명 : 게시글 상세 및 수정 : 동영상게시판
   3. 작성일 : 2018-04-10
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<style>.new_img{display:none;}</style>
<script type="text/javascript">
var newFileFlag = false;
var save_url_inf;
var modl_seq = _param;
var doc_seq = _param2;
var board_editor;

$(document).ready(function() {
	// 게시판 정보 조회 : 동영상게시판
	ajax({
		url:'/pbbs/getPbbs1007MpiList.adm',
		success: function(data) {
			var boardModuleList = data.boardModuleList;
			for(var i=0; i < boardModuleList.length; i++) {
				if(_param == boardModuleList[i].MODL_SEQ) {
					$("#modl_nm").text(boardModuleList[i].MODL_NM);
					$("#modl_tp").val(boardModuleList[i].MODL_TP);
					break;
				}
			}
		}
	});
	
	// 수정 버튼 클릭 시
	$("#btn_mainpop_add").click(function() {
		if(validChk()) {
			submitFormWrite();
		}
	});
	
	// 쓰기 서브밋
	$("#frm_modify").submit(function(e) {
		// 동영상 정보 셋팅
		var cts = board_editor.instances['cts'].getData();
		$("#cts").val(cts);
		$("#url_inf").val(save_url_inf);
		
		// 파라미터 셋팅
		var formData = new FormData($(this)[0]);
		formData.append("cts", cts);
		formData.append("newFileFlag", newFileFlag);
		formData.append("chg_flag", "UPDATE");
		formData.append("doc_seq", doc_seq);
		formData.append("modl_seq", modl_seq);
		formData.append("notc_yn", "N");
		formData.append("cmt_pms_stat", "DENY");
		formData.append("otp_stat", "PUBLIC");
		
		// 동영상 수정
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
					alert("동영상이 수정되었습니다.");
					window.location.reload();
					addTabInFrame("/pbbs/forward.pbbs1004.adm", "CHG");
				}else {
					alert('작업이 정상적으로 실행되지 않았습니다. 잠시후 다시 시도하세요');
				}
			} 
		});
		e.preventDefault();
	});
	
	// 삭제 버튼 클릭 시
	$("#btn_thumbImg_del").click(function() {
		$(".org_img").hide();
		$(".new_img").show();
		newFileFlag = true;
	});
	
	// 초기화
	doInit();
});

// 초기화
function doInit() {
	// 최초 FOCUS
	$("#titl").focus();
	
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
	
	// 동영상 상세 조회
	ajax({
		url:"/pbbs/getPbbs1007PviList.adm",
		data:{modl_seq:modl_seq, doc_seq:doc_seq},
		success:function(data) {
			$("#titl").val(data.tbbsDocInfMap.titl);
			$("#url_inf").val(data.tbbsDocInfMap.url_inf);
			board_editor.instances['cts'].setData(data.tbbsDocInfMap.cts);
			for(var i = 0; i < data.tbbsFlInfMapList.length; i++) {
				var flMapList = data.tbbsFlInfMapList[i];
				if(i == (data.tbbsFlInfMapList.length-1)) {
					$("#org_img_name").attr("href", "javascript:fileDown("+ flMapList.FL_SEQ +");");
					$("#org_img_name").text(flMapList.ORI_FL_NM);
				}
			}
		}
	});
}

// 입력값 유효성 체크
function validChk() {
	// 유효성 FLAG
	var validFlag = true;
	
	// INPUT 체크
	$('input[type="text"], textarea').each(function() {
		var id = $(this).attr("id");
		var value = $(this).val();
		// 필수체크
		if(isEmpty(value)) {
			var label = $('label');
			for(i=0; i<label.length; i++) {
				if(!newFileFlag && $(label[i]).attr("for") == "fileTxt") {
					break;
				}
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
	return validFlag;
}

// 쓰기 서브밋
function submitFormWrite() {
	if(!confirm("작성내용을 저장하시겠습니까?")) {
		return false;
	}else {
		$("#frm_modify").submit();
	}
}
</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
		<h1><%=_title %></h1>
			<form name="frm_modify" id="frm_modify" enctype="multipart/form-data" method="post" onsubmit="return false;">
				<table class="tblType1">
					<colgroup>
						<col width="20%" />
						<col width="31%" />
						<col width="*" />
					</colgroup>
					<tr>
					<th><label for="modl_nm" class="vv">게시판종류</label></th>
					<td id="modl_nm"></td>
					<td>
						<input type="hidden" name="modl_tp" id="modl_tp"/>
						<div class="grid_btn"><button type="button" class="btn_common btn_default" id="btn_mainpop_add" style="margin-right: 10px;">수정</button></div>
					</td>
					</tr>
					<tr>
						<th><label for="titl" class="vv">동영상명</label></th>
						<td colspan="2">
							<span class="txt_pw"><input type="text" name="titl" id="titl" class="w100"/></span>
						</td>
					</tr>
					<tr>
						<th><label for="url_inf" class="vv">동영상URL</label></th>
						<td colspan="2">
							<span class="txt_pw"><textarea name="url_inf" id="url_inf" class="textarea w100 h100"></textarea></span>
						</td>
					</tr>
					<tr>
						<th><label for="fileTxt" class="vv">썸네일 이미지</label></th>
						<td class="org_img">
							<a href="#" id="org_img_name" style="height:26px;font-size:13px;font-weight: bold;"></a>
						</td>
						<td class="org_img"><button type="button" class="btn_common btn_default" id="btn_thumbImg_del">삭제</button></td>
						<td class="new_img">
						<span class="fileAdd w100">
							<input id="fileTxt" type="text" class="w70" value="" placeholder="선택된 파일 없음" readonly>
							<input type="button" value="파일첨부" class="btn_common btn_default" onclick="javascript:document.getElementById('img_files').click();">
							<input id="img_files" type="file" style='visibility:hidden;' name="img_files" onchange="ChangeText(this, 'fileTxt');" accept=".jpg, .jpeg, .bmp, .gif, .png"/>
						</span>
						</td>
						<td class="new_img"><p><b class="required">*허용확장자 :</b> .jpg, .jpeg, .png, .gif, .bmp</p></td>
					</tr>
					<tr>
						<td colspan="3" class="editorTd">
							<div class="editor"><textarea name="cts" id="cts"></textarea></div>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
