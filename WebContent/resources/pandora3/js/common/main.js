/**
 * 초기 페이지 구성을 위한 스크립트
 * 작성일 : 2017-10-30
 */

var tabs;
var num = 1;
var _top_mnu_seq="";
var menu_list ;


$(document).ready(function() {

	tabs = $("#tabs").tabs();

	// tab close button
	tabs.delegate( "span.tab_close_ico", "click", function() {
		var panelId = $(this).closest("li").remove().attr("aria-controls");
		$("#"+panelId).remove();
		tabs.tabs("refresh");
	});

	$('#tabs').tabs({
		activate: function (event, ui) {
			
			var url = ui.newPanel[0].src.substring(ui.newPanel[0].src.indexOf(_context) + _context.length, ui.newPanel[0].src.indexOf('?'));	
			
			preUrl.setPreUrl(url);
		}
	});

	// Click Logo Event
	$('#logo').click(function() {
		popup({url:"/main/login/forward.main.adm"
		, winname:"_top"
		, title:"pandora3"
		, scrollbars:false
		, autoresize:false
		});
	});

	// Click Logout Event
	$('#logout').click(function() {
		ajax({
			url:'/main/logout.adm',
			success: function(data) {
				alert("정상적으로 로그아웃 되었습니다");
				if(isEmpty(opener)) {
					popup({url:"/login/forward.login.adm"
						, winname:"_top"
						, title:"로그인"
						, scrollbars:false
						, autoresize:false
					});
					
				} else {
					opener.window.top.location.href = _context + '/login/forward.login.adm';
					window.close();
				}
				
			}
		});
	});

	if(menu_list != null && menu_list!=undefined && menu_list.length){
		makeMenuElement(0, "gnb", "lnb", true);
	}else{
		setMenuElement(0, "gnb", "lnb", true);
	}
	// Menu Element Set
	//setMenuElement(0, "gnb", "lnb", true);

	// Slide Effect
	slideEffect();
	
	
	if(isNotEmpty(_pre_url) && _pre_url != "/login/forward.main.adm" && _pre_url != "null" && _pre_url != "/login/forward.bdpLanding.adm") {
		// 세션이 끊켰을 경우 이전 프레임
		ajax({
			url:'/main/selectTsysAdmMnuTgt',
			data: {url : _pre_url, sys_cd : _sys_cd},
			success: function(data) {
				if(data.menuInfoMap != null && isNotEmpty(data.menuInfoMap.mnu_seq)) {
					addTab(data.menuInfoMap.mnu_seq, data.menuInfoMap.mnu_nm, _pre_url);
				}
				_pre_url = '';
			}
		});
	} else {
		var url = "";
		// 초기화면 대시보드  이동
		if(isEmpty(rol_app)){
//			url = '/psys/forward.sample1012.adm';
		} else if (rol_app == "notice") {
			url = '/pbbs/forward.pbbs4001.adm';
		} else if (rol_app == "thkuEvnt") {
			url = '/pbbs/forward.pbbs3001.adm';
		} else if (rol_app == "brandReport") {
			url = '/bpcm/forward.bpcm2008.adm';
		} else {
			url = '/psys/forward.psys1039.adm';
		} 
		
		ajax({
			url:'/main/selectTsysAdmMnuTgt',
			data: {url : url, sys_cd : _sys_cd},
			success: function(data) {
				if(data.menuInfoMap != null && isNotEmpty(data.menuInfoMap.mnu_seq)) {
					addTab(data.menuInfoMap.mnu_seq, data.menuInfoMap.mnu_nm, url);
				}
			}
		});
	}
	
});

