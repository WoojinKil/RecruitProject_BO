<%-- 
    개요 : 메인
    수정사항 :
        2017-10-28 최초작성
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- java.jsp include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/java.jsp" %>
<!-- jstl include -->
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!-- jstl include -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- tags include -->
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">   
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<!-- meta.jsp include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/meta_main.jsp" %>
<script type="text/javascript">
var rol_app = '<c:out value="${param.rol_app}" />';
var ckAuth = '<c:out value="${param.ckAuth}" />';
var bdp_doc_seq = '<c:out value="${param.doc_seq}" />';

var _multi_window_limit = "10";
getCommonCodeNm("TAB_MAX", function callBackFunc(data) {
	for(var i in data) {
		if(data[i].MST_CD == "TAB_MAX") {
			_multi_window_limit = data[i].REF_1;
			break;
		}
	}
});
</script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3Front/js/common/jquery.bpopup.min.js"></script> --%>
<!-- main.css -->
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/pandora3/css/swiper.min.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/pandora3/css/slick.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/pandora3/css/main.css" />
<link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/pandora3/css/common_new.css' />

<!-- main.js -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/swiper.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/slick.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/main.js"></script>
<script type="text/javascript">

var _existBookMark="N";

function adminInfoTab(){
	
	parent.addTab('','회원상세정보','/psys/forward.psys1014.adm');
}

$(function() {
    var _arSrchMenuList = new Array();
    for(var kk=0; kk < menu_list.length; kk++){
    	var obj = new Object();
        obj.label = menu_list[kk].DETP_FULL_NM;
        obj.value =menu_list[kk].MNU_NM;
        obj.mnu_seq = menu_list[kk].MNU_SEQ;
        obj.url = menu_list[kk].URL;
        _arSrchMenuList.push(obj);
    }

    $("#txtSrchMenu").autocomplete({
        source: _arSrchMenuList,
        select: function(event, ui) {
            var targetMnuSeq  = ui.item.mnu_seq;
            var targetMnuNm =  ui.item.value;
            var targetUrl =ui.item.url;
             parent.addTab(targetMnuSeq, targetMnuNm, targetUrl);
        },
        focus: function(event, ui) {
            return false;
        }
    });
    // 공지사항 더보기 눌렀을때 top,left 메뉴 셋팅
    if(rol_app == "notice"){
        $(".gnb").find(".menu").eq(1).addClass("on").trigger("click").siblings().removeClass("on");
        $(".lnb").find(".depth2").find(".depth3").find("li").eq(1).addClass("on");
    }
    // 사은행사 더보기 눌렀을때 top,left 메뉴 셋팅
    if(rol_app == "thkuEvnt"){
        $(".gnb").find(".menu").eq(1).addClass("on").trigger("click").siblings().removeClass("on");
        $(".lnb").find(".depth2").find(".depth3").find("li").eq(0).addClass("on");
    }
    if(rol_app == "brandReport"){
        $(".gnb").find(".menu").eq(2).addClass("on").trigger("click").siblings().removeClass("on");
        $(".lnb").find(".depth2").find(".depth3").find("li").eq(0).addClass("on");
    }
    
    if(rol_app == "Y"){
        $(".gnb").find(".menu").eq(0).addClass("on").trigger("click").siblings().removeClass("on");
        $(".lnb").find(".depth2").find(".depth3").find("li").eq(0).addClass("on");
    }
    
    if( ckAuth != "Y"){
//      $("#ckAuth").attr("href","${pageContext.request.contextPath}/login/forward.bdpLanding.adm");
    	$("#ckAuth").attr("href","${pageContext.request.contextPath}/login/forward.main.adm");
    }
});

