<%-- 
   1. 파일명 : notiList
   2. 파일설명: 자주묻는 질문 게시판
   3. 작성일 : 2019-03-26
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/meta.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=_resourcePath%>/common/css/style.css">
<script type="text/javascript">
$(document).ready(function() {
	// 검색 버튼 클릭 시
	$("#searchBtn").click(function() {
		var len = calByte($("#sch_type_txt"));
		 if(calByte($("#sch_type_txt"))>1000){
			alert("검색어는 한글기준 최대 500글자만 가능합니다.");
			$("#sch_type_txt").val("");
			return false;  
		 }{
			 goSearch(); 
		 }
	});
	
	// 초기화
	doInit();
});

// 초기화
function doInit() {
	// 검색 유형
	$("#sch_type").val("1"); // 디폴트 : 제목
    if(isNotEmpty('${sch_type}')) $("#sch_type").val('${sch_type}');
    $("#sch_type_label").text($("#sch_type option:selected").text());
    
	// 검색 텍스트
	$("#sch_type_txt").val("");
	if(isNotEmpty('${sch_type_txt}')) $("#sch_type_txt").val('${sch_type_txt}');
}

// 페이지 검색
function goSearch() {
	var modl_seqs = "${modl_seqs}";
	var field1 = $('<input>').attr({type : "hidden", name : "bbs_tp_cd", id : "bbs_tp_cd", value : "FAQ"});
	var field2 = $('<input>').attr({type : "hidden", name : "tmpl_seq", id : "tmpl_seq", value : _curr_tmpl_seq});
	var field3 = $('<input>').attr({type : "hidden", name : "modl_seqs", id : "modl_seqs", value : modl_seqs});
	$('form[name="searchDoc"]').append(field1).append(field2).append(field3).submit();
}
</script>
<body>
	<div id="wrap">
		<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/header.jsp" %>
		<!-- Container -->
		<div id="container">
			<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/breadCrumb.jsp" %>
					<div class="searchWrap typeBoard">
						<div class="selectWrap">
							<div class="selectInner">
								<form class="form" name="searchDoc" method="get">
								<div class="selectBox">
									<label for="sch_type" id="sch_type_label">전체</label>
									<select class="select" id="sch_type" name="sch_type">
										<option value="1">제목</option>
										<option value="2">내용</option>
										<option value="3">제목+내용</option>
									</select>
								</div>
								<div class="searchArea">
									<input type="text" id="sch_type_txt" name="sch_type_txt" placeholder="검색어" />
									<button id="searchBtn" class="searchBtn"><img src="<%=_resourcePath%>/common/images/btn_search.png" alt="공지사항 검색" /></button>
								</div>
								</form>
							</div>
						</div>
					</div>
					<c:if test="${(pagingInfo.tot_count) > 0}">
					<div class="boardArea">
						<div class="mBoard typeFaq">
							<ul class="boardList">
								<c:forEach var="list" items="${sysDocList}" varStatus="status">
								<li>
									<div class="listLink">
										<div class="listNumber">${pagingInfo.tot_count-list.row_num+1}</div>
										<div class="listContent">
											<p class="listTitle"><span class="iconBoard typeFaq">Q</span>${list.titl}</p>
										</div>
									</div>
									<div class="listDetail">
										<div class="desc">
											<span class="iconDetail">A</span>
											${list.cts}
										</div>
									</div>
								</li>
								</c:forEach>
							</ul>
						</div>
						<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/paging.jsp" %>
					</div>
					</c:if>
					<c:if test="${(pagingInfo.tot_count) eq 0}">
	                <div class="boardArea typeEmpty">
		                <c:choose>
		                <c:when test="${sch_type_txt ne ''}">
		                <p class="emptyResult">조회된 게시물이 없습니다.</p>
		                </c:when>
		                <c:otherwise>
		                <p class="emptyResult">등록된 게시물이 없습니다.</p>
		                </c:otherwise>
		                </c:choose>
	                </div>
	                </c:if>
				</div>
			</div>
			<!-- //Content -->
		</div>
		<!-- //Container -->
        <%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/footer.jsp" %>
	</div>
</body>
</html>