<%--
   1. 파일명 : pbbs1006
   2. 파일설명: 질문답변게시글 상세
   3. 작성일 : 2018-04-10
   4. 작성자 : TANINE
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/bFileControl.js"></script>
<script type="text/javascript">
var board_qcts_editor;
var board_editor;
var stdConstQA_ans_grid;
var chkCmtSeq = null;
var insertFlag = true;
var replyFlag = false;

$(document).ready(function() {

	// 처리상태수정 버튼 클릭 시
	$("#btn_chgProcCd").click(function(e) {
		if(confirm("처리상태를 수정하시겠습니까?")) {
			ajax({
				url:"/pbbs/insertPbbs1006QaCmtInf.adm",
				data:{modl_seq:_param, doc_seq:_param2, proc_cd:$("#proc_cd").val()},
				success: function(data) {
					if(data.RESULT == _boolean_success) {
						alert("처리상태가 수정되었습니다.");
						return;
					}else {
						alert("정상적으로 실행되지 않았습니다. 잠시후 다시 시도하세요.")
						return;
					}
				}
			});
			e.preventDefault();
		}
	});

	// 답변등록 버튼 클릭 시
	$("#btn_reganswer").click(function() {
		submitFormWrite();
	});

	// 초기화 버튼 클릭시
	$("#btn_resetanswer").click(function() {
		board_editor.instances['cts'].setData("");
		insertFlag = true;
		chkCmtSeq = null;
		$("#btn_reganswer").html("답변등록");
	});

	// 쓰기 서브밋
	$("#frm_write").submit(function(e) {
		var cts = board_editor.instances['cts'].getData();
		// 파라미터 셋팅
		var fileCheckBox = $("input:checkbox[name='fileChk']");
		var filePathBox = $("input[name='filePath']");
		var params = new Array();
		for(var i = 0; i < fileCheckBox.length; i++) {
			params.push(fileCheckBox[i].value);
		}
		ajax({
			url:"/pbbs/insertPbbs1006QaCmtInf",
			data:{modl_seq:_param, doc_seq:_param2, proc_cd:$("#proc_cd").val(), cts:cts, cmt_seq:chkCmtSeq,fl_seqs:params.join(',')},
			success: function(data) {
				if(data.RESULT == _boolean_success) {
					if(isEmpty(chkCmtSeq)) {
					    alert("답변이 등록되었습니다.");
					}else {
						alert("답변이 수정되었습니다.");
					}
					return;
				}else {
					alert("정상적으로 실행되지 않았습니다. 잠시후 다시 시도하세요.")
					return;
				}
			}
		});
		e.preventDefault();
	});

	// 초기화
	doInit();
	
});



// 초기화
function doInit() {
	
	$("#cstr_nm").text(('<%=userInfo.getCstr_nm() %>'));
    $("#org_nm").text('<%=userInfo.getHr_org_nm() %>');
    $("#usr_id").text(('<%=userInfo.getUser_id() %>'));
    $("#usr_nm").text('<%=userInfo.getUser_nm() %>');
	
	// 파라미터 전달값 설정
	$("#modl_seq").val(_param);
	$("#doc_seq").val(_param2);

	// CKEDITOR 세팅
	board_qcts_editor = CKEDITOR;
	board_qcts_editor.replace('q_cts', {
		width : '100%',
		height : '200px',
		draggable : false,
		on :{instanceReady : function() {
			$('#cke_1_top').hide();
			$('#cke_1_bottom').hide();
		}}
	});


	// CKEDITOR 세팅
	board_editor = CKEDITOR;
	board_editor.replace('cts', {
		width:'100%',
		height:'200px',
		filebrowserImageUploadUrl:_context +'/board/updateImageUpload.adm'
	});
	board_editor.on('dialogDefinition', function(event) {
		var dialogName = event.data.name;
		var dialogDefinition = event.data.definition;
		switch(dialogName) {
			case 'image':
				dialogDefinition.removeContents('Link');
				dialogDefinition.removeContents('advanced');
				var infoTab = dialogDefinition.getContents( 'info' )
				infoTab.remove('txtHSpace');
				infoTab.remove('txtVSpace');
				infoTab.remove('txtBorder');
				infoTab.remove('txtWidth');
				infoTab.remove('txtHeight');
				infoTab.remove('ratioLock');
				break;
		}
	});

	// 버튼 명칭 초기화
	$("#btn_reganswer").html("답변등록");
	replyFile ="RE";

	// QA상세 (질문/답변) 조회
	getSelectedBoardType3Dtl();
}

