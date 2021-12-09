<%--
   1. 파일명 : bpcm2008
   2. 파일설명 : 인사이트레포트
   3. 작성일 : 2020-02-10
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<!-- 헤더파일 include -->
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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jquery.jqplot.1.0/plugins/jqplot.donutRenderer.js"></script>


<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>


<script type="text/javascript">

<%
Date nowTime = new Date();
SimpleDateFormat sfyyyyMMdd = new SimpleDateFormat("yyyyMMdd");
SimpleDateFormat sfyyyy = new SimpleDateFormat("yyyy");
SimpleDateFormat sfMM = new SimpleDateFormat("MM");
SimpleDateFormat sfdd = new SimpleDateFormat("dd");
%>

var toDay = '<%= sfyyyyMMdd.format(nowTime) %>';  /*현재일자 yyyymmdd*/
var toDay_yyyy = '<%= sfyyyy.format(nowTime) %>'; /*현재일자 yyyy*/
var toDay_MM = '<%= sfMM.format(nowTime) %>';     /*현재일자 mm*/
var toDay_dd = '<%= sfdd.format(nowTime) %>';     /*현재일자 mm*/
var html = "";
var cndToDay = getDate(toDay,0,-1,0,'');

//사용자정보 조회(사용자자점브랜드매장조건, tb_bpcm_usprcstrbrndshopcndt_m)
var cstr_cd = "";
var shop_flr_cd = "";
var shop_pc_cd = "";
var brnd_cd = "";

//조회조건
var yyyy_mm = "";
var std_ym = "";
var lyy_sam_ym = "";
var bef_ym = "";

var on_off_cl_cd = "";

//글로벌변수
var off_slng = 0;
var first_search_flag = false;

//차트
var graph_age, graph_pay, graph_donut, graph_donut_2, graph_days, graph_donut_3;
var value_visitor = [[0, 0, 0, 0, 0, 0, 0]],
    value_visitor_2 = [[0, 0, 0, 0]],
    value_visitor_3 = [[0, 0, 0, 0, 0, 0, 0]];

var ages = ["10대이하", "20대", "30대", "40대", "50대", "60대" ,"70대이상"],
    type_pay = ["자사카드", "타사카드", "상품권", "현금"],
    real_days = ["일", "토", "금", "목", "수", "화", "월"],
    similar_brands = ["에스티로더", "슈에무라", "메이크업포에버", "디올", "맥"],
    interest_brands = ["타임", "보그너", "골든듀", "마인드브릿지", "나이키"];

var jqplot_data_sales_summary = [[0,0,0,0,0,0,0,0,0,0,0,0]];        // 하이라이트 매출요약 그래프
var jqplot_data_cust_age = [[4, 10, 10, 12, 14, 25, 20]];         // 고객 특성 - 성별 및 연령대 매출 비중
var jqplot_data_cust_exgrd = [['AVENUEL', 0], ['MVG', 0], ['일반', 0], ['VIP', 0]];                 // 고객 특성 - 고객등급별 구성비
var jqplot_data_cust_fan = [['FAN 고객', 0], ['일반 고객', 0]];       // 고객 특성 - FAN 고객 구성비
var jqplot_data_cust_day = [[10, 20, 30, 40, 50, 25, 20]];                 // 구매 특성 - 요일별 매출 비중
var jqplot_data_cust_3 = [[0, 0, 0, 0, 0, 0, 0]];                 // 구매 특성 - 시간별 매출 비중
var jqplot_data_cust_pay = [[0, 0, 0, 0, 0, 0, 0]];                 // 구매 특성 - 결제수단별 이용 비중

var intRateArr = [[0,0,0,0,0,0,0,0,0,0,0,0]];
var ageAmtArr = [];
var daywArr = [];
var tmsltArr = [];
var sColor = [];
var stlmMnsArr = [];

$(document).ready(function() {
	
	document.addEventListener('keydown', function(event) {
	    if (event.keyCode === 13) {
	        event.preventDefault();
	    }
	}, true);
	
	$("#tab-" + _menu_id, parent.document).attr("onload", "");
	
	qplot_data_sales_summary = [[0,0,0,0,0,0,0,0,0,0,0,0]];
	$.jqplot ('graph_line', jqplot_data_sales_summary, fn_getLineConfig1(false,intRateArr));          // 하이라이트 매출요약 그래프
	graph_age = $.jqplot('graph_age', jqplot_data_cust_age, fn_getChartConfig(ages,[])); // 고객 특성 - 성별 및 연령대 매출 비중
	graph_pay = $.jqplot('graph_pay', value_visitor_2, fn_getChartConfig_2(type_pay, []));
	graph_days = $.jqplot('graph_days', jqplot_data_cust_day, fn_getChartConfig_3(real_days));

	$('#graph_donut, #graph_donut_2, #graph_donut_3').html("");
	graph_donut = $.jqplot('graph_donut', [jqplot_data_cust_fan], getDonutChart(jqplot_data_cust_fan,[]));           // 고객 특성 - FAN 고객 구성비
	graph_donut_2 = $.jqplot('graph_donut_2', [jqplot_data_cust_exgrd], getDonutChart_2(jqplot_data_cust_exgrd));

	var donutChartData_3 = [['11시', 10], ['11시', 10], ['11시', 10], ['13시', 10], ['14시', 10], ['15시', 10], ['16시', 10], ['17시', 10], ['18시', 10], ['19시', 10], ['20시', 10], ['21시', 10], ['21시', 10], ['21시', 10], ['21시', 10], ['21시', 10], ['21시', 10], ['21시', 10], ['21시', 10], ['21시', 10]];
	graph_donut_3 = $.jqplot('graph_donut_3', [donutChartData_3], getDonutChart_3(donutChartData_3));

 	/* 차트 */
/*	var maxIndex = $(".graph_bar_list_1 li.graph_bar").length;

	for(var i=0; i<maxIndex; i++){
		var val = $(".graph_bar_list_1 li.graph_bar").eq(i).find(".list_percent").attr('data-graph-width');
		var percent_text = $(".graph_bar_list_1 li.graph_bar").eq(i).find(".percent_text");

		$(".graph_bar_list_1 li.graph_bar").eq(i).find(".list_percent").css("width", val+"%");

		percent_text.text(val + "%");
	} */

	/* 차트2 */
/* 	var maxIndex2 = $(".graph_bar_list_2 li.graph_bar").length;
	for(var i=0; i<maxIndex2; i++){
		var val = $(".graph_bar_list_2 li.graph_bar").eq(i).find(".list_percent").attr('data-graph-width');
		var percent_text = $(".graph_bar_list_2 li.graph_bar").eq(i).find(".percent_text");

		$(".graph_bar_list_2 li.graph_bar").eq(i).find(".list_percent").css("width", val+"%");

		percent_text.text(val + "%")
	} */

	var line_data = {
			xaxis : [[1,2,3,4,5,6,7,8,9,10,11,12]],
			yaxis : [["80백만원", "85백만원", "90백만원"]]
	}
	//$.jqplot.config.enablePlugins = true;
	
	// 조회기간 디폴트 셋팅
	setSearchCndt();

	fn_changeYear();
	$("#month_cd").val(cndToDay.substr(4,2)).prop("selected", true);
	$("input:radio[name='on_off_cl_cd']:radio[value='1']").prop('checked', true);
	
	$("#cstr_cd").val(cstr_cd);
	$("#brnd_cd").val(brnd_cd);
	
	//기준일 참조
	loading_start(getStdYm);
	
	
});

$(window).on("load", function() {
	$(".slide_area").slideUp();
	$(".toggle_btn").removeClass("on");
});

//그리드 리사이징
$(window).resize(function() {
	$('#graph_age').empty();
	$('#graph_pay').empty();
	$('#graph_days').empty();

	graph_age = $.jqplot('graph_age', jqplot_data_cust_age, fn_getChartConfig(ages,ageAmtArr));
	graph_pay = $.jqplot('graph_pay', jqplot_data_cust_pay, fn_getChartConfig_2(type_pay,stlmMnsArr));
	graph_days = $.jqplot('graph_days', jqplot_data_cust_day, fn_getChartConfig_3(real_days,sColor,daywArr));
});

//조회버튼 클릭
function fn_Search(){
	
	yyyy_mm = $('#year_cd').val() + $('#month_cd').val();
	on_off_cl_cd = $('input[name="on_off_cl_cd"]:checked').val();

	if(validation_check()){
		return;
	}
	
	first_search_flag = true;
	
	if(on_off_cl_cd=="1"){
		$('#onOffTp').text("오프라인"); //1:오프라인
	} else {
		$('#onOffTp').text("온라인");  //2:온라인
	}

	//1. 매출요약 그래프조회
	loading_start(getHighlightSalesSummary);

	//2. 총매출실적/오프라인(조회기준) 매출실적
	loading_start(getHighlightAllSalesOff);

	//3. 회원/비회원
	loading_start(getHighlightCust);
	
	//getCustInfo();     //고객특성
	//getPurchaseInfo(); //구매특성
	
	$(".slide_area").slideUp();
	$(".toggle_btn").removeClass("on");
}

function bpn_toFixed(a,digit){
    if(digit == null) digit = 1;
    return (Math.round(a*10)/10).toFixed(digit*1);
}

//점팝업
function fn_cstrPop(){
	bpopup({
		  url       :"/bpcm/forward.bpcm2008p001.adm"
		, params	: {callback : "fn_callback001", target_id : _menu_id}
		, title		: "점목록"
		, type		: "1"
		, height	: "500px"
		, width     : "500px"
		, id        : "bpcm2008p1"
	 });

}

//내매세지불러오기 콜백함수
function fn_callback001(rows){
	
	cstr_cd = rows[0].CSTR_CD;
	var cstr_nm = rows[0].CSTR_NM;
	$('#cstr_cd').val(cstr_cd);
	$('#cstr_nm').val(cstr_cd + " | " + cstr_nm);
	
	brnd_cd = "";
	$('#brnd_cd').val(brnd_cd);	
	$('#brnd_nm').val("");	
}

//브랜드팝업
function fn_brndPop(){
	
	if($('#cstr_cd').val()==""){
		alert('<%=MessageUtil.getMsg("MSG.CMPGN.ALERT.000054")%>'); //점을 선택해주세요.
		return;
	}
	
	bpopup({
		  url       :"/bpcm/forward.bpcm2008p002.adm"
		, params	: {callback : "fn_callback002", target_id : _menu_id, cstr_cd : cstr_cd}
		, title		: "브랜드목록"
		, type		: "1"
		, height	: "600px"
		, width     : "500px"
		, id        : "bpcm2008p1"
	 });

}

//내매세지불러오기 콜백함수
function fn_callback002(rows){
	brnd_cd = rows[0].BRND_CD;
	$('#brnd_cd').val(brnd_cd);
	var brnd_nm = rows[0].BRND_NM;
	$('#brnd_nm').val(brnd_cd+" | " + brnd_nm);
}

//1. 매출요약 그래프조회
function getHighlightSalesSummary(){

	var intBrndArr = [];
	var intZoneArr = [];
	var intBrndRateArr = [];
	var intZoneRateArr = [];

	var brndSlng = 0;
	var zoneSlng = 0;

	var highlight_text12 = 0;
	var highlight_text13 = 0;

	//신장률
	var maxYoyRate = 0;
	var maxYoyMonth = 0;
	var minYoyRate = 0;
	var minYoyMonth = 0;

	var brndSlngArr = [];
	var zoneSlngArr = [];
	var momBrndRateArr = [];
	var momZoneRateArr = [];
	
	var month = "";
	var monthStr = "";
	ajax({
		url 	: "/bpcm/bpcm2008getHighlightSalesSummary",
		type    : 'POST',
		data    : { yyyyMm : yyyy_mm,
			        onOffClCd : on_off_cl_cd,
			        cstrCd : cstr_cd,
			        brndCd : brnd_cd,
		},
		success : function (data) {
			if (data.RESULT == "S") {
				$(data.rows).each(function (index) {
					brndSlngArr = [];
					zoneSlngArr = [];
					momBrndRateArr = [];
					momZoneRateArr = [];
					
					brndSlng = parseInt(this.TYM_BRND_GS_SLNG_AMT)/1000000;
					zoneSlng = parseInt(this.TYM_ZONE_GS_SLNG_AMT)/1000000;

					month = parseInt(this.STD_YM.substr(4, 2));

					brndSlngArr.push(month+"월");
					brndSlngArr.push(brndSlng);
					intBrndArr.push(brndSlngArr);

					zoneSlngArr.push(month+"월");
					zoneSlngArr.push(zoneSlng);
					intZoneArr.push(zoneSlngArr);
					
					momBrndRateArr.push(month+"월");
					momBrndRateArr.push(this.YOY_BRND_RATE);
					intBrndRateArr.push(momBrndRateArr);

					momZoneRateArr.push(month+"월");
					momZoneRateArr.push(this.YOY_ZONE_RATE);
					intZoneRateArr.push(momZoneRateArr);

					// 하이라이트 요약 두번째줄 : 당해연도 매출액
					if(this.BRND_SLNG_AMT_SEQ==1){
						$('#highlight_text4').text(numberWithCommas(bpn_toFixed(brndSlng,0)) + "백만원");
						$('#highlight_text5').text(month + "월");
					}
					if(this.BRND_SLNG_AMT_SEQ==12){
						$('#highlight_text6').text(numberWithCommas(bpn_toFixed(brndSlng,0)) + "백만원");
						$('#highlight_text7').text(month + "월");
					}

					// 하이라이트 요약 세번째줄 : 당해연도 신장률
					if(this.YOY_BRND_RATE_SEQ==1){
						$('#highlight_text8').text(this.YOY_BRND_RATE + "%");
						$('#highlight_text9').text(month + "월");
					}
					if(this.YOY_BRND_RATE_SEQ==12){
						$('#highlight_text10').text(this.YOY_BRND_RATE + "%");
						$('#highlight_text11').text(month + "월");
					}

					if(this.STD_YM == yyyy_mm){
						//동일 상품군 평균 대비 매출액은 ▲0.4백만원 낮고, 신장률은 +0.1% 높습니다.
						highlight_text12 = zoneSlng - brndSlng;
						if(highlight_text12 > 0){
							$('#highlight_text12').addClass("down");
							$('#highlight_text12').text(numberWithCommas("▲"+ bpn_toFixed(highlight_text12,0) + "백만원 낮고"));
						} else {
							highlight_text12 = (zoneSlng - brndSlng) * -1;
							$('#highlight_text12').removeClass("down");
							$('#highlight_text12').text(numberWithCommas("+"+ bpn_toFixed(highlight_text12,0) + "백만원 높고"));
						}

						highlight_text13 = this.YOY_ZONE_RATE - this.YOY_BRND_RATE;
						if(highlight_text13 > 0){
							$('#highlight_text13').addClass("down");
							$('#highlight_text13').text(numberWithCommas("▲"+ bpn_toFixed(highlight_text13,1) + "%p 낮습니다."));
						} else {
							highlight_text13 = (this.YOY_ZONE_RATE - this.YOY_BRND_RATE) * -1;
							$('#highlight_text13').removeClass("down");
							$('#highlight_text13').text(numberWithCommas(bpn_toFixed(highlight_text13,1) + "%p 높습니다."));
						}
					}
				});
				jqplot_data_sales_summary = [intBrndArr, intZoneArr];
				
				intRateArr = [intBrndRateArr,intZoneRateArr];

				$('#graph_line').html("");
				$.jqplot ('graph_line', jqplot_data_sales_summary, fn_getLineConfig1(true,intRateArr));


			}
		}
		,complete: function() {setTimeout(function(){loading_end();});}
	});
}

