<%--
   1. 파일명 : pbbs5001
   2. 파일설명: 위키관리(*TODO_CHG_NM)
   3. 작성일 : 2020-04-06
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
// 위키 게시글 그리드
var bbs_wiki_grid;
// zTree Setting
var setting = {
    view: {
        selectedMulti: false
    },
    edit: {
        enable: true,
        showRemoveBtn: true,
        showRenameBtn: true
    },
    data: {
        keep: {
            parent:true,
            leaf:true
        },
        simpleData: {
            enable: true,
            idKey: "id",
            pIdKey: "pId",
            rootPId: 0
        }
    },
    callback : {
        beforeDrag  : beforeDrag,     // 노드 드래그 전
        beforeRemove: beforeRemove,   // 노드 삭제 전
        beforeRename: beforeRename,   // 노드 이름변경 전
        beforeClick : beforeClick,    // 노드 클릭 전
        onRemove    : onRemove,       // 노드 삭제 이후
        onRename    : onRename,       // 노드 이름변경 이후
        onClick     : onClick         // 노드 클릭 시
    }
};
//노드 드래그 전 : 드래그 방지
function beforeDrag(treeId, treeNodes) {
    return false;
}
//노드 삭제 전 이벤트
function beforeRemove(treeId, treeNode) {
    return confirm("[" + treeNode.name + "] 메뉴얼TREE를 삭제하시겠습니까? \n(상위TREE 삭제시 하위TREE도 같이 삭제됩니다.)");
}
//노드 이름 변경 전 이벤트
function beforeRename(treeId, treeNode, newName) {
    if (newName.length == 0) {
        setTimeout(function() {
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            zTree.cancelEditName();
            alert("메뉴얼명을 입력 해주세요");
        }, 0);
        return false;
    }
    return true;
}
//노드 클릭 전 이벤트
function beforeClick(treeId, treeNode) {
    // 편집 플래그가 true 인 경우
    if(editFlag) {
        // 현재 선택 중인 메뉴얼 확인
        var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
            nodes = zTree.getSelectedNodes();

        //현재 선택 중인 메뉴얼과 새로 선택하려는 메뉴얼이 다르면
        if(nodes[0] != treeNode) alert("현재 편집 중인 메뉴얼이 있습니다.\n내용을 저장 하신 후 다시 진행해주세요.");
        return false;
    }
}
//노드 삭제 후 이벤트
function onRemove(e, treeId, treeNode) {
    //선택되었던 메뉴가 DB에 저장된 메뉴인 경우
    if("Y" == treeNode.isSaved) {
        //DB저장 카테고리 삭제
        dbSavedMenuRemove(treeNode);
    }
    formClear();
}
//DB저장 카테고리 삭제
function dbSavedMenuRemove(treeNode, directFlag) {
    //파라미터 (현재 Node id)
    var params = new Object();
    params.id = treeNode.id;

    if(confirm("[" + treeNode.name + "] 메뉴얼TREE를 삭제하시겠습니까? \n(상위TREE 삭제시 하위TREE도 같이 삭제됩니다.)")) {
        dbSavedMenuRemoveAjaxCall(params, '');
    }
}
//DB 저장 메뉴얼TREE 삭제 Ajax Call
function dbSavedMenuRemoveAjaxCall(params, up_mnu_seq) {
    ajax({
        url : "/pbbs/deletePbbs5001List01.adm",
        data: params,
        success: function(data) {
            if(data.RESULT = "S") {
                alert("메뉴얼TREE가 삭제되었습니다.");
                getAdminMenuTree(true);
            }
        }
    });
}

