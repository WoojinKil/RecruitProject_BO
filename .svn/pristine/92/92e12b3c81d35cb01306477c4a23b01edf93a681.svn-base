/**************************************************
 * VIP 파트 공통 Java Script
 **************************************************/


/*************************
 * Single 캘린더 설정
 * @objId	: 캘린더 ID
 * @initDt	: 초기 값
 * @format	: 날짜 포멧 / 미입력시 YYYY-MM-DD
 * @type	: D-일자 또는 M-월 / 미입력 시 D
 * @termYn	: from ~ to 캘린더 여부 YN / 미입력 시 N
 * @etc		: 그 외 기타 적용 옵션 (minDate / maxDate / drops 등)
 * 
 * gfn_SetSingleCalendar("schStdDt");									→ YYYY-MM-DD 포멧 일자 캘린더 / 초기값 없음
 * gfn_SetSingleCalendar("schStdDt", gfn_today());						→ YYYY-MM-DD 포멧 일자 캘린더 / 초기값 오늘 날짜
 * gfn_SetSingleCalendar("schStdDt", gfn_today("YYYY-MM"), "", "M");	→ YYYY-MM 포멧 월 캘린더 / 초기값 현재 월
 * 
 * gfn_SetSingleCalendar("schStdDt", "", "", "", true);							→ YYYY-MM-DD ~ YYYY-MM-DD 포멧 일자 기간 캘린더 / 초기값 없음
 * gfn_SetSingleCalendar("schStdDt", "", "", "M", true);						→ YYYY-MM ~ YYYY-MM 포멧 월 캘린더 / 초기값 없음
 * gfn_SetSingleCalendar("schStdDt", "2019-01-01 ~ 2019-12-31", "", "", true);	→ YYYY-MM ~ YYYY-MM 포멧 월 캘린더 / 초기값 없음
 *************************/
function gfn_setSingleCalendar(objId, initDt, format, type, termYn, etc)
{
	if(isEmpty(objId))
		return;
	
	// 일자 선택 캘린더
	var viewModel = "day";
	
	// 월 선택 캘린더
	if(type == "M")
		viewModel = "month";
	
	// 단일 일자 또는 기간 설정 여부
	var singleDatePicker = (termYn == "Y") ? false : true;
		
	// 날짜 포멧
	if(isEmpty(format) && viewModel == "day")
		format = "YYYY-MM-DD";
	else if(isEmpty(format) && viewModel == "month")
		format = "YYYY-MM";
	
	var timePicker = false;

	// 포멧에 시분초가 포함된 경우 시간 설정 표시 
	if(format.toUpperCase().replace(/Y|M|D|\/|\.|\-|\s/gi, '').length > 0)
		timePicker = true;

	var options = {
		  autoUpdateInput	: false
		, showDropdowns		: true
		, timePicker		: timePicker
		, locale			: {format: format}
		, viewModel			: viewModel
		, singleDatePicker	: singleDatePicker
	};
	
	if(isNotEmpty(etc) && Object.keys(etc).length > 0)
		$.extend(options, etc);
	
	$("#" + objId).val(initDt);
	
	$("#" + objId).daterangepicker(options, function(start, end, separator){
		if(options.singleDatePicker === true) 
			$("#" + objId).val(start);
		else
			$("#" + objId).val(start + separator + end);
	});
}


/*************************
 * FROM ~ TO 캘린더 설정
 * @sObjId	: 시작일자 캘린더 ID
 * @eObjId	: 종료일자 캘린더 ID
 * @starttDt: 시작일자 초기 값
 * @endDt	: 종료일자 초기 값
 * @format	: 날짜 포멧 / 미입력시 YYYY-MM-DD
 * @type	: D-일자 또는 M-월 / 미입력 시 D
 * @etc		: 그 외 기타 적용 옵션 (minDate / maxDate / drops 등)
 * 
 * gfn_SetSingleCalendar("schStartDt", "schEndDt");						→ YYYY-MM-DD ~ YYYY-MM-DD 포멧 일자 캘린더 / 초기값 없음
 * gfn_SetSingleCalendar("schStdDt", gfn_today());						→ YYYY-MM-DD 포멧 일자 캘린더 / 초기값 오늘 날짜
 * gfn_SetSingleCalendar("schStdDt", gfn_today("YYYY-MM"), "", "M");	→ YYYY-MM 포멧 월 캘린더 / 초기값 현재 월
 *************************/