//2. 총매출실적/오프라인(조회기준) 매출실적
function getHighlightAllSalesOff(){

	var all_slng_12 = 0;
	var all_slng_13 = 0;
	var all_slng_22 = 0;
	var all_slng_23 = 0;
	var all_slng_32 = 0;
	var all_slng_33 = 0;
	var all_slng_42 = 0;
	var all_slng_43 = 0;

	var off_slng_12 = 0;
	var off_slng_13 = 0;
	var off_slng_22 = 0;
	var off_slng_23 = 0;
	var off_slng_32 = 0;
	var off_slng_33 = 0;
	var off_slng_42 = 0;
	var off_slng_43 = 0;

	var monthCd = parseInt($('#month_cd').val());

	ajax({
		url 	: "/bpcm/bpcm2008getHighlightAllSalesOff",
		type    : 'POST',
		data    : { yyyyMm : yyyy_mm,
			        onOffClCd : on_off_cl_cd,
			        cstrCd : cstr_cd,
			        brndCd : brnd_cd,
		},
		success : function (data) {
			if (data.RESULT == "S") {
				$(data.rows).each(function (index) {

					// 총매충실적 -------------------------------------------------
/*
					2. 총매출실적/오프라인(조회기준) 매출실적
					 총매출실적
					 - 11월 => 조회월brnd총매출(tot_tym_brnd_gs_slng_amt), 연누계 => 년누계brnd총매출(tot_tyy_brnd_gs_slng_amt)
					 - ZONE구성비 => 100.0 * 조회월brnd총매출(tot_tym_brnd_gs_slng_amt) / 조회월zone총매출(tot_tym_zone_gs_slng_amt) ,
					               전체 => 조회월zone총매출
					 - 전년동월대비 => 조회월brnd총매출(tot_tym_brnd_gs_slng_amt) - 전년동월brnd총매출(tot_lym_brnd_gs_slng_amt),
					                비율 => 100.0 * (조회월brnd총매출 - 전년동월brnd총매출)/전년동월brnd총매출
					 - 전월대비    => 조회월brnd총매출 - 조회전월brnd총매출,
					              비율 => 100.0 * (조회월brnd총매출 - 조회전월brnd총매출)/조회전월brnd총매출
					 오프라인매출실적
					 - 11월 => onOff조회월brnd총매출, 연누계 => onOff년누계brnd총매출
					 - ZONE구성비 => 100.0 * onOff조회월brnd총매출 / onOff조회월zone총매출 , 전체 => onOff조회월zone총매출
					 - 전년동월대비 => onOff조회월brnd총매출 - onOff전년동월brnd총매출, 비율 => 100.0 * (onOff조회월brnd총매출 - onOff전년동월brnd총매출)/onOff전년동월brnd총매출
					 - 전월대비    => onOff조회월brnd총매출 - onOff조회전월brnd총매출, 비율 => 100.0 * (onOff조회월brnd총매출 - onOff조회전월brnd총매출)/onOff조회전월brnd총매출
*/

					all_slng_12 = this.TOT_TYM_BRND_GS_SLNG_AMT/1000000;
					all_slng_13 = this.TOT_TYY_BRND_GS_SLNG_AMT/1000000;

					if(this.TOT_TYM_ZONE_GS_SLNG_AMT != 0){
						all_slng_22 = this.TOT_TYM_BRND_GS_SLNG_AMT / this.TOT_TYM_ZONE_GS_SLNG_AMT * 100;
					}
					all_slng_23 = this.TOT_TYM_ZONE_GS_SLNG_AMT/1000000;
					all_slng_32 = (this.TOT_TYM_BRND_GS_SLNG_AMT - this.TOT_LYM_BRND_GS_SLNG_AMT) /1000000;
					if(this.TOT_LYM_BRND_GS_SLNG_AMT != 0){
						all_slng_33 = (this.TOT_TYM_BRND_GS_SLNG_AMT - this.TOT_LYM_BRND_GS_SLNG_AMT) / this.TOT_LYM_BRND_GS_SLNG_AMT * 100;
					}
					all_slng_42 = (this.TOT_TYM_BRND_GS_SLNG_AMT - this.TOT_TLM_BRND_GS_SLNG_AMT) /1000000;
					if(this.TOT_TLM_BRND_GS_SLNG_AMT != 0){
						all_slng_43 = (this.TOT_TYM_BRND_GS_SLNG_AMT - this.TOT_TLM_BRND_GS_SLNG_AMT) / this.TOT_TLM_BRND_GS_SLNG_AMT * 100;
					}

					//당월
					$('#all_sales_11').text(monthCd + "월");  //11월
					$('#all_sales_12').text(numberWithCommas(bpn_toFixed(all_slng_12,0)) + "백만원");  //100.2백만원
					$('#all_sales_13').text("년누계 " + numberWithCommas(bpn_toFixed(all_slng_13,0)) + "백만원");     //년누계 1,082.1 백만원
					//PC구성비
					$('#all_sales_22').text(numberWithCommas(bpn_toFixed(all_slng_22,1)) + "%"); //7.8%
					$('#all_sales_23').text("전체 " + numberWithCommas(bpn_toFixed(all_slng_23,0)) + "백만원"); //전체 1,284.7 백만원
					
					//전년동월대비
 					if(parseInt(all_slng_32) >= 0){
						$('#span_all_sales_32').removeClass("type_down");
						$('#all_sales_32').text("+" + numberWithCommas(bpn_toFixed(all_slng_32,0)) + "백만원"); 	//0.2백만원
					} else {
						$('#span_all_sales_32').addClass("type_down");
						all_slng_32 = all_slng_32 * -1;
						$('#all_sales_32').text(numberWithCommas(bpn_toFixed(all_slng_32,0)) + "백만원"); 	//0.2백만원
						all_slng_32 = all_slng_32 * -1;
					}
					if(parseInt(all_slng_33) >= 0){
						$('#all_sales_33').removeClass("type_down");
						$('#all_sales_33').text("+" + numberWithCommas(bpn_toFixed(all_slng_33,1)) + "%");		//0.1%
					} else {
						$('#all_sales_33').addClass("type_down");
						all_slng_33 = all_slng_33 * -1;
						$('#all_sales_33').text(numberWithCommas(bpn_toFixed(all_slng_33,1)) + "%");		//0.1%
						all_slng_33 = all_slng_33 * -1;
					}
					
					//전년대비
					if(parseInt(all_slng_42) >= 0){
						$('#span_all_sales_42').removeClass("type_down");
						$('#all_sales_42').text("+" + numberWithCommas(bpn_toFixed(all_slng_42,0)) + "백만원");  	//0.5백만원
					} else {
						$('#span_all_sales_42').addClass("type_down");
						all_slng_42 = all_slng_42 * -1;
						$('#all_sales_42').text(numberWithCommas(bpn_toFixed(all_slng_42,0)) + "백만원");  	//0.5백만원
						all_slng_42 = all_slng_42 * -1;
					}
					if(parseInt(all_slng_43) >= 0){
						$('#all_sales_43').removeClass("type_down");
						$('#all_sales_43').text("+" + numberWithCommas(bpn_toFixed(all_slng_43,1)) + "%");     	//0.2%
					} else {
						$('#all_sales_43').addClass("type_down");
						all_slng_43 = all_slng_43 * -1;
						$('#all_sales_43').text(numberWithCommas(bpn_toFixed(all_slng_43,1)) + "%");     	//0.2%
						all_slng_43 = all_slng_43 * -1;
					}
					
					// 오프라인 매출 실적 ----------------------------------------------------------------------
					off_slng_12 = this.ONOFF_TYM_BRND_GS_SLNG_AMT/1000000;
					off_slng_13 = this.ONOFF_TYY_BRND_GS_SLNG_AMT/1000000;
					if(this.ONOFF_TYM_ZONE_GS_SLNG_AMT != 0){
						off_slng_22 = this.ONOFF_TYM_BRND_GS_SLNG_AMT / this.ONOFF_TYM_ZONE_GS_SLNG_AMT * 100;
					}
					off_slng_23 = this.ONOFF_TYM_ZONE_GS_SLNG_AMT/1000000;
					off_slng_32 = (this.ONOFF_TYM_BRND_GS_SLNG_AMT - this.ONOFF_LYM_BRND_GS_SLNG_AMT) /1000000;
					if(this.ONOFF_LYM_BRND_GS_SLNG_AMT != 0){
						off_slng_33 = (this.ONOFF_TYM_BRND_GS_SLNG_AMT - this.ONOFF_LYM_BRND_GS_SLNG_AMT) / this.ONOFF_LYM_BRND_GS_SLNG_AMT * 100;
					}
					off_slng_42 = (this.ONOFF_TYM_BRND_GS_SLNG_AMT - this.ONOFF_TLM_BRND_GS_SLNG_AMT) /1000000;
					if(this.ONOFF_TLM_BRND_GS_SLNG_AMT != 0){
						off_slng_43 = (this.ONOFF_TYM_BRND_GS_SLNG_AMT - this.ONOFF_TLM_BRND_GS_SLNG_AMT) / this.ONOFF_TLM_BRND_GS_SLNG_AMT * 100;
					}

					off_slng = off_slng_12;

					//당월
					$('#off_sales_11').text(monthCd + "월");  //11월
					$('#off_sales_12').text(numberWithCommas(bpn_toFixed(off_slng_12,0)) + "백만원");  //100.2백만원
					$('#off_sales_13').text("년누계 " + numberWithCommas(bpn_toFixed(off_slng_13,0)) + "백만원");     //년누계 1,082.1 백만원
					//PC구성비
					$('#off_sales_22').text(numberWithCommas(bpn_toFixed(off_slng_22,1)) + "%"); //7.8%
					$('#off_sales_23').text("전체 " + numberWithCommas(bpn_toFixed(off_slng_23,0)) + "백만원"); //전체 1,284.7 백만원
					
					//전년대비
					if(parseInt(off_slng_32) >= 0){
						$('#span_off_sales_32').removeClass("type_down");
						$('#off_sales_32').text("+" + numberWithCommas(bpn_toFixed(off_slng_32,0)) + "백만원"); 	//0.2백만원
					} else {
						$('#span_off_sales_32').addClass("type_down");
						off_slng_32 = off_slng_32 * -1;
						$('#off_sales_32').text(numberWithCommas(bpn_toFixed(off_slng_32,0)) + "백만원"); 	//0.2백만원
						off_slng_32 = off_slng_32 * -1;
					}
					if(parseInt(off_slng_33) >= 0){
						$('#off_sales_33').removeClass("type_down");
						$('#off_sales_33').text("+" + numberWithCommas(bpn_toFixed(off_slng_33,1)) + "%");		//0.1%	
					} else {
						$('#off_sales_33').addClass("type_down");
						off_slng_33 = off_slng_33 * -1;
						$('#off_sales_33').text(numberWithCommas(bpn_toFixed(off_slng_33,1)) + "%");		//0.1%
						off_slng_33 = off_slng_33 * -1;
					}
					
					//전년대비
					if(parseInt(off_slng_42) >= 0){
						$('#span_off_sales_42').removeClass("type_down");
						$('#off_sales_42').text("+" + numberWithCommas(bpn_toFixed(off_slng_42,0)) + "백만원");  	//0.5백만원	
					} else {
						$('#span_off_sales_42').addClass("type_down");
						off_slng_42 = off_slng_42 * -1;
						$('#off_sales_42').text(numberWithCommas(bpn_toFixed(off_slng_42,0)) + "백만원");  	//0.5백만원
						off_slng_42 = off_slng_42 * -1;
					}
					if(parseInt(off_slng_43) >= 0){
						$('#off_sales_43').removeClass("type_down");
						$('#off_sales_43').text("+" + numberWithCommas(bpn_toFixed(off_slng_43,1)) + "%");     	//0.2%
					} else {
						$('#off_sales_43').addClass("type_down");
						off_slng_43 = off_slng_43 * -1;
						$('#off_sales_43').text(numberWithCommas(bpn_toFixed(off_slng_43,1)) + "%");     	//0.2%
						off_slng_43 = off_slng_43 * -1;
					}
					
					// 하이라이트 요약 첫번째줄
					$('#now_mm').text(monthCd);
					$('#now_mm2').text(monthCd);
					$('#highlight_text1').text(numberWithCommas(bpn_toFixed(all_slng_12,0)) + "백만원");

					if(all_slng_33 >= 0){
						$('#highlight_text2').removeClass("down");
						$('#highlight_text2').text(numberWithCommas(bpn_toFixed(all_slng_33,1)) + "%");
					} else {
						all_slng_33 = all_slng_33 * -1;
						$('#highlight_text2').addClass("down");
						$('#highlight_text2').text("▲" + numberWithCommas(bpn_toFixed(all_slng_33,1)) + "%");
					}

					if(all_slng_43 >= 0){
						$('#highlight_text3').removeClass("down");
						$('#highlight_text3').text(numberWithCommas(bpn_toFixed(all_slng_43,1)) + "%");
					} else {
						all_slng_43 = all_slng_43 * -1;
						$('#highlight_text3').addClass("down");
						$('#highlight_text3').text("▲" + numberWithCommas(bpn_toFixed(all_slng_43,1)) + "%");
					}

				});
			}
		}
		,complete: function() {setTimeout(function(){loading_end();});}
	});
}