// QA상세 (질문/답변) 조회
function getSelectedBoardType3Dtl() {
	ajax({
		url:"/pbbs/getPbbs1006DocDtlList.adm",
		data:{modl_seq : _param, doc_seq : _param2},
		success:function(data) {
			// 처리상태
			if(isNotEmpty(data.tbbsDocInfMap)) {
				var map = data.tbbsDocInfMap;
				var usr_nm = map.usr_nm;
				var lgn_id = map.crtr_id;
				var crt_dttm = map.f_crt_dttm;
				var titl = map.titl;
				var cts = map.cts;
				var proc_cd = map.treatment_cd;
				if(isEmpty(usr_nm)) usr_nm = "-";
				if(isEmpty(lgn_id)) lgn_id = "-";
				$("#title").text(titl);
				$("#usr_nm").text(usr_nm);
				$("#lgn_id").text(lgn_id);
				board_qcts_editor.instances['q_cts'].setData(cts);

				$("#cke_1_top").hide();
				$("#cke_1_bottom").hide();
				$("#crt_dttm").text(crt_dttm);
				$("#proc_cd").val(proc_cd);
				makeReFileList(data.tbbsFlInfMapList);  //답변용파일 목록
				makeQueFileList(data.tbbsFlInfMapList); // 질문용파일목록

				if(isNotEmpty(data.tbbsCmtMap)) {
		            var replyCts =data.tbbsCmtMap.cts;
					board_editor.instances['cts'].setData(replyCts);
					replyFlag = true;
					$("#btnFileAdd").hide();
					$("#btnFileDelete").hide();
					$("#btnAttachFile").hide();
					$("#btn_reganswer").hide();
					$("#divAttachArea").hide();
					$("#cts").prop("disabled", true);
					//disabled="disabled"
				}else{
					$("#btnFileAdd").css("display", "inline-block");
					$("#btnFileDelete").css("display", "inline-block");
					$("#btnAttachFile").show();
					$("#btn_reganswer").show();
					$("#divAttachArea").show();
					$("#cts").prop("disabled", false);
				}
			}else {
				alert("해당하는 게시글이 존재하지 않습니다. 다시 조회해주세요.");
			}


		}
	});
}