//side button click effect	/**
function sideBtn(){
	num++;
};
var count=0;
var licount=0;
function addTab(menu_id, menu_nm, url, param, param2, param3) {
	
	var openTabs = false;
	var id = "tab-"+menu_id;
	
	$('.ui-tabs-nav li').each(function(index, item) {
		
		if("#"+id == $(item).children("a").attr("href")) {
			openTabs = true;
		}
	});
	
		
	if ((!openTabs) && _multi_window_limit < $('.ui-tabs-nav li').length+1) {
		alert('최대 추가할 수 있는 화면은 '+_multi_window_limit+'개 입니다');
		return;
	}
	

	var bodyHeight = $("body").height();
	var headerHeight = $(".header").height();
	var tabHeight = $(".tabWrap").outerHeight(); /* class for jquery-ui flug-in */
	var tabWidth = $(".ui-tabs-nav").width(); /* class for jquery-ui flug-in */
	var conWidth = $(".contents").width();
	var sideWidth = $(".sideMenu").width();
	var sideBtnWidth = $(".sideBtn").width();


	
	var retParam ="";
	if (typeof url != 'undefined' && url != null && url != ""){
		if(url.indexOf("?")>=0){
			retParam =  _context+url+"&_mnu_seq="+menu_id+"&_title="+encodeURIComponent(menu_nm);
		}else{
			retParam =  _context+url+"?_mnu_seq="+menu_id+"&_title="+encodeURIComponent(menu_nm);
		}
	}
	if (typeof param != 'undefined' && param != null && param != "") retParam += "&_param=" + param;
	if (typeof param2 != 'undefined' && param2 != null && param2 != "") retParam += "&_param2=" + param2;
	if (typeof param3 != 'undefined' && param3 != null && param3 != "") retParam += "&_param3=" + param3;

	if(!$('.ui-tabs-nav li a#tabNav-'+id).is('*')) {
		var li = "<li class='swiper-slide' id=li"+licount+"><a href='#"+id+"' id=tabNav-"+id+"><span class='txt'>"+menu_nm+"</span></a> <span class='tab_close_ico'></span>  </li>";	/*<span class='ui-icon ui-icon-close' role='presentation'>Remove Tab</span>*/
		tabs.find(".ui-tabs-nav").append(li);
		tabs.append("<iframe id='"+id+"' name='tabCont' src='"+retParam+"' scrolling='no' frameborder='0' framespacing='0' title='ifrm' onload='loading_end()'></iframe>");
		
		$("#tabs").css({"height":(bodyHeight - headerHeight) + "px"});
		$("#tabs").find("iframe").css({"height":(bodyHeight - headerHeight - tabHeight) + "px"}); /* 위아래 20px씩 여백때문에 40px 빼줌 */
		
		main_loading_start();
		
		var storySwiper = new Swiper('.tabListWrap.swiper-container', {
			slidesPerView: 'auto',
		      spaceBetween: 0,
		      freeMode: true,
		      navigation: {
		          nextEl: '.swiper-button-next',
		          prevEl: '.swiper-button-prev',
		        }
		}); 

		var li_length = $("#tabs").find(".tabList > li").length;
		storySwiper.slideTo(li_length-1);
		
		tabs.tabs("refresh");
	} else {
		$("#tabNav-"+id).find("span").html(menu_nm);
		// 메뉴로 지정되지 않은 탭(상세 페이지)
		$('#'+id).attr("src", retParam);
	}

	$("#tabNav-"+id).click();
	licount = $(".ui-tabs-nav li").length;


}
function gnbMenuRolling(){
	var wrapWidth = $(".gnbList").width();
	var eachSum = 0;
	$(".item").each(function(){
		var itemWidth = $(this).outerWidth();
		eachSum += itemWidth;
	})
	if(wrapWidth < eachSum){
		$('.gnbList').addClass("fnSlick");
	}else{
		$('.gnbList').removeClass("fnSlick");
	}

	$('.gnbList.fnSlick').not('.slick-initialized').slick({
		dots: false,
		infinite: false,
		slidesToShow: 4,
		slidesToScroll:4,
		speed: 300,
		centerMode: false,
		draggable: false,
		variableWidth: true,
		focusOnSelect: true
	});
}

function resetMenu() {
	$('.gnbList.fnSlick').slick("unslick");
	$('.gnb').find(".gnbList").html('');
	$('.lnb').html('');
}

// Menu Element Set (Top & Side)
function setMenuElement(selectedGnb, gnbClass, lnbClass) {
	// 메뉴목록조회
	ajax({
		url:'/psys/getTsysAdmMnuList.adm',
		data:{sys_cd : _sys_cd, rol_app : rol_app },
		success: function(data) {
			var menus = data.MENU_LIST;
			menu_list = menus;
			if (menus.length) {
				makeMenuElement(selectedGnb, gnbClass, lnbClass);
			} else {
				alert("사용할 수 있는 메뉴 권한이 없습니다\n관리자에게 문의해 주세요");
				// 사용자 logout 처리
				ajax({
					url:'/main/logout.adm',
					success: function(data) {
						popup({url:"/login/forward.login.adm"
							, winname:"_top"
							, title:"로그인"
							, scrollbars:false
							, autoresize:false
						});
					}
				});
			};

		}
	});
}

