<%--
   1. 파일명 : sample1012
   2. 파일설명: 대시보드
   3. 작성일 : 2019-07-15 
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jquery.jqplot.1.0/plugins/jqplot.canvasTextRenderer.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jquery.jqplot.1.0/plugins/jqplot.canvasAxisLabelRenderer.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jquery.jqplot.1.0/plugins/jqplot.cursor.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jquery.jqplot.1.0/plugins/jqplot.pointLabels.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jquery.jqplot.1.0/plugins/jqplot.highlighter.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jquery.jqplot.1.0/plugins/jqplot.dateAxisRenderer.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jquery.jqplot.1.0/plugins/jqplot.enhancedLegendRenderer.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jquery.jqplot.1.0/plugins/jqplot.barRenderer.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jquery.jqplot.1.0/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jquery.jqplot.1.0/plugins/jqplot.canvasAxisTickRenderer.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jquery.jqplot.1.0/plugins/jqplot.pieRenderer.js"></script>
<script type="text/javascript">

// 통계 그래프
var graph_buy_user_cnt;
var graph_buy_user_amt;
var graph_buy_user_age_cnt;
var graph_buy_user_age_amt;
var graph_buy_user_sex_cnt;
var graph_buy_user_sex_amt;

var value_visitor = [[0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0]];
var value_pageview = [[0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0]];

var graph_buy_user_cnt_cat = ["구매고객수(단위:천명)"];
var graph_buy_user_amt_cat = ["구매금액(단위:백만원)"];
var days3 = ["금년","전년"];
var age = [{label : '20대이하'}, {label : '30대'},{label:'40대'},{label:'50대'},{label:'60대이상'}];
var sex = [{label : '남성'}, {label : '여성'}];
var grid;