window.onload = function() {
	var MainPopupList
	/* 
	ajax({
		url: '/psys/getPsys1018',
		//type: 'POST',
		success: function(data) {
			MainPopupList = data.mapList;
		},
	}); */
	
	$("body").css("display", "block");
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	/* 
		b popup
	if(!(uagentLow.search("iphone") > -1 || uagentLow.search("android") > -1)) {
		// 메인화면 팝업 호출 
		var b_popup = new Array();
		var popImgUrl = [2];
		var cnt = 0;
		$.each(MainPopupList, function(i, el){
			  var popType = el.TYPE;
			  var popType_bg = el.TYPE_BG
			  var popImg_path =el.IMG_PATH
			  var pointX;
			  var pointY;
			  var popOption = null;
			  var popSize;
			  //popType - 01 : 대, 02 : 소
			  if(popType == '01'){
				  popSize = "mainPopLong";
				  popOption = {width:"500", height:"700"};
				  pointY = 0;
			  }else if(popType == '02'){
				  popSize = 'mainPopShort';
				  popOption = {width:"500", height:"400"};
				  pointY = 0;
			  }
			  var popVer;
			  if(popType_bg == "01") {
				  popVer = 'mainPopVer1'	// 파랑(패턴)
			  } else if(popType_bg == "02") {
				  popVer = 'mainPopVer2';	// 노랑
			  } else if(popType_bg == "03") {
				  popVer = 'mainPopVer3';	// 파랑(이미지)
			  }
			  var txt1 = el.TXT_TOP.replace(/(\n|\r\n)/g, '<br>');
			  //$("#txt_top${status.index}").remove();			  
			  var txt2 = el.TXT_MID.replace(/(\n|\r\n)/g, '<br>');
			  //$("#txt_mid${status.index}").remove();
			  var txt3 = el.TXT_BTM.replace(/(\n|\r\n)/g, '<br>');
			  txt3=txt3.replace(/&lt;/g,"<");
			  txt3=txt3.replace(/&#34;/g,'"');
			  txt3=txt3.replace(/&gt;/g,'>');
			  //&lt;a href=&#34;/pandora3/resources/pandora3Front/files/ta9/pandora3_오류리포트.xlsx&#34; target=&#34;_blank&#34;&gt;&lt;b&gt;파일다운로드&lt;/b&gt;&lt;/a&gt;
			  //$("#txt_btm${status.index}").remove();
			  
			  if(!checkPoupCookie(_filePreFix + popImg_path)){
				  cnt++;
				  pointX = (cnt > 1) ? 500 : 0;
				  var $layer_popup1 = $('<div class="layer_popup layer_popup'+i+'"></div>');
		          var $layer_img = $('<div class="mainPopWrap '+popSize+' '+popVer+'">'
	    				  +	  '<div class="mainPopCon">'
	    				  +		'<h1 class="fix">판도라</h1>'
	    				  +		'<h2 class="tit">'+txt1+'</h2>'
	    				  +		'<h3 class="subTit">'+txt2+'</h3>'
	    				  +		'<div class="txt">'+txt3+'</div>'
	    				  +	  '</div>'
	    				  +   '<p class="logo"><img src="${pageContext.request.contextPath}/resources/pandora3/images/common/popLogo.png" alt="pandora3" /></p>'
	    				  +   '<p class="btn_mainPopClose"><img src="${pageContext.request.contextPath}/resources/pandora3/images/common/main_popup_btn.png" alt="닫기" /></p>'
	    				  +'</div>');
		       	  var $layer_no_see = $('<p id="bottom_bar" style="text-align:right; background-color:black; margin-top:0px; height:40px; line-height:40px; vertical-align:middle;">'
		          + '<input type="checkbox" id="colse'+i+'" style="margin:0 5px 0 0; cursor:pointer" />'
		          + '<label for="colse'+i+'" style = "color:white; padding-right:20px; cursor:pointer">오늘 하루 동안 열지 않음</label>'
		          + '</p>');
		          
		          $("body").append($layer_popup1);
		          $layer_popup1.append($layer_img);
		          $layer_popup1.append($layer_no_see);
		          $(".layer_popup"+i).css(popOption);
	              
	              popImgUrl[i] = _filePreFix + popImg_path;
	              var obj = $(".layer_popup"+i).bPopup({
	                  opacity: 0,
	                  closeClass : "btn_mainPopClose",
	                  position: [50+'%', 50+'%']
	              });
	              b_popup.push(obj)
			  }
			  
			 $("#colse"+i).on("click", function() {
				 //console.log(b_popup[i]);
			 	closePop(b_popup[i], popImgUrl[i]);
			 }); 
		});			
	} */
	
   /*즐겨찾기 등록*/	
	$("#btnPageBookMark").click(function() {
		var selectedTabIdx=0;
		var objNav = $(".ui-tabs-nav li");
		var _tab_cnt = objNav.length;
		var currMenuId =0;
		for(var idx=0; idx < _tab_cnt; idx++){
			var tmpSelected = $(objNav[idx]).attr("aria-selected");
			if(tmpSelected=="true"){
				var tabId =$(objNav[idx]).children('a').attr("href");
				currMenuId =  $(tabId).get(0).contentWindow._menu_id;
			}
		}
		if(_existBookMark=="N"){
			ajax({
				url: '/psys/insertTsysAdmFvrt',
				data :  {mnu_seq:currMenuId},
				success: function(data) {
					changePageBookMark();
				}
			});
		}else{
			if(confirm("즐겨찾기를 삭제하시겠습니까?")){
				ajax({
					url: '/psys/deleteTsysAdmFvrt',
					data :  {mnu_seq:currMenuId},
					success: function(data) {
						_existBookMark=="N";
						checkBookMark();
					}
				});
			}else{
				return;
			}
		}
	});
   
   /*즐겨찾기유무 체크*/
	checkBookMark();
};