function makeMenuElement(selectedGnb, gnbClass, lnbClass){
	
	// Top Menu Element Set
	$('.'+gnbClass).find(".gnbList").each(function() {
		var ul = $(this);
		var top_menu_id = null;
		var srcPath = _context+'/resources/pandora3/images/common/';
		$.each(menu_list, function(index, menu){
			if(top_menu_id != menu.TOP_MNU_SEQ) {
				top_menu_id = menu.TOP_MNU_SEQ;
				var li = $('<div class="item">');
				li.append()
				li.addClass("menu")
				ul.append(
					li.append(
						$('<a>').attr('href','#').append(
							//$('<img>').attr('src', srcPath+'ico_gnb0'+menu.TOP_SORT_ORD+'.jpg')
								menu.TOP_MNU_NM
				)));
			}
		});
	});

	// Side Menu Element Set
	$('.'+lnbClass).each(function() {
		var ul = $(this);
		var list = null;
		var top_menu_id = null;
		var gnbIndex = 0;
		$.each(menu_list, function(index, menu){
			if(index == 0) top_menu_id = menu.TOP_MNU_SEQ;
			if(top_menu_id != menu.TOP_MNU_SEQ) {
				top_menu_id = menu.TOP_MNU_SEQ;
				gnbIndex++;
			}
			if (gnbIndex == selectedGnb) {
				_top_mnu_seq =top_menu_id;
				if (menu.SRT_SEQ ==  1) {
					list = $('<ul>').attr('class','depth3');
					ul.append(
						$('<li>').attr('class','depth2').append(
						$('<span>').html(menu.MIDD_MNU_NM)).append(list)
					);
				};
				if (menu.MNU_TP_CD == '10') {

					list.append(
						$('<li/>').append(
							$('<a>').attr('href', '#').click(function() {
								setSideMenuDepth3Event($(this));
								addTab(menu.MNU_SEQ, menu.MNU_NM, menu.URL);
								return false;
							}).html(menu.MNU_NM)
						)
					);
				}
			}

		});
		
		if(ul.hasClass("on")){
			ul.closest(".lnbWrap").append("<div class='moreControl'><button class='allView' onclick='allView(this)'>전체열기</button><button class='allClose' onclick='allClose(this)'>전체닫기</button></div>")
		} else {
			ul.closest(".lnbWrap").append("<div class='moreControl' style='display: none;'><button class='allView' onclick='allView(this)'>전체열기</button><button class='allClose' onclick='allClose(this)'>전체닫기</button></div>")
		}
	});

	// Top Menu Event Set
	setTopMenuEvent(gnbClass, selectedGnb);
	// Side Menu Event Set
	setSideMenuDepth2Event(lnbClass);	
	
	
}

//
//$(".allView").each(function(){
//	console.log("allview");
//	$(this).on("click",function(){
//		$(this).closest(".lnbWrap .lnb").find("span").not(".on").trigger("click")
//	})
//})
//
//$(".allClose").each(function(){
//	console.log("allclose");
//	$(this).on("click",function(){
//		$(this).closest(".lnbWrap .lnb").find(".depth2 .on").trigger("click")
//	})
//})

function allView(thisobj) {
	var $this = $(thisobj);
	$this.closest(".lnbWrap").find(".lnb span").not(".on").trigger("click");
}

function allClose(thisobj) {
	var $this = $(thisobj);
	$this.closest(".lnbWrap").find(".lnb .depth2 .on").trigger("click");
}

function setBookMarkMenuElement(lnbClass) {
	// 메뉴목록조회
	var selectedGnb =0;
	$('#bookLnbPan').empty();
	ajax({
		url:'/psys/getTsysAdmFvrtList.adm',
		data :  {top_mnu_seq:_top_mnu_seq},
		success: function(data) {
			var bookMarkList = data.rows;
			if (bookMarkList!=undefined && bookMarkList.length >0) {

				// BOOKMARK Element Set
				$('#bookLnbPan').each(function() {
					var ul = $(this);
					var list = null;
					var top_menu_id = null;
					var gnbIndex = 0;
					$.each(bookMarkList, function(index, bookMark){
//						if(index == 0) top_menu_id = bookMark.TOP_MNU_SEQ;
//						if(top_menu_id != bookMark.TOP_MNU_SEQ) {
//							top_menu_id = bookMark.TOP_MNU_SEQ;
//							gnbIndex++;
//						}
						// 즐겨찾기 클릭 시 섹션(고객정보,우수고객선정 등) 관계없이 다 나오게 설정
//						if (gnbIndex == selectedGnb) {
							if (bookMark.MNU_DEPTH ==  1) {        
								var closeAllSrc = _context+'/resources/pandora3/images/common/btn_tab_list_close.png';
								list = $('<ul>').attr('class','depth3');
								ul.append(
									$('<li>').attr('class','depth2').append($('<span>').text(bookMark.MIDD_MNU_NM)
																									.append($('<button>').attr("class","bookClose").append(
																																													$('<img>').attr("src",closeAllSrc).click(function(){  
																																																											deleteBookMark(bookMark.MIDD_MNU_SEQ,'up_mnu_seq');
																																																										})
																									))
																					)
																		.append(list)
									);
							};
							if (bookMark.MNU_TP_CD == '10') {
								var closeSrc = _context+'/resources/pandora3/images/common/bul_lnb_book_mark.png';
								list.append(
										$('<li/>').append($('<button>').attr("class","btnBookMark").append($('<img>').attr("src",closeSrc).click(function(){  
																																														deleteBookMark(bookMark.MNU_SEQ,'mnu_seq');
																																													})
																																	))
										        .append(
													$('<a>').attr('href', '#').click(function() {
														setSideMenuDepth3Event($(this));
														addTab(bookMark.MNU_SEQ, bookMark.MNU_NM, bookMark.URL);
														return false;
													}).text(bookMark.MNU_NM)
											)
									);
							}
//						}

					});
				});
				/*bookmark end*/
				$(".allView").each(function(){
					$(this).on("click",function(){
						$(this).parents(".bookLnb").find("span").not(".on").trigger("click")
					})
				})
			}
			
		}
	});
}

