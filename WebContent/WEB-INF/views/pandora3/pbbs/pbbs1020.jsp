<%--
   1. 파일명 : pbbs1020
   2. 파일설명: 공지게시글 조회
   3. 작성일 : 2020-01-30
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var menu_id = _menu_id;
var pbbs1020_grid;


var obj = {
    autoUpdateInput : false,
    showDropdowns: true,
    /* 날짜/일시 선택 start */
//     timePicker: true,
    locale: {
        format: 'YYYY-MM-DD'
    }
    /* 날짜/일시 선택 end */
};

$(document).ready(function() {
	var page;
	
    // 게시판유형 파라미터 존재 시 처리
    if(_type != "") {
        $("#modl_seq").val(_type).prop("selected", true);
        $("#modl_seq option[value!="+_type+"]").remove();
        var modl_tp = $("#modl_seq option:selected").attr("modl_tp");
        $("#modl_tp").val(modl_tp).prop("selected", true);
        $("#modl_tp option[value!="+modl_tp+"]").remove();
    }

    // 그리드 초기화
    var module_config = {
        // 그리드, 페이징 ID
        gridid:'pbbs1020_grid',
        pagerid:'pbbs1020_grid_pager',
        // 컬럼 정보
        columns:[{name:'MODL_SEQ', width:100, label:'게시판순번', hidden:true},
                 {name:'DOC_SEQ', width:100, label:'문서번호', hidden:true},
                 {name:'TMP_SEQ', width:100, label:'템플릿ID', hidden:true},
                 {name:'MAPPED_YN', width:100, label:'매핑여부', hidden:true},
                 {name:'MODL_TP', width:100, label:'게시판유형', hidden:true},
                 {name:'REF_1', width:100, label:'게시판URL', hidden:true},
//               {name:'STATUS', label:'상태', align:'center', editable:false, width:20},
                 {name:'CD_NM', width:100, label:'게시판유형명', sortable:false, hidden:true},
                 {name:'SYS_NM', width:50, label:'시스템', align:'center', sortable:false, editable:false},
                 {name:'MODL_NM', width:90, label:'게시판명', sortable:false},
                 {name:'CTEGRY_DTL_NM', width:90, label:'카테고리', sortable:false},
                 {name:'NOTC_YN', width:50, label:'중요여부', align:'center', sortable:false, editable:false, formatter:'select',edittype:'select', editoptions:{value:'Y:중요;N:일반;P:팝업'}},
                 {name:'TITL', width:280, label:'제목', sortable:false, cellattr:function(rowId, tv, rowObject, cm, rdata) {
                     if(isNotEmpty(rowObject.TITL)) {
                         return 'style="cursor: pointer; text-decoration: underline;"'
                     }
                 }},
                 {name:'INQ_CNT', width:40, label:'조회수', align:'right', editable:false, formatter:'number', formatoptions:{thousandsSeparator:",",decimalPlaces:0}, hidden:true},
                 {name:'DSPLY_STAT', width:50, label:'게시여부', align:'center', sortable:false},
                 {name:'LGN_ID', width:50, label:'작성자 사번', align:'center', sortable:false},
                 {name:'USR_NM', width:50, label:'작성자 성명', align:'center', sortable:false},
                 {name:'F_CRT_DTTM', width:80, label:'작성일', align:'center', editable:false}
                 ],
        editmode:true,          // 그리드 editable 여부
        gridtitle:'게시글 목록', // 그리드명
        multiselect:false,      // checkbox 여부
        formid:'search',        // 조회조건 form id
        shrinkToFit:true,       // width 고정여부
        autowidth:true,         // 컬럼 width 자동조정여부
        height:321,             // 그리드 높이
        cellEdit:false,
        selecturl:'/pbbs/getPbbs1004DocList', // 그리드 조회 URL
        saveurl:'/pbbs/savePbbs1004DocList',  // 그리드 삭제 URL
        events:{
            ondblClickRow: function(event, rowid, irow, icol) {
                var row = pbbs1020_grid.getRowData(rowid);
                if(pbbs1020_grid.getColName(icol) == 'TITL') {
                    var url = row.REF_1+"?page="+$("#pbbs1020_grid").jqGrid('getGridParam', 'page');
                    if(_type != "") {
                        url = row.REF_1+"?type="+_type;
                    }

                    var param3 = {
                    		sys_cd         : $("#sys_cd").val(),
                    		ctegry_dtl_cd   : $("#ctegry_dtl_cd").val(),
                            modl_tp         : $("#modl_tp").val(),
                            modl_seq        : $("#modl_seq").val(),
                            sch_type        : $("#sch_type").val(),
                            sch_type_txt    : $("#sch_type_txt").val(),
                            lgn_id          : $("#lgn_id").val(),
                            sch_st_dt       : $("#sch_st_dt").val(),
                            sch_ed_dt       : $("#sch_ed_dt").val(),
                            notc_yn         : $("#notc_yn").val(),
                            treatment_cd    : $("#treatment_cd").val(),
                            otp_stat          : $("#otp_stat").val(),
                            dsply_stat      : $("#dsply_stat").val(),
                            viewNm          : "pbbs1020"
                            
                    }


                    parent.addTab('sub'+menu_id, row.CD_NM+" 상세", url, row.MODL_SEQ, row.DOC_SEQ, encodeURIComponent(JSON.stringify(param3)));
                }
            }
        }
    };
    pbbs1020_grid = new UxGrid(module_config);
    pbbs1020_grid.init();
    pbbs1020_grid.setGridWidth($('.tblType1').width());
    
    // 조회조건 : 작성기간 날짜 초기화
    /* setDatepicker("#sch", "_st_dt", "_ed_dt"); */
    var today = new Date();
//     $("#sch_st_dt").val(formatDate(today));
    var addMonthDay = addMonth(today);
//     $("#sch_ed_dt").val(formatDate(addMonthDay));

    $("#sch_st_dt").daterangepicker(obj, function(start, end, separator) {

        $("#sch_st_dt").val(start);
        $("#sch_ed_dt").val(end);

    });

    $("#sch_ed_dt").on('click', function () {
         $("#sch_st_dt").trigger('click');
    });

  //사이트 리스트 취득
    getSystemList();
  
    $("#sys_cd").on("change", getPbbs1004ModlTpList);
    $("#modl_seq").on("change", getCtgInf);
   
    
 // 게시글정보 등록/수정 후의 목록 조회
    if(isNotEmpty(_param) && "CHG" == _param) {
    	var jObj = JSON.parse(_param3);
        page = jObj.page;
        
        //param3 가 있을때만
        if(isNotEmpty(jObj) ) {
			
        	
        	$("#sys_cd").val(jObj.sys_cd);
        	$("#sys_cd").trigger("change");
        	$("#modl_seq").val(jObj.modl_seq);
        	$("#modl_seq").trigger("change");
        	$("#ctegry_dtl_cd").val(jObj.ctegry_dtl_cd);
            $("#modl_tp").val(jObj.modl_tp).prop("selected", true);
//             $("#modl_seq").val(jObj.modl_seq).prop("selected", true);
            $("#sch_type").val(jObj.sch_type).prop("selected", true);
            $("#sch_type_txt").val(jObj.sch_type_txt);
            $("#lgn_id").val(jObj.lgn_id);
            $("#sch_st_dt").val(jObj.sch_st_dt);
            $("#sch_ed_dt").val(jObj.sch_ed_dt);
            $("#notc_yn").val(jObj.notc_yn).prop("selected", true);
            $("#treatment_cd").val(jObj.treatment_cd).prop("selected", true);
            $("#otp_stat").val(jObj.otp_stat).prop("selected", true);
            $("#dsply_stat").val(jObj.dsply_stat);
            $("#pbbs1020_grid").jqGrid('setGridParam', {'page': page});
        }
        pbbs1020_grid.retreive();
    }
 
});

