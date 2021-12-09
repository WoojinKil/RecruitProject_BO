<%--
   1. 파일명 : pbbs1008
   2. 파일설명 : 공지게시글 등록
   3. 작성일 : 2018-04-11
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/bFileControl.js"></script>
<style>.b_type1{display:none;}</style>
<script type="text/javascript">
var board_editor;
var newFileFlag = false;

var obj = {
        autoUpdateInput : false,
        showDropdowns: true,
        linkedCalendars: false,
    //  minDate : moment(),
        /* 날짜/일시 선택 start */
        timePicker: true,
        timePicker24Hour : true,
        //viewModel : 'month',
        locale: {
            format: 'YYYY-MM-DD HH:mm'
        }
        /* 날짜/일시 선택 end */
};

$(document).ready(function() {


    // 쓰기 서브밋
    $("#frm_write").submit(function(e) {
        var cts = board_editor.instances['cts'].getData();
        // 게시글 시퀀스 취득
        ajax({
            url:"/pbbs/getPbbsDocSeq.adm",
            data:{modl_seq:$("#modl_seq option:selected").val()},
            success:function(data) {
                if(isNotEmpty(data.doc_seq)) {
                    // 게시글 등록
                    regDocInf(data.doc_seq, cts);
                }
            }
        });
        e.preventDefault();
    });

    // 숫자만 입력 : 면수
    $("#total_page_num").keydown(function(e) {
        var flag = onlyNumber(e);
        return flag;
    }).keyup(function(){
        $(this).val($(this).val().replace(/[^0-9]/g,""));
    });

    getSystemList();
    // 초기화
    doInit();

    $("#btn").on("click", function () {
        fn_Save();
    });

    getModlInf(_sys_cd);


    $("#dsply_yn").on("click", function () {
        //게시 선택 시
        if($(this).prop("checked")) {
            obj.singleDatePicker = false;
            changeTypeCalendar(obj);

            $("#dsply_yn").val("Y");
            $("#dsply_st_dttm").val("").attr('disabled', false);
            $("#dsply_ed_dttm").val("").attr('disabled', false);
            $("#endMaxDateBtn").on('click', maxDate);
        } else {
            $("#dsply_yn").val("N");
            $("#dsply_st_dttm").val("").attr('disabled', true);
            $("#dsply_ed_dttm").val("").attr('disabled', true);
            $("#endMaxDateBtn").off('click');
        }
    });

    $("#sys_info").on("change", function () {
        var sys_cd = $(this).val();
        getModlInf(sys_cd);
    });

    $("#modl_seq").on("change", function () {
        var modl_seq = $(this).val();
        getCtgInf(modl_seq);
    });

});

function maxDate() {
    $("#dsply_ed_dttm").val("").attr('disabled', true);
    $("#dsply_ed_dttm").val("9999-12-31 23:59");

    obj.singleDatePicker = true;

    changeTypeCalendar(obj);


}

function changeTypeCalendar(obj) {

    $("#dsply_st_dttm").daterangepicker(obj, function(start, end, separator) {
        if(obj.singleDatePicker === true) {
            $("#dsply_st_dttm").val(start);
        } else {
            $("#dsply_st_dttm").val(start);
            $("#dsply_ed_dttm").val(end);

        }
    });
}

//사이트 리스트 취득
function getSystemList() {
    var html = "";
    ajax({
        url     : "/pdsp/getPdsp1011ListSit",
        data    : {sys_cd : _sys_cd},
        success : function (data) {
            if (data.RESULT == "S") {
                var sitListCnt = data.rows.length;
                $(data.rows).each(function (index) {
                    // 조회 건수가 하나일 경우 사이트 하나
                    if(sitListCnt == 1) {
                        html += "<option  class='passOption' value="+ this.SYS_CD +" selected='selected' >"+ this.SYS_NM +"</option>"
                        getModlInf(this.SYS_CD);
                        return false;
                    } else {
                        html += "<option class='passOption' value="+ this.SYS_CD +">"+ this.SYS_NM +"</option>"
                        $("#sys_info").closest('div').show();
                    }
                });
                $("#sys_info").append(html);
            }
        }
    });
}