//인사이트레포트-하이라이트-3. 회원/비회원
function getHighlightCust(){

	var cust_sales = 0;
	var cust_cnt = 0;
	var cust_price = 0;
	var cust_price2 = 0;

	ajax({
		url 	: "/bpcm/bpcm2008getHighlightCust1",
		type    : 'POST',
		data    : { yyyyMm : yyyy_mm,
	        		onOffClCd : on_off_cl_cd,
	        		cstrCd : cstr_cd,
	        		brndCd : brnd_cd
		},
		success : function (data) {
			if (data.RESULT == "S") {
				$(data.rows).each(function (index) {
					cust_sales = this.CUST_GS_SLNG_AMT / 1000000;
					cust_cnt = this.CUST_CNT;
					if(cust_cnt!=0){
						cust_price2 = this.CUST_GS_SLNG_AMT / this.CUST_CNT;
						cust_price = cust_price2 / 1000;
					}
					off_slng = off_slng - cust_sales;

					$('#cust_sales').text(numberWithCommas(bpn_toFixed(cust_sales,0)) + "백만원");
					$('#cust_cnt').text(numberWithCommas(cust_cnt) + "명");
					$('#cust_price').text(numberWithCommas(bpn_toFixed(cust_price,0)) + "천원"); //객단가
					$('#cust_sales2').text(numberWithCommas(bpn_toFixed(off_slng,0)) + "백만원");

				});
			}
		}
		,complete: function() {setTimeout(function(){loading_end();});}
	});
}

// 고객특성
function getCustInfo(){
	
	yyyy_mm = $('#year_cd').val() + $('#month_cd').val();
	
	loading_start(getCustSpec);

}

// 구매특성
function getPurchaseInfo(){
	
	yyyy_mm = $('#year_cd').val() + $('#month_cd').val();

	//구매특성-
	loading_start(getPurchaseSpec);
	
/*
	//구매특성-요일별매출비중 
	loading_start(getPurchaseSpecWeek);

 	//구매특성-시간별매출비중 
	loading_start(getPurchaseSpecHour);

	//구매특성-10. 결제수단별 구매금액비중 
	if(on_off_cl_cd == "1"){ //오프라인만 조회가능
		$('#graph_dim1').removeClass("dim");
		document.getElementById("purchase_li2").style.display="";
		loading_start(getPurchaseSpecStlmMnsOff);
	
	} else {
		$('#graph_dim1').addClass("dim");
		jqplot_data_cust_pay = [];
		$('#graph_pay').html("");
		document.getElementById("purchase_li2").style.display="none";
	}
	
	//구매특성-11. 유사브랜드
	if(on_off_cl_cd == "1"){ //오프라인만 조회가능
		$('#graph_dim2').removeClass("dim");
		document.getElementById("purchase_li3").style.display="";
		loading_start(getOrderSmlrBrndNm);	
	} else {
		$('#graph_dim2').addClass("dim");
		$('#smlr_brnd_nm1').text("");
		$('#smlr_brnd_nm2').text("");
		$('#smlr_brnd_nm3').text("");
		$('#smlr_brnd_nm4').text("");
		$('#smlr_brnd_nm5').text("");
		document.getElementById("purchase_li3").style.display="none";
	}

	//구매특성-12. 상품군내 연관브랜드
	loading_start(getPurchaseSpecAsctBrndNm);

	//구매특성-상품 BEST TOP 3
	loading_start(getBestBrnd); */

}

//기준일참조
function getStdYm(){
	
	yyyy_mm = $('#year_cd').val() + $('#month_cd').val();
	
	if($('#year_cd').val() == "" || $('#year_cd').val() == null){
		alert('<%=MessageUtil.getMsg("MSG.CMPGN.ALERT.000088")%>'); //년도를 선택해주세요.
		return;
	}
	
	if($('#month_cd').val() == "" || $('#month_cd').val() == null){
		alert('<%=MessageUtil.getMsg("MSG.CMPGN.ALERT.000089")%>'); //월을 선택해주세요.
		return;
	}
	
	ajax({
		url 	: "/bpcm/bpcm2008getStdYm",
		type    : 'POST',
		data    : { yyyyMm : yyyy_mm},
		success : function (data) {
			if (data.RESULT == "S") {
				$(data.rows).each(function (index) {
					
					std_ym = this.STD_YM;
					lyy_sam_ym = this.LYY_SAM_YM;
					bef_ym = this.BEF_YM;

				});
			}
		}
		,complete: function() {setTimeout(function(){

			loading_end();
			});}
	});
	
}

//상품 BEST TOP 3
function getBestBrnd(){

/* <li id="best_brnd1">에뮐씨옹 에꼴로지끄 125ml
	<em class="percent">38%</em>
	<em class="price">₩ 500,248</em>
</li>
 */
 	var html = "";
 	var rate = 0;

	ajax({
		url 	: "/bpcm/bpcm2008getPurchaseSpecBestBrnd",
		type    : 'POST',
		data    : { yyyyMm : yyyy_mm,
	                onOffClCd : on_off_cl_cd,
	                cstrCd : $('#cstr_cd').val(),
	                brndCd : $('#brnd_cd').val()
		},
		success : function (data) {
			if (data.RESULT == "S") {
				$(data.rows).each(function (index) {

					rate = Math.round(this.AMT_RATIO);

					html = this.PRDC_NM;
					html += "<em class='percent'>" + rate + "%</em>"
					html += "<em class='price'>₩" + numberWithCommas(this.GS_SLNG_AMT) + "</em>"

					if(this.SEQ_RATIO == 1){
						$('#best_brnd1').html("");
						$('#best_brnd1').html(html);
						$('#purchase_spec_text9').text(this.PRDC_NM);
					} else if(this.SEQ_RATIO == 2){
						$('#best_brnd2').html(html);
					} else if(this.SEQ_RATIO == 3){
						$('#best_brnd3').html(html);
					}
				});
			}
		}
		,complete: function() {setTimeout(function(){loading_end();});}
	});
}

//구매특성-12. 상품군내 연관브랜드
function getPurchaseSpecAsctBrndNm(){

	$('#asct_brnd_nm1').text("");
	$('#asct_brnd_nm2').text("");
	$('#asct_brnd_nm3').text("");
	$('#asct_brnd_nm4').text("");
	$('#asct_brnd_nm5').text("");

	ajax({
		url 	: "/bpcm/bpcm2008getPurchaseSpecAsctBrndNm",
		type    : 'POST',
		data    : { yyyyMm : yyyy_mm,
	                onOffClCd : on_off_cl_cd,
	                cstrCd : $('#cstr_cd').val(),
	                brndCd : $('#brnd_cd').val()
		},
		success : function (data) {
			if (data.RESULT == "S") {
				$(data.rows).each(function (index) {

					if(this.ASCT_SEQ == 1){
						$('#asct_brnd_nm1').text(this.BRND_NM);
						$('#purchase_spec_text7').text(this.BRND_NM);
					} else if(this.ASCT_SEQ == 2){
						$('#asct_brnd_nm2').text(this.BRND_NM);
					} else if(this.ASCT_SEQ == 3){
						$('#asct_brnd_nm3').text(this.BRND_NM);
					} else if(this.ASCT_SEQ == 4){
						$('#asct_brnd_nm4').text(this.BRND_NM);
					} else {
						$('#asct_brnd_nm5').text(this.BRND_NM);
					}

				});
			}
		}
		,complete: function() {setTimeout(function(){
			var purchase_spec_text8 = "";

			if($('#asct_brnd_nm2').text() != ""){
				purchase_spec_text8 = $('#asct_brnd_nm2').text();
			}
			if($('#asct_brnd_nm3').text() != ""){
				if(purchase_spec_text8 != ""){
					purchase_spec_text8 += ">"
				}
				purchase_spec_text8 += $('#asct_brnd_nm3').text();
			}
			if($('#asct_brnd_nm4').text() != ""){
				if(purchase_spec_text8 != ""){
					purchase_spec_text8 += ">"
				}
				purchase_spec_text8 += $('#asct_brnd_nm4').text();
			}
			if($('#asct_brnd_nm5').text() != ""){
				if(purchase_spec_text8 != ""){
					purchase_spec_text8 += ">"
				}
				purchase_spec_text8 += $('#asct_brnd_nm5').text();
			}

			$('#purchase_spec_text8').text(purchase_spec_text8);

			//loading_end();
		});}
	});
}

// 조회전 초기화
function fn_initData(){
	
	// 유사 브랜드 TOP5
	$('#smlr_brnd_nm1').text("");
	$('#smlr_brnd_nm2').text("");
	$('#smlr_brnd_nm3').text("");
	$('#smlr_brnd_nm4').text("");
	$('#smlr_brnd_nm5').text("");
	
	// 연관 브랜드 TOP5
	$('#asct_brnd_nm1').text("");
	$('#asct_brnd_nm2').text("");
	$('#asct_brnd_nm3').text("");
	$('#asct_brnd_nm4').text("");
	$('#asct_brnd_nm5').text("");
	
	// 상품 BEST TOP3
	$('#best_brnd1').text("");
	$('#best_brnd2').text("");
	$('#best_brnd3').text("");
	
	// 구매특성요약Text
	$('#purchase_spec_text1').text("");
	$('#purchase_spec_text2').text("");
	$('#purchase_spec_text3').text("");
	$('#purchase_spec_text4').text("");
	$('#purchase_spec_text5').text("");
	$('#purchase_spec_text6').text("");
	$('#purchase_spec_text7').text("");
	$('#purchase_spec_text8').text("");
	$('#purchase_spec_text9').text("");
	
}

