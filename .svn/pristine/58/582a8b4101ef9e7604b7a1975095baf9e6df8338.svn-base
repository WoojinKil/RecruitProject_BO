<%-- 
   1. 파일명 : paging
   2. 파일설명: (공통) 게시판 페이징
   3. 작성일 : 2019-03-26
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
// 페이징 이동
function goPage(page) {
	var field = $('<input>').attr({type : "hidden", name : "page", id : "page", value : page});
	$('form[name="searchDoc"]').append(field);
	goSearch();
}
</script>

<!-- 페이징 공통요소 -->
<c:set var="totalPage" value="${pagingInfo.tot_page}"/>
<c:set var="firstPage" value="${pagingInfo.page_sno}"/>
<c:set var="lastPage" value="${pagingInfo.page_eno}"/>
<c:set var='pagingCnt' value="5" />

<div class="mPaging typeBoard">
	<c:if test="${pagingInfo.page > pagingCnt}">
	<a href="javascript:goPage(1);" class="firstBtn">처음</a>
	<a href="javascript:goPage(${firstPage-1});" class="preBtn">이전</a>
	</c:if>
	<c:forEach begin="${firstPage}" end="${lastPage}" step="1" varStatus="status">
	<c:choose>
	<c:when test="${pagingInfo.page eq status.index}">
	<a href="javascript:goPage(${status.index});" class="active">${status.index}</a>
	</c:when>
	<c:otherwise>
	<a href="javascript:goPage(${status.index});">${status.index}</a>
	</c:otherwise>
	</c:choose>
	</c:forEach>
	<c:if test="${pagingCnt < totalPage && lastPage < totalPage}">
	<a href="javascript:goPage(${lastPage+1});" class="nextBtn">다음</a>
	<a href="javascript:goPage(${totalPage});" class="lastBtn">마지막</a>
	</c:if>
</div>