function getPbbs1004ModlTpList() {
	
	$("#modl_seq").empty();
	$("#ctegry_dtl_cd").empty();
	
	var sys_cd = $(this).val();
	if(sys_cd == "") {
		$("#modl_seq").append("<option value=''>전체</option>");
		$("#ctegry_dtl_cd").append("<option value=''>전체</option>");
	} else {
		
	 // 조회조건 : 게시판명 콤보 생성
	    ajax({
	        url:'/pbbs/getPbbs1004ModlTpList.adm',
	        type:'POST',
	        data:{modl_tp:"B_TYPE2", sys_cd : sys_cd},
	        success:function(data) {
	            var boardList = data.boardList;
	            if(boardList.length > 0) {
		            for(var i = 0; i < boardList.length; i++) {
		                $("#modl_seq").append("<option value='" + boardList[i].MODL_SEQ + "'" + " modl_tp='" + boardList[i].MODL_TP + "'>" + boardList[i].MODL_NM + "</option>");
		            }
	            } else {
	            	$("#modl_seq").append("<option value=''> 없음 </option>");
	            }
	            getCtgInf();
	        }
	    });
	} 
}

function getCtgInf(){
	
	 var modl_seq = $("#modl_seq").val();
    
    $("#ctegry_dtl_cd").empty();
    $("#ctegry_dtl_cd").append("<option value='' ctegry_mst_cd=''>전체</option>");
    
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
                } 
            }
        }
    });
}


