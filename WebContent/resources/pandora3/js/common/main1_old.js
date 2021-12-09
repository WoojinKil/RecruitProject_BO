/**
 * 초기 페이지 구성을 위한 스크립트
 * 작성일 : 2017-10-30
 */

var tabs;
var num = 1;

$(document).ready(function() {

	tabs = $("#tabs").tabs();

	// tab close button
	tabs.delegate( "span.tab_close_ico", "click", function() {
		var panelId = $(this).closest("li").remove().attr("aria-controls");
		$("#"+panelId).remove();
		tabs.tabs("refresh");
	});

	$('#tabs').tabs({
		activate: function (event, ui) {}
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
				popup({url:"/login/forward.login.adm"
					, winname:"_top"
					, title:"로그인"
					, scrollbars:false
					, autoresize:false
				});
			}
		});
	});

	// Menu Element Set
	setMenuElement(0, "gnb", "lnb", true);
	// Slide Effect
	slideEffect();
	// 초기화면 이동
	ajax({
		url:'/main/selectTsysAdmMnuTgt',
		data: {url : '/system/forward.dashBoard.adm'},
		success: function(data) {
			if(isNotEmpty(data.menuInfoMap.menu_id)) {
				addTab(data.menuInfoMap.menu_id, data.menuInfoMap.menu_nm, '/system/forward.dashBoard.adm');
			}
		}
	});
});

//side button click effect	/**
function sideBtn(){
	num++;
};

function addTab(menu_id, menu_nm, url, param, param2) {
	if (_multi_window_limit < $('.ui-tabs-nav li').length+1) {
		alert('최대 추가할 수 있는 화면은 '+_multi_window_limit+'개 입니다');
		return;
	}

	var bodyHeight = $("body").height();
	var headerHeight = $(".header").height();
	var tabHeight = $(".ui-tabs-nav").height(); /* class for jquery-ui flug-in */
	var conWidth = $(".contents").width();
	var sideWidth = $(".sideMenu").width();
	var sideBtnWidth = $(".sideBtn").width();

	var id = "tab-"+menu_id;
	var retParam ="";
	if (typeof url != 'undefined' && url != null && url != ""){
		if(url.indexOf("?")>=0){
			retParam =  _context+url+"&_menu_id="+menu_id+"&_title="+encodeURIComponent(menu_nm);
		}else{
			retParam =  _context+url+"?_menu_id="+menu_id+"&_title="+encodeURIComponent(menu_nm);
		}
	}
	if (typeof param != 'undefined' && param != null && param != "") retParam += "&_param=" + param;
	if (typeof param2 != 'undefined' && param2 != null && param2 != "") retParam += "&_param2=" + param2;

	if(!$('.ui-tabs-nav li a#tabNav-'+id).is('*')) {
		var li = "<li><a href='#"+id+"' id=tabNav-"+id+"><span class='txt'>"+menu_nm+"</span></a> <span class='tab_close_ico'></span>  </li>";	/*<span class='ui-icon ui-icon-close' role='presentation'>Remove Tab</span>*/
		tabs.find(".ui-tabs-nav").append(li);
		tabs.append("<iframe id='"+id+"' name='tabCont' src='"+retParam+"' scrolling='no' frameborder='0' framespacing='0'title='ifrm'></iframe>");
		$("#tabs").css({"width":(conWidth - sideWidth - sideBtnWidth) + "px","height":(bodyHeight - headerHeight - 40) + "px"}); /* 위아래 20px씩 여백때문에 40px 빼줌 */
		$("#tabs").find("iframe").css({"height":(bodyHeight - headerHeight - tabHeight - 40) + "px"}); /* 위아래 20px씩 여백때문에 40px 빼줌 */
		tabs.tabs("refresh");
	} else {
		// 메뉴로 지정되지 않은 탭(상세 페이지)
		$('#'+id).attr("src", retParam);
	}

	$("#tabNav-"+id).click();

}

function resetMenu() {
	$('.gnb').find("ul").html('');
	$('.lnb').html('');
}

