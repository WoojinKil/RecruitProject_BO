<%-- 
   1. 파일명 : pcmp1006
   2. 파일설명 : 직급관리
   3. 작성일 : 2020-05-20
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var msg = "";

$(document).ready(function() {
	
    var staflevel_config = { 
        gridid    : 'staflevel_grid',	    // 그리드 id
        pagerid   : 'staflevel_grid_pager',	// 그리드 페이지 id
        gridBtnYn : 'Y',				// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        // column info
        columns:[{name:'CMPNY_CD', label:'법인 코드', align:'center', hidden:true}, 
        		 {name:'STATUS', label:'상태', align:'center', editable:false, width:20},
        		 {name:'STAFLEVEL_CD', label:'직급 코드', editable:true, align:'center', editoptions:{
        			 maxlength:12,
		                dataInit: function(element){
		                     $(element).keyup(function() {
		                         // 한글 입력 방지
		                         element.value = element.value.replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' );
		                     });
		                 }
        		 }},
                 {name:'STAFLEVEL_NM', label:'직급명', editable:true, edittype:'text'},
                 {name:'STAFLEVEL_RMK', label:'비고', editable:true, align:'center'},
                 {name:'US_YN', label:'사용 여부', align:'center', editable:true, edittype:'select', formatter:'select', editoptions:{value:'Y:사용;N:미사용'}}
                 ],
        initval     : {US_YN:'Y', CMPNY_CD : '202005201'},			// 컬럼 add 시 초기값
        editmode    : true,			  				             	// 그리드 editable 여부
        gridtitle   : '회사 직급',						            	// 그리드명
        multiselect : true,							            	// checkbox 여부
        formid      : 'search',							            // 조회조건 form id
        height      : '100%',							 	        // 그리드 높이
        selecturl   : '/pcmp/getPcmp1006List',	                	// 그리드 조회 URL
        saveurl     : '/pcmp/savePcmp1006',        		    		// 그리드 입력/수정/삭제 URL
        events      : {    
        	onCellSelect: function(event, rowid, icol) { 			//셀 선택시
                var row = staflevel_grid.getRowData(rowid);
                
                if(row.JQGRIDCRUD === "C") {
               	  $("#staflevel_grid").jqGrid('setColProp', 'STAFLEVEL_CD', { editable: true });
                } else {
              	  $("#staflevel_grid").jqGrid('setColProp', 'STAFLEVEL_CD', { editable: false });
                }
        	}
        }

    };    
    staflevel_grid = new UxGrid(staflevel_config);
    staflevel_grid.init();
    staflevel_grid.setGridWidth($('.tblType1').width());
    staflevel_grid.retreive();
});

//행추가: 내부 로직 사용자 정의
function fn_AddRow(){
	staflevel_grid.add();
}
//행삭제: 내부 로직 사용자 정의
function fn_DelRow(){
	var flag = false;
	staflevel_grid.remove({success:function(){staflevel_grid.init();}});
}
//저장: 내부 로직 사용자 정의
function fn_Save(){

	// 그리드 입력중인 경우 포커스 제거
	$("#staflevel_grid").editCell(0, 0, false);
	
	if(fn_ValidtaionCheck()){
		staflevel_grid.save();
	}else{
			alert(msg);
	}
}
//저장 전 유효성 체크
function fn_ValidtaionCheck() {
	
	var data = staflevel_grid.getRowData();
	
	
	return true;
}
</script>
</head>
<body id="app">
	<div class="frameWrap">
	    <div class="subCon">
	    	<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
	    	<table id="staflevel_grid"></table> 
	        <!-- <div id="staflevel_grid_pager"></div> -->
	    </div>
	</div>    	
</body>
</html>