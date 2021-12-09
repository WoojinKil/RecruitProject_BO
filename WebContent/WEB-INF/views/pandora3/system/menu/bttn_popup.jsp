<%-- 
    작성자 : 조성대
    개요 : 버튼조회 팝업
    수정사항 :
        2015-04-03 최초작성
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_header.jsp" %>
<script type="text/javascript">

$(document).ready(function(){
    var bttn_config = { 
        // grid id
        gridid: 'bttn_grid',
        pagerid: 'bttn_grid_pager',
        // column info
        columns:[{name:'MENU_NM', label:'메뉴명', width:100},
                 {name:'BTTN_ID', label:'버튼ID', width:100},
                 {name:'BTTN_NM', label:'버튼명', width:100}
        ],
        editmode: false,                   // 그리드 editable 여부
        gridtitle: '메뉴버튼 목록',      // 그리드명
        multiselect: true,                // checkbox 여부
        formid: 'search',                 // 조회조건 form id
        height: 150,                      // 그리드 높이
        selecturl: '/system/selectSysMenuBttnList.do',   // 그리드 조회 URL
        events: {}
    };    
    
    var bttn_grid = new UxGrid(bttn_config);
    bttn_grid.init();
    
    $("#btn_retreive").click(function() {
        bttn_grid.retreive(); //{success:function(){alert('retreive success');}}
    });  
    
    $("#btn_keyword_select").click(function() {
        var rows = bttn_grid.getSelectRows();
        if (rows.length == 0) {
            alert('버튼을 선택해 주세요');
            return;
        }    
        
        eval('opener.<%= parameterMap.getValue("callback") %>')(rows);
        window.close();
    });  
    
    $("#btn_close").click(function() {
        window.close();    
    });  
    
});
</script>
</head>
<body id="pop">
    <div class="pop_box">
        <h1><%=_title %></h1>     
       
        <div class="bbs_search">
            <form name="search" id="search" name="search" onsubmit="return false">
            <input type="hidden" id="menu_id" name="menu_id" value="<%=parameterMap.get("menu_id")%>"/>
            <input type="hidden" id="us_yn" name="us_yn" value="Y"/>
            <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">   
            <tr>
                <th width="80">메뉴명</th>
                <td width="100"><%=parameterMap.get("menu_nm") %></td>
                <td class="end"><button class="btn_s" id="btn_retreive">조회</button></td>
            </tr>
            </table>
            </form>
        </div>
        <!-- search // -->

        <!-- Grid -->
        <table id="bttn_grid"></table> 
        <div id="bttn_grid_pager"></div>
        <!-- Grid // -->    
        
        <div class="btn_pop mt20 tCenter">
            <button type="button" class="blue2" id="btn_keyword_select" name="btn_keyword_select">선택</button>
            <button type="button" class="gray2 ml5" id="btn_close" name="btn_close">닫기</button>
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_footer.jsp" %>
