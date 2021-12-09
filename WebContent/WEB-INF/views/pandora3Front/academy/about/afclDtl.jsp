<%-- 
   1. 파일명 : afclDtl
   2. 파일설명: 교육시설 페이지
   3. 작성일 : 2019-04-05
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/meta.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=_resourcePath%>/common/css/style.css">
<script type="text/javascript">
$(document).ready(function() {
	// 초기화
	doInit();
});

// 초기화
function doInit() {
	// 교육시설 슬라이드
	var galleryThumbs = new Swiper('.gallery-thumbs', {
		spaceBetween: 0,
		slidesPerView: 5,
		freeMode: true,
		watchSlidesVisibility: true,
		watchSlidesProgress: true
	});
	new Swiper('.gallery-top', {
		spaceBetween: 0,
		thumbs: {
			swiper: galleryThumbs
		}
	});
}
</script>
<body>
	<div id="wrap">
		<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/header.jsp" %>
		<!-- Container -->
		<div id="container">
			<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/breadCrumb.jsp" %>
					<div class="consultWrap typeOnline">
						<div class="mGallery typePicture">
							<div class="imgView swiper-container gallery-top">
								<div class="swiper-wrapper">
									<div class="swiper-slide">
										<img src="<%=_resourcePath%>/common/images/img_gallery_view_1.jpg" alt="" />
									</div>
									<div class="swiper-slide">
										<img src="<%=_resourcePath%>/common/images/img_gallery_view_2.jpg" alt="" />
									</div>
									<div class="swiper-slide">
										<img src="<%=_resourcePath%>/common/images/img_gallery_view_3.jpg" alt="" />
									</div>
									<div class="swiper-slide">
										<img src="<%=_resourcePath%>/common/images/img_gallery_view_4.jpg" alt="" />
									</div>
									<div class="swiper-slide">
										<img src="<%=_resourcePath%>/common/images/img_gallery_view_5.jpg" alt="" />
									</div>
								</div>
							</div>
							<div class="imgList swiper-container gallery-thumbs">
								<div class="swiper-wrapper">
									<div class="swiper-slide">
										<img src="<%=_resourcePath%>/common/images/img_gallery_view_1.jpg" alt="" />
									</div>
									<div class="swiper-slide">
										<img src="<%=_resourcePath%>/common/images/img_gallery_view_2.jpg" alt="" />
									</div>
									<div class="swiper-slide">
										<img src="<%=_resourcePath%>/common/images/img_gallery_view_3.jpg" alt="" />
									</div>
									<div class="swiper-slide">
										<img src="<%=_resourcePath%>/common/images/img_gallery_view_4.jpg" alt="" />
									</div>
									<div class="swiper-slide">
										<img src="<%=_resourcePath%>/common/images/img_gallery_view_5.jpg" alt="" />
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- //Content -->
		</div>
		<!-- //Container -->
        <%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/footer.jsp" %>
	</div>
</body>
</html>