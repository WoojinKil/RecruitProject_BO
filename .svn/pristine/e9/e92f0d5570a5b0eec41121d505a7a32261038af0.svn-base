<%-- 
   1. 파일명 : cnsForm
   2. 파일설명: 수강상담 신청 입력폼
   3. 작성일 : 2019-04-02
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/meta.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=_resourcePath%>/common/css/style.css">
<script type="text/javascript">
var cmplLoad = false;
$(document).ready(function() {
	// 상담가능시간 : 날짜 변경 시
	$("#cns_dt").change(function() {
		$("#cns_st_tm").val("");
		$("#cns_ed_tm").val("");
		$("#lb_cns_st_tm").text("시작시간");
		$("#lb_cns_ed_tm").text("종료시간");
		makeLmAtlcCnsTm($("#atlcCnsStTm").val(), $("#atlcCnsStMI").val(), $("#atlcCnsEdTm").val(), $("#atlcCnsEdMI").val(), $("#mmValArr").val(), $(this).val());
	});
	
	// 상담가능시간 : 시/종료시간 변경 시
	$("#cns_st_tm, #cns_ed_tm").change(function() {
		if("cns_st_tm" == $(this).attr("id")) {
			if($(this).val() >= $("#cns_ed_tm").val()) {
				var txt = $("#cns_st_tm option:selected").text();
				if(isEmpty($(this).val())) txt = "종료시간";
				$("#lb_cns_ed_tm").text(txt);
				$("#cns_ed_tm").val($(this).val()).trigger('change');
			}
			var selIdx = $("#cns_st_tm option:selected").index();
			$("#cns_ed_tm option").attr("disabled", false);
			$("#cns_ed_tm option").removeClass("disabled");
			var idx = 0;
			$("#cns_ed_tm option").each(function() {
				if(idx < selIdx){
					if(isNotEmpty($(this).val())) {
						$(this).attr("disabled", "disabled");
						$(this).addClass("disabled");
					}
				}
				idx++
			});
		}
		if(isNotEmpty($("#cns_dt").val()) && isNotEmpty($(this).val())) {
			if("cns_st_tm" == $(this).attr("id")) {
				$("#cns_st_dttm").val($("#cns_dt").val().replace(/-/gi, "").trim() + $(this).val().replace(/:/gi, "").trim()).trigger('change');
			}else {
				$("#cns_ed_dttm").val($("#cns_dt").val().replace(/-/gi, "").trim() + $(this).val().replace(/:/gi, "").trim()).trigger('change');
			} 
		}else {
			if("cns_st_tm" == $(this).attr("id")) {
				$("#cns_st_dttm").val("").trigger('change');
			}else {
				$("#cns_ed_dttm").val("").trigger('change');
			}
		}
	});
	
	// 상담가능시간 : 유효성 체크 메세지 해제
	$("#cns_st_dttm, #cns_ed_dttm").change(function() {
		if(isNotEmpty($("#cns_st_dttm").val()) && isNotEmpty($("#cns_ed_dttm").val())) delValidMsg("cns_dttm");
	});
	
	// 이름, 이메일 : 유효성 체크 메세지 해제
	var hop_edc_crs = $("#hop_edc_crs").val();
	$("#atlc_usr_nm, #atlc_usr_eml_adr").change(function() {
		var id = $(this).attr("id");
		if("atlc_usr_nm" == id) {
			if(isNotEmpty($(this).val()) && chkDataByte("CHK", "INPUT", id)) delValidMsg(id);
		}else {
			if(isNotEmpty($(this).val()) && chkEml($(this).val()) && chkDataByte("CHK", "INPUT", id)) delValidMsg(id);
		}
	});
	
	// 연락처 : 유효성 체크 메세지 해제
	$("#atlc_usr_mbl_no_1, #atlc_usr_mbl_no_2, #atlc_usr_mbl_no_3").change(function() {
		if(isNotEmpty($("#atlc_usr_mbl_no_1").val()) && isNotEmpty($("#atlc_usr_mbl_no_2").val()) && isNotEmpty($("#atlc_usr_mbl_no_3").val())) delValidMsg("atlc_usr_mbl_no");
	});
	
	// 희망교육과정, 내용 : 유효성 체크 메세지 해제
	$("#hop_edc_crs, #cns_cts").change(function() {
		var id = $(this).attr("id");
		if("hop_edc_crs" == id) {
			if(isNotEmpty($(this).val()) && chkDataByte("CHK", "INPUT", id)) delValidMsg(id);
		}else {
			if(isNotEmpty($(this).val()) && chkDataByte("CHK", "TEXTAREA", id)) delValidMsg(id);
		}
	});
	
	// 개인정보 처리방침 동의여부 체크 : 유효성 체크 박스 해제
	$("#chk_agree").change(function() {
        if($(this).is(":checked")) {
        	$("#lb_chk_agree").removeClass("typeCheck");
        }
    });
	
	// 초기화
	doInit();
});

