<%-- 
   1. 파일명 : notiDtl
   2. 파일설명: 공지사항 게시판 상세
   3. 작성일 : 2019-03-28
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/meta.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=_resourcePath%>/common/css/style.css">
<script type="text/javascript">
// 전역변수
var bbs_tp_cd = isEmpty("${bbs_tp_cd}") ? "NOTI" : "${bbs_tp_cd}";
var modl_seqs = "${modl_seqs}";
var lst_modl_seq = !(parseInt("${lst_modl_seq}", 10) > 0) ? "" : "${lst_modl_seq}";
var page = '${page}';
var sch_type = '${sch_type}';
var sch_type_txt = '${sch_type_txt}';

// 상세 페이지 이동
function goDtl(modl_seq, doc_seq) {
	var params = {};
	params.bbs_tp_cd = bbs_tp_cd;
	params.tmpl_seq = _curr_tmpl_seq;
	params.modl_seqs = modl_seqs;
	params.lst_modl_seq = lst_modl_seq;
	params.modl_seq = modl_seq;
	params.doc_seq = doc_seq;
	params.page = page;
	params.sch_type = sch_type;
	params.sch_type_txt = sch_type_txt;
	
	goDocDtl(params);
}

// 게시판 목록 이동
function goList() {
	// 1. 필수조건
	var field1 = $('<input>').attr({type : "hidden", name : "bbs_tp_cd", id : "bbs_tp_cd", value : bbs_tp_cd});
	var field2 = $('<input>').attr({type : "hidden", name : "tmpl_seq", id : "tmpl_seq", value : _curr_tmpl_seq});
	var field3 = $('<input>').attr({type : "hidden", name : "modl_seqs", id : "modl_seqs", value : modl_seqs});
	var field4 = $('<input>').attr({type : "hidden", name : "modl_seq", id : "modl_seq", value : lst_modl_seq});
	var field5 = $('<input>').attr({type : "hidden", name : "page", value : page});
	
	// 2. 선택조건
	var field6 = $('<input>').attr({type : "hidden", name : "sch_type", value : sch_type});
	var field7 = $('<input>').attr({type : "hidden", name : "sch_type_txt", value : sch_type_txt});
	
	// 3. 전송폼 셋팅 및 서브밋
	var form = $('<form>');
	form.attr({ method : "get", action : _context + "/module/board/boardTypeList.do", name : "goListForm"});
	form.append(field1).append(field2).append(field3).append(field4).append(field5).append(field6).append(field7);
	$(document.body).append(form);
	goListForm.submit();
}
</script>
<body>
	<div id="wrap">
		<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/header.jsp" %>
		<!-- Container -->
		<div id="container">
			<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/breadCrumb.jsp" %>
					<div class="detailArea">
						<div class="titleArea">
							<div class="titleIn">
								<div class="leftWrap">
									<p>
										<c:choose>
										<c:when test="${tbbsDocInf.modl_tp_cd eq 'NOTI'}">
										<span class="iconBoard">
										</c:when>
										<c:otherwise>
										<span class="iconBoard event">
										</c:otherwise>
										</c:choose>
										${tbbsDocInf.modl_nm}
										</span>
									</p>
									<h4 class="detailTitle">${tbbsDocInf.titl}</h4>
								</div>
								<p class="detailDate">${tbbsDocInf.f_crt_dttm}</p>
							</div>
						</div>
						<div class="contentArea">${tbbsDocInf.cts}</div>
						<c:set var="tbbsDocBnAListLen" value="${fn:length(tbbsDocBnAList)}"></c:set>
						<c:if test="${tbbsDocBnAListLen > 0}">
						<div class="viewArea">
							<ul class="viewList">
								<c:set var="befExistYn" value="N" />
								<c:set var="aftExistYn" value="N" />
								<c:forEach var="list" items="${tbbsDocBnAList}" varStatus="status">
								<c:if test="${list.tp eq 'BEFORE'}">
								<c:set var="befExistYn" value="Y" />
								</c:if>
								<c:if test="${list.tp eq 'AFTER'}">
								<c:set var="aftExistYn" value="Y" />
								</c:if>		
								</c:forEach>
								<c:choose>
								<c:when test="${befExistYn eq 'Y' && aftExistYn eq 'N'}">
								<c:forEach var="list" items="${tbbsDocBnAList}" varStatus="status">
								<c:if test="${list.tp eq 'BEFORE'}">
								<li>
									<div class="linkWrap" onclick="javascript:goDtl('${list.modl_seq}', '${list.doc_seq}');return false;">
										<span class="beforeLink">이전글</span>
										<p class="desc">${list.titl}</p>
									</div>
								</li>
								</c:if>
								</c:forEach>
								<li class="typeEmpty">
									<div class="linkWrap">
										<span class="afterLink">다음글</span>
									</div>
								</li>
								</c:when>
								<c:when test="${befExistYn eq 'N' && aftExistYn eq 'Y'}">
								<li class="typeEmpty">
									<div class="linkWrap">
										<span class="beforeLink">이전글</span>
									</div>	
								</li>
								<c:forEach var="list" items="${tbbsDocBnAList}" varStatus="status">
								<c:if test="${list.tp eq 'AFTER'}">
								<li>
									<div class="linkWrap" href="javascript:void(0);" onclick="javascript:goDtl('${list.modl_seq}', '${list.doc_seq}');return false;">
										<span class="afterLink">다음글</span>
										<p class="desc">${list.titl}</p>
									</div>
								</li>
								</c:if>
								</c:forEach>
								</c:when>
								<c:otherwise>
								<c:forEach var="list" items="${tbbsDocBnAList}" varStatus="status">
								<c:if test="${list.tp eq 'BEFORE'}">
								<li>
									<div class="linkWrap" href="javascript:void(0);" onclick="javascript:goDtl('${list.modl_seq}', '${list.doc_seq}');return false;">
										<span class="beforeLink">이전글</span>
										<p class="desc">${list.titl}</p>
									</div>
								</li>
								</c:if>
								<c:if test="${list.tp eq 'AFTER'}">
								<li>
									<div class="linkWrap" href="javascript:void(0);" onclick="javascript:goDtl('${list.modl_seq}', '${list.doc_seq}');return false;">
										<span class="afterLink">다음글</span>
										<p class="desc">${list.titl}</p>
									</div>
								</li>
								</c:if>
								</c:forEach>
								</c:otherwise>
								</c:choose>
							</ul>
						</div>
						</c:if>
						<div class="btnWrap typeBlue">
							<a href="javascript:void(0);" class="listLink" onclick="javascript:goList();return false;">목록</a>
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