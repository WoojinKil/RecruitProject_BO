<%--
   1. 파일명 : pbbs5004
   2. 파일설명: 위키프론트
   3. 작성일 : 2020-04-14
   4. 작성자 :
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/wFileControl.js"></script>
<script type="text/javascript">
//현재 선택된 좌측 카테고리
var selectionCtegry = 0;
//현재 선택된 하단 페이징 번호
var selectionPageNo = 0;
//현재 선택된 정렬순서
var selectionSort = 0;
//1페이지당 표시 갯수
var rowList = [10, 20, 30];
//현재 선택된 1페이지당 표시 갯수
var selectionPageCount = rowList[0];

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
    selectionSort = $this.attr("id") == "sort1" ? 0 : 1;
    $this.addClass("on").siblings().removeClass("on");
    fn_search();
}
$(document).ready(function(){
    //위키카테고리  조회 (트리)
    getWikiCateTree();
    //위키 메뉴얼 목록 조회
    getWikibbsList(1);
    //엔터입력시 자동조회
    $(document).on('keyup', '#keyword', function(e){
        if(event.keyCode==13){
           fn_search();
        }
    });
});
//위키카테고리 클릭
function clickWikictegry(wiki_ctegry_seq) {
    //카테고리 코드가 없으면
    if (isEmpty(wiki_ctegry_seq)) {
        $(".tree_view_1 li > a").removeClass("on");
        wiki_ctegry_seq = 0;
    }
    selectionCtegry = wiki_ctegry_seq;
    //선택된 카테고리의 1페이지로 이동
    getWikibbsList(1);
}
//검색어 조회
function fn_search(holdYn) {
    //Data Byte 체크
    var chkByte = true;
    $("input[data-byte]").each(function(index, item) {
        var maxByte = $(item).data("byte");
        var target = "#" + $(item).attr("id");
        var title = $(item).attr("title");
        if(byteCheck($(target)) > maxByte) {
            alert(title + "은(는) " + maxByte + "자를 넘을 수 없습니다.");
            chkByte = false;
            return false;
        }
    });
    //검색어가 유효할 경우
    if (chkByte) {
        getWikibbsList(holdYn == "Y" ? selectionPageNo : 1);
    } else {
        $("#keyword").val("");
        $("#keyword").focus();
    }
}
//검색어 찾기
function indexOfAll(title, srcword) {
    //대상 문장의 길이 확인
    var titLen = title.length;
    var indexArr = new Array();
    for (var i = 0; i < titLen; i++) {
        var index = title.indexOf(srcword, i);
        if (index > -1 && $.inArray(index,indexArr) == -1) {
            indexArr.push(index);
        }
    }
    var html = "";
    for (var i =0; i < title.length; i++) {
        if ($.inArray(i, indexArr) > -1) {
            html += ("<em class=\"imfort_txt\">" + title.substring(i,i+srcword.length) + "</em>");
            i += (srcword.length-1)
        } else {
            html += (title.substring(i,(i+1)));
        }
    }

    return html;
}

