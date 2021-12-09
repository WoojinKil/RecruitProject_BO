<%--
   1. 파일명 : pbbs5002
   2. 파일설명: 위키상세/수정(*TODO_CHG_NM)
   3. 작성일 : 2020-04-06
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/wFileControl.js"></script>
<script type="text/javascript">
//전역변수 선언
var board_editor;
var wiki_doc_seq = _param;
var obj = {
     autoUpdateInput : false,
     showDropdowns: true,
     linkedCalendars: false,
     //minDate : moment(),
     //날짜/일시 선택
     timePicker: true,
     timePicker24Hour : true,
     //viewModel : 'month',
     locale: {
         format: 'YYYY-MM-DD HH:mm'
     }
};
//zTree Setting
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
        onClick     : onClick         // 노드 클릭 시
    }
};
var zNodes; // 트리노드
//노드 클릭 시 이벤트 (위키 카테고리 변경)
function onClick(event, treeId) {
    var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
        nodes = zTree.getSelectedNodes(),
        treeNode = nodes[0];
    zTree.selectNode(treeNode);
    $("#wiki_ctegry_seq").val(treeNode.id);
}
//트리 전체 열기, 닫기
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

$(document).ready(function() {
    // 초기화
    doInit();
});

// 저장: 내부 로직 사용자 정의
function fn_Save() {
    //유효성 체크
    if (validChk()) {
        submitFormWrite();
    }
}

//위키 메뉴얼 상세 정보 조회
function getWikibbsAndFleInfo() {
    //메뉴얼 정보 조회
    ajax({
        url     : "/pbbs/getWikibbsAndFleInfo",
        data    : {wiki_doc_seq: wiki_doc_seq},
        success : function(data) {
            //메뉴얼 상세 정보
            var bbsInfo = data.bbsInfo;
            //지정된 메뉴얼이 있으면
            if (bbsInfo != null) {
                $("#wiki_titl_nm").val(bbsInfo.wiki_titl_nm); //제목
                //위키카테고리 관련  조회 및 설정 (트리, 콥보박스)
                getWikiCateTree(bbsInfo.wiki_ctegry_seq);
                //중요여부
                $("input[name='wiki_doc_cls_cd']:radio[value='"+bbsInfo.wiki_doc_cls_cd+"']").attr("checked",true);
                $("#crtr_id").text(bbsInfo.crtr_id);      //작성자
                $("#crt_dttm").text(bbsInfo.crt_dttm);    //작성일
                //게시여부가 설정된 경우, 게시일자 설정
                if ("Y" == bbsInfo.dsply_yn) {
                    $("#dsply_yn").val("Y");
                    $("#dsply_yn").prop("checked", true);
                    //시작일 설정
                    if (!isEmpty(bbsInfo.dsply_st_dttm )) $("#dsply_st_dttm").val(bbsInfo.dsply_st_dttm).attr('disabled', false);
                    //종료일 설정
                    if (!isEmpty(bbsInfo.dsply_ed_dttm)) {
                        $("#dsply_ed_dttm").val(bbsInfo.dsply_ed_dttm);
                        //종료일 없음으로 설정된 경우
                        if ("9999-12-31 23:59" == bbsInfo.dsply_ed_dttm) {
                            maxDate();
                        } else {
                            $("#dsply_ed_dttm").attr('disabled', false);
                        }
                    }
                    $("#endMaxDateBtn").on('click', maxDate);
                    changeTypeCalendar(obj);
                }
                $("#hsh_tag").val(bbsInfo.hsh_tag);       //해시태그
                $("#cts").text(bbsInfo.wiki_cts);         //내용
                //첨부파일 확인
                var files = data.files;
                if (files != null) {
                    var flTotSize = 0;
                    for (var i = 0; i < files.length; i++) {
                        var flSeq = files[i].wiki_fl_seq;
                        var srcFlNm = files[i].orgn_fl_nm;
                        var flSize = parseInt(files[i].fl_size, 10);
                        var uplFlNm = files[i].atch_fl_pth_nm;
                        var flExt = getExtOfFilename(uplFlNm);
                        var fileDownload = "<a href='javascript:void(0);' onclick='javascript:fileDown(" + flSeq + ");return false;' title='클릭하면 파일이 다운로드됩니다.'>" + srcFlNm + "</a>";
                        var fileTag = "<div id='fileBox" + filesSeq + "' class='fileBox'><p class='text-small'>" + fileDownload + "</p>";
                        fileTag += "<ul>";
                        fileTag += "<li><span class='screen_out'>용량</span>" + formatBytes(flSize, 2) + "</li>";
                        fileTag += "<li><input type='checkbox' id='fileChk" + filesSeq + "' name='fileChk' value='" + flSeq + "'><label for='fileChk" + filesSeq + "'>선택</label></li>";
                        fileTag += "<input type='hidden' id='fileNm" + filesSeq + "' value='" + srcFlNm + "' />"
                        fileTag += "<input type='hidden' id='filePath" + filesSeq + "' value='" + uplFlNm + "' />"
                        fileTag += "<input type='hidden' id='fileExt" + filesSeq + "' value='" + flExt + "' />"
                        fileTag += "<input type='hidden' id='fileSize" + filesSeq + "' value='" + flSize + "' />"
                        fileTag += "</ul>";
                        fileTag += "</div>";

                        if(filesSeq == 1) $("#fileList").show();
                        $("#fileList").append(fileTag);

                        var flCnt = $(".fileBox").length;
                        flTotSize += flSize;
                        $("#fileCount").html("<em>" + flCnt + "</em>개 (" + formatBytes(flTotSize, 2) + " / 21.00 MB)");
                        filesSeq++;
                    }
                }
            } else {
                alert("메뉴얼이 삭제되었습니다.");
                //탭 닫기 로직 추가
            }
        }
    });
}

