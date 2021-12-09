<%--
   1. 파일명  : pdsp1002
   2. 파일설명: 메뉴상세정보
   3. 작성일  : 2018-03-28
   4. 작성자  : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var tmpl_seq = '<%=parameterMap.getValue("_param")%>';
var mnu_seq  = '<%=parameterMap.getValue("_mnu_seq")%>';

$(document).ready(function(){
	$("#btn_template_mod").click(function() {
		if(validChk($("#templateInfo"))) {
			$("#templateInfo").submit();
		}
	});

	$("#btn_template_list").click(function() {
		addTabInFrame("/pdsp/forward.pdsp1001.adm", "CHG");
	});

	// form submit process
	$("#templateInfo").submit(function(e) {
		var formData = new FormData($(this)[0]);
		var us_yn = $("input[type=radio][name=us_yn]:checked").val();
		formData.append("dsply_yn", us_yn);
		formData.append("tmpl_seq", tmpl_seq);
		$.ajax({
			url: _context + '/pdsp/updatePdsp1002.adm',
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
					alert("일시적 오류입니다\n잠시후 다시 시도하세요.")
				}
			},
		});
		e.preventDefault(); //Prevent Default action.
	});
	
	doInit();
});

function doInit(){
	if(!isEmpty(tmpl_seq)) {
		// 팝업 상세정보 조회
		ajax({
			url : "/pdsp/getPdsp1002List.adm",
			data: {tmpl_seq : tmpl_seq},
			success: function(data) {
				
				// 상세 정보 설정
				var mainPop = data.mainPopMap;
				if(!isEmpty(data.templateMap)) {
					
					$("#tmpl_nm").val(data.templateMap.TMPL_NM);
					$("#tmpl_tp_cd").val(data.templateMap.TMPL_TP_CD);
					$("#tmpl_url").val(data.templateMap.TMPL_URL);
					if(data.templateMap.US_YN == "Y" && data.templateMap.DSPLY_YN =="Y") {
						$("input[name='us_yn']:radio[value='Y']").attr('checked',true)
					}
					$("input[name='lgn_esn_yn']:radio[value='"+data.templateMap.LGN_ESN_YN+"']").attr('checked',true);
					$("#tmpl_dtl_nm").val(data.templateMap.TMPL_DTL_NM);
				}
				
			},
		});
	}else {
		alert("해당 템플릿 정보가 없습니다.\n목록을 재조회 후 다시 선택해주세요.");
		var parentTabId = 'tab-'+mnu_seq;
		var tabs = $("#"+parentTabId, parent.document)[0].parentElement;
		$(tabs).find("li[aria-controls="+parentTabId+"]").find('span.tab_close_ico').trigger('click');
	}	
}
function changeTmpType(obj) {
	var type= $(obj).val();
	if(type == "4" || type == "6") {
		$("#tmpl_url").val("/module/board/boardTypeList.adm");
		$("#tmpl_url").attr("readonly", true);
	} else {
		$("#tmpl_url").val("");
		$("#tmpl_url").attr("readonly", false);
	}
}

</script>
</head>
<body>
<div class="frameWrap">
		<div class="subCon">
			<div class="subConTit">
				<h1><%=_title %></h1>
			</div>
			<form name="templateInfo" id="templateInfo" enctype="multipart/form-data" method="post" submit="return false;">
			<table class="tblType3">
				<tr>
					<td>
						<div class="grid_btn">
							<a href="#" class="btn_common btn_default" id="btn_template_list">목록</a>
							<a href="#" class="btn_common btn_default" id="btn_template_mod">수정</a>
						</div>
					</td>
				</tr>
			</table>
			<table class="tblType1">
				<colgroup>
					<col width="15%" />
					<col width="35%" />
					<col width="15%" />
					<col width="35%" />
				</colgroup>
				<tr>
					<th><label for="tmpl_nm" class="vv">메뉴명</label></th>
					<td colspan="3"><span class="txt_pw"><input type="text" class="w85" id="tmpl_nm" name="tmpl_nm" data-maxbyte="50" title="메뉴명"/></span></td>
				</tr>
				<tr>
					<th><label for="tmpl_tp_cd" class="vv">메뉴유형</label></th>
					<td><%=CodeUtil.getSelectComboList("TMP_TYPE", "tmpl_tp_cd", "", "", "", "class=\"select\" onchange=\"changeTmpType(this)\"")%></td>
				</tr>
				<tr>
					<th><label for="tmpl_url"> 메뉴URL</label></th>
					<td colspan="3"><span class="txt_pw"><input type="text" class="w85" id="tmpl_url" name="tmpl_url" data-maxbyte="200" title="매뉴URL"/></span></td>
				</tr>
				<tr>
					<th><label for="us_yn" class="vv">사용여부</label></th>
					<td>
						<div class="radio">
						<span><input name="us_yn" id="us_yn_y" type="radio" value="Y"><label for="us_yn_y">사용</label></span>
						<span><input name="us_yn" id="us_yn_n" type="radio" value="N" checked><label for="us_yn_n">미사용</label></span>
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
					<td colspan="3"><textarea id="tmpl_dtl_nm" name="tmpl_dtl_nm" class="textarea w85 h80" placeholder="" data-maxbyte="200" title="메뉴설명"></textarea></td>
				</tr>
			</table>

			</form>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
