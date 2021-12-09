<%-- 
   1. 파일명 : main
   2. 파일설명: (공통) BUSINESS IT ACADEMY 메인
   3. 작성일 : 2019-03-25
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/meta.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=_resourcePath%>/common/css/main.css">
<script type="text/javascript">
var mnIntroListSize = "${mnIntroListSize}";
var mnBnnrListSize = "${mnBnnrListSize}";
var mnPopListSize   = "${mnPopListSize}";
$(document).ready(function() {
	// 초기화
	
});

// 초기화
function doInit() {
	// 메인 슬라이드 처리
	mainSlide();
	
	// 비지니스 IT 소개, 공간대여 안내 URL 취득
	var noti_max_cnt = "${notiEtcInf.noti_max_cnt}";
	if(parseInt(noti_max_cnt, 10) < 3) {
		var mst_cd_str_arr = "TMPL_INF_CD";
		getCommCdList(mst_cd_str_arr, function callBackFunc(data) {
			for(var i in data) {
				if(isNotEmpty(data[i].CD)) {
					// 비지니스 IT 소개
					if(data[i].CD == "AINTR") {
						$("#mainlink" + data[i].CD).append('<a href="' + _context + chgEmptyUrl(data[i].CD_DESC) + '" class="moreBtn">more</a>');
					}
					// 공간대여 안내
					else if(data[i].CD == "ALNDG") {
						$("#mainlink" + data[i].CD).append('<a href="' + _context + chgEmptyUrl(data[i].CD_DESC) + '" class="rentalLink">공간대여 안내 바로가기</a>');
					}
				}
			}
		});
	}
	var pop_length = $("#popupWrap").find(".popupBox.show").length;
	
	if(pop_length === 0) {
		$("#popupWrap").removeClass("show");
	}
	
}