// 초기화
function doInit() {
	// 데이트 피커 초기화
	$.datepicker.regional['ko'] = {
        closeText: '닫기',
        prevText: '이전달',
        nextText: '다음달',
        currentText: '오늘',
        monthNames: ['1월','2월','3월','4월','5월','6월',
        '7월','8월','9월','10월','11월','12월'],
        monthNamesShort: ['1월','2월','3월','4월','5월','6월',
        '7월','8월','9월','10월','11월','12월'],
        dayNames: ['일','월','화','수','목','금','토'],
        dayNamesShort: ['일','월','화','수','목','금','토'],
        dayNamesMin: ['일','월','화','수','목','금','토'],
        showMonthAfterYear: true,
        minDate: 0
    };
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$(".dtpicker").datepicker({ dateFormat: 'yy-mm-dd' }).val();
	
	// 상담가능일자 셋팅 : 디폴트, 현재일자
	var currDt = getCurrDate("YYYY-MM-DD");
	$("#cns_dt").val(currDt);
	$("#cns_dt").datepicker("option", "minDate", currDt);
	
	// 공통코드 호출 : 상담유형, 수강 상담 시간 간격, 수강 상담 시/종료 시간 셋팅
	var mst_cd_str_arr = "CNS_TP_CD,ATLC_CNS_TR,ATLC_CNS_TM";
	getCommCdList(mst_cd_str_arr, function callBackFunc(data) {
		var atlcCnsTr = "30"; // 수강상담시간간격
		var atlcCnsStTm = "0900"; // 수강상담시작시간
		var atlcCnsStMI = "00"; // 수강상담시작분
		var atlcCnsEdTm = "1800"; // 수강상담종료시간
		var atlcCnsEdMI = "00"; // 수강상담종료분 
		var cnsTpCdIdx = 0;
		for(var i in data) {
			// 상담유형
			if(data[i].MST_CD == "CNS_TP_CD") {
				if(cnsTpCdIdx == 0) $('.radioWrap').append('<li><input type="radio" name="cns_tp_cd" id="cns_tp_cd_' + String(cnsTpCdIdx) + '" value="' + data[i].CD + '" checked="checked" onchange="javascrpit:chgCnsTpCd(this);" /><label for="cns_tp_cd_' + String(cnsTpCdIdx) + '">' + data[i].CD_NM + '</label></li>'); 
				else $('.radioWrap').append('<li><input type="radio" name="cns_tp_cd" id="cns_tp_cd_' + String(cnsTpCdIdx) + '" value="' + data[i].CD + '" onchange="javascrpit:chgCnsTpCd(this);" /><label for="cns_tp_cd_' + String(cnsTpCdIdx) + '">' + data[i].CD_NM + '</label></li>');
				cnsTpCdIdx++;
			}
			// 수강상담시간 간격
			if(data[i].MST_CD == "ATLC_CNS_TR") {
				atlcCnsTr = data[i].REF_1;
			}
			// 수강상담시/종료시간
			if(data[i].MST_CD == "ATLC_CNS_TM") {
				if(data[i].CD == "10") {
					atlcCnsStTm = data[i].REF_1;
					atlcCnsStMI = atlcCnsStTm.substring(2, 4);
				}else if(data[i].CD == "20") {
					atlcCnsEdTm = data[i].REF_1;
					atlcCnsEdMI = atlcCnsEdTm.substring(2, 4);
				}
			}
		}
		var mmValArr = new Array();
		for(var i = 0; i < 6; i++) {
			for(j = 0; j < 10; j++) {
				var mmVal = i + "" + j;
				if((parseInt(mmVal, 10)) % parseInt(atlcCnsTr, 10) == 0) {
					mmValArr.push(mmVal);
				}
			}
		}
		// 시작시간, 종료시간 콤보 생성
		makeAtlcCnsTm(atlcCnsStTm, atlcCnsStMI, atlcCnsEdTm, atlcCnsEdMI, mmValArr);
	});
	
	// 연락처 숫자만 입력 가능
	onlyNum($("#atlc_usr_mbl_no_2"));
	onlyNum($("#atlc_usr_mbl_no_3"));
	
	
}