//Top Menu Event effect
function setTopMenuEvent(gnbClass, initGnbIndex) {

	gnbMenuRolling();

	var gnbArr = $("."+gnbClass).find(".gnbList").find(".menu");
	gnbArr.each(function(){
		$(this).click(function(){
			if($(".gnbList").hasClass("fnSlick")){
				var clickedIndex = $(this).parents(".slick-slide").index();
			}else{
				var clickedIndex = $(this).index();
			}

			// Menu Reset & Menu Element Set
			resetMenu();
			if(menu_list != null && menu_list!=undefined && menu_list.length){
				makeMenuElement(clickedIndex, "gnb", "lnb");
			}else{
				setMenuElement(clickedIndex, "gnb", "lnb");
			}
			
			setTopMenuEvent();
			$('.gnbList.fnSlick').slick('slickGoTo', clickedIndex, true);
			
			$(".menuView").addClass("on")
			$(".bookMark").removeClass("on")
			$(".fnBookList").hide()
			$(".fnMenuList").show()
		})
	});

	// gnb Effect
	gnbArr.eq(initGnbIndex).addClass("on");
	gnbArr.eq(initGnbIndex).siblings(".menu").removeClass("on");


	if(!$(".lnbWrap").find(".lnb").hasClass("on")) {
		$(".sideBtn").trigger("click");
	}
	
}

//onceResize();
windowResize()

function windowResize(){
	//windowResize
	var ww = $(window).width();
	var limit = 1300;
	var tOut;
	function refresh() {
		ww = $(window).width();
		var w = ww < limit ? (onceResize()) : (ww > limit ? (onceResize()) : ww = limit);
	}
	$(window).resize(function () {
		var resW = $(window).width();
		clearTimeout(tOut);
		if ((ww > limit && resW < limit) || (ww < limit && resW > limit)) {
			tOut = setTimeout(refresh, 100);
		}
	});
}

function onceResize(){
	if($(".gnbList").hasClass("fnSlick")){
		var clickedIndex = $(".menu.on").parents(".slick-slide").index();
	}else{
		var clickedIndex = $(".menu.on").index();
	}
	
	tabs.tabs("refresh");
	gnbMenuRolling();
	resetMenu();
	if(menu_list != null && menu_list!=undefined && menu_list.length){
		makeMenuElement(clickedIndex, "gnb", "lnb");
	}else{
		setMenuElement(clickedIndex, "gnb", "lnb");
	}
	setTopMenuEvent();

}



//Side Menu Depth2 Event effect
function setSideMenuDepth2Event(lnbClass) {
	// depth2 Effect
	var depth2Arr = $("."+lnbClass).find(".depth2");
	depth2Arr.each(function(){ // lnb 탭 효과
		$(this).find("span").on("click",function(){
			var lnbIdx = $(this).parents(".depth2").index();
			var depth2 = $(this).closest("."+lnbClass).find(".depth2");

			$(depth2).eq(lnbIdx).find(".depth3").stop().slideToggle(200);
			$(depth2).eq(lnbIdx).find("span").toggleClass("on");
			//$(depth2).not(".depth2:eq(" + lnbIdx + ")").find(".depth3").stop().slideUp();
			//$(depth2).not(".depth2:eq(" + lnbIdx + ")").find("span").removeClass("on");
		});
	});

	depth2Arr.eq(0).find("span").trigger("click");
}