//위키메뉴얼  조회 (트리)
function getWikibbsList(page) {
    var params = new Object();
    params.wiki_ctegry_seq = selectionCtegry;
    params.rows         = selectionPageCount;
    params.page         = page;
    if (!isEmpty($("#keyword").val())) {
        params.keyword = $("#keyword").val();
    }
    params.SEL_ORD = selectionSort == 1 ? "WIKI_INQ_CNT" : "WIKI_DOC_SEQ";

    ajax({
        url    : "/pbbs/getPbbs5004BbsList",
        data   : params,
        async  : true,
        beforeSend : function() {
            //전체 로딩바가 활성 도중인 경우는 로딩바 없음
            if ($(".loading", parent.document).css("display") != "block") {
                $("#loadingBar").show();
            }
        },
        success: function(data) {
            //상세정보 영역 초기화
            $("#wikiDetail").remove();
            $("#wikiDetailBtn").find("button").remove();

            //목록 엘리먼트 작성
            var list = data.mapList;
            var keyword_list = data.keyword_list;
            var isSearch = keyword_list!= null && keyword_list.length > 0 ? true : false;
            var html = "";
            for (var i = 0; i < list.length; i++) {
                //FAQ 메뉴얼의 경우 클래스 및 엘리먼트 추가
                if (list[i].WIKI_DOC_CLS_CD == "2") {
                html += "<li class=\"type_btn\">";
                html +=     "<span class=\"board_inf\">FAQ</span>";
                //일반 메뉴얼의 경우
                } else {
                html += "<li>";
                }
                //시스템, 제목 설정
                html +=     "<span class=\"desc\" title=\"" + ("[" + list[i].WIKI_CTEGRY_NM + "] " + list[i].WIKI_TITL_NM) + "\" onclick=\"javascript:goDetail(" + list[i].WIKI_DOC_SEQ + ")\">"

                //검색어 유뮤 확인
                if (isSearch) {
                    var tit_nm = list[i].WIKI_TITL_NM;
                    for (var j = 0; j < keyword_list.length; j++) {
                        tit_nm = indexOfAll(tit_nm, keyword_list[j]);
                    }
                    html += ("<em>[" + list[i].WIKI_CTEGRY_NM + "]</em> " + tit_nm);

                    if (!isEmpty(list[i].HSH_TAG)) {
                        var hshArr = list[i].HSH_TAG.split(",");
                        if (hshArr.length > 0 && !isEmpty(hshArr[0])) {
                            html += "<ul class=\"notice_sub_list\">"
                            for (var j = 0; j < hshArr.length; j++) {
                                if (!isEmpty(hshArr[j])) {
                                    //해시태그가 키워드(한단어 기준)와 완전 일치하면
                                    if ($.inArray(hshArr[j],keyword_list) > -1) {
                                        html += "<li class=\"imfort_txt\">#" + hshArr[j] + "</li>";
                                    } else {
                                        html += "<li>#" + hshArr[j] + "</li>";
                                    }
                                }
                            }
                            html += "</ul>";
                        }
                    }
                } else {
                    html +=     "<em>[" + list[i].WIKI_CTEGRY_NM + "]</em> " + list[i].WIKI_TITL_NM;
                }
                html +=     "</span>"
                //등록일 설정
                html +=     "<span class=\"date\">" + list[i].CRT_DTTM + "</span>"
                html += "</li>";
            }
            //전체 갯수
            var totalSize = 0;
            //1건 이상 있으면
            if (!isEmpty(html)) {
                totalSize = list[0].TOTAL_COUNT;
                //리스트 클래스 삭제 (없을경우)
                $("#treeList").removeClass("list_none");
            } else {
                //리스트 클래스 추가
                $("#treeList").addClass("list_none");
            }
            //리스트 작성
            $("#treeList").html(html);
            //페이징 처리
            initPage("treeList", "treePaging", true, params.rows, totalSize, page);
            //현재 선택된 페이지 화면저장
            selectionPageNo = page;
            //현재 선택된 Row 화면 저장
            selectionPageCount = params.rows;
        },
        //전송 후 process
        complete : function() {
            //스크롤 최상단
            $("#pbbs5004").scrollTop(0);
            //로딩바 종료
            $("#loadingBar").hide();
        }
    });
}