function getSystemList() {
    var html = "";
    ajax({
        url     : "/pdsp/getPdsp1011ListSit",
        data    : {sys_cd : _sys_cd},
        success : function (data) {
            if (data.RESULT == "S") {
                var sitListCnt = data.rows.length;
                $(data.rows).each(function (index) {
                    // 조회 건수가 하나일 경우 단일 하나의 시스템
                    if(sitListCnt == 1) {
                        html += "<option value="+ this.SYS_CD +" selected='selected' >"+ this.SYS_NM +"</option>"
                        return false;
                    } else {
                        html += "<option value="+ this.SYS_CD +">"+ this.SYS_NM +"</option>"
                        //$("#sys_info").closest('div').show();
                    }
                });
                //alert(html);
                $("#sys_cd").append(html);
            }
        }
    });
}

// 조회 : 내부 로직 사용자 정의
function fn_Search() {
    if(validChk()) {
    	if($("#pbbs1020_grid").jqGrid('getGridParam', 'page') > 1) $("#pbbs1020_grid").jqGrid('setGridParam', {'page':1});
        pbbs1020_grid.retreive();
    }
}
// 저장 : 내부 로직 사용자 정의
function fn_Save() {
    pbbs1020_grid.save();
}
// 삭제: 내부 로직 사용자 정의
function fn_DelRow() {
    pbbs1020_grid.remove();
}
// 엑셀다운로드 : 내부 로직 사용자 정의
function fn_ExcelDownload(){
    var grid_id = "pbbs1020_grid";
    var rows = $('#pbbs1020_grid').jqGrid('getGridParam', 'rowNum');
    var page = $('#pbbs1020_grid').jqGrid('getGridParam', 'page');
    var total = $('#pbbs1020_grid').jqGrid('getGridParam', 'total');
    var title = $('#pbbs1020_grid').jqGrid('getGridParam', 'gridtitle');
    var url = "/pbbs/getPbbs1004XlsxDwld.adm";  //페이징 존재
    var param ={};
    param.page=page;
    param.rows=rows;
    param.filename ="통합게시글 목록";
    AdvencedExcelDownload(grid_id,url,param);
}

// 게시판유형 변경 시 처리
function moduleSelect() {
    $("#modl_seq option").remove();
    $("#modl_seq").append("<option value=''>전체</option>");
    ajax({
        url:'/pbbs/getPbbs1004ModlTpList.adm',
        type:'POST',
        data:{modl_tp:"B_TYPE2"},
        success:function(data) {
            var boardList = data.boardList;
            for(var i = 0; i < boardList.length; i++) {
                $("#modl_seq").append("<option value='" + boardList[i].MODL_SEQ + "'" + " modl_tp='" + boardList[i].MODL_TP + "'>" + boardList[i].MODL_NM + "</option>");
            }
        },
    });
}

