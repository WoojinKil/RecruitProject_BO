<%-- 
   1. 파일명 : psys1016
   2. 파일설명 : 시스템로그인설정관리
   3. 작성일 : 2018-04-16
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var menu_id = '<%=parameterMap.getValue("_menu_id")%>';
$(document).ready(function(){
	// 공통코드 복수 설정
	$("#mst_cd_arr").val(new Array( 'LOGIN_PROP'));
	var mst_cd;
	ajax({
		url: '/psys/getPsysCommon',
		data : $("form[name=frm_sysCdDtl]").serialize(),
		success: function(data) {
			mst_cd=data.selectData[0].mst_cd;
			for(i=0; i<data.selectData.length; i++) {
				mst_cd = data.selectData[0].MST_CD;
				if("JOIN_TERM" == data.selectData[i].CD) {
					$("#category1").val(data.selectData[i].REF_2);
					$("#category1_dtl").text(data.selectData[i].NOTE_CONT);
				}
				else if("PW_RENEW" == data.selectData[i].CD) {
					$("#category2").val(data.selectData[i].REF_2);
					$("#category2_dtl").text(data.selectData[i].NOTE_CONT);
				}
				else if("PW_WRONG" == data.selectData[i].CD) {
					$("#category4").val(data.selectData[i].REF_2);
					$("#category4_dtl").text(data.selectData[i].NOTE_CONT);
				}
				else if("LOGIN_TERM" == data.selectData[i].CD) {
					$("#category5").val(data.selectData[i].REF_2);
					$("#category5_dtl").text(data.selectData[i].NOTE_CONT);
				}else if("PW_WRONG_YN"== data.selectData[i].CD){
					$("input[ name='mailing_yn']").filter("[value="+data.selectData[i].REF_2+"]").attr('checked',true);
				}
			}
		},
	});
	
	$("#frm_loginSetting").submit(function(e) {
		var formData = new FormData();
		formData.append("GBN"			, "BO");
		formData.append("MST_CD"		, mst_cd);
		formData.append("JOIN_TERM"		,$("#category1").val());
		formData.append("PW_RENEW"		,$("#category2").val());
		formData.append("PW_WRONG_YN"	,$('input[name="mailing_yn"]:checked').val());
		formData.append("PW_WRONG"		,$("#category4").val());
		formData.append("LOGIN_TERM"	,$("#category5").val());
		
		$.ajax({
			url: _context + '/pmbr/savePmbr1006',
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
					$("#btn_retreive").trigger('click');
				} else {
					alert("일시적 오류입니다\n잠시후 다시 시도하세요.")
				}
			},
		});
	});
	$("#btn_setting_save").click(function() {
		$("#frm_loginSetting").submit();
	});
});

</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
			<div class="subConTit no_common">
				<h1><%=_title %></h1>
			</div>
			<form name="frm_loginSetting" id="frm_loginSetting" onsubmit="return false">
				<table class="tblType1">
					<colgroup>
						<col width="16%" />
						<col width="16%" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><span id="category2_title">VIP 비밀번호갱신주기</span></th>
						<td class="txt_pw"><input type="text" id="category2" class="w70"/>&nbsp;일</td>
						<td><span id="category2_dtl"></span></td>
					</tr>
					<tr>
						<th><span id="category3_title">계정 무한대입 방지사용</span></th>
						<td colspan="2">
							<div class="radio">
								<span class="txt_pw"><input name="mailing_yn" id="mailing_y" type="radio" value="Y"><label for="mailing_y">예</label></span>
								<span class="txt_pw"><input name="mailing_yn" id="mailing_n" type="radio" value="N" checked><label for="mailing_n">아니오</label></span>
							</div>
						</td>
					</tr>
					<tr>
						<th><span id="category4_title">로그인 시도 횟수 제한</span></th>
						<td class="txt_pw"><input type="text" id="category4" class="w70"/>&nbsp;회</td>
						<td><span id="category4_dtl"></span></td>
					</tr>
					<tr>
						<th><span id="category5_title">로그인 시도 횟수 제한 시간</span></th>
						<td class="txt_pw"><input type="text" id="category5" class="w70"/>&nbsp;초</td>
						<td><span id="category5_dtl"></span></td>
					</tr>
				</table>
				<div class="bottomBtnWrap nonFloating">
	                <a href="#" class="btn_common btn_gray" id="btn_setting_save" style="">저장</a>
	            </div>
			</form>
		</div>
	</div>
	<form name="frm_sysCdDtl" id="frm_sysCdDtl" submit="return false;">
		<input type="hidden" name="mst_cd_arr" id="mst_cd_arr" />
	</form>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>