// 시작시간, 종료시간 콤보 생성
function makeAtlcCnsTm(atlcCnsStTm, atlcCnsStMI, atlcCnsEdTm, atlcCnsEdMI, mmValArr) {
	$('#cns_st_tm').html('');
	$('#cns_st_tm').append('<option value="">시작시간</option>');
	$('#cns_ed_tm').html('');
	$('#cns_ed_tm').append('<option value="">종료시간</option>');
	for(var i = 0; i < 6; i++) {
		var limitCnt = 10;
		if(i == 2) limitCnt = 5;
		for(var j = 0; j < limitCnt; j++) {
			var hhVal = i + "" + j;
			if((parseInt((hhVal + atlcCnsStMI), 10) >= parseInt(atlcCnsStTm, 10)) && (parseInt((hhVal + atlcCnsEdMI), 10) <= parseInt(atlcCnsEdTm, 10))) {
				for(var k = 0; k < mmValArr.length; k++) {
					var hhmmVal = hhVal + ":" + mmValArr[k];
					if((parseInt(hhVal + mmValArr[k], 10) >= parseInt(atlcCnsStTm, 10)) && (parseInt(hhVal + mmValArr[k], 10) <= parseInt(atlcCnsEdTm, 10))) {
						$('#cns_st_tm').append('<option value="' + hhmmVal + '">' + hhmmVal + '</option>');
						$('#cns_ed_tm').append('<option value="' + hhmmVal + '">' + hhmmVal + '</option>');
					}
				}
			}
		}
	}
	// 시작시간, 종료시간 콤보 제한 설정
	makeLmAtlcCnsTm(atlcCnsStTm, atlcCnsStMI, atlcCnsEdTm, atlcCnsEdMI, mmValArr, $("#cns_dt").val());
}

// 시작시간, 종료시간 콤보 제한 설정
function makeLmAtlcCnsTm(atlcCnsStTm, atlcCnsStMI, atlcCnsEdTm, atlcCnsEdMI, mmValArr, selDt) {
	// 콤보 제한
	var currDt = getCurrDate("YYYY-MM-DD");
	var currTm = getCurrDate("HH:MI");
	var comboIdxs = 0;
	var disabledIdxs = 0;
	$("#cns_st_tm option").removeClass("disabled");
	$("#cns_st_tm option").attr("disabled", false);
	$("#cns_ed_tm option").removeClass("disabled");
	$("#cns_ed_tm option").attr("disabled", false);
	$("#cns_st_tm option").each(function() {
		if(isNotEmpty($(this).val())) {
			if(currDt == selDt && currTm > $(this).val()) {
				$(this).addClass("disabled");
				$(this).attr("disabled", "disabled");
				disabledIdxs++;
			}
			comboIdxs++;
		}
	});
	$("#cns_ed_tm option").each(function() {
		if(isNotEmpty($(this).val())) {
			if(currDt == selDt && currTm > $(this).val()) {
				$(this).addClass("disabled");
				$(this).attr("disabled", "disabled");
			}
		}
	});
	
	// Hidden 셋팅 
	$("#atlcCnsStTm").val(atlcCnsStTm);
	$("#atlcCnsStMI").val(atlcCnsStMI);
	$("#atlcCnsEdTm").val(atlcCnsEdTm);
	$("#atlcCnsEdMI").val(atlcCnsEdMI);
	$("#mmValArr").val(mmValArr);
	
	// 오늘일자 모두 Disabled인 경우 다음날로 셋팅
	if(comboIdxs == disabledIdxs) {
		// 오늘일자 + 1
		selDt = addDate(selDt, 1);
		$("#cns_dt").val(selDt);
		$("#cns_dt").datepicker("option", "minDate", selDt);
		// 시작시간, 종료시간 콤보 제한 설정
		makeLmAtlcCnsTm(atlcCnsStTm, atlcCnsStMI, atlcCnsEdTm, atlcCnsEdMI, mmValArr, selDt);
	}
}