//메뉴얼 상세 이동
var detailTag = "<div id=\"wikiDetail\" class=\"notice_detail\"><div class=\"notice_in\"></div></div>";
var dtlBtnTag = "<button class=\"m_btn_default full\" onclick=\"javascript:fn_search('Y');\">목록</button>"
function goDetail(bbsSrno) {
    var params = new Object();
    params.wiki_doc_seq     = bbsSrno;
    params.wiki_ctegry_seq = selectionCtegry;
    params.rows         = selectionPageCount;
    params.page         = selectionPageNo;
    if (!isEmpty($("#keyword").val())) {
        params.keyword = $("#keyword").val();
    }
    params.SEL_ORD = selectionSort == 1 ? "WIKI_INQ_CNT" : "WIKI_DOC_SEQ";
    //상세정보 취득
    ajax({
        url   : '/pbbs/getWikibbsFrontDtl',
        data  : params,
        async : true,
        beforeSend : function() {
            $("#loadingBar").show();
        },
        //전송 성공 process
        success: function(data) {
            var bbsInfo = data.bbsInfo;
            if (!isEmpty(bbsInfo)) {
                //리스트 영역 초기화
                $("#treeList").html("");
                //페이징 영역 초기화
                initPage("", "treePaging", false);
                //컨텐츠 영역 작성1(상세정보, 첨부파일, 이전/다음글)
                var detail = $(detailTag);
                //컨텐츠 타이틀 영역 작성
                var title = "";
                title += "<h2 class=\"title\">";
                //시스템, 게시글 제목
                title +=     "<span>[" + bbsInfo.wiki_ctegry_nm + "] " + bbsInfo.wiki_titl_nm + "</span>";
                title += "</h2>";
                //등록일
                title += "<span class=\"date\">" + bbsInfo.crt_dttm + "</span>"
                //해시 태그 확인
                if (!isEmpty(bbsInfo.hsh_tag)) {
                    var hshArr = bbsInfo.hsh_tag.split(",");
                    if (hshArr.length > 0 && !isEmpty(hshArr[0])) {
                        title += "<ul class=\"notice_sub_list\">"
                        for (var i = 0; i < hshArr.length; i++) {
                            if (!isEmpty(hshArr[i]))
                                title += "<li>#" + hshArr[i] + "</li>";
                        }
                        title += "</ul>";
                    }
                }
                //타이틀 영역 추가
                detail.append($("<div class=\"notice_title\">").html(title));
                //컨텐츠 내용 영역 추가
                detail.append($("<div class=\"notice_content\">").html(bbsInfo.wiki_cts));
                //첨부 파일 영역 추가
                var files = data.files;
                if (files!= null && files.length > 0) {
                    var fStr = "";
                    fStr += "<div class=\"notile_file_list\">"
                    fStr +=     "<ul class=\"file_list\">";
                    for (var i = 0; i < files.length; i++) {
                        var flSeq = files[i].wiki_fl_seq;
                        var srcFlNm = files[i].orgn_fl_nm;
                        var flSize = parseInt(files[i].fl_size, 10);
                        var uplFlNm = files[i].atch_fl_pth_nm;
                        if (!isEmpty(bbsInfo.wiki_cts) && (bbsInfo.wiki_cts).indexOf(uplFlNm) > -1){
                            fStr += "<li class='fileBox' style='display:none;'>";
                        } else {
                            fStr += "<li class='fileBox'>";
                        }
                        fStr +=         "<div class=\"file_name\">";
                        fStr +=             "<a href=\"javascript:fileDown(" + flSeq + ");\" title=\"클릭하면 파일이 다운로드됩니다.\">" + srcFlNm + " ";
                        fStr +=                 "<span class=\"volumn\">(" + formatBytes(flSize, 2) + ")</span>";
                        fStr +=             "</a>";
                        fStr +=         "</div>";
                        fStr +=         "<span class='file_down'><img src='${pageContext.request.contextPath}/resources/pandora3/images/img_file_download.png' alt='파일 다운로드'></span>"
                        fStr +=      "</li>";
                    }
                    fStr +=     "</ul>";
                    fStr += "</div>"
                    detail.append(fStr);
                }

                //이전글 다음글 목록
                var rtnPrvNxtList = data.rtnPrvNxtList;
                if (rtnPrvNxtList != null && rtnPrvNxtList.length > 0) {
                    var prvNxt = "";
                    //이전글 다음글 영역 추가
                    prvNxt += "<div class=\"page_wrap\">";
                    prvNxt +=     "<ul class=\"page_move_list\">";
                    for (var i = 0; i < rtnPrvNxtList.length; i++) {
                        var wiki_type = rtnPrvNxtList[i].wiki_type;
                        var wiki_titl_nm = rtnPrvNxtList[i].wiki_titl_nm;
                        prvNxt += "<li>"
                        prvNxt +=     "<a href=\"javascript:goDetail(" + rtnPrvNxtList[i].wiki_doc_seq + ")\">";
                        prvNxt +=         "<span class=\"left\">" + (wiki_type == "prev" ? "이전글" : wiki_type == "next" ? "다음글" : "") + "</span>";
                        prvNxt +=         "<span class=\"right\" title=\"" + wiki_titl_nm + "\">" + wiki_titl_nm + "</span>";
                        prvNxt +=     "</a>"
                        prvNxt += "</li>"
                    }
                    prvNxt +=     "</ul>";
                    prvNxt += "</div>";
                    detail.append(prvNxt);
                }
                //상세정보 영역 초기화
                $("#wikiDetail").remove();
                $("#wikiDetailBtn").find("button").remove();
                //전체 정보 그리기
                $("#wikiDetailBtn").before(detail);
                //버튼정보 그리기
                $("#wikiDetailBtn").find("div.m_btn_wrap").append(dtlBtnTag);
            }
        },
        //전송 후 process
        complete : function() {
            //스크롤 최상단
            $("#pbbs5004").scrollTop(0);
            //로딩바 닫기
            $("#loadingBar").hide();
        }
    });
}

