<%-- 
   1. 파일명 : pbbs1014
   2. 파일설명: 채용공고 상세 및 수정
   3. 작성일 : 2018-04-17
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var rcrt_seq = _param;
var board_editor;
var isInputChanged = false;

$(document).ready(function() {
	// 콤보 공통 코드 호출
	var mst_cd_str_arr = "RCRT_GB,CLS_GB,COM0001";
	getCommonCodeNm(mst_cd_str_arr, function callBackFunc(data) {
		for(var i in data) {
			if(data[i].MST_CD == "RCRT_GB") {
				$("#rcrt_gb").append("<option value='" + data[i].CD + "'>" + data[i].CD_NM + "</option>");	
			}else if(data[i].MST_CD == "CLS_GB") {
				$("#cls_gb").append("<option value='" + data[i].CD + "'>" + data[i].CD_NM + "</option>");	
			}else if(data[i].MST_CD == "COM0001") {
				$("#dsply_yn").append("<option value='" + setYnValue(data[i].CD) + "'>" + data[i].CD_NM + "</option>");	
			}
		}
	});
	
	// 수정 버튼 클릭 시
	$("#btn_mainpop_add").click(function() {
		if(validChk()) {
			if(isInputChanged) {
				alert("미리보기를 진행해주세요.");
				return;
			}
			if(!confirm("작성내용을 저장하시겠습니까?")) {
				return false;
			}else {
				$("#frm_modify").submit();
			}
		}
	});
	
	// 목록 버튼 클릭 시
	$("#btn_mainpop_list").click(function() {
		addTabInFrame("/pbbs/forward.pbbs1013.adm", "CHG");
	});
	
	// 미리보기 버튼 클릭 시
	$("#btn_mainpop_preview").click(function() {
		popup({url:"/pbbs/pbbs1013p01Vw.adm"
			 , winname:"recruit_preview"
			 , title:"채용공고 미리보기"
			 , width:"1100"
			 , height:"530"
			 , scrollbars:false
			 , autoresize:false
		});
	});
	
	// 쓰기 서브밋
	$("#frm_modify").submit(function(e) {
		// 파라미터 셋팅
		var cts = board_editor.instances['cts'].getData();
		$("#cts").val(cts);
		var formData = new FormData($(this)[0]);
		formData.append("chg_flag", "UPDATE");
		formData.append("rcrt_seq", rcrt_seq);
		
		// 채용공고 수정
		$.ajax({
			url:_context + '/pbbs/savePbbs1013RcrInf',
			type:'POST',
			data:formData,
			mimeType:"multipart/form-data",
			contentType:false,
			cache:false,
			processData:false,
			success:function(data) {
				var json = eval('('+data+')');
				if(_boolean_success == json.RESULT) {
					alert("수정되었습니다.");
					window.location.reload();
					addTabInFrame("/pbbs/forward.pbbs1013.adm", "CHG");
				} else {
					alert('작업이 정상적으로 실행되지 않았습니다. 잠시후 다시 시도하세요');
				}
			} 
		});
		e.preventDefault();
	});
	
	// 마감구분 변경 시
	$('#cls_gb').change(function() {
		if($(this).val() == '1') {
			$('#cls_dt').val("");
			$('#cls_dt').attr("disabled", true);
			$('#cls_dt_lb').removeClass("vv");	
		}else {
			$('#cls_dt').attr("disabled", false);
			$('#cls_dt_lb').addClass("vv");
		}
	});
	
	// 입력폼 변경 시
	$("input, select, textarea").change(function() {
		isInputChanged = true;
	});
	
	// 초기화
	doInit();
});