// 상당유형 변경 시 처리
function chgCnsTpCd(obj) {
	// 상담유형 : 유효성 체크 메세지 해제
	if(isNotEmpty(obj.value)) delValidMsg("cns_tp_cd");
}

// 유효성 체크 메세지 해제
function delValidMsg(id) {
	$("#err_" + id).html("");
	$("#err_" + id).hide();
	if("cns_dttm" == id) {
		$("#lb_cns_st_tm").removeClass("typeCheck");
		$("#lb_cns_ed_tm").removeClass("typeCheck");
	}else if("atlc_usr_mbl_no" == id) {
		$("#atlc_usr_mbl_no_2").removeClass("typeCheck");
		$("#atlc_usr_mbl_no_3").removeClass("typeCheck");
	}else {
		$("#" + id).removeClass("typeCheck");
	}
}

// 등록 전 유효성 체크
function regValidChk() {
	var retVal = true;
	var err_ids = new Array();
	var err_msgs = new Array();
	
	
	// 1. 상담유형
	var cns_tp_cd = $('input:radio[name="cns_tp_cd"]:checked').val();
	
	// 2. 상담가능시간
	var cns_dt = $("#cns_dt").val();
	var cns_st_tm = $("#cns_st_tm").val();
	var cns_ed_tm = $("#cns_ed_tm").val();
	// 3. 이름
	var atlc_usr_nm = $("#atlc_usr_nm").val();
	// 4. 연락처
	var atlc_usr_mbl_no_1 = $("#atlc_usr_mbl_no_1").val();
	var atlc_usr_mbl_no_2 = $("#atlc_usr_mbl_no_2").val();
	var atlc_usr_mbl_no_3 = $("#atlc_usr_mbl_no_3").val();
	// 5. 이메일
	var atlc_usr_eml_adr = $("#atlc_usr_eml_adr").val();
	var eml_chk = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	// 6. 희망교육과정
	var hop_edc_crs = $("#hop_edc_crs").val();
	// 7. 내용
	var cns_cts = $("#cns_cts").val();
	if(isEmpty(cns_tp_cd)) {
		err_ids.push("err_cns_tp_cd");
		err_msgs.push("&#39;상담유형&#39;을 선택해주세요.");
		retVal = false;
	}
	var focusCnt = 0;
	if(isEmpty(cns_dt) || isEmpty(cns_st_tm) || isEmpty(cns_ed_tm)) {
		err_ids.push("err_cns_dttm");
		err_msgs.push("&#39;상담가능시간&#39;을 선택해주세요.");
		if(isEmpty(cns_dt)) {
			$("#cns_dt").addClass("typeCheck");
			if(!(focusCnt > 0)) $("#cns_dt").focus();
			focusCnt++;
		}
		if(isEmpty(cns_st_tm)) {
			$("#lb_cns_st_tm").addClass("typeCheck");
			if(!(focusCnt > 0)) $("#cns_st_tm").focus();
			focusCnt++;
		}
		if(isEmpty(cns_ed_tm)) {
			$("#lb_cns_ed_tm").addClass("typeCheck");
			if(!(focusCnt > 0)) $("#cns_ed_tm").focus();
			focusCnt++;
		}
		retVal = false;
	}
	if(isEmpty(atlc_usr_nm)) {
		err_ids.push("err_atlc_usr_nm");
		err_msgs.push("&#39;이름&#39;을 입력해주세요.");
		$("#atlc_usr_nm").addClass("typeCheck");
		if(!(focusCnt > 0)) $("#atlc_usr_nm").focus();
		focusCnt++;
		retVal = false;
	}else {
		var chk_id = "atlc_usr_nm";
		if(!chkDataByte("CHK", "INPUT", chk_id)) {
			err_ids.push("err_" + chk_id);
			err_msgs.push(chkDataByte("MSG", "INPUT", chk_id));
			$("#atlc_usr_nm").addClass("typeCheck");
			if(!(focusCnt > 0)) $("#atlc_usr_nm").focus();
			focusCnt++;
			retVal = false;
		}
	}
	if(isEmpty(atlc_usr_mbl_no_1) || isEmpty(atlc_usr_mbl_no_2) || isEmpty(atlc_usr_mbl_no_3)) {
		err_ids.push("err_atlc_usr_mbl_no");
		err_msgs.push("&#39;연락처&#39;를 입력해주세요.");
		if(isEmpty(atlc_usr_mbl_no_2)) {
			$("#atlc_usr_mbl_no_2").addClass("typeCheck");
			if(!(focusCnt > 0)) $("#atlc_usr_mbl_no_2").focus();
			focusCnt++;
		}
		if(isEmpty(atlc_usr_mbl_no_3)) {
			$("#atlc_usr_mbl_no_3").addClass("typeCheck");
			if(!(focusCnt > 0)) $("#atlc_usr_mbl_no_3").focus();
			focusCnt++;
		}
		retVal = false;
	}else if(isNotNum(atlc_usr_mbl_no_1) || isNotNum(atlc_usr_mbl_no_2) || isNotNum(atlc_usr_mbl_no_3)) {
		err_ids.push("err_atlc_usr_mbl_no");
		err_msgs.push("&#39;연락처&#39;는 숫자만 입력 가능합니다.");
		if(isNotNum(atlc_usr_mbl_no_1)) {
			$("#lb_atlc_usr_mbl_no_1").addClass("typeCheck");
			if(!(focusCnt > 0)) $("#atlc_usr_mbl_no_1").focus();
			focusCnt++;
		}
		if(isNotNum(atlc_usr_mbl_no_2)) {
			$("#atlc_usr_mbl_no_2").addClass("typeCheck");
			if(!(focusCnt > 0)) $("#atlc_usr_mbl_no_2").focus();
			focusCnt++;
		}
		if(isNotNum(atlc_usr_mbl_no_3)) {
			$("#atlc_usr_mbl_no_3").addClass("typeCheck");
			if(!(focusCnt > 0)) $("#atlc_usr_mbl_no_3").focus();
			focusCnt++;
		}
		retVal = false;
	}
	if(isEmpty(atlc_usr_eml_adr)) {
		err_ids.push("err_atlc_usr_eml_adr");
		err_msgs.push("&#39;이메일&#39;을 입력해주세요.");
		$("#atlc_usr_eml_adr").addClass("typeCheck");
		if(!(focusCnt > 0)) $("#atlc_usr_eml_adr").focus();
		focusCnt++;
		retVal = false;
	}else if(!chkEml(atlc_usr_eml_adr)) {
		err_ids.push("err_atlc_usr_eml_adr");
		err_msgs.push("&#39;이메일&#39;을 정확하게 입력해주세요.");
		$("#atlc_usr_eml_adr").addClass("typeCheck");
		if(!(focusCnt > 0)) $("#atlc_usr_eml_adr").focus();
		focusCnt++;
		retVal = false;
	}else {
		var chk_id = "atlc_usr_eml_adr";
		if(!chkDataByte("CHK", "INPUT", chk_id)) {
			err_ids.push("err_" + chk_id);
			err_msgs.push(chkDataByte("MSG", "INPUT", chk_id));
			$("#atlc_usr_eml_adr").addClass("typeCheck");
			if(!(focusCnt > 0)) $("#atlc_usr_eml_adr").focus();
			focusCnt++;
			retVal = false;
		}
	}
	if(isEmpty(hop_edc_crs)) {
		err_ids.push("err_hop_edc_crs");
		err_msgs.push("&#39;희망교육과정&#39;을 입력해주세요.");
		$("#hop_edc_crs").addClass("typeCheck");
		if(!(focusCnt > 0)) $("#hop_edc_crs").focus();
		focusCnt++;
		retVal = false;
	}else {
		var chk_id = "hop_edc_crs";
		if(!chkDataByte("CHK", "INPUT", chk_id)) {
			err_ids.push("err_" + chk_id);
			err_msgs.push(chkDataByte("MSG", "INPUT", chk_id));
			$("#hop_edc_crs").addClass("typeCheck");
			if(!(focusCnt > 0)) $("#hop_edc_crs").focus();
			focusCnt++;
			retVal = false;
		}
	}
	if(isNotEmpty(cns_cts)) {
		var chk_id = "cns_cts";
		if(!chkDataByte("CHK", "TEXTAREA", chk_id)) {
			err_ids.push("err_" + chk_id);
			err_msgs.push(chkDataByte("MSG", "TEXTAREA", chk_id));
			$("#cns_cts").addClass("typeCheck");
			if(!(focusCnt > 0)) $("#cns_cts").focus();
			focusCnt++;
			retVal = false;
		}
	}
	
	// 유효성 체크 메세지 출력
	if(!retVal) {
		for(var i = 0; i < err_ids.length; i++) {
			$("#" + err_ids[i].toString()).html(err_msgs[i].toString());
			$("#" + err_ids[i].toString()).show();
		}
	}
	
	return retVal;
}