//노드 이름 변경 후 이벤트
function onRename(e, treeId, treeNode) {
    $("#wiki_ctegry_nm").val(treeNode.name);
    $("input[name='us_yn']:radio[value='"+treeNode.us_yn+"']").prop('checked',true);
}
//노드 클릭 시 이벤트
function onClick(event, treeId) {
    //form 활성화
    formControl(false);

    //현재 선택 메뉴 확인
    var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
        nodes = zTree.getSelectedNodes(),
        treeNode = nodes[0];

    //선택 메뉴 데이터를 상세정보 Form에 설정
    $("#wiki_ctegry_seq").val(treeNode.id);
    $("#up_wiki_ctegry_seq").val(treeNode.pId);
    $("#wiki_ctegry_nm").val(unescapeHtml(treeNode.name));
    $("#srt_seq").val(treeNode.srt_seq);
    $("input[name='us_yn']:radio[value='"+treeNode.us_yn+"']").prop('checked',true);

    //선택 메뉴 데이터 조회용 키값 설정
    bbs_wiki_grid.retreive({data:{wiki_ctegry_seq:treeNode.id}});

    // 선택 메뉴의 설정정보(DB저장여부)를 전역변수에 저장(복사의 경우 예외)
    if("Y" == treeNode.isSaved) {
        isSavedWikiCte = true;
    } else {
        isSavedWikiCte = false;
    }
    zTree.selectNode(treeNode);
}

var zNodes;                 // 트리노드
var newCount = 1;           // 임시Id SEQ
var editFlag = false;       // 편집 진행 플래그
var editWikiCte;            // 편집 진행중인 카테고리 정보
var isSavedWikiCte = false; // 저장된 카테고리 여부