function gfn_setCalendar(sObjId, eObjId, startDt, endDt, format, type, etc)
{
	if(isEmpty(sObjId) || isEmpty(eObjId))
		return;
	
	// 일자 선택 캘린더
	var viewModel = "day";
	
	// 월 선택 캘린더
	if(type == "M")
		viewModel = "month";
	
	if(isEmpty(format))
		format = "YYYY-MM-DD";

	// 날짜 포멧
	if(isEmpty(format) && viewModel == "day")
		format = "YYYY-MM-DD";
	else if(isEmpty(format) && viewModel == "month")
		format = "YYYY-MM";
	
	var timePicker = false;

	// 포멧에 시분초가 포함된 경우 시간 설정 표시 
	if(format.toUpperCase().replace(/Y|M|D|\/|\.|\-|\s/gi, '').length > 0)
		timePicker = true;

	var options = {
			  autoUpdateInput	: false
			, showDropdowns		: true
			, timePicker		: timePicker
			, locale			: {format: format}
			, viewModel			: viewModel
	};
	
	if(isNotEmpty(etc) && Object.keys(etc).length > 0)
		$.extend(options, etc);

	$("#" + sObjId).val(startDt);
	$("#" + eObjId).val(endDt);

	$("#" + sObjId).daterangepicker(options, function(start, end, separator){
		$("#" + sObjId).val(start);
		$("#" + eObjId).val(end);
	});
    
	$("#" + eObjId).on('click', function (){
		$("#" + sObjId).trigger('click');
	});
}


/*************************
 * 현재 일자를 기준으로 포멧 변경하여 날짜 가져오기
 * @format	: 날짜 포멧 / 미입력시 YYYY-MM-DD 
 * 
 * gfn_today("")			→ 2019-01-01
 * gfn_today("YYYY")		→ 2019
 * gfn_today("YYYYMM")		→ 201901
 * gfn_today("YYYYMMDD")	→ 20190101
 * gfn_today("YYYY-MM")		→ 2019-01
 *************************/
function gfn_today(format)
{
	if(isEmpty(format))
		format = "yy-mm-dd";

	format = format.toLowerCase();

	if(format == "yyyy" || format.replace("yyyy", "").length > 0)
		format = format.replace(/yyyy/, "yy");
	
	return $.datepicker.formatDate(format, new Date());
}


/*************************
 * 그리드 resize 설정
 * @grdList	: 그리드 객체 배열
 * 
 * gfn_setGridResize([grd_master, grd_detail])
 *************************/
function gfn_setGridResize(grdList)
{
	$(window).resize(function(){
		
		var width = $('.tblType1').width();

		grdList.forEach(function(grd){
			grd.setGridWidth(width);
		});
	});
	
	$(window).trigger('resize');
}


/*************************
 * 기준년도 -3 ~ + 1년에 해당하는 5년 셀렉트박스 생성 
 * @objId		: 셀렉트 박스 ID
 * @baseDt		: 기준이 되는 일자 또는 년도 / 미입력 시 현재일자
 * @addOption	: 전체 A /선택 C 옵션 추가 여부 / 미입력 시 추가 없음
 * @initIdx		: 초기 선택 인덱스 / 미입력 시 기준이 되는 년도
 * 
 * gfn_setYearSelBox("schYear")				→ 현재년도(2019) 기준 / 2016, 2017, 2018, 2019, 2020
 * gfn_setYearSelBox("schYear", "A", 0)		→ 현재년도(2019) 기준 / 전체, 2016, 2017, 2018, 2019, 2020
 * gfn_setYearSelBox("schYear", "C", 0)		→ 현재년도(2019) 기준 / 선택, 2016, 2017, 2018, 2019, 2020
 * gfn_setYearSelBox("schYear", "2018")		→ 2018 기준 / 2015, 2016, 2017, 2018, 2019
 * gfn_setYearSelBox("schYear", "20200201")	→ 2020 기준 / 2017, 2018, 2019, 2020, 2021
 *************************/