// 초기화
function doInit() {
	// CKEDITOR 세팅
	board_editor = CKEDITOR;
	board_editor.replace('cts', {
		width:'100%',
		height:'325px',
		draggable:false,
		filebrowserImageUploadUrl:_context +'/board/updateImageUpload.adm',
		allowedContent:true,
		on:{
			change: function() {
				isInputChanged = true;
			}
		}
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
	
	// 마감일자 초기화
	$('#cls_dt').datepicker({
		changeMonth: true,
		changeYear: true,
		showMonthAfterYear: true,
		dateFormat: "yy-mm-dd",
		monthNames: ['01','02','03','04','05','06','07','08','09','10','11','12'],
        monthNamesShort: ['01','02','03','04','05','06','07','08','09','10','11','12'],
        changeMonth: true
	});
	$('#cls_dt').val("");
	$('#cls_dt').attr("disabled", true);
	
	// 채용공고 상세 조회
	ajax({
		url:"/pbbs/getPbbs1013RcrInf.adm",
		data:{rcrt_seq:rcrt_seq},
		success:function(data) {
			var map = data.tbbsRcrInfMap;
			$("#rcrt_gb").val(map.rcrt_gb);
			$("#titl").val(map.titl);
			$("#cls_gb").val(map.cls_gb);
			$("#cls_dt").val(map.cls_dt);
			$("#cts").val(map.cts);
			$("#dsply_yn").val(map.dsply_yn);
			if(map.cls_gb == '1') {
				$('#cls_dt').val("");
				$('#cls_dt').attr("disabled", true);
				$('#cls_dt_lb').removeClass("vv");
			}else {
				$('#cls_dt').attr("disabled", false);
				$('#cls_dt_lb').addClass("vv");
			}
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
	$('input[type="text"]').each(function() {
		var id = $(this).attr("id");
		var value = $(this).val();
		// 필수체크
		if(isEmpty(value)) {
			var label = $('label');
			for(i=0; i<label.length; i++) {
				if($(label[i]).attr("for") == id && $(label[i]).hasClass("vv")) {
					validFlag = false;
					alert($(label[i]).text()+"를 입력해주세요");
					$("#"+id).focus();
					validFlag = false;
			        return false;
				}
			}
		} 
	});
	
	if (!validFlag) return validFlag;
	
	// 2. Data Byte 체크
	$("input[data-byte]").each(function(index, item) {
		var maxByte = $(item).data("byte");
		var target  = "#" + $(item).attr("id");
		var title   = $(item).attr("title");
		if(byteCheck($(target)) > maxByte) {
	        alert(title + "은(는) " + maxByte + "자를 넘을 수 없습니다.");
	        validFlag = false;
	        return false;
	    }
	});
	
	return validFlag;
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
						<col width="14%" />
						<col width="35%" />
					</colgroup>
					<tr>
						<th><label for="titl" class="vv">제목</label></th>
						<td colspan="2">
							<span class="txt_pw"><input type="text" name="titl" id="titl" class="w100" data-byte="100" title="제목"/></span>
						</td>
						<td>
							<div class="grid_btn" id="btn_info">
								<button type="button" class="btn_common btn_default" id="btn_mainpop_preview" style="margin-right: 10px;">미리보기</button>
								<button type="button" class="btn_common btn_default" id="btn_mainpop_list" style="margin-right: 10px;">목록</button>
								<button type="button" class="btn_common btn_default" id="btn_mainpop_add" style="margin-right: 10px;">수정</button>		
							</div>					
						</td>
					</tr>
					<tr>
						<th><label for="rcrt_gb" class="vv">채용구분</label></th>
						<td><select id="rcrt_gb" name="rcrt_gb" class="select"></select></td>
						<th><label for="title" class="vv">전시여부</label></th>
						<td><select id="dsply_yn" name="dsply_yn" class="select"></select></td>
					</tr>
					<tr>
						<th><label for="cls_gb" class="vv">마감구분</label></th>
						<td><select id="cls_gb" name="cls_gb" class="select" class="w100"></select></td>
						<th><label for="cls_dt" id="cls_dt_lb">마감일</label></th>
						<td>
							<span class="txt_pw"><input type="text" name="cls_dt" id="cls_dt" class="w100" maxlength="6" readonly/></span>
						</td>
				    </tr>
					<tr>
						<td colspan="4">
							<div class="editor"><p style="font-size:30px;text-align:center;padding:10px 10px;"><textarea name="cts" id="cts"></textarea></p></div>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>