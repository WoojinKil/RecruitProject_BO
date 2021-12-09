<%-- 
   1. 파일명 : psys1020
   2. 파일설명: BO팝업 등록
   3. 작성일 : 2018-04-13
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">

$(document).ready(function(){
	
	// 저장 서브밋
	$("#form_popup").submit(function(e) {
		var formData = new FormData($(this)[0]);
		
		$.ajax({
			url			: _context + '/psys/savePsys1020',
			type		: 'POST',
			data		: formData,
			mimeType	: "multipart/form-data",
			contentType:  false,
			cache		: false,
			processData	: false,
			success		: function(data){
				
				data = JSON.parse(data);
				// console.log(data);
				
				if(data.result == "S")
				{
					alert("팝업이 등록되었습니다.");
					fn_List();
				}
				else
					alert('팝업 등록이 정상적으로 실행되지 않았습니다. 잠시 후 다시 시도하세요');

			}
		});
		
		e.preventDefault();
	});

	// 조회조건 : 전시기간
	setDatepicker("#sch", "_st_dt", "_ed_dt");

	// 조회조건 : 전시기간 시분초 셋팅
	initSelectNumbers();
	
	// 최초 FOCUS
	$("#pop_nm").focus();
	
    // FO/BO 구분 설정
    $("#frnt_yn").val("N");
    
	// 파일 플래그 (주석처리 & 미사용)
	// $("#new_file_yn").val("Y");
});


// 입력값 유효성 체크
function fn_validationCheck()
{
	var temp = $("#form_popup input[type='text'],textarea");
	
	// INPUT FORM CHECK
	for(var i=0 ; i < temp.length ; i++)
	{
		if(isEmpty(temp[i].value))
		{
			alert($('label[for=' + temp[i].id + ']').text() + "를 입력해주세요.");
			$("#" + temp[i].id).focus();
			return false;
		}
	}

	fn_SetDateTime(true, "sch");
	
	// 팝업 전시시작일시, 종료일시 유효성 검사
	if(!validDateChk($("#h_sch_st_dt").val(), $("#h_sch_ed_dt").val()))
		return false;

	fn_SetDateTime(false, "sch");
	
	return true;
}


// 목록 : 내부 로직 사용자 정의
function fn_List()
{
	addTabInFrame("/psys/forward.psys1018.adm", "CHG");
}