function gfn_setYearSelBox(objId, addOption, initIdx, baseDt)
{
	if(isEmpty(objId))
		return;
	
	var year = "";
	
	if(isEmpty(baseDt))
		year = gfn_today("YYYY");
	else
		year = baseDt.toString().substr(0, 4);

	if(year.length != 4)
		return;

	// 셀렉트박스 하위 옵션 삭제
	$("#" + objId).empty();
	
	// 전체/선택 옵션 추가
	if(addOption == "A")
		$("#" + objId).append("<option value='ALL'>전체</option>");
	else if(addOption == "C")
		$("#" + objId).append("<option value=''>선택</option>");

	year = parseInt(year) - 3;
	
	for(var i = 0 ; i <= 4 ; i++)
		$("#" + objId).append("<option value='" + (year + i) + "'>" + (year + i) + "</option>");

	if(initIdx >= 0 && initIdx < $("#" + objId + " option").length)
		$("#" + objId + " option:eq(" + initIdx + ")").prop("selected", true);
	else
		$("#" + objId).val(year + 3).prop("selected", true);
}


/*************************
 * Y / N 선택 셀렉트박스 생성 
 * @objId		: 셀렉트 박스 ID
 * @addOption	: 전체 A /선택 C 옵션 추가 여부 / 미입력 시 추가 없음
 * @initIdx		: 초기 선택 인덱스 / 미입력 시 첫번째 값
 * @labelY		: Y 대신 보여줄 라벨 / 미입력 시 Y
 * @labelN		: N 대신 보여줄 라벨 / 미입력 시 N
 * 
 * gfn_setYnSelBox("schLuxrYn")						→ Y, N / 최초값 Y
 * gfn_setYnSelBox("schLuxrYn", "A", 1)				→ 전체, Y, N / 최초값 Y
 * gfn_setYnSelBox("schLuxrYn", "C")				→ 선택, Y, N / 최초값 선택
 * gfn_setYnSelBox("schLuxrYn", "", "YES", "NO")	→ YES, NO / 최초값 YES
 *************************/
function gfn_setYnSelBox(objId, addOption, initIdx, labelY, labelN)
{
	if(isEmpty(objId))
		return;
	
	// 셀렉트박스 하위 옵션 삭제
	$("#" + objId).empty();
	
	// 전체/선택 옵션 추가
	if(addOption == "A")
		$("#" + objId).append("<option value='ALL'>전체</option>");
	else if(addOption == "C")
		$("#" + objId).append("<option value=''>선택</option>");

	if(isEmpty(labelY))
		labelY = "Y";
	
	if(isEmpty(labelN))
		labelN = "N";
	
	$("#" + objId).append("<option value='Y'>" + labelY + "</option>");
	$("#" + objId).append("<option value='N'>" + labelN + "</option>");

	if(initIdx < 0 || initIdx >= $("#" + objId + " option").length)
		initIdx = 0;

	$("#" + objId + " option:eq(" + initIdx + ")").prop("selected", true);
}


/*************************
 * 선정차수 셀렉트박스 생성
 * @objId		: 셀렉트 박스 ID
 * @addOption	: 전체 A /선택 C 옵션 추가 여부 / 미입력 시 추가 없음
 * @initIdx		: 초기 선택 인덱스 / 미입력 시 첫번째 값
 * @maxIdx		: 최대 차수 / 미입력 시 default 설정 값
 * 
 * gfn_setSlctOrdrSelBox("schSlctOrdr")						→ 1차, 2차 / 최초값 1차
 * gfn_setSlctOrdrSelBox("schSlctOrdr", "A")				→ 전체, 1차, 2차 / 최초값 전체
 * gfn_setSlctOrdrSelBox("schSlctOrdr", "C")				→ 선택, 1차, 2차 / 최초값 선택
 * gfn_setSlctOrdrSelBox("schSlctOrdr", "", 1, 4)			→ 1차, 2차, 3차, 4차 / 최초값 2차
 *************************/
