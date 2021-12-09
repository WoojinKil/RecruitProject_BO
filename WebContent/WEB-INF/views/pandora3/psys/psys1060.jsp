<%--
   1. 파일명   : psys1060
   2. 파일설명 : 외부 사원 권한관리
   3. 작성일   : 2019-12-17
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var extn_usr_grid;
var poc_list;

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
        gridid    : 'extn_usr_grid',            // 그리드 id
        pagerid   : 'extn_usr_grid_pager',      // 그리드 페이지 id
        gridBtnYn : 'Y',                    // 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        columns   : [
                      {name : 'LGN_ID', label : '아이디', editable : false},
                      {name : 'USR_ID', editable : false, hidden : true},
                      {name : 'CSTR_CD', label : 'CSTR_CD', editable : false, hidden : true},
                      {name : 'POC_CD', label : 'POC_CD', editable : false, hidden : true},
                      {name : 'USR_NM', label : '사원명', editable : false},
                      {name : 'CSTR_NM', label : '소속점', editable : false},
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
                      {name : "POC_CD", label : "접점서비스" , editable : false, formatter: fn_makePocCheckbox, unformat : fn_makePocUnCheckbox }
                      ],
        editmode    : true,                                     // 그리드 editable 여부
        gridtitle   : '접접서비스관리',                                  // 그리드명
        multiselect : true,                                     // checkbox 여부
        formid      : 'search',                                 // 조회조건 form id
        height      : 480,                                      // 그리드 높이
        shrinkToFit : true,                                     // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl   : '/psys/getPsys1060List.adm',              // 그리드 조회 URL
        saveurl     : '/psys/savePsys1060List.adm',             // 그리드 입력/수정/삭제 URL
        search      : true,
        events      : {
                        onCellSelect: function(event, rowid, icol) {        // 해당 셀 선택시
                        },
                        gridComplete: function (event) {

                        }
        }
    };

    extn_usr_grid = new UxGrid(grid_config);
    extn_usr_grid.init();
    extn_usr_grid.setGridWidth($('.tblType1').width());


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

    ajax({
        url     : "/psys/selectPocCdInfoList",
        data : {sys_cd :0},
        success : function (data) {
            if (data.RESULT == "S") {
            	poc_list = data.POC_LIST;
            }
        }
    });
    ajax({
    	url : "/psys/selectCoList",
    	success : function (data) {
    		if (data.RESULT == "S") {
    			var coList = data.CO_LIST;
    			$("#blco_cd").empty();
                $("#blco_cd").append("<option value=''>전체</option>");
                $.each(coList, function(idx, tmp){
                    $("#blco_cd").append("<option value='" + tmp.COMN_CD + "'>" + tmp.COMN_CD_NM + "</option>");
                });
    		}
    	}
    });



});

function fn_makePocCheckbox(cellValue, options, row) {
    var selectHtml="";
    for(var i=0; i < poc_list.length; i++){
        if(poc_list[i].MGM_STR_CD==row.CSTR_CD){
            selectHtml += "<div class='tableCheck'><label class='container' for='checkbox" + row.LGN_ID + i +"'>"
            selectHtml += "<input role='checkbox' type='checkbox' onclick='fn_check(this)' id='checkbox"+ row.LGN_ID + i + "'  value='" + poc_list[i].SVC_POC_CD + "'";

            if(isNotEmpty(row.POC_CD) && row.POC_CD.indexOf(poc_list[i].SVC_POC_CD)>=0){
                selectHtml +="checked";
            }
            selectHtml +="/><span  class='checkmark'></span>"+ poc_list[i].SVC_POC_NM +"</label></div>";
        }
    }
    return selectHtml;
}

function fn_makePocUnCheckbox( cellvalue, options, cell) {

	var checkboxValue = "";
	var temp = [];

	$($(cell).find("input[type='checkbox']:checked")).each(function (i,t) {
		temp.push($(this).val());
	});

	checkboxValue = temp.join(",");

	return checkboxValue;

}


// grid resizing
$(window).resize(function() {
	extn_usr_grid.setGridWidth($('.tblType1').width());
});

// 저장 전 유효성 체크

//조회: 내부 로직 사용자 정의
function fn_Search(){
	extn_usr_grid.retreive();
}

//현재 신청할 권한에 대한 검색
function fn_check (target) {
    var rowId = $(target).closest("tr").attr("id");
    var targetRow = extn_usr_grid.getRowData(rowId);


    var chk = $("input:checkbox[id='jqg_extn_usr_grid_"+ rowId +"']").is(":checked");
    console.log(chk);
    if(chk != true) {
        $("#extn_usr_grid").jqGrid('setSelection', rowId, true);
    }

}


//저장: 내부 로직 사용자 정의
function fn_Save(){
    $("#extn_usr_grid").editCell(0, 0, false);

    extn_usr_grid.save();  // {success:function(){alert('save success');}}

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
                                <th>아이디</th>
                                <td>
                                    <span class="txt_pw">
                                        <input type="text" name="lgn_id" id="lgn_id" class="text" value="" />
                                    </span>
                                </td>
                                <th>사원명</th>
                                <td>
                                    <span class="txt_pw">
                                        <input type="text" name="usr_nm" id="usr_nm" class="text" value="" />
                                    </span>
                                </td>
                                <th>가입일자</th>
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
                                <th>회사명</th>
                                <td>
                                    <span class="txt_pw">
                                    	<select name="blco_cd" id="blco_cd" class="select">
                                    	</select>
                                    </span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
               </form>
            </div>
            <!-- search // -->
            <div class="bgBorder"></div>
            <!-- Grid -->
            <table id="extn_usr_grid"></table>
            <div id="extn_usr_grid_pager"></div>
            <!-- Grid // -->
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
