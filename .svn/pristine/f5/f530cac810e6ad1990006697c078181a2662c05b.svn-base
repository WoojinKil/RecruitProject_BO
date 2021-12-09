<%-- 
   1. 파일명 : pdsp1006
   2. 파일설명: 메인팝업 상세관리
   3. 작성일 : 2018-03-29
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/jquery.bpopup.min.js"></script>
<style>
.new_img{display:none;}
.layer_popup {background-color:#fff;border-radius:0;border:1px solid #000;color:#000;display:none;padding:0px;min-width:400px;min-height: 180px}
.layer_popup .btn_close{cursor:pointer;position:absolute;right:10px;top:5px}
</style>
<script type="text/javascript">
var newFileFlag;
var jsfunction;
var b_popup;
$(document).ready(function() {
	
	// 팝업종류코드 비활성화
	$("input[name=pop_kd_cd]").attr("disabled", "disabled");
	
	// 삭제 버튼 클릭 시
	$("#btn_popimg_del").click(function() {
		$(".org_img").hide();
		$(".new_img").show();
		newFileFlag = true;
	});
	
	// 수정버튼 클릭 시
	$("#btn_mainpop_mod").click(function() {
		formSetDateTime("disp", isNotEmpty($("#disp_st_dt").val()), isNotEmpty($("#disp_ed_dt").val()));
		$("#updateFlag").val("Y")
		$("#newFileFlag").val(newFileFlag);
		
		// 입력 값 필수 체크
		if(!validChk($("#frm_modify")))	return false;
		
		// 팝업 전시시작일시, 종료일시 유효성 검사
		var strFromDate = $("#disp_st_dt").val() + " " + $("#_st_dt_hh").val() + ":" + $("#_st_dt_mm").val() + ":" + $("#_st_dt_ss").val();
		var strToDate   = $("#disp_ed_dt").val()   + " " + $("#_ed_dt_hh").val()   + ":" + $("#_ed_dt_mm").val()   + ":" + $("#_ed_dt_ss").val();
		if(!validDateChk(strFromDate, strToDate)) return false;
		
		submitFormWrite();
	});
	
	// 목록버튼 클릭 시
	$("#btn_mainpop_list").click(function() {
		addTabInFrame("/pdsp/forward.pdsp1005.adm", "CHG");
	});
	
	// 쓰기 서브밋
	$("#frm_modify").submit(function(e) {
		var formData = new FormData($(this)[0]);
		$.ajax({
			url: _context + '/pdsp/savePdsp1006.adm',
			type: 'POST',
			data: formData,
			mimeType:"multipart/form-data",
			contentType: false,
			cache: false,
			processData:false,
			success: function(data) {
				//console.log(data);
				var json = eval('('+data+')');
				if(json.result == "S") {
					alert("팝업이 수정되었습니다.");
					addTabInFrame("/pdsp/forward.pdsp1005.adm", "CHG");
				} else {
					alert('작업이 정상적으로 실행되지 않았습니다. 잠시후 다시 시도하세요');
				}
			} 
		});
	e.preventDefault();
	});
	
	$("#colse").on("click", function() {
        closePop(b_popup);
        
    });
	
	 // 팝업 종류 radio 변경 시, form 하위요소 변경
    $("input[name=pop_kd_cd]").change(function(){
    	var popKdCd = $(this).val();
    		
    	// 10 - text popup, 20 - url popup
    	if(popKdCd == "10") {
    		$("tr[data-popup=url]").hide();
    		$("tr[data-popup=text]").show();
    		$("tr[data-popup=url] th label[for]").removeClass("vv");
    		$("tr[data-popup=text] th label[for]").addClass("vv");
    	}else if(popKdCd == "20") {
    		$("tr[data-popup=text]").hide();
    		$("tr[data-popup=url]").show();
    		$("tr[data-popup=text] th label[for]").removeClass("vv");
    		$("tr[data-popup=url] th label[for]").addClass("vv");
    	}
    });

	doInit();
	
	// byte 표시
	// @param textTarget, byteTarget, maxByte
	byteTextShow("#top_txt", "#top_txt_text", 50);
	byteTextShow("#mid_txt", "#mid_txt_text", 100);
	
});

//초기화
function doInit() {
	// 최초 FOCUS
	$("#pop_nm").focus();
	
	// 전시기간(시작일/종료일)
	setDatepicker("#disp", "_st_dt", "_ed_dt");
	initSelectNumbers();
	
	// 팝업 상세정보 조회
	ajax({
		url : "/pdsp/getPdsp1006.adm",
		data: {mn_pop_seq : _param},
		success: function(data) {
			// 상세 정보 설정
			if(isNotEmpty(data.mainPopMap)) {
				var mainPop = data.mainPopMap;
				//console.log(mainPop);
				
				$("#mn_pop_seq").val(mainPop.MN_POP_SEQ);
				$("#pop_nm").val(mainPop.POP_NM);
				$("input[name='pop_tp_cd']:radio[value='"+mainPop.POP_TP_CD+"']").prop("checked",true);
				$("input[name='dsply_yn']:radio[value='"+mainPop.DSPLY_YN+"']").attr("checked",true);
				$("#disp_st_dt").val(mainPop.ST_DTTM.substring(0,4)+"-"+mainPop.ST_DTTM.substring(4,6)+"-"+mainPop.ST_DTTM.substring(6,8));
				$("#_st_dt_hh").val(mainPop.ST_DTTM.substring(8,10));
				$("#_st_dt_mm").val(mainPop.ST_DTTM.substring(10,12));
				$("#_st_dt_ss").val(mainPop.ST_DTTM.substring(12,14));
				$("#disp_ed_dt").val(mainPop.ED_DTTM.substring(0,4)+"-"+mainPop.ED_DTTM.substring(4,6)+"-"+mainPop.ED_DTTM.substring(6,8));
				$("#_ed_dt_hh").val(mainPop.ED_DTTM.substring(8,10));
				$("#_ed_dt_mm").val(mainPop.ED_DTTM.substring(10,12));
				$("#_ed_dt_ss").val(mainPop.ED_DTTM.substring(12,14));
				$("#ognl_img_nm").text(mainPop.OGNL_IMG_NM);
				$("input[name='pop_kd_cd']:radio[value='"+mainPop.POP_KD_CD+"']").prop("checked",true).change();
				if(mainPop.POP_KD_CD == "10") {
					$("#top_txt").val(mainPop.TOP_TXT);
					$("#mid_txt").val(mainPop.MID_TXT);
					$("#btm_txt").val(mainPop.BTM_TXT);
					$("input[name='bkg_tp_cd']:radio[value='"+mainPop.BKG_TP_CD+"']").prop("checked",true);
				}else if(mainPop.POP_KD_CD == "20") {
					$("#pop_url").val(mainPop.POP_URL);
				}
				// 팝업 미리보기 만들기
				jsfunction = "javascript:callPopupPreview('"+mainPop.IMG_PTH+"');";
				$("#btn_popimg_preview").attr("href", jsfunction);
			} else {
				alert("해당 팝업정보가 존재하지 않습니다. 다시 조회해주세요.");
			}
		}
	});
}

//Form 전송용 DateTime 설정
function formSetDateTime(id, isFrom, isTo) {
	var idPrefixs = "#h_";
	var idSuffixs = ["_st_dt","_ed_dt"];
	var flagArr = new Array();
	flagArr.push(isFrom);
	flagArr.push(isTo);
	
	for(var i = 0; i < idSuffixs.length; i++) {
		if(flagArr[i]) $(idPrefixs+id+idSuffixs[i]).val($("#"+id+idSuffixs[i]).val().replace(/-/gi, "") + $("#"+idSuffixs[i]+"_hh").val() + $("#"+idSuffixs[i]+"_mm").val() + $("#"+idSuffixs[i]+"_ss").val());
		else $(idPrefixs+id+idSuffixs[i]).val("");
	}
}

// 쓰기 서브밋
function submitFormWrite() {
	if(!confirm("작성내용을 저장하시겠습니까?")) return false;
	$("#frm_modify").submit();
}

// 팝업 미리보기
function callPopupPreview(img_path) {
	var popImgUrl = _filePreFix + img_path;
	var popOption = null;
	var type = $(":input:radio[name=type]:checked").val();
	
	//type : - 01 : 대, 02 : 소
	if(type == '01') {
		popOption = {width:"545", height:"900"};
		pointX = 0;
        pointY = 10;
	} else if(type == '02') {
		popOption = {width:"545", height:"590"};
		pointX = 0;
        pointY = 10;
	}
	
	var $layer_popup1 = $('<div class="layer_popup"></div>');
    var $layer_close = $('<a href="#" class="btn_close">x</a>');
    var $layer_img = $('<div><img alt="" src="'+popImgUrl+'" style="width:100%;"></div>');
    var $layer_no_see = $('<p id="bottom_bar" style="text-align:right; background-color:black; margin-top:0px; height:40px; line-height:40px; vertical-align:middle;">'
    + '<input type="checkbox" id="colse" readonly />'
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
        position: [pointX, pointY]
    });
    $(".layer_popup").draggable();
}

