<%--
   1. 파일명   : psys1047
   2. 파일설명 : 외부 사원 관리
   3. 작성일   : 2019-12-17
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var apvl_usr_grid;

var obj = {
    autoUpdateInput : false,
    showDropdowns: true,
    singleDatePicker: true,
    locale: {
        format: 'YYYY-MM-DD'
    }
};

// 한글 입력 방지
function fn_onKeyUp(e)
{
    $(e).keyup(function(){
        e.value = e.value.replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' );
    });
}

// 달력
function fn_datePicker(e)
{
    $(e).daterangepicker(obj, function(start, end, separator) {
        $(e).val(start);
    });
}

$(document).ready(function(){
    var grid_config = {
        gridid    : 'apvl_usr_grid',            // 그리드 id
        pagerid   : 'apvl_usr_grid_pager',      // 그리드 페이지 id
        gridBtnYn : 'Y',                    // 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        columns   : [
                      {name : 'MNGR_TP_CD', editable : false, hidden : true},
                      {name : 'MNGR_TP_NM', editable : false, hidden : true},
                      {name : 'ACTV_YN', editable : false, hidden : true},
                      {name : 'APPL_NO', editable : false, hidden : true},
                      {name : 'APPL_STAT_CD', editable : false, hidden : true},
                      {name : 'APPL_RSN_CONT', editable : false, hidden : true},
                      {name : 'SYS_CD', editable : false, hidden : true},
                      {name : 'SYS_NM', editable : false, hidden : true},
                      {name : 'USR_ID', editable : false, hidden : true},
                      {name : 'USR_MBL_NO_1', editable : false, hidden : true},
                      {name : 'USR_MBL_NO_2', editable : false, hidden : true},
                      {name : 'USR_MBL_NO_3', editable : false, hidden : true},
                      {name : 'HP_TEL_NO', editable : false, hidden : true},
                      {name : 'ETSN_TEL_NO',editable : false, hidden : true},
                      {name : 'FXL_TEL_NO', editable : false, hidden : true},
                      {name : 'ORG_CD', editable : false, hidden : true},
                      {name : 'GRDE_CD', editable : false, hidden : true},
                      {name : 'POS_CD', editable : false, hidden : true},
                      {name : 'JOB_CD', editable : false, hidden : true},
                      {name : 'CTF_YN', editable : false, hidden : true},
                      {name : 'CTF_KEY_CRT_DTTM', editable : false, hidden : true},
                      {name : 'F_CRT_DTTM', label : '신청일자', editable : false},
                      {name : 'CSTR_NM', label : '소속점', editable : false},
                      {name : 'LGN_ID', label : '아이디', editable : false},
                      {name : 'USR_NM', label : '사원명', editable : false},
                      {name : 'CO_NM', label : '소속회사', editable : false},
                      {name : 'POC_NM', label:'접점서비스'
                          ,formatter: function(cellValue,options,rowdata,action){
                        	  var value = "";
                        	  if(isNotEmpty(cellValue)) {
                        		  value = cellValue.replace(/[,]/gi, '<br />');
                        	  } else {
                        		  value = cellValue;
                        	  }
                                 return value;
                             }
                      },
                      {name : 'APVL_YN', label : '승인여부', editable : false, hidden : true},
                      {name : 'APVL_RFS_RSN_CONT', label : '신청 권한 거절 사유', editable : false, hidden : true},
                      {name : 'USR_STAT_CD', label : '승인여부', editable : true, edittype : 'select', formatter : 'select',
                          editoptions : {
                                          value:'1:승인;20:반려;3:미승인',
                                          dataEvents : [{
                                              type :'change',
                                              fn   : function(e) {
                                                     var rowId = $(this).closest("tr").attr("id");
                                                     if ($(this).val() == "20") {
                                                         $("#apvl_usr_grid").jqGrid('setColProp', 'APVL_RFS_RSN', { editable : true});
                                                         apvl_usr_grid.setRowData(rowId, {APPL_STAT_CD : '30'});
                                                     }else if($(this).val() == "1"){
                                                    	 $("#apvl_usr_grid").jqGrid('setColProp', 'APVL_RFS_RSN', { editable : false});
                                                         apvl_usr_grid.setRowData(rowId, {APVL_RFS_RSN : ''});
                                                         apvl_usr_grid.setRowData(rowId, {APVL_YN : 'Y'});
                                                         apvl_usr_grid.setRowData(rowId, {APPL_STAT_CD : '10'});
                                                     } else {
                                                         $("#apvl_usr_grid").jqGrid('setColProp', 'APVL_RFS_RSN', { editable : false});
                                                         apvl_usr_grid.setRowData(rowId, {APVL_RFS_RSN : ''});
                                                         apvl_usr_grid.setRowData(rowId, {APPL_STAT_CD : '20'});

                                                     }
                                               },
                                           }]
                          }

                      },
                      {name : 'ROL_ID', label : '권한ID', hidden : true},
                      {name : 'ROL_NM', label : '신청 권한명'},
                      {name : 'APVL_RFS_RSN', label : '승인거절사유', editable : false}
                     ],
        editmode    : true,                                     // 그리드 editable 여부
        gridtitle   : '권한 목록',                                  // 그리드명
        multiselect : true,                                     // checkbox 여부
        formid      : 'search',                                 // 조회조건 form id
        height      : 480,                                      // 그리드 높이
        shrinkToFit : true,                                     // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl   : '/psys/getPsys1047List.adm',              // 그리드 조회 URL
        saveurl     : '/psys/savePsys1047List.adm',             // 그리드 입력/수정/삭제 URL
        search      : true,
        events      : {
                        onCellSelect: function(event, rowid, icol) {        // 해당 셀 선택시
                            var row = apvl_usr_grid.getRowData(rowid);
                            //처리 여부가 N일때만 Select box 컨트롤
                            if(row.USR_STAT_CD === "20") {
                              $("#apvl_usr_grid").jqGrid('setColProp', 'APVL_RFS_RSN', { editable: true});
                            } else {
                              $("#apvl_usr_grid").jqGrid('setColProp', 'APVL_RFS_RSN', { editable: false});
                              apvl_usr_grid.setRowData(rowid, {APVL_RFS_RSN : ''});
                            }

                        },
                        gridComplete: function (event) {
                            var idArry = $("#apvl_usr_grid").jqGrid('getDataIDs'); //grid의 id 값을 배열로 가져옴

                             for(var i=0 ; i < idArry.length; i++){
                               var ret =  $("#apvl_usr_grid").getRowData(idArry[i]); // 해당 id의 row 데이터를 가져옴

                               if("N" != ret.APVL_YN){ //해당 row의 특정 컬럼 값이 N이 아니면 multiselect checkbox disabled 처리
                                  //해당 row의 checkbox disabled 처리 "jqg_list_" 이 부분은 grid에서 자동 생성
                                  $("#jqg_apvl_usr_grid_"+idArry[i]).attr("disabled", true);
                               }
                             }

                        },
        }
    };

    apvl_usr_grid = new UxGrid(grid_config);
    apvl_usr_grid.init();
    apvl_usr_grid.setGridWidth($('.tblType1').width());


    var obj = {

            autoUpdateInput : false,
            showDropdowns: true,
            linkedCalendars: false,
            /* 날짜/일시 선택 start */
            timePicker: false,
            timePicker24Hour: false,
            //viewModel : 'month',
            locale: {
                format: 'YYYY-MM-DD'
            }
    }

    $("#sch_appl_st_dt").daterangepicker(obj, function(start, end) {

        $("#sch_appl_st_dt").val(start);
        $("#sch_appl_ed_dt").val(end);

    });

    $("#sch_appl_ed_dt").on('click', function () {
        $("#sch_appl_st_dt").trigger('click');
   });

    $("#btn_all_app_save").on("click", function () {
        var rowIds = apvl_usr_grid.getSelectRowIDs();

        if(rowIds.length > 0) {
            for (var i = 0; i < rowIds.length; i++) {
            	apvl_usr_grid.setRowData(rowIds[i], {USR_STAT_CD : '1'});
            	apvl_usr_grid.setRowData(rowIds[i], {APVL_RFS_RSN : ''});
            	apvl_usr_grid.setRowData(rowIds[i], {APVL_YN : 'Y'});
            	apvl_usr_grid.setRowData(rowIds[i], {APPL_STAT_CD : '10'});
            }
        } else {
            alert("사용자를 선택해 주세요.");
            return false;
        }

    });

    $("#btn_all_gvbk_save").on("click", function () {
        var rowIds = apvl_usr_grid.getSelectRowIDs();


        if(rowIds.length > 0) {
            var inputString = prompt('반려사유를 입력해주세요.');
            if(inputString.trim().length > 2) {

                for (var i = 0; i < rowIds.length; i++) {
                	apvl_usr_grid.setRowData(rowIds[i], {USR_STAT_CD : '20'});
                	apvl_usr_grid.setRowData(rowIds[i], {APVL_RFS_RSN : inputString});
                	apvl_usr_grid.setRowData(rowIds[i], {APVL_RFS_RSN_CONT : inputString});
                	apvl_usr_grid.setRowData(rowIds[i], {APPL_STAT_CD : '30'});
                }
            } else {
                alert("반려 사유를 3글자 이상 입력해주세요.");
                return false;
            }
        } else {
            alert("사용자를 선택해 주세요.");
            return false;
        }

    });


    ajax({
    	url : "/psys/getSrvDptInfoList",
    	success : function (data) {
    		if (data.RESULT == "S") {
    			var _strCd = data.strCd;

    			$("#cstr_cd").empty();
                $("#cstr_cd").append("<option value=''>전체</option>");
                $.each(_strCd, function(idx, tmp){
                    $("#cstr_cd").append("<option value='" + tmp.MGM_STR_CD + "'>" + tmp.STR_NM + "</option>");
                });
    		}
    	}
    });

});

