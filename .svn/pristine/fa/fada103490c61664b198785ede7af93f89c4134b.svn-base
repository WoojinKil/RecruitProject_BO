<%--
   1. 파일명 : pbbs4001
   2. 파일설명: 공지사항
   3. 작성일 : 2020-02-21
   4. 작성자 :
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>
<script type="text/javascript">
var menu_id = _menu_id;
var jbfn_grid;


/* 트리 메뉴 슬라이드 보이기 숨기기 공통 */
function menu_toggle(thisobj) {
	var $this = $(thisobj);
	$this.toggleClass("on").closest("li").toggleClass("on").find("> .menu_toggle").slideToggle(300);
}

/* 트리 메뉴 전체 열기 닫기 */
function menu_total_toggle(thisobj) {
	var $this = $(thisobj);
	var treeIcon = $this.closest(".tree_borad").find(".tree_view_1 li, .tree_view_1 .tree_icon");
	var treeSlide = $this.closest(".tree_borad").find(".menu_toggle");
	
	if($this.hasClass("on")) {
		$this.removeClass("on")
		treeIcon.removeClass("on");
		treeSlide.slideUp(300);
	} else {
		$this.addClass("on")
		treeIcon.addClass("on");
		treeSlide.slideDown(300);
	}
}

/* 게시판 탭 on off */
function tabClick(thisobj) {
	var $this = $(thisobj);
	
	$this.addClass("on").siblings().removeClass("on");
}


$(document).ready(function(){
	initPage("treeList", "treePaging", true, 10); 
});

/* 
  * 그리드 페이징
 *
 * @param gridId    : 리스트 ID
 * @param pagerId   : 페이징 ID
 * @param pagerYn   : 페이지 정보를 나타낼 것인지 / boolean / 생략시 false
 * @param pageCount : 한 페이지에 보여줄 페이지 수  (ex:1 2 3 4 5)
 */
 
