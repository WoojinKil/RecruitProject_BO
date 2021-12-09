// 빈값 체크
function isEmpty(val) {
	if (val == null || val == '' || val == undefined || ( val != null && typeof val == "object" && !Object.keys(val).length)) return true;
	else return false;
}
function isNotEmpty(val) {
	return !isEmpty(val);
}
function chgEmptyUrl(url) {
	var retVal = "/";
	if(isNotEmpty(url)) retVal = url;
	return retVal;
}

// 숫자만 입력
function onlyNum(obj) {
	$(obj).keyup(function() {
		$(this).val($(this).val().replace(/[^0-9]/g, ""));
	});
	$(obj).keydown(function() {
		$(this).val($(this).val().replace(/[^0-9]/g, ""));
	});
}

// 숫자인지 판단
function isNum(num) {
	return (num.toString() && !/\D/.test(num));
}
function isNotNum(num) {
	return !isNum(num);
}

// 숫자 Max Length 설정
function setNumMaxLen(obj) {
    if(obj.value.length > obj.maxLength) obj.value = obj.value.slice(0, obj.maxLength);
}

// 이메일 형식 확인
function chkEml(eml) {
	var eml_chk = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	return eml_chk.test(eml);
}

// 바이트 계산
function calByte(obj){
    var codeByte = 0;
    for(var idx = 0; idx < obj.val().length; idx++) {
        var oneChar = escape(obj.val().charAt(idx));
        if(oneChar.length == 1) codeByte ++;
        else if(oneChar.indexOf("%u") != -1) codeByte += 2;
        else if (oneChar.indexOf("%") != -1) codeByte ++;
    }
    return codeByte;
}

// String 타입 > Date 타입 변환
function stringToDate(strDate) {
	var matches;
	if(matches = strDate.match(/^(\d{4})-(\d{2})-(\d{2})$/)) {
		return new Date(matches[1], matches[2] - 1, matches[3]);
	}else {
		return null;
	}
};

// Date 타입 > String 타입 변환
dateToString = function(date) {
	var year  = date.getFullYear().toString();
	var month = (date.getMonth() + 1).toString();
	var day   = date.getDate().toString();
	month = (month.length == 1) ? "0" + month : month;
	day   = (day.length == 1) ? "0" + day : day;
	return year + "-" + month + "-" + day;
};

// 일자 추가
function addDate(date, addDay) {
	if(typeof(date) == "string") {
		date = stringToDate(date);
	}
	if(date != null) {
		return dateToString(new Date(date.getFullYear(), date.getMonth(), date.getDate() + addDay));
	}else {
		return "";
	}
}

// 현재일자
function getCurrDate(type) {
	var curr_date = new Date();
	var curr_year  = curr_date.getFullYear().toString();
	var curr_month = (curr_date.getMonth() + 1).toString();
	var curr_day   = curr_date.getDate().toString();
	var curr_hour  = curr_date.getHours().toString();
	var curr_min   = curr_date.getMinutes().toString();
	curr_month = (curr_month.length == 1) ? "0" + curr_month : curr_month;
	curr_day   = (curr_day.length == 1) ? "0" + curr_day : curr_day;
	curr_hour  = (curr_hour.length == 1) ? "0" + curr_hour : curr_hour;
	curr_min   = (curr_min.length == 1) ? "0" + curr_min : curr_min;
	if("YYYY-MM-DD" == type) return curr_year + "-" + curr_month + "-" + curr_day;
	else if("HH:MI" == type) return curr_hour + ":" + curr_min;
}

// 글자 바이트 체크
function f_chk_byte(aro_name, ari_max) {
	var ls_str= aro_name.value;	
	var li_str_len = ls_str.length;	
	var li_max= ari_max;	
	var i= 0;	
	var li_byte= 0;	
	var li_len= 0;	
	var ls_one_char = "";	
	var ls_str2= "";	
	
	for(i=0; i< li_str_len; i++) {	
		ls_one_char = ls_str.charAt(i);		
		if (escape(ls_one_char).length > 4)		
			  li_byte += 2;		
		else		
			  li_byte++;		
		if (li_byte <= li_max) li_len = i + 1;
	}

	if(li_byte > li_max) {	
		alert("입력 최대 Byte 수는" +ari_max + "Byte 입니다.");	
		ls_str2 = ls_str.substr(0, li_len);	
		aro_name.value = ls_str2;
	}	
	aro_name.focus();
}

// 공통 : 게시글 상세 이동
function goDocDtl(params) {
	var frm = $('<form>').attr({ method : "get", action : _context + "/module/board/boardTypeDtlInfo.do", name : "docFrm"});
	
	// 1. 필수조건
	var field1 = $('<input>').attr({type : "hidden", name : "bbs_tp_cd", value : params.bbs_tp_cd});
	var field2 = $('<input>').attr({type : "hidden", name : "tmpl_seq", value : params.tmpl_seq});
	var field3 = $('<input>').attr({type : "hidden", name : "modl_seqs", value : params.modl_seqs});
	var field4 = $('<input>').attr({type : "hidden", name : "lst_modl_seq", value : params.lst_modl_seq});
	var field5 = $('<input>').attr({type : "hidden", name : "modl_seq", value : params.modl_seq});
	var field6 = $('<input>').attr({type : "hidden", name : "doc_seq", value : params.doc_seq});
	
	// 2. 검색조건
	var field7 = $('<input>').attr({type : "hidden", name : "page", value : params.page});
	var field8 = $('<input>').attr({type : "hidden", name : "sch_type", value : params.sch_type});
	var field9 = $('<input>').attr({type : "hidden", name : "sch_type_txt", value : params.sch_type_txt});
	
	// 3. 전송폼 셋팅 및 서브밋
	frm.append(field1).append(field2).append(field3).append(field4).append(field5).append(field6).append(field7).append(field8).append(field9);
	$(document.body).append(frm);
	docFrm.submit();
}

// 공통 : (복수) 공통코드 목록 조회
function getCommCdList(mst_cd_str_arr, callBackFunc) {
	$.ajax({
        url     : _context + '/psys/getPsysCommon',
        type    : 'POST',
        data    : {'mst_cd_arr' : mst_cd_str_arr.trim()},
        async   : true,
        success : function(data) {
        	data = JSON.parse(data);
        	callBackFunc(data.selectData);
        }
	});
}