//구매특성
function getPurchaseSpec(){

	var week = new Array('','일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일');
	var weekArr = [];

	var week_rate_1 = parseInt(0);
	var week_rate_2 = parseInt(0);
	var week_rate_3 = parseInt(0);
	var week_rate_4 = parseInt(0);
	var week_rate_5 = parseInt(0);
	var week_rate_6 = parseInt(0);
	var week_rate_7 = parseInt(0);

	var week_amt_1 = parseInt(0);
	var week_amt_2 = parseInt(0);
	var week_amt_3 = parseInt(0);
	var week_amt_4 = parseInt(0);
	var week_amt_5 = parseInt(0);
	var week_amt_6 = parseInt(0);
	var week_amt_7 = parseInt(0);
	
	var rate = 0;
	var amt = 0;
	var max_day = 0;
	
	var max_cd = "99";
	
	var stlm_01 = 0;  //자사카드
	var stlm_02 = 0;  //타사카드
	var stlm_03 = 0;  //현금
	var stlm_04 = 0;  //상품권
	var stlm_99 = 0;  //기타
	
	var stlm_amt_01 = 0;  //자사카드
	var stlm_amt_02 = 0;  //타사카드
	var stlm_amt_03 = 0;  //현금
	var stlm_amt_04 = 0;  //상품권
	var stlm_amt_99 = 0;  //기타
	
	var html = "";
	
	var dayw_flag = false;
	var asct_brnd_flag = false;
	var best_flag = false;
	var smlr_brnd_flag = false;
	var stlm_mns_flag = false;
	var tmslt_flag = false;
	
	tmsltArr = [];
	
	fn_initData();
	
	document.getElementById("view2_true").style.display="none";
	document.getElementById("view2_false").style.display="";
	
	ajax({
		url 	: "/bpcm/bpcm2008getPurchaseSpec",
		type    : 'POST',
		data    : { yyyyMm : yyyy_mm,
    		        onOffClCd : on_off_cl_cd,
    		        cstrCd : cstr_cd,
    		        brndCd : brnd_cd
		},
		success : function (data) {
			if (data.RESULT == "S") {
				$(data.rows).each(function (index) {

					rate = Math.round(this.AMT_RATIO);
					amt = this.GS_SLNG_AMT;
					//요일별배출비중
					if(this.GUBUN=="dayw"){
						dayw_flag = true;
						if(this.SEQ_RATIO == 1){
							max_day = this.GUBUN_CD;
							$('#purchase_spec_text1').text(this.GUBUN_NM+"요일");
						}
						
						if(this.GUBUN_CD == 1){
							week_rate_1 = rate;
							week_amt_1 = bpn_toFixed(amt/1000000,0);
						}
						if(this.GUBUN_CD == 2){
							week_rate_2 = rate;
							week_amt_2 = bpn_toFixed(amt/1000000,0);
						}
						if(this.GUBUN_CD == 3){
							week_rate_3 = rate;
							week_amt_3 = bpn_toFixed(amt/1000000,0);
						}
						if(this.GUBUN_CD == 4){
							week_rate_4 = rate;
							week_amt_4 = bpn_toFixed(amt/1000000,0);
						}
						if(this.GUBUN_CD == 5){
							week_rate_5 = rate;
							week_amt_5 = bpn_toFixed(amt/1000000,0);
						}
						if(this.GUBUN_CD == 6){
							week_rate_6 = rate;
							week_amt_6 = bpn_toFixed(amt/1000000,0);
						}
						if(this.GUBUN_CD == 7){
							week_rate_7 = rate;
							week_amt_7 = bpn_toFixed(amt/1000000,0);
						}						
					}
					
					//시간별매출비중
					if(this.GUBUN=="tmslt"){
						tmslt_flag = true;
						
						tmsltArr.push(bpn_toFixed(amt/1000000,0));
						
						if(this.SEQ_RATIO == 1){
							max_cd = this.GUBUN_CD;
							$('#purchase_spec_text2').text(this.GUBUN_CD + "~" + (parseInt(this.GUBUN_CD) + 1) + "시");
						}
					}
					
					//결제수단별이용비중
					if(this.GUBUN=="stlm_mns"){
						stlm_mns_flag = true;
						if(this.SEQ_RATIO == "1"){
							if(this.GUBUN_CD == "01"){
								$('#purchase_spec_text3').text("자사카드");
							} else if(this.GUBUN_CD == "02"){
								$('#purchase_spec_text3').text("타사카드");
							} else if(this.GUBUN_CD == "03"){
								$('#purchase_spec_text3').text("상품권");
							} else if(this.GUBUN_CD == "04"){
								$('#purchase_spec_text3').text("현금");
							}
							$('#purchase_spec_text4').text(rate + "%");
						}

						if(this.GUBUN_CD == "01"){
							stlm_01 = rate;
							stlm_amt_01 = bpn_toFixed(amt/1000000,0);
						} else if(this.GUBUN_CD == "02"){
							stlm_02 = rate;
							stlm_amt_02 = bpn_toFixed(amt/1000000,0);
						} else if(this.GUBUN_CD == "03"){
							stlm_03 = rate;
							stlm_amt_03 = bpn_toFixed(amt/1000000,0);
						} else if(this.GUBUN_CD == "04"){
							stlm_04 = rate;
							stlm_amt_04 = bpn_toFixed(amt/1000000,0);
						} else {
							stlm_99 = rate;
							stlm_amt_99 = bpn_toFixed(amt/1000000,0);
						}	
					}
					
					//유사브랜드TOP5
					if(this.GUBUN=="smlr_brnd"){
						smlr_brnd_flag = true;
						if(this.SEQ_RATIO == 1){
							$('#smlr_brnd_nm1').text(this.GUBUN_NM);
							$('#purchase_spec_text5').text(this.GUBUN_NM);
						} else if(this.SEQ_RATIO == 2){
							$('#smlr_brnd_nm2').text(this.GUBUN_NM);
						} else if(this.SEQ_RATIO == 3){
							$('#smlr_brnd_nm3').text(this.GUBUN_NM);
						} else if(this.SEQ_RATIO == 4){
							$('#smlr_brnd_nm4').text(this.GUBUN_NM);
						} else {
							$('#smlr_brnd_nm5').text(this.GUBUN_NM);
						}
					}
				
					//연관브랜드TOP5
					if(this.GUBUN=="asct_brnd"){
						asct_brnd_flag = true;
						if(this.SEQ_RATIO == 1){
							$('#asct_brnd_nm1').text(this.GUBUN_NM);
							$('#purchase_spec_text7').text(this.GUBUN_NM);
						} else if(this.SEQ_RATIO == 2){
							$('#asct_brnd_nm2').text(this.GUBUN_NM);
						} else if(this.SEQ_RATIO == 3){
							$('#asct_brnd_nm3').text(this.GUBUN_NM);
						} else if(this.SEQ_RATIO == 4){
							$('#asct_brnd_nm4').text(this.GUBUN_NM);
						} else {
							$('#asct_brnd_nm5').text(this.GUBUN_NM);
						}
					}
					//상품BEST TOP3
					if(this.GUBUN=="best"){
						best_flag = true;
						html = this.GUBUN_NM;
						html += "<em class='percent'>" + rate + "%</em>"
						html += "<em class='price'>₩" + numberWithCommas(this.GS_SLNG_AMT) + "</em>"

						if(this.PCH_RANK == 1){
							$('#best_brnd1').html("");
							$('#best_brnd1').html(html);
							$('#purchase_spec_text9').text(this.GUBUN_NM);
						} else if(this.PCH_RANK == 2){
							$('#best_brnd2').html(html);
						} else if(this.PCH_RANK == 3){
							$('#best_brnd3').html(html);
						}
					}
					
				});
			}
		}
		,complete: function() {setTimeout(function(){
			
			if(dayw_flag || asct_brnd_flag || best_flag || smlr_brnd_flag || stlm_mns_flag){
				document.getElementById("view2_true").style.display="";
				document.getElementById("view2_false").style.display="none";
			}
			
			//요일별배출비중
			if(dayw_flag){
				//week_rate_1 일
				//week_rate_2 월
				//week_rate_3 화
				//week_rate_4 수
				//week_rate_5 목
				//week_rate_6 금
				//week_rate_7 토

				weekArr.push(week_rate_1); //일
				weekArr.push(week_rate_7); //토
				weekArr.push(week_rate_6); //금
				weekArr.push(week_rate_5); //목
				weekArr.push(week_rate_4); //수
				weekArr.push(week_rate_3); //화
				weekArr.push(week_rate_2); //월

				daywArr = [];
				daywArr.push(week_amt_1); //일
				daywArr.push(week_amt_7); //토
				daywArr.push(week_amt_6); //금
				daywArr.push(week_amt_5); //목
				daywArr.push(week_amt_4); //수
				daywArr.push(week_amt_3); //화
				daywArr.push(week_amt_2); //월				
				
				jqplot_data_cust_day = [];
				jqplot_data_cust_day.push(weekArr);

			//  real_days = ["일1", "토2", "금3", "목4", "수5", "화6", "월7"],
				$('#graph_days').html("");

				var max_color = "#0fb5bf";
				var base_color = "#887ae4";
				sColor = [];

				if(max_day == 1){
					sColor.push(max_color);
				} else {
					sColor.push(base_color);
				}
				for(var i=7; i>1; i--){

					if(i==max_day){
						sColor.push(max_color);
					} else {
						sColor.push(base_color);
					}
				}
				
				graph_days = $.jqplot('graph_days', jqplot_data_cust_day, fn_getChartConfig_3(real_days,sColor,daywArr));
			} else {
				$('#graph_days').html("");
				$('#purchase_spec_text1').text("");
			}

			
			// 시간별매출비중
			if(tmslt_flag){
				var donut_color = [];
				donutChartData_3 = [];
				
				var html = "";
				
				var startHour = 0;
				var endHour = 0;
				if(on_off_cl_cd == "1"){
					//오프라인인 경우
					startHour = 10;
					endHour = 21;
				} else {
					//온라인인 경우
					startHour = 0;
					endHour = 23;
				}
				
				var arrData = [];
				
				var j=0;
				for(var i=startHour; i<=endHour; i++){

					if(i==parseInt(max_cd)){
						donut_color.push('#0fb5bf'); //max
					} else {
						donut_color.push('#887ae4'); //기본
					}
					
					arrData = [];
					
					if(on_off_cl_cd == "1"){
						arrData.push(i+"시");	
						arrData.push(10);
						html += "<li>" + i+"시</li>";
					} else {
						if(i%2 == 0){
							arrData.push(i+"시");
							html += "<li>" + i+"시</li>";
						} else {
							arrData.push("");
						}
						arrData.push(5);
					}
					
					donutChartData_3.push(arrData);

					
				}
				$('#hours_list').html("");
				$('#hours_list').html(html);
				
				if(max_cd=="99"){
					$('#purchase_spec_text2').text("");
				}
				
				$('#graph_donut_3').html("");
				$.jqplot('graph_donut_3', [donutChartData_3], getDonutChart_3(donutChartData_3,donut_color,tmsltArr));
			} else {
				$('#hours_list').html("");
				$('#graph_donut_3').html("");
				$('#purchase_spec_text2').text("");
			}

			if(on_off_cl_cd == "1"){ //오프라인만 조회가능
				
				$('#graph_dim1').removeClass("dim");
				document.getElementById("purchase_li2").style.display="";
				
				//결제수단별이용비중
				if(stlm_mns_flag){
					var pay_arr = [];
					pay_arr.push(stlm_01);
					pay_arr.push(stlm_02);
					pay_arr.push(stlm_03);
					pay_arr.push(stlm_04);
					jqplot_data_cust_pay = [];
					jqplot_data_cust_pay.push(pay_arr);
					
					stlmMnsArr = [];
					stlmMnsArr.push(stlm_amt_01);
					stlmMnsArr.push(stlm_amt_02);
					stlmMnsArr.push(stlm_amt_03);
					stlmMnsArr.push(stlm_amt_04);
					
					$('#graph_pay').html("");
					graph_pay = $.jqplot('graph_pay', jqplot_data_cust_pay, fn_getChartConfig_2(type_pay,stlmMnsArr));
				} else {
					$('#graph_pay').html("");
				}
			} else {
				$('#graph_dim1').addClass("dim");
				jqplot_data_cust_pay = [];
				$('#graph_pay').html("");
				document.getElementById("purchase_li2").style.display="none";
			}


			if(on_off_cl_cd == "1"){ //오프라인만 조회가능
				$('#graph_dim2').removeClass("dim");
				document.getElementById("purchase_li3").style.display="";
				
				//유사브랜드TOP5
				if(smlr_brnd_flag){
					var purchase_spec_text6 = "";
					if($('#smlr_brnd_nm2').text() != ""){
						purchase_spec_text6 = $('#smlr_brnd_nm2').text();
					}
					if($('#smlr_brnd_nm3').text() != ""){
						if(purchase_spec_text6 != ""){
							purchase_spec_text6 += ">"
						}
						purchase_spec_text6 += $('#smlr_brnd_nm3').text();
					}
					if($('#smlr_brnd_nm4').text() != ""){
						if(purchase_spec_text6 != ""){
							purchase_spec_text6 += ">"
						}
						purchase_spec_text6 += $('#smlr_brnd_nm4').text();
					}
					if($('#smlr_brnd_nm5').text() != ""){
						if(purchase_spec_text6 != ""){
							purchase_spec_text6 += ">"
						}
						purchase_spec_text6 += $('#smlr_brnd_nm5').text();
					}
					$('#purchase_spec_text6').text(purchase_spec_text6);
				} else {
					$('#purchase_spec_text6').text("");
				}
			} else {
				$('#graph_dim2').addClass("dim");
				$('#smlr_brnd_nm1').text("");
				$('#smlr_brnd_nm2').text("");
				$('#smlr_brnd_nm3').text("");
				$('#smlr_brnd_nm4').text("");
				$('#smlr_brnd_nm5').text("");
				document.getElementById("purchase_li3").style.display="none";
			}

			
			//연관브랜드TOP5
			if(asct_brnd_flag){
				var purchase_spec_text8 = "";
				if($('#asct_brnd_nm2').text() != ""){
					purchase_spec_text8 = $('#asct_brnd_nm2').text();
				}
				if($('#asct_brnd_nm3').text() != ""){
					if(purchase_spec_text8 != ""){
						purchase_spec_text8 += ">"
					}
					purchase_spec_text8 += $('#asct_brnd_nm3').text();
				}
				if($('#asct_brnd_nm4').text() != ""){
					if(purchase_spec_text8 != ""){
						purchase_spec_text8 += ">"
					}
					purchase_spec_text8 += $('#asct_brnd_nm4').text();
				}
				if($('#asct_brnd_nm5').text() != ""){
					if(purchase_spec_text8 != ""){
						purchase_spec_text8 += ">"
					}
					purchase_spec_text8 += $('#asct_brnd_nm5').text();
				}

				$('#purchase_spec_text8').text(purchase_spec_text8);
			} else {
				$('#asct_brnd_nm1').text("");
				$('#asct_brnd_nm2').text("");
				$('#asct_brnd_nm3').text("");
				$('#asct_brnd_nm4').text("");
				$('#asct_brnd_nm5').text("");
				$('#purchase_spec_text7').text("");
				$('#purchase_spec_text8').text("");
			}
			
			if(!best_flag){
				$('#best_brnd1').html("");
				$('#best_brnd2').html("");
				$('#best_brnd3').html("");
				$('#purchase_spec_text9').text("");
			}
			
			loading_end();
		});}
	});

}