function closePop(b_popup){
    b_popup.close();
}

</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
		<h1><%=_title %></h1>	
			<form name="frm_modify" id="frm_modify" enctype="multipart/form-data" method="post" onsubmit="return false;">
			<input type="hidden" name="mn_pop_seq" id="mn_pop_seq" />
			<input type="hidden" name="updateFlag" id="updateFlag" />
			<input type="hidden" name="newFileFlag" id="newFileFlag" />
			<table class="tblType1 type_register">
				<colgroup>
					<col width="20%" />
					<col width="27%" />
					<col width="18%" />
					<col width="35%" />
				</colgroup>
				<tr>
					<th><label for="pop_nm" class="vv">팝업명</label></th>
					<td colspan="2">
						<span class="txt_pw"><input type="text" name="pop_nm" id="pop_nm" class="w50"/></span>
					</td>
					<td>
						<div class="grid_btn">
							<a class="btn_common btn_default" id="btn_mainpop_list">목록</a>
							<a class="btn_common btn_default" id="btn_mainpop_mod">수정</a>
						</div>
					</td>
				</tr>
				<tr>
					<th><label for="pop_tp_cd" class="vv">팝업종류</label></th>
					<td colspan="3">
						<%=CodeUtil.getRadioBoxList("POP_KD_CD", "pop_kd_cd")%>
					</td>
				</tr>
				<tr data-popup="url" style="display:none;">
					<th><label for="pop_url" class="">팝업URL</label><p class="pad-left-4"></p></th>
					<td colspan="3"><span class="txt_pw"><input type="text" name="pop_url" id="pop_url" class="w100" data-maxbyte="255" title="팝업URL"/></span></td>
				</tr>
				<tr data-popup=text>
					<th><label for="top_txt" class="vv">상단문구</label><p class="pad-left-4">&nbsp;(<label id="top_txt_text"></label>/50byte)</p></th>
					<td colspan="3"><span class="txt_pw"><input type="text" name="top_txt" id="top_txt" class="w100" data-maxbyte="50" title="상단문구"/></span></td>
				</tr>
				<tr data-popup=text>
					<th><label for="mid_txt" class="vv">중단문구</label><p class="pad-left-4">&nbsp;(<label id="mid_txt_text"></label>/100byte)</p></th>
					<td colspan="3"><span class="txt_pw"><textarea name="mid_txt" id="mid_txt" class="textarea w100 h80" data-maxbyte="100" title="중단문구"></textarea></span></td>
				</tr>
				<tr data-popup=text>
					<th><label for="btm_txt" class="vv">하단문구</label></th>
					<td colspan="3"><span class="txt_pw"><textarea name="btm_txt" id="btm_txt" class="textarea w100 h80"></textarea></span></td>
				</tr>
				<tr data-popup=text>
					<th><label for="bkg_tp_cd" class="vv">팝업배경</label></th>
					<td colspan="3">
						<div class="radio">
							<span><input name="bkg_tp_cd" id="bkg_tp_cd_01" type="radio" value="01" checked><label for="bkg_tp_cd_01">파랑(패턴)</label></span>
							<span><input name="bkg_tp_cd" id="bkg_tp_cd_02" type="radio" value="02"><label for="bkg_tp_cd_02">노랑</label></span>
							<span><input name="bkg_tp_cd" id="bkg_tp_cd_03" type="radio" value="03"><label for="bkg_tp_cd_03">파랑(이미지)</label></span>
						</div>
					</td>
				</tr>
				<tr>
					<th><label for="pop_tp_cd" class="vv">팝업유형</label></th>
					<td colspan="2">
						<%=CodeUtil.getRadioBoxList("POP_TP_CD", "pop_tp_cd")%>
					</td>
					<td>
						<p><b class="required">*(대) - </b>가로 : <b>500px</b>&nbsp;&nbsp;세로 : <b>700px</b></p>
						<p><b class="required">*(소) - </b>가로 : <b>500px</b>&nbsp;&nbsp;세로 : <b>400px</b></p>
					</td>
				</tr>
				<tr>
					<th><label for="dsply_yn" class="vv">전시여부</label></th>
					<td colspan="3">
						<div class="radio">
							<span><input name="dsply_yn" id="dsp_y" type="radio" value="Y"><label for="dsp_y">전시</label></span>
							<span><input name="dsply_yn" id="dsp_n" type="radio" value="N" checked><label for="dsp_n">비전시</label></span>
						</div>
					</td>
				</tr>
