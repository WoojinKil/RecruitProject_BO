<%-- 
   1. 파일명 : rfnmDtl
   2. 파일설명: 환불규정 페이지
   3. 작성일 : 2019-04-05
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/meta.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=_resourcePath%>/common/css/style.css">
<body>
	<div id="wrap">
		<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/header.jsp" %>
		<!-- Container -->
		<div id="container">
			<!-- Content -->
			<div id="content">
				<div class="subContent typeNon">
					<h3 class="title typeBoard">환불규정</h3>
					<div class="consultWrap typeOnline">
						<div class="mArticle typeText">
							<p>
								학원의 정상적인 운영을 위하여 아래와 같이 학원규정을 적용하오니 교육신청 시 참조하시어 착오 없으시기 바랍니다.
							</p>
							<ol class="refundList">
								<li><strong>1.등록규정</strong>
									<ul class="refundDetail">
										<li>- 수강접수는 수시 접수가 가능합니다.</li>
										<li>- 수강료 납부는 선납을 원칙으로 하며 현금, 무통장 입금, 카드를 이용하실 수 있습니다.</li>
									</ul>
								</li>
								<li><strong>2.연기신청</strong>
									<ul class="refundDetail">
										<li>- 연기신청은 반드시 사전신청만 가능하며, 무단결석은 연기신청 기간에 제외됩니다.</li>
										<li>- 연기는 1주일 단위로 신청할 수 있으며, 연기 횟수는 등록한 개월 수 만큼 할 수 있습니다.<br>예) 1개월 등록 시 → 1번만 연기신청 가능, 3개월 등록 시 → 3번 연기신청 가능</li>
										<li>- 연기할 수 있는 기간은 등록 수강종료일 기준에서, 등록한 개월 수 까지 연기할 수 있으며,기한이 지나면 남은 기간은 자동 소멸됩니다.<br>예)2020년 6월 1일~8월 31까지-3개월 등록 시 → 수강종료일 3개월 연기-11월 30일까지.</li>
										<li>- 수강 종료일이 2주 이내 남을 시에는 연기가 불가합니다.</li>
									</ul>
								</li>
								<li><strong>3.환불규정</strong><br><p>학원법시행령 &lt;제18조 제3항&gt;아래의 수강료 반환기준에 의거합니다</p>
									<ul class="refundDetail">
										<li>- 수강 신청 시 할인 적용된 수강료는 환불시 할인적용을 받지 못합니다.</li>
										<li>- 수강료 반환 의사를 표시하지 아니하고 무단결석 할 때에는 결석한 기간은 교습시간으로 인지하며, 환불 요구한 시점을 기준으로 반환됩니다.</li>
										<li>- 환불신청은 서면으로만 가능하며, 환불요구 신청 후 5일 이내에 반환됩니다.</li>
										<li>- 연기신청 후 반환을 요구할 때에는, 수강 신청일 기준으로 반환됩니다.</li>
									</ul>
								</li>
							</ol>
							<table class="articleTable">
								<colgroup>
									<col>
									<col>
									<col>
								</colgroup>
								<thead>
									<tr>
										<th scope="col" colspan="2">구분</th>
										<th scope="col">반환사유발생일</th>
										<th scope="col">반환금액</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td rowspan="6">학습자가 본인의 의사로 수강을 포기한 경우</td>
										<td rowspan="4">수강료 징수기간이 1월 이내인 경우</td>
										<td>교습개시 이전</td>
										<td>이미 납부한 수강료 전액</td>
									</tr>
									<tr>
										<td>총 교습시간의 1/3경과 전</td>
										<td>이미 납부한 수강료의 2/3 해당액</td>
									</tr>
									<tr>
										<td>총 교습시간의 1/2경과 전</td>
										<td>이미 납부한 수강료의 1/3 해당액</td>
									</tr>
									<tr>
										<td>총 교습시간의 1/2경과 후</td>
										<td>반환하지 아니함</td>
									</tr>
									<tr>
										<td rowspan="2">수강료 징수기간이 1월을 초과하는 경우	</td>
										<td rowspan="2">교습개시 이후</td>
										<td rowspan="2">반환사유가 발생한 당해 월의 반환 대상 수강료(수강료 징수기간이 1월 이내인 경우에 따라 산출된 수강료를 말한다)와 나머지 월의 수강료 전액을 합산한 금액</td>
									</tr>
								</tbody>
							</table>
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