function getCustSpec(){
	
	//고객특성 초기화
	
	var age_val_10 = 0;
	var age_val_20 = 0;
	var age_val_30 = 0;
	var age_val_40 = 0;
	var age_val_50 = 0;
	var age_val_60 = 0;
	var age_val_70 = 0;
	
	var age_amt_10 = 0;
	var age_amt_20 = 0;
	var age_amt_30 = 0;
	var age_amt_40 = 0;
	var age_amt_50 = 0;
	var age_amt_60 = 0;
	var age_amt_70 = 0;
	
	var gen_all_cnt = 0;
	var gen_man_cnt = 0;
	var gen_woman_cnt = 0;
	var exgrd_11 = 0;
	var exgrd_12 = 0;
	var exgrd_13 = 0;
	var exgrd_99 = 0;
	var evgrd_max_seq = 0;
	var evgrd_01_cnt = 0;
	var evgrd_02_cnt = 0;
	var evgrd_03_cnt = 0;
	var evgrd_04_cnt = 0;
	var evgrd_05_cnt = 0;
	var evgrd_01_per = 1;
	var evgrd_02_per = 1;
	var evgrd_03_per = 1;
	var evgrd_04_per = 1;
	var evgrd_05_per = 1;
	var evgrd_01_amt = 1;
	var evgrd_02_amt = 1;
	var evgrd_03_amt = 1;
	var evgrd_04_amt = 1;
	var evgrd_05_amt = 1;	

	var cust_spec_text1 = "";
	var cust_spec_text2 = "";
	var cust_spec_text3 = "";
	var cust_spec_text4 = "";
	var cust_spec_text5 = "";
	var cust_spec_text6 = "";
	var cust_spec_text7 = "";
	var cust_spec_text8 = "";
	var cust_spec_text9 = "";
	var cust_spec_text10 = "";
	var cust_spec_text11 = "";
	var cust_spec_text12 = "";
	var cust_spec_text13 = "";
	var cust_spec_text14 = 0;
	var cust_spec_text15 = 0;
	var cust_spec_text16 = 0;
	var cust_spec_text17 = 0;

	var rate = 0;
	var gubunCd = "";
	var html = "";

	var age_flag = false;
	var dong_flag = false;
	var evgrd_flag = false;
	var exgrd_flag = false;
	var fan_flag = false;
	var gen_flag = false;
	
	var intFanArr = [['FAN 고객', 0], ['일반 고객', 0]];
	var fanAmtArr = [];
	var int_val = 0;
	var info = [];
	
	var data_flag = false;
	document.getElementById("view1_true").style.display="none";
	document.getElementById("view1_false").style.display="";
	
	ajax({
		url 	: "/bpcm/bpcm2008getCustSpec",
		type    : 'POST',
		data    : { yyyyMm : yyyy_mm,
	        		onOffClCd : on_off_cl_cd,
	        		cstrCd : cstr_cd,
	        		brndCd : brnd_cd,
	        		stdYm : std_ym,
	        		lyySamYm : lyy_sam_ym,
	        		befYm : bef_ym
		},
		beforeSend: function() {},
		success : function (data) {
			if (data.RESULT == "S") {
				
				intFanArr = [];
				
				$(data.rows).each(function (index) {
					data_flag = true;
					gubunCd = this.GUBUN_CD;
					
					var tymGsSlngAmt = bpn_toFixed(this.TYM_GS_SLNG_AMT/1000000,0);
					
					if(this.GUBUN == "gen"){
						gen_flag = true;
						gen_all_cnt += parseInt(this.CUST_CNT);
						if(gubunCd=="1"){
							gen_man_cnt = parseInt(this.CUST_CNT);
							cust_spec_text3 = bpn_toFixed(this.YOY_RATE); //남성 전년동월대비
							cust_spec_text4 = bpn_toFixed(this.MOM_RATE); //남성 전월대비
						} else if(gubunCd=="2"){
							gen_woman_cnt = parseInt(this.CUST_CNT);
							cust_spec_text1 = bpn_toFixed(this.YOY_RATE); //여성 전년동월대비
							cust_spec_text2 = bpn_toFixed(this.MOM_RATE); //여성 전월대비
						}
					}

					if(this.GUBUN == "age"){ 
						
						age_flag = true;
						//연령대코드  #[미분류] ,01[19세이하] ,02[20~29] ,03[30~39] ,04[40~49] ,05[50~59] ,06[60~69] ,07[70세이상] ,~[해당사항없음]
						//성별 및 연령대 매출 비중
						rate = Math.round(this.AMT_RATIO);
						//가장높은신장률 및 연령대
						if(this.YOY_RATE_SEQ=="1"){
							cust_spec_text5 = bpn_toFixed(this.YOY_RATE);
							cust_spec_text6 = gubunCd;
						}
						//가장낮은신장률 및 연령대
						if(this.YOY_RATE_SEQ=="7"){
							cust_spec_text7 = gubunCd;
							cust_spec_text8 = bpn_toFixed(this.YOY_RATE);
						}
						switch(gubunCd){
							case "01":
								age_val_10 = rate; age_amt_10 = tymGsSlngAmt; break;
							case "02":
								age_val_20 = rate; age_amt_20 = tymGsSlngAmt; break;
							case "03":
								age_val_30 = rate; age_amt_30 = tymGsSlngAmt; break;
							case "04":
								age_val_40 = rate; age_amt_40 = tymGsSlngAmt; break;
							case "05":
								age_val_50 = rate; age_amt_50 = tymGsSlngAmt; break;
							case "06":
								age_val_60 = rate; age_amt_60 = tymGsSlngAmt; break;
							case "07":
								age_val_70 = rate; age_amt_70 = tymGsSlngAmt; break;
						}
					}

					if(this.GUBUN == "exgrd"){
						exgrd_flag = true;
						rate = Math.round(this.AMT_RATIO);

						//고객등급별구성비 도넛
						// 우수고객등급 #[미확인] ,11[AVENUEL] ,12[MVG] ,13[점VIP] ,15[VIP+] ,16[G-VIP] ,21[LOVE 명품마일리지] ,22[LOVE 마일리지] ,31[CLOVER] ,99[Members] ,~[해당사항없음]
						if(gubunCd=="11"){ //AVENUEL
							exgrd_11 = tymGsSlngAmt;
						}
						if(gubunCd=="12"){ //MVG
							exgrd_12 = tymGsSlngAmt;
						}
						if(gubunCd=="13"){ //VIP
							exgrd_13 = tymGsSlngAmt;
						}
						if(gubunCd=="99"){ //일반
							exgrd_99 = tymGsSlngAmt;
						}

						if(this.RATIO_SEQ_DESC == 1){
							cust_spec_text11 = this.GUBUN_NM + " 고객";
							cust_spec_text12 = rate + "%";
						}

						if(this.YOY_RATE_SEQ == 1){
							cust_spec_text13 = this.GUBUN_NM + " 고객";
						}
					}
					if(this.GUBUN == "zone_exgrd"){
						if(gubunCd=="11"){ //AVENUEL
							cust_spec_text14 = bpn_toFixed(this.AMT_RATIO);
						}
						if(gubunCd=="12"){ //MVG
							cust_spec_text15 = bpn_toFixed(this.AMT_RATIO);
						}
						if(gubunCd=="13"){ //VIP
							cust_spec_text16 = bpn_toFixed(this.AMT_RATIO);
						}
						if(gubunCd=="99"){ //일반
							cust_spec_text17 = bpn_toFixed(this.AMT_RATIO);
						}
					}
					
					if(this.GUBUN == "evgrd"){
						evgrd_flag = true;
						// 고객평가등급코드 #[미분류] ,01[상위1%] ,02[상위5%] ,03[상위10%] ,04[상위20%] ,05[하위80%] ,~[해당사항없음]
						if(gubunCd=="01"){
							evgrd_01_cnt = parseInt(this.CUST_CNT);
							evgrd_01_per = parseInt(this.AMT_RATIO);
							evgrd_01_amt = tymGsSlngAmt;
						} else if(gubunCd=="02"){
							evgrd_02_cnt = parseInt(this.CUST_CNT);
							evgrd_02_per = parseInt(this.AMT_RATIO);
							evgrd_02_amt = tymGsSlngAmt;
						} else if(gubunCd=="03"){
							evgrd_03_cnt = parseInt(this.CUST_CNT);
							evgrd_03_per = parseInt(this.AMT_RATIO);
							evgrd_03_amt = tymGsSlngAmt;
						} else if(gubunCd=="04"){
							evgrd_04_cnt = parseInt(this.CUST_CNT);
							evgrd_04_per = parseInt(this.AMT_RATIO);
							evgrd_04_amt = tymGsSlngAmt;
						} else if(gubunCd=="05"){
							evgrd_05_cnt = parseInt(this.CUST_CNT);
							evgrd_05_per = parseInt(this.AMT_RATIO);
							evgrd_05_amt = tymGsSlngAmt;
						}

						if(this.RATIO_SEQ_DESC == 1){
							evgrd_max_seq = this.GUBUN_SEQ;
						}
					}
					
					if(this.GUBUN == "dong"){
						dong_flag = true;
						//지역별 매출 비중
						rate = Math.round(this.AMT_RATIO);
						
						if(this.RATIO_SEQ_DESC>=1 && this.RATIO_SEQ_DESC<=5){
							html  = this.GUBUN_NM + " " + this.GUBUN_NM2;
							$('#dong_name'+this.RATIO_SEQ_DESC).attr("value",this.GUBUN_NM);
							$('#dong_name'+this.RATIO_SEQ_DESC).attr("value2",this.GUBUN_NM2);
							html += '<span class="list_percent" data-graph-width="'+ rate + '">';
							html += '<em class="percent_text"></em></span>';
							html += '<span class="graph_hover">' + this.GUBUN_NM + ' ' + this.GUBUN_NM2 + ' : ' + tymGsSlngAmt + '백만원</span>';
							$('#dong_name'+this.RATIO_SEQ_DESC).html("");
							$('#dong_name'+this.RATIO_SEQ_DESC).html(html);
						}
					}
					
					if(this.GUBUN == "fan"){
						fan_flag = true;
						if(gubunCd=="1"){
							int_val = Number(this.CUST_CNT);
							info = ["FAN 고객",int_val];
							intFanArr.push(info);
							fanAmtArr.push(tymGsSlngAmt);
						} else {
							int_val = Number(this.CUST_CNT);
							info = ["일반 고객",int_val];
							intFanArr.push(info);
							fanAmtArr.push(tymGsSlngAmt);
						}
					}
				});
			}
		}
		,complete: function() {setTimeout(function(){

			if(data_flag){
				document.getElementById("view1_true").style.display="";
				document.getElementById("view1_false").style.display="none";
			}
			
			//성별 및 연령대 매출비중
			if(age_flag){
				$('#cust_all_cnt').text(gen_all_cnt);
				$('#cust_man_cnt').text(gen_man_cnt);
				$('#cust_woman_cnt').text(gen_woman_cnt);
				var age_arr = [];
				age_arr.push(parseInt(age_val_10));
				age_arr.push(parseInt(age_val_20));
				age_arr.push(parseInt(age_val_30));
				age_arr.push(parseInt(age_val_40));
				age_arr.push(parseInt(age_val_50));
				age_arr.push(parseInt(age_val_60));
				age_arr.push(parseInt(age_val_70));
				jqplot_data_cust_age = [];
				jqplot_data_cust_age.push(age_arr);
				
				ageAmtArr = [];
				ageAmtArr.push(age_amt_10);
				ageAmtArr.push(age_amt_20);
				ageAmtArr.push(age_amt_30);
				ageAmtArr.push(age_amt_40);
				ageAmtArr.push(age_amt_50);
				ageAmtArr.push(age_amt_60);
				ageAmtArr.push(age_amt_70);
				
				$('#graph_age').html("");
				graph_age = $.jqplot('graph_age', jqplot_data_cust_age, fn_getChartConfig(ages, ageAmtArr)); // 고객 특성 - 성별 및 연령대 매출 비중
				
				switch(cust_spec_text6){
					case "01" : $('#cust_spec_text6').text("10대이하"); break;
					case "02" : $('#cust_spec_text6').text("20대"); break;
					case "03" : $('#cust_spec_text6').text("30대"); break;
					case "04" : $('#cust_spec_text6').text("40대"); break;
					case "05" : $('#cust_spec_text6').text("50대"); break;
					case "06" : $('#cust_spec_text6').text("60대"); break;
					case "07" : $('#cust_spec_text6').text("70대이상"); break;
				}

				switch(cust_spec_text7){
					case "01" : $('#cust_spec_text7').text("10대이하"); break;
					case "02" : $('#cust_spec_text7').text("20대"); break;
					case "03" : $('#cust_spec_text7').text("30대"); break;
					case "04" : $('#cust_spec_text7').text("40대"); break;
					case "05" : $('#cust_spec_text7').text("50대"); break;
					case "06" : $('#cust_spec_text7').text("60대"); break;
					case "07" : $('#cust_spec_text7').text("70대이상"); break;
				}
				
				if(cust_spec_text8 >= 0){ //전년동월대비 가장낮은신장률
					$('#cust_spec_text8').removeClass("down");
					$('#cust_spec_text8').text(cust_spec_text8 + "%"); //↑
				} else {
					cust_spec_text8 = bpn_toFixed(cust_spec_text8 * -1);
					$('#cust_spec_text8').addClass("down");
					$('#cust_spec_text8').text("▲" + cust_spec_text8 + "%"); //↓
				}
				
			} else {
				$('#graph_age').html("");
				$('#cust_all_cnt').text("-");
				$('#cust_man_cnt').text("-");
				$('#cust_woman_cnt').text("-");
				$('#cust_spec_text6').text("-");
				$('#cust_spec_text7').text("-");
				
				$('#cust_spec_text5').removeClass("down");
				$('#cust_spec_text5').text("-"); //↑
				$('#cust_spec_text8').removeClass("down");
				$('#cust_spec_text8').text("-"); //↑
			}


			if(exgrd_flag){
				//var jqplot_data_cust_exgrd = [['AVENUEL', 10], ['MVG', 16], ['일반', 40], ['VIP', 34]];                 // 고객 특성 - 고객등급별 구성비
				var exgrd_arr = [];
				jqplot_data_cust_exgrd = [];

				exgrd_arr = [];
				exgrd_arr.push('AVENUEL');
				exgrd_arr.push(parseInt(exgrd_11));
				jqplot_data_cust_exgrd.push(exgrd_arr);

				exgrd_arr = [];
				exgrd_arr.push('MVG');
				exgrd_arr.push(parseInt(exgrd_12));
				jqplot_data_cust_exgrd.push(exgrd_arr);

				exgrd_arr = [];
				exgrd_arr.push('일반');
				exgrd_arr.push(parseInt(exgrd_99));
				jqplot_data_cust_exgrd.push(exgrd_arr);

				exgrd_arr = [];
				exgrd_arr.push('VIP');
				exgrd_arr.push(parseInt(exgrd_13));
				jqplot_data_cust_exgrd.push(exgrd_arr);

				$('#graph_donut_2').html("");
				graph_donut_2 = $.jqplot('graph_donut_2', [jqplot_data_cust_exgrd], getDonutChart_2(jqplot_data_cust_exgrd));
				
			} else {
				$('#graph_donut_2').html("");
			}

			if(evgrd_flag){
				for(var i=1; i<=5; i++){
					$('#li_evgrd0'+i).removeClass("type_green");
					$('#li_evgrd0'+i).removeClass("type_red");
					if(i==evgrd_max_seq){
						$('#li_evgrd0'+i).addClass("type_red");
					} else {
						$('#li_evgrd0'+i).addClass("type_green");
					}
				}

				html  = evgrd_01_cnt + "명";
				html += '<span class="list_percent" data-graph-width="'+ parseInt(evgrd_01_per) + '">';
				html += '<em class="percent_text"></em></span>';
				html += '<span class="graph_hover">상위 1% : ' + evgrd_01_amt + '백만원</span>';
				$('#evgrd01').html("");
				$('#evgrd01').html(html);

				html  = evgrd_02_cnt + "명";
				html += '<span class="list_percent" data-graph-width="'+ parseInt(evgrd_02_per) + '">';
				html += '<em class="percent_text"></em></span>';
				html += '<span class="graph_hover">상위 5% : ' + evgrd_02_amt + '백만원</span>';
				$('#evgrd02').html("");
				$('#evgrd02').html(html);

				html  = evgrd_03_cnt + "명";
				html += '<span class="list_percent" data-graph-width="'+ parseInt(evgrd_03_per) + '">';
				html += '<em class="percent_text"></em></span>';
				html += '<span class="graph_hover">상위 10% : ' + evgrd_03_amt + '백만원</span>';
				$('#evgrd03').html("");
				$('#evgrd03').html(html);

				html  = evgrd_04_cnt + "명";
				html += '<span class="list_percent" data-graph-width="'+ parseInt(evgrd_04_per) + '">';
				html += '<em class="percent_text"></em></span>';
				html += '<span class="graph_hover">상위 20% : ' + evgrd_04_amt + '백만원</span>';
				$('#evgrd04').html("");
				$('#evgrd04').html(html);

				html  = evgrd_05_cnt + "명";
				html += '<span class="list_percent" data-graph-width="'+ parseInt(evgrd_05_per) + '">';
				html += '<em class="percent_text"></em></span>';
				html += '<span class="graph_hover">상위 20% 미만 : ' + evgrd_05_amt + '백만원</span>';
				$('#evgrd05').html("");
				$('#evgrd05').html(html);

			} else {
				html  = "0명";
				html += '<span class="list_percent" data-graph-width="'+ 0 + '">';
				html += '<em class="percent_text"></em></span>';
				$('#evgrd01').html(html);
				$('#evgrd02').html(html);
				$('#evgrd03').html(html);
				$('#evgrd04').html(html);
				$('#evgrd05').html(html);
			}
			//고객등급별 구성비 refresh
			var maxIndex2 = $(".graph_bar_list_2 li.graph_bar").length;
			for(var i=0; i<maxIndex2; i++){
				var val = $(".graph_bar_list_2 li.graph_bar").eq(i).find(".list_percent").attr('data-graph-width');
				var percent_text = $(".graph_bar_list_2 li.graph_bar").eq(i).find(".percent_text");

				$(".graph_bar_list_2 li.graph_bar").eq(i).find(".list_percent").css("width", val+"%");

				percent_text.text(val + "%")
			}

			//고객특성 요약
			if(cust_spec_text1 >= 0){ //여성 - 전년대비
				$('#cust_spec_text1').removeClass("down");
				$('#cust_spec_text1').text(cust_spec_text1 + "%"); //↑
			} else {
				cust_spec_text1 = bpn_toFixed(cust_spec_text1 * -1);
				$('#cust_spec_text1').addClass("down");
				$('#cust_spec_text1').text("▲" + cust_spec_text1 + "%"); //↓
			}
			if(cust_spec_text2 >= 0){ //여성 - 전월대비
				$('#cust_spec_text2').removeClass("down");
				$('#cust_spec_text2').text(cust_spec_text2 + "%"); //↑
			} else {
				cust_spec_text2 = bpn_toFixed(cust_spec_text2 * -1);
				$('#cust_spec_text2').addClass("down");
				$('#cust_spec_text2').text("▲" + cust_spec_text2 + "%"); //↓
			}
			if(cust_spec_text3 >= 0){ //남성 - 전년대비
				$('#cust_spec_text3').removeClass("down");
				$('#cust_spec_text3').text(cust_spec_text3 + "%"); //↑
			} else {
				cust_spec_text3 = bpn_toFixed(cust_spec_text3 * -1);
				$('#cust_spec_text3').addClass("down");
				$('#cust_spec_text3').text("▲" + cust_spec_text3 + "%"); //↓
			}
			if(cust_spec_text4 >= 0){ //남성 - 전월대비
				$('#cust_spec_text4').removeClass("down");
				$('#cust_spec_text4').text(cust_spec_text4 + "%"); //↑
			} else {
				cust_spec_text4 = bpn_toFixed(cust_spec_text4 * -1);
				$('#cust_spec_text4').addClass("down");
				$('#cust_spec_text4').text("▲" + cust_spec_text4 + "%"); //↓
			}
			
			if(cust_spec_text5 >= 0){ //전년동월대비 가장높은신장률
				$('#cust_spec_text5').removeClass("down");
				$('#cust_spec_text5').text(cust_spec_text5 + "%"); //↑
			} else {
				cust_spec_text5 = bpn_toFixed(cust_spec_text5 * -1);
				$('#cust_spec_text5').addClass("down");
				$('#cust_spec_text5').text("▲" + cust_spec_text5 + "%"); //↓
			}

			if(dong_flag){
				cust_spec_text9 = $('#dong_name1').attr("value") + " " + $('#dong_name1').attr("value2");
				cust_spec_text10 = "";
				if($('#dong_name2').attr("value2") != ""){
					cust_spec_text10 = $('#dong_name2').attr("value2");
				}
				if($('#dong_name3').attr("value2") != ""){
					if(cust_spec_text10!=""){ cust_spec_text10 += ">" }
					cust_spec_text10 += $('#dong_name3').attr("value2");
				}
				if($('#dong_name4').attr("value2") != ""){
					if(cust_spec_text10!=""){ cust_spec_text10 += ">" }
					cust_spec_text10 += $('#dong_name4').attr("value2");
				}
				if($('#dong_name5').attr("value2") != ""){
					if(cust_spec_text10!=""){ cust_spec_text10 += ">" }
					cust_spec_text10 += $('#dong_name5').attr("value2");
				}
				
/* 				cust_spec_text10 = $('#dong_name2').attr("value2") + ">"
				                 + $('#dong_name3').attr("value2") + ">"
				                 + $('#dong_name4').attr("value2") + ">"
				                 + $('#dong_name5').attr("value2"); */
				                 
				$('#cust_spec_text9').text(cust_spec_text9);
				$('#cust_spec_text10').text(cust_spec_text10);
				
			} else {
				$('#cust_spec_text9').text("-");
				$('#cust_spec_text10').text("-");
				
				html = '<span class="list_percent" data-graph-width="0">';
				html += '<em class="percent_text"></em></span>';
				$('#dong_name1').html(html);
				$('#dong_name2').html(html);
				$('#dong_name3').html(html);
				$('#dong_name4').html(html);
				$('#dong_name5').html(html);
			}
			
			if(exgrd_flag){
				$('#cust_spec_text11').text(cust_spec_text11);
				$('#cust_spec_text12').text(cust_spec_text12);
				$('#cust_spec_text13').text(cust_spec_text13);				
			} else {
				$('#cust_spec_text11').text("-");
				$('#cust_spec_text12').text("-");
				$('#cust_spec_text13').text("-");
			}
			
			
			$('#cust_spec_text14').text(cust_spec_text14+"%");
			$('#cust_spec_text15').text(cust_spec_text15+"%");
			$('#cust_spec_text16').text(cust_spec_text16+"%");
			$('#cust_spec_text17').text(cust_spec_text17+"%");
			
			
			if(fan_flag){
				//Fan
				jqplot_data_cust_fan = intFanArr;
				$('#graph_donut').html("");
				graph_donut = $.jqplot('graph_donut', [jqplot_data_cust_fan], getDonutChart(jqplot_data_cust_fan, fanAmtArr)); // 고객 특성 - FAN 고객 구성비				
			}
			
			loading_end();
		});}
	});

	//지역별 배출 비중 refresh
	var maxIndex = $(".graph_bar_list_1 li.graph_bar").length;

	for(var i=0; i<maxIndex; i++){
		var val = $(".graph_bar_list_1 li.graph_bar").eq(i).find(".list_percent").attr('data-graph-width');
		var percent_text = $(".graph_bar_list_1 li.graph_bar").eq(i).find(".percent_text");

		$(".graph_bar_list_1 li.graph_bar").eq(i).find(".list_percent").css("width", val+"%");

		percent_text.text(val + "%")
	}
	
}