function initPage(gridId, pagerId, pagerYn, pageCount){
	 if(pagerYn == null || pagerYn == "")
		 pagerYn = false; 

	 // 2019.11.08 그리드 내부 데이터 정렬 사용을 위해 변경
	 if(isEmpty(pagerId))
		 return;
	
	// 현재 페이지
	var currentPage = 1;
	
	// 전체 리스트 수
	var totalSize = $('#'+gridId).find("> li").length;
	
	// 그리드 데이터 전체의 페이지 수
	var totalPage = Math.ceil(totalSize/pageCount);
	
	// 전체 페이지 수를 한화면에 보여줄 페이지로 나눈다.
	var totalPageList = Math.ceil(totalPage/pageCount);
	
	// 페이지 리스트가 몇번째 리스트인지
	var pageList=Math.ceil(currentPage/pageCount);
	
	// 페이지 리스트가 1보다 작으면 1로 초기화
	if(pageList<1) pageList=1;
	
	// 페이지 리스트가 총 페이지 리스트보다 커지면 총 페이지 리스트로 설정
	if(pageList>totalPageList) pageList = totalPageList;
	
	// 시작 페이지
	var startPageList=((pageList-1)*pageCount)+1;
	// 끝 페이지
	var endPageList=startPageList+pageCount-1;
	// 시작 페이지와 끝페이지가 1보다 작으면 1로 설정
	
	// 끝 페이지가 마지막 페이지보다 클 경우 마지막 페이지값으로 설정
	if(startPageList<1)       startPageList=1;
	if(endPageList>totalPage) endPageList=totalPage;
	if(endPageList<1)         endPageList=1;
	
	// 페이징 DIV에 넣어줄 태그 생성변수
	var pageInner="";
	
	if(currentPage <=1 || totalSize <= 1){
		pageInner+="<li class='leftOne'><span class='pageNum typeImg'><img src='${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_page_left_arrow2.png' alt=''></span></li>";
		pageInner+="<li class='leftTwo'><span class='pageNum typeImg'><img src='${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_page_left_arrow1.png' alt=''></span></li>";
	} else {
		pageInner+="<li class='leftOne'><a class='pageNum typeImg' href='javascript:firstPage(\""+ gridId +"\");' title='첫 페이지로 이동'><img src='${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_page_left_arrow2.png' alt=''></a></li>";
		pageInner+="<li class='leftTwo'><a class='pageNum typeImg' href='javascript:prePage(\""+ gridId +"\", "+ currentPage +");' title='이전 페이지로 이동'><img src='${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_page_left_arrow1.png' alt=''></a></li>";
	}
	
	
	// 페이지 숫자를 찍으며 태그생성 (현재페이지는 강조태그)
	for(var i=startPageList; i<=endPageList; i++)
	{
		  var titleGoPage = i + "페이지로 이동";
	
		  if(i==currentPage){
		   pageInner = pageInner +"<li class='on'><span class='pageNum'>"+(i)+"</span></li>";
		  }else{
		   pageInner = pageInner +"<li><a class='pageNum' href='javascript:goPage(\""+ gridId +"\", "+(i)+");' id='"+(i)+"' title='"+ titleGoPage +"'>"+(i)+"</a></li>";
		  }
	}
	
	// 다음 페이지 리스트가 있을 경우
	if(totalSize <= 1 || currentPage == totalPage){
		 pageInner+="<li class='rightOne'><span class='pageNum typeImg'><img src='${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_page_right_arrow1.png' alt=''></span></li>";
		 pageInner+="<li class='rightTwo'><span class='pageNum typeImg'><img src='${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_page_right_arrow2.png' alt=''></span></li>";
	}else{
		 pageInner+="<li class='rightOne'><a class='pageNum typeImg' href='javascript:nextPage(\""+ gridId +"\", "+ currentPage +");' title='다음 페이지로 이동'><img src='${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_page_right_arrow1.png' alt=''></a></li>";
		 pageInner+="<li class='rightTwo'><a class='pageNum typeImg' href='javascript:lastPage(\""+ gridId +"\", "+ totalPage +");' title='마지막 페이지로 이동'><img src='${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_page_right_arrow2.png' alt=''></a></li>";
	}
	
	
	var pageInfoText = "총 " + totalSize + "건";
	
	var table = "";
	table+= "<div class='pagination'>";
	table+= "<ul class='paging'>";
	table+= pageInner;
	table+= "</ul>";
	
	table+="<div class='pagingRight'>";
	table+="<select id='pagerNum_"+pagerId+"' name='' class='select' onchange='rowNumClick(\""+ gridId +"\", this)' >";
	
	for(var i in _grid_rows_list) {
		 table+="<option value='" + _grid_rows_list[i] + "'>"+ _grid_rows_list[i] +"</option>";
	}
	
	table+="</select>";
	table+= pagerYn ? "<span>" + pageInfoText + "</span> " : "" ;
	table+="</div>";
	table+= "</div>";
	
	// 페이징할 DIV태그에 우선 내용을 비우고 페이징 태그삽입
	$("#"+pagerId).html("");
	
	// 페이징 html 추가
	$("#"+pagerId).append(table);
	// 페이징 클래스 추가
	
	//$("#pagerNum_" + pagerId + " option[value='" + $('#'+gridId).getGridParam('rowNum') + "']").prop("selected", true);

}