// 데이터 바이트 체크
function chkDataByte(chk_flag, chk_type, chk_id) {
	if("CHK" == chk_flag) {
		var retVal = true;
		if("INPUT" == chk_type) {
			$("input[data-byte]").each(function(idx, item) {
				var maxByte = $(item).data("byte");
				var id = $(item).attr("id");
				var target  = "#" + id;
				var title   = $(item).attr("title");
				if((chk_id == id) && (calByte($(target)) > maxByte)) {
					retVal = false;
				}
			});
		}else if("TEXTAREA" == chk_type) {
			$("textarea[data-byte]").each(function(idx, item) {
				var maxByte = $(item).data("byte");
				var id = $(item).attr("id");
				var target  = "#" + id;
				var title   = $(item).attr("title");
				if((chk_id == id) && (calByte($(target)) > maxByte)) {
					retVal = false;
				}
			});
		}
		return retVal;
	}else if("MSG" == chk_flag){
		var retVal = "";
		if("INPUT" == chk_type) {
			$("input[data-byte]").each(function(idx, item) {
				var maxByte = $(item).data("byte");
				var id = $(item).attr("id");
				var target  = "#" + id;
				var title   = $(item).attr("title");
				if((chk_id == id) && (calByte($(target)) > maxByte)) {
					retVal = "&#39;" + title + "&#39;은 최대 &#39;" + maxByte + " Byte&#39;까지 입력이 가능합니다.";
				}
			});
		}else if("TEXTAREA" == chk_type) {
			$("textarea[data-byte]").each(function(idx, item) {
				var maxByte = $(item).data("byte");
				var id = $(item).attr("id");
				var target  = "#" + id;
				var title   = $(item).attr("title");
				if((chk_id == id) && (calByte($(target)) > maxByte)) {
					retVal = "&#39;" + title + "&#39;은 최대 &#39;" + maxByte + " Byte&#39;까지 입력이 가능합니다.";
				}
			});
		}
		return retVal;
	}
}

