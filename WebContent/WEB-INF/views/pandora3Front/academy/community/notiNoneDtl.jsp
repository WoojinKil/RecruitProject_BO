<%-- 
   1. 파일명 : notiNoneDtl
   2. 파일설명: 공지사항 게시판 상세 : 상세 정보가 없는 경우
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
			<!-- //TopBanner -->
			<%@ include file="/WEB-INF/views/pandora3Front/academy/common/include/breadCrumb.jsp" %>
					<div class="detailArea typeNoneTitle">
						<div class="boardArea typeEmpty">
							<p class="emptyResult">&#39;공지사항&#39; 게시글이 존재하지 않습니다.</p>
						</div>
					</div>
					<div class="btnWrap typeBlue">
						<a href="javascript:void(0);" class="listLink" onclick="javascript:goList();return false;">목록</a>
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