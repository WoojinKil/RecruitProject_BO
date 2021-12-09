<%-- 
   1. 파일명   : psys1039
   2. 파일설명 : 사용자 개별 권한 신청
   3. 작성일   : 2018-11
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var rol_grid;

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
        gridid    : 'rol_grid',            // 그리드 id
        pagerid   : 'rol_grid_pager',      // 그리드 페이지 id
        gridBtnYn : 'Y',                    // 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        columns   : [
                        {name : 'STATUS', label:'상태', align:'center', editable:false, width:20, hidden:true}
                      , {name : 'SYS_CD', label : '시스템 번호', editable : false, hidden:true}
                      , {name : 'ORG_CD', label : '조직ID', editable : false, hidden:true}
                      , {name : 'ORG_NM', label : '조직명', editable : false, hidden:true}
                      , {name : 'CSTR_CD', label : '점코드', editable : false, hidden:true}
                      , {name : 'CSTR_NM', label : '점명', editable : false, hidden:true}
                      , {name : 'USR_ID', label : '사원 번호', align:'center', editable : false, hidden:true}
                      , {name : 'APP_ROL_ID', label : '신청한 권한', editable : false, hidden:true}
                      , {name : 'USR_NM', label : '사원 명', align:'center', editable : false, hidden:true}
                      , {name : 'SYS_NM', label : '시스템', align:'center', editable : false}
                      , {name : 'ROL_ID', label : '현재권한ID', editable : false, hidden:true}
                      , {name : 'ROL_NM', label : '현재권한', editable : false, formatter : fn_makeRolNm}
                      , {name : 'F_APVL_DTTM', label : '권한일자', align:'center', editable : false}
                      , {name : 'APP_ROL_NM', label : '신청권한명', align:'center', editable : false, hidden:true}
                      , {name : 'ROL_IDS', label : '신청 권한', editable : false, formatter : fn_makeRolSelectbox, unformat : fn_makeRolUnSelectbox}
                      , {name : 'APPL_RSN_CONT', label : '신청 사유', editable : true, align : 'left'}
                      , {name : 'APP_DTTM', label : '신청일자', align:'center', editable : false}
                      
                     ],
        initval     : {US_YN:'Y', APL_ED_DT:'9999-12-31'},      // 컬럼 add 시 초기값
        editmode    : true,                                     // 그리드 editable 여부
        gridtitle   : '권한 목록',                                  // 그리드명
        multiselect : true,                                     // checkbox 여부
        height      : 480,                                      // 그리드 높이
        shrinkToFit : true,                                     // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl   : '/psys/getPsys1039List.adm',              // 그리드 조회 URL
        saveurl     : '/psys/savePsys1039List.adm',             // 그리드 입력/수정/삭제 URL
        search      : true,
        events      : {
        	
        	
        }
    };
    
    rol_grid = new UxGrid(grid_config);
    rol_grid.init();
    rol_grid.setGridWidth($('.tblType1').width());
    $("#rol_grid").jqGrid("setLabel", "rn", "NO");
    $("#cb_rol_grid").attr("disabled",true).hide();
    $("#jqgh_rol_grid_cb").hide();
     
    fn_getUserInfo();
    
});

// grid resizing
$(window).resize(function() {
    rol_grid.setGridWidth($('.tblType1').width());
});

// 저장 전 유효성 체크

//조회: 내부 로직 사용자 정의
function fn_Search(){
    
    rol_grid.retreive();
}


//저장: 내부 로직 사용자 정의
function fn_Save(){
    
    $("#rol_grid").editCell(0, 0, false);
    
    var rowIds = rol_grid.getSelectRowIDs();
    
    for(var i = 0 ; i<rowIds.length; i++) {
    	
    	var row = rol_grid.getRowData(rowIds[i]);
    	
    	if(isEmpty(row.ROL_IDS)) {
    		
    		alert("신청할 권한을 선택해주세요.");
    		rol_grid.setCellFocus(rowIds[i], 5);
    		
    		return false;
    	}
    	
    	if(isEmpty(row.APPL_RSN_CONT)) {
    		alert("신청사유를 입력해주세요.");
    		rol_grid.setCellFocus(rowIds[i], 6);
    		return false;
    	}
    } 
    
    
     rol_grid.save();  // {success:function(){alert('save success');}}
}