// 수강상담 신청
function registAtlcCnsInf() {
	if(cmplLoad && regValidChk()) {
		// 개인정보취급방침 체크여부 확인
		var chk_agree = $("input:checkbox[id='chk_agree']").is(":checked");
		if(!chk_agree) {
			alert("개인정보 처리방침에 동의해주세요.");
			$("#lb_chk_agree").addClass("typeCheck");
			$("#chk_agree").focus();
			return;
		}
		//수강유형명
		var cns_tp_cd_Id = $('input:radio[name="cns_tp_cd"]:checked').attr("id");
		var cns_tp_nm = $("label[for='"+cns_tp_cd_Id+"']").text();
		// 수강상담 신청
		// [ 파라미터 셋팅 ]
		var formData = new FormData();
		// 1. 상담유형
		formData.append("cns_tp_cd", $('input:radio[name="cns_tp_cd"]:checked').val());
		formData.append("cns_tp_nm",cns_tp_nm);
		
		// 2. 상담가능시간
		formData.append("cns_st_dttm", $("#cns_st_dttm").val());
		formData.append("cns_ed_dttm", $("#cns_ed_dttm").val());
		// 3. 이름
		formData.append("atlc_usr_nm", $("#atlc_usr_nm").val());
		// 4. 연락처
		formData.append("atlc_usr_mbl_no_1", $("#atlc_usr_mbl_no_1").val());
		formData.append("atlc_usr_mbl_no_2", $("#atlc_usr_mbl_no_2").val());
		formData.append("atlc_usr_mbl_no_3", $("#atlc_usr_mbl_no_3").val());
		// 5. 이메일
		formData.append("atlc_usr_eml_adr", $("#atlc_usr_eml_adr").val());
		// 6. 희망교육과정
		formData.append("hop_edc_crs", $("#hop_edc_crs").val());
		// 7. 내용
		formData.append("cns_cts", $("#cns_cts").val());
		// 8. 상담상태코드(10:신청)
		formData.append("cns_ss_cd", "10");
		// [ 수강상담 신청 정보 저장 ]
		$.ajax({
			url         : _context + "/module/board/registAtlcCnsInf",
			type        : 'POST',
			data        : formData,
			contentType : false,
			cache       : false,
			processData : false,
			async       : true,
			success     : function(data) {
				var json = eval('('+data+')');
				if(_boolean_success == json.RESULT) {
					// 수강상담 신청 이메일 전송
					sendEmailAtlcCnsInf(formData);
				}else {
					alert("정상적으로 실행되지 않았습니다. 잠시후 다시 시도하세요.");
					return;
				}
			}
		});
	}
}