//답변등록시 등록한 첨부파일
function makeReFileList(flList){
	var flTotSize = 0;
	if(flList.length > 0) {

		var fileInfo ="";
		for(var i = 0; i < flList.length; i++) {
			var flSeq = flList[i].FL_SEQ;
			var srcFlNm = flList[i].ORI_FL_NM;
			var flSize = parseInt(flList[i].FL_SIZE, 10);
			var uplFlNm = flList[i].UPL_FL_NM;
			var flExt = flList[i].FL_EXT;
			var thumbYn = flList[i].THUMB_YN;
		    var uplTrgTp = flList[i].UPL_TRG_TP;

			if(thumbYn == "Y") continue;
			if(uplTrgTp != "RE") continue;
			var fileDownload = "";
			fileDownload = "<a href =\"#\" onclick=\"javascript:fileDown('"+flSeq+"');\">" +srcFlNm+"</a>";
			var fileTag = "<div id='fileBox" + filesSeq + "' class='fileBox'><p class='text-small'>" + fileDownload + "</p>";
				fileTag += "<ul>";
				fileTag += "<li><span class='screen_out'>용량</span>" + formatBytes(flSize, 2) + "</li>";
				//fileTag += "<li><input type='checkbox' id='fileChk" + filesSeq + "' name='fileChk' value='" + flSeq + "'><label for='fileChk" + filesSeq + "'>선택</label></li>";
				fileTag += "<input type='hidden' id='fileNm" + filesSeq + "' value='" + srcFlNm + "' />"
				fileTag += "<input type='hidden' id='filePath" + filesSeq + "' value='" + uplFlNm + "' />"
				fileTag += "<input type='hidden' id='fileExt" + filesSeq + "' value='" + flExt + "' />"
				fileTag += "<input type='hidden' id='fileSize" + filesSeq + "' value='" + flSize + "' />"
				fileTag += "</ul>";
				fileTag += "</div>";
				fileInfo += fileTag;
				flTotSize += flSize;
			filesSeq++;
		}
	}
	if(filesSeq>0){
		$("#fileList").show();
		$("#fileList").append(fileInfo);
		var flCnt = $(".fileBox").length;
		$("#fileCount").html("<em>" + (filesSeq-1) + "</em>개 (" + formatBytes(flTotSize, 2) + " / 21.00 MB)");
	}

}

//질문자 첨부파일
function makeQueFileList(flList){
	var flQaTotSize = 0;
	if(flList.length > 0) {
		var filesQaSeq = 0;
		var fileQaInfo ="";

		for(var i = 0; i < flList.length; i++) {
			var flSeq = flList[i].FL_SEQ;
			var srcFlNm = flList[i].ORI_FL_NM;
			var flSize = parseInt(flList[i].FL_SIZE, 10);
			var uplFlNm = flList[i].UPL_FL_NM;
			var flExt = flList[i].FL_EXT;
			var thumbYn = flList[i].THUMB_YN;
		    var uplTrgTp = flList[i].UPL_TRG_TP;
		    console.log(uplTrgTp);

			if(thumbYn == "Y") continue;
			if(uplTrgTp == "RE") continue;
			//if(uplTrgTp != "RE")
			var fileDownload = "";
			fileDownload = "<a href =\"#\" onclick=\"javascript:fileDown('"+flSeq+"');\">" +srcFlNm+"</a>";
			var fileTag = "<div id='fileBox" + filesSeq + "' class='fileBox'><p class='text-small'>" + fileDownload + "</p>";
				fileTag += "<ul>";
				fileTag += "<li><span class='screen_out'>용량</span>" + formatBytes(flSize, 2) + "</li>";
				fileTag += "<input type='hidden' id='fileNm" + filesSeq + "' value='" + srcFlNm + "' />"
				fileTag += "<input type='hidden' id='filePath" + filesSeq + "' value='" + uplFlNm + "' />"
				fileTag += "<input type='hidden' id='fileExt" + filesSeq + "' value='" + flExt + "' />"
				fileTag += "<input type='hidden' id='fileSize" + filesSeq + "' value='" + flSize + "' />"
				fileTag += "</ul>";
				fileTag += "</div>";
				fileQaInfo += fileTag;
				filesQaSeq++;
				flQaTotSize += flSize;
		}
	}

	if(filesQaSeq>0){
		$("#fileQaList").show();
		$("#fileQaList").append(fileQaInfo);
		$("#fileQaCount").html("<em>" + filesQaSeq + "</em>개 (" + formatBytes(flQaTotSize, 2) + " / 21.00 MB)");
	}
}


// 입력 유효성 체크
function validChk() {
	var retVal = true;
	var cts = board_editor.instances['cts'].getData();
	if(isEmpty(cts)) {
		alert("답변 내용을 입력해 주세요.");
		board_editor.instances.cts.focus();
		retVal = false;
	}
	return retVal;
}