//초기화
function doInit() {
    //데이터 조회
    getWikibbsAndFleInfo();

    //게시여부 이벤트 설정
    $("#dsply_yn").on("click", function () {
        //게시 선택 시
        if($(this).prop("checked")) {
            //기간 달력 설정
            obj.singleDatePicker = false;
            //datepicker 초기화
            changeTypeCalendar(obj);
            $("#dsply_yn").val("Y");
            $("#dsply_st_dttm").val("").attr('disabled', false);
            $("#dsply_ed_dttm").val("").attr('disabled', false);
            //최대 기간
            $("#endMaxDateBtn").on('click', maxDate);
        } else {
            $("#dsply_yn").val("N");
            $("#dsply_st_dttm").val("").attr('disabled', true);
            $("#dsply_ed_dttm").val("").attr('disabled', true);
            $("#endMaxDateBtn").off('click');
        }
    });

    //CKEDITOR 세팅
    board_editor = CKEDITOR;
    board_editor.replace('cts', {
        width : '100%',
        height : '325px',
        draggable : false,
        removeButtons: 'Image'
    });
    board_editor.on('dialogDefinition', function(event) {
        event.data.definition.resizable = CKEDITOR.DIALOG_RESIZE_NONE;
        var dialogName = event.data.name;
        var dialogDefinition = event.data.definition;
        switch(dialogName) {
            case 'image':
                dialogDefinition.removeContents('Link');
                dialogDefinition.removeContents('advanced');
                var infoTab = dialogDefinition.getContents( 'info' );
                var upload = dialogDefinition.getContents( 'Upload' );
                infoTab.remove('txtHSpace');
                infoTab.remove('txtVSpace');
                infoTab.remove('txtBorder');
                infoTab.remove('cmbAlign');
                break;
        }
    });

    //수정 버튼 클릭 시
    $("#btn_mod4").click(function() {
        fn_Save();
    });

    //수정 버튼 클릭 시
    $("#btn_list4").click(function() {
        //위키 메뉴얼 조회 화면 추가
        parent.addTabInFrame("/pbbs/forward.pbbs5001.adm", "CHG","");
        var panelId = parent.$("a[href=#"+ window.frameElement.id +"]").closest("li").remove().attr("aria-controls");
        parent.$("#"+panelId).remove();
        parent.tabs.tabs("refresh");
    });

    //게시글 쓰기 서브밋
    $("#frm_write").submit(function(e) {
        //게시글 등록 파라미터 Object 선언
        var param = new Object();
        //파라미터 정보 설정
        param.wiki_doc_seq       = wiki_doc_seq;                                             //게시글 시퀀스
        param.wiki_ctegry_seq      = $("#wiki_ctegry_seq option:selected").val();          //위키 카테고리
        param.wiki_doc_cls_cd = $(":input:radio[name=wiki_doc_cls_cd]:checked").val(); //중요여부
        param.dsply_yn       = $("#dsply_yn").val();                                 //게시여부
        param.wiki_titl_nm     = $("#wiki_titl_nm").val();                               //제목
        param.hsh_tag        = $("#hsh_tag").val();                                  //해시태그
        param.wiki_cts       = board_editor.instances['cts'].getData();              //내용
        //게시 시/종료일
        var dsply_st_dttm     = $("#dsply_st_dttm").val();
        var dsply_ed_dttm    = $("#dsply_ed_dttm").val();
        if (!isEmpty(dsply_st_dttm )) param.dsply_st_dttm  = dsply_st_dttm;
        if (!isEmpty(dsply_ed_dttm)) param.dsply_ed_dttm = dsply_ed_dttm;
        //첨부 파일 (배열)
        var fileCheckBox = $("input:checkbox[name='fileChk']");
        var wiki_fl_seq_arr = new Array();
        for(var i = 0; i < fileCheckBox.length; i++) {
            wiki_fl_seq_arr.push(fileCheckBox[i].value);
        }
        param.wiki_fl_seq_arr = wiki_fl_seq_arr;

        //위키 게시글 등록
        ajax({
            url     : "/pbbs/savePbbs5002WikiAll.adm",
            data    : param,
            success : function(data) {
                alert("수정되었습니다.");
                //위키 메뉴얼 조회 화면 추가
                parent.addTabInFrame("/pbbs/forward.pbbs5001.adm", "CHG","");
                var panelId = parent.$("a[href=#"+ window.frameElement.id +"]").closest("li").remove().attr("aria-controls");
                parent.$("#"+panelId).remove();
                parent.tabs.tabs("refresh");
            }
        });
    });
}
//위키카테고리 관련  조회 (트리, 콥보박스)
function getWikiCateTree(wiki_ctegry_seq) {
    $.ajax({
        url: _context + '/pbbs/getPbbs5002List01',
        type: 'POST',
        success: function(data) {
            data = JSON.parse(data);
            if (data.RESULT == _boolean_success) {
                //정상 실행 시 진행
                zNodes = data.mapList;
                var html = "";
                //위키 카테고리 생성(콤보박스)
                $(zNodes).each(function (index) {
                    html += "<option class='passOption' value="+ this.id +">"+ this.name +"</option>"
                });
                $("#wiki_ctegry_seq").append(html);
                //위키트리 구조 생성
                $.fn.zTree.init($("#treeDemo"), setting, zNodes);

                //조회대상의 타겟 기준
                var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                var nodes = treeObj.getNodesByParam("id", parseInt(wiki_ctegry_seq, 10), null)
                if(nodes.length > 0) $("#" + nodes[0].tId + "_a").trigger('click');
            }
        }
    });
}