// 수강상담 신청 이메일 전송
function sendEmailAtlcCnsInf(formData) {
	$.ajax({
		url         : _context + "/module/board/sendEmailAtlcCnsInf",
		type        : 'POST',
		data        : formData,
		contentType : false,
		cache       : false,
		processData : false,
		async       : true,
		success     : function(data) {
			var json = eval('('+data+')');
			if(_boolean_success == json.RESULT) {
				// 수강상담 신청 완료폼 이동
				location.href = _context + "/module/board/cmplCnsForm.do?tmpl_seq=" + _curr_tmpl_seq+"&bbs_tp_cd="+_bbs_tp_cd;
			}else {
				alert("수강상담 신청 메일 전송에 실패하였습니다. 잠시후 다시 시도하세요.");
				return;
			}
		}
	});
}

// 페이지 Onload 시 처리
window.onload = function() {
	cmplLoad = true;
}
</script>
<body>
	<div id="wrap">
		<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/header.jsp" %>
		<!-- Container -->
		<div id="container">
			<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/breadCrumb.jsp" %>
					<div class="consultWrap typeOnline">
						<table class="consultTable">
							<caption>BESINESS IT 수강상담 신청서 작성</caption>
							<colgroup>
								<col style="width:16.69%;" />
								<col style="width:83.31%;" />
							</colgroup>
							<tbody>
								<tr>
									<th scope="row" class="typeMust">
										<span>상담유형</span>
									</th>
									<td>
										<ul class="radioWrap typeOnline">
										</ul>
										<span class="typeWarning" id="err_cns_tp_cd" style="display:none;"></span>
									</td>
								</tr>
								<tr>
									<th scope="row" class="typeMust">
										<span>상담가능시간</span>
									</th>
									<td>
										<input type="text" id="cns_dt" class="dtpicker" readonly />
										<div class="selectBox typeTime">
											<label id="lb_cns_st_tm" for="cns_st_tm">시작시간</label>
											<select class="time select" id="cns_st_tm" name="cns_st_tm">
												<option value="">시작시간</option>
											</select>
										</div>
										<div class="selectBox typeTime">
											<label id="lb_cns_ed_tm" for="cns_ed_tm">종료시간</label>
											<select class="time select" id="cns_ed_tm" name="cns_ed_tm">
												<option value="">종료시간</option>
											</select>
										</div>
										<span class="typeWarning" id="err_cns_dttm" style="display:none;"></span>
									</td>
								</tr>
								<tr>
									<th scope="row" class="typeMust">
										<label for="atlc_usr_nm">이름</label>
									</th>
									<td>
										<input type="text" id="atlc_usr_nm" class="inputName" placeholder="이름을 입력해주세요." data-byte="300" title="이름" />
										<span class="typeWarning" id="err_atlc_usr_nm" style="display:none;"></span>
									</td>
								</tr>
								<tr>
									<th scope="row" class="typeMust">
										<span>연락처</span>
									</th>
									<td>
										<div class="selectBox">
											<label id="lb_atlc_usr_mbl_no_1" for="atlc_usr_mbl_no_1">010</label>
											<select class="phone select" id="atlc_usr_mbl_no_1">
												<option disabled="disabled" class="disabled">핸드폰</option>
												<option value="010">010</option>
												<option value="011">011</option>
												<option value="016">016</option>
												<option value="017">017</option>
												<option value="018">018</option>
												<option value="019">019</option>
												<option disabled="disabled" class="disabled">전화번호</option>
												<option value="02">02</option>
												<option value="031">031</option>
												<option value="032">032</option>
												<option value="033">033</option>
												<option value="041">041</option>
												<option value="042">042</option>
												<option value="043">043</option>
												<option value="051">051</option>
												<option value="052">052</option>
												<option value="053">053</option>
												<option value="054">054</option>
												<option value="055">055</option>
												<option value="061">061</option>
												<option value="062">062</option>
												<option value="063">063</option>
												<option value="064">064</option>
												<option value="070">070</option>
											</select>
										</div>
										-
										<input type="number" id="atlc_usr_mbl_no_2" class="phone" maxlength="4" oninput="setNumMaxLen(this);" />
										-
										<input type="number" id="atlc_usr_mbl_no_3" class="phone" maxlength="4" oninput="setNumMaxLen(this);" />
										<span class="typeWarning" id="err_atlc_usr_mbl_no" style="display:none;"></span>
									</td>
								</tr>
								<tr>
									<th scope="row" class="typeMust">
										<label for="atlc_usr_eml_adr">이메일</label>
									</th>
									<td>
										<input type="text" id="atlc_usr_eml_adr" class="email" placeholder="이메일을 입력해주세요." name="atlc_usr_eml_adr" data-byte="200" title="이메일" />
										<span class="typeWarning" id="err_atlc_usr_eml_adr" style="display:none;"></span>
									</td>
								</tr>
								<tr>
									<th scope="row" class="typeMust">
										<label for="hop_edc_crs">희망교육과정</label>
									</th>
									<td>
										<input type="text" id="hop_edc_crs" class="hopeCourse" placeholder="과정명을 입력해주세요." data-byte="200" title="희망교육과정" />
										<span class="typeWarning" id="err_hop_edc_crs" style="display:none;"></span>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="cns_cts">내용</label>
									</th>
									<td>
										<textarea id="cns_cts" class="hopeContent" placeholder="상담내용을 입력해주세요." data-byte="3000" title="내용"></textarea>
										<span class="typeWarning" id="err_cns_cts" style="display:none;"></span>
									</td>
								</tr>
							</tbody>
						</table>
						<div class="agreeWrap">
							<h4 class="title">개인정보 취급방침</h4>
							<div class="infoArea">
								<iframe src="<%=_resourcePath%>/common/html/policy_content.html" style="border:0 none; width:100%; height:auto;"></iframe>
							</div>
							<div class="checkWrap">
								<input type="checkbox" id="chk_agree" />
								<label id="lb_chk_agree" for="chk_agree">개인정보 처리방침에 동의합니다.</label>
							</div>
						</div>
					</div>
					<div class="btnWrap typeBlue">
						<a href="javascript:void(0);" class="saveLink" onclick="javascript:registAtlcCnsInf();return false;">등록</a>
					</div>
				</div>
			</div>
			<!-- //Content -->
			<input type="hidden" id="atlcCnsStTm">
			<input type="hidden" id="atlcCnsStMI">
			<input type="hidden" id="atlcCnsEdTm">
			<input type="hidden" id="atlcCnsEdMI">
			<input type="hidden" id="mmValArr">
			<input type="hidden" id="cns_st_dttm">
			<input type="hidden" id="cns_ed_dttm">
		</div>
		<!-- //Container -->
        <%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/footer.jsp" %>
	</div>
</body>
</html>