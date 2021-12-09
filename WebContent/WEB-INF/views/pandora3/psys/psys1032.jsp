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
	
	var batch_grid_config = {
	    // grid id
		gridid : 'batch_grid' ,
		pagerid : 'batch_grid_pager' ,
		columns : [
			{name : 'LOG_SEQ', label : '로그 번호', align : 'center', sortable : false, editable : false, hidden:true,frozen:true},
			{name : 'BATCH_SEQ', label : '배치명', align : 'center', sortable : false, editable : false, highlight:true,frozen:true},
			{name : 'F_BATCH_ST_DT', label : '배치시작일시', align : 'center', sortable : false, editable : false,frozen:true}, 
			{name : 'F_BATCH_ED_DT', label : '배치종료일시', align : 'center', sortable : false, editable : false}, 
			{name : 'F_BATCH_WRK_ST_DT', label : '작업시작일시', align : 'center', sortable : false, editable : false}, 
			{name : 'F_BATCH_WRK_ED_DT', label : '작업종료일시', align : 'center', sortable : false, editable : false}, 
			{name : 'SELECT_CNT', label : '조회건수', align : 'center', sortable : false, editable : false},
			{name : 'UPDATE_CNT', label : '수정건수', align : 'center', sortable : false, editable : false}, 
			{name : 'DELETE_CNT', label : '삭제건수', align : 'center', sortable : false, editable : false}, 
			{name : 'INSERT_CNT', label : '추가건수', align : 'center', sortable : false, editable : false}, 
			{name : 'CRTR_ID', label : '생성자아이디', align : 'center', sortable : false, editable : false}, 
			{name : 'CRT_DTTM', label : '생성일시', align : 'center', formatter:'date', formatoptions: {srcformat: 'U',newformat:'Y-m-d'}}, 
			{name : 'UPDR_ID', label : '수정아아이디', align : 'center', sortable : false, editable : false}, 
			{name : 'UPD_DTTM', label : '수정일시', align : 'center',  formatter:'date', formatoptions: {srcformat: 'U',newformat:'Y-m-d'}},
			{name : 'BATCH_RSLT_CD', label : '배치결과코드', align : 'center', sortable : false, editable : false},
			{name : 'BATCH_LOG_DETAIL', label : '배치로그 보기', align : 'center', formatter : batchLogDetailBtn}
		],
		initval:  {},										// 컬럼 add 시 초기값
	    editmode: false,								    // 그리드 editable 여부
	    gridtitle: '배치 목록',							    // 그리드명
	    multiselect: false,								    // checkbox 여부
	    formid: 'search',								    // 조회조건 form id
	    height: '200',									    // 그리드 높이
	    selecturl: '/psys/getPsys1032List',	            // 그리드 조회 URL
	    search: true,
	    caption : 'JSON Data',
	    emptyrecords: 'No URLs have been loaded for evaluation.',
	    events: { 
	    	gridComplete:function(data){
	    		 var tr ;
		            /* $("#batch_grid >tbody").append("<tr><td align='center' colspan='16'>검색 결과가 없습니다.</td></tr>"); */
		            /*
		            if(data.rows.length == 0){
		                $("#batch_grid >tbody").append("<tr><tdalign='center' colspan='15'>검색 결과가 없습니다.</td></tr>");
		            }*/
	    		/*
	    		 var objTable = document.getElementById("sample_table");
	    		   for(i=0; i<objTable.rows.length;i++){
	    		      for(j=0; j<objTable.rows[i].cells.length;j++){
	    		           alert(objTable.rows[i].cells[j].innerText);
	    		      }
	    		   }
	    	*/
	    	},
	    	loadComplete : function(data) {
	    		//alert("load");
	    	}
	    }
			
	}
	
	batch_grid = new UxGrid(batch_grid_config);
	batch_grid.init();
	
	batch_grid.setGridWidth($('.tblType1').width());
	aaa(batch_grid_config,"batch_grid");
    //"rows":
	
     var mydata2="";
        mydata2 = "{\"total\":1,\"records\":29,\"page\":1,\"rows\":[";
    	mydata2 += "{\"id\":\"1\",\"invdate\":\"2010-05-24\",\"name\":\"test\",\"note\":\"note\",\"tax\":\"10.00\",\"total\":\"2111.00\"}";
    //	mydata2 += "{id:\"2\",invdate:\"2010-05-25\",name:\"test2\",note:\"note2\",tax:\"20.00\",total:\"320.00\"},";
    //	mydata2 += "{id:\"3\",invdate:\"2007-09-01\",name:\"test3\",note:\"note3\",tax:\"30.00\",total:\"430.00\"}";
    	mydata2 += "]} ";
    
    	//console.log(mydata2);
    
    var jsonInfo = JSON.parse(mydata2);
  //  console.log(jsonInfo);
	

	var mydata = [
		{id:"1",invdate:"2010-05-24",name:"test",note:"note",tax:"10.00",total:"2111.00"} ,
		{id:"2",invdate:"2010-05-25",name:"test2",note:"note2",tax:"20.00",total:"320.00"},
		{id:"3",invdate:"2007-09-01",name:"test3",note:"note3",tax:"30.00",total:"430.00"},
		{id:"4",invdate:"2007-10-04",name:"test",note:"note",tax:"10.00",total:"210.00"},
		{id:"5",invdate:"2007-10-05",name:"test2",note:"note2",tax:"20.00",total:"320.00"},
		{id:"6",invdate:"2007-09-06",name:"test3",note:"note3",tax:"30.00",total:"430.00"},
		{id:"7",invdate:"2007-10-04",name:"test",note:"note",tax:"10.00",total:"210.00"},
		{id:"8",invdate:"2007-10-03",name:"test2",note:"note2",amount:"300.00",tax:"21.00",total:"320.00"},
		{id:"9",invdate:"2007-09-01",name:"test3",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"},
		{id:"11",invdate:"2007-10-01",name:"test",note:"note",amount:"200.00",tax:"10.00",total:"210.00"},
		{id:"12",invdate:"2007-10-02",name:"test2",note:"note2",amount:"300.00",tax:"20.00",total:"320.00"},
		{id:"13",invdate:"2007-09-01",name:"test3",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"},
		{id:"14",invdate:"2007-10-04",name:"test",note:"note",amount:"200.00",tax:"10.00",total:"210.00"},
		{id:"15",invdate:"2007-10-05",name:"test2",note:"note2",amount:"300.00",tax:"20.00",total:"320.00"},
		{id:"16",invdate:"2007-09-06",name:"test3",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"},
		{id:"17",invdate:"2007-10-04",name:"test",note:"note",amount:"200.00",tax:"10.00",total:"210.00"},
		{id:"18",invdate:"2007-10-03",name:"test2",note:"note2",amount:"300.00",tax:"20.00",total:"320.00"},
		{id:"19",invdate:"2007-09-01",name:"test3",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"},
		{id:"21",invdate:"2007-10-01",name:"test",note:"note",amount:"200.00",tax:"10.00",total:"210.00"},
		{id:"22",invdate:"2007-10-02",name:"test2",note:"note2",amount:"300.00",tax:"20.00",total:"320.00"},
		{id:"23",invdate:"2007-09-01",name:"test3",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"},
		{id:"24",invdate:"2007-10-04",name:"test",note:"note",amount:"200.00",tax:"10.00",total:"210.00"},
		{id:"25",invdate:"2007-10-05",name:"test2",note:"note2",amount:"300.00",tax:"20.00",total:"320.00"},
		{id:"26",invdate:"2007-09-06",name:"test3",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"},
		{id:"27",invdate:"2007-10-04",name:"test",note:"note",amount:"200.00",tax:"10.00",total:"210.00"},
		{id:"28",invdate:"2007-10-03",name:"test2",note:"note2",amount:"300.00",tax:"20.00",total:"320.00"},
		{id:"29",invdate:"2007-09-01",name:"test3",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"}
	]
	;

	var group_grid_config= {
		data: jsonInfo ,
		datatype: "local",
		height: 'auto',
		gridid : 'group_grid' ,
		pagerid : 'group_grid_pager' ,
		//rowNum: 30,
		rowList: [10,20,30],
		columns : [
			{name : 'id', label : 'id', align : 'center', sortable : false, editable : false, highlight:true},
			{name : 'invdate', label : 'invdate', align : 'center', sortable : false, editable : false}, 
			{name : 'name', label : 'name', align : 'center', sortable : false, editable : false}, 
			{name : 'amount', label : 'amount', align : 'center', sortable : false, editable : false}, 
			{name : 'tax', label : 'tax', align : 'center', sortable : false, editable : false}, 
			{name : 'total', label : 'total', align : 'center', sortable : false, editable : false},
			{name : 'note', label : 'note', align : 'center', sortable : false, editable : false},
		],
		initval:  {},										// 컬럼 add 시 초기값
	    editmode: false,								    // 그리드 editable 여부
	    gridtitle: '',							    // 그리드명
	    multiselect: false,								    // checkbox 여부
	    formid: 'search',								    // 조회조건 form id
	    height: '200',									    // 그리드 높이
		viewrecords: true,
		sortname: 'name',
		grouping: true,
		groupingView : {
			groupField : ['name']
		},
	//	caption: "Grouping Array Data"
		};
	
	group_grid = new UxGrid(group_grid_config);
	group_grid.init();
	//group_grid.addRowData(2,mydata,'last','after');
	

	
	
	
	$("#group_grid").jqGrid({
		data: mydata,
		datatype: "local",
		height: 'auto',
		rowNum: 30,
		rowList: [10,20,30],
		search: true,
	   	colNames:['Inv No','Date', 'Client', 'Amount','Tax','Total','Notes'],
	   	colModel:[
	   		{name:'id',index:'id', width:60, sorttype:"int"},
	   		{name:'invdate',index:'invdate', width:90, sorttype:"date", formatter:"date"},
	   		{name:'name',index:'name', width:100, editable:true},
	   		{name:'amount',index:'amount', width:80, align:"right",sorttype:"float", formatter:"number", editable:true},
	   		{name:'tax',index:'tax', width:80, align:"right",sorttype:"float", editable:true},		
	   		{name:'total',index:'total', width:80,align:"right",sorttype:"float"},		
	   		{name:'note',index:'note', width:150, sortable:false}		
	   	],
	   	pager: "#group_grid_pager",
	   	viewrecords: true,
	   	sortname: 'name',
	   	grouping:true,
	   	groupingView : {
	   		groupField : ['name']
	   	},
	   	caption: "Grouping Array Data",
	    loadComplete : function(data) {
	    		//alert("load");
	    	}
	});
	//$("#group_grid").jqGrid('searchGrid', {edit:false, add:false, del:false, search:this.search, refresh:false},{},{},{},{multipleSearch:true,showQuery: true} );
	
	$("#group_grid").jqGrid('navGrid', '#group_grid_pager', {	edit: false,  add: false,  del: false,  search: true,  refresh: true},
			{}, // edit options
{}, // add options
{}, // del options
{multipleSearch:true}
);
	
	//group_grid.setGridWidth($('.tblType1').width());
});

function aaa(grdConf,grdNm){
	/*
	 $(batch_grid).addcClass('ui-th-column1');
	.ui-jqgrid-labels ui-jqgrid .ui-jqgrid-labels th
	*/
	//$("#batch_grid .ui-jqgrid-labels ui-jqgrid .ui-jqgrid-labels th").removeClass('ui-th-column1');
	 //$("#batch_grid .ui-jqgrid-labels ui-jqgrid .ui-jqgrid-labels th").addClass('ui-th-column1');
    //console.log(grdConf.columns[0]);
    //batch_grid_BATCH_SEQ
   // console.log(grdNm);
    //$("#regTitle").html("Hello World");
    //var grdHtml = $("#"+grdNm).html()
    //console.log($("#"+grdNm).html());
    //var name_by_id = $(grdHtml).find('batch_grid_BATCH_SEQ');
    //console.log(name_by_id);
    //console.log($('#batch_grid_BATCH_SEQ').attr('class'));
    
    //$('#batch_grid_BATCH_SEQ').css('background','orange');
	for(var i = 0; i < grdConf.columns.length; i++) {
		var highlight = grdConf.columns[i].highlight;
		if(highlight != undefined && highlight!='undefined' && highlight==true){
		  var colNm =grdConf.columns[i].name;
		  /* $('#'+grdNm+'_'+colNm).css('background','orange'); */
		}
	}

}



//조회: 내부 로직 사용자 정의
function fn_Search(){
	batch_grid.retreive(); 
          
}

//jqgrid 내 버튼 생성
function batchLogDetailBtn (value, options, rowJson) {
	
	return "<button id='batchLogDetailBtn_" + options.rowId + "' onclick='fn_batchLogDetailBtn(" + options.rowId + ")' class='btn_common btn_default' style='float:center;'>로그 보기</button>";﻿﻿﻿﻿﻿
	
}

//jqgrid 내  formatter 버튼 클릭 이벤트 
function fn_batchLogDetailBtn (rowId) {
	
	var log_seq = $("#batch_grid").jqGrid('getCell', rowId, 'LOG_SEQ');
	
	
	bpopup({
		  url       :"/psys/forward.psys1032p001.adm"
		, params	: {log_seq : log_seq}
		, title		: "배치 로그 상세"                          
		, type		: "xml"
		, height	: "600px"
		, id        : "psys1032p1" 
	 });	
	
	
}

$(window).resize(function() {
	batch_grid.setGridWidth($('.tblType1').width());
	group_grid.setGridWidth($('.tblType1').width());
});

</script>

</head>
<body id="app">
	<div class="frameWrap">
	    <div class="subCon">
	    	<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
			<div class="frameTopTable">
		    	<form name="search" id="search" name="search" onsubmit="return false">
		            <table class="tblType1">
		            	<colgroup>
							<col style="width: 117px;" />
							<col style="" />
							<col style="width: 117px;" />
							<col style="" />
						</colgroup>  
			            <tr>
			            	<!-- 검색 조건 부분명 -->
			                <th>배치 번호</th>
			                <td>
			                    <span class="txt_pw"><input type="text" name="batch_seq" id="batch_seq" class="text" readonly="readonly" maxlength="12" onclick="this.value=''" /></span>
			                </td>
			                <th></th>
			                <td></td>        
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
	        </div>
			<div class="bgBorder"></div>
	    	<table id="batch_grid"></table> 
	        <div id="batch_grid_pager"></div>
	        
	        <table id="group_grid"></table> 
	        <div id="group_grid_pager"></div>
	        
    	</div>
   	</div>   
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