//Side Menu Depth3 Event effect
function setSideMenuDepth3Event(obj){
	// depth3 Effect
	obj.parent().addClass("on");
	obj.parent().siblings("li").removeClass("on");
	obj.parents(".depth2").siblings("li").find(".depth3").find("li").removeClass("on");
}

// Slide Effect
function slideEffect(){
	// 변수
	var bodyHeight = $("body").height();
	var headerHeight = $(".header").height();
	var searchHeight = $(".search").height() + 26; /* 위 아래 margin:13px때문에 26 더해줌 */
	var tabHeight = $(".tabWrap").outerHeight(); /* class for jquery-ui flug-in */
	var conWidth = $(".contents").width();
	var sideWidth = $(".sideMenu").width();
	var sideMenuLeft = $(".sideMenu").css("left");
	var sideBtnWidth = $(".sideBtn").width();

	//$(".menu").css({"margin":"10px"})

	// side menu height
	$(".sideMenu").css({"height":(bodyHeight - headerHeight) + "px","top":headerHeight + "px"});

	// lnb height
	//$(".lnbWrap").css({"height":(bodyHeight - headerHeight - searchHeight) + "px"});
	/*$(".lnbWrap").find(".lnb").css({"height":(bodyHeight - headerHeight - 88) + "px"});*/ /* 유저 네임 41px + 전체 닫기 열기 47px 빼줌 */
	/*$(".lnbWrap").find(".bookLnb" ).css({"height":(bodyHeight - headerHeight) + "px"});*/

	// result height
	$(".result").css({"height":(bodyHeight - headerHeight - searchHeight - 10) + "px","top":searchHeight + "px"}); /* 위아래 10px씩 여백때문에 20px 빼줌 */

	// tab area defult setting
	$("#tabs").css({"height":(bodyHeight - headerHeight) + "px"});
	$("#tabs").find("iframe").css({"height":(bodyHeight - headerHeight - tabHeight) + "px"}); /* 위아래 20px씩 여백때문에 40px 빼줌 */

	// side button click effect
	$(".sideBtn").on("click",function(){
		tabs.tabs("refresh");
		
		if(num%2 == 0){
			$(this).addClass("on");
			$(".lnb").removeClass("on");
			$(".lnbWrap .moreControl").hide();
			$(".header").addClass("folded");
			$(".lnb, .userName").stop().animate({"left":"-180px"}, 400); // 메뉴 숨기기
			$(".sideMenu").stop().animate({"width":"44px"}, 400);
			$(".contents").stop().animate({"padding-left":"44px"}, 400);
		}else{
			$(this).removeClass("on");
			$(".lnb").addClass("on");
			$(".lnb, .userName").stop().animate({"left":"44px"},400,function(){
				$(".lnbWrap .moreControl").show();
			}); // 메뉴 열기
			$(".header").removeClass("folded");
			$(".sideMenu").stop().animate({"width":"224px"},400);
			$(".contents").stop().animate({"padding-left":"224px"},400);
		};

	});


	// tab width
	/*
	if(sideMenuLeft == "0px"){
		$("#tabs").css("width",(conWidth) + "px"); // 표 영역 좁히기
	}else{
		$("#tabs").css("width",conWidth + "px"); // 표 영역 넓히기
	};
	*/

	$(".menuView").on("click", function(){
		$(this).addClass("on")
		$(".bookMark").removeClass("on")
		$(".fnBookList").hide()
		$(".fnMenuList").show()
		$(".lnbWrap .moreControl").show();
	})
	$(".bookMark").on("click", function(){
		//alert();
		$(this).addClass("on")
		$(".menuView").removeClass("on");
		$(".fnMenuList").hide();
		$(".fnBookList").show();
		$(".lnbWrap .moreControl").hide();
		setBookMarkMenuElement();
	})
	$(".menuView").trigger("click")

}

/*북마크삭제*/
function deleteBookMark(mnuSeq,gbn){
	if(confirm("즐겨찾기를 삭제하시겠습니까?")){
		if(gbn=="mnu_seq"){
			ajax({
				url: '/psys/deleteTsysAdmFvrt',
				data :  {mnu_seq:mnuSeq},
				success: function(data) {
					setBookMarkMenuElement();
				}
			});
		}else{
			ajax({
				url: '/psys/deleteUpMnuTsysAdmFvrt',
				data :  {up_mnu_seq:mnuSeq},
				success: function(data) {
					setBookMarkMenuElement();
				}
			});
		}
				
	}else{
		return false;
	}
}