function getModlInf(sys_cd){
    // 게시판 모듈 목록 조회

    $("#modl_seq").empty();

    ajax({
        url:'/pbbs/selectTbbsModlInfCommonList',
        data    : {sys_cd : sys_cd},
        success:function(data) {

            if (data.RESULT == _boolean_success) {
                var boardModuleList = data.boardModuleList;

                if(boardModuleList.length > 0) {
                    for(var i = 0; i < boardModuleList.length; i++) {
                        $("#modl_seq").append(
                                "<option value='" + boardModuleList[i].MODL_SEQ
                                                  + "' modl_tp='" + boardModuleList[i].MODL_TP+ "'>"
                                                  + boardModuleList[i].MODL_NM
                                                  + "</option>"
                        );
                    }

                    getCtgInf($("#modl_seq").val());

                } else {
                    $("#modl_seq").append("<option value=''>없음</option>");
                    $("#ctegry_dtl_cd").empty();
                    $("#ctegry_dtl_cd").append("<option value=''>없음</option>");
                }

            }
        }


    });

    // 모듈순번 파라미터 존재 시 자동 선택
    if(_type != "") {
        $("#modl_seq").val(_type).prop("selected", true);
        $("#modl_seq option[value!="+_type+"]").remove();
    }
}

function getCtgInf(modl_seq){
    $("#ctegry_dtl_cd").empty();

    ajax({
        url:"/pbbs/getCtgInfo",
        data:{modl_seq : modl_seq},
        success:function(data){
            if (data.RESULT == _boolean_success) {


                var boardCtgInfoList = data.boardCtgInfo;

                if(boardCtgInfoList.length > 0) {
                    for(var i = 0; i < boardCtgInfoList.length; i++) {
                        $("#ctegry_dtl_cd").append(
                                "<option value='" + boardCtgInfoList[i].CTEGRY_DTL_CD
                                                  + "' ctegry_mst_cd='" + boardCtgInfoList[i].CTEGRY_MST_CD+ "'>"
                                                  + boardCtgInfoList[i].CTEGRY_DTL_NM
                                                  + "</option>"
                        );
                    }
                } else {
                    $("#ctegry_dtl_cd").append("<option value='' ctegry_mst_cd=''>없음</option>");
                }
            }
        }
    });
}
// 목록: 내부 로직 사용자 정의
function fn_List() {
    addTabInFrame("/pbbs/forward.pbbs1004", "CHG");
}
// 저장: 내부 로직 사용자 정의
function fn_Save() {
    if(validChk()) {
        submitFormWrite();
    }
}

