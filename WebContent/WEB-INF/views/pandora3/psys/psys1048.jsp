<%-- 
   1. 파일명   : psys1034
   2. 파일설명 : 시스템 그룹별 권한 관리
   3. 작성일   : 2018-10-28
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var apvl_rol_grid;

$(document).ready(function(){
    var grid_config = {
        gridid    : 'apvl_rol_grid',            // 그리드 id
        pagerid   : 'apvl_rol_grid_pager',      // 그리드 페이지 id
        gridBtnYn : 'N',                    // 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        columns   : [
                      {name : 'APPL_NO', label : '신청번호', editable : false, hidden:true},
                      {name : 'ROL_ID', label : '권한 아이디', editable : false, hidden:true},
                      {name : 'SYS_CD', label : '사이트번호', editable : false, hidden:true},
                      {name : 'ORG_CD', label : '조직코드', editable : false, hidden:true},
                      {name : 'MSTR_CD', label : '모점코드', editable : false, hidden:true},
                      {name : 'MSTR_NM', label : '모점명', editable : false, hidden:true},
                      {name : 'CSTR_CD', label : '자점코드', editable : false, hidden:true},
                      {name : 'POS_CD', label : '직책코드', editable : false, hidden:true},
                      {name : 'ORG_NM', label : '조직명', editable : false, hidden:true},
                      {name : 'APVL_YN', label : '승인여부', editable : false, hidden:true},
                      {name : 'APPL_STAT_NM', label : '신청상태명', editable : false, hidden:true},
                      {name : 'APPL_STAT_CD', label : '신청상태', editable : true, edittype : 'select', formatter : 'select', 
                    	  editoptions : {
				                    	  value:'<%=CodeUtil.getGridComboList("APPL_STAT_CD")%>',
				                          dataEvents : [{
				                              type :'change',
				                              fn   : function(e) {
				                                     var rowId = $(this).closest("tr").attr("id");
				                                     apvl_rol_grid.setRowData(rowId, {APPL_STAT_NM : $(this).find("option:selected").text()});
				                                     if ($(this).val() === "30") {
				                                         $("#apvl_rol_grid").jqGrid('setColProp', 'APVL_RFS_RSN_CONT', { editable : true});
				                                           
				                                     } else {
				                                         $("#apvl_rol_grid").jqGrid('setColProp', 'APVL_RFS_RSN_CONT', { editable : false});
				                                         apvl_rol_grid.setRowData(rowId, {APVL_RFS_RSN_CONT : ''});
				                                         
				                                     }
				                               },
				                           }] 
                    	  }  
                      
                      },
                      {name : 'CSTR_NM', label : '점', editable : false},
                      {name : 'ORG_NM', label : '부서명', editable : false},
                      {name : 'USR_ID', label : '사번', editable : false},
                      {name : 'USR_NM', label : '성명', editable : false},
                      {name : 'SYS_NM', label : '시스템명', editable : false},
                      {name : 'POS_NM', label : '직책', editable : false},
                      {name : 'ROL_NMS', label : '현재권한', editable : false, formatter :fn_makeRolNm},
                      {name : 'ROL_NM', label : '신청권한', editable : false},
                      {name : 'APPL_RSN_CONT', label : '신청사유', editable : false},
                      {name : 'APVL_RFS_RSN_CONT', label : '승인거절사유', editable : false, hidden:true},
                      {name : 'APPL_DT', label : '신청일', editable : false},
                     ],
        editmode    : true,                                     // 그리드 editable 여부
        gridtitle   : 'VIP 권한 신청 목록',                                  // 그리드명
        multiselect : true,                                     // checkbox 여부
        formid      : 'search',                                 // 조회조건 form id
        height      : 480,                                      // 그리드 높이
        shrinkToFit : true,                                     // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl   : '/psys/getPsys1048List.adm',              // 그리드 조회 URL
        saveurl     : '/psys/savePsys1048List.adm',             // 그리드 입력/수정/삭제 URL
        search      : true,
        events      : {
			        	onCellSelect: function(event, rowid, icol) {        // 해당 셀 선택시
			                var row = apvl_rol_grid.getRowData(rowid);
			        	    //처리 여부가 N일때만 Select box 컨트롤 
			                if(row.APVL_YN === "N") {
			                	$("#apvl_rol_grid").jqGrid('setColProp', 'APPL_STAT_CD', { editable: true });
			                } else {
			                	$("#apvl_rol_grid").jqGrid('setColProp', 'APPL_STAT_CD', { editable: false });
			                }
			                if(row.APPL_STAT_CD === "30") {
			                  $("#apvl_rol_grid").jqGrid('setColProp', 'APVL_RFS_RSN_CONT', { editable: true});
			                } else {
			                  $("#apvl_rol_grid").jqGrid('setColProp', 'APVL_RFS_RSN_CONT', { editable: false});
			                  apvl_rol_grid.setRowData(rowid, {APVL_RFS_RSN_CONT : ''});
			                }
			                
			            },
			            gridComplete: function (event) {
			            	var idArry = $("#apvl_rol_grid").jqGrid('getDataIDs'); //grid의 id 값을 배열로 가져옴
	                           
			            	 for(var i=0 ; i < idArry.length; i++){
			            	   var ret =  $("#apvl_rol_grid").getRowData(idArry[i]); // 해당 id의 row 데이터를 가져옴

			            	   if("N" != ret.APVL_YN){ //해당 row의 특정 컬럼 값이 1이 아니면 multiselect checkbox disabled 처리
			            	      //해당 row의 checkbox disabled 처리 "jqg_list_" 이 부분은 grid에서 자동 생성
			            	      $("#jqg_apvl_rol_grid_"+idArry[i]).attr("disabled", true);
			            	   }
			            	 }  

			            },
        }
    };
    
    apvl_rol_grid = new UxGrid(grid_config);
    apvl_rol_grid.init();
    apvl_rol_grid.setGridWidth($('.tblType1').width());
    
    
    
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
    	var rowIds = apvl_rol_grid.getSelectRowIDs();
    	
    	if(rowIds.length > 0) {
    		for (var i = 0; i < rowIds.length; i++) {
    			apvl_rol_grid.setRowData(rowIds[i], {APPL_STAT_CD : '10'});
    			apvl_rol_grid.setRowData(rowIds[i], {APPL_STAT_NM : '승인'});
    			apvl_rol_grid.setRowData(rowIds[i], {APVL_RFS_RSN_CONT : ''});
    		}
    	} else {
    		alert("권한을 선택해 주세요.");
    		return false; 
    	}
    	
    });
    
    $("#btn_all_gvbk_save").on("click", function () {
    	
    	
        var rowIds = apvl_rol_grid.getSelectRowIDs();
        
        if(rowIds.length > 0) {
            
            bpopup({
                  url:"/psys/forward.psys1034p001.adm"
                , params    : {callback : "fn_gvbkBtn", target_id : _menu_id}
                , title     : "반려사유입력"
                , type      : "l"
                , id        : "psys1034p1"
            });
            
        } else {
            alert("권한을 선택해 주세요.");
            return false; 
        }
    	
    });
    
     
});

