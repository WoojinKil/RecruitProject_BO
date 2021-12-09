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
<style>
 .ui-th-column221 {
    background-color: orange;
    background-image: none
}
</style>
<style>
.ui-jqgrid .ui-jqgrid-labels th.ui-th-column1 {
    background-color: orange;
    background-image: none
}


/*
.ui-jqgrid .ui-jqgrid-titlebar-close{
	background-color: red;
}

.ui-widget-header .ui-icon {
	background-image: url(../../../resources/pandora3/images/jquery-ui-red/ui-icons_cc0000_256x240.png);
}
*/

</style>
<script type="text/javascript">

$(document).ready(function () {
	
	var group_grid_config= {
		
		height: 'auto',
		gridid : 'group_grid' ,
		pagerid : 'group_grid_pager' ,
		//rowNum: 30,
		rowList: [10,20,30],
		columns : [
			{name : 'ID', label : 'ID', align : 'center', sortable : false, editable : false, highlight:true},
			{name : 'INVDATE', label : 'INVDATE', align : 'center', sortable : false, editable : false}, 
			{name : 'NAME', label : 'NAME', align : 'center', sortable : false, editable : false}, 
			{name : 'NOTE', label : 'NOTE', align : 'center', sortable : false, editable : false},
			{name : 'AMOUNT', label : 'AMOUNT', align : 'center', sortable : false, editable : false}, 
			{name : 'TAX', label : 'TAX', align : 'center', sortable : false, editable : false}, 
			{name : 'TOTAL', label : 'TOTAL', align : 'center', sortable : false, editable : false},
			
		],
		initval:  {},										// 컬럼 add 시 초기값
	    editmode: false,								    // 그리드 editable 여부
	    gridtitle: '',							    // 그리드명
	    multiselect: false,								    // checkbox 여부
	    formid: 'search',								    // 조회조건 form id
	    height: '800',									    // 그리드 높이
		viewrecords: true,
		sortname: 'name',
	    selecturl: '/sample/selectGroupingList',			  		// 그리드 조회 URL
	    grouping:true,
	    groupingView : {
	    	groupField : ['NAME']
	    }
	//	caption: "Grouping Array Data"
	};
	
	group_grid = new UxGrid(group_grid_config);
	group_grid.init();
	
	

});

function aaa(grdConf,grdNm){
    
    //$('#batch_grid_BATCH_SEQ').css('background','orange');
	for(var i = 0; i < grdConf.columns.length; i++) {
		var highlight = grdConf.columns[i].highlight;
		if(highlight != undefined && highlight!='undefined' && highlight==true){
		  var colNm =grdConf.columns[i].name;
		  $('#'+grdNm+'_'+colNm).css('background','orange');
		}
	}

}

//조회: 내부 로직 사용자 정의
function fn_Search(){
	group_grid.retreive();
	//console.log(zzzzzz);
	//group_grid.init();
}


//테스트 커밋 6번째
//jqgrid 내 버튼 생성
//그리드 테스트 
//jqgrid 내  formatter 버튼 클릭 이벤트 

$(window).resize(function() {
	batch_grid.setGridWidth($('.tblType1').width());
});

</script>

</head>
<body id="app">
	<div class="frameWrap">
	    <div class="subCon">
	    	<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
	    	 <form name="search" id="search" name="search" onsubmit="return false">
	            <table class="tblType1">   
		            <colgroup>
						<col width="15%" />
						<col width="35%" />
						<!-- <col width="15%" />
						<col width="35%" /> -->
					</colgroup>   
		            <tr>
		                <!-- <th>사용여부</th>
		                <td>
		                   <select name="us_yn" id="us_yn" class="select">
		                       <option value="">전체</option>
		                       <option value="Y">사용</option>
		                       <option value="N">미사용</option>
		                   </select>
		                </td> -->
		            </tr>
	            </table>
            </form>
           	<br/>
	    	
	        <br/><br/><br/><br/><br/><br/>
	        <table id="group_grid"></table> 
	        <div id="group_grid_pager"></div>
	        
    	</div>
   	</div>   
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
