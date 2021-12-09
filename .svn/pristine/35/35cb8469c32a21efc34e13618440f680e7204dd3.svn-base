<%--
   1. 파일명  : pdsp1003
   2. 파일설명: 메뉴추가
   3. 작성일  : 2018-03-28
   4. 작성자  : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">

$(document).ready(function(){

	$("#templateInfo").submit(function(e) {
		var formData = new FormData($(this)[0]);
		formData.append("dsply_yn", "N");
		$.ajax({
			url: _context + '/pdsp/insertPdsp1003.adm',
			type: 'POST',
			data: formData,
			mimeType:"multipart/form-data",
			contentType: false,
			cache: false,
			processData:false,
			success: function(data) {
				data = JSON.parse(data);
				if(data.RESULT == "S") {
					alert('저장되었습니다');
					addTabInFrame("/pdsp/forward.pdsp1001.adm");
				} else {
					alert('일시적 오류입니다\n잠시후 다시 시도하세요.')
				}
			},
		});
		e.preventDefault(); 
	});

});

function changeTmpType(obj) {
	var type= $(obj).val();
	
	if(type == "4" || type == "6") {	// 4:2층게시판메뉴, 6:3층게시판메뉴
		$("#tmpl_url").val("/module/board/boardTypeList.adm");
		$("#tmpl_url").attr("readonly", true);
	} else {
		$("#tmpl_url").val("");
		$("#tmpl_url").attr("readonly", false);
	}
}
//목록: 내부 로직 사용자 정의
function fn_List() {
	addTabInFrame("/pdsp/forward.pdsp1001.adm", "CHG");
}

//저장: 내부 로직 사용자 정의
function fn_Save() {
	// 입력 값 필수 체크
	if(validChk($("#templateInfo"))){
		$("#templateInfo").submit();
	}	
}

</script>
</head>
<body>
<div class="frameWrap">
		<div class="subCon">
		<%@ include file="/WEB-INF/views/pandora3/common/include/btnList2.jsp" %>
			<form name="templateInfo" id="templateInfo" enctype="multipart/form-data" method="post" submit="return false;">
			<table class="tblType1">
				<tr>
					<th><label for="tmpl_nm" class="vv">메뉴명</label></th>
					<td colspan="3"><span class="txt_pw"><input type="text" class="w100" id="tmpl_nm" name="tmpl_nm" data-maxbyte="50" title="메뉴명"/></span></td>
				</tr>
				<tr>
					<th><label for="tmpl_tp_cd" class="vv">메뉴유형</label></th>
					<td><%=CodeUtil.getSelectComboList("TMP_TYPE", "tmpl_tp_cd", "", "", "", "class=\"select\" onchange=\"changeTmpType(this)\"")%></td>
				</tr>
				<tr>
					<th><label for="tmpl_url"> 메뉴URL</label></th>
					<td colspan="3"><span class="txt_pw"><input type="text" class="w100" id="tmpl_url" name="tmpl_url" data-maxbyte="300" title="메뉴URL"/></span></td>
				</tr>
				<tr>
					<th><label for="us_yn" class="vv">사용여부</label></th>
					<td>
						<div class="radio">
						<span><input name="us_yn" id="us_yn_y" type="radio" value="Y" checked><label for="us_yn_y">사용</label></span>
						<span><input name="us_yn" id="us_yn_n" type="radio" value="N"><label for="us_yn_n">미사용</label></span>
						</div>
					</td>
					<th><label for="lgn_esn_yn" class="vv">로그인여부</label></th>
					<td>
						<div class="radio">
						<span><input name="lgn_esn_yn" id="lgn_esn_yn_y" type="radio" value="Y"><label for="lgn_esn_yn_y">로그인 필수</label></span>
						<span><input name="lgn_esn_yn" id="lgn_esn_yn_n" type="radio" value="N" checked><label for="lgn_esn_yn_n">비로그인 허용</label></span>
						</div>
					</td>
				</tr>
				<tr>
					<th><label for="tmpl_dtl_nm"> 메뉴설명</label></th>
					<td colspan="3"><textarea id="tmpl_dtl_nm" name="tmpl_dtl_nm" class="textarea w100 h80" placeholder="" data-maxbyte="300" title="메뉴설명"></textarea></td>
				</tr>
			</table>
			</form>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