// grid resizing
$(window).resize(function() {
    apvl_usr_grid.setGridWidth($('.tblType1').width());
});

// 저장 전 유효성 체크

//조회: 내부 로직 사용자 정의
function fn_Search(){

    apvl_usr_grid.retreive();
}


//저장: 내부 로직 사용자 정의
function fn_Save(){
    $("#apvl_usr_grid").editCell(0, 0, false);

    var rowIds = apvl_usr_grid.getSelectRowIDs();

    for (var i = 0; i < rowIds.length; i++) {
        var row = apvl_usr_grid.getRowData(rowIds[i]);
        if (row.USR_STAT_CD === "3") {
            alert("신청 상태를 수정해주세요.");
            apvl_usr_grid.setCellFocus(rowIds[i], 6);
            return false;
        }
        if (row.USR_STAT_CD === "20") {
        	apvl_usr_grid.setCell(rowIds[i], 'JQGRIDCRUD', 'D');
            if(row.APVL_RFS_RSN.length < 1) {
                alert("반려 사유를 작성해주세요.");
                apvl_usr_grid.setCellFocus(rowIds[i], 7);
                return false;
            }
            apvl_usr_grid.setRowData(rowIds[i], {APVL_RFS_RSN_CONT : row.APVL_RFS_RSN});
        }
    }
    if(confirm("현장대리인을 통해 해당 외부직원의 근무여부를 확인하셨습니까?")) {
	    apvl_usr_grid.save();  // {success:function(){alert('save success');}}
    };

}