// Menu Element Set (Top & Side)
function setMenuElement(selectedGnb, gnbClass, lnbClass) {
	// 메뉴목록조회
	ajax({
		url:'/psys/getTsysAdmMnuList.adm',
		success: function(data) {
			var menus = data.MENU_LIST;
			menu_list = menus;
			if (menus.length) {
				// Top Menu Element Set
				$('.'+gnbClass).find("ul").each(function() {
					var ul = $(this);
					var top_menu_id = null
					var srcPath = _context+'/resources/pandora3/images/common/';
					$.each(menus, function(index, menu){
						if(top_menu_id != menu.TOP_MENU_ID) {
							top_menu_id = menu.TOP_MENU_ID;
							var li = $('<li>');
							li.append()
							li.addClass("menu")
							ul.append(
								li.append(
									$('<a>').attr('href','#').append(
										//$('<img>').attr('src', srcPath+'ico_gnb0'+menu.TOP_SORT_ORD+'.jpg')
											menu.TOP_MENU_NM
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
					$.each(menus, function(index, menu){
						if(index == 0) top_menu_id = menu.TOP_MENU_ID;
						if(top_menu_id != menu.TOP_MENU_ID) {
							top_menu_id = menu.TOP_MENU_ID;
							gnbIndex++;
						}
						if (gnbIndex == selectedGnb) {
							if (menu.SORT_ORD ==  1) {
								list = $('<ul>').attr('class','depth3');
								ul.append(
									$('<li>').attr('class','depth2').append(
									$('<span>').text(menu.MIDD_MENU_NM)).append(list)
								);
							};
							if (menu.MENU_TYPE_CD == '10') {

								list.append(
									$('<li/>').append(
										$('<a>').attr('href', '#').click(function() {
											setSideMenuDepth3Event($(this));
											//console.log(menu);
											addTab(menu.MENU_ID, menu.MENU_NM, menu.URL);
											return false;
										}).text(menu.MENU_NM)
									)
								);
							}
						}

					});
				});

				// Top Menu Event Set
				setTopMenuEvent(gnbClass, selectedGnb);
				// Side Menu Event Set
				setSideMenuDepth2Event(lnbClass);

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

//Top Menu Event effect
function setTopMenuEvent(gnbClass, initGnbIndex) {
	var gnbArr = $("."+gnbClass).find("ul").find("li");

	gnbArr.each(function(){
		$(this).click(function(){
			var clickedIndex = $(this).index();
			// Menu Reset & Menu Element Set
			resetMenu();
			setMenuElement(clickedIndex, "gnb", "lnb");

		})
	});

	// gnb Effect
	gnbArr.eq(initGnbIndex).addClass("on");
	gnbArr.eq(initGnbIndex).siblings("li").removeClass("on");
}

//Side Menu Depth2 Event effect
function setSideMenuDepth2Event(lnbClass) {
	// depth2 Effect
	var depth2Arr = $("."+lnbClass).find(".depth2");
	depth2Arr.each(function(){ // lnb 탭 효과
		$(this).find("span").on("click",function(){
			var lnbIdx = $(this).parents(".depth2").index();
			var depth2 = $(this).closest("."+lnbClass).find(".depth2");

			$(depth2).eq(lnbIdx).find(".depth3").stop().slideToggle();
			$(depth2).eq(lnbIdx).find("span").toggleClass("on");
			$(depth2).not(".depth2:eq(" + lnbIdx + ")").find(".depth3").stop().slideUp();
			$(depth2).not(".depth2:eq(" + lnbIdx + ")").find("span").removeClass("on");
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
	var tabHeight = $(".ui-tabs-nav").height(); /* class for jquery-ui flug-in */
	var conWidth = $(".contents").width();
	var sideWidth = $(".sideMenu").width();
	var sideMenuLeft = $(".sideMenu").css("left");
	var sideBtnWidth = $(".sideBtn").width();

	//$(".menu").css({"margin":"10px"})

	// side menu height
	$(".sideMenu").css({"height":(bodyHeight - headerHeight) + "px","top":headerHeight + "px"});

	// lnb height
	$(".lnbWrap").css({"height":(bodyHeight - headerHeight - searchHeight) + "px"});
	$(".lnbWrap").find(".lnb").css({"height":(bodyHeight - headerHeight - searchHeight) + "px"});

	// result height
	$(".result").css({"height":(bodyHeight - headerHeight - searchHeight - 20) + "px","top":searchHeight + "px"}); /* 위아래 10px씩 여백때문에 20px 빼줌 */

	// tab area defult setting
	$("#tabs").css({"width":(conWidth - sideWidth - sideBtnWidth) + "px","height":(bodyHeight - headerHeight - 40) + "px"}); /* 위아래 20px씩 여백때문에 40px 빼줌 */
	$("#tabs").find("iframe").css({"height":(bodyHeight - headerHeight - tabHeight - 40) + "px"}); /* 위아래 20px씩 여백때문에 40px 빼줌 */

	// side button click effect
	$(".sideBtn").on("click",function(){
		if(num%2 == 0){
			$(".sideMenu").stop().animate({"left":"-180px"},500); // 메뉴 숨기기
			$("#tabs").stop().animate({"width":conWidth + "px"},500); // 표 영역 넓히기
			$(this).css("background-position","-14px 0").text("메뉴 열기"); // 메뉴 열기 버튼 노출

		}else{
			$(".sideMenu").stop().animate({"left":"0"},500); // 메뉴 열기
			$("#tabs").stop().animate({"width":(conWidth - sideWidth - sideBtnWidth) + "px"},500); // 표 영역 좁히기
			$(this).css("background-position","0 0").text("메뉴 닫기"); // 메뉴 닫기 버튼 노출
		};
	});

	// tab width
	if(sideMenuLeft == "0px"){
		$("#tabs").css("width",(conWidth - sideWidth - sideBtnWidth) + "px"); // 표 영역 좁히기
	}else{
		$("#tabs").css("width",conWidth + "px"); // 표 영역 넓히기
	};
}

