<%-- 
    작성자 : 이태명
    개요 : 공지사항
    수정사항 :
        2016-08-28 최초작성
--%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더 파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<c:set var="cd" value="<%=Const.NOTICE%>"/>
<script type="text/javascript">

$(document).ready(function(){
    var up_config = { 
        // grid id
        gridid: 'master_grid',
        pagerid: 'master_grid_pager',
        // column info
        columns:[{name:'BOARD_NO', label:'번호', align:'center', editable:false, width:30},
                 {name:'BOARDTITLE', label:'제목', align:'left' , editable:false, width:150},    
                 {name:'REG_ID', label:'작성자', align:'center' , editable:false, width:40},
                 {name:'REG_DATE', label:'작성일', align:'center', editable:false, width:40, formatter:'date', formatoptions: {srcformat: 'U',newformat:'Y-m-d'}},
                 {name:'BOARDREAD_CNT', label:'조회수', align:'center', editable:false, width:40},
                 {name:'FILE_YN', label:'파일여부', align:'center', editable:false, width:40},
                 {name:'CD', label:'게시판타입', hidden:true}
        ],
        editmode: true,                                  // 그리드 editable 여부
        gridtitle: '게시글 목록',                           // 그리드명
        multiselect: true,                              // checkbox 여부
        formid: 'search',                                // 조회조건 form id
        height: 400,                                     // 그리드 높이
        shrinkToFit: true,                               // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl: '/board/selectBoardMstGridList.do',  // 그리드 조회 URL
        saveurl: '/board/updateBoardMstGridList.do',        // 그리드 입력/수정/삭제 URL
        events: {
                onSelectRow: function(event, rowid) {
                	var row = master_grid.getRowData(rowid);

                 },
                 onCellSelect: function(event, rowid, icol) {        // 해당 셀 선택시
                	 var row = master_grid.getRowData(rowid);
                	 
                     if (master_grid.getColName(icol) != 'cb') {
                         // 표기형식을 나타내주고 입력할땐 셀을 비워준다.
                         popup({url:"/board/selectBoardPopup.do"
                             //, params: {}
                             , params: {callback:"retrieveGrid" , board_no: row.BOARD_NO , type: "mod" ,  cd: row.CD}
                             , winname:"_regist_pop"
                             , title:"공지사항 수정"    
                             , type: "l"
                             , scrollbars:true
                             , autoresize:true
                             , resizable:true
                             , height: "800px"
                             , width: "1200px"
                         });
                     }               	   
                 }
      }
    };
    
    var master_grid = new UxGrid(up_config);
    master_grid.init();
   
    $("#btn_retreive").click(function() {
        if( !search.validate() ) return;

        master_grid.retreive(); //{success:function(){alert('retreive success');}}
    });
    
    
    $("#btn_code_master_add").click(function() {
        popup({url:"/board/selectBoardPopup.do"
            //, params: {}
            , params: {callback:"retrieveGrid", cd : "${cd}"}
            , winname:"_regist_pop"
            , title:"공지사항 등록"    
            , type: "l"
            , scrollbars:true
            , autoresize:true
            , resizable:true
            , height:"800px"
            , width: "1200px"
        });
    });
    
    $("#btn_code_master_del").click(function() {

      master_grid.remove();

    });
    
});
function retrieveGrid() {
    $("#btn_retreive").trigger("click"); 
}  

</script>
</head>
<body id="app">
    <div class="app_box">
        <h1><%=_title %></h1>     
       
        <div class="bbs_search">
            <form name="search" id="search" onsubmit="return false">
            <input type="hidden" id="cd" name="cd" value="${cd}"/>
            <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">   
            <tr>
                <th>제목</th>
                <td width="100">
                    <input type="text" name="boardtitle" id="boardtitle" class="text" style="width:150px;" maxlength="200" value=""  maxbyte="200"  />
                </td>
                <th>내용</th>
                <td width="100">
                    <input type="text" name="boardcontent" id="boardcontent" class="text" style="width:150px;" maxlength="100" maxbyte="200" value="" />
                </td>
                <td class="end">
                    <button class="btn_s" id="btn_retreive">조회</button>
                </td>
            </tr>
            </table>
            </form>
        </div>
        <!-- search // -->
        
        <div class="grid_btn">
           <button class="wh50" id="btn_code_master_add">추가</button>
           <button class="wh50" id="btn_code_master_del">삭제</button>
        </div>
        <!-- Grid -->
        <table id="master_grid"></table> 
        <div id="master_grid_pager"></div>
        <br/>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
