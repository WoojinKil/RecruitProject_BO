<%-- 
   1. 파일명 : rcrtDtl
   2. 파일설명: 강사채용 페이지
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
			<div id="content" class="typeSub2">
				<div class="subContent typeNon">
					<h3 class="title typeBoard">강사채용</h3>
				</div>
				<div class="lecturer typeHire typeStep">
					<div class="lecturerInner">
						<div class="lectureSeciton">
							<div class="left">
								<h4 class="lectureTItle">전형절차</h4>
							</div>
							<div class="right">
								<div class="rightArea">
									<div class="document">
										<p class="rightTitle">제출서류</p>
										<p class="rightDesc">재직/경력증명서 1부, 각종 자격증 1부, 이력서, 자기소개서
												주민등록초본/등본 각1부, 졸업/성적증명서 각1부</p>
									</div>
									<div class="other">
										<p class="rightTitle">기타사항</p>
										<p class="rightDesc">입사지원서의 기재사항이 허위 판명시 입사 취소됩니다. 
												제출시 서류는 합격자를 제외하고 전부 파기됩니다.</p>
									</div>
									<div class="method">
										<p class="rightTitle">전형방법</p>
										<img class="imgStep" src="<%=_resourcePath%>/common/images/img_selection_step.png" alt="1.지원신청 2.서류전형 3.면접(실무/인성) 4.처우협의 5.입사확정">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- <div class="lecturer typeHire typeBenefit">
					<div class="lecturerInner">
						<div class="lectureSeciton">
							<div class="left">
								<h4 class="lectureTItle">복리후생</h4>
							</div>
							<div class="right">
								<ul class="benefits">
									<li>
										<p class="beneTitle">사대보험</p>
										<p class="beneDesc">사대보험 가입 및<br /> 직원 건강검진 실시</p>
									</li>
									<li>
										<p class="beneTitle">의료비 지원</p>
										<p class="beneDesc">직원 본인을 포함한<br /> 직계가족의 의료비 지원</p>
									</li>
									<li>
										<p class="beneTitle">학자금 지원</p>
										<p class="beneDesc">본인학자금 및<br /> 자녀학자금 지원</p>
									</li>
									<li>
										<p class="beneTitle">경조사 지원</p>
										<p class="beneDesc">경조사 발생 시<br /> 지원금,휴가 등 부여</p>
									</li>
									<li>
										<p class="beneTitle">자기계발비 지원</p>
										<p class="beneDesc">자기계발,교육훈련<br /> 등의 비용 지원</p>
									</li>
									<li>
										<p class="beneTitle">전직원 행사</p>
										<p class="beneDesc">워크샵,호프데이 등의<br /> 전직원 행사 실시</p>
									</li>
									<li>
										<p class="beneTitle">명절 선물</p>
										<p class="beneDesc">명절 및 본인 생일<br /> 선물 지급</p>
									</li>
									<li>
										<p class="beneTitle">휴가제도</p>
										<p class="beneDesc">각종 휴가제도 운영<br /> (연차유급휴가, 대체휴가,<br /> 하계휴가, 포상휴가 등)</p>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div> -->
				<div class="lecturer typeHire typeRecruit typeBenefit">
					<div class="lecturerInner">
						<div class="lectureSeciton">
							<div class="left">
								<h4 class="lectureTItle">채용공고</h4>
							</div>
							<div class="right">
								<p class="recruitTitle">모집부문</p>
								<ul class="subjectList">JAVA | JSP | WEB | PYTHON | R | UI/UX  
									<li>JAVA</li>
									<li>JSP</li>
									<li>WEB</li>
									<li>PYTHON</li>
									<li>R</li>
									<li>UI/UX</li>
								</ul>
								<ul class="totalList">
									<li>모집인원 : 00명</li>
									<li>학력 : 초대졸 이상</li>
									<li>우대사항 : 강의경험 / 동종업계 경험</li>
									<li>채용기간 : 채용시 마감</li>
								</ul>
								<p class="sendMail">※ 포트폴리오와 이력서를 첨부하여 <em>bzit@ta9.co.kr</em>로 보내주세요.</p>
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