function gfn_setSlctOrdrSelBox(objId, addOption, initIdx, maxIdx)
{
	if(isEmpty(objId))
		return;
	
	// 셀렉트박스 하위 옵션 삭제
	$("#" + objId).empty();
	
	// 전체/선택 옵션 추가
	if(addOption == "A")
		$("#" + objId).append("<option value='ALL'>전체</option>");
	else if(addOption == "C")
		$("#" + objId).append("<option value=''>선택</option>");

	// 최대 차수 기본 값 지정
	if(isEmpty(maxIdx))
		maxIdx = 2;

	for(var i=1 ; i<=maxIdx ; i++)
		$("#" + objId).append("<option value='" + i + "'>" + i + "차" + "</option>");

	if(initIdx < 0 || initIdx >= $("#" + objId + " option").length)
		initIdx = 0;

	$("#" + objId + " option:eq(" + initIdx + ")").prop("selected", true);
}


/*************************
 * MVG프로그램코드 셀렉트박스 생성
 * @objId		: 셀렉트 박스 ID
 * @addOption	: 전체 A /선택 C 옵션 추가 여부 / 미입력 시 추가 없음
 * @initIdx		: 초기 선택 인덱스 / 미입력 시 첫번째 값
 * @maxIdx		: 최대 차수 / 미입력 시 default 설정 값
 * 
 * gfn_setSlctOrdrSelBox("schSlctOrdr")						→ 1차, 2차 / 최초값 1차
 * gfn_setSlctOrdrSelBox("schSlctOrdr", "A")				→ 전체, 1차, 2차 / 최초값 전체
 * gfn_setSlctOrdrSelBox("schSlctOrdr", "C")				→ 선택, 1차, 2차 / 최초값 선택
 * gfn_setSlctOrdrSelBox("schSlctOrdr", "", 1, 4)			→ 1차, 2차, 3차, 4차 / 최초값 2차
 *************************/
function gfn_setMvgPgmCdSelBox(objId, addOption, initIdx, maxIdx)
{
	if(isEmpty(objId))
		return;
	
	$.ajax({
		url			: _context + '/ecst/getMvgPgmCdList',
		type		: 'POST',
		cache		: false,
		success		: function(data){
			
			data = JSON.parse(data);

			if(data.RESULT == "S")
			{
				// 셀렉트박스 하위 옵션 삭제
				$("#" + objId).empty();
			
				// 전체/선택 옵션 추가
				if(addOption == "A")
					$("#" + objId).append("<option value='ALL'>전체</option>");
				else if(addOption == "C")
					$("#" + objId).append("<option value=''>선택</option>");
				
				$.each(data.list, function(idx, tmp){
					$("#" + objId).append("<option value='" + tmp.MVG_PGM_CD + "'>" + tmp.MVG_PGM_NM + "</option>");
				})
			}
		}
	});
}


/*************************
 * 신규/수정/삭제 상태인 row count 반환
 * @grid		: 그리드 컴포넌트
 * @type		: row 상태 / 미입력 시 신규, 수정, 삭제 (CUD)
 * 
 * gfn_getModRowCount(master_grid)			→ 상태가 C, U, D인 row count
 * gfn_getModRowCount(master_grid, "C")		→ 상태가 C인 row count
 * gfn_getModRowCount(master_grid, "CU")	→ 상태가 C, U인 row count
 *************************/
function gfn_getModRowCount(grid, type)
{
	if(isEmpty(grid))
		return 0;
	
	if(isEmpty(type))
		type = "CUD";
	
	var cnt = 0;
	
	$.each(grid.getRowData(), function(idx, data){
		if(data.JQGRIDCRUD != "" && type.indexOf(data.JQGRIDCRUD) > -1)
			cnt++;
	})

	return cnt;
}

/*************************
 * 그리드 캘린더 입력 설정
 * @termYn	: from ~ to 캘린더 여부 YN / 미입력 시 N
 * @etc		: 그 외 기타 적용 옵션 (minDate / maxDate / drops 등)
 *************************/
function gfn_setGridYmd(termYn, etc){

	// 단일 일자 또는 기간 설정 여부
	var singleDatePicker = (termYn == "Y") ? false : true;
	
	var options = {
		  linkedCalendars	: false			// 캘린더 날짜 분리
		, showDropdowns		: true			// 날짜 선택번튼
		, singleDatePicker	: singleDatePicker
		, viewModel			: "day"
		, autoUpdateInput	: true
	};
	
	if(isNotEmpty(etc) && Object.keys(etc).length > 0)
		$.extend(options, etc);

	var func = function(e, row){
		$(e).daterangepicker(options);
	}
	
	return {dataInit : func};
}