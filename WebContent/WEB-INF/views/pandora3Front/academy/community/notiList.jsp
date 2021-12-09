<%-- 
   1. 파일명 : notiList
   2. 파일설명: 공지사항 게시판
   3. 작성일 : 2019-03-26
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/meta.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=_resourcePath%>/common/css/style.css">
<script type="text/javascript">
var bbs_tp_cd = isEmpty("${bbs_tp_cd}") ? "NOTI" : "${bbs_tp_cd}";
var modl_seqs = "${modl_seqs}";
var lst_modl_seq = !(parseInt("${modl_seq}", 10) > 0) ? "" : "${modl_seq}";
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
	var field1 = $('<input>').attr({type : "hidden", name : "bbs_tp_cd", id : "bbs_tp_cd", value : bbs_tp_cd});
	var field2 = $('<input>').attr({type : "hidden", name : "tmpl_seq", id : "tmpl_seq", value : _curr_tmpl_seq});
	var field3 = $('<input>').attr({type : "hidden", name : "modl_seqs", id : "modl_seqs", value : modl_seqs});
	var field4 = $('<input>').attr({type : "hidden", name : "modl_seq", id : "modl_seq", value : lst_modl_seq});
	$('form[name="searchDoc"]').append(field1).append(field2).append(field3).append(field4).submit();
}

// 상세 페이지 이동
function goDtl(modl_seq, doc_seq) {
	var params = {};
	params.bbs_tp_cd = bbs_tp_cd;
	params.tmpl_seq = _curr_tmpl_seq;
	params.modl_seqs = modl_seqs;
	params.lst_modl_seq = lst_modl_seq;
	params.modl_seq = modl_seq;
	params.doc_seq = doc_seq;
	params.page = '${pagingInfo.page}';
	params.sch_type = $("#sch_type").val();
	params.sch_type_txt = $("#sch_type_txt").val();
	
	goDocDtl(params);
}
</script>
<body>
	<div id="wrap">
		<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/header.jsp" %>
		<!-- Container -->
		<div id="container">
			<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/breadCrumb.jsp" %>
					<div class="searchWrap typeBoard">
						<ul class="searchList">
							<c:forEach var="list" items="${notiTabList}" varStatus="status">
								<c:choose>
									<c:when test="${modl_seq eq list.modl_seq}">
										<li class="active">
									</c:when>
								<c:otherwise>
								<li>
								</c:otherwise>
								</c:choose>
								<a href="${pageContext.request.contextPath}${list.url}">${list.modl_nm}</a>
							</li>
							</c:forEach>
						</ul>
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
					<c:if test="${(pagingInfo.tot_count + notiCnt) > 0}">
					<div class="boardArea">
						<div class="mBoard typeNotice">
							<ul class="boardList">
								<c:forEach var="list" items="${sysDocList}" varStatus="status">
								<c:choose>
								<c:when test="${list.notc_yn eq 'Y'}">
								<c:choose>
								<c:when test="${list.modl_tp_cd eq 'NOTI'}">
								<li class="typeY">
									<div class="listLink" onclick="javascript:goDtl('${list.modl_seq}', '${list.doc_seq}');return false;">
										<div class="listNumber"></div>
										<div class="listContent">
											<div class="listTitle"><span class="iconBoard typeNotice">${list.modl_nm}</span>${list.titl}</div>
											<div class="listDesc">${list.cts}</div>
										</div>
										<div class="listMore">
											<p class="listDate">${list.f_crt_dttm}</p>
										</div>
									</div>
								</li>
								</c:when>
								<c:otherwise>
								<li class="typeY event">
									<div class="listLink" onclick="javascript:goDtl('${list.modl_seq}', '${list.doc_seq}');return false;">
										<div class="listNumber"></div>
										<div class="listContent">
											<div class="listTitle"><span class="iconBoard typeNotice">${list.modl_nm}</span>${list.titl}</div>
											<div class="listDesc">${list.cts}</div>
										</div>
										<div class="listMore">
											<p class="listDate">${list.f_crt_dttm}</p>
										</div>
									</a>
								</li>
								</c:otherwise>
								</c:choose>
								</c:when>
								<c:otherwise>
								<c:choose>
								<c:when test="${list.modl_tp_cd eq 'NOTI'}">
								<li>
									<div class="listLink" onclick="javascript:goDtl('${list.modl_seq}', '${list.doc_seq}');return false;">
										<div class="listNumber">${pagingInfo.tot_count-list.row_num+1}</div>
										<div class="listContent">
											<div class="listTitle"><span class="iconBoard typeNotice">${list.modl_nm}</span>${list.titl}</div>
											<div class="listDesc">${list.cts}</div>
										</div>
										<div class="listMore">
											<p class="listDate">${list.f_crt_dttm}</p>
										</div>
									</a>
								</li>
								</c:when>
								<c:otherwise>
								<li class="event">
									<div class="listLink" onclick="javascript:goDtl('${list.modl_seq}', '${list.doc_seq}');return false;">
										<div class="listNumber">${pagingInfo.tot_count-list.row_num+1}</div>
										<div class="listContent">
											<div class="listTitle"><span class="iconBoard typeNotice">${list.modl_nm}</span>${list.titl}</div>
											<div class="listDesc">${list.cts}</div>
										</div>
										<div class="listMore">
											<p class="listDate">${list.f_crt_dttm}</p>
										</div>
									</a>
								</li>
								</c:otherwise>
								</c:choose>
								</c:otherwise>
								</c:choose>
								</c:forEach>
							</ul>
						</div>
						<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/paging.jsp" %>
					</div>
					</c:if>
					<c:if test="${(pagingInfo.tot_count + notiCnt) eq 0}">
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