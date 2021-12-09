<%-- 
   1. 파일명 : psys1003
   2. 파일설명 : 메뉴권한관리
   3. 작성일 : 2018-03-27
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var role_grid;
var menu_grid;
var bttn_grid;

var target_sys_cd = '';
$(document).ready(function() {
	
    var role_config = { 
        gridid    : 'role_grid',	    // 그리드 id
        pagerid   : 'role_grid_pager',	// 그리드 페이지 id
        gridBtnYn : 'Y',				// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        // column info
        columns:[{name:'ROL_ID', label:'권한ID',editable:true, align:'center',  sorttype:'int', width:60,editoptions:{
		        	dataInit:function(element){
		                $(element).keyup(function() {
		                    // 한글 입력 방지
		                    element.value = element.value.replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' );
		                });
		            }
		           }},
                 {name:'ROL_NM', label:'권한명', edittype:'text', width:200},
                 {name:'US_YN', label:'사용여부', align:'center',  edittype:'select', formatter:'select', editoptions:{value:'Y:사용;N:미사용'}, width:80},
                 {name:'F_APL_ST_DT', label:'적용시작일자', align:'center',  width:120, editoptions:{dataInit:function(e){$(e).datepicker({dateFormat:'yy-mm-dd',changeYear:true,changeMonth:true});}}},
                 {name:'F_APL_ED_DT', label:'적용종료일자', align:'center', width:120, editoptions:{dataInit:function(e){$(e).datepicker({dateFormat:'yy-mm-dd',changeYear:true,changeMonth:true});}}},
                 {name:'UPD_DTTM',label:'변경일자', align:'center', width:100, formatter:'date', formatoptions: {srcformat: 'U',newformat:'Y-m-d'}},
                 {name : 'SYS_CD', label : '시스템명', align : 'center', editable : true, edittype : 'select', formatter : 'select', editoptions : {value:'<c:out value="<%=CodeUtil.getSitGridComboList()%>" />'}, width : 100, }
                 ],
        initval     : {US_YN:'Y', F_APL_ED_DT:'9999-12-31 23:59'},	// 컬럼 add 시 초기값
        editmode    : false,							            // 그리드 editable 여부
        gridtitle   : '권한 목록',						            	// 그리드명
        multiselect : false,							            // checkbox 여부
        formid      : 'search',							            // 조회조건 form id
        height      : '150',							 	        // 그리드 높이
        selecturl   : '/psys/getPsys1006List',	                // 그리드 조회 URL
        events      : {    
        				ondblClickRow: function(event, rowid, irow, icol) {
	                          var row = role_grid.getRowData(rowid);
	                          if (isNotEmpty(row.ROL_ID)) {
	                               menu_grid.retreive({data:{rol_id:row.ROL_ID,sys_cd:$("#sys_info").val()}});
	                           	   target_sys_cd = row.SYS_CD;    
	                          }
	                    } 
      	}
    };    
    
    var menu_config = {
            
            gridid  : 'menu_grid',			// 그리드 id
            pagerid : 'menu_grid_pager',	// // 그리드 페이지 id
            // column info
            columns:[
            	     {name : 'ROL_NM', label : '권한명', hidden : true},
                     {name : 'SYS_NM', label : '시스템명', hidden : true},
                     {name : 'SYS_CD', label : '시스템번호', hidden : true},
            	     {name : 'STATUS', label:'상태', align:'center', editable:false, width:20},	
            	     {name : 'ROL_ID' , label:'권한ID',  editable:false, align:'center',  sortable:false, width:60},                       
                     {name : 'MNU_SEQ', label:'메뉴ID', editable:false, align:'center',  sortable:false, width:60},
                     {name : 'MNU_NM', label:'메뉴명', editable:false, width:150, sortable:false},               
                          /* {name:'ROL_DESC', label:'비고', editable:true, width:100, sortable:false}, */
                     {name : 'F_UPD_DTTM', label:'변경일자', editable:false, align:'center', width:100, sortable:false}
                     ],
            initval     : {},								// 컬럼 add 시 초기값
            editmode    : true,								// 그리드 editable 여부
            gridtitle   : '권한메뉴 목록',						// 그리드명
            multiselect : true,								// checkbox 여부
            height      : '200',							// 그리드 높이
            shrinkToFit : true,								// true인경우 column의 width 자동조정, false인경우 정해진 width데로 구현(가로스크롤바필요시 false)
            selecturl   : '/psys/getPsys1003List',	    // 그리드 조회 URL
            saveurl     : '/psys/savePsys1003List',		// 그리드 입력/수정/삭제 URL
    };

    
    role_grid = new UxGrid(role_config);
    role_grid.init();
    menu_grid = new UxGrid(menu_config);
    menu_grid.init();
    
    role_grid.setGridWidth($('.tblType1').width());
    menu_grid.setGridWidth($('.tblType1').width());
    
    // 저장 버튼 클릭 시
    $("#btn_menu_save").click(function() {
        menu_grid.save(); 
    });
    
    // 행추가 버튼 클릭 시
    $("#btn_menu_add").click(function() {
        var sels    = role_grid.getSelectRows();
        var sys_cd = $("#sys_info").val();
        
        if (sels.length == 0 || target_sys_cd == '') {
            alert('권한을 선택하세요');
            return;
        } else if (sels.length > 1) {
            alert('권한을 하나만 선택하세요');
            return;
        }

        bpopup({
			  url:"/psys/forward.psys1003p001.adm"
			, params	: {callback : "getAdminMenu", sys_cd : target_sys_cd, target_id : _menu_id}
			, title		: "메뉴목록"                          
			, type		: "l"
			, height	: "460px"
			, id        : "psys1003p1"
		});
		     
	     
		     
    });
    
    // 행삭제 버튼 클릭 시
    $("#btn_menu_del").click(function() {
    	menu_grid.remove();
    });
    
    // 엑셀다운로드 버튼 클릭 시 
    $("#btn_menu_excel").click(function() {
    	var sels = role_grid.getSelectRows();
        if (sels.length == 0) {
            alert('권한을 선택하세요');
            return;
        }
        
    	var grid_id = "menu_grid";
    	var rows    = $('#menu_grid').jqGrid('getGridParam', 'rowNum');
    	var page    = $('#menu_grid').jqGrid('getGridParam', 'page');
    	var total   = $('#menu_grid').jqGrid('getGridParam', 'total');
    	var title   = $('#menu_grid').jqGrid('getGridParam', 'gridtitle');
    	var url     = "/psys/getPsys1003XlsxDwld.adm";  //페이징 존재
    	var param          = {};
    	    param.rol_id   = sels[0].ROL_ID;
    	    param.page     = page;
    	    param.rows     = rows;
    	    param.filename ="권한메뉴 목록";
    	AdvencedExcelDownload(grid_id, url, param);
    });
    
  	//사이트 리스트 취득
    getSystemList();
 	
 	//시스템 변경 시 재 검색
    $("#sys_info").on("change", function () {
		fn_Search();
	});  
    
});