//최대 기간 설정 (종료일 없음)
function maxDate() {
    $("#dsply_ed_dttm").val("").attr('disabled', true);
    $("#dsply_ed_dttm").val("9999-12-31 23:59");

    obj.singleDatePicker = true;

    changeTypeCalendar(obj);
}

//Datepicker 초기화
function changeTypeCalendar(obj) {
    $("#dsply_st_dttm").daterangepicker(obj, function(start, end, separator) {
        if (obj.singleDatePicker === true) {
            $("#dsply_st_dttm").val(start);
        } else {
            $("#dsply_st_dttm").val(start);
            $("#dsply_ed_dttm").val(end);
        }
    });
}

// 입력값 유효성 체크
function validChk() {
    //유효성 검사 결과
    var retVal = true;

    //게시여부가 True일때
    if ($("#dsply_yn").prop("checked") && (isEmpty($("#dsply_st_dttm").val()) || isEmpty($("#dsply_ed_dttm").val()))) {
        alert("게시 날짜를 입력해주세요.");
        $("#dsply_st_dttm").focus();
        retVal = false;
        return retVal;
    }

    if (isEmpty($("#wiki_titl_nm").val())) {
        alert("제목을 입력해주세요.");
        $("#wiki_titl_nm").focus();
        retVal = false;
        return retVal;
    }

    var cts = board_editor.instances['cts'].getData();
    if(isEmpty(cts)) {
        alert("내용을 입력해주세요.");
        board_editor.on('instanceReady', function(event) {
            board_editor.instances.cts.focus();
        });
        board_editor.instances.cts.focus();
        retVal = false;
        return retVal;
    }

    //Data Byte 체크
    $("input[data-byte]").each(function(index, item) {
        var maxByte = $(item).data("byte");
        var target = "#" + $(item).attr("id");
        var title = $(item).attr("title");
        if(byteCheck($(target)) > maxByte) {
            alert(title + "은(는) " + maxByte + "자를 넘을 수 없습니다.");
            retVal = false;
            return false;
        }
    });

    return retVal;
}