$(document).ready(function(){
	// 그리드 초기화 : 시스템 회원 목록
	var grid_config = {
		gridid	    : 'grid',
		pagerid	    : 'grid_pager',
		columns	    : [
			           {name : 'TEAM', label : '매입팀', align : 'left', sortable : false, editable : false},
			           {name : 'COL1', label : '금년', align : 'left', sortable : false, editable : false,formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' }},
			           {name : 'COL2', label : '전년', align : 'left', sortable : false, editable : false},
			           {name : 'COL3', label : '신장률', align : 'left', sortable : false, editable : false},
			           {name : 'COL4', label : '금년', align : 'left', sortable : false, editable : false},
			           {name : 'COL5', label : '전년', align : 'left', sortable : false, editable : false},
			           {name : 'COL6', label : '신장률', align : 'left', sortable : false, editable : false}],
		editmode	: false, 								// 그리드 editable 여부
		multiselect	: false, 								// checkbox 여부
		height		: 151,									// 그리드 높이
		formid		: 'search', 							// 조회조건 form id
		shrinkToFit	: true, 								// true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현
		selecturl	: '/sample/getTeamResultDataList', 			// 그리드 조회 URL
		footerrow   : true,
		events		: {
			gridComplete : function() {
				if($('#grid').jqGrid('getGridParam', 'records') > 0) {
					$('#grid').jqGrid('setGroupHeaders', {
						useColSpanStyle: true,
						
						groupHeaders:[

							{ startColumnName: 'COL1', numberOfColumns: 3, titleText: '구매고객 수' }
							, { startColumnName: 'COL4', numberOfColumns: 3, titleText: '구매금액' } 

						  ]

				    });
					

					var col1 = $('#grid').jqGrid("getCol", 'COL1', false, 'sum');
					var col2 = $('#grid').jqGrid("getCol", 'COL2', false, 'sum');
					var col3 = $('#grid').jqGrid("getCol", 'COL3', false, 'avg').toFixed(1);
					var col4 = $('#grid').jqGrid("getCol", 'COL4', false, 'sum');
					var col5 = $('#grid').jqGrid("getCol", 'COL5', false, 'sum');
					var col6 = $('#grid').jqGrid("getCol", 'COL6', false, 'avg').toFixed(1);
					
				    $("#grid").jqGrid('footerData','set' ,{"TEAM":"합계","COL1":col1,"COL2":col2,"COL3":col3,"COL4":col4,"COL5":col5,"COL6":col6});
				   /*  $("#grid").addRowData(undefined, {"team":"합계","col1":col1,"col2":col2,"col3":col3,"col4":col4,"col5":col5,"col6":col6}, 'before', 1); */
					
					
				}
			}
		}
	};
	grid = new UxGrid(grid_config);
	grid.init();
	//grid.addRowData(2, data,'last','after');
	
	grid.retreive();
	
	// 대시보드 방문자수/페이지뷰수 조회
//     ajax({
// 		url		: "/sample/selectVisitorPageviewCountList",
// 		success	: function(data){
			
// 			var list = data.mapList;
			
// 			 var num =1;
// 			for(i=0; i<7; i++)
// 			{
// 				var visr_cnBase = Math.floor((Math.random() * 1000) + 1); //Math.random();
// 				var visr_cnNowBase = Math.floor((Math.random() * 2000) + 1); //Math.random();
// 				//console.log("visr_cnBase==>"+ visr_cnBase);
// 				value_visitor[0][num - 1] = 100// ((i+1)) * visr_cnBase;
// 				value_pageview[0][num - 1] = 100; //( (i+1)) * visr_cnBase;
				
// 				value_visitor[1][num - 1] = 200// ((i+1)) * visr_cnNowBase;
// 				value_pageview[1][num - 1 - 1] =200//((i+1)) * visr_cnNowBase;
// 				num ++;
				
// 				/*
// 				if(list[i].wk_tp == "LAST")
// 				{
// 					console.log(list[i].visr_cnt);
// 					value_visitor[0][parseInt(list[i].day_of_week, 10) - 1] = ((i+1)) * visr_cnBase;
// 					value_pageview[0][parseInt(list[i].day_of_week, 10) - 1] = ( (i+1)) * visr_cnBase;
//         		}
// 				else if(list[i].wk_tp == "THIS")
// 				{
// 					value_visitor[1][parseInt(list[i].day_of_week, 10) - 1] = list[i].visr_cnt;
// 					value_pageview[1][parseInt(list[i].day_of_week, 10) - 1] = list[i].scrn_acs_cnt;
//         		}
// 				*/
// 			}
// 		}
// 	});
    
	var val_ = [[[30,1], [45,2]], [[20,1], [15,2]], [[25,1], [10,2]]];  // [2,1]  =>2: 그래프그려지는 부분 1:Y 축라벨 2,7,14: 차트 가로로 증가하는값
	// 연령대별 구성비 현황
	val_ =[[[15,1], [10,2]], [[20,1], [25,2]], [[15,1], [10,2]],[[25,1], [35,2]],[[25,1], [20,2]]];
	var val2_ =[[[30,1], [8,2]], [[30,1], [14,2]], [[10,1], [38,2]],[[10,1], [26,2]],[[20,1], [14,2]]];
	// 성별 구성비 현황
	var val3_ =[[[50,1], [10,2]], [[50,1], [90,2]]];
	var val4_ =[[[90,1], [15,2]], [[10,1], [85,2]]];
    var user_ag;
    
    // 고객매출 현황
    var legendOptions = {isLegend: false, labels:[{label : '전년'}, {label : '금년'}]}
	graph_buy_user_cnt = $.jqplot('graph_buy_user_cnt', value_visitor, fn_getChartConfig(graph_buy_user_cnt_cat, value_visitor, legendOptions));
    
    legendOptions.isLegend = true;
	graph_buy_user_amt = $.jqplot('graph_buy_user_amt', value_visitor, fn_getChartConfig(graph_buy_user_amt_cat, value_visitor, legendOptions));
	
	// 연령대별 구성비 현황
	legendOptions = {isLegend: true, labels:[{label:'20대이하'}, {label:'30대'}, {label:'40대'}, {label:'50대'}, {label:'60대 이상'}]}
	graph_buy_user_age_cnt = $.jqplot('graph_buy_user_age_cnt', val_, fn_getChartConfig2(days3, val_,age, legendOptions));
	
	legendOptions.isLegend = false;
	graph_buy_user_age_amt = $.jqplot('graph_buy_user_age_amt', val2_, fn_getChartConfig2(days3, val2_,age, legendOptions));
	
	// 성별 구성비 현황
	legendOptions = {isLegend: true, labels:[{label:'남성'}, {label:'여성'}]}
	graph_buy_user_age_cnt = $.jqplot('graph_buy_user_sex_cnt', val3_, fn_getChartConfig2(days3, val3_,age, legendOptions));
	
	legendOptions.isLegend = false;
	graph_buy_user_age_amt = $.jqplot('graph_buy_user_sex_amt', val4_, fn_getChartConfig2(days3, val4_,age, legendOptions));
	
	//graph_buy_user_amt = $.jqplot('graph_buy_user_amt', val_, fn_getChartConfig2(days3, val_));

	
	
	//graph_pageview_line = $.jqplot('graph_pageview_line', value_pageview, fn_getChartConfigLine(days, value_pageview));
	//graph_pie_info = $.jqplot('graph_pie_info', value_pageview, fn_getChartConfigPie(days, value_pageview));
	
	/* 
	    ajax({
		url		: "/content/selectTsysLogInfMnuList",
		success	: function(data){
			var list = data.mapList;
			graph_pie_info = data.mapList;
		}
	}); 
	*/
	
	$.jqplot ('graph_line', [[1,2,3,4,5,400,30]], {

		title : '그래프 제목옵션',
		axes: {
			xaxis: {
				label: "X 좌표제목"
			},

			yaxis: {
				label: "Y 좌표제목"
			}

		}

	});
	
	$.jqplot ('graph_pie', [[['첫번째', 50], ['두번째', 22], ['세번째', 38], ['네번째', 30]]], {

		seriesDefaults: {
			
			//원형으로 렌더링
			renderer: $.jqplot.PieRenderer,

			//원형상단에 값보여주기(알아서 %형으로 변환)
			rendererOptions: {
				showDataLabels: true

				}	

		},
		//우측 색상별 타이틀 출력
		legend: { 
			show:true, location: 'e' 
		}

	});
	

});

$(window).resize(function() {

});

function fn_getChartConfig(xAxis, value, legendOptions)
{
	var maxlast = value[0].reduce(function(a, b) {return Math.max(a, b);});
	var maxthis = value[1].reduce(function(a, b) {return Math.max(a, b);});
	var maxtot = Math.max(maxlast, maxthis) * 2;
	var chartConfig = {
		seriesDefaults : {
			pointLabels		: {show : false},
			renderer		: $.jqplot.BarRenderer,
			rendererOptions	: {fillToZero: true},
			markerOptions : {
				shadow: false
			},
			rendererOptions: {
                barPadding: 0,  //bar padding
                barMargin: 0      //bar간 간격                       
    		},
    		/*
    		pointLabels:{
		        show: true,
		      //  labels:['fourteen', 'thirty two', 'fourty one', 'fourty four', 'fourty'],
		        location:'s', 
		        ypadding:3
			}*/
		},

		grid: {
            drawBorder: false,
            background: '#fbfbfb',
            border:'0',
            drawGridLines:false,
            borderColor: '#fbfbfb',
            gridLineColor: '#fbfbfb',
            shadow: false
            // CSS color spec for background color of grid   
        },
       // title: '<div style="float:left;width:50%;text-align:center">Male</div><div style="float:right;width:50%;text-align:center">Female</div>',
       /*
		title:{
			text:'<div style="float:left;width:50%;text-align:center;">Male</div><div style="float:right;width:50%;text-align:center">Female</div>',  //타이틀텍스트 
		    show:true,           //타이틀표시여부
		    //fontFamily          //타이틀 폰트종류
		    //fontSize //폰트사이즈
		    textAlign: 'center',  //타이틀 텍스트 위치 left,right,center
		   // textColor //텍스트 컬러
		},*/
		series	: [{label : '전년'}, {label : '금년'},{label:'최초'}],
		axes	: {
			xaxis	: {
				renderer	: $.jqplot.CategoryAxisRenderer,
				ticks		: xAxis,
				tickRenderer: $.jqplot.CanvasAxisTickRenderer,
				showMark : false,
				pad: 0,
				tickOptions:{
			         showGridline: false
			    }
			},
			yaxis	: {
				min			: 0,
				max			: maxtot,
				pad			: 0,
				tickOptions : {
					//formatString:"%'d ",
					showMark :false,
					showGridline:false,
					show: false,
					showLabel:false
				},
				showTickMarks: false
			}
		},
	};
	
	if(legendOptions.isLegend) {
		chartConfig.legend = {
			renderer		: $.jqplot.EnhancedLegendRenderer,
			location		: 'ne',
			show			: true,
			placement		: 'inside',
		    xoffset         : -10, //x축, x2축에서 범례 영역까지의 거리
		     //yoffset //y축, y2축에서 범례 영역까지의 거리
		     rendererOptions: {
     			   numberRows: 1
    		}
		}
		chartConfig.series = legendOptions.labels;
	}
	return chartConfig;
}
function fn_getChartConfig2(xAxis, value,seriesLabel, legendOptions)
{
	var maxlast = value[0].reduce(function(a, b) {return Math.max(a, b);});
	var maxthis = value[1].reduce(function(a, b) {return Math.max(a, b);});
	var maxtot = Math.max(maxlast, maxthis) * 2;
	var chartConfig = { stackSeries: true,
            captureRightClick: true,
            seriesColors:['#FFCCE5', '#00749F', '#73C774', '#C7754C', '#17BDB8'],
            seriesDefaults:{
                renderer:$.jqplot.BarRenderer,
                shadowAngle: 135,
                markerOptions : {
    				shadow: false
    			},
                rendererOptions: {
                    barDirection: 'horizontal',
                    highlightMouseDown: true ,
                    barPadding: 20,  //bar padding
                    barMargin: 15      //bar간 간격 k
                },
                pointLabels: {show: true, formatString: '%.2f'}
            },
    		grid: {
                drawBorder: false,
                background: '#fbfbfb',
                border:'0',
                drawGridLines:false,
                borderColor: '#fbfbfb',
                gridLineColor: '#fbfbfb',
                shadow: false
            },
            axes: {
            	xaxis	: {
    				tickOptions : {
    					showMark :false,
    					showGridline:false,
    					show: false,
    					showLabel:false
    				}
    			},
            	yaxis: {
                    renderer: $.jqplot.CategoryAxisRenderer,
                    ticks		: xAxis,
    				tickRenderer: $.jqplot.CanvasAxisTickRenderer,
    				showMark : false,
    				pad: 0,
    				showGridline:false,
                }
            }
	};
	if(legendOptions.isLegend) {
		chartConfig.legend = {
			renderer		: $.jqplot.EnhancedLegendRenderer,
			location		: 'ne',
			show			: true,
			placement		: 'inside',
		    xoffset         : -10, //x축, x2축에서 범례 영역까지의 거리
		     //yoffset //y축, y2축에서 범례 영역까지의 거리
		      rendererOptions: {
     			   numberRows: 1
    		}
		}
		chartConfig.series = legendOptions.labels;
	}
	return chartConfig;
}
//로딩 이후 CSS 적용
window.onload = function() {
	$("#chart2").find("table.jqplot-table-legend").css("top", "-28px");
	$("#chart4").find("table.jqplot-table-legend").css("top", "-28px");
	$("#chart1").find("table.jqplot-table-legend").css("top", "0px");
	$("#chart6").find("table.jqplot-table-legend").css("top", "-35px");
	
	$("#grid").find("td[role='gridcell']").each(function(){
		if (isNum($(this).text())) {
			$(this).text(addCommaStr($(this).text()));
		}
	});
}
//숫자문자열 > 콤마 추가
function addCommaStr(str) {
	var num = "";
	var sign = "";

	if (str.charAt(0) == "+" || str.charAt(0) == "-") {
		sign = str.charAt(0);
		str = str.substr(1);
	}

	var index = str.indexOf('.');

	if (index != -1) {
		num = str.substr(index);
	} else {
		index = str.length;
	}

	for (var i = index - 3; i > 0; ) {
		num = ',' + str.substr(i, 3) + num;

		index = i;
		i -= 3;
	}

	num = sign + str.substr(0, index) + num;

	return	num;
}

</script>
<style>
	.table_margin {margin:20px 10px;}
</style>
<style type="text/css">
#graph_buy_user_age_cnt ,#graph_buy_user_age_amt, #graph_buy_user_sex_cnt, #graph_buy_user_sex_amt  .jqplot-point-label {
	color: #000 ;
	font-weight:600;
	font-size:13px;
}
#graph_buy_user_age_cnt ,#graph_buy_user_age_amt, #graph_buy_user_sex_cnt, #graph_buy_user_sex_amt  .td {
	color: black ;
}
.tblType4{margin:0 !important;}
</style>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
			<h1><%=_title%></h1>
			<!-- st -->
		 <table class="tblType4 w47">
		 <tr>
		 	<td colspan="2">
		 	<span>고객매출 현황</span>
		 	</td>
		 </tr>
		 <tr>
		 <td>
		 <table class="tblType4" style="border:none;">
            <tr style="border:none;">
            	<td style="border:none;position:relative;">
            		<div style="color:#666;font-weight:600;position:absolute;z-index:10; top:30%; left:50%;  transform:translate(-50%, -50%);">신장률:100%</div>
            		<div id="graph_buy_user_cnt" style="width:100%;"></div>
            	</td>
            </tr>
         </table>
         </td>
         <td>
         <table id="chart1" class="tblType4" style="border:none;">
            <tr style="border:none;">
            	<td style="border:none;position:relative;">
            		<div style="color:#666;font-weight:600;position:absolute;z-index:10; top:30%; left:50%;  transform:translate(-50%, -50%);">신장률:100%</div>
            		<div id="graph_buy_user_amt" style="width:100%;"></div>
            	</td>
            </tr>
         </table>
         </td>
         </tr>
         </table>
         
          <table class="tblType4 w47">
		 <tr>
		 	<td>
		 	<span>연령대별 구성비 현황 (%)</span>
		 	</td>
		 </tr>
		 <tr style="border:none;">
		 <td id="chart2" style="padding-top:40px !important;position:relative;">
		 <div style="color:#666;font-weight:600;position:absolute;z-index:10; top:15%; left:6%;  transform:translate(-50%, -50%);">구매고객 수</div>
            <div id="graph_buy_user_age_cnt" style="width: 100%; height:123px;">
            </div>
            </td>
            </tr>
          <tr>
		 <td style="padding-top:24px !important;position:relative;">
		 <div style="color:#666;font-weight:600;position:absolute;z-index:10; top:15%; left:6%;  transform:translate(-50%, -50%);">구매금액</div>
            <div id="graph_buy_user_age_amt" style="width: 100%; height:123px;">
            </div>
            </td>
            </tr>
         </table>
         <table style="border-top:none;width:781px;float:left;">
            <tr>
		 	<td style="padding: 10px 10px !important;border-left: 1px solid #ccc;">
		 	<span>팀별 실적 현황</span>
		 	</td>
		 </tr>
            <tr>
            	<td style="padding: 10px 10px !important;border-left: 1px solid #ccc;border-bottom: 1px solid #ccc;">
                     <table id="grid"></table>
					<div id="grid_pager"></div>	
            	</td>
           	</tr>
      	  	<tr>
	         	<td>
	           		<div id="graph_line" style="width:300px; height:300px;"></div>
	           	</td>
	         </tr>

         </table>
         
         
         
         <table class="tblType4 w47" style="border:none;;">
			 <tr>
			 	<td>
			 	<span>성별 구성비 현황 (%)</span>
			 	</td>
			 </tr>
			 <tr style="border:none;">
			 <td id="chart6" style="padding-top:40px !important;position:relative;">
			 <div style="color:#666;font-weight:600;position:absolute;z-index:10; top:15%; left:6%;  transform:translate(-50%, -50%);">구매고객 수</div>
	            <div id="graph_buy_user_sex_cnt" style="width: 100%; height:123px;">
	            </div>
	            </td>
	            </tr>
	         <tr>
			 	<td style="padding-top:24px !important;position:relative;">
			 		<div style="color:#666;font-weight:600;position:absolute;z-index:10; top:15%; left:6%;  transform:translate(-50%, -50%);">구매금액</div>
	           		<div id="graph_buy_user_sex_amt" style="width: 100%; height:123px;"></div>
	            </td>
	         </tr>
      	  	<tr>
	         	<td>
	           		<div id="graph_pie" style="width:300px; height:300px;"></div>
	           	</td>
	         </tr>
         </table>
         
			<!--  ed  -->
			
		<!-- line chart  -->
		
		
			
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
