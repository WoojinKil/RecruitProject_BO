<%-- 
   1. 파일명   : psys1033
   2. 파일설명 : 샘플 > 랜딩페이지 샘플
   3. 작성일   : 2019-07-03
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
	$(document).ready(function(){
		
		// number형 data 랜덤숫자 셋팅
		$(".card_wrap .current_num, .count").each(function(index, item){
			
			$(item).text(getRandomInt(0,100));
		});
	});
	
	function getRandomInt(min, max) {
	  return Math.floor(Math.random() * (max - min)) + min;
	}
</script>
</head>
<body>
	<div id="frameWrap" >
		<!-- container -->
		<div class="subCon">
			<div class="hidden">
				<!-- 캠페인 운영현황 -->
				<div class="card_wrap type_half">
					<div class="card type_circle">
						<div class="card_in">
							<div class="card_top">
								<h2 class="card_title">캠페인 운영 현황</h2>
								<span class="card_term">최근 2개월</span>
								<span class="card_unit">(단위:건수)</span>
							</div>
							<div class="card_list ">
								<ul class="list">
									<li class="item">
										<p class="item_desc">기획</p>
										<div class="count_wrap">
											<span class="current_num">52</span>
											<button type="button" class="plus_btn">plus</button>
										</div>
									</li>
									<li class="item">
										<p class="item_desc">승인중</p>
										<div class="count_wrap">
											<span class="current_num">2</span>
											<button type="button" class="plus_btn">plus</button>
										</div>
									</li>
									<li class="item">
										<p class="item_desc">실행</p>
										<div class="count_wrap">
											<span class="current_num">14</span>
											<button type="button" class="plus_btn">plus</button>
										</div>
									</li>
									<li class="item">
										<p class="item_desc">완료</p>
										<div class="count_wrap">
											<span class="current_num">12</span>
											<button type="button" class="plus_btn">plus</button>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<!-- // 캠페인 운영현황 -->
				<!-- 데이터 추출/채널 전송 현황 -->
				<div class="card_wrap type_half pad-left-15">
					<div class="card type_rect">
						<div class="card_in">
							<div class="card_top">
								<h2 class="card_title">데이터 추출/채널 전송 현황</h2>
								<span class="card_term">최근 2개월</span>
							</div>
							<div class="card_list ">
								<ul class="list">
									<li class="item">
										<div class="count_wrap">
											<span class="current_num">6</span>
											<p class="item_desc">추출 진행중<span>캠페인 건수</span></p>
											<button type="button" class="plus_btn">plus</button>
										</div>
									</li>
									<li class="item">
										<div class="count_wrap">
											<span class="current_num">2</span>
											<p class="item_desc">추출 오류<span>캠페인 건수</span></p>
											<button type="button" class="plus_btn">plus</button>
										</div>
									</li>
									<li class="item">
										<div class="count_wrap">
											<span class="current_num">0</span>
											<p class="item_desc">채널 전송<span>캠페인 건수</span></p>
											<button type="button" class="plus_btn">plus</button>
										</div>
									</li>
									<li class="item">
										<div class="count_wrap">
											<span class="current_num">17</span>
											<p class="item_desc">채널 미전송<span>캠페인 건수</span></p>
											<button type="button" class="plus_btn">plus</button>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<!-- // 데이터 추출/채널 전송 현황 -->
			</div>
			<!-- 최근 활동 -->
			<div class="card_wrap">
				<div class="card type_noImg">
					<div class="card_in">
						<div class="card_top">
							<h2 class="card_title">최근 활동</h2>
							<span class="card_term">최근 2개월</span>
							<span class="card_unit">(단위:건수)</span>
						</div>
						<div class="card_list">
							<ul class="list">
								<li class="item">
									<p class="item_desc">로그인 횟수</p>
									<div class="count_wrap">
										<span class="current_num">370</span>
									</div>
								</li>
								<li class="item">
									<p class="item_desc">로그인 사용자 수</p>
									<div class="count_wrap">
										<span class="current_num">9</span>
									</div>
								</li>
								<li class="item">
									<p class="item_desc">성과 레포트 조회 수</p>
									<div class="count_wrap">
										<span class="current_num">0</span>
									</div>
								</li>
								<li class="item">
									<p class="item_desc">사전 분석 조회 수</p>
									<div class="count_wrap">
										<span class="current_num">351</span>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- // 최근 활동 -->
			<!-- 리스트 활용 -->
			<div class="card_wrap"> 
				<div class="card type_data">
					<div class="card_in">
						<div class="card_top">
							<h2 class="card_title">리스트 활용 TOP 5</h2>
						</div>
						<div class="card_list">
							<div class="list">
								<div class="item">
									<p class="list_top">캠페인 유형/설계 활용 현황</p>
									<div class="list_bottom">
										<div class="left">
											<p class="text_top">TOP 1</p>
											<p class="text_desc">타겟 캠페인 - 워크플로우</p>
											<p class="text_last">
												<span class="count">10</span><span class="text_count">건</span>
											</p>
										</div>
										<div class="right">
											<ul class="list">
												<li>
													2. 타겟 캠페인 타겟 캠페인 <span class="data_count">(9)</span>
												</li>
												<li>
													2. 타겟 캠페인 타겟 캠페인 <span class="data_count">(9)</span>
												</li>
												<li>
													2. 타겟 캠페인 타겟 캠페인 <span class="data_count">(9)</span>
												</li>
												<li>
													2. 타겟 캠페인 타겟 캠페인 <span class="data_count">(9)</span>
												</li>
											</ul>
										</div>
									</div>
								</div>
								<div class="item">
									<p class="list_top">템플릿 활용 현황</p>
									<div class="list_bottom">
										<div class="left">
											<p class="text_top">TOP 1</p>
											<p class="text_desc">우수 고객 관리_ 타</p>
											<p class="text_last">
												<span class="count">3</span><span class="text_count">건</span>
											</p>
										</div>
										<div class="right">
											<ul class="list">
												<li>
													2. 포인트 소멸 <span class="data_count">(9)</span>
												</li>
											</ul>
										</div>
									</div>
								</div>
								<div class="item">
									<p class="list_top">최근 채널 활용 현황</p>
									<div class="list_bottom">
										<div class="left">
											<p class="text_top">TOP 1</p>
											<p class="text_desc">LMS</p>
											<p class="text_last">
												<span class="count">8</span><span class="text_count">건</span>
											</p>
										</div>
										<div class="right">
											<ul class="list">
												<li>
													2. EMAIL<span class="data_count">4건</span>
												</li>
												<li>
													3. SMS<span class="data_count">2건</span>
												</li>
												<li>
													4. 앱 푸시<span class="data_count">2건</span>
												</li>
												<li>
													5. MMS<span class="data_count">2건</span>
												</li>
											</ul>
										</div>
									</div>
								</div>
								<div class="item">
									<p class="list_top">최근 오퍼 유형 활용 현황</p>
									<div class="list_bottom">
										<div class="center">
											<p>데이터가 존재하지 않습니다.</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- // 리스트 활용 -->
		</div>
		<!-- //container -->
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