//input,select form control
function formControl(flag) {
    $('input').attr("disabled", flag);
    $('select').attr("disabled", flag);
}
//input,select form clear
function formClear() {
    $("#wikictegryDetail").find("input[type=text],input[type=hidden]").val('');
}
//문자열 escape 처리
function unescapeHtml(str) {
    if (str == null) return "";
    return str.replace(/&amp;/g, '&')
              .replace(/&lt;/g, '<')
              .replace(/&gt;/g, '>')
              .replace(/&quot;/g, '"')
              .replace(/&#039;/g, "'")
              .replace(/&#39;/g, "'")
              .replace(/&#40;/g, "(")
              .replace(/&#41;/g, ")");
}

$(document).ready(function(){
    //좌측 버튼 이벤트 설정 : 추가
    $("#addMenu").on("click", function(e){
        //편집 활성화 (우측)
        formControl(false);

        //Tree 편집 진행 플래그 확인
        if (editFlag) {
            alert("현재 편집 중인 신규 Tree가 있습니다.\n편집내용을 저장 하신 후 다시 진행해주세요.");
            return false;
        }
        // 현재 선택된 노드의 정보를 취득
        var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
            nodes = zTree.getSelectedNodes(),
            treeNode = nodes[0];

        //신규 생성될 노드의 설정값
        var nodeConfig = new Object();
        nodeConfig.name = "새 위키";             // 위키명 기본값
        nodeConfig.isParent = true;           // 하위 위키 허용값 (기본 허용)
        nodeConfig.id = ("TMP" + newCount++); // 위키ID
        nodeConfig.pId = null;                // 상위 위키ID
        nodeConfig.mnu_dpth = 1;
        nodeConfig.us_yn = "N";
        nodeConfig.isSaved = "N";

        //메뉴 추가 허용값 : 기본 허용
        var addMenuOkFlag = true;

        //선택된 메뉴가 존재하면
        if (treeNode) {
            //선택된 메뉴의 정보 확인 (하위허용여부)
            if (treeNode.isParent) {
                //생성될 메뉴의 상위 메뉴 취득
                nodeConfig.pId = treeNode.id;
                nodeConfig.mnu_dpth = treeNode.level + 1;
                //신규 생성될 3Depth 메뉴는 하위 생성 불가
                if (treeNode.level + 1 == 3) {
                    nodeConfig.isParent = false;
                }
            //하위불가일 경우
            } else {
                addMenuOkFlag = false;
            }
        //선택된 메뉴가 없는 경우(최상층 메뉴 추가 시 : 메인메뉴의 유무를 판단)
        } else if(zTree.getNodes()[0]) {
            alert("추가할 메뉴얼Tree를 선택해 주세요.");
            addMenuOkFlag = false;
            formControl(true);
            return false;
        }

        //메뉴 추가 허용값이 유효하면
        if (addMenuOkFlag) {
            //새 메뉴 추가
            treeNode = zTree.addNodes(treeNode, nodeConfig);
            //새로 생성한 메뉴로 포커스
            zTree.editName(treeNode[0]);
            //새로 생성한 메뉴의 정보를 전역변수에 임시 저장
            editWikiCte = treeNode[0];
            //정상적으로 메뉴추가가 완료되면 메뉴추가진행플래그를 진행중으로 변경
            editFlag = true;
            //form 클리어
            formClear();
            //선택 메뉴 데이터를 상세정보 Form에 설정
            $("#up_wiki_ctegry_seq").val(editWikiCte.pId);
            $("#wiki_ctegry_nm").val(unescapeHtml(editWikiCte.name));
            $("input[name='us_yn']:radio[value='"+editWikiCte.us_yn+"']").prop('checked',true);
        } else {
            alert("선택하신 메뉴얼은 하위 메뉴얼을 추가할 수 없습니다.\n(생성가능 계층 : 3층계까지)");
        }
    });

    //좌측 버튼 이벤트 설정 : TREE삭제
    $("#removeTree").on("click", function(e){
        //현재 선택 중인 노드 확인
        var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
            nodes = zTree.getSelectedNodes(),
            treeNode = nodes[0];
        //선택된 노드가 하나도 없으면
        if (nodes.length == 0) {
            alert("삭제하실 Tree를 선택해 주세요.");
            return false;
        }
        //선택한 노드 삭제
        dbSavedMenuRemove(treeNode);
    });

    //좌측 버튼 이벤트 설정 : 편집중단
    $("#resetEdit").on("click", function(e){
        if(!confirm("편집을 중단하시면 저장된 Tree까지만 반영됩니다.\n편집을 중단하시겠습니까?")) return false;
        window.location.reload();
    });

    //저장 버튼 클릭 시 이벤트
    $("#bbsWikiCteForm").submit(function(e) {
        //파라미터 설정
        var params = new Object();
        params.wiki_ctegry_seq    = $("#wiki_ctegry_seq").val();
        params.up_wiki_ctegry_seq = $("#up_wiki_ctegry_seq").val();
        params.wiki_ctegry_nm    = $("#wiki_ctegry_nm").val();
        params.srt_seq = $("#srt_seq").val();
        params.us_yn       = $(":input:radio[name=us_yn]:checked").val();

        ajax({
            url : "/pbbs/savePbbs5001List01.adm",
            data: params,
            success: function(data) {
                if(data.RESULT = "S") {
                    alert('저장되었습니다');
                    //Tree 새로고침
                    getAdminMenuTree(true, data.rtn_wiki_ctegry_seq);
                }
            }
        });
    });

    //Grid 영역 설정(하위메뉴)
    var bbs_wiki_title = "카테고리 하위 메뉴얼 목록";
    var bbs_wiki_config = {
        gridid    : 'bbs_wiki_grid',       // 그리드 id
        pagerid   : 'bbs_wiki_grid_pager', // 그리드 페이지 id
     // gridBtnYn : 'Y',                   // 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        columns   :[
                    {name:'WIKI_DOC_SEQ'      , hidden:true , label:'게시글번호'},
                    {name:'CTEGRY_CD'     , hidden:true , label:'카테고리CD'},
                    {name:'WIKI_CTEGRY_NM'     , label:'카테고리 명'},
                    {name:'WIKI_DOC_CLS_CD', width:80, formatter:'select', label:'게시글 구분', editoptions:{value:'1:일반글;2:FAQ'}},
                    {name:'WIKI_TITL_NM'    , label:'게시글 제목', cellattr:function(rowId, tv, rowObject, cm, rdata) {
                        if(isNotEmpty(rowObject.WIKI_TITL_NM)) {
                            return 'style="cursor: pointer; text-decoration: underline;"'
                        }
                    }},
                    {name:'DSPLY_YN'      , width:80 ,  formatter:'select', label:'게시여부', editoptions:{value:'Y:게시;N:비전시'}},
                    {name:'WIKI_INQ_CNT'   , width:80 ,  label:'조회수'},
                   ],
        editmode    : true,                      // 그리드 editable 여부
        gridtitle   : bbs_wiki_title,            // 그리드명
        shrinkToFit : true,                      // 컬럼 width 자동조정
        autowidth   : true,
        height      : 280,
        cellEdit    : false,
        selecturl   : '/pbbs/getPbbs5001List03', // 그리드 조회 URL
        events:{
            ondblClickRow: function(event, rowid, irow, icol) {
                var row = bbs_wiki_grid.getRowData(rowid);
                if(bbs_wiki_grid.getColName(icol) == 'WIKI_TITL_NM') {
                    var url = "/pbbs/forward.pbbs5003.adm";
                    parent.addTab('sub'+_menu_id, "위키상세", url, row.WIKI_DOC_SEQ);
                }
            }
        }
    };

    bbs_wiki_grid = new UxGrid(bbs_wiki_config);
    bbs_wiki_grid.init();
    bbs_wiki_grid.setGridWidth($('#menuInfo').width());

    //1. 최초 위키트리 조회
    fn_Search();
});

//1. 최초 위키트리 조회
function fn_Search(){
    //1-1.위키 트리 조회
    getAdminMenuTree(true);
}

//1-1.위키 트리 조회
function getAdminMenuTree(initFlag, mnu_seq) {
    if(!initFlag) return false;
    $.ajax({
        url: _context + '/pbbs/getPbbs5001List01',
        type: 'POST',
        data: { _pre_url:"/psys/forward.psys1002.adm"},
        success: function(data) {
            data = JSON.parse(data);
            if (data.AUTH_CHECK_RESULT == _boolean_fail) {
                // 메시지 출력
                alert(data.AUTH_CHECK_MESSAGE);

                // 로그인 페이지로 가야 한다면
                if (data.AUTH_CHECK_ACTION == _action_login || data.AUTH_CHECK_ACTION == _action_none) {
                    popup({url:"/login/forward.login.adm"
                        , winname:"_top"
                        , title:"로그인"
                        , scrollbars:false
                        , autoresize:false
                        , params : {_pre_url : parent.preUrl.getPreUrl(), lgn_id : parent.preUrl.getLgnId() , usr_nm : parent.preUrl.getUsrNm(),
                            usr_eml_addr : parent.preUrl.getUsrEmlAdr(), usr_stat_cd : parent.preUrl.getUsrSsCd(), actv_yn : parent.preUrl.getActvYn()}
                    });
                }
            } else {
                //정상 실행 시 진행(위키 트리구조 생성)
                zNodes = data.mapList;
                $.fn.zTree.init($("#treeDemo"), setting, zNodes);

                //편집 플래그 초기화
                editFlag = false;

                //편집 중인 메뉴정보 초기화
                editWikiCte = null;

                //선택된 메뉴얼TREE가 있는 경우 클릭
                if(isNotEmpty(mnu_seq)) {
                    var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                    var nodes = treeObj.getNodesByParam("id", parseInt(mnu_seq, 10), null)
                    if(nodes.length > 0) $("#" + nodes[0].tId + "_a").trigger('click');
                } else {
                    //최초 조회시 최상단 트리 클릭
                    $("#treeDemo_1_a").trigger("click");
                }
            }
        }
    });
}
//grid resizing
$(window).resize(function() {
    bbs_wiki_grid.setGridWidth($('#menuInfo').width());
});


//위키 트리 저장하기
function fn_Save(){
    //입력값 유효성 확인
    if(submitFormCheck()) {
        $("#bbsWikiCteForm").submit();
    }
}
//유효성 확인
function submitFormCheck() {
    //신규 추가한 메뉴가 편집 중인 경우 [Tree에 "메뉴추가"]
    if (editWikiCte || isSavedWikiCte) {
        var arrId = ["wiki_ctegry_nm"] ;
        return requiredCheck(arrId);
    }

    return true;
}

//입력값 필수 체크
function requiredCheck(arrId) {
    var flag = true;
    for(i=0; i<arrId.length; i++) {
        if(isEmpty($("#"+arrId[i]).val())) {
            var tgtName = $("label[for='"+arrId[i]+"']").text();
            alert("["+tgtName+"] - "+"필수항목을 입력해주세요.");
            $("#"+arrId[i]).focus();
            flag = false;
            return false;
        }
    }
    return flag;
}

//전체 열기, 닫기
var expand_count = 0;
function tree_all(thisobj) {
    var $this = $(thisobj);

    var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
    type = $(thisobj).attr("data-type");

    var totNodes = zTree.getNodes();
    var nodes =totNodes[0].children;

    if (type == "expandAll" && expand_count == 1) {
        $(thisobj).attr("data-type", "collapseAll");
        $this.text("전체닫기");
        $this.addClass("on");
        zTree.expandAll(true);

        expand_count = 0;

    } else if (type == "collapseAll" && expand_count == 0) {
        $(thisobj).attr("data-type", "expandAll");
        $this.text("전체열기");
        $this.removeClass("on");
        zTree.expandAll(false);

        expand_count++;
    }
}
</script>
</head>
<body>
<div class="frameWrap">
    <!-- tab1 contents -->
    <div class="subCon on clear">
        <%@ include file="/WEB-INF/views/pandora3/common/include/btnList2.jsp" %>
        <div class="treeWrap">
            <div class="treeInner">
                <!-- 메뉴얼TREE -->
                <div class="tblType1 menuEdit treeList">
                    <div class="leftTop">
                        <h3>메뉴얼TREE</h3>
                        <button class="btn_common btn_gray" id="addMenu" onclick="return false;">추가</button>
                        <div class="treeBtn">
                            <button class="btn_common btn_default treeOpen" data-type="collapseAll" id="tree_all" onclick="tree_all(this)">전체닫기</button>
                            <button class="btn_common btn_default" id="removeTree" onclick="return false;">TREE삭제</button>
                            <button class="btn_common btn_default" id="resetEdit" onclick="return false;">편집중단</button>
                        </div>
                    </div>
                    <!-- zTree -->
                    <div class="leftBottom">
                        <ul id="treeDemo" class="ztree menuEdit h590"></ul>
                    </div>
                    <!-- //zTree -->
                </div>
                <!-- //메뉴얼TREE -->

                <!-- 메뉴얼 상세정보 -->
                <div id="wikictegryDetail" class="detailInfo">
                    <div class="menuInfo">
                        <div class="tableTop first">
                            <h3 class="title">위키 카테고리 상세정보</h3>
                        </div>
                        <%-- 전송 Form --%>
                        <form name="bbsWikiCteForm" id="bbsWikiCteForm"  method="post" onsubmit="return false;">
                            <input type="hidden" name="up_wiki_ctegry_seq" id="up_wiki_ctegry_seq" />
                            <input type="hidden" name="wiki_ctegry_seq" id="wiki_ctegry_seq" />
                            <table id="menuInfo" class="tblType1">
                                <colgroup>
                                    <col style="width:15%;" />
                                    <col style="" />
                                    <col style="width:25%;" />
                                    <col style="" />
                                </colgroup>
                                <tr>
                                    <th>
                                        <label for="wiki_ctegry_nm">카테고리 명</label>
                                    </th>
                                    <td>
                                        <span class="txt_pw"><input type="text" id="wiki_ctegry_nm" name="wiki_ctegry_nm" class="w100" /></span>
                                    </td>
                                    <th>
                                        <label>카테고리 순서(동일계층)</label>
                                    </th>
                                    <td>
                                        <span class="txt_pw"><input type="text" id="srt_seq" name="srt_seq" class="w20" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' maxlength="3"/> 번째</span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <label>사용여부</label>
                                    </th>
                                    <td colspan="3">
                                        <ul class="radioWrap typeOnline">
                                            <li>
                                                <input type="radio" id="use_y" name="us_yn" value="Y">
                                                <label for="use_y" >사용</label>
                                            </li>
                                            <li>
                                                <input type="radio" id="use_n" name="us_yn" value="N">
                                                <label for="use_n" >미사용</label>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                            </table>
                        </form>
                        <%-- //전송 Form --%>
                        <div class="grid_right_btn">
                            <div id="btn_menu_grid" class="grid_right_btn_in"></div>
                        </div>

                        <!-- Grid : TOP GRID-->
                        <table id="bbs_wiki_grid"></table>
                        <div id="bbs_wiki_grid_pager"></div>
                        <!-- Grid : TOP GRID -->

                    </div>
                </div>
                <!-- //메뉴얼 상세정보 -->
            </div>
        </div>
    </div>
</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>