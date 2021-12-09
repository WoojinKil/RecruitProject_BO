<%--
   1. 파일명 : accessStatistics
   2. 파일설명: 대시보드
   3. 작성일 : 2017-12-28 최초작성
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

var graph_buy_user_cnt_cat = ["구매고객수"];
var graph_buy_user_amt_cat = ["구매금액"];
var days3 = ["금년","전년"];
var age = [{label : '20대이하'}, {label : '30대'},{label:'40대'},{label:'50대'},{label:'60대이상'}];
var sex = [{label : '남성'}, {label : '여성'}];


$(document).ready(function(){
	// 대시보드 방문자수/페이지뷰수 조회
    ajax({
		url		: "/content/selectVisitorPageviewCountList",
		success	: function(data){
			
			var list = data.mapList;
			
			 var num =1;
			for(i=0; i<7; i++)
			{
				var visr_cnBase = Math.floor((Math.random() * 1000) + 1); //Math.random();
				var visr_cnNowBase = Math.floor((Math.random() * 2000) + 1); //Math.random();
				//console.log("visr_cnBase==>"+ visr_cnBase);
				value_visitor[0][num - 1] = Math.floor((Math.random() * 1000) + 1);// ((i+1)) * visr_cnBase;
				value_pageview[0][num - 1] = Math.floor((Math.random() * 2000) + 1); //( (i+1)) * visr_cnBase;
				
				value_visitor[1][num - 1] = Math.floor((Math.random() * 2000) + 1)// ((i+1)) * visr_cnNowBase;
				value_pageview[1][num - 1 - 1] = Math.floor((Math.random() * 1000) + 1)//((i+1)) * visr_cnNowBase;
				num ++;
				
				/*
				if(list[i].wk_tp == "LAST")
				{
					console.log(list[i].visr_cnt);
					value_visitor[0][parseInt(list[i].day_of_week, 10) - 1] = ((i+1)) * visr_cnBase;
					value_pageview[0][parseInt(list[i].day_of_week, 10) - 1] = ( (i+1)) * visr_cnBase;
        		}
				else if(list[i].wk_tp == "THIS")
				{
					value_visitor[1][parseInt(list[i].day_of_week, 10) - 1] = list[i].visr_cnt;
					value_pageview[1][parseInt(list[i].day_of_week, 10) - 1] = list[i].scrn_acs_cnt;
        		}
				*/
			}
		}
	});
    
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
            background: '#ffffff',
            border:'0',
            drawGridLines:false,
            borderColor: '#ffffff',
            gridLineColor: '#ffffff',
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
                background: '#ffffff',
                border:'0',
                drawGridLines:false,
                borderColor: '#ffffff',
                gridLineColor: '#ffffff',
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
		}
		chartConfig.series = legendOptions.labels;
	}
	return chartConfig;
}

</script>
<style>
	.table_margin {margin:20px 10px;}
</style>
<style type="text/css">
#graph_buy_user_age_cnt ,#graph_buy_user_age_amt, #graph_buy_user_sex_cnt, #graph_buy_user_sex_amt  .jqplot-point-label {
	color: #ffffff ;
	font-size:14px;
}
#graph_buy_user_age_cnt ,#graph_buy_user_age_amt, #graph_buy_user_sex_cnt, #graph_buy_user_sex_amt  .td {
	color: black ;
}
</style>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
			<h1><%=_title%></h1>
			
			<table style="width:20%;float:left;" border ="0">
				<colgroup>
					<col width="80%" />
					<col width="20%" />
				</colgroup>
				<tr>
					<td colspan="2" align="left">고객매출현황</td>
				</tr>
				<tr>
					<td colspan="2"><div id="graph_buy_user_cnt" style="width: 100%;height:300px;"></div></td>
				</tr>
			</table>
			<table style="width:20%; float:left" border ="0px">
				<colgroup>
					<col width="80%" />
					<col width="20%" />
				</colgroup>
				<tr>
					<td colspan="2" align="left">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2"><div id="graph_buy_user_amt" style="width: 100%;height:300px;"></div></td>
				</tr>
			</table>
			<div style="width:55%;float:left">
				<table style="width:90%;height:100px;" border ="1">
					<colgroup>
						<col width="80%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td colspan="2"><div id="graph_buy_user_age_cnt" style="width: 100%;height:150px;"></div></td>
					</tr>
				</table>
				<table style="width:90%;" border ="1">
					<colgroup>
						<col width="80%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td colspan="2"><div id="graph_buy_user_age_amt" style="width: 100%;height:150px;"></div></td>
					</tr>
				</table>
			</div>
			<div style="width:40%;float:left:background:blue; height:300px;">
			<table style="width:95%;" border="1">
				<colgroup>
					<col width="80%" />
					<col width="20%" />
				</colgroup>
				<tr>
					<th>백오피스메뉴별 접속이력</th>
					<th><a style="color: black;" id="research_more" href="javascript:addTabInFrame('/system/forward.accessStatistics.adm');">+ 더보기</a></th>
				</tr>
				<tr>
					<td colspan="2"><div id="graph_pie_info" style="width: 100%;"></div></td>
				</tr>
			</table>
			</div>
			<div style="width:55%;float:left;">
				<table style="width:90%;height:100px;" border ="1">
					<colgroup>
						<col width="80%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td colspan="2"><div id="graph_buy_user_sex_cnt" style="width: 100%;height:150px;"></div></td>
					</tr>
				</table>
				<table style="width:90%;" border ="1">
					<colgroup>
						<col width="80%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td colspan="2"><div id="graph_buy_user_sex_amt" style="width: 100%;height:150px;"></div></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