// 쓰기 서브밋
function submitFormWrite() {
    if(!confirm("작성글을 수정하시겠습니까?")) return false;
    $("#frm_write").submit();
}

</script>
<style>
.cals_div.type_two{position:relative; padding-right:81px;}
#endMaxDateBtn{position:absolute;right:0;top:0;height:23px;line-height:23px;padding:0 5px;border:1px solid #757575;background:#777777;color:#fff;font-size:12px;box-sizing:border-box;cursor:pointer;}
</style>
</head>
<body>
    <div class="frameWrap">
        <div class="subCon">
            <h1><%=_title %></h1>
            <div class="treeWrap">
                <div class="treeInner">

                    <!-- 메뉴얼TREE -->
                    <div class="tblType1 menuEdit treeList">
                        <div class="leftTop">
                            <h3>메뉴얼TREE</h3>
                            <button class="btn_common btn_default treeOpen" data-type="collapseAll" id="tree_all" onclick="tree_all(this)">전체닫기</button>
                            <div class="treeBtn">
                            </div>
                        </div>
                        <!-- zTree -->
                        <div class="leftBottom">
                            <ul id="treeDemo" class="ztree menuEdit h590"></ul>
                        </div>
                        <!-- //zTree -->
                    </div>
                    <!-- //메뉴얼TREE -->

                    <div class="detailInfo">
                        <div class="menuInfo">
                            <div class="tableTop first">
                                <h3 class="title">위키 메뉴얼 상세 정보</h3>
                                <div class="grid_btn">
                                    <button type="button" class="btn_common btn_default" id="btn_list4">목록</button>
                                    <button type="button" class="btn_common btn_default" id="btn_mod4">수정</button>
                                </div>
                            </div>
                            <table id="menuInfo" class="tblType1">
                                <colgroup>
                                    <col style="width:120px;">
                                    <col style="width:100px;">
                                    <col style="width:">
                                    <col style="width:120px;">
                                    <col style="width:">
                                </colgroup>
                                <tr>
                                    <th><label for="wiki_ctegry_seq" class="vv">위키 카테고리</label></th>
                                    <td colspan="2"><span class="txt_pw"><select class="select w100" name="wiki_ctegry_seq" id="wiki_ctegry_seq"></select></span></td>
                                    <th><label for="wiki_doc_cls_cd" class="vv">중요여부</label></th>
                                    <td>
                                        <ul class="radioWrap typeOnline">
                                            <li>
                                                <input name="wiki_doc_cls_cd" id="wiki_doc_cls_cd1" type="radio" value="1" checked>
                                                <label for="wiki_doc_cls_cd1">일반글</label>
                                            </li>
                                            <li>
                                                <input name="wiki_doc_cls_cd" id="wiki_doc_cls_cd2" type="radio" value="2">
                                                <label for="wiki_doc_cls_cd2">FAQ</label>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                                <tr>
                                    <th>작성자</th>
                                    <td colspan="2"><span id="crtr_id"></span></td>
                                    <th>작성일</th>
                                    <td><span id="crt_dttm"></span></td>
                                </tr>
                                <tr>
                                    <th><label for="dsply_yn" class="vv">게시여부</label></th>
                                    <td>
                                        <div class="tableCheck">
                                            <label class="container typeInspect">게시
                                                <input type="checkbox" name="dsply_yn" value="N" id="dsply_yn">
                                                <span class="checkmark"></span>
                                            </label>
                                        </div>
                                    </td>
                                    <td class="nobor" colspan="3">
                                        <div class="cals_div type_two">
                                            <span class="txt_pw"><input class="cals w45" type="text" value="" id="dsply_st_dttm" autocomplete="off" disabled="disabled" /></span>
                                            <span class="space w10">~</span>
                                            <span class="txt_pw"><input class="cals w45" type="text" value="" id="dsply_ed_dttm" autocomplete="off" disabled="disabled" /></span>
                                            <input type="button" value="종료일 없음" id="endMaxDateBtn">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th><label for="titl" class="vv">제목</label></th>
                                    <td colspan="4"><span class="txt_pw"><input type="text" name="wiki_titl_nm" id="wiki_titl_nm" class="w100" data-byte="250" title="제목" /></span></td>
                                </tr>
                                <tr>
                                    <th><label for="titl" class="vv">해시태그</label></th>
                                    <td colspan="4"><span class="txt_pw"><input type="text" name="hsh_tag" id="hsh_tag" class="w100" data-byte="250" title="해시태그" placeholder="해시태그 1개당 [,]로 구분해주세요. (예시> 기술,개발 => #기술 #개발)" /></span></td>
                                </tr>
                                <tr>
                                    <td colspan="5" class="editorTd">
                                        <div class="editor"><textarea name="cts" id="cts"></textarea></div>
                                        <div class="board_writeFiles">
                                            <div class="form">
                                                <p>파일 첨부를 클릭하세요.</p>
                                                <button style="display:inline;" id="btnAttachFile">파일첨부</button>
                                                <p>*문서 첨부 제한 : 21.00MB (허용 확장자 *.*)</p>
                                            </div>
                                            <div class="info">
                                                <p class="text-small">첨부파일 <span id="fileCount"><em>0</em>개 (0 MB / 21.00 MB)</span></p>
                                                <div>
                                                    <button style="display:inline;" id="btnFileAdd">본문삽입</button>
                                                    <button style="display:inline;" id="btnFileDelete">선택삭제</button>
                                                </div>
                                            </div>
                                            <div class="list" id="fileList" style="display:none;"></div>
                                            <!-- loading bar -->
                                            <div class="files-prog" style="display:none;">
                                                <p id="file-message"></p>
                                                <div class="progress">
                                                    <div class="progress-bar" id="progBar" role="progressbar" aria-valuemin="0" aria-valuemax="100"></div>
                                                </div>
                                            </div>
                                            <!--// loading bar -->
                                        </div>
                                    </td>
                                </tr>
                            </table>

                            <form name="frm_file" id="frm_file" enctype="multipart/form-data" method="post" onsubmit="return false;">
                                <div id="fileContainer" style="display:none;">
                                    <input type="file" id="files" name="files" multiple="multiple" />
                                </div>
                            </form>

                            <form name="frm_write" id="frm_write" enctype="multipart/form-data" method="post" onsubmit="return false;"></form>

                        </div>
                    </div>

                </div>
            </div>

        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