function  checkBookMark(){
	 var selectedTabIdx=0;
		var objNav = $(".ui-tabs-nav li");
		var _tab_cnt = objNav.length;
		var currMenuId =0;
		for(var idx=0; idx < _tab_cnt; idx++){
			var tmpSelected = $(objNav[idx]).attr("aria-selected");
			if(tmpSelected=="true"){
				var tabId =$(objNav[idx]).children('a').attr("href");
				currMenuId =  $(tabId).get(0).contentWindow._menu_id;
			}
	  }
		ajax({
			url: '/psys/selectExistTsysAdmFvrt',
			data :  {mnu_seq:currMenuId},
			success: function(data) {
				if(data.EXIST_YN=="Y"){
					$( "#btnPageBookMark" ).addClass( "on" );
					_existBookMark ="Y";
				}else{
					$( "#btnPageBookMark" ).removeClass( "on" );
					_existBookMark ="N";
				}
			}
		})
	  
 }	

function changePageBookMark(){
	$( "#btnPageBookMark" ).addClass( "on" );
	_existBookMark ="Y";
}
function setCookie(name, value, expiredays){
	var todayDate = new Date();
    todayDate.setDate(todayDate.getDate() + expiredays);
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}

function closePop(b_popup, popImgUrl){
	setCookie(popImgUrl, popImgUrl, 1);
	//console.log(b_popup);
    b_popup.close();
}