</script>
</head>
<body class="">
<!-- 

	왼쪽 트리 설명
	
		1. 트리 구조 및 설명
			- 1depth = tree_view_1
			- 2depth = tree_view_2 - menu_toggle 클래스 추가
			- 3depth = tree_view_3 - menu_toggle 클래스 추가
			- 하위 메뉴 없을 경우 li에 no_sub 클래스 추가
			- 3depth에 on으로 활성화 구분
			
			
		2. 함수
			- menu toggle()       : 함수로 공통 메뉴 열기 닫기
			- menu_total_toggle() : 함수 전체 열기 닫기
	
	--------------------------------------------------------------
	
	오른쪽 게시판 설명
	
		1. 테이블 리스트 start 로 주석 처리
		2. 리스트 중요 및 FAQ 나올경우 li에 type_btn 클래스 추가 
		3. imfort_txt : 제목에 초록색 강조 표시 클래스 
		
	오른쪽 게시판 상세
		1. 테이블 리스트 상세 start 로 주석 처리
		2. imfort_txt : 제목에 초록색 강조 표시 클래스
		
 -->
    <div class="frameWrap">
    	<div class="subCon typeSearch">
	   		<div class="subConIn">
				<div class="board_search">
					<div class="board_title">
						<h3 class="title type_notice">오피스 분석</h3>
					</div>
				</div>
				<div class="custom_tree_area">
					<div class="left">
						<div class="tree_borad">
							<div class="tree_btn">
								<button type="button" class="total_btn" onclick="menu_total_toggle(this)">전체</button>
							</div>
							<ul class="tree_view_1">
								<li> 
									<span class="tree_icon" onclick="menu_toggle(this)" ></span>
									<a href="#">빅데이터포탈</a>
									<ul class="tree_view_2 menu_toggle">
										<li class="no_sub">
											<span class="tree_icon" onclick="menu_toggle(this)"></span>
											<a href="#" >
												<span class="folder_icon"></span>
												홈화면
											</a>
										</li>
										<li class="no_sub">
											<span class="tree_icon" onclick="menu_toggle(this)"></span>
											<a href="#" >
												<span class="folder_icon"></span>
												권한
											</a>
										</li>
									</ul>
								</li>
								<li>
									<span class="tree_icon" onclick="menu_toggle(this)" ></span>
									<a href="#">고객 BI</a>
									<ul class="tree_view_2 menu_toggle">
										<li class="no_sub">
											<span class="tree_icon" onclick="menu_toggle(this)"></span>
											<a href="#" >
												<span class="folder_icon"></span>
												홈화면
											</a>
										</li>
										<li class="no_sub">
											<span class="tree_icon" onclick="menu_toggle(this)"></span>
											<a href="#" >
												<span class="folder_icon"></span>
												권한
											</a>
										</li>
									</ul>
								</li>
								<li>
									<span class="tree_icon" onclick="menu_toggle(this)" ></span>
									<a href="#">상권 BI</a>
									<ul class="tree_view_2 menu_toggle">
										<li class="no_sub">
											<span class="tree_icon" onclick="menu_toggle(this)"></span>
											<a href="#" >
												<span class="folder_icon"></span>
												시작하기
											</a>
										</li>
										<li>
											<span class="tree_icon" onclick="menu_toggle(this)"></span>
											<a href="#" >
												<span class="folder_icon"></span>
												고객분석
											</a>
											<ul class="tree_view_3 menu_toggle">
												<li class="no_sub">
													<span class="tree_icon" onclick="menu_toggle(this)"></span>
													<a href="#">
														<span class="folder_icon"></span>
														행정구역분석
													</a>
												</li>
												<li class="no_sub">
													<span class="tree_icon" onclick="menu_toggle(this)"></span>
													<a href="#">
														<span class="folder_icon"></span>
														아파트 분석
													</a>
												</li>
												<li class="no_sub">
													<span class="tree_icon" onclick="menu_toggle(this)"></span>
													<a href="#" class="on">
														<span class="folder_icon"></span>
														오피스 분석
													</a>
												</li>
											</ul>
										</li>
										<li>
											<span class="tree_icon" onclick="menu_toggle(this)"></span>
											<a href="#" >
												<span class="folder_icon"></span>
												시계열분석
											</a>
											<ul class="tree_view_3 menu_toggle">
												<li class="no_sub">
													<span class="tree_icon" onclick="menu_toggle(this)"></span>
													<a href="#">
														<span class="folder_icon"></span>
														행정구역분석
													</a>
												</li>
												<li class="no_sub">
													<span class="tree_icon" onclick="menu_toggle(this)"></span>
													<a href="#">
														<span class="folder_icon"></span>
														아파트 분석
													</a>
												</li>
												<li class="no_sub">
													<span class="tree_icon" onclick="menu_toggle(this)"></span>
													<a href="#">
														<span class="folder_icon"></span>
														오피스 분석
													</a>
												</li>
											</ul>
										</li>
										<li>
											<span class="tree_icon" onclick="menu_toggle(this)"></span>
											<a href="#" >
												<span class="folder_icon"></span>
												외부시스템연계분석
											</a>
											<ul class="tree_view_3 menu_toggle">
												<li class="no_sub">
													<span class="tree_icon" onclick="menu_toggle(this)"></span>
													<a href="#">
														<span class="folder_icon"></span>
														행정구역분석
													</a>
												</li>
												<li class="no_sub">
													<span class="tree_icon" onclick="menu_toggle(this)"></span>
													<a href="#">
														<span class="folder_icon"></span>
														아파트 분석
													</a>
												</li>
												<li class="no_sub">
													<span class="tree_icon" onclick="menu_toggle(this)"></span>
													<a href="#">
														<span class="folder_icon"></span>
														오피스 분석
													</a>
												</li>
											</ul>
										</li>
										<li>
											<span class="tree_icon" onclick="menu_toggle(this)"></span>
											<a href="#" >
												<span class="folder_icon"></span>
												점유율분석
											</a>
											<ul class="tree_view_3 menu_toggle">
												<li class="no_sub">
													<span class="tree_icon" onclick="menu_toggle(this)"></span>
													<a href="#">
														<span class="folder_icon"></span>
														행정구역분석
													</a>
												</li>
												<li class="no_sub">
													<span class="tree_icon" onclick="menu_toggle(this)"></span>
													<a href="#">
														<span class="folder_icon"></span>
														아파트 분석
													</a>
												</li>
												<li class="no_sub">
													<span class="tree_icon" onclick="menu_toggle(this)"></span>
													<a href="#">
														<span class="folder_icon"></span>
														오피스 분석
													</a>
												</li>
											</ul>
										</li>
									</ul>
								</li>
								<li>
									<span class="tree_icon" onclick="menu_toggle(this)" ></span>
									<a href="#">AI 캠페인</a>
									<ul class="tree_view_2 menu_toggle">
										<li class="no_sub">
											<span class="tree_icon" onclick="menu_toggle(this)"></span>
											<a href="#" >
												<span class="folder_icon"></span>
												홈화면
											</a>
										</li>
										<li class="no_sub">
											<span class="tree_icon" onclick="menu_toggle(this)"></span>
											<a href="#" >
												<span class="folder_icon"></span>
												권한
											</a>
										</li>
									</ul>
								</li>
								<li>
									<span class="tree_icon" onclick="menu_toggle(this)" ></span>
									<a href="#">VIP Plus</a>
									<ul class="tree_view_2 menu_toggle">
										<li class="no_sub">
											<span class="tree_icon" onclick="menu_toggle(this)"></span>
											<a href="#" >
												<span class="folder_icon"></span>
												홈화면
											</a>
										</li>
										<li class="no_sub">
											<span class="tree_icon" onclick="menu_toggle(this)"></span>
											<a href="#" >
												<span class="folder_icon"></span>
												권한
											</a>
										</li>
									</ul>
								</li>
								<li>
									<span class="tree_icon" onclick="menu_toggle(this)" ></span>
									<a href="#">트렌드 View</a>
									<ul class="tree_view_2 menu_toggle">
										<li class="no_sub">
											<span class="tree_icon" onclick="menu_toggle(this)"></span>
											<a href="#" >
												<span class="folder_icon"></span>
												홈화면
											</a>
										</li>
										<li class="no_sub">
											<span class="tree_icon" onclick="menu_toggle(this)"></span>
											<a href="#" >
												<span class="folder_icon"></span>
												권한
											</a>
										</li>
									</ul>
								</li>
							</ul>
						</div>
					
					</div>
					<div class="right">
						<!-- 테이블 리스트 상세 start -->
					    <!-- 
					    <div class="notice_detail">
							<div class="notice_in">
								<div class="notice_title">
									<h2 class="title">
										<span>[상권BI]  외부시스템 <em class="imfort_txt">연계분석</em>에서 구매예측분석하기</span>
									</h2>
									<span class="date">2020-03-30</span>
									<ul class="notice_sub_list">
										<li class="imfort_txt">#연계분석</li>
										<li>#연계분석</li>
										<li>#구매예측</li>
										<li>#모델</li>
										<li>#예측모델</li>
										<li>#외부시스템연계분석</li>
										<li>#외부시스템</li>
									</ul>
								</div>
								<div class="notice_content" id="notice_content">
									<p>디지털 플랫폼 AI캠페인
										<img alt="200330185635.jpg" src="https://s3.ap-northeast-2.amazonaws.com/ldps-prd.static.bdp/files/attach/20200330095743412_200330185635.jpg"><br>
										<img alt="200330185643.jpg" src="https://s3.ap-northeast-2.amazonaws.com/ldps-prd.static.bdp/files/attach/20200330095743593_200330185643.jpg"><br>
										의 1차 실습예제입니다.
									</p>
								</div>
								<div class="notile_file_list">
									<ul class="file_list" id="fileList">
		                           		 <li id="fileBox16322" class="fileBox">
		                           			 <div class="file_name">
				                            	<a href="#" title="클릭하면 파일이 다운로드됩니다.">디지털플랫폼 AI캠페인 1차 매뉴얼.pdf
				                            		<span class="volumn"> (6.37 MB) </span>
				                            	</a>
			                            	</div>
			                            	<span class="file_down"><img src="${pageContext.request.contextPath}/resources/pandora3/images/img_file_download.png" alt="파일 다운로드"></span>
		                           		</li>
		                         	</ul>
								</div>
								<div class="page_wrap">
									<ul class="page_move_list">
										<li>
											<a href="#">
												<span class="left">이전글</span>
												<span class="right">외부시스템 연계분석에서 구매예측분석하기</span>
											</a>
										</li>
										<li>
											<a href="#">
												<span class="left">다음글</span>
												<span class="right">구매예측분석하기</span>
											</a>
										</li>
									</ul>
								</div>
								
							</div>
						</div>
						<div class="notice_btn">
					   		<div class="m_btn_wrap">
								<button class="m_btn_default full" id="btn_goList">목록</button>
							</div>
				   		</div>
				   		-->
			    		<!-- 테이블 리스트 상세 end -->
						<!-- 테이블 리스트 start -->
						
							<div class="board_tab_area">
								<div class="board_tab_in">
									<ul class="board_tab_list" id ="catList">
										<li class="catlistDtl on" onclick="tabClick(this);">
											<a href="#" >최신순</a>
										</li>
										<li class="catlistDtl" onclick="tabClick(this);">
											<a href="#" >조회순</a>
										</li>
									</ul>
				
									<div class="tab_search">
										<input type="text" class="board_search" id="txt_titl" placeholder="잠깐! 메뉴 찾기가 어려우신가요?" autocomplete="off"  maxlength="250" />
										<button id ="btn_search">
											<img src="${pageContext.request.contextPath}/resources/pandora3/images/img_board_search_btn.png" alt="공지사항 조회">
										</button>
									</div>
								</div>
							</div>
							<div class="tree_table" >
								<ul class="tree_table_list" id="treeList">
									<li class="type_btn">
										<span class="board_inf">중요</span>
										<div class="desc"><em>[레포트]</em> 엑셀 다운로드 기능 개선 안내
											
											<ul class="notice_sub_list">
												<li class="imfort_txt">#연계분석</li>
												<li>#연계분석</li>
												<li>#구매예측</li>
												<li>#모델</li>
												<li>#예측모델</li>
												<li>#외부시스템연계분석</li>
												<li>#외부시스템</li>
											</ul>
										</div>
										<span class="date">2020-03-15</span>
									</li>
									<li class="type_btn">
										<span class="board_inf">FAQ</span>
										<span class="desc"><em>[레포트]</em> 엑셀 다운로드 기능 개선 안내</span>
										<span class="date">2020-03-15</span>
									</li>
									<li class="type_btn">
										<span class="board_inf">FAQ</span>
										<span class="desc"><em>[레포트]</em> 엑셀 다운로드 기능 개선 안내</span>
										<span class="date">2020-03-15</span>
									</li>
									<li>
										<span class="desc"><em>[레포트]</em> 엑셀 다운로드 기능 개선 안내</span>
										<span class="date">2020-03-15</span>
									</li>
									<li>
										<span class="desc"><em>[레포트]</em> 엑셀 다운로드 기능 개선 안내</span>
										<span class="date">2020-03-15</span>
									</li>
									<li>
										<span class="desc"><em>[레포트]</em> 엑셀 다운로드 기능 개선 안내</span>
										<span class="date">2020-03-15</span>
									</li>
									<li>
										<span class="desc"><em>[레포트]</em> 엑셀 다운로드 기능 개선 안내</span>
										<span class="date">2020-03-15</span>
									</li>
									<li>
										<span class="desc"><em>[레포트]</em> 엑셀 다운로드 기능 개선 안내</span>
										<span class="date">2020-03-15</span>
									</li>
									<li>
										<span class="desc"><em>[레포트]</em> 엑셀 다운로드 기능 개선 안내</span>
										<span class="date">2020-03-15</span>
									</li>
									<li>
										<span class="desc"><em>[레포트]</em> 엑셀 다운로드 기능 개선 안내</span>
										<span class="date">2020-03-15</span>
									</li>
									<li>
										<span class="desc"><em>[레포트]</em> 엑셀 다운로드 기능 개선 안내</span>
										<span class="date">2020-03-15</span>
									</li>
									<li>
										<span class="desc"><em>[레포트]</em> 엑셀 다운로드 기능 개선 안내</span>
										<span class="date">2020-03-15</span>
									</li>
									<li>
										<span class="desc"><em>[레포트]</em> 엑셀 다운로드 기능 개선 안내</span>
										<span class="date">2020-03-15</span>
									</li>
									<li>
										<span class="desc"><em>[레포트]</em> 엑셀 다운로드 기능 개선 안내</span>
										<span class="date">2020-03-15</span>
									</li>
									<li>
										<span class="desc"><em>[레포트]</em> 엑셀 다운로드 기능 개선 안내</span>
										<span class="date">2020-03-15</span>
									</li>
								</ul>
								<div id="treePaging" class="treePaging">
								</div>
							</div> 
				    	
				    	<!-- 테이블 리스트 end -->
					</div>
				</div>
    		</div>
    	</div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>