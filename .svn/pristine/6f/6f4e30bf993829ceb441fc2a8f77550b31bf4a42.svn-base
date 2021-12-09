<%-- 
   1. 파일명 : pcmp1008
   2. 파일설명 : 기술직무관리
   3. 작성일 : 2020-05-20
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
	
    var tech_stafjob_config = { 
        gridid    : 'tech_stafjob_grid',	    // 그리드 id
        pagerid   : 'tech_stafjob_grid_pager',	// 그리드 페이지 id
        gridBtnYn : 'Y',				// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        // column info
        columns:[{name:'CMPNY_CD', label:'법인 코드', align:'center', hidden:true},
        		 {name:'TECH_STAFJOB_CD', label:'기술 직무 코드', editable:true, align:'center', editoptions:{
        			 maxlength:12,
		                dataInit: function(element){
		                     $(element).keyup(function() {
		                         // 한글 입력 방지
		                         element.value = element.value.replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' );
		                     });
		                 }
  		 }},
                 {name:'TECH_STAFJOB_NM', label:'기술 직무명', editable:true, edittype:'text'},
                 {name:'TECH_STAFJOB_RMK', label:'비고', editable:true, align:'center'},
                 {name:'US_YN', label:'사용 여부', align:'center',  edittype:'select', formatter:'select', editoptions:{value:'Y:사용;N:미사용'}}
                 ],
        initval     : {US_YN:'Y'},	// 컬럼 add 시 초기값
        editmode    : true,							            	// 그리드 editable 여부
        gridtitle   : '회사 기술 직무',						            // 그리드명
        multiselect : true,							            	// checkbox 여부
        formid      : 'search',							            // 조회조건 form id
        height      : '150',							 	        // 그리드 높이
        selecturl   : '/pcmp/getPcmp1009List',	                	// 그리드 조회 URL
        saveurl		: '/pcmp/savePcmp1009',							// 그리드 저장 URL
        events      : {    

      	}
    };    
    tech_stafjob_grid = new UxGrid(tech_stafjob_config);
    tech_stafjob_grid.init();
    tech_stafjob_grid.setGridWidth($('.tblType1').width());
    
});

//행추가: 내부 로직 사용자 정의
function fn_AddRow(){
	tech_stafjob_grid.add();
}
//행삭제: 내부 로직 사용자 정의
function fn_DelRow(){
	var flag = false;
	tech_stafjob_grid.remove({success:function(){tech_stafjob_grid.init();}});
}
//저장: 내부 로직 사용자 정의
function fn_Save(){

	// 그리드 입력중인 경우 포커스 제거
	$("#tech_stafjob_grid").editCell(0, 0, false);
	
	if(fn_ValidtaionCheck()){
		tech_stafjob_grid.save();
	}else{
			alert(msg);
	}
}
//저장 전 유효성 체크
function fn_ValidtaionCheck() {
	
	var data = tech_stafjob_grid.getRowData();
	
	
	return true;
}
</script>
</head>
<body id="app">
	<div class="frameWrap">
	    <div class="subCon">
	    	<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
	    	
	    	<table id="tech_stafjob_grid"></table> 
	        <div id="tech_stafjob_grid_pager"></div>
	    </div>
	</div>    	
</body>
</html>