// 메인 슬라이드 처리
function mainSlide() {
	var main_slide = $(".slide li");
	main_slide.each(function() {
		var $this = $(this);
		var src = $this.find(".slide-img img").attr("src");
		$this.css("background-image" , "url("+src+")");
	});
	// 메인 상단 배너
	var mnTopBnnrSize = $(".main-swiper1 > ul > li").size();
	if(mnTopBnnrSize > 1) {
		new Swiper('.main-swiper1', {
			loop: true,
			pagination: {
				el: '.swiper-pagination1',
				clickable: true
			},
			autoplay: {
				delay: 4000,
				disableOnInteraction: false
			}
		});
	}
	// 메인 수강 소개 배너
	if(mnIntroListSize > 4) {
		new Swiper('.main-swiper2', {
			loop: true,
			slidesPerView: 6,
			centeredSlides: true,
			spaceBetween: 30,
			grabCursor: true,
			autoplay: {
				delay: 3000,
				disableOnInteraction: false,
			},
		});
	}else {
		new Swiper('.main-swiper2', {
			slidesPerView: 6,
			spaceBetween: 30,
			centerInsufficientSlides: true
		});
	}
	// 메인 이벤트 배너
	if(mnBnnrListSize > 1) {
		new Swiper('.main-swiper3', {
			loop: true,
			pagination: {
				el: '.swiper-pagination3'
			},
			autoplay: {
				delay: 4000,
				disableOnInteraction: false
			}
		});
	}
}
</script>
<body>
	<div id="wrap">
		<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/header.jsp" %>
		<!-- Container -->
		<div id="container">
			<div id="mainBanner">
				<div class="swiper-container main-swiper1">
					<ul class="slide swiper-wrapper">
						<li class="swiper-slide">
							<div class="slide-img">
								<img src="<%=_resourcePath%>/common/images/img_main_slide_1.jpg" alt="메인 배너 이미지 1" />
							</div>
							<div class="slide-text">
								<img src="<%=_resourcePath%>/common/images/img_main_slide_text_1.png" alt="메인 배너 텍스트 1" />
							</div>
							<!-- <div class="slide-text">
								<div class="slide-inner">
									<p>비즈니스IT와<br /><strong>함께</strong><br /><strong>정상</strong>에<br /><strong>도전</strong>하세요!</p>
								</div>
							</div> -->
						</li>
						<li class="swiper-slide">
							<div class="slide-img">
								<img src="<%=_resourcePath%>/common/images/img_main_slide_2.jpg" alt="메인 배너 이미지 2" />
							</div>
							<div class="slide-text">
								<img src="<%=_resourcePath%>/common/images/img_main_slide_text_2.png" alt="메인 배너 텍스트 2" />
							</div>
						</li>
						<li class="swiper-slide">
							<div class="slide-img">
								<img src="<%=_resourcePath%>/common/images/img_main_slide_3.jpg" alt="메인 배너 이미지 3" />
							</div>
							<div class="slide-text">
								<img src="<%=_resourcePath%>/common/images/img_main_slide_text_3.png" alt="메인 배너 텍스트 3" />
							</div>
						</li>
						<li class="swiper-slide">
							<div class="slide-img">
								<img src="<%=_resourcePath%>/common/images/img_main_slide_4.jpg" alt="메인 배너 이미지 4" />
							</div>
							<div class="slide-text">
								<img src="<%=_resourcePath%>/common/images/img_main_slide_text_4.png" alt="메인 배너 텍스트 4" />
							</div>
						</li>
						<li class="swiper-slide">
							<div class="slide-img">
								<img src="<%=_resourcePath%>/common/images/img_main_slide_5.jpg" alt="메인 배너 이미지 5" />
							</div>
							<div class="slide-text">
								<img src="<%=_resourcePath%>/common/images/img_main_slide_text_5.png" alt="메인 배너 텍스트 5" />
							</div> 
						</li>
					</ul>
				</div>
				<div class="swiper-pagination1"></div>
			</div>
			<c:if test="${mnIntroListSize > 0}">
			<div class="mainCourse">
				<div class="swiper-container  main-swiper2 courseInner">
					<ul class="swiper-wrapper couseList">
						<c:forEach var="list" items="${mnIntroList}" varStatus="status">
						<li class="swiper-slide">
							<img class="courseImg" src="<%=_basicResourcePath%>${list.upl_fl_nm}" alt="${list.titl} ${list.cts}">
							<div class="textWrap">
								<p class="title">${list.titl}</p>
								<p class="desc">${list.cts}</p>
								<a href="${pageContext.request.contextPath}${list.url_info}" class="courseMore">자세히보기</a>
							</div>
						</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			</c:if>
			
			<div id="content" class="main">
				<div class="contentInner">
					<div class="mainIntroduce">
						<div class="titleWrap">
							<h2 class="title">비즈니스 IT 학원<em>소개</em></h2>
						</div>
						<div class="descWrap">
							<div class="descInner">
								<div class="imgWrap">
									<img src="<%=_resourcePath%>/common/images/img_gallery_view_2.jpg" alt="비즈니스It 강의실">
								</div>
								<div class="desc">
									<p>
									<strong class="infoTitle">4차 산업 혁명을 선도하는 실무 중심의 IT 기술 교육의 메카!</strong>
									최신 IT 기술 트렌드를 접목한 실무 중심의 교육으로 대한민국 4차 산업 혁명 시대의 미래를  비즈니스 IT 학원이 열어가겠습니다.
									비즈니스 IT 학원은 직업능력개발훈련을 통해 SW 및 IT 전문 기술 인력을 양성하여 사회적, 범국가적 사업의 일환인 
									'일자리 창출'에 기여할 수 있도록 노력하고 있으며, 주요 교육 분야는 Java Frameworks, 빅데이터, UI/UX 등의 직종
									분야을 중심으로 구직자 취업교육과 재직자 직무교육을 실시하고 있습니다.
									</p>
									<div id="mainlinkAINTR"></div>
								</div>
							</div>
						</div>
					</div>
					<c:if test="${mnBnnrListSize > 0}">
					<div class="mainBanner2">
						<div class="swiper-container main-swiper3">
							<ul class="slide3 swiper-wrapper">
								<c:forEach var="list" items="${mnBnnrList}" varStatus="status">
								<li class="swiper-slide">
									<c:if test="${not empty list.url_info}">
									<a href="${pageContext.request.contextPath}${list.url_info}">
									</c:if>
										<img src="<%=_basicResourcePath%>${list.upl_fl_nm}" alt="${list.cts}">
									<c:if test="${not empty list.url_info}">
									</a>
									</c:if>
								</li>
								</c:forEach>
							</ul>
						</div>
						<div class="swiper-pagination3"></div>
					</div>
					</c:if>
					<c:if test="${mnNotiListSize > 0}">
					<div class="mainNotice">
						<c:choose>
						<c:when test="${notiEtcInf.noti_max_cnt > 2}">
						<div class="noticeInner type_${mnNotiListSize} typeNoRight">
						</c:when>
						<c:otherwise>
						<div class="noticeInner type_${mnNotiListSize}">
						</c:otherwise>
						</c:choose>
							<div class="leftArea">
								<div class="titleWrap">
									<h2 class="title">비지니스 IT <em>공지사항</em></h2>
									<a href="${pageContext.request.contextPath}${notiEtcInf.url_info}" class="moreBtn">more</a>
								</div>
								<div class="listWrap">
									<ul class="noticeList">
										<c:forEach var="list" items="${mnNotiList}" varStatus="status">
										<li>
											<a href="${pageContext.request.contextPath}${list.url_info}" class="noticeContent">
												<p class="noticeTitle">${list.titl}</p>
												<%-- <p class="noticeDate">${list.f_crt_dttm}</p> --%>
												<p class="noticeDesc">${list.cts}</p>
											</a>
										</li>
										</c:forEach>
									</ul>
								</div>
							</div>
						
							<c:if test="${notiEtcInf.noti_max_cnt < 3}">
							<div class="rightArea">
								<div class="rightInner">
									<img src="<%=_resourcePath%>/common/images/main/img_free_lecture.png" alt="비즈니스 IT 학원 무료 강의 안내, 매주 수요일 12명 선착순 무료강의를 진행합니다. (사전예약필수)">
									<!-- <div id="mainlinkALNDG"></div> -->
								</div>
							</div>
							</c:if>
						</div>
					</div>		
					</c:if>
				</div>
			</div>
		</div>
		<!-- //Container -->
        <%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/footer.jsp" %>
	</div>
	<!-- 팝업 -->
	<c:if test="${mnPopListSize >0}">
	   <c:set var="width" value=""/>
	   <c:set var="height" value="" />
	  <div id="popupWrap" class="show">
	  	<c:forEach var="list" items="${mnPopList}"   varStatus="status">
	  		<c:choose>
				<c:when test="${list.pop_kd_cd eq '10'}">
					<c:set var="width">600px</c:set>
					<c:set var="height">400px</c:set>
				</c:when>
				<c:when test="${list.pop_kd_cd eq '20'}">
					<c:set var="width">600px</c:set>
					<c:set var="height">700px</c:set>
				</c:when>
			</c:choose>
			
	  		<c:if test="${list.pop_kd_cd eq '10'}">  <!-- TextType -->
	  			<div class="popupBox show">
					<button type="button" class="popClose" onclick="oneDayClose(this,'popChk${status.index}')">닫기</button>
					<div class="popupContent bgBlue"  style="width:${width};height:${height}">
						<div class="popContentInner">
							<div class="bnrTitle">${list.top_txt}</div>
							<div class="bnrDesc">
								<div class="desInner">
									<div class="desContent">
										<span class="centerText">
											<span class="eventDate">${list.mid_txt}</span>
										</span>
										<div class="bottomText">${list.btm_txt}</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="popupFooter">
						<div class="popDayClose">
							<input type="checkbox" id="popChk${status.index}" value="${status.index}">
							<label for="popChk${status.index}">오늘 하루 열지 않음</label>
						</div>
					</div>
				</div>
				<script type="text/javascript">
				if (checkPoupCookie("popChk${status.index}")) {
					$("#"+"popChk${status.index}").closest(".popupBox").removeClass("show");
				}
				</script>
	  		</c:if>
	  		<c:if test="${list.pop_kd_cd eq '20'}">  <!-- URL type  typeSmall -->
	  			<div class="popupBox show">
					<button type="button" class="popClose" onclick="oneDayClose(this,'popChk${status.index}')">닫기</button>
					<div class="popupContent bgBlue"  style="width:${width};height:${height}">
							<iframe  src="${list.pop_url}" style="border:0 none; width:100%; height:100%;"></iframe>
					</div>
					<div class="popupFooter">
						<div class="popDayClose">
							<input type="checkbox" id="popChk${status.index}" value="${status.index}">
							<label for="popChk${status.index}">오늘 하루 열지 않음</label>
						</div>
					</div>
				</div>
				<script type="text/javascript">
				if (checkPoupCookie("popChk${status.index}")) {
					$("#"+"popChk${status.index}").closest(".popupBox").removeClass("show");
				}
				</script>
	  		</c:if>
	  	</c:forEach>
	  </div>
	</c:if>
</body>
</html>