<%--
   1. 파일명 : pbbs1005
   2. 파일설명 : 공지게시글 상세
   3. 작성일 : 2018-04-10
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/bFileControl.js"></script>
<style>.b_type1{display:none;}</style>
<script type="text/javascript">
var page = '<%= parameterMap.getValue("page") %>';
var board_editor;
var newFileFlag = false;
var param3 = JSON.parse(_param3);
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
    // 게시판 정보 조회 : 일반게시판
    ajax({
        url:'/pdsp/getPdsp1009List1.adm',
        success:function(data) {
            var boardModuleList = data.boardModuleList;
            for(var i = 0; i < boardModuleList.length; i++) {
                if(_param == boardModuleList[i].MODL_SEQ) {
                    $("#modl_nm").text(boardModuleList[i].MODL_NM);
                    $("#modl_tp").val(boardModuleList[i].MODL_TP);
                    modFormInit(boardModuleList[i].MODL_TP);
                    break;
                }
            }
        }
    });

    // 수정 버튼 클릭 시
    $("#btn_mod1, #btn_mod2, #btn_mod4").click(function() {
        if(validChk()) {
            submitFormWrite();
        }
    });

    // 목록 버튼 클릭 시
    $("#btn_list1, #btn_list2, #btn_list4").click(function() {
    	var viewNm = param3.viewNm;
    	param3.page = page;
    	param3.doc_seq = _param2
    	var _param3 = JSON.stringify(param3);
        
        
        if(viewNm) {
            addTabInFrame("/pbbs/forward."+viewNm+".adm", "CHG", encodeURIComponent(_param3));
        } else {
            addTabInFrame("/pbbs/forward.pbbs1004.adm", "CHG", encodeURIComponent(_param3));
        }
        
        var panelId = parent.$("a[href=#"+ window.frameElement.id +"]").closest("li").remove().attr("aria-controls");
        parent.$("#"+panelId).remove();
        parent.tabs.tabs("refresh");
        
    });

    // 쓰기 서브밋
    $("#frm_write").submit(function(e) {
        // 게시글 수정
        var cts = board_editor.instances['cts'].getData();
        modDocInf(cts);
        e.preventDefault();
    });

    // 썸네일 삭제 버튼 클릭 시
    $("#btn_thumbImg_del").click(function() {
        $(".org_img").hide();
        $(".new_img").show();
        newFileFlag = true;
    });

    // 초기화
    doInit();
    getDtlList();
    
    $("#dsply_yn").on("click", function () {
        //게시 선택 시 
        if($(this).prop("checked")) {
            obj.singleDatePicker = false;
            
            $("#dsply_yn").val("Y");
            $("#dsply_st_dttm").val("").attr('disabled', false);
            $("#dsply_ed_dttm").val("").attr('disabled', false);
            $("#endMaxDateBtn").on('click', maxDate);
            changeTypeCalendar(obj);
        } else {
            $("#dsply_yn").val("N");
            $("#dsply_st_dttm").val("").attr('disabled', true);
            $("#dsply_ed_dttm").val("").attr('disabled', true);
            $("#endMaxDateBtn").off('click');
        }
    });
    
});