//grid resizing
$(window).resize(function() {
	role_grid.setGridWidth($('.tblType1').width());
	menu_grid.setGridWidth($('.tblType1').width());
});
	
// 메뉴 조회 콜백 팝업 함수
function getAdminMenu(rows) {
    var sels = role_grid.getSelectRows();
    if (sels.length == 0) {
        alert('권한을 선택하세요');
        return;
    } else if (sels.length > 1) {
        alert('권한을 하나만 선택하세요');
        return;
    }
    
    var records = rows||{}
    var rows    = menu_grid.getRowData();  
    var existMnuNm = "";
    var notExistMnuCnt = 0;
    var existMnuCnt = 0;
    var exist = false;
    for (var i = 0; i < records.length; i++) {
	    var isExist = false;
        
        // 기존에 추가되어있는지 확인                   
        for (var k = 0; k < rows.length; k++) {
            if (records[i].MNU_SEQ == rows[k].MNU_SEQ) {
                isExist = true;
                exist = true;
                existMnuNm = "[" + records[i].MNU_NM + "]";
                existMnuCnt ++;
            }
        }
        
        if (!isExist) {
            menu_grid.add({
            	           ROL_ID :sels[0].ROL_ID,
            	           ROL_NM :sels[0].ROL_NM,
            	           MNU_SEQ:records[i].MNU_SEQ,
            	           MNU_NM :records[i].MNU_NM,
            	           SYS_CD:records[i].SYS_CD,
            	           SYS_NM:records[i].SYS_NM
                           });
            notExistMnuCnt ++ ;
        }
    }
    
    existMnuCnt = existMnuCnt > 0 ? --existMnuCnt : 0;
    if(exist) {
    	alert(existMnuNm + "외 " + existMnuCnt + "건 중복 제거 후 \n" + notExistMnuCnt + "건 추가 완료했습니다.");
    } else {
    	alert(notExistMnuCnt + "건 추가 완료했습니다.");
    }
    
}
    