//위키카테고리  조회 (트리)
function getWikiCateTree() {
    ajax({
        url    : "/pbbs/getPbbs5002List01",
        success: function(data) {
            //위키 카테고리 트리 결과
            var list = data.mapList;
            //카테고리 트리 작성 시작
            var html = $("<ul class=\"tree_view_1\">");
            for (var i = 0; i < list.length; i++) {
                //카테고리 노드 (본인)
                var addEle = $("<li>").attr({id:"treeId"+list[i].id, title:list[i].name});
                //카테고리 노드 Depth
                var nowLev = list[i].LEV;
                //카테고리 노드 배치 위치 (부모)
                var prtEle = html.find("#treeId"+list[i].pId);
                //1Depth인 경우
                if (nowLev == "1") {
                    addEle.append($("<span>").attr({onclick:"menu_toggle(this);"}).addClass("tree_icon"));
                    //1Depth 카테고리 클릭 이벤트 설정
                    addEle.append($("<a>").attr({href:"javascript:clickWikictegry(" + list[i].id+ ");"}).append("<span class=\"ellipsis\">" + list[i].name + "</span>"));
                    html.append(addEle);
                //그외
                } else {
                    //2Depth
                    if (nowLev == "2") {
                        addEle.append($("<span>").attr({onclick:"menu_toggle(this);"}).addClass("tree_icon"));
                    //2Depth
                    } else if (nowLev == "3") {
                        addEle.addClass("no_sub");
                    }
                    //아이콘 붙이기, 카테고리 클릭 이벤트 설정
                    addEle.append($("<a>").attr({href:"javascript:clickWikictegry(" + list[i].id+ ");"}).html("<span class=\"folder_icon\"></span><span class=\"ellipsis\">" + list[i].name + "</span>"));

                    //노트 추가 대상(Depth별 틀)
                    var addTarget = prtEle.find("ul.tree_view_"+nowLev);
                    //최초 추가인 경우는 틀 생성
                    if (addTarget.length == 0) {
                        prtEle.append($("<ul class=\"tree_view_" + nowLev + " menu_toggle\">").append(addEle));
                    } else {
                        addTarget.append(addEle);
                    }
                }
            }

            //2계층 하위 여부 확인 (하위가 없으면 + 삭제용 클래스 추가)
            html.find("ul.tree_view_2 > li").each(function(){
                if ($(this).find("ul.tree_view_3").length == 0) $(this).addClass("no_sub");
            })

            //카테고리 트리 작성
            $("#treeView").append(html);

            //카테고리 이벤트 설정
            $(".tree_view_1").on("click", "li > a", function(e) {
                $(".tree_view_1 li > a").removeClass("on");
                $(this).addClass("on");
            });

            //전체 펼치기
            $("#toggleAll").trigger("click");
        }
    });
}
/*
 * 페이징
 *
 * @param gridId     : 리스트 ID
 * @param pagerId    : 페이징 ID
 * @param pagerYn    : 페이지 정보를 나타낼 것인지 / boolean / 생략시 false
 * @param pageCount  : 한 페이지에 보여줄 레코드 수  (ex:1 2 3 4 5)
 * @param totalSize  : 전체 목록 수
 * @param currentPage: 현재 페이지
 */