<!-- 				<tr> -->
<!-- 					<th><label for="fileTxt" class="vv">팝업 이미지 파일</label></th> -->
<!-- 					<td class="org_img"><p><b id="ognl_img_nm" style="height:26px;font-size:13px"></b></p></td> -->
<!-- 					<td class="org_img"> -->
<!-- 						<button type="button" class="btn_common btn_darkGray" id="btn_popimg_del">삭제</button> -->
<!-- 						<a href="#" type="button" class="btn_common btn_darkGray" id="btn_popimg_preview">미리보기</button> -->
<!-- 					</td> -->
<!-- 					<td class="org_img"></td> -->
<!-- 					<td class="new_img" colspan="2"> -->
<!-- 						<span class="fileAdd w100"> -->
<!-- 							<input id="fileTxt" type="text" class="w70" value="" placeholder="선택된 파일 없음" readonly> -->
<!-- 							<input type="button" value="파일첨부" class="btn_common btn_blue" onclick="javascript:document.getElementById('img_files').click();"> -->
<!-- 							<input id="img_files" type="file" style='visibility:hidden;' name="img_files" onchange="ChangeText(this, 'fileTxt');" accept=".jpg, .jpeg, .bmp, .gif, .png"/> -->
<!-- 						</span> -->
<!-- 					</td> -->
<!-- 					<td class="new_img"><p><b class="required">*허용확장자 :</b> .jpg, .jpeg, .png, .gif, .bmp</p></td> -->
<!-- 				</tr> -->
				<tr>
					<th><label for="disp_st_dt" class="vv">전시시작일시</label></th>
					<td colspan="3" class="type_show"> 
						<span class="txt_pw type_date">
							<input type="text" id="disp_st_dt"/>
						</span>
						<span class="txt_pw type_three"> 
							<select id="_st_dt_hh" class="select"></select>
							<span class="colon">:</span>
							<select id="_st_dt_mm" class="select"></select>
							<span class="colon">:</span>
							<select id="_st_dt_ss" class="select"></select>
						</span>
						<input type="hidden" id="h_disp_st_dt" name="st_dttm" />
					</td>
				</tr>
				<tr>
					<th><label for="disp_ed_dt" class="vv">전시종료일시</label></th>
					<td colspan="3" class="type_show"> 
						<span class="txt_pw type_date">
							<input type="text" id="disp_ed_dt"/>
						</span>
						<span class="txt_pw type_three">
							<select id="_ed_dt_hh" class="select"></select>
							<span class="colon">:</span>
							<select id="_ed_dt_mm" class="select"></select> 
							<span class="colon">:</span>
							<select id="_ed_dt_ss" class="select"></select>
						</span>
						<input type="hidden" id="h_disp_ed_dt" name="ed_dttm" />
					</td>
				</tr>
			</table>
			</form>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
