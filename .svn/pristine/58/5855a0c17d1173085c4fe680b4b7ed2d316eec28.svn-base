/* gnb */
function gnb() {
	var $body = $('html, body'),
		wrap = $('#wrap'),
		gnb = $('#gnb'),
		gnbWrap = gnb.find('.gnb_wrap'),
		gnbMenu = $('.gnb_list > li > a'),
		btnOpen = $('.btn_gnb_open button'),
		btnClose = $('.btn_gnb_close button'),
		gnbClose = function() {
			wrap.removeClass('menu_open');
			gnbMenu.parent().removeClass('active');
			$body.css({'height':'','overflow':''});
		};
		
	gnb.on('mouseleave', function(){gnbClose()});
	btnOpen.on('click', function(){
		wrap.addClass('menu_open');
		$body.css({'height':'100%','overflow':'hidden'});
		gnb.bind('touchmove', function(){event.preventDefault()});
		gnbWrap.bind('touchmove',function(){event.stopPropagation()});
	});
	btnClose.on('click', function(){
		gnbClose();
		$('.gnb_2depth_list').slideUp(300);
		gnbWrap.unbind('touchmove');
	});
	gnb.on('click', function(){wrap.removeClass('menu_open')});
	gnbWrap.on('click', function(){event.stopPropagation()});
	gnbMenu.on({
		mouseenter : function() {
			if(window.innerWidth >= 1024) {
				var $this = $(this),
					thisParent = $this.parent();

				wrap.addClass('menu_open');
				thisParent.addClass('active').siblings().removeClass('active');
			}
		},
		click : function() {
			if(window.innerWidth < 1024) {
				var $this = $(this),
					thisParent = $this.parent();
				
				if(thisParent.hasClass('active')) {
					thisParent.removeClass('active').find('.gnb_2depth_list').slideUp(300);
				} else {
					thisParent.addClass('active').siblings().removeClass('active');
					thisParent.find('.gnb_2depth_list').slideDown(300);
					thisParent.siblings().find('.gnb_2depth_list').slideUp(300);
				}
				return false;
			}
		}
	});
}

/* cookie */
function setCookie(name, value, expiredays) {
	var todayDate = new Date();
	todayDate.setDate(todayDate.getDate() + expiredays);
	document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}
function getCookie(name) {
	var i,x,y,ARRcookies=document.cookie.split(";");
	for (i=0;i<ARRcookies.length;i++) {
		x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
		y=ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
		x=x.replace(/^\s+|\s+$/g,"");

		if (x==name) return unescape(y);
	}
}

$(function(){
	gnb();
});