(function($){

	// DATE FILED 정의
	date_field = {
			YEAR:0,
			MONTH:1,
			DAY:2
	};
	
	// DATE검색 SELECT BOX 설정값
	srch_date_type = {
		TODAY:{value:10,       text:"오늘"},
		THIS_NEXT_WEEK:{value:20,   text:"이번주 + 다음주"},
		THIS_WEEK:{value:30,   text:"이번주"},
		THIS_MONTH:{value:40,  text:"이번달"},
		TOMORROW:{value:110,   text:"내일"},
		NEXT_WEEK:{value:120,  text:"다음주"},
		NEXT_MONTH:{value:130, text:"다음달"},
		YESTERDAY:{value:210,  text:"어제"},
		LAST_WEEK:{value:220,  text:"지난주"},
		LAST_MONTH:{value:230, text:"지난달"}
	};

	/**
	 * STRING 타입을 받아 TIMESTAMP로 변환
	 * STRING 포맷 (YYYY-MM-DD HH:mm:ss)
	 */
	$.stringToTimestamp = function(strTime) {
		
		var matches;
		if(matches = strTime.match(/^(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})$/)) {
			return new Date(matches[1], matches[2] - 1, matches[3]);
		}
		else {
			return new Date();
		}
	};

	/**
	 * STRING 타입을 받아 DATE로 변환
	 * STRING 포맷 (YYYY-MM-DD)
	 */
	$.stringToDate = function(strDate) {
		
		var matches;
		if(matches = strDate.match(/^(\d{4})-(\d{2})-(\d{2})$/)) {
			return new Date(matches[1], matches[2] - 1, matches[3]);
		}
		else {
			return null;
		}
		
	};
	
	/**
	 * TIMESTAMP 타입을 받아 STRING으로 변환
	 * STRING 포맷 (yyyy-MM-dd HH:mm:ss)
	 */
	$.timestampToString = function(date) {

		var year  = date.getFullYear().toString();
		var month = (date.getMonth() + 1).toString();
		var day   = date.getDate().toString();
		var hour  = date.getHours().toString();
		var min   = date.getMinutes().toString();
		var sec   = date.getSeconds().toString();

		month = (month.length == 1)?"0" + month:month;
		day   = (day.length == 1)?"0" + day:day;
		hour  = (hour.length == 1)?"0" + hour:hour;
		min   = (min.length == 1)?"0" + min:min;
		sec   = (sec.length == 1)? "0"+sec : sec;
		
		
		return year + "-" + month + "-" + day + " " + hour + ":" + min + ":" + sec;
		
	};
	
	/**
	 * DATE 타입을 받아 TIMESTAMP으로 변환
	 * STRING 포맷 (yyyy-MM-dd HH:mm:ss)
	 */	
	$.dateToString = function(date) {

		var year  = date.getFullYear().toString();
		var month = (date.getMonth() + 1).toString();
		var day   = date.getDate().toString();

		month = (month.length == 1)?"0" + month:month;
		day   = (day.length == 1)?"0" + day:day;

		return year + "-" + month + "-" + day;

	};
	
	/**
	 * 일자 차이
	 * usage $.dateDiff(date_field.YEAR, '2010-10-21', '2007-09-21');
	 */
	$.dateDiff = function(field, frDate, toDate) {
		
		if(frDate != null) {
			if(typeof(frDate)  == "string") {
				frDate = $.stringToDate(frDate);
			}
		}
		else {
			frDate = new Date();
		}
		
		if(toDate != null) {
			if(typeof(toDate)  == "string") {
				toDate = $.stringToDate(toDate);
			}
		}
		else {
			toDate = frDate;
		}

		msDiff = Math.abs(toDate - frDate); 

		if(field == date_field.YEAR) {        // 몇년
			return parseInt(Math.abs(msDiff / ( 1000 * 3600 * 24 * 365)));
		}
		else if(field == date_field.DAY) {    // 몇일
			return parseInt(Math.abs(msDiff / ( 1000 * 3600 * 24)));
		}
		return 0;
	}
	
	/**
	 * 날짜 계산
	 * usage $.addDate(date_field.YEAR, '2009-09-12', 1)
	 */
	$.addDate = function(field, date, addAmt) {
		
		if(typeof(date) == "string") {
			date = $.stringToDate(date);
		}

		if(date != null) {
			if(field == date_field.YEAR) {
				return $.dateToString(new Date(date.getYear() + addAmt, date.getMonth(), date.getDate()));
			}
			else if(field == date_field.MONTH) {
				return $.dateToString(new Date(date.getYear(), date.getMonth() + addAmt, date.getDate()));
			}
			else {
				return $.dateToString(new Date(date.getYear(), date.getMonth(), date.getDate() + addAmt));
			}
		}
		else {
			return '';
		}
	}
	
	/**
	 * 날짜 입력 필드의 날짜 계산
	 * usage $('#input').addDate(date_field.YEAR, 1)
	 */
	$.fn.addDate = function(field, addAmt) {

		$(this).val($.addDate(field, $(this).val(), addAmt));

	};
	
	/**
	 * 일자 select 박스 생성
	 * usage $('#select').makeDaySelect(2010, 8); 
	 */
	$.fn.makeDaySelect = function(year, month) {
		
		var date = new Date();
		
		if(year  == null || year  == 0) {
			year = date.getYear();
		}
		if(month == null || month == 0) {
			month = date.getMonth();
		}
		
		// 해당월의 마지막일을 구한다.
		date = new Date(year, month + 1, 0);
		var lastDay = date.getDay();
		
		for(var day = 0; day < lastDay; day++) {
			$(this).addOption({
				value:(day.length == 1)?"0" + day:day,
				text:(day.length == 1)?"0" + day:day
			});
		}
	}
	
	/**
	 * 날자 설정 select박스 생성
	 * usage : $('#select').makeDateSelect({
	 *              srch_date_types:[
	 *                  srch_date_type.TODAY,     srch_date_type.THIS_NEXT_WEEK,
	 *                  srch_date_type.THIS_WEEK, srch_date_type.THIS_MONTH
	 *              ],
	 *              from:'srch_period_from',
	 *              to:'srch_period_to',
	 *              def:srch_date_type.TODAY
	 *         );
	 */
	$.fn.makeDateSelect = function(param) {
		return this.each(function() {
			
			var selectElement = this;
			
			if(this.tagName == 'SELECT') {
				if(param.first != null) {
					var option = new Option(param.first.value, param.first.text);
	
					if($.browser.msie) {
						selectElement.add(option);
					}
					else {
						selectElement.add(option, null);
					}
				}
				
				$.each(param.srch_date_types, function (index, srch_date_type) {
	
					var option = new Option(srch_date_type.text, srch_date_type.value);
					
					if(srch_date_type.value == param.def) {
						option.selected = true;
					}

					if($.browser.msie) {
						selectElement.add(option);
					}
					else {
						selectElement.add(option, null);
					}
				});
				
				if(param.def != null) {
					
					$(selectElement).attr('def', param.def.value);
					$.setDateFromTo(param.def.value, param.from, param.to);

					$('#' + param.from).attr('def', $('#' + param.from).val());
					$('#' + param.to).attr('def', $('#' + param.to).val());
				}
			}
			// 이벤트 설정
			$(this).change(function(srchType) {
				if($(this).val().trim() == '') {
					$('#' + param.from).val('');
					$('#' + param.to).val('');
					return;
				}
				$.setDateFromTo($(this).val(), param.from, param.to);
			});
		});
	};
	
	/**
	 * 검색일자 조건 설정
	 **/
	$.setDateFromTo = function(srchDateType, from, to) {
		
		if(srchDateType < 100) { // 현재 일자 검색조건 셋팅
			$.setCurrDateFromTo(srchDateType, from, to);
		}
		else if(srchDateType < 200) { // 미래일자 검색 조건 셋팅
			$.setFutureDateFromTo(srchDateType, from, to);
		}
		else if(srchDateType < 300) { // 과거일자 검색 조건 셋팅
			$.setLastDateFromTo(srchDateType, from, to);
		}
	};


	/**
	 * 현재 일자 검색 조건 처리
	 **/
	$.setCurrDateFromTo = function(srchDateType, from, to) {

		var today = new Date();
		var day  = today.getDay(); // 현재 요일
		var saturday = 6;          // 토요일
		var weekday  = 7;          // 일주일
		var applyDay;

		// 현재 미래 일자 변환 유형
		if(srchDateType == srch_date_type.THIS_NEXT_WEEK.value) { // 이번주 + 다음주

			$('#' + from).val($.dateToString(today));
			
			// 오늘 부터 다음주 토요일 까지 설정
			applyDay = today;
			applyDay.setDate(applyDay.getDate() + (saturday - day + weekday));
			$('#' + to).val($.dateToString(applyDay));
		}
		 else if(srchDateType == srch_date_type.TODAY.value) { // 오늘
		
			// 오늘로 설정
			$('#' + from).val($.dateToString(new Date()));
			$('#' + to).val($.dateToString(new Date()));
		}
		 else if(srchDateType == srch_date_type.THIS_WEEK.value) { // 이번주
				
			// 오늘 부터 다음주 토요일 까지 설정
			applyDay = today;
			$('#' + from).val($.dateToString(today));
			applyDay.setDate(applyDay.getDate() + (saturday - day));
			$('#' + to).val($.dateToString(applyDay));
		}
		 else if(srchDateType == srch_date_type.THIS_MONTH.value) { // 이번달

			// 이번달 1일 부터 마지막일 까지
			applyDay = today;
			var thisMonthFirstDay = new Date(applyDay.getYear(), applyDay.getMonth(), 1);

			$('#' + from).val($.dateToString(thisMonthFirstDay));
			$('#' + to).val($.dateToString(new Date(applyDay.getYear(), thisMonthFirstDay.getMonth() + 1, 0)));
		}
	};

	/**
	 * 미래일자 검색 조건 처리
	 **/
	$.setFutureDateFromTo = function(srchDateType, from, to) {

		var today = new Date();
		var day = today.getDay(); // 현재 요일
		var saturday = 6;         // 토요일
		var weekday = 7;          // 일주일
		var applyDay;

		if(srchDateType == srch_date_type.TOMORROW.value) { // 내일
				
			// 내일로 설정
			applyDay = today;
			applyDay.setDate(applyDay.getDate() + 1);
			$('#' + from).val($.dateToString(applyDay));
			$('#' + to).val($.dateToString(applyDay));
		}
		 else if(srchDateType == srch_date_type.NEXT_WEEK.value) { // 다음주
				
			// 다음주 월요일 부터 다음주 토요일 까지 설정
			applyDay = today;
			applyDay.setDate(applyDay.getDate() + (weekday - day))
			$('#' + from).val($.dateToString(applyDay));

			applyDay.setDate(applyDay.getDate() + saturday);
			$('#' + to).val($.dateToString(applyDay));
		}
		 else if(srchDateType == srch_date_type.NEXT_MONTH.value) { // 다음달

			// 다음달 1일 부터 마지막일 까지
			applyDay = today;
			var nextMonthFirstDay = new Date(applyDay.getYear(), applyDay.getMonth() + 1, 1);

			$('#' + from).val($.dateToString(nextMonthFirstDay));
			$('#' + to).val($.dateToString(new Date(applyDay.getYear(), applyDay.getMonth() + 2, 0)));
			
		} 
	}

	/**
	 * 과거일자 검색 조건 처리
	 **/
	$.setLastDateFromTo = function(srchDateType, from, to) {

		var srchFrm = document.srchFrm;

		var today = new Date();
		var day = today.getDay(); // 현재 요일
		var saturday = 6;         // 토요일
		var weekday = 7;          // 일주일
		var applyDay;

		// 현재 미래 일자 변환 유형
		if(srchDateType == srch_date_type.YESTERDAY.value) { // 어제

			applyDay = today;
			applyDay.setDate(applyDay.getDate() - 1);
			$('#' + from).val($.dateToString(applyDay));
			$('#' + to).val($.dateToString(applyDay));

		}
		 else if(srchDateType == srch_date_type.LAST_WEEK.value) { // 지난주

			// 지난주 월요일 부터 다음주 토요일 까지 설정
			applyDay = today;
			applyDay.setDate(applyDay.getDate() - day);
			$('#' + to).val($.dateToString(applyDay));

			applyDay.setDate(applyDay.getDate() - saturday);
			$('#' + from).val($.dateToString(applyDay));
		
		}
		 else if(srchDateType == srch_date_type.LAST_MONTH.value) { // 지난달

			// 지난달 1일 부터 마지막일 까지
			applyDay = today;
			var lastMonthFirstDay = new Date(applyDay.getYear(), applyDay.getMonth() - 1, 1);

			$('#' + from).val($.dateToString(lastMonthFirstDay));
			$('#' + to).val($.dateToString(new Date(applyDay.getYear(), applyDay.getMonth(), 0)));

		}
	};

})(jQuery);