//삭제: 내부 로직 사용자 정의
function fn_DelRow(){
    apvl_usr_grid.remove(); // {success:function(){alert('remove success');}}
}


</script>
</head>
<body id="app">
    <div class="frameWrap">
        <div class="subCon">
            <%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
            <div class="frameTopTable">
                <form name="search" id="search" name="search" onsubmit="return false">
                    <table class="tblType1">
                        <colgroup>
                            <col style="width: 117px;" />
                            <col style="" />
                            <col style="width: 117px;" />
                            <col style="" />
                            <col style="width: 117px;" />
                            <col style="" />
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>회사명</th>
                                <td>
                                    <span class="txt_pw">
                                        <input type="text" name="blco_nm" id="blco_nm" class="text" value="" />
                                    </span>
                                </td>
                                <th>사원명</th>
                                <td>
                                    <span class="txt_pw">
                                        <input type="text" name="usr_nm" id="usr_nm" class="text" value="" />
                                    </span>
                                </td>
                                <th>신청일자</th>
                                <td class="typeCal">
                                   <div class="cals_div">
                                        <span class="txt_pw"><input class="cals w100" type="text" value="" name="sch_appl_st_dt" id="sch_appl_st_dt" autocomplete="off" /></span>
                                        <span class="w10 space">~</span>
                                        <span class="txt_pw"><input class="cals w100" type="text" value="" name="sch_appl_ed_dt" id="sch_appl_ed_dt" autocomplete="off" /></span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>소속점</th>
                                <td>
                                    <select name="cstr_cd" id="cstr_cd" class="select">
                                    </select>
                                </td>
                                <th>아이디</th>
                                <td>
                                    <span class="txt_pw">
                                        <input type="text" name="lgn_id" id="lgn_id" class="text" value="" />
                                    </span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
               </form>
            </div>
            <!-- search // -->
            <div class="bgBorder"></div>

            <div class="grid_right_btn">
                <div class="grid_right_btn_in">
                    <button id="btn_all_app_save" class="btn_common btn_default">일괄 승인 변경</button>
                    <button id="btn_all_gvbk_save" class="btn_common btn_default">일괄 반려 변경</button>
                </div>
            </div>

            <!-- Grid -->
            <table id="apvl_usr_grid"></table>
            <div id="apvl_usr_grid_pager"></div>
            <!-- Grid // -->
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