// grid resizing
$(window).resize(function() {
    apvl_rol_grid.setGridWidth($('.tblType1').width());
});

// 저장 전 유효성 체크

//조회: 내부 로직 사용자 정의
function fn_Search(){
    
    apvl_rol_grid.retreive();
}


//저장: 내부 로직 사용자 정의
function fn_Save(){
    $("#apvl_rol_grid").editCell(0, 0, false);
    
    var rowIds = apvl_rol_grid.getSelectRowIDs();
    
    for (var i = 0; i < rowIds.length; i++) {
        var row = apvl_rol_grid.getRowData(rowIds[i]);
        if (row.APPL_STAT_CD === "20") {
        	alert("신청 상태를 수정해주세요.");
        	apvl_rol_grid.setCellFocus(rowIds[i], 8);
        	return false;
        }
        if (row.APPL_STAT_CD === "30") {
        	if(row.APVL_RFS_RSN_CONT.length < 1) {
        		alert("반려 사유를 작성해주세요.");
        	    apvl_rol_grid.setCellFocus(rowIds[i], 9);
        	    return false;
        	}
        }
    }
    
    apvl_rol_grid.save();  // {success:function(){alert('save success');}}
}

//삭제: 내부 로직 사용자 정의
function fn_DelRow(){
    apvl_rol_grid.remove(); // {success:function(){alert('remove success');}}
}

function fn_makeRolNm(cellValue, option, row) {
    
    var html = "";
    if(isNotEmpty(cellValue)) {
        var rols = cellValue.split(",");
        for( var i=0; i< rols.length; i++ ) {
            html += "<div>" + rols[i] + "</div>"
        };
    }
    return html;
}

function fn_gvbkBtn(apvl_rfs_rsn_cont) {
    
    var rowIds = apvl_rol_grid.getSelectRowIDs();
    
     for (var i = 0; i < rowIds.length; i++) {
         var row = apvl_rol_grid.getRowData(rowIds[i]);
         
         //미승인된 것들에 대해서만
         if(row.APPL_STAT_CD == "20") {
             apvl_rol_grid.setRowData(rowIds[i], {APPL_STAT_CD : '30'});
             apvl_rol_grid.setRowData(rowIds[i], {APPL_STAT_NM : '반려'});
             apvl_rol_grid.setRowData(rowIds[i], {APVL_RFS_RSN_CONT : apvl_rfs_rsn_cont});
         }
     }
    
}

</script>
</head>
<body id="app">
    <div class="frameWrap">
        <div class="subCon">
            <%@ include file="/WEB-INF/views/pandora3/common/include/btnList2.jsp" %>
            <div class="frameTopTable">
                <form name="search" id="search" name="search" onsubmit="return false">
                    <table class="tblType1 typeCal">   
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
                                <th>점</th>
                                <td>
                                    <span class="txt_pw">
                                        <input type="text" name="cstr_nm" id="cstr_nm" class="text" value="" />
                                    </span>                         
                                </td>                
                                <th>부서명</th>
                                <td>
                                    <span class="txt_pw">
                                        <input type="text" name="org_nm" id="org_nm" class="text" value="" />
                                    </span>                         
                                </td> 
                                <th>사번/성명</th>
                                <td>
                                    <span class="txt_pw">
                                        <input type="text" name="usr_id" id="usr_id" class="text" value="" />
                                    </span>
                                </td>               
                            </tr>
                            <tr>
                                <th>신청일자</th>
                                <td class="typeCal">
                                   <div class="cals_div">
                                        <span class="txt_pw"><input class="cals w100" type="text" value="" name="sch_appl_st_dt" id="sch_appl_st_dt" autocomplete="off" /></span>
                                        <span class="w10 space">~</span>
                                        <span class="txt_pw"><input class="cals w100" type="text" value="" name="sch_appl_ed_dt" id="sch_appl_ed_dt" autocomplete="off" /></span>
                                    </div>
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
                    <button id="btn_all_app_save" class="btn_common btn_default">승인</button>
                    <button id="btn_all_gvbk_save" class="btn_common btn_default">반려</button>
                </div>
            </div>
            
            <!-- Grid -->
            <table id="apvl_rol_grid"></table> 
            <div id="apvl_rol_grid_pager"></div>
            <!-- Grid // -->    
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