function checkPoupCookie(cookieName){

	var cookie = document.cookie;
	// 현재 쿠키가 존재할 경우
	if(cookie.length > 0){

		// 자식창에서 set해준 쿠키명이 존재하는지 검색
		startIndex = cookie.indexOf(cookieName);
	
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

//비밀번호 변경 팝업
function callPopupPWChange() {
	
	var popOption = null;
    var popSize;
   
        popOption = {width:"450px", height:"275px"};
        popSize = "mainPopLong";
        pointX = 0;
        pointY = 10;
	
    var $layer_popup1 = $('<div class="layer_popup"></div>');
    
    $("body").append($layer_popup1);
    //$layer_popup1.append($layer_img);
    $(".layer_popup").css(popOption);
    
    b_popup = $(".layer_popup").bPopup({
		//content:'iframe',
        contentContainer:'.layer_popup',
        loadUrl:'${pageContext.request.contextPath}/psys/psys1012Vw',
        position: [50+'%', 50+'%']
    });
   
    $(".layer_popup").draggable();
}

//회원정보 수정 팝업
function callPopupBOInfo() {
	
	var popOption = null;
    var popSize;
   
        popOption = {width:"220px", height:"140px"};
        popSize = "mainPopLong";
        pointX = 0;
        pointY = 10;
    
    var $layer_popup1 = $('<div class="layer_popup"></div>');
    
    $("body").append($layer_popup1);
    //$layer_popup1.append($layer_img);
    $(".layer_popup").css(popOption);
    
    b_popup = $(".layer_popup").bPopup({
        contentContainer:'.layer_popup',
        loadUrl:'${pageContext.request.contextPath}/psys/forward.psys1014p01.adm',
        position: [50+'%', 50+'%']
    });
   
    $(".layer_popup").draggable();
}

/* $("#cancelButton").on("click", function() {
    closePop(b_popup);
    alert("닫기")
}); */

$(window).resize(function(){
	slideEffect();
	// resize시 num 초기화
	/* var sideMenuLeft = $(".sideMenu").css("left");

	if(sideMenuLeft == "0px"){ // open
		num = 1;
	}else{ // close
		num = 2;
	} */

});

function fn_closeTabs() {
	if(!confirm("모든 탭을 닫으시겠습니까?")) return false;
	$("#tabs").find(".tabList ").css("transform", "translate3d(0, 0px, 0px)");
	$('span.tab_close_ico').trigger('click');
}

// 레이어 팝업 OPEN
function openPopLayer(pop_url, params) {
	if(!(typeof pop_url != "undefined" && pop_url != null && pop_url != '')) {
//		console.log("팝업 URL 미입력 오류");
		return;
	}else {
		// 레이어 팝업 생성
		var $layer_popup = $('<div class="layer_popup"></div>');
		$("body").append($layer_popup);
		if(typeof params != "undefined" && params != null && params != '') {
			var existWidth = false;
			var existHeight = false;
			if(typeof params.width != "undefined" && params.width != null && params.width != '') existWidth = true;
			if(typeof params.height != "undefined" && params.height != null && params.height != '') existHeight = true;
			var popOption = {};
			if(existWidth && existHeight) $(".layer_popup").css({ width : params.width, height : params.height });
			else if(existWidth) $(".layer_popup").css({ width : params.width });
			else if(existHeight) $(".layer_popup").css({ height : params.height });
		}
		
		if(pop_url.indexOf("?") > -1) {
			pop_url += "&layer_yn=Y";
		}else {
			pop_url += "?layer_yn=Y";
		}
		
		b_popup = $(".layer_popup").bPopup({
	        contentContainer : ".layer_popup",
	        loadUrl          : "${pageContext.request.contextPath}" + pop_url,
	        position         : ["50%", "50%"]
	    });
		
	    $(".layer_popup").draggable();
	}
}

</script>
<style>
.gnb{
	margin-top:30px !important; 
	font-size:15px;
}
.menu{
	margin:10px;
}
</style>
</head>
<body>

<div id="wrap">
	<!-- header -->
	<div class="header">
		<div>
			<h1 class="headerLogo">
				<a href="${pageContext.request.contextPath}/login/forward.main.adm" id="ckAuth"><img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/pandora3_logo.png" alt="TA9 로고"/></a>
			</h1>
			<!-- gnb -->
			<div class="gnb">
				<p class="screen_out">전체 메뉴</p>
				<div class="gnbList"></div>
			</div>
			<!--// gnb -->
			<!-- id & logout -->
			<div class="headerAcc">
				<!-- <p class=""><strong><%=userInfo.getUser_nm() %></strong></p>
				<p class=""><span class="pipe">|</span><strong><span class="user_edit" onclick="callPopupPWChange()">비밀번호 변경</span></strong></p> -->
				<div class="menuSearch">
					<label class="screenInput">
						<input type="text" name=""  id="txtSrchMenu" placeholder="메뉴명 입력" />
					</label>
					<input type="submit" name="" id="" value="검색" class="searchBtn" />
					<ul>
					</ul>
				</div>
				<p class="btnUserAcc"><strong><span class="user_edit" onclick="callPopupBOInfo()">정보 수정</span></strong></p>
				<p class="btnLogOut"><a href="#" id="logout">Logout</a></p>
			</div>
			<!--// id & logout -->
		</div>
	</div>
	<!--// header -->

	<!-- contents -->
	<div class="contents">
		<!-- side menu -->
		<div class="sideMenu">
				<!-- search
				<form action="" class="search">
					<label for="search" class="screen_out">메뉴 검색</label>
					<input type="text" name="" id="search" placeholder="메뉴명 입력" />
					<input type="submit" name="" id="" value="검색" />
				</form>
				-->
				<!-- lnb -->
				<div class="lnbWrap">
					<p class="userName"><%=userInfo.getUser_nm() %></p>
					<ul class="selectLnb">
						<li class="viewLayout">
							<button class="sideBtn" onClick="sideBtn();">메뉴 닫기</button>
						</li>
						<li class="menuView">
							<a href="#" class="sideMenuViewBtn">메뉴</a>
						</li>
						<li class="bookMark">
							<a href="#" class="sideBookBtn">즐겨찾기</a>
						</li>
					</ul>
					<ul class="lnb fnMenuList on">
					</ul>
					<!-- 북마크  -->
					<ul class="bookLnb fnBookList" id="bookLnbPan">
					</ul>
				</div>
				<!--// lnb -->
				<!-- result 
				<ul class="result" style="display:none">
					<li><a href="#">Caterogy 1-1</a></li>
					<li><a href="#">Caterogy 2-3</a></li>
					<li><a href="#">Caterogy 2-4</a></li>
				</ul>
				-->
				<!-- button -->
				<!-- <p class="sideBtn" onClick="sideBtn();">메뉴 닫기</p> -->
				<!--// button -->
		</div>
		<!--// side menu -->
		<!-- iframe area -->
		<div class="iframe">
			<!-- tab -->
			<div id="tabs" class="tab" >
				<div class="loading" style="display:none;">
				    <img src="${pageContext.request.contextPath}/resources/pandora3/images/common/img_loading_2.gif" alt="loading">
				    <p class="desc">
				        데이터를 불러오고 있습니다 
				        <em>잠시만 기다려주세요</em>
				    </p>
				</div>
				
				<div class="tabWrap">
					<div class="tabControlBtn">
						<a href="#" class="btnArrow arrowprev swiper-button-prev" id="btn_prevTabs"><</a>
						<a href="#" class="btnArrow arrowNext swiper-button-next" id="btn_nextTabs">></a>
						<a href="javascript:fn_closeTabs()" class="btnTabClose" id="btn_closeTabs">X</a>
					</div>
					<div class="tabListWrap swiper-container">
						<ul class="tabList swiper-wrapper"></ul>
					</div>
					
					<button class="btnPageBookMark" id="btnPageBookMark">즐겨찾기</button><!-- 즐겨찾기 추가시 on 클래스 추가  -->
				</div>
				
			</div>
			<!--// tab -->
		</div>
		<!--// iframe area -->
		
		<!-- 메세지 Layer : Global -->
		<%@ include file="/WEB-INF/views/pandora3/common/include/msg_global.jsp" %>
	</div>
	<!--// contents -->
</div>
</body>
</html>
