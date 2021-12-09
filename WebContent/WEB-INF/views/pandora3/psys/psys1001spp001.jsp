<%-- 
   1. 파일명 : psys1008p001
   2. 파일설명 : 시스템사용자권한관리팝업
   3. 작성일 : 2018-03-28
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_header.jsp" %>
<script type="text/javascript">
var rowId = <%= parameterMap.getValue("rowId") %>;
$(document).ready(function(){
    var menu_config = { 
        // grid id
        gridid: 'menu_grid',
        pagerid: 'menu_grid_pager',
        // column info
        columns:[{name:'USER_ID', label:'사용자ID', align:'center', width:60, hidden:true},
        		 {name:'LOGIN_ID', label:'로그인ID', align:'center', width:60},
                 {name:'USER_NM', label:'사용자명', width:100},   
                 {name:'EMAIL', label:'이메일', width:100},                
                <%--  {name:'MENU_TYPE_CD', label:'메뉴유형', editable:true, edittype:'select', formatter:'select', editoptions:{value:'<%=CodeUtil.getGridComboList("S101")%>'}, width:60},
                 {name:'MENU_YN',label:'메뉴여부', align:'center', editable:true, edittype:'select', formatter:'select', editoptions:{value:'Y:메뉴;N:비메뉴'}, width:60} --%>
        ],
        editmode: false,                   	// 그리드 editable 여부
        gridtitle: '시스템 사용자 목록',      		// 그리드명
        multiselect: true,                	// checkbox 여부
        formid: 'search',                 	// 조회조건 form id
        height: 150,                      	// 그리드 높이
        selecturl: '/psys/getPsys1007List',   // 그리드 조회 URL
        events: {}
    };    
    
    var menu_grid = new UxGrid(menu_config);
    menu_grid.init();
    menu_grid.setGridWidth($('.tblType1').width());
    $("#btn_retreive").click(function() {
        menu_grid.retreive(); //{success:function(){alert('retreive success');}}
    });  
    
    $("#btn_keyword_select").click(function() {
        var rows = menu_grid.getSelectRows();
        if (rows.length == 0) {
            alert('메뉴를 선택해 주세요');
            return;
        }    
        
        eval('opener.<%= parameterMap.getValue("callback") %>')(rows, rowId);
        window.close();
    });  
    
    $("#btn_close").click(function() {
        window.close();    
    });
    
    // 로딩 되자마자 조회
    $("#btn_retreive").trigger("click");
});
$(window).resize(function() {
	menu_grid.setGridWidth($('.tblType1').width());
});
</script>
</head>
<body id="pop">
    <div class="subCon">
        <h1><%=_title %></h1>     
            <form name="search" id="search" name="search" onsubmit="return false">
            <input type="hidden" id="leaf_menu_yn" name="leaf_menu_yn" value="Y"/>
            <table class="tblType1">   
            	<colgroup>
					<col width="10%" />
					<col width="27%" />
					<col width="15%" />
					<col width="28%" />
					<col width="20%" />
				</colgroup>   
            <tr>
                <th>사용자명</th>
                <td>
                   <span class="txt_pw"> <input type="text" name="user_nm" id="user_nm" class="text" style="width:100px;" value="<%= parameterMap.getValue("userNm") %>" /></span>
                </td> 
                <!-- <th>부서명</th>
                <td width="100">
                    <input type="text" name="menu_nm" id="menu_nm" class="text" style="width:100px;" value="" />
                </td>  -->
                <td>
                 <div class="grid_btn">
                <button class="btn_common btn_darkGray" id="btn_retreive">조회</button>
                </div>
                </td>
            </tr>
            </table>
            </form>
        <!-- search // -->

        <!-- Grid -->
        <table id="menu_grid"></table> 
        <div id="menu_grid_pager"></div>
        <!-- Grid // -->    
        
        <div class="grid_btn">
            <button type="button" class="btn_common btn_darkGray" id="btn_keyword_select" name="btn_keyword_select">선택</button>
            <button type="button" class="btn_common btn_darkGray" id="btn_close" name="btn_close">닫기</button>
        </div>
    </div>
     
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_footer.jsp" %>
