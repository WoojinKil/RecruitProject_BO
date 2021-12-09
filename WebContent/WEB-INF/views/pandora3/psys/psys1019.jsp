<%-- 
   1. 파일명 : psys1019
   2. 파일설명: BO팝업 상세관리
   3. 작성일 : 2018-04-13
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3Front/js/common/jquery.bpopup.min.js"></script>
<style>
.new_img{display:none;}
.layer_popup {background-color:#fff;border-radius:0;border:1px solid #000;color:#000;display:none;padding:0px;min-width:400px;min-height: 180px}
.layer_popup .btn_close{cursor:pointer;position:absolute;right:10px;top:5px}
</style>
<script type="text/javascript">

var b_popup;

$(document).ready(function(){
	
	// 삭제 버튼 클릭
	$("#btn_popimg_del").click(function(){
		$(".org_img").hide();
		$(".new_img").show();
	});
	
	// 목록 버튼 클릭
	$("#btn_mainpop_list").click(function(){
		addTabInFrame("/psys/forward.psys1018.adm", "CHG");
	});
	
	// 수정 버튼 클릭
	$("#btn_mainpop_mod").click(function(){

		if(fn_validationCheck())
		{
			if(confirm("작성내용을 저장하시겠습니까?"))
				$("#form_popup").submit();
		}
	});
	
	// 수정 서브밋
	$("#form_popup").submit(function(e) {
		var formData = new FormData($(this)[0]);
		
		$.ajax({
			url			: _context + '/psys/savePsys1019',
			type		: 'POST',
			data		: formData,
			mimeType	: "multipart/form-data",
			contentType	: false,
			cache		: false,
			processData	: false,
			success		: function(data){
				
				data = JSON.parse(data);
				// console.log(data);
				
				if(data.result == "S")
				{
					alert("팝업이 수정되었습니다.");
					addTabInFrame("/psys/forward.psys1018.adm", "CHG");
				}
				else
				{
					alert('팝업 수정이 정상적으로 실행되지 않았습니다. 잠시후 다시 시도하세요');
				}
			} 
		});
		e.preventDefault();
	});
	
	$("#close").on("click", function() {
        closePop(b_popup);
    });

	fn_init();
});

// 초기화
function fn_init()
{
	// 조회조건 : 전시기간
	setDatepicker("#sch", "_st_dt", "_ed_dt");

	// 조회조건 : 전시기간 시분초 셋팅
	initSelectNumbers();
	
	// 최초 FOCUS
	$("#pop_nm").focus();
	
	// 파일 플래그 (주석처리 & 미사용)
	// $("#new_file_yn").val("Y");
	
	// 수정 플래그 설정
	$("#upd_yn").val("Y");
		
    // FO/BO 구분 설정
    $("#frnt_yn").val("N");
    
	// 팝업 상세정보 조회
	ajax({
		url		: "/psys/getPsys1019.adm",
		data	: {mn_pop_seq : _param},
		success	: function(data){

			// 상세 정보 설정
			if(isNotEmpty(data.popInfo))
			{
				var pop = data.popInfo;
				
				$("#mn_pop_seq").val(pop.MN_POP_SEQ);
				$("#pop_nm").val(pop.POP_NM);
				$("#top_txt").val(pop.TOP_TXT);
				$("#mid_txt").val(pop.MID_TXT);
				$("#btm_txt").val(pop.BTM_TXT);
				$("input[name='pop_tp_cd']:radio[value='" + pop.POP_TP_CD + "']").prop("checked",true);
				$("input[name='bkg_tp_cd']:radio[value='" + pop.BKG_TP_CD + "']").prop("checked",true);
				$("input[name='dsply_yn']:radio[value='" + pop.DSPLY_YN + "']").attr("checked",true);
				$("#sch_st_dt").val(pop.ST_DTTM.substring(0, 4) + "-" + pop.ST_DTTM.substring(4, 6) + "-" + pop.ST_DTTM.substring(6, 8));
				$("#_st_dt_hh").val(pop.ST_DTTM.substring(8, 10));
				$("#_st_dt_mm").val(pop.ST_DTTM.substring(10, 12));
				$("#_st_dt_ss").val(pop.ST_DTTM.substring(12, 14));
				$("#sch_ed_dt").val(pop.ED_DTTM.substring(0, 4) + "-" + pop.ED_DTTM.substring(4,6) + "-" + pop.ED_DTTM.substring(6, 8));
				$("#_ed_dt_hh").val(pop.ED_DTTM.substring(8, 10));
				$("#_ed_dt_mm").val(pop.ED_DTTM.substring(10, 12));
				$("#_ed_dt_ss").val(pop.ED_DTTM.substring(12, 14));
				// $("#ognl_img_nm").text(pop.OGNL_IMG_NM);
				
				// 팝업 미리보기
				var preview = "javascript:fn_previewPopup('" + pop.IMG_PTH + "');";
				
				$("#btn_popimg_preview").attr("href", preview);
			}
			else
			{
				alert("해당 팝업정보가 존재하지 않습니다. 다시 조회해주세요.");
			}
		}
	});
}

//입력값 유효성 체크
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


// 팝업 미리보기
function fn_previewPopup(img_path)
{
	var popImgUrl = _filePreFix + img_path;
	var popOption = null;
	var type = $(":input:radio[name=type]:checked").val();
	
	//type : - 01 : 대, 02 : 소
	if(type == '01')
	{
		popOption = {width:"545", height:"900"};
	}
	else if(type == '02')
	{
		popOption = {width:"545", height:"590"};
	}
	
	var $layer_popup1	= $('<div class="layer_popup"></div>');
    var $layer_close	= $('<a href="#" class="btn_close">x</a>');
    var $layer_img		= $('<div><img alt="" src="'+popImgUrl+'" style="width:100%;"></div>');
    var $layer_no_see	= $('<p id="bottom_bar" style="text-align:right; background-color:black; margin-top:0px; height:40px; line-height:40px; vertical-align:middle;">'
						+ '<input type="checkbox" id="close" readonly />'
						+ '<label style = "color:white; padding-right:20px;">오늘 하루 동안 열지 않음</label>'
						+ '</p>');
    $("body").append($layer_popup1);
    $layer_popup1.append($layer_close);
    $layer_popup1.append($layer_img);
    $layer_popup1.append($layer_no_see);
    $(".layer_popup").css(popOption);
    
    b_popup = $(".layer_popup").bPopup({
        opacity: 0,
        closeClass : "btn_close",
        position: ['50%', '50%']
    });
    
    $(".layer_popup").draggable();
}

function closePop(b_popup)
{
    b_popup.close();
}

</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
			<div class="subConTit">
				<h1><%=_title%></h1>
			</div>
			<div class="pageBtnWrap">
				<div class="grid_btn">
					<a class="btn_common btn_default" id="btn_mainpop_list">목록</a>
					<a class="btn_common btn_default" id="btn_mainpop_mod">수정</a>
					<!-- 
					<a class="btn_common btn_darkGray" id="btn_mainpop_preview">미리보기</a>
					-->
				</div>
			</div>
			<form name="form_popup" id="form_popup" enctype="multipart/form-data" method="post" onsubmit="return false;">
				<input type="hidden" name="mn_pop_seq" id="mn_pop_seq" />
				<input type="hidden" id="frnt_yn" name="frnt_yn" />
				<input type="hidden" name="upd_yn" id="upd_yn" />
				<input type="hidden" name="new_file_yn" id="new_file_yn" />
				
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
								<span><input name="pop_tp_cd" id="pop_tp_cd_01" type="radio" value="01"><label for="pop_tp_cd_01">팝업크기(대)</label></span>
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
						<td colspan="2">
							<div class="radio">
								<span><input name="bkg_tp_cd" id="bkg_tp_cd_01" type="radio" value="01" checked><label for="bkg_tp_cd_01">파랑(패턴)</label></span> <span><input
									name="bkg_tp_cd" id="bkg_tp_cd_02" type="radio" value="02"><label for="bkg_tp_cd_02">노랑</label></span> <span><input name="bkg_tp_cd"
									id="bkg_tp_cd_03" type="radio" value="03"><label for="bkg_tp_cd_03">파랑(이미지)</label></span>
							</div>
						</td>
					</tr>
					<tr>
						<th><label for="dsply_yn" class="vv">전시여부</label></th>
						<td colspan="2">
							<div class="radio">
								<span><input name="dsply_yn" id="display_y" type="radio" value="Y"><label for="display_y">전시</label></span> <span><input
									name="dsply_yn" id="display_n" type="radio" value="N" checked><label for="display_n">비전시</label></span>
							</div>
						</td>
					</tr>
					<!-- 
					<tr>
						<th><label for="fileTxt" class="vv">팝업 이미지 파일</label></th>
						<td class="org_img">
							<p><b id="ognl_img_nm" style="height:26px;font-size:13px"></b></p>
						</td>
						<td class="org_img">
							<button type="button" class="btn_common btn_darkGray" id="btn_popimg_del">삭제</button>
							<a href="#" type="button" class="btn_common btn_darkGray" id="btn_popimg_preview">미리보기</button>
						</td>
						<td class="org_img"></td>
						<td class="new_img" colspan="2">
							<span class="fileAdd w100">
								<input id="fileTxt" type="text" class="w70" value="" placeholder="선택된 파일 없음" readonly>
								<input type="button" value="파일첨부" class="btn_common btn_blue" onclick="javascript:document.getElementById('img_files').click();">
								<input id="img_files" type="file" style='visibility:hidden;' name="img_files" onchange="ChangeText(this, 'fileTxt');" accept=".jpg, .jpeg, .bmp, .gif, .png"/>
							</span>
						</td>
						<td class="new_img">
							<p><b class="required">*허용확장자 :</b> .jpg, .jpeg, .png, .gif, .bmp</p>
						</td>
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