//날짜계산
function dateAddDel(sDate, nNum, type) {
  var yyyy = parseInt(sDate.substr(0, 4), 10);
  var mm = parseInt(sDate.substr(4, 2), 10);
  var dd = parseInt(sDate.substr(6, 2), 10);
  var monArr=new Array(31,28,31,30,31,30,31,31,30,31,30,31);    
  if (type == "d") {
   d = new Date(yyyy, mm-1, dd + nNum);
  } else if (type == "m") {
    if((mm-1 + nNum)!="1") {
        var amm = "";
        if((mm-1 + nNum)>=0)
        {
          if((mm-1 + nNum)<12)
            amm = mm-1 + nNum;
          else
            amm = mm-1 + nNum-12;
        }
        else
        {
          amm = mm-1 + nNum+12;
        }
        var dd2 = monArr[Number(amm)];
        if(dd>=dd2)
          dd=dd2;
      }
      else {
        if((yyyy%4==0 && yyyy%100!=0) || yyyy%400==0) {
          if(dd>29)
              dd=29;
        }
        else {
        if(dd>28)
          dd=28;
        }
      }
   d = new Date(yyyy, mm-1 + nNum, dd);
  } else if (type == "y") {
   d = new Date(yyyy + nNum, mm - 1, dd);
  }
  yyyy = d.getFullYear();
  mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;
  dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;
  return '' + yyyy + '' +  mm  + '' + dd;
}

/**
* 날짜계산기
* 아무것도 안던지면 오늘날짜 반환
* 오늘일자 기준 년,월,일 +- 계산해드림 
* @param addYear : 년도계산 +10, -10 등등
* @param addMonth : 월계산 +10, -10 등등
* @param addDay : 일자계산 +10, -10 등등 
* @param token : 기본값 "-"
* @return yyyy-mm-dd
*/
function getDate(sDate, addYear, addMonth, addDay, token)
{
	 var yyyy = parseInt(sDate.substr(0, 4), 10);
	 var mm = parseInt(sDate.substr(4, 2), 10);
	 var dd = parseInt(sDate.substr(6, 2), 10);
  
    token = token == undefined || token == null ? "-" : token;
    addYear = addYear == null ? 0 : addYear;
    addMonth = addMonth == null ? 0 : addMonth;
    addDay = addDay == null ? 0 : addDay;
    var now = new Date(yyyy, mm-1, dd);
    var ry = now.getFullYear();
    var rm = now.getMonth() + 1;
    var rd = now.getDate();
    
    if(addYear != 0) { //cal year
        ry = ry + addYear;
    }
    
    if(addMonth != 0) {//cal month
        var isRun = true;
        rm = rm + addMonth;
        while (isRun == true) {
            if(rm > 12){
                ry++;
                rm = rm - 12;
            } else if(rm < 1) {
                ry--;
                rm = 12 + rm;
            }
            
            if(rm > 0 && rm < 13){
                isRun = false;
            }
        }
    }
    var cal = new Date(ry, rm, 0);
    if(rd > cal.getDate())
        rd = cal.getDate();
    if (addDay != 0) {
        rd = rd + addDay;
        if(rd > cal.getDate() || rd < 1) {
            var isRun = true;
            while(isRun == true) {
                if(rd > cal.getDate()) {
                    rd = rd - cal.getDate();
                    rm++;
                    if (rm > 12) {
                        ry++;
                        rm = 1;
                    }
                }
                if(rd < 1) { 
                    rm--;
                    if(rm < 1) { 
                        ry--;
                        rm = 12;
                    }
                    cal = new Date(ry, rm, 0);
                    rd = cal.getDate() + rd;
                }
                cal = new Date(ry, rm, 0);
                if(rd <= cal.getDate() && rd >= 1)
                    isRun = false;
            }
        }
        if(rd > cal.getDate() || rd < 1) {
            cal = new Date(ry, rm, 0);
        }
    }
        
    if(rm.toString().length < 2) rm = '0' + rm;
    if(rd.toString().length < 2) rd = '0' + rd;
    
    return ry + token + rm + token + rd;
}

//조회기간 디폴트 셋팅
function setSearchCndt (){
	
	var openYear = "2020";
	var year = toDay_yyyy;
	
	html = "";
	for(var i=parseInt(openYear); i<=parseInt(toDay_yyyy); i++){
		html += "<option value='" + i + "'>" + i + "년</option>";
	}
	
	$('#year_cd').html("");
	$('#year_cd').append(html);
	$("#year_cd").val(cndToDay.substr(0,4)).prop("selected", true);

	$('#onOffTp').text("오프라인");

}

//년도 selectbox선택 이벤트
function fn_changeYear(){
	var year = $('#year_cd').val();
	//선택한년도가 현재연도와 다르면 1~12월표시
	html = "";
	var month = "";
	var temp_day = toDay_yyyy+"0101";
	$('#month_cd').html("");
	for(var i=0; i<12; i++){
		month = getDate(temp_day,0,i,0,'').substr(4,2);
		if(toDay_yyyy != year || (toDay_yyyy == year && toDay_MM > month)){
			html += "<option value='" + month + "'>" + month + "월</option>";
		}
	}
	$('#month_cd').html("");
	$('#month_cd').append(html);
	
	//기준일 참조
	loading_start(getStdYm);
}

//월 selectbox선택 이벤트
function fn_changeMonth(){
	//기준일 참조
	loading_start(getStdYm);
}

