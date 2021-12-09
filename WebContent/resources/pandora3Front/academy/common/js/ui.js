$(function() {
	mainScroll();
	changeCombo();
	dropList();
	if($(".dtpicker").length) {
		setDatePicker();
	}
});


// 콤보 변경 처리
function changeCombo() {
	var select_target = $('.selectBox .select');
	select_target.change(function(e){
		var $this = $(this);
		var select_name = $("#" + $(this).attr("id") + " option:selected").text();
		$this.siblings('label').text(select_name);
	});
}

// 자주찾는 질문 목록 드롭 & 다운 처리
function dropList() {
	var target = $(".mBoard.typeFaq .listLink");
	target.click(function(e){
		e.preventDefault();
		var $this = $(this);
		$this.toggleClass("on").siblings(".listDetail").slideToggle();
	});
}

// 데이트 피커 셋팅
function setDatePicker() {
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
	
	//날짜 포멧
	$(".dtpicker").datepicker({ dateFormat: 'yy-mm-dd' }).val();
}
// 팝업 닫기
function popClose(thisobj) {
	var $this = $(thisobj);
	var pop_length = $this.closest("#popupWrap").find(".popupBox.show").length;
	if(pop_length === 1) {
		$this.closest("#popupWrap").removeClass("show");
	}
	$this.closest(".popupBox").removeClass("show");
}

function oneDayClose(thisobj,id){
   if($('input:checkbox[id="'+id+'"]').is(":checked")==true){
	   var value = $("#"+id).val();
	   console.log(id); 
	   setCookie(id, value, 1);   
   }
    popClose(thisobj);
   
}

function checkPoupCookie(cookieName){
console.log(cookieName);
    var cookie = document.cookie;
    // 현재 쿠키가 존재할 경우
    if(cookie.length > 0){

        // 자식창에서 set해준 쿠키명이 존재하는지 검색
        startIndex = cookie.indexOf(cookieName);
    
        console.log(startIndex);
        // 존재한다면
        if(startIndex != -1){
               return true;
        }else{
              // 쿠키 내에 해당 쿠키가 존재하지 않을 경우
              return false;
        };
    }else{
        // 쿠키 자체가 없을 경우
        return false;
    };
}

/* cookie */
function setCookie(name, value, expiredays) {
	var todayDate = new Date();
	todayDate.setDate(todayDate.getDate() + expiredays);
	document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}

//메인 스크롤시 header
function mainScroll() {
	
	$(window).scroll(function(){
		var $this = $(this);
		var main_header = $("#header");

		main_header.addClass("notFixed");

		if($this.scrollTop() == 0){
			main_header.removeClass("notFixed");
		}
	});
}