// 쓰기 서브밋
function submitFormWrite() {
	if(!validChk()) return false;
	var confMsg = "답변을 내용을 등록하시겠습니까?";
	if(!isEmpty(chkCmtSeq)) confMsg = "답변을 내용을 수정하시겠습니까?";
	if(!confirm(confMsg)) return false;

	$("#frm_write").submit();
}
</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
		<h1><%=_title %></h1>
			<table class="tblType1" id="docQuestion">
				<colgroup>
					<col width="10%" />
					<col width="12%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="15%" />
					<col width="*" />
				</colgroup>
				<tr>
					<th>점</th>
					<td  id="crt_dttm"></td>
					<th>부서명</th>
					<td  id="crt_dttm"></td>
					<th>사번</th>
					<td  id="lgn_id"></td>
					<th>성명</th>
					<td  id="usr_nm" colspan="2"></td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="5" id="title"></td>
					<th>작성일</th>
					<td id="crt_dttm" colspan="2"></td>
				</tr>
				<tr>
					<th>질문내용</th>
					<td colspan="8"><div class="editor" id="que_cts">
					<textarea id="q_cts" disabled="disabled" style="display:none;"></textarea></div></td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td colspan="8">
						<div class="board_writeFiles type_question">
							<div class="info">
								<p class="text-small">첨부파일 <span id="fileQaCount"><em>0</em>개 (0 MB / 21.00 MB)</span></p>
							</div>
							<div class="list" id="fileQaList" style="display:none;"></div>
						</div>
					</td>
				</tr>
			</table>
			<!-- Grid form -->
			<form name="search" id="search" onsubmit="return false">
				<input type="hidden" name="modl_seq" id="modl_seq"/>
				<input type="hidden" name="doc_seq" id="doc_seq"/>
				<input type="hidden" name="f" id="doc_seq"/>
			</form>
			<div class="table_bottom  answerinfo">
				<div class="tableBtnWrap">
					<p class="tableTitle">[질문답변형게시판] 답변입력창</p>
				</div>
				<table class="tblType1">
					<colgroup>
						<col width="10%" />
						<col width="12%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tr>
						<th>점</th>
						<td  id="cstr_nm"></td>
						<th>부서명</th>
						<td  id="org_nm"></td>
						<th>사번</th>
						<td  id="usr_id"></td>
						<th>성명</th>
						<td  id="usr_nm"></td>
						<th>답변작성일</th>
						<td  id=""></td>
					</tr>
					<tr>
						<td colspan="10" class="editorTd"> 
							<form name="frm_write" id="frm_write" enctype="multipart/form-data" method="post" onsubmit="return false;">
								<div class="editor"><textarea name="cts" id="cts"></textarea></div>
							</form>
							<div class="board_writeFiles">
								<div class="form" id="divAttachArea" style="display:none;">
									<p>파일 첨부를 클릭하세요.</p>
									<button style="display:none;" id="btnAttachFile">파일첨부</button>
									<p>*문서 첨부 제한 : 21.00MB (허용 확장자 *.*)</p>
								</div>
								<div class="info">
									<p class="text-small">첨부파일 <span id="fileCount"><em>0</em>개 (0 MB / 21.00 MB)</span></p>
									<div>
										<button style="display:none;" id="btnFileAdd">본문삽입</button>
										<button style="display:none;" id="btnFileDelete">선택삭제</button>
									</div>
								</div>
								<div class="list" id="fileList" style="display:none;"></div>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<form name="frm_file" id="frm_file" enctype="multipart/form-data" method="post" onsubmit="return false;">
				<div id="fileContainer" style="display:none;">
					<input type="file" id="files" name="files" multiple="multiple" />
				</div>
			</form>

			<div class="bottomBtnWrap nonFloating">
				<button type="button" id="btn_reganswer" class="btn_common btn_dark"  style="width:70px;display:none;">답변등록</button>
			</div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
