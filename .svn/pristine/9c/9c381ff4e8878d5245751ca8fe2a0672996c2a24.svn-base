<%-- 
    개요     : 메세지 풋터(공통) - LOCAL
    수정사항 : 2019-02-11
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- ALERT -->
<div class="popup alert_popup">
	<div class="pop_container">
		<div class="popup_img">
			<img src="${pageContext.request.contextPath}/resources/pandora3/images/common/img-caution.png" alt="CAUTION 이미지">
		</div>
		<div class="txt_dialog message"></div>
	</div>
	<p class="foot_btn">
		<a href="#" class="btn_confirm btn_modal_alert">확인</a>
	</p>
</div>
<!-- CONFIRM -->
<div class="popup confirm_popup">
	<div class="pop_container">
		<div class="popup_img">
			<img src="${pageContext.request.contextPath}/resources/pandora3/images/common/img-question.png" alt="QUESTION 이미지">
		</div>
		<div class="txt_dialog message"></div>
	</div>
	<p class="foot_btn">
		<a href="#" class="btn_confirm btn_modal_confirm">확인</a>
		<a href="#" class="btn_cancel btn_modal_close">취소</a>
	</p>
</div>
<!-- ERROR -->
<div class="popup error_popup">
	<div class="pop_container">
		<div class="popup_img">
			<img src="${pageContext.request.contextPath}/resources/pandora3/images/common/img-warning.png" alt="WARNING 이미지">
		</div>
		<div class="txt_dialog message"></div>
	</div>
	<p class="foot_btn">
		<a href="#" class="btn_confirm btn_modal_error">확인</a>
	</p>
</div>
<script type="text/javascript">
var LMsgLayer = {
	target : {
		alert   : $(".popup.alert_popup"),
		confirm : $(".popup.confirm_popup"),
		error   : $(".popup.error_popup")
	},
	overflow : $("body").css("overflow"),
	// 레이어 OPEN
	open : function(target, type, msg) {
		// 메세지 박스 초기화
		var cloneObj;
		if("alert" == type) cloneObj = target.clone();
		if("confirm" == type) cloneObj = target.clone();
		if("error" == type) cloneObj = target.clone();
		target.empty().append(cloneObj.html());
		
		// 메세지 셋팅
		if(!isEmpty(msg)) target.find(".message").html(msg);
		
		// 메세지 위치 조정 및 Dim 처리
		var wHeight = $(window).height();
		var oHeight = target.height();
		var oWidth = target.width();
		if($(".modal_bg").length > 0) {
			var zIndex = $(".modal_bg:last").css("z-Index");
			$("html,body").css("overflow", "hidden");
			target.css({
				top        : '50%',
				left       : '50%',
				visibility : 'visible',
				zIndex     : (parseInt(zIndex)+3)
			});
			$("body").append('<div class="modal_bg" style="z-index:'+(parseInt(zIndex)+2)+'"></div>');
		}else {
			$("html,body").css("overflow","hidden");
			target.css({
				top        : '50%',
				left       : '50%',
				visibility : 'visible'
			});
			$("body").append("<div class='modal_bg'></div>");
		}
		
		// 메세지 박스 드레그 - 드래그 버그로 인한 주석 처리
		//target.draggable();
		
		// 닫기 버튼 클릭 시
		$(".btn_modal_close", target).click(function(e) {
			e.preventDefault();
			$("html,body").css("overflow", LMsgLayer.overflow); 
			$(".modal_bg:last-child").remove();
			$(this).parents(".popup").css({top:"-9999px",visibility:"hidden"});
		});
	},
	// ALERT 레이어
	alert : function(msg, callback) {
		// 레이어 OPEN
		LMsgLayer.open(LMsgLayer.target.alert, "alert", msg);
		
		// 확인 버튼 클릭 시
		$(".btn_modal_alert", LMsgLayer.target.alert).click(function(e) {
			e.preventDefault();
			
			// 레이어 CLOSE
			$("html,body").css("overflow", LMsgLayer.overflow);
			$(".modal_bg:last-child").remove();
			$(this).parents(".popup").css({top:"-9999px",visibility:"hidden"});
			
			// 레이어 CLOSE 후 콜백함수 호출
			if(!isEmpty(callback)) {
				// 기본 함수
				if(typeof callback == "function") {
					callback();
				}
				// 사용자 정의 함수
				else {
					if(callback) {
						if(callback.indexOf("(") == -1) eval(callback +"()");
						else eval(callback);
					}
				}
				
				// 언클릭
				$(this).unbind("click");
			}
		});
	},
	// CONFIRM 레이어
	confirm : function(msg, callback) {
		// 레이어 OPEN
		LMsgLayer.open(LMsgLayer.target.confirm, "confirm", msg);
		
		// 확인 버튼 클릭 시
		$(".btn_modal_confirm", LMsgLayer.target.confirm).click(function(e) {
			e.preventDefault();
			
			// 레이어 CLOSE
			$("html,body").css("overflow", LMsgLayer.overflow);
			$(".modal_bg:last-child").remove();
			$(this).parents(".popup").css({top:"-9999px",visibility:"hidden"});
			
			// 레이어 CLOSE 후 콜백함수 호출
			if(!isEmpty(callback)) {
				// 기본 함수
				if(typeof callback == "function") {
					callback();
				}
				// 사용자 정의 함수
				else {
					if(callback) {
						if(callback.indexOf("(") == -1) eval(callback +"()");
						else eval(callback);
					}
				}
				
				// 언클릭
				$(this).unbind("click");
			}
		});
	},
	// ERROR 레이어
	error : function(msg, callback) {
		// 레이어 OPEN
		LMsgLayer.open(LMsgLayer.target.error, "error", msg);
		
		// 확인 버튼 클릭 시
		$(".btn_modal_error", LMsgLayer.target.error).click(function(e) {
			e.preventDefault();
			
			// 레이어 CLOSE
			$("html,body").css("overflow", LMsgLayer.overflow);
			$(".modal_bg:last-child").remove();
			$(this).parents(".popup").css({top:"-9999px",visibility:"hidden"});
			
			// 레이어 CLOSE 후 콜백함수 호출
			if(!isEmpty(callback)) {
				// 기본 함수
				if(typeof callback == "function") {
					callback();
				}
				// 사용자 정의 함수
				else {
					if(callback) {
						if(callback.indexOf("(") == -1) eval(callback +"()");
						else eval(callback);
					}
				}
				
				// 언클릭
				$(this).unbind("click");
			}
		});
	}
};
</script>