function pad(n, width) {
	  n = n + '';
	  return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function AddComma(num) {
    if(num == 0) return "-";
    var regexp = /\B(?=(\d{3})+(?!\d))/g;
    return num.toString().replace(regexp, ',');
}

function financial(x) {
	return Number.parseFloat(x).toFixed(1);
}
	
//하이라이트-매출요약 그래프셋팅
function fn_getLineConfig1(flag,intRateArr){

	var lineConfig = {
			animate: true,                          //animation 설정
			seriesColors:['#0fb5bf', '#887ae4'],
            seriesDefaults:{
                shadow:false,
                markerOptions : {
                    shadow: false
                },
                rendererOptions: {
                    varyBarColor: true,
                    smooth: true,
                    animation: {
                        speed: 2500
                    },
                },
                pointLabels: {show: false}
            },
/* 	        seriesDefaults:{
	            shadow:false,
	            markerOptions : {
					shadow: false
				},
	            rendererOptions: {
	            	varyBarColor: true
	            },
	            pointLabels: {show: false}
	        }, */
	        grid: {
	            background: '#fff',
	            border:'0',
	            borderColor: '#fff',
	            gridLineColor: '#e9e9e9',//'#000000',//'#fbfbfb',
	            shadow: false
	        },
	        axes: {
	            xaxis: {
	                renderer: $.jqplot.CategoryAxisRenderer,
					tickOptions: { // y 라인 삭제
					    showGridline: false,
					    showMark: false
					 	},
					},
				yaxis: {
						min:0,
					     //ticks: Yticks
					     tickOptions: {
					    	 formatString: "%'d백만원"
						}
					}
	        },
		    highlighter: {
		        show: true,
		        tooltipContentEditor: function (str, seriesIndex, pointIndex, plot) {
		        	
		        	if(!flag){
		        		return
		        	}
		        	
		        	var one = bpn_toFixed(plot.data[seriesIndex][pointIndex][1],0);
		        	var two = bpn_toFixed(intRateArr[seriesIndex][pointIndex][1]); 
		        	
		            var html = "<div style='padding: 20px; background:#303945; color:#fff; '>";
		            html += "<span style='display:inline-block; font-size:14px; line-height: 14px;'>";
		            html += "매출" + " : ";
		            html += AddComma(one);
		            html += "백만원</span>";
		            html += "  <br><span style='display:inline-block; margin-top:10px; font-size:14px; line-height: 14px;'>";
		            html += "신장률" + " : ";
		        	if(two < 0){
		        		two = two * -1;
		        		html += "▲"
		        	}
		            html += AddComma(two);
		            html += "%</span>";
		            html += "  </div>";
		
		            return html;
		        }
		    },
	        cursor: {
	          show: false
	        }

		};
	return lineConfig;
}

//막대 차트
function fn_getChartConfig(xAxis, ageAmtArr)
{

	var chartConfig = {
			seriesColors:['#0fb5bf', '#87dcff'],
			seriesDefaults : {
				pointLabels: {
		            show: true,
		            formatString: '%s %%'
		        },
				renderer		: $.jqplot.BarRenderer,
				shadow: false,
	            rendererOptions: {
	              // Set varyBarColor to tru to use the custom colors on the bars.
	              varyBarColor: true,
	              barMargin: 30,
	              barWidth: 19
	          }
			},
			legend	: {
				show			: false,
			},
			axes	: {
				xaxis	: {
					renderer	: $.jqplot.CategoryAxisRenderer,
					ticks		: xAxis,
					tickRenderer: $.jqplot.CanvasAxisTickRenderer,
					tickOptions: {
			            fontFamily:'Nanum Gothic, sans-serif',
			            fontWeight:'bold',
						fontSize: '14px',
			            color:'#6c6f75'
		           }
				},
				yaxis	: {
					tickOptions : {
						show: false
					}
				}
			},
		    highlighter: {
		        show: true, 
		        useAxesFormatters: false,
		        tooltipContentEditor: function (str, seriesIndex, pointIndex, plot) {
		        	var one = plot.axes.xaxis.ticks[pointIndex];
		        	var two = ageAmtArr[pointIndex];
		        	
		            var html = "<div style='padding: 20px; background:#303945; color:#fff; '>";
		            html += "<span style='display:inline-block; font-size:14px; line-height: 14px;'>";
		            html += one + " : " + two;
		            html += "백만원</span>";
		            html += "  </div>";
		
		            return html;
		        }
		    }
		};
		return chartConfig;
}

//막대 차트
function fn_getChartConfig_2(xAxis, stlmMnsArr)
{

	var chartConfig = {
		seriesColors:['#0fb5bf', '#87dcff'],
		seriesDefaults : {
			pointLabels: {
	            show: true,
	            formatString: '%s %%'
	        },
			renderer		: $.jqplot.BarRenderer,
			shadow: false,
        rendererOptions: {
            // Set varyBarColor to tru to use the custom colors on the bars.
            varyBarColor: true,
            barMargin: 30,
            barWidth: 19
        }
		},
		legend	: {
			show			: false,
		},
		axes	: {
			xaxis	: {
				renderer	: $.jqplot.CategoryAxisRenderer,
				ticks		: xAxis,
				tickRenderer: $.jqplot.CanvasAxisTickRenderer,
	           labelOptions: {
		            fontFamily:'Nanum Gothic, sans-serif',
		            fontWeight:'Bold',
					fontSize: '15px',
		            color:'#6c6f75'
	           }
			},
			yaxis	: {
				tickOptions : {
					show: false
				}
			}
		},
	    highlighter: {
	        show: true, 
	        useAxesFormatters: false,
	        tooltipContentEditor: function (str, seriesIndex, pointIndex, plot) {
				
	        	var one = plot.axes.xaxis.ticks[pointIndex];
	        	var two = stlmMnsArr[pointIndex];
	        	
	            var html = "<div style='padding: 20px; background:#303945; color:#fff; '>";
	            html += "<span style='display:inline-block; font-size:14px; line-height: 14px;'>";
	            html += one + " : " + two;
	            html += "백만원</span>";
	            html += "  </div>";
	
	            return html;
	        }
	    }
	};
	return chartConfig;
}

//막대 차트
function fn_getChartConfig_3(xAxis, sColor, daywArr) 
{

	var chartConfig = {
		seriesColors:sColor,
		seriesDefaults : {
			pointLabels		: {
				show : true,
	            formatString: '%s %%'
	        },
			renderer		: $.jqplot.BarRenderer,
			shadow: false,
		      rendererOptions: {
		          // Set varyBarColor to tru to use the custom colors on the bars.
		          barDirection: 'horizontal',
		          varyBarColor: true,
		          barMargin: 30,
		          barWidth: 19
              }
		},
		legend	: {
			show			: false,
		},
		axes	: {
			xaxis	: {
				tickOptions : {
					show: false
				}
			},
			yaxis	: {
			   renderer	: $.jqplot.CategoryAxisRenderer,
			   ticks		: xAxis,
			   tickRenderer: $.jqplot.CanvasAxisTickRenderer,
	           labelOptions: {
		            fontFamily:'Nanum Gothic, sans-serif',
		            fontWeight:'Bold',
					fontSize: '15px',
		            color:'#6c6f75'
	           }
			}
		},
	    highlighter: {
	        show: true,
	        tooltipContentEditor: function (str, seriesIndex, pointIndex, plot) {
	        	
	        	var one = daywArr[pointIndex];
	        	var yaxis = plot.axes.yaxis.ticks[pointIndex];
	        	
	            var html = "<div style='padding: 20px; background:#303945; color:#fff; '>";
	            html += "<span style='display:inline-block; font-size:14px; line-height: 14px;'>";
	            html += yaxis + " : ";
	            html += AddComma(one);
	            html += "백만원</span>";
	            html += "  </div>";
	
	            return html;
	        }
	    }
		
	};
	return chartConfig;
}

function getDonutChart(data, fanAmtArr){
	var chartConfig = {
			seriesColors:['#0fb5bf', '#71d2f3'],
			seriesDefaults: {
			      // make this a donut chart.
			      renderer:$.jqplot.DonutRenderer,
			      shadow: false,
			      rendererOptions:{
				        // Donut's can be cut into slices like pies.
				        sliceMargin: 0,
				        // Pies and donuts can start at any arbitrary angle.
				        startAngle: -90,
				        showDataLabels: true
			      }
		    },
            cursor: {
                showTooltip: false,
                followMouse: false,
                showTooltipDataPosition: false,
                zoom: true,
                intersectionThreshold: 6,
                tooltipFormatString: 'Height:%s'
            },
		    highlighter: {
		        show: true, 
		        useAxesFormatters: false,
		        tooltipContentEditor: function (str, seriesIndex, pointIndex, plot) {
		        	var one = plot.data[0][pointIndex][0];  
		        	var two = fanAmtArr[pointIndex];
		        	
		            var html = "<div style='padding: 20px; background:#303945; color:#fff; '>";
		            html += "<span style='display:inline-block; font-size:14px; line-height: 14px;'>";
		            html += one + " : ";
		            html += AddComma(two);
		            html += "백만원</span>";
		            html += "  </div>";
		
		            return html;
		        }
		    }
	};
	return chartConfig;
}

/* function getDonutChart_2(data){
	 var chartConfig = {
           seriesColors:['#ff6a81', '#7087d6', '#71d2f3', '#0fb5bf'],
			 seriesDefaults: {
			      // make this a donut chart.
			      renderer:$.jqplot.DonutRenderer,
			      shadow: false,
			      rendererOptions:{
			        // Donut's can be cut into slices like pies.
			        sliceMargin: 0,
			        // Pies and donuts can start at any arbitrary angle.
			        startAngle: -90,
			        showDataLabels: true
			      }
		     }
   };
	return chartConfig;
} */

function getDonutChart_2(data){
	 var chartConfig = {
	         seriesColors:['#ff6a81', '#7087d6', '#0fb5bf', '#71d2f3'],
			 seriesDefaults: {
			      // make this a donut chart.
			      renderer:$.jqplot.DonutRenderer,
			      shadow: false,
			      rendererOptions:{
			        // Donut's can be cut into slices like pies.
			        sliceMargin: 0,
			        // Pies and donuts can start at any arbitrary angle.
			        startAngle: -90,
			        showDataLabels: true
			      }
		     },
			    highlighter: {
			        show: true, 
			        useAxesFormatters: false,
			        tooltipContentEditor: function (str, seriesIndex, pointIndex, plot) {
			        	
			        	var one = plot.data[0][pointIndex][0]; 
			        	var two = plot.data[0][pointIndex][1]; 
			        	 
			            var html = "<div style='padding: 20px; background:#303945; color:#fff; '>";
			            html += "<span style='display:inline-block; font-size:14px; line-height: 14px;'>";
			            html += one + " : ";
			            html += two;
			            html += "백만원</span>";
			            html += "  </div>";
			
			            return html;
			        }
			    }
   };
	return chartConfig;
}

function getDonutChart_3(data, color,tmsltArr){

	// ['#0fb5bf', '#0fb5bf', '#0fb5bf', '#0fb5bf', '#0fb5bf', '#0fb5bf', '#887ae4', '#ff6a81', '#0fb5bf', '#0fb5bf', '#0fb5bf', '#0fb5bf']
	 var chartConfig = {
           seriesColors: color,
			 seriesDefaults: {
			      // make this a donut chart.
			      renderer:$.jqplot.DonutRenderer,
			      shadow: false,
			      rendererOptions:{
			        // Donut's can be cut into slices like pies.
			        sliceMargin: 2,
			        // Pies and donuts can start at any arbitrary angle.
			        startAngle: -90
			      }
		     },
			    highlighter: {
			        show: true, 
			        useAxesFormatters: false,
			        tooltipContentEditor: function (str, seriesIndex, pointIndex, plot) {
			        	
			        	var one = plot.data[0][pointIndex][1]; 
			        	var two = tmsltArr[pointIndex];
			        	
			            var html = "<div style='padding: 20px; background:#303945; color:#fff; '>";
			            html += "<span style='display:inline-block; font-size:14px; line-height: 14px;'>";
			            html += "매출" + " : ";
			            html += two;
			            html += "백만원</span>";
			            html += "  </div>";
			
			            return html;
			        }
			    }
   };
	return chartConfig;
}


function validation_check(){

	yyyy_mm = $('#year_cd').val() + $('#month_cd').val();
	on_off_cl_cd = $('input[name="on_off_cl_cd"]:checked').val();
	cstr_cd = $('#cstr_cd').val();
	brnd_cd = $('#brnd_cd').val();
	
	if($('#year_cd').val() == ""){
		alert('<%=MessageUtil.getMsg("MSG.CMPGN.ALERT.000088")%>'); //년도를 선택해주세요.
		return true;
	}
	
	if($('#month_cd').val() == ""){
		alert('<%=MessageUtil.getMsg("MSG.CMPGN.ALERT.000089")%>'); //월을 선택해주세요.
		return true;
	}
	
	if($('#cstr_cd').val() == ""){
		alert('<%=MessageUtil.getMsg("MSG.CMPGN.ALERT.000054")%>'); //점을 선택해주세요.
		return true;
	}
	if($('#brnd_cd').val() == ""){
		alert('<%=MessageUtil.getMsg("MSG.CMPGN.ALERT.000057")%>'); //브랜드를 선택해주세요.
		return true;
	}

	return false;
}

function report_slide(thisobj) {
	var $this = $(thisobj);
	var $order = $(thisobj).attr("data-report");

	if(validation_check()){
		return;
	}

	if($order == "1"  && !$this.hasClass("on")) {
		getCustInfo();     //고객특성
	} else if($order == "2"  && !$this.hasClass("on")) {
		getPurchaseInfo(); //구매특성
	}
	
	$this.toggleClass("on").closest(".m_report_area").find(".slide_area").slideToggle(500);

}

</script>
<style>
.bpn_wrap .jqplot-highlighter-tooltip, .bpn_wrap .jqplot-canvasOverlay-tooltip {
    overflow: hidden;
    border: 0 none;
    padding:0;
    border-radius: 8px;
    z-index: 100; 
}
.bpn_wrap .graph_wrap.type_line{
overflow:visible;
}
.bpn_wrap .graph_wrap.type_line .graph_list {
	-webkit-border-radius: 10px;
	-ms-border-radius: 10px;
	border-radius: 10px;
    border: 1px solid rgb(21, 183, 192);
}
</style>
</head>
<body class="bpn_wrap">
	<div class="frameWrap">
		<div class="subCon">
			<div class="subConIn">
				<!-- 인사이트 레포트 -->
				<div class="report_title">
					<h3 class="title">이달의 레포트</h3>
				</div>
				<div class="report_inquiry">
					<p class="desc">
						조회기간 조회
						<em>* 인사이트 리포트는 매월 1일 정기 업데이트 됩니다.</em>
					</p>
					<div class="inquiry_wrap type_half">
						<div class="inquiry_left">
							<div class="input_btn">
								<div class="type_btn" style="width: 235px;">
									<span class="txt_pw">
										<input type="hidden" id="cstr_cd" name="cstr_cd" style="width: 235px;" class="type_disabled" tabindex="-1">
										<input type="text" id="cstr_nm" name="cstr_nm" style="width: 235px;" class="type_disabled" tabindex="-1">
										<!-- <input type="hidden" id="cstr_cd" name="cstr_cd"> -->
									</span>
									<button type="button" id="btn_search" class="search_btn " onclick="fn_cstrPop()">
										<img src="<%=_s3_bpn_url%>/pandora3/images/lotte_bpn/img_magnify.png" alt="돋보기">
									</button>
								</div>
								<div class="type_btn" style="width: 235px; margin-left:2%">
									<span class="txt_pw"> 
										<input type="hidden" id="brnd_cd" name="brnd_cd" style="width: 235px;" class="type_disabled" tabindex="-1">
										<input type="text" id="brnd_nm" name="brnd_nm" style="width: 235px; text-overflow: ellipsis;" class="type_disabled" tabindex="-1">
										<!-- <input type="hidden" id="brnd_cd" name="brnd_cd"> -->
									</span>
									<button type="button" id="btn_search" class="search_btn " onclick="fn_brndPop()">
										<img src="<%=_s3_bpn_url%>/pandora3/images/lotte_bpn/img_magnify.png" alt="돋보기">
									</button>
								</div>
							</div>
						</div>
					</div>
					<div class="inquiry_wrap type_half">
						<div class="inquiry_left">
							<span class="txt_pw">
								<select class="select" id="year_cd" onchange="fn_changeYear()">
								</select>
							</span>
							<span class="txt_pw">
								<select class="select" id="month_cd" onchange="fn_changeMonth()">
								</select>
							</span>
						</div>
						<div class="inquiry_right">
							<div class="radio_area">
								<div class="m_radio_wrap">
									<input type="radio" id="on_off_cl_cd_1" name="on_off_cl_cd" value="1">
									<label for="on_off_cl_cd_1">오프라인</label>
								</div>
								<div class="m_radio_wrap">
									<input type="radio" id="on_off_cl_cd_2" name="on_off_cl_cd" value="2" checked>
									<label for="on_off_cl_cd_2">온라인</label>
								</div>
							</div>
							<div class="m_btn_wrap">
								<button type="button" class="m_btn_default full" onclick="fn_Search()">조회</button>
							</div>
						</div>
					</div>

				</div>

				<div class="m_report_area type_sub">
					<!-- <p class="insite_sub_title">본점(0001) 설화수(0003418)</p> -->
					<h4 class="title">하이라이트</h4>
					<div class="graph_wrap type_line">
						<div class="graph_list">
							<div class="high_light">
								<h2 class="title">매출 요약</h2>
								<div id="graph_line" style="width:100%; height:240px;"></div>
								<span class="xaxis_title">월</span>
							    <ul class="graph_kinds">
							      	<li class="type_green">내 브랜드 매출</li>
							      	<li class="type_purple">동일ZONE 평균매출</li>
							    </ul>
							</div>
						</div>
					</div>
					<div class="report_saleslist">
						<div class="sales_area" style="border: 1px solid #71d2f3;">
							<p class="desc">총 매출 실적</p>
							<ul class="list">
								<li>
									<span class="left_text" id="all_sales_11">-</span>
									<span class="top_text" id="all_sales_12">-</span>
									<span class="bottom_text" id="all_sales_13">-</span>
								</li>
								<li>
									<span class="left_text">ZONE구성비</span>
									<span class="top_text" id="all_sales_22">-</span>
									<span class="bottom_text" id="all_sales_23">-</span>
								</li>
								<li>
									<span class="left_text">전년 대비 <em>(신장률)</em></span>
									<span class="top_text" id="span_all_sales_32"><em id="all_sales_32">-</em></span>
									<span class="bottom_text" id="all_sales_33">-</span>
								</li>
								<li>
									<span class="left_text">전월 대비<em>(신장률)</em></span>
									<span class="top_text" id="span_all_sales_42"><em id="all_sales_42">-</em></span>
									<span class="bottom_text" id="all_sales_43">-</span>
								</li>
							</ul>
						</div>
						<div class="sales_area">
							<p class="desc"><span id="onOffTp">오프라인</span> 매출 실적</p>
							<ul class="list">
								<li>
									<span class="left_text" id="off_sales_11">-</span>
									<span class="top_text" id="off_sales_12">-</span>
									<span class="bottom_text" id="off_sales_13">-</span>
								</li>
								<li>
									<span class="left_text">ZONE구성비</span>
									<span class="top_text" id="off_sales_22">-</span>
									<span class="bottom_text" id="off_sales_23">-</span>
								</li>
								<li>
									<span class="left_text">전년 대비<em>(신장률)</em></span>
									<span class="top_text" id="span_off_sales_32"><em id="off_sales_32">-</em></span>
									<span class="bottom_text" id="off_sales_33">-</span>
								</li>
								<li>
									<span class="left_text">전월 대비<em>(신장률)</em></span>
									<span class="top_text" id="span_off_sales_42"><em id="off_sales_42">-</em></span>
									<span class="bottom_text" id="off_sales_43">-</span>
								</li>
							</ul>
						</div>
						<div class="sales_area">
							<p class="desc">회원</p>
							<ul class="list">
								<li>
									<span class="left_text">매출</span>
									<span class="top_text"><em id="cust_sales">-</em></span>
								</li>
								<li>
									<span class="left_text">고객 수</span>
									<span class="top_text"><em id="cust_cnt">-</em></span>
								</li>
								<li>
									<span class="left_text">객단가</span>
									<span class="top_text"><em id="cust_price">-</em></span>
								</li>
							</ul>
							<p class="desc type_second">비회원</p>
							<ul class="list type_second">
								<li>
									<span class="left_text">매출</span>
									<span class="top_text"><em id="cust_sales2">-</em></span>
								</li>
							</ul>
						</div>
					</div>
					<div class="report_more_info">
						<ul class="list">
						   <li>* <span id="now_mm"></span>월 총 매출액은 <strong id="highlight_text1">-</strong>으로, 전년 신장률 <strong id="highlight_text2">-</strong>, 전월 신장률 <strong id="highlight_text3">-</strong> 입니다.</li>
						   <li>* 동일 ZONE 평균 매출 대비 <strong id="highlight_text12">-</strong>, 신장률은 <strong id="highlight_text13">-</strong></li>
						   <li>* 매출액이 가장 높은 월은   <strong id="highlight_text5">-</strong>(<strong id="highlight_text4">-</strong>), 매출액이 가장 낮은 월은 <strong id="highlight_text7">-</strong>(<strong id="highlight_text6">-</strong>) 입니다.</li>
						   <!-- <li>* 당해연도 신장률이 가장 높은 월은 <strong id="highlight_text8">-</strong>를 기록한 <strong id="highlight_text9">-</strong>이며, 신장률이 가장 낮은 월은 <strong id="highlight_text10">-</strong>를 기록한 <strong id="highlight_text11">-</strong>입니다.</li> -->
						</ul>
					</div>
				</div>
				<div class="m_report_area">
					<h4 class="title"> 고객 특성 
						<span class="question"><img src="<%=_s3_bpn_url%>/pandora3/images/lotte_bpn/img_trd_qs.png" alt="물음표이미지" title="고객 특성 데이터의 구성비(%)는 매출금액 비중을 나타내며, 수(명)는 구매고객 수를 표시합니다."></span>
						<button type="button" class="toggle_btn" data-report="1" onclick="report_slide(this)"><img src="<%=_s3_bpn_url%>/pandora3/images/lotte_bpn/img_gray_arrow.png" alt="화살표"></button>
					</h4>
					<div class="slide_area">
						<p class='no_data' id="view1_false" style="display:none;">분석 가능한 데이터가 없어 결과값이 제공되지 않습니다.</p>
						<div id="view1_true">
							<div class="analysis_chart_area no_sub_title">
								<div class="graph_wrap type_half">
					         		<div class="graph_list type_6">
										 <div class="bar type_sky type_age">
											  <p class="custom_graph_title">성별/연령별 매출 비중</p>
										      <ul class="graph_kinds">
										      	<li class="total">총 <strong id="cust_all_cnt">-</strong>명</li>
										      	<li class="man"><strong id="cust_man_cnt">-</strong>명</li>
										      	<li class="woman"><strong id="cust_woman_cnt">-</strong>명</li>
										      </ul>
										      <div id="graph_age" style="width: 350px; height: 200px; !important; margin:0 auto; "></div>
										      <span class="xaxis_title">연령</span>
										 </div>
					         		</div>
					         		<div class="graph_list type_4">
										<div class="bar custom_graph type_region">
											<p class="custom_graph_title">지역별 매출 비중</p>
											<ol class="graph_bar_list_1 list">
												<li class="graph_bar type_green">
													<span class="count">01</span>
													<p class="desc" id="dong_name1">-
														<span class="list_percent" data-graph-width="0">
															<em class="percent_text"></em>
														</span>
													</p>
												</li>
												<li class="graph_bar type_blue">
													<span class="count">02</span>
													<p class="desc" id="dong_name2">-
														<span class="list_percent" data-graph-width="0">
															<em class="percent_text"></em>
														</span>
													</p>
												</li>
												<li class="graph_bar type_green">
													<span class="count">03</span>
													<p class="desc" id="dong_name3">-
														<span class="list_percent" data-graph-width="0">
															<em class="percent_text"></em>
														</span>
													</p>
												</li>
												<li class="graph_bar type_blue">
													<span class="count">04</span>
													<p class="desc" id="dong_name4">-
														<span class="list_percent" data-graph-width="0">
															<em class="percent_text"></em>
														</span>
													</p>
												</li>
												<li class="graph_bar type_green">
													<span class="count">05</span>
													<p class="desc" id="dong_name5">-
														<span class="list_percent" data-graph-width="0">
															<em class="percent_text"></em>
														</span>
													</p>
												</li>
											</ol>
										</div>
					         		</div>
								</div>
							</div>
							<div class="analysis_chart_area no_sub_title type_construction">
								<div class="graph_wrap type_three">
									<div class="graph_list">
										 <div class="bar" style="padding-top:0;">
										 	<p class="custom_graph_title">고객등급별 구성비</p>
										 	<div id="graph_donut_2" style="width:250px; height:280px;"></div>
										    <ul class="graph_kinds type_bottom">
										      	<li class="type_red">AVENUEL</li>
										      	<li class="type_blue">MVG</li>
										      	<li class="type_sky">VIP</li>
										      	<li class="type_green">일반</li>
										    </ul>
										 </div>
									</div>
					         		<div class="graph_list">
										<div class="bar custom_graph type_config">
											<p class="custom_graph_title">고객 RANK별 구성비</p>
											<ol class="graph_bar_list_2 list">
												<li class="graph_bar type_green" id="li_evgrd01">
													<span class="count">상위 1%</span>
													<p class="desc" id="evgrd01">0명
														<span class="list_percent" data-graph-width="5">
															<em class="percent_text">%</em>
														</span>
													</p>
												</li>
												<li class="graph_bar type_green" id="li_evgrd02">
													<span class="count">상위 5%</span>
													<p class="desc" id="evgrd02">0명
														<span class="list_percent" data-graph-width="5">
															<em class="percent_text">%</em>
														</span>
													</p>
												</li>
												<li class="graph_bar type_green" id="li_evgrd03">
													<span class="count">상위 10%</span>
													<p class="desc" id="evgrd03">0명
														<span class="list_percent" data-graph-width="5">
															<em class="percent_text">%</em>
														</span>
													</p>
												</li>
												<li class="graph_bar type_green" id="li_evgrd04">
													<span class="count">상위 20%</span>
													<p class="desc" id="evgrd04">0명
														<span class="list_percent" data-graph-width="5">
															<em class="percent_text">%</em>
														</span>
													</p>
												</li>
												<li class="graph_bar type_green" id="li_evgrd05">
													<span class="count type_small">상위 20%미만</span>
													<p class="desc" id="evgrd05">0명
														<span class="list_percent" data-graph-width="5">
															<em class="percent_text">%</em>
														</span>
													</p>
												</li>
											</ol>
										</div>
					         		</div>
					         		<div class="graph_list">
										 <div class="bar" style="padding-top:0;">
										 	<p class="custom_graph_title">FAN 고객 구성비</p>
										 	<div id="graph_donut" style="width:250px; height:280px;"></div>
										    <ul class="graph_kinds type_bottom">
										      	<li class="type_sky">FAN 고객</li>
										      	<li class="type_green">일반 고객</li>
										    </ul>
										 </div>
					         		</div>
								</div>
							</div>
							<div class="report_more_info">
								<ul class="list">
									<li>* 여성고객 매출은 전년 신장률 <strong id="cust_spec_text1">-</strong>, 전월 신장률 <strong id="cust_spec_text2">-</strong>이며, 남성고객 매출은 전년 신장률 <strong id="cust_spec_text3">-</strong>, 전월 신장률 <strong id="cust_spec_text4">-</strong> 입니다.</li>
									<li>* 전년 대비 가장 높은 신장률을 달성한 연령대는 <strong id="cust_spec_text6">-</strong>(<strong id="cust_spec_text5">-</strong>)이며, 가장 낮은 신장률을 달성한 연령대는 <strong id="cust_spec_text7">-</strong>(<strong id="cust_spec_text8">-</strong>) 입니다. </li>
									<li>* 매출 비중이 가장 높은 지역은 <strong id="cust_spec_text9">-</strong>이며, <strong id="cust_spec_text10">-</strong> 순 입니다.</li>
									<li>* 고객등급 중 가장 높은 매출 비중은 <strong id="cust_spec_text11">-</strong>(<strong id="cust_spec_text12">-</strong>)이며, 전월대비 신장률이 가장 높은 고객등급은 <strong id="cust_spec_text13">-</strong> 입니다.</li>
									<li style="font-size: 14px;">(※ 동일 ZONE 고객등급별 매출구성비 : AVENUEL <strong id="cust_spec_text14">0%</strong>, MVG <strong id="cust_spec_text15">0%</strong>, VIP <strong id="cust_spec_text16">0%</strong>, 일반 <strong id="cust_spec_text17">0%</strong>)</li>
								</ul>
							</div>						
						</div>
					</div>
				</div>
				<div class="m_report_area">
					<h4 class="title"> 구매 특성 <button type="button" class="toggle_btn" data-report="2" onclick="report_slide(this)"><img src="<%=_s3_bpn_url%>/pandora3/images/lotte_bpn/img_gray_arrow.png" alt="화살표"></button></h4>
					<div class="slide_area">
						<p class='no_data' id="view2_false" style="display:none;">분석 가능한 데이터가 없어 결과값이 제공되지 않습니다.</p>
						<div id="view2_true">
							<div class="analysis_chart_area no_sub_title">
								<div class="graph_wrap type_half">
					         		<div class="graph_list type_6">
										<div class="bar custom_graph">
											<p class="custom_graph_title">요일/시간별 매출 비중</p>
											<div class="chart_two_area">
												<div class="chart_1">
													<div id="graph_days" style="width: 162px; height: 250px !important; margin:0 auto;"></div>
												</div>
												<div class="chart_2">
													<div id="graph_donut_3" style="width: 300px; height: 250px !important; margin:0 auto;"></div>
													<ol class="hours_list" id="hours_list">
														<li>10시</li>
														<li>11시</li>
														<li>12시</li>
														<li>13시</li>
														<li>14시</li>
														<li>15시</li>
														<li>16시</li>
														<li>17시</li>
														<li>18시</li>
														<li>19시</li>
														<li>20시</li>
														<li>21시</li>
													</ol>
												</div>
											</div>
										</div>
					         		</div>
					         		<div class="graph_list type_4" id="graph_dim1">
										 <div class="bar type_sky">
											  <p class="custom_graph_title">결제수단별 이용 비중</p>
										      <div id="graph_pay" style="width: 320px; height: 245px !important; margin:25px auto 0;"></div>
										 </div>
					         		</div>
								</div>
							</div>
	
							<div class="analysis_chart_area type_brands no_sub_title">
								<div class="graph_wrap type_half">
					         		<div class="graph_list type_5" id="graph_dim2">
										<div class="bar custom_graph">
											<p class="custom_graph_title">유사 브랜드 TOP5<img style="margin-top: 2px;" src="<%=_s3_bpn_url%>/pandora3/images/lotte_bpn/img_trd_qs.png" alt="물음표이미지" title="<%=MessageUtil.getMsg("MSG.CMPGN.TOOLTIP.002001")%>"></p>
										    <div class="brands_order_list">
												<ul class="order_list">
													<li>
														<span class="desc" id="smlr_brnd_nm1">-</span>
													</li>
													<li>
														<span class="desc" id="smlr_brnd_nm2">-</span>
													</li>
													<li>
														<span class="desc" id="smlr_brnd_nm3">-</span>
													</li>
													<li>
														<span class="desc" id="smlr_brnd_nm4">-</span>
													</li>
													<li>
														<span class="desc" id="smlr_brnd_nm5">-</span>
													</li>
												</ul>
											</div>
										</div>
					         		</div>
					         		<div class="graph_list type_5">
										 <div class="bar type_sky">
											  <p class="custom_graph_title">연관 브랜드 TOP5<img style="margin-top: 2px;" src="<%=_s3_bpn_url%>/pandora3/images/lotte_bpn/img_trd_qs.png" alt="물음표이미지" title="<%=MessageUtil.getMsg("MSG.CMPGN.TOOLTIP.002002")%>"></p>
											<div class="brands_order_list">
												<ul class="order_list">
													<li>
														<span class="desc" id="asct_brnd_nm1">-</span>
													</li>
													<li>
														<span class="desc" id="asct_brnd_nm2">-</span>
													</li>
													<li>
														<span class="desc" id="asct_brnd_nm3">-</span>
													</li>
													<li>
														<span class="desc" id="asct_brnd_nm4">-</span>
													</li>
													<li>
														<span class="desc" id="asct_brnd_nm5">-</span>
													</li>
												</ul>
											</div>
										 </div>
					         		</div>
								</div>
							</div>
							<h5 class="sub_title">상품 BEST TOP3</h5>
							<div class="product_best">
								<ul class="list">
									<li class="rank_1" id="best_brnd1">-
										<em class="percent">-</em>
										<em class="price">-</em>
									</li>
									<li class="rank_2" id="best_brnd2">-
										<em class="percent">-</em>
										<em class="price">-</em>
									</li>
									<li class="rank_3" id="best_brnd3">-
										<em class="percent">-</em>
										<em class="price">-</em>
									</li>
								</ul>
							</div>
							<div class="report_more_info">
								<ul class="list">
									<li id="purchase_li1">* 매출 비중이 가장 높은 요일은 <strong id="purchase_spec_text1">-</strong>이며, 시간대는 <strong id="purchase_spec_text2"></strong> 사이입니다.</li>
									<li id="purchase_li2">* 결제수단은 <strong id="purchase_spec_text3">-</strong>가(이) <strong id="purchase_spec_text4">-</strong>로 가장 높은 비중을 차지합니다.</li>
									<li id="purchase_li3">* 브랜드 유사도가 가장 높은 브랜드는 <strong id="purchase_spec_text5">-</strong>이며, <strong id="purchase_spec_text6">-</strong> 순 입니다.</li>
									<li id="purchase_li4">* 브랜드 연관도가 가장 높은 브랜드는 <strong id="purchase_spec_text7">-</strong>이며, <strong id="purchase_spec_text8">-</strong> 순 입니다.</li>
									<li id="purchase_li5">* <span id="now_mm2">-</span>월 가장 많이 판매된 상품은 <strong id="purchase_spec_text9">-</strong> 입니다. </li>
								</ul>
							</div>
						</div>

					</div>

				</div>

				<!-- // 인사이트 레포트 -->
			</div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>