// 조회조건 : 입력값 유효성 체크
function validChk() {
    // 작성기간 유효성 체크
    var sch_st_dt = $("#sch_st_dt").val();
    var sch_ed_dt = $("#sch_ed_dt").val();
    if(isEmpty(sch_st_dt) ^ isEmpty(sch_st_dt)) {
        alert("작성기간을 입력하여 주세요");
        return false;
    }
    if(!validDateChk(sch_st_dt, sch_ed_dt)) return false;
    return true;
}

// 그리드 리사이징
$(window).resize(function() {
    pbbs1020_grid.setGridWidth($('.tblType1').width());
});

</script>
</head>
<body>
    <div class="frameWrap">
        <div class="subCon">
        <%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
            <div class="frameTopTable">
                <form name="search" id="search" onsubmit="return false">
                    <input type="hidden" value="B_TYPE2" name="modl_tp" id="modl_tp"/>
<!--                     <input type="hidden" name="page" id="page"/> -->
                    <table class="tblType1 typeCal">
                        <colgroup>
                            <col style="width: 117px;" />
                            <col style="" />
                            <col style="width: 117px;" />
                            <col style="" />
                            <col style="width: 117px;" />
                            <col style="" />
                        </colgroup>
                        <tr>
                            <th>시스템</th>
                            <td><span class="txt_pw"><select id="sys_cd" name="sys_cd" class="select" ><option value="">전체</option></select></span></td>
                            <th><label for="modl_seq">게시판명</label></th>
                            <td><span class="txt_pw"><select class="select w100" name="modl_seq" id="modl_seq" ><option value="">전체</option></select></span></td>
                            <th>카테고리</th>
                            <td><span class="txt_pw"><select id="ctegry_dtl_cd" name="ctegry_dtl_cd" class="select" ><option value="">전체</option></select></span></td>
                        </tr>
                        <tr>
                            <th>검색구분</th>
                            <td><span class="txt_pw"><select class="select w100" name="sch_type" id="sch_type"><option value="1">제목</option><option value="2">내용</option><option value="3">제목+내용</option></select></span></td>  
                            <th>검색내용</th>
                            <td><span class="txt_pw"><input type="text" name="sch_type_txt" id="sch_type_txt" class="w100"/></span></td>
                            <th>중요여부</th>
                            <td><span class="txt_pw"><select class="select w100" name="notc_yn" id="notc_yn"><option value="">전체</option><option value="Y">중요</option><option value="N">일반</option><option value="P">팝업</option></select></span></td>
                            
                        </tr>
                        <tr>
                            <th>작성자 사번/성명</th>
                            <td><span class="txt_pw"><input type="text" name="lgn_id" id="lgn_id" class="w100"/></span></td>
                            <th>작성기간</th>
                            <td class="typeCal">
                                <!-- <span class="txt_pw">
                                    <input type="text" id="sch_st_dt" name="sch_st_dt" class="w45"/>
                                    <span style="width:10%;display: inline-block;text-align: center;">~</span>
                                    <input type="text" id="sch_ed_dt" name="sch_ed_dt" class="w45"/>
                                </span> -->
                                <div class="cals_div">
                                    <span class="txt_pw ">
                                        <input type="text" id="sch_st_dt" name="sch_st_dt" class="cals w100">
                                    </span>
                                    <span class="w10 space">~</span>
                                    <span class="txt_pw ">
                                        <input type="text" id="sch_ed_dt" name="sch_ed_dt" class="cals w100" >
                                    </span>
                                </div>
                            </td>
                            <th>게시여부</th>
                            <td><span class="txt_pw"><select class="select w100" name="dsply_stat" id="dsply_stat"><option value="">전체</option><option value="임시저장">임시저장</option><option value="게시중">게시중</option><option value="게시종료">게시종료</option></select></span></td>
                            
                        </tr>
                    </table>
                </form>
            </div>
            <div class="bgBorder"></div>
            <table id="pbbs1020_grid"></table>
            <div id="pbbs1020_grid_pager"></div>
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>