// 초기화
function doInit() {
    
    
    $("#dsply_ed_dttm").on('click', function () {
        $("#dsply_st_dttm").trigger('click');
    });
    
    $("#dsply_st_dttm").val("").attr( 'disabled', true );
    $("#dsply_ed_dttm").val("").attr( 'disabled', true );
    
    changeTypeCalendar(obj);
    
    // CKEDITOR 세팅
    board_editor = CKEDITOR;
    board_editor.replace('cts', {
        width:'100%',
        height:'325px',
        filebrowserImageUploadUrl:_context +'/board/updateImageUpload.adm'
    });
    board_editor.on('dialogDefinition', function(event) {
        event.data.definition.resizable = CKEDITOR.DIALOG_RESIZE_NONE;
        var dialogName = event.data.name;
        var dialogDefinition = event.data.definition;
        switch(dialogName) {
            case 'image':
                dialogDefinition.removeContents('Link');
                dialogDefinition.removeContents('advanced');
                var infoTab = dialogDefinition.getContents('info');
                infoTab.remove('txtHSpace');
                infoTab.remove('txtVSpace');
                infoTab.remove('txtBorder');
                infoTab.remove('cmbAlign');
                break;
        }
    });

    // 게시글 상세 조회


    // 면수 : 숫자만 입력 받도록
    $("#total_page_num").keydown(function(e) {
        return onlyNumber(e);
    });

    // 최초 FOCUS
    $("#titl").focus();
}

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
    
    var ctegry_dtl_nm = $("#ctegry_dtl_nm").val();
    if(isEmpty(ctegry_dtl_nm)) {
        alert("카테고리를 선택해주세요.");
        $("#ctegry_dtl_nm").focus();
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

    // 2. DATE Byte 체크
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

// 게시글 수정
function modDocInf(cts) {
    // 추가 컬럼 정보
    var exVals = new Array();
    var modl_tp = $("#modl_tp").val();
    var ctg_seq;
    if("B_TYPE1" == modl_tp) {
        exVals.push($("#author").val());
        exVals.push($("#total_page_num").val());
        exVals.push($("#pbl_date").val());
        exVals.push($("#contents_table").val());
        ctg_seq = $("#ctg_seq option:selected").val();
    }else {
        ctg_seq = 0;
    }

    var formData = new FormData($('#frm_img')[0]);

    formData.append("doc_seq", _param2);
    formData.append("modl_seq", _param);
    formData.append("notc_yn", $(":input:radio[name=notc_yn]:checked").val());
    formData.append("cmt_pms_stat", $(":input:radio[name=cmt_pms_stat]:checked").val());
    formData.append("titl", $("#titl").val());
    formData.append("cts", cts);
    formData.append("exVals", exVals);
    formData.append("modl_tp", $("#modl_tp").val());
    formData.append("ctg_seq", ctg_seq);
    formData.append("thumb_yn", "Y");
    formData.append("newFileFlag", newFileFlag);
    formData.append("dsply_yn", $("#dsply_yn").val());
    formData.append("dsply_st_dttm", $("#dsply_st_dttm").val());
    formData.append("dsply_ed_dttm", $("#dsply_ed_dttm").val());
    formData.append("ctegry_dtl_cd", $("#ctegry_dtl_nm").val());
    
    // 일반컨텐츠 : 게시글 수정
    $.ajax({
        url:_context + "/pbbs/updatePbbs1005DocInf",
        type:'POST',
        data:formData,
        mimeType:"multipart/form-data",
        contentType:false,
        cache:false,
        processData:false,
        success:function(data) {
            data = JSON.parse(data);
            
            if(data.RESULT == _boolean_success) {
                alert("게시글이 수정되었습니다.");
                
                /* var viewNm = JSON.parse(_param3).viewNm;
                
                if(viewNm) {
                    var url="/pbbs/forward."+viewNm+".adm";
                    if(_type != "") url="/pbbs/forward."+viewNm+".adm?type="+_type;
                    addTabInFrame(url, "CHG", encodeURIComponent(_param3));
                } else {
                    var url="/pbbs/forward.pbbs1004.adm";
                    if(_type != "") url="/pbbs/forward.pbbs1004.adm?type="+_type;
                    addTabInFrame(url, "CHG", encodeURIComponent(_param3));
                } */
                return;
            }
        }
    });
}

// 게시글 상세 조회
function getDocDtl() {
    // DATAPICKER 초기화
    $("#pbl_date").datepicker({
        changeMonth:true,
        changeYear:true,
        dateFormat:'yy-mm-dd',
    }).attr("readonly", true);

    // 일반컨텐츠 : 게시글 상세
    ajax({
        url:"/pbbs/getPbbs1005DocDtlList",
        data:{modl_seq: _param, doc_seq:_param2, modl_tp:$("#modl_tp").val()},
        success: function(data) {
            // 상세 정보 설정
            if(isNotEmpty(data.tbbsDocInfMap)) {
                var map = data.tbbsDocInfMap;
                var user_nm = map.user_nm;
                var lgn_id = map.lgn_id;
                var crt_dttm = $.timestampToString(new Date(map.crt_dttm));
                if(isEmpty(user_nm)) user_nm = "-";
                if(isEmpty(lgn_id)) lgn_id = "-";
                // TYPE1 단독
                $("#ctg_seq").val(map.ctg_seq);
                $("#author").val(map.author);
                $("#total_page_num").val(map.total_page_num);
                $("#pbl_date").val(map.pbl_date);
                $("#contents_table").val(map.contents_table);
                // TYPE1&TYPE2 공통
                $("#titl").val(map.titl);
                $("input[name='cmt_pms_stat']:radio[value='"+map.cmt_pms_stat+"']").attr("checked",true);
                $("input[name='notc_yn']:radio[value='"+map.notc_yn+"']").attr("checked",true);
                $("#lgn_id").text(lgn_id);
                $("#crt_dttm").text(crt_dttm.substring(0,4)+"-"+crt_dttm.substring(5,7)+"-"+crt_dttm.substring(8,10));
                board_editor.instances['cts'].setData(map.cts);
                // TYPE4 단독
                $("#org_img_name").attr("href", "javascript:fileDown("+ map.fl_seq +");");
                $("#org_img_name").text(map.ori_fl_nm);
                $("#sys_nm").text(map.sys_nm);
                $("#ctegry_dtl_nm").val(map.ctegry_dtl_cd);
                
                 if(map.dsply_yn == "Y") {
                    obj.singleDatePicker = false;
                    
                        
                    $("#dsply_yn").val("Y");
                    $("#dsply_yn").prop("checked", true);
                    $("#dsply_st_dttm").val(map.f_dsply_st_dttm).attr('disabled', false);
                    $("#dsply_ed_dttm").val(map.f_dsply_ed_dttm).attr('disabled', false);
                    $("#endMaxDateBtn").on('click', maxDate);
                    changeTypeCalendar(obj);
                 } else {
                    $("#dsply_yn").val("N");
                    $("#dsply_yn").prop("checked", false);
                    $("#dsply_st_dttm").val("").attr('disabled', true);
                    $("#dsply_ed_dttm").val("").attr('disabled', true);
                    $("#endMaxDateBtn").off('click');
                 }

                if(map.ori_fl_nm != null && map.ori_fl_nm != "") {
                    $(".new_img").hide();
                    $(".org_img").show();
                    newFileFlag = false;
                } else {
                    $(".new_img").show();
                    $(".org_img").hide();
                    newFileFlag = true;
                }
            }else {
                alert("해당하는 게시글이 존재하지 않습니다. 다시 조회해주세요.");
                return;
            }
            // 파일리스트
            var flList = data.tbbsFlInfMapList;
            if(flList.length > 0) {
                var flTotSize = 0;
                for(var i = 0; i < flList.length; i++) {
                    var flSeq = flList[i].FL_SEQ;
                    var srcFlNm = flList[i].ORI_FL_NM;
                    var flSize = parseInt(flList[i].FL_SIZE, 10);
                    var uplFlNm = flList[i].UPL_FL_NM;
                    var flExt = flList[i].FL_EXT;
                    var thumbYn = flList[i].THUMB_YN;

                    if(thumbYn == "Y") continue;

                    var fileDownload = "<a href='#' onclick='javascript:fileDown(" + flSeq + ");return false;' title='클릭하면 파일이 다운로드됩니다.'>" + srcFlNm + "</a>";
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
        }
    });
}

function getDtlList(){
    var dtlList = []
    ajax({
        url:"/pbbs/getCtgInfo",
        data:{modl_seq: _param},
        type:'POST',
        success:function(data) {
            
            if (data.RESULT == _boolean_success) {
                
                dtlList = data.boardCtgInfo;
                if(dtlList.length > 0) {
//                 	$("#ctegry_dtl_nm").append("<option value=''>없음</option>");
                    $.each(dtlList, function(idx, tmp){
                        $("#ctegry_dtl_nm").append("<option value='" + tmp.CTEGRY_DTL_CD + "'>" + tmp.CTEGRY_DTL_NM + "</option>");
                    });
                    
                } else {
                    $("#ctegry_dtl_nm").append("<option value=''>없음</option>");
                }
                getDocDtl();
            }
            
        }
    });
}

// 수정 폼 초기화
function modFormInit(modl_tp) {
    $(".b_type").show();
    // BOARD TYPE1
    if("B_TYPE1" == modl_tp) {
        $(".b_type1").show();
        $(".b_type2").hide();
        $(".b_type4").hide();
    }
    // BOARD TYPE2
    else if("B_TYPE2" == modl_tp) {
        $(".b_type1").hide();
        $(".b_type2").show();
        $(".b_type4").hide();
    }
    // BOARD TYPE4
    else if("B_TYPE4" == modl_tp) {
        $(".b_type1").hide();
        $(".b_type2").hide();
        $(".b_type4").show();
    }
}
</script>
</head>
<body>
    <div class="frameWrap">
        <div class="subCon">
        <h1><%=_title %></h1>
            <table class="tblType1">
                <colgroup>
                    <col width="15%" />
                    <col width="35%" />
                    <col width="15%" />
                    <col width="35%" />
                </colgroup>
                <tr>
                    <th>게시판명</th>
                    <td id="modl_nm"></td>
                    <th class="b_type1" style="display:none;"><label for="ctg_seq" class="vv">분류</label></th>
                    <td class="b_type1" style="display:none;">
                        <span class="txt_pw">
                            <select class="select w20" name="ctg_seq" id="ctg_seq">
                                <option value="880">기본</option>
                                <option value="881">수탁</option>
                                <option value="882">성과</option>
                            </select>
                        </span>
                        <div class="grid_btn">
                            <button type="button" class="btn_common btn_default" id="btn_list1">목록</button>
                            <button type="button" class="btn_common btn_default" id="btn_mod1">수정</button>
                        </div>
                    </td>
                    <td class="b_type2" colspan="2" style="display:none;">
                        <div class="grid_btn">
                            <button type="button" class="btn_common btn_default" id="btn_list2">목록</button>
                            <button type="button" class="btn_common btn_default" id="btn_mod2">수정</button>
                        </div>
                    </td>
                    <td class="b_type4" colspan="2">
                        <div class="grid_btn">
                            <button type="button" class="btn_common btn_default" id="btn_list4">목록</button>
                            <button type="button" class="btn_common btn_default" id="btn_mod4">수정</button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td><span id="lgn_id"></span></td>
                    <th>작성일</th>
                    <td><span id="crt_dttm"></span></td>
                </tr>
                <tr>
                    <th><label for="titl" class="vv">제목</label></th>
                    <td><span class="txt_pw"><input type="text" name="titl" id="titl" class="w100" data-byte="250" title="제목"/></span></td>
                    <th>시스템 명</th>
                    <td><span id="sys_nm"></span></td>
                </tr>
                <tr>
                    <th><label for="notc_yn" class="vv">중요여부</label></th>
                    <td>
                        <div class="radio">
                            <span><input name="notc_yn" id="notc_n" type="radio" value="N"><label for="noti_n">일반글</label></span>
                            <span><input name="notc_yn" id="notc_y" type="radio" value="Y"><label for="noti_y">중요글</label></span>
                            <span><input name="notc_yn" id="notc_p" type="radio" value="P"><label for="noti_p">팝업글</label></span>
                        </div>
                    </td>
                    <th><label for="cmt_pms_stat" class="vv">카테고리 정보</label></th>
                    <td>
                        <span class="txt_pw">
                            <select class="select w20" name="ctegry_dtl_nm" id="ctegry_dtl_nm">
                            </select>
                        </span>
                    </td>
                </tr>
                <tr>
                    <th><label for="dsply_yn" class="vv">게시여부</label></th>
                    <td>
                       <style>
                        .cals_div.type_two{position:relative; padding: 0 81px 0 60px;}
                        .cals_div.type_two .tableCheck{position:absolute; left:0; top:0; } 
                        #endMaxDateBtn{position: absolute; right: 0; top: 0; height:23px; line-height: 23px; padding: 0 5px; border: 1px solid #757575;  background: #777777; color: #fff; font-size:12px; box-sizing:border-box;  cursor:pointer;}
                       </style>
                        <div class="cals_div type_two">
	                        <div class="tableCheck">
	                            <label class="container typeInspect">게시
	                                <input type="checkbox" name="dsply_yn" value='N' id="dsply_yn">
	                                <span class="checkmark"></span>
	                            </label>
	                        </div>
                            <span class="txt_pw"><input class="cals w45" type="text" value="" id="dsply_st_dttm" autocomplete="off" /></span>
                            <span class="space w10">~</span>
                            <span class="txt_pw"><input class="cals w45" type="text" value="" id="dsply_ed_dttm" autocomplete="off" /></span>
                            <input type="button" value="종료일 없음" id="endMaxDateBtn">
                        </div>
                    </td>
                </tr>
                <tr class="b_type1" style="display:none;">
                    <th><label for="author" class="vv">저자</label></th>
                    <td colspan="3"><span class="txt_pw"><input type="text" name="author" id="author" class="w100" placeholder="*연구보고서의 저자를 입력하세요."/></span></td>
                </tr>
                <tr class="b_type1" style="display:none;">
                    <th><label for="total_page_num" class="vv">면수</label></th>
                    <td><span class="txt_pw"><input type="text" name="total_page_num" id="total_page_num" class="w100" placeholder="*총 페이지 숫자를 입력해주세요."/></span></td>
                    <th><label for="pbl_date" class="vv">발행일</label></th>
                    <td><span class="txt_pw"><input type="text" name="pbl_date" id="pbl_date" class="w100" placeholder="*발행일을 입력해주세요. (yyyy-mm-dd)"/></span></td>
                </tr>
                <tr class="b_type1" style="display:none;">
                    <th><label for="contents_table" class="vv">목차</label></th>
                    <td colspan="3"><textarea id="contents_table" name="contents_table" class="textarea w100 h80" placeholder="*목차를 입력해주세요."></textarea></td>
                </tr>
                <tr>
                    <td colspan="4" class="editorTd">
                        <form name="frm_write" id="frm_write" enctype="multipart/form-data" method="post" onsubmit="return false;">
                            <div class="editor"><textarea name="cts" id="cts"></textarea></div>
                        </form>
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
            <input type="hidden" name="modl_tp" id="modl_tp"/>
            <form name="frm_file" id="frm_file" enctype="multipart/form-data" method="post" onsubmit="return false;">
                <div id="fileContainer" style="display:none;">
                    <input type="file" id="files" name="files" multiple="multiple" />
                </div>
            </form>
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