//초기화
function doInit() {


    changeTypeCalendar(obj);

    $("#dsply_ed_dttm").on('click', function () {
        $("#dsply_st_dttm").trigger('click');
   });

    $("#dsply_st_dttm").val("").attr( 'disabled', true );
    $("#dsply_ed_dttm").val("").attr( 'disabled', true );

    // CKEDITOR 세팅
    board_editor = CKEDITOR;
    board_editor.replace('cts', {
        width : '100%',
        height : '325px',
        draggable : false,
        filebrowserImageUploadUrl : _context +'/board/updateImageUpload',
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

    // DATAPICKER 초기화(발행일)
    $("#pbl_date").datepicker({
        changeMonth : true,
        changeYear : true,
        dateFormat : 'yy-mm-dd',
    }).attr("readonly", true);

    // 등록폼 초기화
    var tgt_modl_tp = $("#modl_seq option:selected").attr("modl_tp");
    // BOARD TYPE1
    if("B_TYPE1" == tgt_modl_tp) {
        if($(".b_type2").css("display") == "table-cell") {
            resetValue();
            $(".b_type2").hide();
            $(".b_type1").show();
        }
    }
    // BOARD TYPE2
    else if("B_TYPE2" == tgt_modl_tp) {
        if($(".b_type1").css("display") == "table-cell") {
            resetValue();
            $(".b_type1").hide();
            $(".b_type2").show();
        }
    }

    // 최초 FOCUS
    $("#titl").focus();
}

// 입력값 유효성 체크
function validChk() {
    var retVal = true;
    // 1. 필수값 체크
    var titl = $("#titl").val();
    if(isEmpty(titl)) {
        alert("글제목을 입력해주세요.");
        $("#titl").focus();
        retVal = false;
        return retVal;
    }

    if($("#dsply_yn").prop("checked") && (isEmpty($("#dsply_st_dttm").val()) || isEmpty($("#dsply_ed_dttm").val()))) {

        alert("게시 날짜를 입력해주세요.");
        $("#dsply_st_dttm").focus();
        retVal = false;
        return retVal;
    }

    var modl_seq = $("#modl_seq").val();
    if(isEmpty(modl_seq)) {
        alert("게시판 종류를 선택해주세요.");
        $("#modl_seq").focus();
        retVal = false;
        return retVal;
    }

    var ctegry_dtl_cd = $("#ctegry_dtl_cd").val();
    if(isEmpty(ctegry_dtl_cd)) {
        alert("카테고리를 선택해주세요.");
        $("#ctegry_dtl_cd").focus();
        retVal = false;
        return retVal;
    }

    var cts = board_editor.instances['cts'].getData();
    if(isEmpty(cts)) {
        alert("글내용을 입력해주세요.");
        board_editor.on('instanceReady', function(event) {
            board_editor.instances.cts.focus();
        });
        board_editor.instances.cts.focus();
        retVal = false;
        return retVal;
    }

    // 2. Data Byte 체크
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
    if(!confirm("작성글을 저장하시겠습니까?")) return false;
    $("#frm_write").submit();
}

// 게시글 등록
function regDocInf(doc_seq, cts) {
    // 파라미터 셋팅
    var fileCheckBox = $("input:checkbox[name='fileChk']");
    var filePathBox = $("input[name='filePath']");
    var params = new Array();
    for(var i = 0; i < fileCheckBox.length; i++) {
        params.push(fileCheckBox[i].value);
    }

    // 추가 컬럼 정보(B_TYPE1)
    var exVals = new Array();
    var modl_tp = $("#modl_seq option:selected").attr("modl_tp");
    var ctg_seq = $("#ctg_seq option:selected").val();
    if("B_TYPE1" == modl_tp) {
        exVals.push($("#author").val());
        exVals.push($("#total_page_num").val());
        exVals.push($("#pbl_date").val());
        exVals.push($("#contents_table").val());
    }

    // 썸네일 이미지가 등록되었을 때
    var imgCheck = $('#img_files').val();
    if(imgCheck != null && imgCheck != "") {
        newFileFlag = true;
    }
    var ctegry_mst_cd = $("#ctegry_dtl_cd option:selected").attr("ctegry_mst_cd");
    var formData = new FormData($('#frm_write')[0]);
    formData.append("doc_seq", doc_seq);
    formData.append("modl_seq", $("#modl_seq option:selected").val());
    formData.append("notc_yn", $(":input:radio[name=notc_yn]:checked").val());
    formData.append("otp_stat", "PUBLIC");
    formData.append("titl", $("#titl").val());
    formData.append("cts",cts);
    formData.append("cmt_pms_stat", $('input[name="cmt_pms_stat"]:checked').val());
    formData.append("fl_seqs", params);
    formData.append("modl_tp", $("#modl_seq option:selected").attr("modl_tp"));
    formData.append("exVals", exVals);
    formData.append("ctg_seq", ctg_seq);
    formData.append("thumb_yn", "Y");
    formData.append("newFileFlag", newFileFlag);
    formData.append("chg_flag", "INSERT");
    formData.append("ctegry_dtl_cd",  $("#ctegry_dtl_cd option:selected").val());
    formData.append("ctegry_mst_cd",ctegry_mst_cd);
    formData.append("dsply_yn", $("#dsply_yn").val());
    formData.append("dsply_st_dttm", $("#dsply_st_dttm").val());
    formData.append("dsply_ed_dttm", $("#dsply_ed_dttm").val());


    // 게시글 등록
    $.ajax({
        url:_context + "/pbbs/savePbbs1008DocInf",
        type:'POST',
        data:formData,
        mimeType:"multipart/form-data",
        contentType:false,
        cache:false,
        processData:false,
        success:function(data) {
            var json = eval('('+data+')');
            if(_boolean_success == json.RESULT) {
                alert("게시글이 등록되었습니다.");
                // 통합게시글조회 화면 추가
                var url ="/pbbs/forward.pbbs1020.adm";
                if(_type != ""){
                    url ="/pbbs/forward.pbbs1020.adm?type="+_type;
                }

                parent.addTabInFrame(url, "CHG","");

                var panelId = parent.$("a[href=#"+ window.frameElement.id +"]").closest("li").remove().attr("aria-controls");
                parent.$("#"+panelId).remove();
                parent.tabs.tabs("refresh");
            }
        }
    });
}



// 등록 폼 설정
function regFormInit() {
    var tgt_modl_tp = $("#modl_seq option:selected").attr("modl_tp");
    // BOARD TYPE1
    if("B_TYPE1" == tgt_modl_tp) {
        if($(".b_type2").css("display") == "table-cell") {
            if(confirm("선택하신 게시판은 작성유형이 다른 게시판입니다.\n변경시 기존 입력값은 초기화 됩니다. 변경하시겠습니까?")) {
                resetValue();
                $(".b_type2").hide();
                $(".b_type1").show();
            }
        }
    }
    // BOARD TYPE2
    else if("B_TYPE2" == tgt_modl_tp) {
        if($(".b_type1").css("display") == "table-cell") {
            if(confirm("선택하신 게시판은 작성유형이 다른 게시판입니다.\n변경시 기존 입력값은 초기화 됩니다. 변경하시겠습니까?")) {
                resetValue();
                $(".b_type1").hide();
                $(".b_type2").show();
            }
        }
    }
}

// 입력값 초기화
function resetValue() {
    // TEXT BOX 초기화
    $('input[type="text"]').val("");
    // SELECT BOX 초기화
    $("#ctg_seq").val("880");
    // RADIO 초기화
    $('input[name="cmt_pms_stat"]').removeAttr('checked');
    $('input[name="notc_yn"]').removeAttr('checked');
    $('input[name="cmt_pms_stat"]:radio[value="ALLOW"]').prop('checked',true);
    $('input[name="notc_yn"]:radio[value="N"]').prop('checked',true);
    // EDITOR 초기화
    board_editor.instances['cts'].setData("");
}
</script>
</head>
<body>
    <div class="frameWrap">
        <div class="subCon">
        <%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
            <table class="tblType1">
                <colgroup>
                    <col style="width: 117px;">
                    <col style="width: ">
                    <col style="width: 110px">
                    <col style="width: 117px;">
                    <col style="width: 110px">
                    <col style="width: ">
                </colgroup>
                <tr>
                    <th><label for="titl" class="vv">시스템</label></th>
                    <td colspan="5"><span class="txt_pw"><select class="select w100" name="sys_info" id="sys_info"></select></span></td>
                </tr>
                <tr>
                    <th><label for="modl_seq" class="vv">게시판종류</label></th>
                    <td  colspan="2"><span class="txt_pw"><select class="select w100" name="modl_seq" id="modl_seq"></select></span></td>
                    <th><label for="modl_seq" class="vv">카테고리</label></th>
                    <td  colspan="2">
                       <span class="txt_pw">
                           <select class="select w100" name="ctegry_dtl_cd" id="ctegry_dtl_cd">
                               <option value="">없음</option>
                           </select>
                       </span>
                   </td>
                </tr>
                <tr>
                    <th><label for="titl" class="vv">제목</label></th>
                    <td colspan="5"><span class="txt_pw"><input type="text" name="titl" id="titl" class="w100" data-byte="250" title="제목"/></span></td>
                </tr>
                <tr>
                    <th><label for="notc_yn" class="vv">중요여부</label></th>
                    <td colspan="2">
                        <ul class="radioWrap typeOnline">
                            <li>
                                <input name="notc_yn" id="notic_n" type="radio" value="N" checked>
                                <label for="notic_n">일반글</label>
                            </li>
                            <li>
                                <input name="notc_yn" id="notic_y" type="radio" value="Y">
                                <label for="notic_y">중요글</label>
                            </li>
                            <li>
                                <input name="notc_yn" id="notic_p" type="radio" value="P">
                                <label for="notic_p">팝업글</label>
                            </li>
                        </ul>
                    </td>
                    <th><label for="dsply_yn" class="vv">게시여부</label></th>
                    <td>
                        <div class="tableCheck">
                            <label class="container typeInspect">게시
                                <input type="checkbox" name="dsply_yn" value='N' id="dsply_yn">
                                <span class="checkmark"></span>
                            </label>
                        </div>
                    </td>
                    <td style="border-left:0 none;">
                       <style>
                        .cals_div.type_two{position:relative; padding-right:81px;}
                        #endMaxDateBtn{position: absolute; right: 0; top: 0; height:23px; line-height: 23px; padding: 0 5px; border: 1px solid #757575;  background: #777777; color: #fff; font-size:12px; box-sizing:border-box;  cursor:pointer;}
                       </style>
                        <div class="cals_div type_two">
                            <span class="txt_pw"><input class="cals w45" type="text" value="" id="dsply_st_dttm" autocomplete="off" /></span>
                            <span class="space w10">~</span>
                            <span class="txt_pw"><input class="cals w45" type="text" value="" id="dsply_ed_dttm" autocomplete="off" /></span>
                        <input type="button" value="종료일 없음" id="endMaxDateBtn">
                        </div>

                    </td>
                </tr>
                <tr>
                <tr>
                    <td colspan="6" class="editorTd">
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
            <form name="frm_write" id="frm_write" enctype="multipart/form-data" method="post" onsubmit="return false;">
                <input id="img_files" type="file" style='visibility:hidden;' name="img_files" onchange="ChangeText(this, 'fileTxt');" accept=".jpg, .jpeg, .bmp, .gif, .png" />
            </form>

            <div class="bottomBtnWrap nonFloating">
                <button type="button" id="btn" class="btn_common btn_dark">저장</button>
            </div>
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