// 저장 : 내부 로직 사용자 정의
function fn_Save()
{
	if(fn_validationCheck())
	{
		if(confirm("작성내용을 저장하시겠습니까?"))
			$("#form_popup").submit();
	}

}
</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
			<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp"%>
			<form name="form_popup" id="form_popup" enctype="multipart/form-data" method="post" onsubmit="return false;">
				<input type="hidden" id="frnt_yn" name="frnt_yn" />
				<input type="hidden" id="new_file_yn" name="new_file_yn" />
				<table class="tblType1">
					<colgroup>
						<col width="15%" />
						<col width="25%" />
						<col width="*" />
					</colgroup>

					<tr>
						<th><label for="pop_nm" class="vv">팝업명</label></th>
						<td colspan="2">
							<span class="txt_pw"><input type="text" name="pop_nm" id="pop_nm" class="w70" maxlength="150"/></span>
							<div class="grid_btn">
								<!-- 
								<a class="btn_common btn_darkGray" id="btn_mainpop_add">등록</a>
								<a class="btn_common btn_darkGray" id="btn_mainpop_preview">미리보기</a>
								 -->
							</div>
						</td>
					</tr>
					<tr>
						<th><label for="top_txt" class="vv">상단문구</label></th>
						<td colspan="2"><span class="txt_pw"><input type="text" name="top_txt" id="top_txt" class="w100" maxlength="25"/></span></td>
					</tr>
					<tr>
						<th><label for="mid_txt" class="vv">중단문구</label></th>
						<td colspan="2"><span class="txt_pw"><textarea name="mid_txt" id="mid_txt" class="textarea w100 h80" maxlength="50"></textarea></span></td>
					</tr>
					<tr>
						<th><label for="btm_txt" class="vv">하단문구</label></th>
						<td colspan="2"><span class="txt_pw"><textarea name="btm_txt" id="btm_txt" class="textarea w100 h80"></textarea></span></td>
					</tr>
					<tr>
						<th><label for="pop_tp_cd" class="vv">팝업유형</label></th>
						<td>
							<div class="radio">
								<span>
									<input name="pop_tp_cd" id="pop_tp_cd_01" type="radio" value="01"><label for="pop_tp_cd_01">팝업크기(대)</label></span>
									<span><input name="pop_tp_cd" id="pop_tp_cd_02" type="radio" value="02" checked><label for="pop_tp_cd_02">팝업크기(소)</label></span>
							</div>
						</td>
						<td>
							<p>
								<b class="required">*(대) - </b>가로 : <b>500px</b>&nbsp;&nbsp;세로 : <b>700px</b>
							</p>
							<p>
								<b class="required">*(소) - </b>가로 : <b>500px</b>&nbsp;&nbsp;세로 : <b>400px</b>
							</p>
						</td>
					</tr>
					<tr>
						<th><label for="bkg_tp_cd" class="vv">팝업배경</label></th>
						<td>
							<div class="radio">
								<span>
								<input name="bkg_tp_cd" id="bkg_tp_cd_01" type="radio" value="01"><label for="bkg_tp_cd_01">파랑(패턴)</label></span>
								<span><input name="bkg_tp_cd" id="bkg_tp_cd_02" type="radio" value="02" checked><label for="bkg_tp_cd_02">노랑</label></span>
								<span><input name="bkg_tp_cd" id="bkg_tp_cd_03" type="radio" value="03" checked><label for="bkg_tp_cd_03">파랑(이미지)</label></span>
							</div>
						</td>
						<td></td>
					</tr>
					<tr>
						<th><label for="dsply_yn" class="vv">전시여부</label></th>
						<td colspan="2">
							<div class="radio">
								<span><input name="dsply_yn" id="dsp_y" type="radio" value="Y"><label for="dsp_y">전시</label></span> <span><input name="dsply_yn"
									id="dsp_n" type="radio" value="N" checked><label for="dsp_n">비전시</label></span>
							</div>
						</td>
					</tr>

					<!-- 
					<tr>
						<th><label for="fileTxt" class="vv">팝업 이미지 파일</label></th>
						<td>
							<span class="fileAdd w100">
								<input id="fileTxt" type="text" class="w60" value="" placeholder="선택된 파일 없음" readonly>
								<input type="button" value="파일첨부" class="btn_common btn_blue" onclick="javascript:document.getElementById('img_files').click();">
								<input id="img_files" type="file" style='visibility:hidden;' name="img_files" onchange="ChangeText(this, 'fileTxt');" accept=".jpg, .jpeg, .bmp, .gif, .png"/>
							</span>
						</td>
						<td><p><b class="required">*허용확장자 :</b> .jpg, .jpeg, .png, .gif, .bmp,</p></td>
					</tr>
					-->

					<tr>
						<th><label for="sch_st_dt" class="vv">전시시작일시</label></th>
						<td colspan="2">
							<span class="txt_pw">
								<input type="text" id="sch_st_dt" />
								<select id="_st_dt_hh" class="select"></select> :
								<select id="_st_dt_mm" class="select"></select> : 
								<select id="_st_dt_ss" class="select"></select>
							</span>
							<input type="hidden" id="h_sch_st_dt" name="sch_st_dt" />
						</td>
					</tr>
					<tr>
						<th><label for="sch_ed_dt" class="vv">전시종료일시</label></th>
						<td colspan="2">
							<span class="txt_pw">
								<input type="text" id="sch_ed_dt" />
								<select id="_ed_dt_hh" class="select"></select> :
								<select	id="_ed_dt_mm" class="select"></select> : 
								<select id="_ed_dt_ss" class="select"></select>
							</span>
							<input type="hidden" id="h_sch_ed_dt" name="sch_ed_dt" />
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>