//삭제: 내부 로직 사용자 정의
function fn_DelRow(){
    rol_grid.remove(); // {success:function(){alert('remove success');}}
}

//엑셀다운로드: 내부 로직 사용자 정의
function fn_ExcelDownload(){
    var grid_id = "rol_grid";
    var rows    = $('#rol_grid').jqGrid('getGridParam', 'rowNum');
    var page    = $('#rol_grid').jqGrid('getGridParam', 'page');
    var total   = $('#rol_grid').jqGrid('getGridParam', 'total');
    var title   = $('#rol_grid').jqGrid('getGridParam', 'gridtitle');
    var url     = "/psys/getPsys1037XlsxDwld";  //페이징 존재
    var param          = {};
        param.page     = page;
        param.rows     = rows;
        param.filename = "시스템 그룹 권한 목록";
    AdvencedExcelDownload(grid_id, url, param);
}

function fn_makeRolSelectbox(cellValue, option, row) {
	
	var selectHtml = "<select class='w100' onchange='fn_dupCheck(this)'>";
	
	selectHtml += "<option value=''>선택안함</option>"
	if(isNotEmpty(cellValue)) {
		var rols = cellValue.replace(/&#40;/gi, "(").replace(/&#41;/gi, ")").split(";");
		for( var i=0; i< rols.length; i++ ) {
			var selectBoxElement = rols[i].split(":");
			selectHtml += "<option value='" + selectBoxElement[0] +"' >"+selectBoxElement[1]+"</option>"
		};
	}
	
	
	selectHtml +="</select>"
	
	return selectHtml;
}

function fn_makeRolNm(cellValue, option, row) {
	
	var html = "";
	if(isNotEmpty(cellValue)) {
        var rols = cellValue.split(",");
        for( var i=0; i< rols.length; i++ ) {
            html += "<div style='padding:3px 0;'>" + rols[i] + "</div>"
        };
    }
	return html;
}

function fn_makeRolUnSelectbox( cellvalue, options, cell) {
	return $("select",cell).find("option:selected").val();
	
}

//현재 신청할 권한에 대한 검색
function fn_dupCheck (target) {
	
	      
	var findStr = $(target).find("option:selected").val() + ":" + $(target).find("option:selected").text();
	var rowId = $(target).closest("tr").attr("id");
	var targetRow = rol_grid.getRowData(rowId);
	
	
    rol_grid.setRowData(rowId, {APP_DTTM : ""});
    rol_grid.setRowData(rowId, {APPL_RSN_CONT : ""});
	
	if(isNotEmpty(findStr)) {
		
		if(targetRow.ROL_ID.indexOf(findStr) > -1) {
			alert("이미 갖고 있는 권한입니다.");
			$(target).find("option:eq(0)").prop("selected", true);
			
            var chk = $("input:checkbox[id='jqg_rol_grid_"+ rowId +"']").is(":checked");
            if(chk == true) {
                $("#rol_grid").jqGrid('setSelection', rowId, true);
            }
            
			return false;
		} else if (targetRow.APP_ROL_ID.indexOf(findStr) > -1) {
			alert("신청 중인 권한입니다.");
			var str = targetRow.APP_ROL_ID;
			var targetRolInfo = str.substring(str.indexOf(findStr), str.indexOf(";", str.indexOf(findStr)));
			if(isNotEmpty(targetRolInfo)) {
				var rolInfoArray = targetRolInfo.split(":"); <%-- 0:권한 ID, 1:권한 명 ,2:신청일 3:신청사유 --%> 
				
				rol_grid.setRowData(rowId, {APP_DTTM : rolInfoArray[2]});
				rol_grid.setRowData(rowId, {APPL_RSN_CONT : rolInfoArray[3]});
			}
            $("#jqg_rol_grid_"+rowId).attr("disabled", true);
            $("#rol_grid").jqGrid('setSelection', rowId, false);
            $("#rol_grid").jqGrid('setColProp', 'APPL_RSN_CONT', { editable : false});
            
            var chk = $("input:checkbox[id='jqg_rol_grid_"+ rowId +"']").is(":checked");
            if(chk == true) {
            	$("#rol_grid").jqGrid('setSelection', rowId, true);
            }
            
	        return false;
		} else {
		    rol_grid.setRowData(rowId, {APP_ROL_NM : $(target).find("option:selected").text()});
		    var chk = $("input:checkbox[id='jqg_rol_grid_"+ rowId +"']").is(":checked");
		    if(chk != true) {
		        $("#rol_grid").jqGrid('setSelection', rowId, true);
		    }
		    $("#rol_grid").jqGrid('setColProp', 'APPL_RSN_CONT', { editable : true});
			$("#jqg_rol_grid_"+rowId).attr("disabled", false);
		}
		
	}
	
}

function fn_getUserInfo() {
	
	var html = "";
	$("#usr_id").append(('<%=userInfo.getUser_id() %>'));
	
	$("#usr_nm").append('<%=userInfo.getUser_nm() %>'+' / '+'<%=userInfo.getHr_emp_pos_nm() %>');
	$("#org_nm").append('<%=userInfo.getHr_org_nm() %>');
	
	
	var cstr_cd = '<%=userInfo.getCstr_cd()%>'; //자점 코드|
//  String blstr_cd = parameterMap.getUserInfo().getBlstr_cd(); // 소속점 코드
    var shop_grde_cd = '<%=userInfo.getShop_grde_cd()%>';// 매입 등급 코드
    var grp_rol_id =  '<%=userInfo.getGrp_rol_id()%>';// 권한 등급 코드
	var rgn_ldr_yn = '<%=userInfo.getRgn_ldr_yn() %>';
	
	if("Y" == rgn_ldr_yn) { // 지역장일 경우
		cstr_nm = '<%=userInfo.getBsle_hdofic_nm() %>'; // 지역명이 들어갈 예쩡
    } else if ("0000" == cstr_cd || isEmpty(cstr_cd) ) { // 본사일 경우 전사
        
    } else {// 점일 경우  
        if(isNotEmpty(shop_grde_cd) && (shop_grde_cd.indexOf("L") > -1 || "9" == grp_rol_id)) {
        	cstr_nm = '<%=userInfo.getBsle_hdofic_nm() %>';
        } else {
        	cstr_nm = '<%=userInfo.getCstr_nm()%>'; 
        }
        
    }
	
	$("#cstr_nm").append(cstr_nm);
	
	var grp_rol_nms = '<%=userInfo.getGrp_rol_nm() %>';
	
	if(isEmpty(grp_rol_nms)) {
		html = "<div>-</div>";
		
	} else {
		
		grp_rol_nms.split(",").filter(function(item, pos, self) {
			   return self.indexOf(item) == pos;
		}).forEach(function (item, index) {
			html += "<div>" + item + "</div>";
		});
		
	}
	
	$("#grp_rol_nm").append(html);
	
// 	ajax({
		
// 	});
}



</script>
</head>
<body id="app">
    <div class="frameWrap">
        <div class="subCon">
            <%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
            <div class="frameTopTable">
                <form name="search" id="search" onsubmit="return false">
                    <table class="tblType1 typeNoInput">
                        <colgroup>
                            <col style="width: 117px;" />
                            <col style="" />
                            <col style="width: 117px;" />
                            <col style="" />
                            <col style="width: 117px;" />
                            <col style="" />
                        </colgroup>   
                        <tr>
                            <th>통합그룹</th>
                            <td><div class="div_input" id="grp_rol_nm"></div></td>
                            <th>점</th>
                            <td><div class="div_input" id="cstr_nm"></div></td>
                            <th>부서명</th>
                            <td><div class="div_input" id="org_nm"></div></td>
                        </tr>
                        <tr>
                            <th>사번</th>
                            <td><div class="div_input" id="usr_id"></div></td>
                            <th>성명/직책</th>
                            <td>
                                <div class="div_input" id="usr_nm"></div>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <!-- search // -->
            <div class="bgBorder"></div>
            <!-- Grid -->
            <table id="rol_grid"></table> 
            <div id="rol_grid_pager"></div>
            <!-- Grid // -->    
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