//조회: 내부 로직 사용자 정의
function fn_Search(){
	
	var sys_cd = $("#sys_info").val();
	$("#sys_cd").val(sys_cd);
	
	/* //시스템(사이트) 구분 필수
	if(isEmpty(sys_cd)) {
		alert("시스템을 선택해 주세요.");
		role_grid.clearGridData();
		menu_grid.clearGridData();
		return false;
	} */
	
	role_grid.retreive(); 
	menu_grid.clearGridData();      
}

//엑셀다운로드: 내부 로직 사용자 정의
function fn_ExcelDownload(){
	var grid_id = "role_grid";
	var rows    = $('#role_grid').jqGrid('getGridParam', 'rowNum');
	var page    = $('#role_grid').jqGrid('getGridParam', 'page');
	var total   = $('#role_grid').jqGrid('getGridParam', 'total');
	var title   = $('#role_grid').jqGrid('getGridParam', 'gridtitle');
	var url     = "/psys/getPsys1006XlsxDwld";  //페이징 존재
	var param          = {};
	    param.page     = page;
	    param.rows     = rows;
	    param.filename = "시스템메뉴 권한 목록";
	AdvencedExcelDownload(grid_id, url, param);
}

//사이트 리스트 취득
function getSystemList() {
	var html = "";
	ajax({
		url 	: "/pdsp/getPdsp1011ListSit",
		data 	: {sys_cd : _sys_cd} , 
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
						$("#sys_info").closest('div').show();
					}
				});
				$("#sys_info").append(html);
			}
		}
	});
}

</script>
</head>
<body id="app">
	<div class="frameWrap">
	    <div class="subCon">
	    	<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
	    	<!-- search -->
	    	<div class="tableTopLeft gridBtn">
				<div class="selectInner" style="display: none;">
					<label for="sys_info">시스템 : </label>
					<select id="sys_info" name="sys_info" class="select" >
						<option value="">전체</option>
					</select>
				</div>
			</div>
			<div class="frameTopTable">  
	            <form name="search" id="search" name="search" onsubmit="return false">
	            	<input type="hidden" name="sys_cd" id="sys_cd" value="" />
		            <table class="tblType1">  
		            	<colgroup>
							<col style="width: 117px;" />
							<col style="" />
							<col style="width: 117px;" />
							<col style="" />
						</colgroup>   
			            <tr>
			                <th>권한명</th>
			                <td>
			                    <span class="txt_pw"><input type="text" name="rol_nm" id="rol_nm" class="text" value="" maxlength="12" maxlength="300"/></span>
			                </td>                
			                <th>사용여부</th>
			                <td>
				               <span class="txt_pw">
				                   <select name="us_yn" id="us_yn" class="select">
				                       <option value="">전체<option>
				                       <option value="Y">사용</option>
				                       <option value="N">미사용</option>
				                   </select>
			                   </span>
			                </td>
			            </tr>
		            </table>
	            </form>
            </div>
            <div class="bgBorder"></div>
	        <!-- search // -->
	        <!-- Grid -->
	        <table id="role_grid"></table> 
	        <div class="bgBorder"></div>
	        <div id="role_grid_pager"></div>
			<div class="grid_right_btn">
				<div id="btn_menu_grid" class="grid_right_btn_in">
					<button class="btn_common btn_default" id="btn_menu_save">저장</button>
					<button class="btn_common btn_default" id="btn_menu_add">행추가</button>
					<button class="btn_common btn_default" id="btn_menu_del">행삭제</button>
					<button class="btn_common btn_default" id="btn_menu_excel">
					   <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_download.png" alt="엑셀 다운로드" />
                    </button>
				</div>
			</div>
	        <table id="menu_grid"></table> 
	        <div id="menu_grid_pager"></div>
	        <br/>
	        <!-- Grid // -->    
	    </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