function initPage(gridId, pagerId, pagerYn, pageCount, totalSize, currentPage) {
    //페이징 초기화
    $("#" + pagerId).empty();

    if (pagerYn == null || pagerYn == "")
         pagerYn = false;

    if (!pagerYn) {
        $("#wikiList").hide();
        $("#wikiListTab").hide();
        return;
    } else {
        $("#wikiList").show();
        $("#wikiListTab").show();
    }

    if (isEmpty(pagerId))
        return;

    // 그리드 데이터 전체의 페이지 수
    var totalPage = Math.ceil(totalSize/pageCount);

    // 전체 페이지 수를 한화면에 보여줄 페이지로 나눈다.
    var totalPageList = Math.ceil(totalPage/pageCount);

    // 페이지 리스트가 몇번째 리스트인지
    var pageList=Math.ceil(currentPage/pageCount);

    // 페이지 리스트가 1보다 작으면 1로 초기화
    if (pageList<1) pageList=1;

    // 페이지 리스트가 총 페이지 리스트보다 커지면 총 페이지 리스트로 설정
    if (pageList>totalPageList) pageList = totalPageList;

    // 시작 페이지
    var startPageList=((pageList-1)*pageCount)+1;
    // 끝 페이지
    var endPageList=startPageList+pageCount-1;
    // 시작 페이지와 끝페이지가 1보다 작으면 1로 설정

    // 끝 페이지가 마지막 페이지보다 클 경우 마지막 페이지값으로 설정
    if (startPageList<1)       startPageList=1;
    if (endPageList>totalPage) endPageList=totalPage;
    if (endPageList<1)         endPageList=1;

    // 페이징 DIV에 넣어줄 태그 생성변수
    var pageInner="";

    if (currentPage <=1 || totalSize <= 1) {
        pageInner+="<li class='leftOne'><span class='pageNum typeImg'><img src='${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_page_left_arrow2.png' alt=''></span></li>";
        pageInner+="<li class='leftTwo'><span class='pageNum typeImg'><img src='${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_page_left_arrow1.png' alt=''></span></li>";
    } else {
        pageInner+="<li class='leftOne'><a class='pageNum typeImg' href='javascript:pageFun1();' title='첫 페이지로 이동'><img src='${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_page_left_arrow2.png' alt=''></a></li>";
        pageInner+="<li class='leftTwo'><a class='pageNum typeImg' href='javascript:pageFun2("+ currentPage +");' title='이전 페이지로 이동'><img src='${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_page_left_arrow1.png' alt=''></a></li>";
    }


    // 페이지 숫자를 찍으며 태그생성 (현재페이지는 강조태그)
    for (var i=startPageList; i<=endPageList; i++)
    {
        var titleGoPage = i + "페이지로 이동";

        if (i==currentPage) {
            pageInner = pageInner +"<li class='on'><span class='pageNum'>"+(i)+"</span></li>";
        } else {
            pageInner = pageInner +"<li><a class='pageNum' href='javascript:pageFun3("+(i)+");' id='"+(i)+"' title='"+ titleGoPage +"'>"+(i)+"</a></li>";
        }
    }

    // 다음 페이지 리스트가 있을 경우
    if (totalSize <= 1 || currentPage == totalPage) {
        pageInner+="<li class='rightOne'><span class='pageNum typeImg'><img src='${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_page_right_arrow1.png' alt=''></span></li>";
        pageInner+="<li class='rightTwo'><span class='pageNum typeImg'><img src='${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_page_right_arrow2.png' alt=''></span></li>";
    } else {
        pageInner+="<li class='rightOne'><a class='pageNum typeImg' href='javascript:pageFun4("+ currentPage +");' title='다음 페이지로 이동'><img src='${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_page_right_arrow1.png' alt=''></a></li>";
        pageInner+="<li class='rightTwo'><a class='pageNum typeImg' href='javascript:pageFun3("+ totalPage +");' title='마지막 페이지로 이동'><img src='${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_page_right_arrow2.png' alt=''></a></li>";
    }

    var pageInfoText = "총 " + totalSize + "건";

    var table = "";
    table+= "<div class='pagination'>";
    table+= "<ul class='paging'>";
    table+= pageInner;
    table+= "</ul>";

    table+="<div class='pagingRight'>";
    table+="<select id='pagerNum_"+pagerId+"' name='' class='select' onchange='rowChange(this);' >";

    for (var i in rowList) {
         table+="<option value='" + rowList[i] + "'>"+ rowList[i] +"</option>";
    }

    table+="</select>";
    table+= pagerYn ? "<span>" + pageInfoText + "</span> " : "" ;
    table+="</div>";
    table+= "</div>";

    // 페이징할 DIV태그에 우선 내용을 비우고 페이징 태그삽입
    $("#"+pagerId).html("");

    // 페이징 html 추가
    $("#"+pagerId).append(table);

    // 페이징 기준 기본값 설정
    $("#pagerNum_"+pagerId).val(selectionPageCount);

}
//페이징 기준 변경
function rowChange(obj) {
    selectionPageCount = obj.value;
    getWikibbsList(1);
}
//첫페이지로
function pageFun1() {
    getWikibbsList(1);
}
//이전페이지로
function pageFun2(page) {
    getWikibbsList(page-1);
}
//페이지 이동
function pageFun3(page) {
    getWikibbsList(page);
}
//다음페이지로
function pageFun4(page) {
    getWikibbsList(page+1);
}
</script>
</head>
<body>
    <div class="frameWrap">
        <div id="pbbs5004" class="subCon typeSearch front">
            <div class="subConIn">
                <div class="board_search titleFix">
                    <div class="board_title">
                        <h3 id="pbbs5004Title" class="title type_notice"><%=_title %></h3>
                    </div>
                </div>
                <div class="custom_tree_area">
                    <div class="left">
                        <!-- 카테고리 트리 -->
                        <div id="treeView" class="tree_borad">
                            <div class="tree_btn">
                                <div class="toggleWrap">
                                    <button type="button" class="total_btn" onclick="clickWikictegry(0);">전체</button>
                                    <span id="toggleAll" class="total_span" onclick="menu_total_toggle(this)"></span>
                                </div>
                            </div>
                        </div>
                        <!-- //카테고리 트리 -->
                    </div>
                    <div class="right">
                        <!-- 상세 영역 start -->
                        <div id="wikiDetailBtn" class="notice_btn">
                            <div class="m_btn_wrap"></div>
                        </div>
                        <!-- //상세 영역 end -->

                        <!-- 목록 영역 start -->
                        <!-- Tab 영역 -->
                        <div id="wikiListTab" class="board_tab_area">
                            <div class="board_tab_in">
                                <ul class="board_tab_list" id ="catList">
                                    <li id="sort1" class="catlistDtl on" style="cursor:pointer;" onclick="tabClick(this);">
                                        <a>최신순</a>
                                    </li>
                                    <li id="sort2" class="catlistDtl" style="cursor:pointer;" onclick="tabClick(this);">
                                        <a>조회순</a>
                                    </li>
                                </ul>
                                <div class="tab_search">
                                    <input type="text" class="board_search" id="keyword" placeholder="잠깐! 메뉴 찾기가 어려우신가요?" autocomplete="off" data-byte="250" title="검색어"/>
                                    <button id ="btn_search" onclick="javascript:fn_search();">
                                        <img src="${pageContext.request.contextPath}/resources/pandora3/images/img_board_search_btn.png" alt="공지사항 조회">
                                    </button>
                                </div>
                            </div>
                        </div>
                        <!-- 목록, 페이징 -->
                        <div id="wikiList" class="tree_table" >
                            <!-- 메뉴얼 목록 -->
                            <ul id="treeList" class="tree_table_list"></ul>
                            <!-- 메뉴얼 페이징 -->
                            <div id="treePaging" class="treePaging"></div>
                        </div>
                        <!-- 목록영역 end -->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="loadingBar" class="loading" style="display:none;">
        <img src="${pageContext.request.contextPath}/resources/pandora3/images/common/img_loading_2.gif" alt="loading">
        <p class="desc">데이터를 불러오고 있습니다 <em>잠시만 기다려주세요</em></p>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>