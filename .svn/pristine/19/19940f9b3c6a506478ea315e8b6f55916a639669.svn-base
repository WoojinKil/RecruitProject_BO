<%-- 
   1. 파일명 : footer
   2. 파일설명: (공통) BUSINESS IT ACADEMY 풋터 영역
   3. 작성일 : 2019-03-25
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
$(document).ready(function() {
	// 풋터 URL 취득
	getFooterUrl();
});

// 풋터 URL 취득
function getFooterUrl() {
	var mst_cd_str_arr = "TMPL_INF_CD";
	getCommCdList(mst_cd_str_arr, function callBackFunc(data) {
		for(var i in data) {
			var txtNm = "";
			if(isNotEmpty(data[i].CD)) {
				if(data[i].CD == "FAQ") txtNm = "FAQ";
				else if(data[i].CD == "ACOA") txtNm = "오시는길";
				else if(data[i].CD == "AINTR") txtNm = "학원소개";
				else if(data[i].CD == "RCRT") txtNm = "강사채용";
				else if(data[i].CD == "PLCY") txtNm = "개인정보취급방침";
				else if(data[i].CD == "RFNM") txtNm = "환불규정";
				if(isNotEmpty(txtNm)) {
					if(data[i].CD == "FAQ" || data[i].CD == "ACOA") {
						$("#link" + data[i].CD).append('<a href="' + _context + chgEmptyUrl(data[i].CD_DESC) + '" class="linkBtn">' + txtNm + '</a>');
					}else {
						$("#link" + data[i].CD).append('<a href="' + _context + chgEmptyUrl(data[i].CD_DESC) + '">' + txtNm + '</a>');
					}	
				}
			}
		}
	});
}
</script>
        <!-- Footer -->
        <div id="footer">
			<div class="footerTop">
				<div class="footerInner">
					<div class="innerRow firstRow">
						<p class="innerTitle">교육상담</p>
						<div class="innerContent">
							<p class="contentTxt number">031-421-1012</p>
							<ul class="contentTxt">
								<li>OPEN &nbsp;&nbsp;: AM 09:00 ~ PM 22:00 </li>
								<li>BREAK : PM 12:00 ~ PM 13:00</li>
							</ul>
						</div>
						<div id="linkFAQ"></div>
					</div>
					<div class="innerRow secondRow">
						<p class="innerTitle">입금계좌</p>
						<div class="innerContent">
							<p class="contentTxt number">603101-01-258695</p>
							<p class="contentTxt">KB국민은행 / 예금주 : (주)티에이나인(비즈니스IT학원)</p>
						</div>
					</div>
					<div class="innerRow thirdRow">
						<p class="innerTitle">오시는 길</p>
						<div class="innerContent">
							<p class="contentTxt">경기도 의왕시 갈미2로 40 캠퍼스프라자 206호(롯데마트 앞)</p>
							<ul class="contentTxt">
								<li>TEL : 031-421-1012</li>
								<li>FAX : 031-421-1620</li>
								<!-- <li>평촌역 1번출구에서 마을버스 6번 - 롯데마트 정류장 하차</li>	
								<li>인덕원역 4번 출구에서 777, 540, 502, 441, 08, 60-1번 버스 - 롯데마트, 계원예대 정류장 하차</li>	
								<li>범계역 4-1번 출구에서 마을버스 6번 - 대원아파트 정류장 하차</li>	 -->
							</ul>
						</div>
						<div id="linkACOA"></div>
					</div>
				</div>
			</div>
			<div class="footerBottom">
				<div class="footerInner">
					<div class="innerRow firstRow">
						<ul class="contentTxt">
							<li>사업자번호 : 101-56-45672</li>
							<!-- <li>통신판매업신고번호 : 제2009-서울강남-5235호</li> -->
							<li>대표이사 : 정철우</li>
							<li>경기도 의왕시 갈미2로 40 캠퍼스프라자 206호<br />(롯데마트 앞)</li>
							<li>대표전화 : 031-421-1012</li>
							<li>교육담당 : 이기쁨</li>
						</ul>
					</div>
					<div class="innerRow secondRow">
						<ul class="contentTxt">
							<li id="linkAINTR"></li>
							<li id="linkRCRT"></li>
							<li id="linkPLCY"></li>
							<li id="linkRFNM"></li>
						</ul> 
					</div>
					<div class="innerRow thirdRow">
						<!-- <a href="javascript:void(0);" class="iconLink blog" onclick="javascript:alert('준비중입니다.');return false;">Blog</a>
						<a href="javascript:void(0);" class="iconLink facebook" onclick="javascript:alert('준비중입니다.');return false;">FaceBook</a> -->
						<div class="familySite">
							<span class="siteMore">FAMILY SITE</span>
							<ul class="siteDrop">
								<li><a href="http://www.ta9.co.kr/" >(주)티에이나인</a></li>
							</ul>
						</div>
						<div class="academyLogo">
							<img src="<%=_resourcePath%>/common/images/img_footer_logo.png" alt="BUSINESS IT 학원" />
						</div>
					</div>
					<div class="innerRow copyright">
						<p>Copyright 2019 TANINE reserved.</p>
					</div>
				</div>
			</div>
		</div>
        <!-- //Footer -->