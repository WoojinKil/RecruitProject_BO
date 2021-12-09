<%-- 
    작성자 : 이태명
    개요 : 메뉴 관리
    수정사항 :
        2016-08-23 최초작성
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
// 그리드 선언
var top_menu_grid;
var middle_menu_grid;
var bottom_menu_grid;
$(document).ready(function(){
	// 상위 그리드
    var top_config = { 
        // grid id
        gridid: 'top_menu_grid',
        pagerid: 'top_menu_grid_pager',
        // column info
        columns:[{name:'MENU_ID', label:'메뉴ID', align:'center',  sorttype:'int', width:60},
                 {name:'MENU_NM', label:'메뉴명', editable:true, edittype:'text', width:200, editoptions:{
                     size:48,
                     maxlength:150,  
                 }},             
                 {name:'US_YN', label:'사용여부', align:'center', editable:true, edittype:'select', formatter:'select', editoptions:{value:'Y:사용;N:미사용'}, width:60, required:true},
                 {name:'SORT_ORD', label:'노출순서', align:'right', editable:true, sorttype:'int', width:60, required:true, editoptions:{
                     size:4,
                     maxlength:4,  
                     dataInit: function(element){
                    	 var oldVal = element.value;
                         $(element).keypress(function(e) {
                        	 // 숫자만 입력받도록
                        	 if(!onlyNum(e)){
                        		 return false;
                        	 }
                         });
                         $(element).keyup(function() {
                             // 한글 입력 방지
                             element.value = element.value.replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' );
                         });
                     }
                 }, formatter:'currency', 
                 formatoptions: {
                     decimalPlaces:0,  //정수표현
                     defaultValue: '1'
               	 }},
                /*  {name:'NOTE_CONT',label:'비고', editable:true, width:100, editoptions:{
                     size:21,
                     maxlength:250
                 }}, */
                  {name:'MOD_DATE',label:'변경일자', required:false, align:'center', sorttype:"date", width:100, formatter:'date', formatoptions: {srcformat: 'U',newformat:'Y-m-d'}},
      			  {name:'MENU_DEPTH', hidden:true, sorttype:'int'},
                  {name:'LEAF_MENU_YN', hidden:true},
                  {name:'FRONT_YN',hidden:true}
        ],
        initval: {MENU_TYPE_CD:'10', MENU_YN:'Y', US_YN:'Y', SORT_ORD:999, MENU_DEPTH:1, LEAF_MENU_YN:'Y',FRONT_YN:'N'}, // 컬럼 add 시 초기값
        editmode: true,                                   // 그리드 editable 여부
        gridtitle: '상위 메뉴 목록',                           // 그리드명
        multiselect: true,                                // checkbox 여부
        formid: 'search',                                 // 조회조건 form id
        height: 200,                                      // 그리드 높이
        shrinkToFit: true,                                // true인경우 column의 width 자동조정, false인경우 정해진 width데로 구현(가로스크롤바필요시 false)
        selecturl: '/system/selectSysAdminMenuGridList',   // 그리드 조회 URL
        saveurl: '/system/updateSysAdminMenuList',     // 그리드 입력/수정/삭제 URL
        events: {
        	     // 그리드 로우 선택시
                 onSelectRow: function(event, rowid) {
                     var row = top_menu_grid.getRowData(rowid);
                     if (isNotEmpty(row.MENU_ID)) {
                    	  // 상위 메뉴 아이디로 하위 그리드 조회
                    	  $("#menu_depth").val("2");
                          middle_menu_grid.retreive({data:{up_menu_id:row.MENU_ID,menu_depth:2}});
                          bottom_menu_grid.clearGridData({success:function(){$("#bottom_menu_grid").jqGrid('setColProp', 'MENU_NM', { editable: false });}});
                     }
                 },
                 // 셀 선택시
                 onCellSelect: function(event, rowid, icol) {
                     var row = top_menu_grid.getRowData(rowid);
                     // 선택한 컬럼이 메뉴 아이디일 경우
                     if (top_menu_grid.getColName(icol) == 'MENU_ID') {
                    	 // 메뉴 아이디가 비어있을 경우
                         if(row.TOP_MENU_ID == "") { 
                               alert("메뉴 ID는 자동으로 입력됩니다.");
                            }
                     }
                 }
        }
    };
	
	// 2뎁스 그리드
    var middle_config = { 
            // grid id
            gridid: 'middle_menu_grid',
            pagerid: 'middle_menu_grid_pager',
            // column info
            columns:[{name:'MENU_ID', label:'메뉴ID', align:'center',  sorttype:'int', width:60},
                     {name:'UP_MENU_ID', label:'상위 메뉴ID',align:'center',sorttype:'int',hidden:true},
                     {name:'MENU_NM', label:'메뉴명', editable:true, edittype:'text', width:200, required:true, editoptions:{
                         size:48,
                         maxlength:150,  
                     }},             
                     {name:'US_YN', label:'사용여부', align:'center', editable:true, edittype:'select', formatter:'select', editoptions:{value:'Y:사용;N:미사용'}, width:60, required:true},
                     {name:'SORT_ORD', label:'노출순서', align:'right', editable:true, sorttype:'int', width:60, required:true, editoptions:{
                         size:4,
                         maxlength:4,  
                         dataInit: function(element){
                        	 var oldVal = element.value;
                             $(element).keypress(function(e) {
                            	 // 숫자만 입력받도록
                            	 if(!onlyNum(e)){
                            		 return false;
                            	 }
                             });
                             $(element).keyup(function() {
                                 // 한글 입력 방지
                                 element.value = element.value.replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' );
                             });
                         }
                     }, formatter:'currency', 
                     formatoptions: {
                         decimalPlaces:0,  //정수표현
                         defaultValue: '1'
                   	  }},
                     /* {name:'NOTE_CONT',label:'비고', editable:true, width:100, editoptions:{
                         size:21,
                         maxlength:250
                     }}, */
                      {name:'MOD_DATE',label:'변경일자', required:false, align:'center', sorttype:"date", width:100, formatter:'date', formatoptions: {srcformat: 'U',newformat:'Y-m-d'}},
                      {name:'MENU_DEPTH', hidden:true, sorttype:'int'},
                      {name:'LEAF_MENU_YN', hidden:true}, 
                      {name:'FRONT_YN',hidden:true}
            ],
            initval: {MENU_TYPE_CD:'10', MENU_YN:'Y', US_YN:'Y', SORT_ORD:999, MENU_DEPTH:2, LEAF_MENU_YN:'Y',FRONT_YN:'N'}, // 컬럼 add 시 초기값
            editmode: true,                                   // 그리드 editable 여부
            gridtitle: '중위 메뉴 목록',                           // 그리드명
            multiselect: true,                                // checkbox 여부
            formid: 'search',                                 // 조회조건 form id
            height: 200,                                      // 그리드 높이
            shrinkToFit: true,                                // true인경우 column의 width 자동조정, false인경우 정해진 width데로 구현(가로스크롤바필요시 false)
            selecturl: '/system/selectSysAdminMenuGridList',   // 그리드 조회 URL
            saveurl: '/system/updateSysAdminMenuList',     // 그리드 입력/수정/삭제 URL
            events: {
            	     // 그리드 로우 선택시
                     onSelectRow: function(event, rowid) {
                         var row = middle_menu_grid.getRowData(rowid);
                         if (isNotEmpty(row.MENU_ID)) {
                        	  // 상위 메뉴 아이디로 하위 그리드 조회
                        	    $("#menu_depth").val("3");
                        	  bottom_menu_grid.retreive({data:{up_menu_id:row.MENU_ID,menu_depth:3}});
                         }
                     },
                     // 셀 선택시
                     onCellSelect: function(event, rowid, icol) {
                         var row = middle_menu_grid.getRowData(rowid);
                         // 선택한 컬럼이 메뉴 아이디일 경우
                         if (middle_menu_grid.getColName(icol) == 'MENU_ID') {
                        	 // 메뉴 아이디가 비어있을 경우
                             if(row.MENU_ID == "") { 
                                   alert("메뉴 ID는 자동으로 입력됩니다.");
                                }
                         }
                     }
            }
        };
	
	
    // 하위 그리드
    var bottom_config = { 
            // grid id
            gridid: 'bottom_menu_grid',
            pagerid: 'bottom_menu_grid_pager',
            // column info
            columns:[{name:'MENU_ID', label:'메뉴ID', align:'center',  sorttype:'int', width:60},
                     {name:'UP_MENU_ID', label:'상위 메뉴ID',align:'center',sorttype:'int',hidden:true},
                     {name:'MENU_NM', label:'메뉴명', editable:true, edittype:'text', width:200, editoptions:{
                    	 size:31,
                         maxlength:150,  
                     }},
                     {name:'URL', label:'URL', editable:true, edittype:'text', width:200, required:true, editoptions:{
                         size:31,
                         maxlength:250,  
                         dataInit: function(element){
                             $(element).keyup(function() {
                                 // 한글 입력 방지
                                 element.value = element.value.replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' );
                             });
                         }
                     }},
                     {name:'MENU_TYPE_CD', label:'메뉴유형', align:'center', editable:true, edittype:'select', formatter:'select', editoptions:{value:'<%=CodeUtil.getGridComboList("S101")%>'}, width:60, required:true},
                     {name:'US_YN', label:'사용여부', align:'center', editable:true, edittype:'select', formatter:'select', editoptions:{value:'Y:사용;N:미사용'}, width:60, required:true},
                     {name:'SORT_ORD', label:'노출순서', align:'right', editable:true, sorttype:'int', width:60, required:true, editoptions:{
                    	 size:4,
                         maxlength:4,  
                         dataInit: function(element){
                             var oldVal = element.value;
                             $(element).keypress(function(e) {
                                 // 숫자만 입력받도록
                                 if(!onlyNum(e)){
                                     return false;
                                 }
                             });
                             $(element).keyup(function() {
                                 // 한글 입력 방지
                                 element.value = element.value.replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' );
                             });
                         }
                     }, formatter:'currency', 
                     formatoptions: { 
                         decimalPlaces:0,  //정수표현
                         defaultValue: '1'
                     }},
	                /*  {name:'NOTE_CONT',label:'비고', editable:true, width:100, editoptions:{
	                     size:13,
	                     maxlength:250
	                 }}, */
                     {name:'MOD_DATE',label:'변경일자', required:false, align:'center', sorttype:"date", width:100, formatter:'date', formatoptions: {srcformat: 'U',newformat:'Y-m-d'}},
                     {name:'MENU_DEPTH', hidden:true, sorttype:'int'},
                     {name:'LEAF_MENU_YN', hidden:true},
                     {name:'UP_MENU_ID', hidden:true},
                     {name:'FRONT_YN',hidden:true}
            ],
            initval: {MENU_TYPE_CD:'10', MENU_YN:'Y', US_YN:'Y', SORT_ORD:999, MENU_DEPTH:3, LEAF_MENU_YN:'Y',FRONT_YN:'N'},
            editmode: true,                                   // 그리드 editable 여부
            gridtitle: '하위 메뉴 목록',                           // 그리드명
            multiselect: true,                                // checkbox 여부
            height: 200,                                      // 그리드 높이
            selecturl: '/system/selectSysAdminMenuGridList',   // 그리드 조회 URL
            saveurl: '/system/updateSysAdminMenuList',     // 그리드 입력/수정/삭제 URL
            events: {
            	// 셀 선택시
                onCellSelect: function(event, rowid, icol) {
                    var row = bottom_menu_grid.getRowData(rowid);
                    // 선택한 컬럼이 메뉴 아이디일 경우
                    if (bottom_menu_grid.getColName(icol) == 'MENU_ID') {
                    	// 메뉴 아이디가 비어있을 경우
                        if(row.MENU_ID == "") { 
                              alert("메뉴 ID는 자동으로 입력됩니다.");
                           }
                    }
                }
            } 
        };
    // 상위 그리드 선언
    top_menu_grid = new UxGrid(top_config);
    // 상위 그리드 생성
    top_menu_grid.init();
    // 조회 버튼 클릭시
    $("#btn_retreive").click(function() {
    	// 상위 그리드 조회 성공 시 상위 그리드의 메뉴명 컬럼의 editable 값을 false로 변경
    	$("#menu_depth").val("1");
        top_menu_grid.retreive({success:function(){$("#top_menu_grid").jqGrid('setColProp', 'MENU_NM', { editable: true });}});
        // 중위 그리드 조회 성공 시 중위 그리드의 메뉴명 컬럼의 editable 값을 false로 변경
     /*    middle_menu_grid.retreive({success:function(){$("#middle_menu_grid").jqGrid('setColProp', 'MENU_NM', { editable: false });}});
    	// 하위 그리드 조회 성공 시 하위 그리드의 메뉴명 컬럼의 editable 값을 false로 변경
    	
    	 bottom_menu_grid.retreive({success:function(){$("#bottom_menu_grid").jqGrid('setColProp', 'MENU_NM', { editable: false });}});
    	
        bottom_menu_grid.clearGridData({success:function(){$("#bottom_menu_grid").jqGrid('setColProp', 'MENU_NM', { editable: false });}}); */
        
        middle_menu_grid.clearGridData({success:function(){$("#middle_menu_grid").jqGrid('setColProp', 'MENU_NM', { editable: false });}});
        bottom_menu_grid.clearGridData({success:function(){$("#bottom_menu_grid").jqGrid('setColProp', 'MENU_NM', { editable: false });}});
    });
    // 상위 그리드 저장 버튼 클릭시
    $("#btn_top_menu_save").click(function() {
    	// 상위 그리드 저장 성공 시 상위 그리드의 메뉴명 컬럼의 editable 값을 false로 변경
    	$("#menu_depth").val("1");
        top_menu_grid.save({success:function(){$("#top_menu_grid").jqGrid('setColProp', 'MENU_NM', { editable: false });}});
    });
    // 상위 그리드 추가 버튼 클릭시
    $("#btn_top_menu_add").click(function() {
    	// default 값 세팅
       	top_menu_grid.add();    // 상위 그리드 추가
       	// 상위 그리드의 메뉴명 컬럼 상태값을 true 로 변경
        $("#top_menu_grid").jqGrid('setColProp', 'MENU_NM', { editable: true });  
    });
    
    // 상위 그리드 삭제 버튼 클릭시
    $("#btn_top_menu_del").click(function() {
    	$("#menu_depth").val("1");
    	top_menu_grid.remove();
    	middle_menu_grid.clearGridData({success:function(){$("#bottom_menu_grid").jqGrid('setColProp', 'MENU_NM', { editable: false });}});
    	bottom_menu_grid.clearGridData({success:function(){$("#bottom_menu_grid").jqGrid('setColProp', 'MENU_NM', { editable: false });}});
    });
   
    // 중위 그리드 선언
    middle_menu_grid= new UxGrid(middle_config);
    
    //중위 그리드 생성
    middle_menu_grid.init();
    
 // 중위 그리드 저장 버튼 클릭시
    $("#btn_middle_menu_save").click(function() {
    	// 하위 그리드 저장 완료시 메뉴명 컬럼 editable 값을  false로 변경
    	$("#menu_depth").val("2");
        middle_menu_grid.save({success:function(){$("#bottom_menu_grid").jqGrid('setColProp', 'MENU_NM', { editable: false });}});
    });
    
    // 중위 그리드 추가 버튼 클릭시
    $("#btn_middle_menu_add").click(function() {
        // 현재 상위 그리드에서 선택된 값 확인
        var sels = top_menu_grid.getSelectRows();
    	//console.log(sels[0].MENU_ID)
        if (sels.length == 0) {
        	// 선택된 상위 그리드 값이 없을 경우
            alert('상위 메뉴를 선택하세요');
            return;
        }else if(sels[0].MENU_ID == "" ){
        	// 선택된 상위 그리드 값이 저장되지 않았을 경우
            alert('상위 메뉴 저장후 사용가능합니다.');
            return;         
        }
        else if (sels.length > 1) {
        	// 상위 그리드 값을 여러개 선택했을 경우
            alert('상위 메뉴 하나만 선택하세요');
            return;
        }
        
        // default 값 세팅
    	middle_menu_grid.add({UP_MENU_ID:sels[0].MENU_ID});  // 상위 그리드 메뉴ID로 하위 그리드 세팅
    	// 중위 그리드 메뉴명 컬럼의 editable 값을 true로 변경
        $("#middle_menu_grid").jqGrid('setColProp', 'MENU_NM', { editable: true });
    });
    
    // 중위 그리드 삭제 버튼 클릭시
    $("#btn_middle_menu_del").click(function() {
    	$("#menu_depth").val("2");
    	middle_menu_grid.remove();
    	bottom_menu_grid.clearGridData({success:function(){$("#bottom_menu_grid").jqGrid('setColProp', 'MENU_NM', { editable: false });}});
    });
    
    // 하위 그리드 선언
    bottom_menu_grid = new UxGrid(bottom_config);
    // 하위 그리드 생성
    bottom_menu_grid.init();
    
    // 하위 그리드 저장 버튼 클릭시
    $("#btn_bottom_menu_save").click(function() {
    	// 하위 그리드 저장 완료시 메뉴명 컬럼 editable 값을  false로 변경
    	$("#menu_depth").val("3");
        bottom_menu_grid.save({success:function(){$("#bottom_menu_grid").jqGrid('setColProp', 'MENU_NM', { editable: false });}});
    });
    
    // 하위 그리드 추가 버튼 클릭시
    $("#btn_bottom_menu_add").click(function() {
        // 현재 상위 그리드에서 선택된 값 확인
        var sels = middle_menu_grid.getSelectRows();
        if (sels.length == 0) {
        	// 선택된 상위 그리드 값이 없을 경우
            alert('상위 메뉴를 선택하세요');
            return;
        }
       
        else if(sels[0].MENU_ID == "" ){
        	
        	// 선택된 상위 그리드 값이 저장되지 않았을 경우
            alert('상위 메뉴 저장후 사용가능합니다.');
            return;         
        }
     
        else if (sels.length > 1) {
        	// 상위 그리드 값을 여러개 선택했을 경우
            alert('상위 메뉴 하나만 선택하세요');
            return;
        }
        
        // default 값 세팅
    	bottom_menu_grid.add({UP_MENU_ID:sels[0].MENU_ID});  // 상위 그리드 메뉴ID로 하위 그리드 세팅
    	// 하위 그리드 메뉴명 컬럼의 editable 값을 true로 변경
        $("#bottom_menu_grid").jqGrid('setColProp', 'MENU_NM', { editable: true });          
    });
    
    // 하위 그리드 삭제 버튼 클릭시
    $("#btn_bottom_menu_del").click(function() {
    	$("#menu_depth").val("3");
    	bottom_menu_grid.remove();
    });

});
//grid resizing
$(window).resize(function(){
	top_menu_grid.setGridWidth($('.tblType1').width());
	middle_menu_grid.setGridWidth($('.tblType1').width());
	bottom_menu_grid.setGridWidth($('.tblType1').width());
});
</script>
</head>
<body id="app">
    <div class="subCon">
        <h1><%=_title %></h1>     
        <form name="search" id="search" name="search" onsubmit="return false">
        <input type="hidden" id="menu_depth" name="menu_depth"/>
        <table class="tblType1">   
        <tr>
            <th>사용여부</th>
            <td>
               <select name="us_yn" id="us_yn" class="select">
                   <option value="">전체</options>
                   <option value="Y">사용</option>
                   <option value="N">미사용</option>
               </select>
            </td>
            <th>메뉴명</th>
            <td><span class="txt_pw"><input type="text" name="menu_nm" id="menu_nm" class="w100"/></span></td>
            <td><div class="grid_btn"><button class="btn_common btn_darkGray" id="btn_retreive">조회</button></div></td>
        </tr>
        </table>
        </form>

        <table class="tblType3">
        <tr>
            <td>
                <div class="grid_btn">
                    <button class="btn_common btn_darkGray" id="btn_top_menu_save">저장</button>
                    <button class="btn_common btn_darkGray" id="btn_top_menu_add">추가</button>
                    <button class="btn_common btn_darkGray" id="btn_top_menu_del">삭제</button>
                </div>
            </td>
        </tr>
        </table>

        <!-- Grid -->
        <table id="top_menu_grid"></table> 
        <div id="top_menu_grid_pager"></div>

        <table class="tblType3">
        <tr>
            <td>
                <div class="grid_btn">
                    <button class="btn_common btn_darkGray" id="btn_middle_menu_save">저장</button>
                    <button class="btn_common btn_darkGray" id="btn_middle_menu_add">추가</button>
                    <button class="btn_common btn_darkGray" id="btn_middle_menu_del">삭제</button>
                </div>
            </td>
        </tr>
        </table>

        <!-- Grid -->
        <table id="middle_menu_grid"></table> 
        <div id="middle_menu_grid_pager"></div>

        <table class="tblType3">
        <tr>
            <td>
                <div class="grid_btn">
                    <button class="btn_common btn_darkGray" id="btn_bottom_menu_save">저장</button>
                    <button class="btn_common btn_darkGray" id="btn_bottom_menu_add">추가</button>
                    <button class="btn_common btn_darkGray" id="btn_bottom_menu_del">삭제</button>
                </div>
            </td>
        </tr>
        </table>

        <!-- Grid -->
        <table id="bottom_menu_grid"></table> 
        <div id="bottom_menu_grid_pager"></div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
