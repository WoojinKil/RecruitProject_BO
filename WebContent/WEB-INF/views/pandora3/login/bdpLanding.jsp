<%--
   1. 파일명 : bdpLanding
   2. 파일설명 :  BDP 랜딩 페이지
   3. 작성일 : 2019-09-24
   4. 작성자 : TANINE
--%>
<!DOCTYPE html>
<html>
<head>
<title>롯데백화점 빅데이터포탈</title>
<?xml version="1.0" encoding="UTF-8" ?>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="kr.co.ta9.pandora3.common.conf.Configuration" %>
<!-- jstl include -->
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!-- jstl include -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- tags include -->
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>

<!-- meta File include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/meta.jsp" %>
<%@ include file="/WEB-INF/views/pandora3/common/include/java.jsp" %>
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
<link href='${pageContext.request.contextPath}/resources/pandora3/fullcalendar/css/fullcalendar.min.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/pandora3/fullcalendar/css/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='${pageContext.request.contextPath}/resources/pandora3/fullcalendar/js/moment.min.js'></script>
<script src='${pageContext.request.contextPath}/resources/pandora3/fullcalendar/js/jquery-ui.min.js'></script>
<script src='${pageContext.request.contextPath}/resources/pandora3/fullcalendar/js/fullcalendar.js'></script>
<script src='${pageContext.request.contextPath}/resources/pandora3/fullcalendar/js/ko.js'></script>
<%
String target = configuration.get("properties.target");
%>
<script>
var notice_grid = null;
var bpcm3001_grid = null;

var barChartDateArr = {};
// 그래프 데이터
// 그래프 x축
var ckAuth="";
var tmpTarget ='<c:out escapeXml="true"  value='<%=target%>' />';
$(document).ready(function () {


    var rol_yn = "N";
    ajax({
        url : '/main/selectTsysAdmOrgGrpRolList.adm',// 그리드 조회 URL
        success : function ( data) {
            if (data.RESULT == "S") {
                if(data.rows.length > 0 ){
                    rol_yn = "Y";

                    if('<%=userInfo.getApvl_yn() %>' == "N" && "Y" == rol_yn) {
                        bpopup({
                            url:"/login/forward.bdpLandingp001.adm"
                          , params    : {callback : "fn_landingReload"}
                          , title     : "개인별 권한 확인"
                          , type      : "xl"
                          , height    : "600px"
                          , id        : "bdpLandingp1"
                        });
                    }
                }
            }
        }
    });



    $("#usr_nm").text('<%=userInfo.getUser_nm() %>');
    $("#org_nm").text('<%=userInfo.getHr_org_nm() %>');
    $("#pos_nm").text('<%=userInfo.getHr_emp_pos_nm() %>');
    $("#lgn_access_dy").text('<%=userInfo.getLgn_access_dy() %>' +" login");

    var mstr_uspr_id = '<%=userInfo.getMstr_uspr_id() %>';
    var mstr_cd = '<%=userInfo.getMstr_cd() %>';
    //매출 하이라이트 권한이 없을 경우 가림.
    if(isEmpty(mstr_uspr_id) || mstr_uspr_id == "null") {
        $("#mstr_uspr_id").addClass("on");
        $("#ave_mvg_report").removeClass("off");
    }
    if(mstr_cd == "0021" || mstr_cd == "0331" || mstr_cd == "0332" || mstr_cd == "0337" || mstr_cd == "0338"
        || mstr_cd == "0339" || mstr_cd == "0342" || mstr_cd == "0343" || mstr_cd == "0345" || mstr_cd == "0346"
        || mstr_cd == "0347" || mstr_cd == "0350" || mstr_cd == "0351" || mstr_cd == "0352" || mstr_cd == "0355"
        || mstr_cd == "0358" || mstr_cd == "0359" || mstr_cd == "0360" || mstr_cd == "0361" || mstr_cd == "0362") {
        $("#vipLngeutlprco").hide();
    }


    var currTimeHour = parseInt(moment().format("HH"));
    if(11 <= currTimeHour && currTimeHour <= 21 ) {
        $("#no_sty").removeClass("on");
    } else {
        $("#no_sty").addClass("on");
    }

    getAccessSitList(); // 접근 가능한 사이트
    fn_getWeather(); //날씨
    fn_getPopNotice();
    fn_getThkuEvntList(); //사은행사/ 공지사항
    fn_getMktData(); // MKT 추천
    fn_getStyData(); // 현재 내점 고객
    fn_getNoticeData(); // 한줄 공지
    fn_getMmcustvocList(); // voc
    fn_getLngeutlprco(); // 라운지
    fn_getReport(); // 리포트
    fn_getDstrbzarvstList(); //방문객수 비교

    moment.lang('ko', {
        weekdays: ["일요일","월요일","화요일","수요일","목요일","금요일","토요일"],
        weekdaysShort: ["일","월","화","수","목","금","토"],
    });

    /* hight light 클릭 이벤트 */
     $('#graph_bar').bind('jqplotDataClick',
      function (ev, seriesIndex, pointIndex, data) {

          fn_getDetailLngeutlprco(barChartDateArr["VST_DT"+(pointIndex)]);

      });

    $('#calendar').fullCalendar({
        header: {
            left:'',
            center: 'title',
            right: 'month,prev,next'
        },
        defaultDate: new Date(),
        locale: 'ko',
        navLinks: true,         // can click day/week names to navigate views
        businessHours: false,  // display business hours
        editable: false,
        allDayDefault: false,
        defaultView: "month",
        events:calendarData(),
        eventLimit:false,
        buttonText: {
            month:    '이전'
        },
        views:{
            agenda:{
                eventLimit:5
            }
        }
    });


    // 탭 클릭 이벤트
    $(".landing_tab_list > li .item").on("click", function() {
        var tab_name = $(this).data("tab");
        var tab_content = null;

        /*if($(this).closest("li").hasClass("off")) {
            return alert("서비스 준비중입니다.");
        }
        */
        $(this).closest(".landing_tab_area").find(".tab_content_list li").each(function(i) {
            if($(this).data("tab") == tab_name) {
                tab_content = $(this).data("tab");
            }
        });

        $(this).addClass("on").closest("li").siblings().find(".item").removeClass("on");
        $(this).closest(".landing_tab_area").find(".tab_content_list li[data-tab='"+tab_content+"']").addClass("on").siblings().removeClass("on");
    })



    // Click Logout Event
    $('#logout').click(function() {
        ajax({
            url:'/main/logout.adm',
            success: function(data) {
                alert("정상적으로 로그아웃 되었습니다");
                popup({url:"/login/forward.login.adm"
                    , winname:"_top"
                    , title:"로그인"
                    , scrollbars:false
                    , autoresize:false
                });
            }
        });
    });


    //사이트 클릭시
    $("#landing_gnb_List a").on("click", fn_move_sit);
    $("#debot a").on("click", fn_move_sit);

    $("#bdpMain a").on("click", function () {
        var sys_cd = $(this).data("sys_cd");
        var sys_url = $(this).data("sys_url");
        var sys_nm = $(this).data("sys_nm");
        window.open(sys_url, sys_nm);
    });

    $("#rol_app_btn").on("click", function () {

        window.open(
                _context+"/login/forward.main.adm?rol_app=Y&ckAuth="+ckAuth
                , "rolMain"
        );

    });
    $("#moreViewNotie, #btn_search").on("click", function () {
        window.open(
                _context+"/login/forward.main.adm?rol_app=notice&ckAuth="+ckAuth
                , "rolMain"
        );
    });
    $("#moreViewThkuEvnt").on("click", function () {
        window.open(
                _context+"/login/forward.main.adm?rol_app=thkuEvnt&ckAuth="+ckAuth
                , "rolMain"
        );
    });
    $("#brandReport a").on("click", function () {
        window.open(
                _context+"/login/forward.main.adm?rol_app=brandReport&ckAuth="+ckAuth
                , "rolMain"
        );
    });

    $("#styRefreshData").on("click", fn_getStyData);

    $(".btnclose").on("click", function() {
        $("body .new_dim").remove();
        $("#tsttscuststyBpopup1").hide();
    });
    var reportDay = moment().format("D");
    //매월 4일이나 5일 이후에는 전달 출력, 4일이나5일전이면 전전달 출력
    if(parseInt(reportDay,10)>=4){
    	$("#brandReportMonth").text(moment().add(-1, "month").format("M") + "월");
    }else{
    	$("#brandReportMonth").text(moment().add(-2, "month").format("M") + "월");
    }
    

});

function unescapeHtml(str) {

    if (str == null) {
     return "";
    }

    return str.replace(/&amp;/g, '&')
              .replace(/&lt;/g, '<')
              .replace(/&gt;/g, '>')
              .replace(/&quot;/g, '"')
              .replace(/&#039;/g, "'")
              .replace(/&#39;/g, "'")
              .replace(/&#40;/g, "(")
              .replace(/&#41;/g, ")");

}

function fn_move_sit() {

    if(isEmpty($(this).data("sys_cd"))) {
        alert("권한이 없습니다.");
        return false;
    }
    var sys_cd = $(this).data("sys_cd");
    var sys_url = $(this).data("sys_url");
    var sys_nm = $(this).text();
    ajax({
        url:'/main/sitLoginInfo.adm',
        data:{sys_cd : sys_cd},
        success: function(data) {
            if (data.RESULT == "S") {

                if(sys_cd == "15") {
                    window.open(sys_url+"?v="+data.v, sys_nm , "width=600,height=680,status=no,resizable=no,scrollbars=no,location=no");
                } else {
                    window.open(sys_url+"?v="+data.v , sys_nm );
                }
            }
        }
    });
}

//사이트 접속 리스트 취득
function getAccessSitList() {

    var html = "";

    ajax({
        url     : "/pdsp/getAccessSitList.adm",
        success : function (data) {
            if (data.RESULT == "S") {
                $(data.rows).each(function (index) {
                    if(this.SYS_CD == 0) {
                        if(this.SYS_URL != "#") {
                            ckAuth = "Y";
                            $("#bdpMain a").show();
    //                      $("#bdpMain a").attr("href", this.SYS_URL);
                            $("#bdpMain a").attr("href", "#");
                            $("#bdpMain a").attr("data-sys_cd", this.SYS_CD);
                            $("#bdpMain a").attr("data-sys_url", this.SYS_URL);
    //                          $("#bdpMain a").attr("data-sys_url", "http://localhost:8080/bdp/main");
                            $("#bdpMain a").attr("data-sys_nm", this.SYS_NM);
                        }
                    } else if(this.SYS_CD == 15) {
                         if(this.SYS_URL != "#") {
                            $("#debot").addClass("on");
                            $("#debot a").attr("data-sys_cd", this.SYS_CD);
                            $("#debot a").attr("data-sys_url", this.SYS_URL);
                            $("#debot a").attr("data-sys_nm", this.SYS_NM);
                         }
                    } else {
                        var sitUrl ="";
                        if(this.SYS_URL != "#") {
                            sitUrl = this.SYS_URL;
                            /*
                            if(tmpTarget=="prd"){
                                if(this.SYS_CD==2){
                                    var arr = ["http://10.7.26.10:8080/","http://10.7.26.97:8080/"];
                                    sitUrl = arr[Math.floor(Math.random() * arr.length)];
                                }
                            }
                            */
                            html += "<li class='on'>";
                            $(".move_sit" + this.SYS_CD).attr("data-sys_cd", this.SYS_CD)
                            .attr("data-sys_url", sitUrl)
                            .attr("data-sys_nm", this.SYS_NM)
                            .on("click", fn_move_sit);
                        } else {
                            html += "<li>";
                            $(".move_sit" + this.SYS_CD).on("click", fn_move_sit);
                        }


                        html +=     "<div class='list_pa'><a href='/#' data-sys_cd='"+ this.SYS_CD +"' data-sys_url='"+ sitUrl+"' onclick='return false' >";
                        html +=         this.SYS_NM.replace(" ", '</br>');
                        html +=     "</a></div>";
                        html += "</li>";
                    }
                });
                $("#landing_gnb_List").append(html);

            }
        }
    });
}
function fn_landingReload() {

    location.reload();
}

// 방문객수 비교
function fn_getLineConfig1(xAxis, lineInfo, dstrbzarvstSeries){

    var lineConfig = {
            animate: true,
            seriesColors: lineInfo["colorLineArr"],
            seriesDefaults:{
                shadow:false,
                markerOptions : {
                    shadow: false
                },
                rendererOptions: {
                    varyBarColor: true,
                    smooth: true,
                    animation: {
                        speed: 1500
                    },
                },
                pointLabels: {show: false}
            },
            series : dstrbzarvstSeries,
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
                    ticks       : xAxis,
                    tickOptions: { // y 라인 삭제
                        showGridline: false,
                        showMark: false
                        },
                    },
                    yaxis: {
                        min:0,
                         //ticks: Yticks
                         tickOptions: {
                             formatString: "%d"
                        }
                    }
            },
            highlighter: {
                show: true,
                tooltipContentEditor: function (str, seriesIndex, pointIndex, plot) {
                    var html = "<div class='highlight_wrap' >";

                    for(var i = 0; i<plot.data.length; i++) {
                        html += "<span class='highlight_text' >";
                        html += lineInfo["NmLineArr"][i] + " : ";
                        html += AddComma(plot.data[i][pointIndex]);
                        html += "명</span>";
                    }

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

/* MKT 추천 */
function getDonutChart(data){
    var chartConfig = {
            seriesColors:['#71d2f3', '#0fb5bf'],
            seriesDefaults: {
                  renderer:$.jqplot.DonutRenderer,
                  shadow: false,
                  rendererOptions:{
                        sliceMargin: 0,
                        startAngle: -90,
                        showDataLabels: true,
                        dataLabels: 'value'  ,
                        animation: {
                            speed: 2500
                        },
                  }
            }
    };
    return chartConfig;
}


function getBarChart(){
     var chartConfig = {
            seriesColors:['#0fb5bf', '#87dcff'],
            seriesDefaults:{
                renderer:$.jqplot.BarRenderer,
                shadowAngle: 135,
                shadow:false,
                markerOptions : {
                    shadow: false
                },
                rendererOptions: {
                    varyBarColor: true,
                    barWidth: 27,
                    animation: {
                        speed: 2500
                    }
                }
            },
            grid: {
                background: '#fff',
                border:'0',
                borderColor: '#fff',
                gridLineColor: '#e9e9e9',
                shadow: false
            },
            axes: {
                xaxis: {
                    renderer: $.jqplot.CategoryAxisRenderer,
                    tickOptions: { // y 라인 삭제
                        showGridline: false,
                        showMark: false
                     }
                }
            }
        };
    return chartConfig;

}

function fn_getWeather () {


    ajax({
        url : '/landing/getWeather.adm',
        success : function (data) {
            if (data.RESULT == _boolean_success) {

                var fn_dst_cnct_nm = "";
                var utrfn_dst_cnct_nm = "";
                var fn_dst_cnct_color = "";
                var utrfn_dst_cnct_color = "";
                if(data.rows[0]) {


                    var wthr = data.rows[0];


                    if(wthr.FN_DST_CNCT >= 0 && wthr.FN_DST_CNCT <= 30) {
                        fn_dst_cnct_nm = "좋음";
                        fn_dst_cnct_color = "type_blue";
                    } else if(wthr.FN_DST_CNCT >= 31 && wthr.FN_DST_CNCT <= 80) {
                        fn_dst_cnct_nm = "보통";
                        fn_dst_cnct_color = "type_green";
                    } else if(wthr.FN_DST_CNCT >= 81 && wthr.FN_DST_CNCT <= 150) {
                        fn_dst_cnct_nm = "나쁨";
                        fn_dst_cnct_color = "type_orange";

                    } else /* if(wthr.FN_DST_CNCT >= 151) */ {
                        fn_dst_cnct_nm = "매우나쁨";
                        fn_dst_cnct_color = "type_red";
                    }

                    if(wthr.UTRFN_DST_CNCT >= 0 && wthr.UTRFN_DST_CNCT <= 15) {
                        utrfn_dst_cnct_nm = "좋음";
                        utrfn_dst_cnct_color = "type_blue";
                    } else if(wthr.UTRFN_DST_CNCT >= 16 && wthr.UTRFN_DST_CNCT <= 50) {
                        utrfn_dst_cnct_nm = "보통";
                        utrfn_dst_cnct_color = "type_green";
                    } else if(wthr.UTRFN_DST_CNCT >= 51 && wthr.UTRFN_DST_CNCT <= 100) {
                        utrfn_dst_cnct_nm = "나쁨";
                        utrfn_dst_cnct_color = "type_orange";
                    } else /* if(wthr.UTRFN_DST_CNCT >= 101) */ {
                        utrfn_dst_cnct_nm = "매우나쁨";
                        utrfn_dst_cnct_color = "type_red";
                    }

//                     WTHR_ICON_CD

                    $(".weather_area a img").attr("src", "${pageContext.request.contextPath}/resources/pandora3/images/weather_icon/" + wthr.WTHR_ICON_CD + ".png");
                    $(".weather_area .desc_1 span").eq("0").html("<strong>" + wthr.WTHR_CL_NM + "</strong> " + wthr.NOW_ATMPR + " ºc");
                    $(".weather_area .desc_1 span").eq("1").html("미세 <em class='" + fn_dst_cnct_color + "'>"+ fn_dst_cnct_nm +"</em>")
                    $(".weather_area .desc_1 span").eq("2").html("초미세 <em class='" + utrfn_dst_cnct_color + "'>"+ utrfn_dst_cnct_nm +"</em>")
                    $(".weather_area .desc_2").text(wthr.MCTY_NM +" " + wthr.SIGUNGU_NM + " " + wthr.WTHR_TM + " 기준");
                }
            }
        }

    });

}

function fn_getMktData () {



    ajax({
        url : '/landing/getMktData.adm',
        success : function (data) {
            if (data.RESULT == _boolean_success) {

                $("#mkt_title").text(moment().format("YY년 M월")+ " " + data.MKT_TITLE );
                if(isNotEmpty(data.mktData)) {
                    var mktData = data.mktData;

//                  var jqplot_data_mkt = [['구매예상고객', mktData.MKTG_PSBL_CUST_CNT], ['마케팅가능고객', mktData.PCH_FORE_CUST_CNT]];
                    // $.jqplot('graph_donut', [jqplot_data_mkt], getDonutChart()); // MKT 추천

                    $("#pch_fore_cust_cnt").text(numberToKorean(mktData.PCH_FORE_CUST_CNT) + "명");
                    $("#excll_entr_cust_cnt").text(numberToKorean(mktData.EXCLL_ENTR_CUST_CNT) + "명");
                    $("#chrn_rcov_fore_cust_cnt").text(numberToKorean(mktData.CHRN_RCOV_FORE_CUST_CNT)+ "명");
                    $("#chnl_crs_fore_cust_cnt").text(numberToKorean(mktData.CHNL_CRS_FORE_CUST_CNT)+ "명");
                    $("#chrn_fore_cust_cnt").text(numberToKorean(mktData.CHRN_FORE_CUST_CNT)+ "명");

                }

            }
        }
    });

}



function fn_getStyData() {



    ajax({
        url : '/landing/getStyData.adm',
        success : function (data) {
            if (data.RESULT == _boolean_success) {

                $("#sty_title").text(data.STY_TITLE);

                if(data.styData) {
                    var styData = data.styData;

                    $("#sty_cust_cnt").text(AddComma(styData.STY_CUST_CNT) + " 명");
                    $("#prk_cust_cnt").text(AddComma(styData.PRK_CUST_CNT) + " 대");
                    $("#pch_cust_cnt").text(AddComma(styData.PCH_CUST_CNT) + " 명");
                    $("#poc_cust_cnt").text(AddComma(styData.POC_CUST_CNT) + " 명");
                    $("#lnge_cust_cnt").text(AddComma(styData.LNGE_CUST_CNT) + " 명");
                    $("#load_dttm").text(styData.LOAD_DTTM + " 기준");

                    if(AddComma(styData.POC_CUST_CNT) != "-") {
                        $("#poc_cust_cnt").closest("li").addClass("on");
                        $("#poc_cust_cnt").on("click", fn_getTsttscuststy);
                    } else {
                        $("#poc_cust_cnt").closest("li").removeClass("on");
                        $("#poc_cust_cnt").off();
                    }
                }
            }
        }
    });

}

function fn_getDstrbzarvstList() {



    var colorLine = {
             color_1 : "#a59274"
            , color_2 : "#1ba085"
            , color_3 : "#f22c2d"
            , color_4 : "#8d6148"
            , color_5 : "#e0c6ab"
            , color_6 : "#1d2953"
            , color_99 : "#1d4853"
    };
    var mt = moment();
    mt.add(-7, "days");
    var xLabels = getDayArr(mt, 7, null);


    var dstrbzarvstSeries = [];


    var lineInfo = {
         colorLineArr : []
        , NmLineArr : []
    };
    ajax({
        url : '/landing/getDstrbzarvst.adm',
        success : function (data) {
            if (data.RESULT == _boolean_success) {


                $("#dstr_title").text(data.DSTR_TITLE);

                if(isNotEmpty(data.rows)) {

                    var dstrbzarvstDataList = data.rows;
                    var rvco_srno_arry = [];
                    var jqplot_data_customer = [];
                    $(".graph_kinds.type_right").empty();
                    for(var i = 0; i < dstrbzarvstDataList.length; i++) {

                        if(rvco_srno_arry.indexOf(dstrbzarvstDataList[i].RVCO_SRNO) > -1) {
                            dstrbzarvstSeries.push({markerOptions: { style:"filledDiamond", size : 11 }});
                        } else {
                            dstrbzarvstSeries.push({});
                        }



                        $(".graph_kinds.type_right").append("<li class='color_"+ dstrbzarvstDataList[i].RVCO_SRNO +" "+ ((rvco_srno_arry.indexOf(dstrbzarvstDataList[i].RVCO_SRNO) > -1) ? "rhombus" : "")  +"'>" + dstrbzarvstDataList[i].NM + "</li>");
                        lineInfo["colorLineArr"].push(colorLine["color_" + dstrbzarvstDataList[i].RVCO_SRNO]);
                        lineInfo["NmLineArr"].push(dstrbzarvstDataList[i].NM);
                        jqplot_data_customer.push([
                             dstrbzarvstDataList[i].COL_CNT8
                            , dstrbzarvstDataList[i].COL_CNT9
                            , dstrbzarvstDataList[i].COL_CNT10
                            , dstrbzarvstDataList[i].COL_CNT11
                            , dstrbzarvstDataList[i].COL_CNT12
                            , dstrbzarvstDataList[i].COL_CNT13
                            , dstrbzarvstDataList[i].COL_CNT14
                        ]);
                        rvco_srno_arry.push(dstrbzarvstDataList[i].RVCO_SRNO);
                    }

                    $.jqplot ('graph_line', jqplot_data_customer, fn_getLineConfig1(xLabels, lineInfo, dstrbzarvstSeries));          // 방문객수 비교 그래프

                }

            }
        }
    });

}

var lineNoticeRow = null;
function fn_getNoticeData() {

    ajax({
        url:"/landing/getTbbsDocInfNoticeLandingList.adm"
        ,success : function (data) {
            if (data.RESULT == _boolean_success) {
                if(data.rows) {

                    //조회된 첫번째 공지만 상단으로 가져오기
                    lineNoticeRow = data.rows[0];

                    if(lineNoticeRow) {

                        $("#line_notice").html("[" + lineNoticeRow.CTEGRY_DTL_NM + "] " + lineNoticeRow.TITL);

                        $("#line_notice_date").text(lineNoticeRow.F_CRT_DTTM);

                        $("#line_notice").on("click", fn_notice_popup);
                    }

                }
            }

        }
    });
}

function setCookie(name, value, expiredays){
    var todayDate = new Date();
    todayDate.setDate(todayDate.getDate() + expiredays);
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}

function checkPoupCookie(cookieName){

    var cookie = document.cookie;
    // 현재 쿠키가 존재할 경우
    if(cookie.length > 0){

        // 자식창에서 set해준 쿠키명이 존재하는지 검색
        startIndex = cookie.indexOf(cookieName);
    
        // 존재한다면
        if(startIndex != -1){
               return true;
        }else{
              // 쿠키 내에 해당 쿠키가 존재하지 않을 경우
              return false;
        };
    }else{
        // 쿠키 자체가 없을 경우
        return false;
    };
}


function landing_pop_close(thisobj) {
    var $this = $(thisobj);
    
    if($("#today_check").is(":checked")){
        var cookieName = $this.closest(".landing_pop").data("DOC");
        setCookie(cookieName, cookieName, 1);
    }
    
    $this.closest(".landing_pop").removeClass("on");
}

function fn_getPopNotice() {
    ajax({
        url:"/landing/getPopNotice.adm"
        ,success : function(data) {
            
            if (data.RESULT == _boolean_success) {
                
                if(data.rows[0]) {
                    if(!checkPoupCookie("DOC" + data.rows[0].DOC_SEQ)) {
                        $("#landing_pop").data("DOC", "DOC" + data.rows[0].DOC_SEQ);
                        $("#pop_cnt_area").html(data.rows[0].CTS);
                        $("#pop_cnt_area").html($("#pop_cnt_area").text());
                        $("#landing_pop").addClass("on");
                    }
                }
                
            }
        }
    });
}

function fn_notice_popup() {

    window.open(
            _context+"/login/forward.main.adm?rol_app=notice&ckAuth="+ckAuth+"&doc_seq="+lineNoticeRow.DOC_SEQ
            , "rolMain"
    );
}

function fn_getTsttscuststy() {

    $("#tsttscuststyBpopup1 table tbody").empty();

    ajax({
        url:"/landing/getTsttscuststy.adm"
        ,success : function (data) {
            if (data.RESULT == _boolean_success) {
                if(data.rows) {
                    var tsttscuststyList = data.rows;

                    for (var i = 0; i< tsttscuststyList.length; i++) {
                        $("#tsttscuststyBpopup1 table tbody").append("<tr><th scope='row'>" + tsttscuststyList[i].MSG_NAME + "</th><td>" +tsttscuststyList[i].POC_CUST_CNT+ "명 </td></tr>")
                    }

                    $("body").append("<div class='new_dim'></div>");
                    $("#tsttscuststyBpopup1").show();

                }
            }

        }
    });

}

function fn_getDetailLngeutlprco(searchDate) {

    ajax({
        url:'/landing/getDetailLngeutlprco.adm',
        data:{search_dt : searchDate},
        success : function(data) {
            if (data.RESULT == _boolean_success) {

                $("#vst_date").text(moment(searchDate).format("M/D(ddd)"));

                if(data.detailLngeutlprcoData) {
                    var detailLngeutlprcoData = data.detailLngeutlprcoData;

                    var slng_amt = detailLngeutlprcoData.SLNG_AMT;
                    var pch_cust_cnt = detailLngeutlprcoData.PCH_CUST_CNT;
                    var cust_unit_price = 0;
                    if(slng_amt != 0 && pch_cust_cnt != 0 ) {
                        cust_unit_price = slng_amt / pch_cust_cnt;
                    }

                    var slng_amt_unit = slng_amt;
                    var slng_until = "원";
                    if(slng_amt > 1000000) {
                        slng_amt_unit = slng_amt / 1000000;
                        slng_until = "백만원";
                    }
                    cust_unit_price = Math.round(cust_unit_price);
                    slng_amt_unit = Math.round(slng_amt_unit);


                    $("#vst_cust_cnt").text(AddComma(detailLngeutlprcoData.VST_CUST_CNT) + "명"); //VST_CUST_CNT  방문객수
                    $("#vat_time").text(detailLngeutlprcoData.VAT_TIME + "분");//VAT_TIME     // 평균체류시간
                    $("#drnk_ord_prdc_cnt").text(detailLngeutlprcoData.DRNK_ORD_PRDC_CNT + "잔");//DRNK_ORD_PRDC_CNT // 평균 주문수
                    $("#slng_amt").text(AddComma(slng_amt_unit) + slng_until);//SLNG_AMT // 구매 금액
                    $("#cust_unit_price").text(AddComma(Math.round(cust_unit_price / 1000)) + "천원");
                    $("#ord_chg_tovrrt").text(detailLngeutlprcoData.ORD_CHG_TOVRRT+ "%")
                    //PCH_CUST_CNT //  구매 고객 수
                    //LGNE_TOVRRT // 라운지 회전률
                    //ORD_CHG_TOVRRT // 구매 전환률

                };
            }
        }
    })
}

function fn_getMmcustvocList() {



    var dateObj = {
            currMonth : {
                  VOC01_CNT : 0  //문의 수
                  , VOC02_CNT : 0  // 만족 수
                  , VOC03_CNT : 0 //불만족 수
                  , VOC04_CNT : 0 // 제안 수
                  , VOC_TOTAL_CNT : 0

            },
            oldMonth : {
                  VOC01_CNT : 0  //문의 수
                  , VOC02_CNT : 0  // 만족 수
                  , VOC03_CNT : 0 //불만족 수
                  , VOC04_CNT : 0 // 제안 수
                  , VOC_TOTAL_CNT : 0
            },
            getVoc02Percentage : function() {
                return  Math.round(this.currMonth.VOC02_CNT /  (this.currMonth.VOC_TOTAL_CNT == 0 ? 1 : this.currMonth.VOC_TOTAL_CNT)  * 100)
            },
            getVoc0104Percentage : function () {
                return Math.round((this.currMonth.VOC01_CNT + this.currMonth.VOC04_CNT) / (this.currMonth.VOC_TOTAL_CNT == 0 ? 1 : this.currMonth.VOC_TOTAL_CNT) * 100);
            },
            getVoc03Percentage : function () {
                return Math.round(this.currMonth.VOC03_CNT / (this.currMonth.VOC_TOTAL_CNT == 0 ? 1 : this.currMonth.VOC_TOTAL_CNT) * 100);
            }
    };

    var currMonth =  moment().add(-1, "day").format("YYYYMM"); // 현재 달
    var oldMonth = moment().add(-1, "year").add(-1, "day").format("YYYYMM"); // 이전 년도.
    
    ajax({
        url : '/landing/getMmcustvocList.adm',
        success : function (data) {

            if (data.RESULT == _boolean_success) {

                $("#voc_title").text(data.VOC_TITLE + " " + moment().add(-1, "day").format("M") + "월");

                // 현재 달 과 이전 달만 가져옴
                if(data.rows) {
                    var mmcustvocList = data.rows;

                    for(var i = 0; i< mmcustvocList.length; i ++) {

                        if(mmcustvocList[i].STD_YM == currMonth) {

                            dateObj["currMonth"].VOC01_CNT = mmcustvocList[i].VOC01_CNT;  //문의 수
                            dateObj["currMonth"].VOC02_CNT = mmcustvocList[i].VOC02_CNT;  // 만족 수
                            dateObj["currMonth"].VOC03_CNT = mmcustvocList[i].VOC03_CNT; //불만족 수
                            dateObj["currMonth"].VOC04_CNT = mmcustvocList[i].VOC04_CNT; // 제안 수
                            dateObj["currMonth"].VOC_TOTAL_CNT = mmcustvocList[i].VOC_TOTAL_CNT;

                        } else if(mmcustvocList[i].STD_YM == oldMonth) {

                            dateObj["oldMonth"].VOC01_CNT = mmcustvocList[i].VOC01_CNT;  //문의 수
                            dateObj["oldMonth"].VOC02_CNT = mmcustvocList[i].VOC02_CNT;  // 만족 수
                            dateObj["oldMonth"].VOC03_CNT = mmcustvocList[i].VOC03_CNT; //불만족 수
                            dateObj["oldMonth"].VOC04_CNT = mmcustvocList[i].VOC04_CNT; // 제안 수
                            dateObj["oldMonth"].VOC_TOTAL_CNT = mmcustvocList[i].VOC_TOTAL_CNT;

                        }

                    }

                    var voc02Percentage = dateObj.getVoc02Percentage();
                    var voc0104Percentage = dateObj.getVoc0104Percentage();
                    var voc03Percentage = dateObj.getVoc03Percentage();

                    $("#voc02").html(voc02Percentage +" <em>%<em>");
                    $("#voc0104").html(voc0104Percentage +" <em>%<em>");
                    $("#voc03").html(voc03Percentage +" <em>%<em>");


                    var voc01Result = dateObj["currMonth"].VOC01_CNT - dateObj["oldMonth"].VOC01_CNT;
                    var voc02Result = dateObj["currMonth"].VOC02_CNT - dateObj["oldMonth"].VOC02_CNT;
                    var voc03Result = dateObj["currMonth"].VOC03_CNT - dateObj["oldMonth"].VOC03_CNT;
                    var voc04Result = dateObj["currMonth"].VOC04_CNT - dateObj["oldMonth"].VOC04_CNT;


                    $("#voc01_cnt").html(dateObj["currMonth"].VOC01_CNT +"건 ( <em class='" + getUpDownClass(voc01Result) + "'>" + Math.abs(voc01Result) + "</em> )");
                    $("#voc02_cnt").html(dateObj["currMonth"].VOC02_CNT +"건 ( <em class='" + getUpDownClass(voc02Result) + "'>" + Math.abs(voc02Result) + "</em> )");
                    $("#voc03_cnt").html(dateObj["currMonth"].VOC03_CNT +"건 ( <em class='" + getUpDownClass(voc03Result) + "'>" + Math.abs(voc03Result) + "</em> )");
                    $("#voc04_cnt").html(dateObj["currMonth"].VOC04_CNT +"건 ( <em class='" + getUpDownClass(voc04Result) + "'>" + Math.abs(voc04Result) + "</em> )");

                    $("#vocTime").text(moment().add(-1, 'day').format("Y-MM-DD") + " 기준");
                }
            }
        }
    });


}

function fn_getLngeutlprco() {


    var barChartData = [];
    ajax({
        url:"/landing/getLngeutlprco.adm"
        , success : function (data) {
            if (data.RESULT == "S") {
                $("#lng_title").text(data.LNG_TITLE);

                if(data.rows) {
                    var lngeutlprcoList = data.rows;
                    for(var i = 0 ; i < lngeutlprcoList.length; i++) {
                        barChartData.push([

                            moment(lngeutlprcoList[i].VST_DT).format("M/D(ddd)")
                            , lngeutlprcoList[i].VST_CUST_CNT
                        ]);

                        barChartDateArr["VST_DT"+i] = lngeutlprcoList[i].VST_DT;
                    }
                    fn_getDetailLngeutlprco(barChartDateArr["VST_DT" + (lngeutlprcoList.length-1)]);
                    $.jqplot('graph_bar', [barChartData], getBarChart());
                }

            }
        }
    });
}

function fn_getReport( ) {

    ajax({
        url:"/landing/getReport.adm",
        success : function (data) {

            $("#report_title").text(data.REPORT_CSTR_TITLE);

            if(data.RESULT != "FAIL") {

                //전사 정보
                if(data.TOTAL_STR) {
                    var totalStr = data.TOTAL_STR[0];
                }

                var custReport = data;
                var chart1Custom1Data = [];

                var totalDatas = [];

                var labels = [], newData;
                var elements = custReport['definition']['grid']['columns'][0]['elements'];
                var datas = custReport['data']['metricValues']['raw'][0];
                if(!datas) {
                    $("#mstr_uspr_id").addClass("on");
                    $("#ave_mvg_report").removeClass("off");
                    return false;
                }
                $.each(elements, function(idx, json){
                    newData = datas[idx];
                    totalDatas.push({name: json['name'], data: newData });
                });

                // 데이터 배열
                var dataIdxs = [[0,1], [6,7], [12,13], [18,19]];
                var totIdxs =[[4,5], [10,11], [16,17], [22,23]];

                var txtDatas = custReport['data']['metricValues']['formatted'][0];
                // 텍스트 배열
                var txtIdxs = [[0,1,4,5], [6,7,10,11], [12,13,16,17], [18,19,22,23]];


                var tmpLabels, tmpDatas, tmpTxt;

                for(var i=0;i<dataIdxs.length;i++){
                    tmpLabels = [];
                    tmpDatas = [];
                    $.each(dataIdxs[i], function(idx, dataIdx){
                        tmpTxt=totalDatas[dataIdx]['data'];
                        tmpLabels.push(totalDatas[dataIdx]['name']);
                        tmpDatas.push(tmpTxt);
                    });
                    // 하단 텍스트 변경
                    $.each(txtIdxs[i], function(idx, dataIdx){
                        tmpTxt = txtDatas[dataIdx];
                        if(isEmpty(tmpTxt)){
                            tmpTxt = "0";
                        }

                        if(3 == idx+1 || 4 == idx+1) {
                            $('#bi_select'+i+'_'+(idx+1)).text(tmpTxt.replace(/[-%]/gi, '')+"%").addClass(getUpDownClass(parseInt(tmpTxt)));
                        } else {
                            tmpTxt = numberToCut(tmpTxt, false, 1000000);
                            $('#bi_select'+i+'_'+(idx+1)).text(AddComma(parseInt(tmpTxt)));
                        }


                    });

                    if(data.TOTAL_STR) {

                        $.each(totIdxs[i], function (idx, itm) {
                            var txt = totalStr[itm];
                            if(isNotEmpty(txt)){
                                txt = txt.replace(/[%]/gi, '');
                                $("#bi_tot_select"+ i + "_" + (idx+3)).html("(전사 : <em>" + Math.abs(parseFloat(txt.replace(/[%]/gi, ''))) +"</em>%)").addClass(getUpDownClass(parseInt(txt))).addClass("on");
                            }

                        });
                    }
                }


                $("#bi_date").text(moment().add(-1,"day").format("Y-MM-DD"));
            } else {
                $("#mstr_uspr_id").addClass("on");
                $("#ave_mvg_report").removeClass("off");
            }
        }
    })
}

function getUpDownClass(num) {

    if(isEmpty(num) || num == 0) {
        return "";
    } else if (num < 0) {
        return "down";
    } else {
        return "up";
    }

}

function getDayArr(mt, range, foramt){
    if(mt == null) mt = moment();
    if(foramt == null) foramt = "M/D(ddd)";
    var dateArr = new Array();
    mt.add(-1, "days");
    for (var i = 0; i < range; i++) {
        mt.add(1, "days");
        dateArr.push(mt.format(foramt));
    }
    return dateArr;
}

function AddComma(num) {

    if(num == 0) return "0";

    var regexp = /\B(?=(\d{3})+(?!\d))/g;
    return num.toString().replace(regexp, ',');
}

function addComma(no){
    if(no==null) return "";
    no = no.replace(/,/g, '');
    var regExp = /(-?[0-9]+)([0-9]{3})/;
    while(regExp.test(no)) no = no.replace(regExp, '$1,$2');
    return no;
};

function numberToCut(number, isComma, splitUnit){
    try{
        if(number < 0) return number;
        if(isComma===undefined) isComma=true;
        if(splitUnit===undefined) splitUnit=1000000;
        number=removeComma(String(number));
        number=parseInt(number);
        // 단위로 구분
        var unitResult=(number % Math.pow(splitUnit, 3)) / Math.pow(splitUnit, 1);
        // 반올림
        unitResult = Math.round(unitResult);
        if(isComma){
            unitResult = addComma(String(unitResult));
        }
    }catch(e){console.error("# numberToCut error msg: "+e);}
    return unitResult;
};

function removeComma(no){
    if(no==null) return "";
    return no.replace(/,/g, '');
};


//사은, 공지게시글 그리드 조회
function fn_getThkuEvntList() {

    // 그리드 초기화
    var module_config = {
        // 그리드, 페이징 ID
        gridid:'bpcm3001_grid',
        pagerid:'bpcm3001_grid_pager',
        // 컬럼 정보
        columns:[{name:'THKU_EVNT_NO', width:50, label:'이벤트코드', align: "center", hidden:true},
                 {name:'THKU_EVNT_MDCLS_NM', width:30, label:'유형', align: "center", hidden:true},
                 {name:'EVNT_NM', label:'사은행사명', align: 'left', width:150
                     ,formatter: function(cellValue,options,rowdata,action){
                            var str ="";

                            if(rowdata.THKU_EVNT_PRGRS_STAT_CD == "03"){
                                str ="<span class='board_inf'>종료</span>" + cellValue;
                            } else if(rowdata.THKU_EVNT_PRGRS_STAT_CD == "02") {
                                str ="<span class='board_inf'>마감임박</span>" + cellValue;
                            } else {
                                str = cellValue;
                            }
                            return str;
                        }
                 },
                 {name:'EVNT_SMRY_2_INFO', width:50, label:'요약정보2', hidden:true},
                 {name:'THKU_EVNT_PRGRS_STAT_CD',  label:'사은진행상태', align:'center', hidden:true, width:50},
                 {name:'EVNT_DT', width:120, label:'행사기간',align: "right", hidden:false}
                ],
        editmode:true,          // 그리드 editable 여부
        gridtitle:'',   // 그리드명
        formid:'search',        // 조회조건 form id
        shrinkToFit:true,       // width 고정여부
        autowidth:true,         // 컬럼 width 자동조정여부
        height:160,             // 그리드 높이
        cellEdit:false,
        loadonce : true,
        rowNum : 4,
        rownumbers: false,
        events : {
            onCellSelect:function(event, rowid, icol, value) {
                var row = bpcm3001_grid.getRowData(rowid);

                var _evnt_no = row.THKU_EVNT_NO;
                bpopup({
                      url:"/pbbs/forward.bpcm3001p001.adm"
                    , params    : {target_id : _menu_id, thku_evnt_no :  _evnt_no}
                    , title     : "사은행사 요약정보"
                    , type      : "s"
                    , id        : "bpcm3001p1"
                   });
            }
        },

        selecturl:'/bpcm/getBpcm3001List'
    };



    // 그리드 초기화
    var notice_config = {
        // 그리드, 페이징 ID
        gridid:'notice_grid',
        pagerid:'notice_grid_pager',
        // 컬럼 정보
        columns:[{name:'MODL_SEQ', width:100, label:'게시판순번', hidden:true},
            {name:'DOC_SEQ', width:100, label:'문서번호', hidden:true},
            {name:'TMP_SEQ', width:100, label:'템플릿ID', hidden:true},
            {name:'MAPPED_YN', width:100, label:'매핑여부', hidden:true},
            {name:'MODL_TP', width:100, label:'게시판유형', hidden:true},
            {name:'REF_1', width:100, label:'게시판URL', hidden:true},
//          {name:'STATUS', label:'상태', align:'center', editable:false, width:20},
            {name:'CD_NM', width:100, label:'게시판유형명', sortable:false, hidden:true},
            {name:'SYS_NM', width:50, label:'시스템', align:'center', sortable:false, editable:false, hidden:true},
            {name:'MODL_NM', width:90, label:'게시판명', sortable:false, hidden:true},
            {name:'CTEGRY_DTL_NM', width:90, label:'카테고리', sortable:false, hidden:true},
            {name:'NOTC_YN', width:50, label:'중요여부', align:'center', sortable:false, editable:false, formatter:'select',edittype:'select', editoptions:{value:'Y:중요;N:일반'}, hidden:true},
            {name:'TITL', width:280, label:'제목', sortable:false,  align: 'left',
                formatter: function(cellValue,options,rowdata,action){
                    var str ="";

                    if(rowdata.NOTC_YN == "Y"){
                        str ="<span class='board_inf'>중요</span>" +"[" + rowdata.CTEGRY_DTL_NM + "] " + cellValue;
                    } else {
                        str = "[" + rowdata.CTEGRY_DTL_NM + "] " +cellValue;
                    }
                    return str;
            }},
            {name:'INQ_CNT', width:40, label:'조회수', align:'right', editable:false, formatter:'number', formatoptions:{thousandsSeparator:",",decimalPlaces:0}, hidden:true},
            {name:'DSPLY_STAT', width:50, label:'게시여부', align:'center', sortable:false, hidden:true},
            {name:'LGN_ID', width:50, label:'작성자 사번', align:'center', sortable:false, hidden:true},
            {name:'USR_NM', width:50, label:'작성자 성명', align:'center', sortable:false, hidden:true},
            {name:'F_CRT_DTTM', width:80, label:'작성일', align:'right', editable:false},
//          {name:'TREATMENT_CD', width:50, label:'답변여부', align:'center', sortable:false, editable:false, formatter:'select', edittype:'select', editoptions:{value:'1:등록완료;2:답변준비중;3:답변완료;-:-;'}}
            ],

        events : {
            onCellSelect:function(event, rowid, icol, conts) {
                var row = notice_grid.getRowData(rowid);
                var obj = $("#notice_grid");
                var id = obj.jqGrid('getCell', rowid, 'DOC_SEQ');

                window.open(
                        _context+"/login/forward.main.adm?rol_app=notice&ckAuth="+ckAuth+"&doc_seq="+id
                        , "rolMain"
                );

            }
        },
        editmode:true,          // 그리드 editable 여부
        gridtitle:'',   // 그리드명
        formid:'search',        // 조회조건 form id
        shrinkToFit:true,       // width 고정여부
        autowidth:true,         // 컬럼 width 자동조정여부
        height:160,             // 그리드 높이
        cellEdit:false,
        loadonce : true,
        rowNum : 4,
        rownumbers: false,

        selecturl:'/landing/getTbbsDocInfNoticeLandingList', // 그리드 조회 URL
    };

    bpcm3001_grid = new UxGrid(module_config);
    bpcm3001_grid.init();
    $("#bpcm3001_grid").jqGrid("setLabel", "rn", "NO.");
    bpcm3001_grid.setGridWidth($('.landing_tab_area.type_two').width());


    notice_grid = new UxGrid(notice_config);
    notice_grid.init();
    $("#notice_grid").jqGrid("setLabel", "rn", "NO.");
    notice_grid.setGridWidth($('.landing_tab_area.type_two').width());

    bpcm3001_grid.retreive();
    notice_grid.retreive();





}

//그리드 리사이징
$(window).resize(function() {
});

var my_schedule = null;
//캘린더 정보
function calendarData(){
  var events = [];
  var events_color = ["#caeff1", "#fdd3d3", "#f9fdd3", "#d3fdec"];

  ajax({
      url:'/pbbs/getPbbs1016ScdList.adm',
      data:{my_schedule:my_schedule},
      success: function(data){
          var dataList = data.rows;
          for(i=0; i<dataList.length; i++) {
            if(i < 2) {
            }
            events.push({
                  title: unescapeHtml(dataList[i].TIT1),
                  start: dataList[i].F_ST_DTTM,
                  end: dataList[i].F_ED_DTTM,
                  cts: unescapeHtml(dataList[i].CTS),
                  user: dataList[i].USR_NM,
                  lct: dataList[i].LCT,
                  ady_yn: dataList[i].ADY_YN,
                  schedule_id: dataList[i].SCD_SEQ,
                  color: events_color[i % 4],
                  crtr_id: dataList[i].CRTR_ID,
                  cstr_cd : dataList[i].CSTR_CD,
                  scd_cl_cd : dataList[i].SCD_CL_CD
               });

          }
      }
  });
  return events;
}

/** 메인 로딩 start
 *  작성일 : 2019-11-18
 *
 */
function main_loading_start2() {
    $(".loading_landing").show();
}

/** 메인 로딩 start
 *  작성일 : 2019-11-18
 *
 */
function main_loading_end2() {
    $(".loading_landing").hide();
}

function numberFormat(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function numberToKorean(number){
    if(number == 0) return number;
    var inputNumber  = number < 0 ? false : number;
    var unitWords    = ['', '만'];
    var splitUnit    = 10000;
    var splitCount   = unitWords.length;
    var resultArray  = [];
    var resultString = '';

    for (var i = 0; i < splitCount; i++){
        var unitResult = (inputNumber % Math.pow(splitUnit, i + 1)) / Math.pow(splitUnit, i);
        unitResult = Math.round(unitResult);
        if (unitResult > 0){
            resultArray[i] = unitResult;
        }
    }

    if(resultArray.length == 2) {
        resultString = String(numberFormat(resultArray[1])) + unitWords[1];
    } else {
        resultString =  String(numberFormat(resultArray[0]))
    }

    return resultString;
}

function toolTip(thisobj) {
    var $this = $(thisobj);

    $this.closest(".tooltip_area").toggleClass("on");
}

function number_data(thisobj) {
    var $this = $(thisobj);

    $this.closest(".number_data_wrap").toggleClass("on");
}



</script>
<style>
    /* loading */
    .loading_landing{position:absolute;width:100%;height:100%;background:rgba(0,0,0,0.7);z-index:102}
    .loading_landing img{display:block;position:absolute;left:50%;top:50%; -ms-transform:translate(-50%, -50%); transform: translate(-50%,-50%);}
    .loading_landing .desc{position:absolute; left:50%; top:50%; -ms-transform:translate(-50%, -50%); transform:translate(-50%, -50%); margin-top:70px; color:#7bb6e2; font-size:24px; font-weight:700; text-align:center; font-family: 'Noto Sans KR', 'Dotum', '돋움', sans-serif;}
    .loading_landing .desc em{display:block; margin-top:15px; color:#999; font-size:18px;}
    
    body .b-modal{z-index:110 !important;}
</style>
</head>
<body onload="main_loading_end2();">
    <!-- wrapper -->
        <div id="wrapper" class="landing">

            <div id="tsttscuststyBpopup1" style="display: none">
                <strong>고객접점현황</strong>
                <div class="in">
                    <table>
                        <colgroup>
                            <col style="width:60%;">
                            <col style="width:40%;">
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="row">유모차 대여외</th>
                                <td>0 명</td>
                            </tr>
                            <tr>
                                <th scope="row">고객피팅</th>
                                <td>0 명</td>
                            </tr>
                            <tr>
                                <th scope="row">근거리배송</th>
                                <td>0 명</td>
                            </tr>
                            <tr>
                                <th scope="row">리버스픽</th>
                                <td>0 명</td>
                            </tr>
                            <tr>
                                <th scope="row">스토어픽</th>
                                <td>0 명</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <button class="btn_close btnclose"><img src="${pageContext.request.contextPath}/resources/pandora3/images/common/btn_close_pop.png" ></button>

                <button class="close btnclose">닫기</button>
            </div>
                <div class="loading_landing">
                    <img src="${pageContext.request.contextPath}/resources/pandora3/images/common/img_loading_2.gif" alt="loading">
                    <p class="desc">
                        데이터를 불러오고 있습니다 
                        <em>잠시만 기다려주세요</em>
                    </p>
                </div>
            <div class="landing_header">
                <div class="Landing_header_in">
                    <h1 class="landing_header_logo">
                        <a href="${pageContext.request.contextPath}/login/forward.bdpLanding.adm"><img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_landing_logo.png" alt="bigdata portal 로고"></a>
                    </h1>
                    <div class="landing_gnb">
                        <ul class="landing_gnb_List" id="landing_gnb_List">

                        </ul>
                    </div>
                    <div class="landing_acc">
                        <div class="login_info">
                            <p class="user_name"><span id="usr_nm"></span> <span id="pos_nm"></span> <em id="org_nm"></em></p>
                            <p class="date" id="lgn_access_dy"><span></span></p>
                        </div>
                        <ul class="add_list">
                            <li>
                                <p class="btnUserAcc"><strong><span class="user_edit" id="rol_app_btn">권한 신청</span></strong></p>
                            </li>
                            <li id="bdpMain">
                                <a href="#" style="display: none;"><img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_landing_set.png" alt="이동" /></a>
                            </li>
                            <li>
                                <a href="#"><img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_landing_logout.png"  id="logout" alt="로그아웃" /></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- container -->
            <div class="landing_container">
                <div class="landing_content">
                    <div class="landing_top">
                        <div class="landing_notice_area">
                            <h2 class="title">
                                <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_bell.png" alt="공지사항 이미지">
                                <a href="#">
                                    <span id="line_notice"></span>
                                </a>
                                <button id="btn_search" class="btn_common type_light_green type_more">
                                    <img src="https://s3.ap-northeast-2.amazonaws.com/ldps-prd.static.bpn/pandora3/images/lotte_bpn/img_green_plus.png" alt="더하기">
                                     더보기
                                </button>
                            </h2>
                            <p class="date" id="line_notice_date" ></p>
                        </div>
                        <div class="weather_area">
                            <a href="https://www.weather.go.kr/w/weather/today.do" target="_blank">
                                <img src="" alt="날씨 맑음">
                                <p class="desc_1">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </p>
                                <p class="desc_2">
                                </p>
                            </a>
                        </div>
                    </div>
                    <div class="landing_center">
                        <div class="high_light_area">
                            <div class="high_light_title">
                                <h2 class="title"><span id="report_title"></span> 매출 하이라이트<em class="small">(월누계)  </em><a href="#"  class="more_right on move_sit8">이동</a></h2>
                                <div class="date">데이터기준일 : <span id="bi_date"></span>
                                    <div class="tooltip_area type_highlight">
                                        <button type="button" class="question_btn" onclick="toolTip(this)">
                                            <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_green_question.png" alt="물음표" />
                                        </button>
                                        <div class="tooltip_content">
                                            <table>
                                                <colgroup>
                                                    <col style="" />
                                                    <col style="" />
                                                    <col style="" />
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th colspan="2">구 분</th>
                                                        <th>설 명</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>1</td>
                                                        <td class="color_green">총 매출</td>
                                                        <td>상품 판매가액의 총합 (=영업통합시스템 총 매출액)</td>
                                                    </tr>
                                                    <tr>
                                                        <td>2</td>
                                                        <td class="color_green">공시 매출</td>
                                                        <td>매출 이익을 관리하는 이익중심 매출 지표  : 공시매출 = 총 매출 - 에누리성비용 - 상품대금 + 기타영업수입<br />
                                                            <em class="caution">※ 에누리성 비용 : 온·오프라인 에누리, 사은행사비, 포인트外      ※ 기타영업수입 : 임대수수료, 관리비 수입 外</em>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>3</td>
                                                        <td class="color_green">고객 매출</td>
                                                        <td>L.POINT 기반 멤버십 고객의 매출(= 오프라인 + 온라인[프리미엄몰/엘롯데/콘랍샵外] L.POINT 고객 매출)<br /><span class="color_green">※ 오프라인은 백화점에 입점한 슈퍼마켓(롯데슈퍼), 롭스 등 기존 고객 非식별 매장 추가</span></td>
                                                    </tr>
                                                    <tr>
                                                        <td>4</td>
                                                        <td class="color_green">우수고객 매출</td>
                                                        <td>AVE + MVG 등급의 (본인+가족 합산) 매출</td>
                                                    </tr>
                                                    <tr>
                                                        <td>5</td>
                                                        <td>달성률</td>
                                                        <td>추정매출 대비 총 매출 달성률 : (총 매출/추정매출)*100 <br /><span class="color_green">※ 기준:전점 기준</span></td>
                                                    </tr>
                                                    <tr>
                                                        <td>6</td>
                                                        <td>신장률</td>
                                                        <td>전년 동기간 대비 조회 기간의 (총 매출·공시매출·고객매출·우수고객매출)신장률 <br /> : (조회기간 매출-전년 동기간 매출) / 전년 동기간 매출<br /><span class="color_green">※ 기준:전사, 지역조직은 기존점 기준</span></td>
                                                    </tr>
                                                    <tr>
                                                        <td>7</td>
                                                        <td>구성비</td>
                                                        <td>총 매출 대비 구성비 : (고객매출 / 총 매출) *100<br />고객매출 대비 구성비 : (우수고객매출 / 고객매출) *100<br /><span class="color_green">※ 기준:전점 기준</span></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                               </div>
                            </div>
                            <div class="high_light_list">
                                <ul class="list">
                                    <li>
                                        <div class="list_top">
                                            <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_highlight_1.png" alt="총 매출">
                                            <span class="title">총 매출</span>
                                            <div class="price_box">
                                                <span class="price" id="bi_select0_1">0</span>
                                                <span class="txt">백만원</span>
                                            </div>
                                            <div class="price_box small">
                                                <em>전년 : </em>
                                                <span class="price" id="bi_select0_2">0</span>
                                                <span class="txt">백만원</span>
                                            </div>
                                        </div>
                                        <div class="list_bottom">
                                            <ul class="bottom_list">
                                                <li>
                                                    <span class="left">
                                                        달성률
                                                    </span>
                                                    <span class="right">
                                                        <em class="percent" id="bi_select0_3">0%</em>
                                                        <span class="new_txt" id="bi_tot_select0_3">(전사 : 3.5%)</span>
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="left">
                                                        신장률
                                                    </span>
                                                    <span class="right">
                                                        <em class="percent up" id="bi_select0_4">0%</em>
                                                        <span class="new_txt" id="bi_tot_select0_4">(전사 : 3.5%)</span>
                                                    </span>
                                                </li>
                                            </ul>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="list_top">
                                            <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_highlight_2.png" alt="공시매출">
                                            <span class="title">공시매출</span>
                                            <div class="price_box">
                                                <span class="price" id="bi_select1_1">0</span>
                                                <span class="txt">백만원</span>
                                            </div>
                                            <div class="price_box small">
                                                <em>전년 : </em>
                                                <span class="price" id="bi_select1_2">0</span>
                                                <span class="txt">백만원</span>
                                            </div>
                                        </div>
                                        <div class="list_bottom">
                                            <ul class="bottom_list">
                                                <li>
                                                    <span class="left">
                                                        구성비(총매출 대비)
                                                    </span>
                                                    <span class="right">
                                                        <em class="percent" id="bi_select1_3">0%</em>
                                                        <span class="new_txt" id="bi_tot_select1_3">(전사 : 3.5%)</span>
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="left">
                                                        신장률
                                                    </span>
                                                    <span class="right">
                                                        <em class="percent up" id="bi_select1_4">0%</em>
                                                        <span class="new_txt" id="bi_tot_select1_4">(전사 : 3.5%)</span>
                                                    </span>
                                                </li>
                                            </ul>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="list_top">
                                            <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_highlight_3.png" alt="고객매출">
                                            <span class="title">고객매출</span>
                                            <div class="price_box">
                                                <span class="price" id="bi_select2_1">0</span>
                                                <span class="txt">백만원</span>
                                            </div>
                                            <div class="price_box small">
                                                <em>전년 : </em>
                                                <span class="price" id="bi_select2_2">0</span>
                                                <span class="txt">백만원</span>
                                            </div>
                                        </div>
                                        <div class="list_bottom">
                                            <ul class="bottom_list">
                                                <li>
                                                    <span class="left">
                                                        구성비(총매출 대비)
                                                    </span>
                                                    <span class="right">
                                                        <em class="percent" id="bi_select2_3">0%</em>
                                                        <span class="new_txt" id="bi_tot_select2_3">(전사 : 3.5%)</span>
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="left">
                                                        신장률
                                                    </span>
                                                    <span class="right">
                                                        <em class="percent up" id="bi_select2_4">0%</em>
                                                        <span class="new_txt" id="bi_tot_select2_4">(전사 : 3.5%)</span>
                                                    </span>
                                                </li>
                                            </ul>
                                        </div>
                                    </li>
                                    <li id="ave_mvg_report">
                                        <div class="list_top">
                                            <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_highlight_4.png" alt="우수고객 매출">
                                            <span class="title">우수고객 매출 (AVE+MVG)</span>
                                            <div class="price_box">
                                                <span class="price" id="bi_select3_1">0</span>
                                                <span class="txt">백만원</span>
                                            </div>
                                            <div class="price_box small">
                                                <em>전년 : </em>
                                                <span class="price" id="bi_select3_2">0</span>
                                                <span class="txt">백만원</span>
                                            </div>
                                        </div>
                                        <div class="list_bottom">
                                            <ul class="bottom_list">
                                                <li>
                                                    <span class="left">
                                                        구성비(고객매출대비)
                                                    </span>
                                                    <span class="right">
                                                        <em class="percent" id="bi_select3_3">0%</em>
                                                        <span class="new_txt" id="bi_tot_select3_3">(전사 : 3.5%)</span>
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="left">
                                                        신장률
                                                    </span>
                                                    <span class="right">
                                                        <em class="percent up" id="bi_select3_4">0%</em>
                                                        <span class="new_txt" id="bi_tot_select3_4">(전사 : 3.5%)</span>
                                                    </span>
                                                </li>
                                            </ul>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="no_sty type_highlight" id="mstr_uspr_id">
                            <p class="desc">권한이 없습니다.</p>
                        </div>
                    </div>

                    <div class="landing_center">
                        <div class="landing_customer_area">
                            <div class="landing_tab_area">
                                <ul class="landing_tab_list">
                                    <li>
                                        <span class="item on" data-tab="tab_1">
                                            방문객수 비교
                                            <a href="#" class="more_right move_sit1">이동</a>
                                        </span>
                                    </li>
                                    <li class="event">
                                        <span class="item " data-tab="tab_2">
                                            MKT 추천
                                            <a href="#" class="more_right move_sit7">이동</a>
                                        </span>
                                    </li>
                                    <li class="off" id="vipLngeutlprco">
                                        <span class="item" data-tab="tab_3">
                                            라운지 고객 현황
                                            <a href="#" class="more_right move_sit2">이동</a>
                                        </span>
                                    </li>
                                    <li class="off" id="brandReport">
                                        <span class="item" data-tab="tab_4">
                                            브랜드 레포트
                                            <a href="#" class="more_right">이동</a>
                                        </span>
                                    </li>
                                </ul>
                                <div class="landing_tab_content">
                                    <ul class="tab_content_list">
                                        <li data-tab="tab_1" id="tab1" class="on">
                                            <div class="graph_wrap type_line">
                                                <div class="graph_list">
                                                    <div id="graph_line" style="height:145px;">
                                                    </div>
                                                    <ul class="graph_kinds type_right">
                                                    </ul>
                                                </div>
                                            </div>
                                            <p class="tab_desc style2">
                                                SKT 통신사 DB를 활용하여 <em id="dstr_title">본점</em> 방문객수를 카운팅하고, 같은 기준으로 경쟁 점포별 방문객수를 비교할 수 있습니다.
                                                <span class="bottom_txt">※ 점별 방문객수 100%변환(SKT 점유율 60%) / 1일 1인 카운팅  / 개인식별 불가</span>
                                             </p>
                                        </li>
                                        <li data-tab="tab_2" id="tab2" >
                                            <!--
                                            <div class="graph_wrap type_donut">
                                                <div class="graph_list">
                                                    <div class="donut">
                                                        <div id="graph_donut" style="width:250px; height:200px;"></div>
                                                        <ul class="graph_kinds type_bottom">
                                                            <li class="type_sky">구매예상고객</li>
                                                            <li class="type_green">마케팅가능고객</li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                             -->

                                            <div class="circle_box">
                                                <div class="in">
                                                    <em id="pch_fore_cust_cnt">- 명</em>
                                                    <strong>
                                                        추가지출<br />
                                                        예상고객
                                                    </strong>
                                                       <div class="mkt_more_area">
                                                        <p>
                                                            구매패턴 및 온·오프 행동 기반  <br /><em>이번 달 추가 지출 가능성 높은 고객</em>
                                                        </p>
                                                       </div>
                                                </div>
                                                <span class="recommend">
                                                        <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_mkt_recommend.png" alt="추천" />
                                                </span>
                                            </div>
                                            <div class="mkt_detail">
                                                <ul class="list">
                                                    <li>
                                                        <span id="chrn_fore_cust_cnt">- 명</span>
                                                        <span>이탈위험</span>
                                                        <div class="mkt_more_area">
                                                            <p>
                                                                구매패턴 기반  <em>향후 6개월 이탈 가능성 높은 고객</em>
                                                            </p>
                                                        </div>
                                                    </li>
                                                    <li >
                                                        <span id="chnl_crs_fore_cust_cnt">- 명</span>
                                                        <span>채널확대예상<br />(온→오프)</span>
                                                        <div class="mkt_more_area">
                                                            <p>
                                                                엘롯데만 이용하는 고객 중 <em>오프라인 구매예측 고객</em>
                                                            </p>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <span id="chrn_rcov_fore_cust_cnt">- 명</span>
                                                        <span>이탈회복예상</span>
                                                        <div class="mkt_more_area">
                                                            <p>
                                                                6개월 미구매 고객 중 <em>이번 달 회복(구매) 예측 고객</em>
                                                            </p>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <span id="excll_entr_cust_cnt">- 명</span>
                                                        <span>우수고객 <br />진입예상</span>
                                                        <div class="mkt_more_area type_prior">
                                                            <p>
                                                                구매패턴 및 온·오프 행동 기반 <em>우수고객 등급 이번 달 진입 예측 고객(MVG/VIP)</em>
                                                                 <span class="caution">※ 우수고객 관리점에 해당(아울렛 제외)</span>
                                                            </p>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                            <p class="tab_desc">
                                                <em id="mkt_title">20년 3월 전사</em> 기준 AI가 추천하는 마케팅 고객군 규모 입니다. 캠페인을 기획해보세요!
                                                <span class="bottom_txt">※ AI 추천 마케팅 고객군 규모는 월 1회 업데이트</span>
                                            </p>
                                        </li>
                                        <li data-tab="tab_3" >
                                            <div class="graph_wrap type_bar">
                                                <div class="graph_list">
                                                    <div class="bar">
                                                        <div id="graph_bar" style="height:145px;"></div>
                                                    </div>
                                                </div>
                                                <div class="launge_list">
                                                    <p class="date" id="vst_date"></p>
                                                    <ul class="list">
                                                        <li>
                                                            <span class="lanunge_left">입실고객수</span>
                                                            <span class="lanunge_right" id="vst_cust_cnt">- 명</span>
                                                        </li>
                                                        <li>
                                                            <span class="lanunge_left">평균 체류시간</span>
                                                            <span class="lanunge_right" id="vat_time">- 분</span>
                                                            <div class="mkt_more_area" >
                                                                <p>
                                                                    <em>평균 체류시간 = 퇴실시각 – 입실시각</em>
                                                                </p>
                                                                <table>
                                                                    <colgroup>
                                                                        <col style="width:30%;" />
                                                                        <col style="" />
                                                                    </colgroup>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td>※ 입실시각 : </td>
                                                                            <td>라운지 입실 시(카드센싱 기준)</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>※ 퇴실시각 : </td>
                                                                            <td>① 라운지 담당자가 퇴실 등록 시(미등록시 2시간 이후 퇴실처리)  <br />
                                                                                ② 착석 테이블에 신규 주문 발생 시
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <span class="lanunge_left">평균 주문수</span>
                                                            <span class="lanunge_right" id="drnk_ord_prdc_cnt">- 잔</span>

                                                            <div class="mkt_more_area">
                                                                <p>
                                                                    <em>평균 주문수 : 동반고객 포함 평균 주문수 </em>
                                                                </p>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <span class="lanunge_left">구매율</span>
                                                            <span class="lanunge_right" id="ord_chg_tovrrt">- %</span>
                                                        </li>
                                                        <li>
                                                            <span class="lanunge_left">구매금액</span>
                                                            <span class="lanunge_right" id="slng_amt">- 백만원</span>
                                                        </li>
                                                        <li>
                                                            <span class="lanunge_left">객단가</span>
                                                            <span class="lanunge_right" id="cust_unit_price">- 천원</span>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <p class="tab_desc"><em id="lng_title">전사</em> 우수고객 라운지 입실고객의 이용 행태와 구매율을 확인해보세요!
                                                <span class="bottom_txt">※ 입실고객수(동반, 테이크아웃 포함) │ 구매율·구매금액·객단가 (본인 기준) </span>
                                            </p>
                                        </li>
                                        <li data-tab="tab_4" id="tab4">
                                            <div>
                                                <div>
                                                    <div style="height:145px;">
                                                    <img src="${pageContext.request.contextPath}/resources/pandora3/images/common/img_brand_report.jpg" alt="brand report">
                                                    </div>
                                                    <ul class="graph_kinds type_right">
                                                    </ul>
                                                </div>
                                            </div>
                                            <p class="tab_desc style2">
                                                내가 관리하는 브랜드의 주요 지표와 구매 고객 특성을 확인할 수 있습니다. <em id="brandReportMonth">4월</em> 인사이트레포트를 확인해보세요!
                                                <span class="bottom_txt">※ 인사이트레포트는 매월 <em>4~5일</em>에 정기 업데이트 됩니다.</span>
                                             </p>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="current_customer">
                                <div class="current_customer_in">
                                    <div class="customer_title_area">
                                        <h2 class="title"><em id="sty_title">전사</em> 현재 내점 고객
                                            <a href="#" class="more_right on move_sit7">이동</a>
                                        </h2>
                                        <div class="time">
                                            <span id="load_dttm">- 기준</span>
                                            <button type="button" id="styRefreshData">
                                                <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_refresh.png" alt="새로고침">
                                            </button>
                                            <div class="tooltip_area type_customer">
                                                <button type="button" class="question_btn" onclick="toolTip(this)">
                                                    <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_green_question.png" alt="물음표" />
                                                </button>
                                                <div class="tooltip_content">
                                                    <p class="first">
                                                        <em class="color_green">현재 점포에 체류</em>할 것으로 추정되어
                                                        <em class="color_green">실시간 마케팅 발송</em>이 가능한 고객 모수를 보여 줍니다.<br />
                                                        <span>※ 영업시간 중 조회 가능 (11시 ~ 21시, 30분 단위 업데이트)</span>
                                                    </p>
                                                    <table>
                                                        <colgroup>
                                                            <col style="" />
                                                            <col style="" />
                                                        </colgroup>
                                                        <thead>
                                                            <tr>
                                                                <th colspan="2">구분</th>
                                                                <th>정의</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td colspan="2">입차</td>
                                                                <td class="align_left">주차장 입·출차 인식 고객
                                                                    <em class="caution">※ 현재 12개점 가능<br />
                                                                    (본점/분당/구리/안산/평촌/수원/인T/부본/대구/센텀/OL동부산/OL광교)</em>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">구매</td>
                                                                <td class="align_left">실시간 구매고객(POS 연동)</td>
                                                            </tr>
                                                            <tr>
                                                                <td rowspan="5">고객접점</td>
                                                                <td>유모차 대여 외</td>
                                                                <td class="align_left">유모차 대여 또는 물품 보관중인 고객</td>
                                                            </tr>
                                                            <tr>
                                                                <td>고객피팅</td>
                                                                <td class="align_left">프리미엄몰에서 피팅 예약을 하고 점에 방문 중인 고객</td>
                                                            </tr>
                                                            <tr>
                                                                <td>근거리배송</td>
                                                                <td class="align_left">식품 근거리배송을 접수한 고객</td>
                                                            </tr>
                                                            <tr>
                                                                <td>리버스픽</td>
                                                                <td class="align_left">점에서 엘롯데/프리미엄몰 구매 상품 반품 접수한 고객</td>
                                                            </tr>
                                                            <tr>
                                                                <td>스토어픽</td>
                                                                <td class="align_left">엘롯데/프리미엄몰에서 스토어픽을 신청하여 픽업한 고객</td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">우수 고객 라운지</td>
                                                                <td class="align_left">점내 모든 라운지 입실 고객</td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="customer_top">
                                        <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_current_customer.png" alt="현재고객수">
                                        <h3 class="title">현재</h3>
                                        <p class="desc" id="sty_cust_cnt">- 명</p>
                                    </div>
                                    <div class="customer_bottom">
                                        <ul class="list">
                                            <li>
                                                <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_custo_list_1.png" alt="입차">
                                                <h3 class="title">입차</h3>
                                                <p class="desc" id="prk_cust_cnt">- 대</p>
                                            </li>
                                            <li>
                                                <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_custo_list_2.png" alt="구매">
                                                <h3 class="title">구매</h3>
                                                <p class="desc" id="pch_cust_cnt">- 명</p>
                                            </li>
                                            <li>
                                                <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_custo_list_3.png" alt="고객접점">
                                                <h3 class="title">고객접점</h3>
                                                <p class="desc" id="poc_cust_cnt">- 명</p>
                                            </li>
                                            <li>
                                                <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_custo_list_4.png" alt="라운지">
                                                <h3 class="title">라운지</h3>
                                                <p class="desc" id="lnge_cust_cnt">- 명</p>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="no_sty" id="no_sty">
                                    <p class="desc">
                                           영업시간 중 조회 가능
                                           <em>(11시~21시, 30분 단위)</em>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="landing_center">
                        <div class="landing_customer_area">
                            <div class="landing_tab_area type_two">
                                <ul class="landing_tab_list">
                                    <li>
                                        <span class="item on" data-tab="tab_1">
                                            공지사항
                                        </span>
                                    </li>
                                    <li class="event">
                                        <span class="item " data-tab="tab_2">
                                            사은행사
                                        </span>
                                    </li>
                                </ul>
                                <div class="landing_tab_content">
                                    <ul class="tab_content_list">
                                        <li data-tab="tab_1" id="tab2"  class="on">
                                            <button id="moreViewNotie" class="btn_common type_light_green type_more" >
                                                <img src="https://s3.ap-northeast-2.amazonaws.com/ldps-prd.static.bpn/pandora3/images/lotte_bpn/img_green_plus.png" alt="더하기">
                                                 더보기
                                            </button>
                                            <div class="type_board type_nobor">
                                                <table id="notice_grid"></table>
                                            </div>
                                        </li>
                                        <li data-tab="tab_2">
                                            <button id="moreViewThkuEvnt" class="btn_common type_light_green type_more" >
                                                <img src="https://s3.ap-northeast-2.amazonaws.com/ldps-prd.static.bpn/pandora3/images/lotte_bpn/img_green_plus.png" alt="더하기">
                                                 더보기
                                            </button>
                                            <div class="type_board type_nobor">
                                                <table id="bpcm3001_grid"></table>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="point_area">
                                <div class="point_title_area">
                                    <h2 class="title"><span id="voc_title"> </span> VOC <em class="small"> (월누계)</em></h2>
                                    <div class="time_area">
                                        <span class="time" id="vocTime">
                                        </span>
                                        <div class="tooltip_area">
                                            <button type="button" class="question_btn" onclick="toolTip(this)">
                                                <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_green_question.png" alt="물음표" />
                                            </button>
                                            <div class="tooltip_content">
                                                <p class="first">
                                                    롯데백화점 홈페이지와 APP에 등록한 <br />
                                                    <em class="color_green">VOC(고객의소리)의 유형별 등록건수를 집계했습니다.</em>
                                                </p>
                                                <p>
                                                    데이터 기준 : D-1일 기준 나의점 월누계 건수 <br />
                                                    ※전년 대비 증감 건수 비교
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="point_top">
                                    <ul class="list">
                                        <li class="type_positive">
                                          <div>
                                             <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_positive.png" alt="만족">
                                             <p class="desc" id="voc02"><em></em></p>
                                          </div>
                                          <p>[만족]</p>
                                        </li>
                                        <li class="type_neutrality">
                                          <div>
                                            <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_neutrality.png" alt="제안/문의">
                                            <p class="desc" id="voc0104"></p>
                                          </div>
                                          <p>[문의/제안]</p>
                                        </li>
                                        <li class="type_negative">
                                          <div>
                                            <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_negative.png" alt="불만족">
                                            <p class="desc" id="voc03"></p>
                                          </div>
                                          <p>[불만족]</p>
                                        </li>
                                    </ul>
                                </div>
                                <div class="point_bottom">
                                    <ul class="list">
                                        <li>
                                            <h3 class="title">만족</h3>
                                            <p class="desc" id="voc02_cnt">0건 ( <em class="up">0</em> )</p>
                                        </li>
                                        <li>
                                            <h3 class="title">문의</h3>
                                            <p class="desc" id="voc01_cnt">0건 ( <em class="up">0</em> )</p>
                                        </li>
                                        <li>
                                            <h3 class="title">불만족</h3>
                                            <p class="desc" id="voc03_cnt">0건 ( <em class="down">0</em> )</p>
                                        </li>
                                        <li>
                                            <h3 class="title">제안</h3>
                                            <p class="desc" id="voc04_cnt">0건 ( <em class="down">0</em> )</p>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="cal_area">
                                <div class="full_calendar type_small">
                                    <div id="calendar">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="number_data_wrap">
                    <div class="number_btn">
                        <button type="button" class="number_text" onclick="number_data(this)">숫자로 보는 빅데이터</button>
                    </div>
                    <div class="more_area">
                        <div class="more_inner">
                            <div class="more_info first type_half">
                                <div class="more_content left">
                                    <div class="title_area">
                                        <h2 class="title">롯데백화점 전체 고객수</h2>
                                    </div>
                                    <span class="date">기준일 : 2020-04-01 </span>
                                    <div class="price_area">
                                        <p class="price_in">
                                            <span class="total"></span>
                                            <span class="price">2,201</span>
                                            <span class="unit">만명</span>
                                        </p>
                                        <p class="compare">
                                            (전월 대비 +19만명)
                                        </p>
                                    </div>
                                    <p class="desc first">
                                        빅데이터포탈은 롯데백화점의 오프라인+온라인
                                        고객의 통합된 View를 제공합니다.
                                    </p>
                                    <ul class="price_list">
                                        <li>① 멤버스 ↔ 백화점온라인 158만 ( <em class="top_arrow"></em> 3만)</li>
                                        <li>② 멤버스↔엘롯데 289만 (+10만)</li>
                                        <li>③ 백화점온라인↔엘롯데 96만 (+1만)</li>
                                        <li>④ 멤버스↔백화점온라인↔엘롯데 240만 (+4만)</li>
                                    </ul>
                                    <p class="caution">※ 백화점 온라인 고객 = 백화점 APP 가입고객 + 웨딩 + 문화센터</p>
                                    <div class="figure_area type_circle">
                                        <ul class="circle_list">
                                            <li>
                                                <span>멤버스</span>
                                                <span class="price">1,941만<em>(+16만)</em></span>
                                            </li>
                                            <li>
                                                <span>백화점온라인</span>
                                                <span class="price">539만<em>(+1만)</em></span>
                                            </li>
                                            <li>
                                                <span>엘롯데</span>
                                                <span class="price">744만<em>(+18만)</em></span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="more_content right">
                                    <div class="title_area">
                                        <h2 class="title">마케팅 가능 고객수</h2>
                                    </div>
                                    <span class="date">기준일 : 2020-04-01 </span>
                                    <div class="price_area">
                                        <p class="price_in">
                                            <span class="total"></span>
                                            <span class="price">1,639</span>
                                            <span class="unit">만명</span>
                                        </p>
                                        <p class="compare">
                                            (전월 대비 +4만명)
                                        </p>
                                    </div>
                                    <p class="desc first">
                                        롯데백화점 전체고객 중 마케팅 캠페인이 가능한 고객을 말합니다.
                                    </p>
                                    <p class="desc">
                                        각 채널별 수신 동의 여부 중   중복 값 제외하여 마케팅 가능한 총 고객수를 산정합니다.
                                    </p>
                                    <ul class="methods_list">
                                        <li>
                                            <p class="title">DM</p>
                                            <p class="desc">
                                                1,133<em class="unit">만명</em>
                                                <span class="more">
                                                    (+1만명)
                                                </span>
                                            </p>
                                        </li>
                                        <li>
                                            <p class="title">백화점 <br />APP PUSH</p>
                                            <p class="desc">
                                                141<em class="unit">만명</em>
                                                <span class="more">
                                                    (-)
                                                </span>
                                            </p>
                                        </li>
                                        <li>
                                            <p class="title">문자</p>
                                            <p class="desc">
                                                1,283<em class="unit">만명</em>
                                                <span class="more">
                                                    (+4만명)
                                                </span>
                                            </p>
                                        </li>
                                        <li>
                                            <p class="title">카카오 <br />플친</p>
                                            <p class="desc">
                                                TBD
                                                <%-- 140<em class="unit">만명</em>
                                                <span class="more">
                                                    (+000만명)
                                                </span> --%>
                                            </p>
                                        </li>
                                        <li>
                                            <p class="title">이메일</p>
                                            <p class="desc">
                                                962<em class="unit">만명</em>
                                                <span class="more">
                                                    (+3만명)
                                                </span>
                                            </p>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="more_info type_right_img">
                                <div class="more_content">
                                    <div class="title_area">
                                        <h2 class="title">2019년 롯데백화점 고객 프로파일</h2>
                                    </div>

                                        <table class="customer_table">
                                            <colgroup>
                                                <col style="" />
                                                <col style="" />
                                                <col style="" />
                                                <col style="" />
                                                <col style="" />
                                                <col style="" />
                                                <col style="" />
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th>구분</th>
                                                    <th>평균연령</th>
                                                    <th>성별</th>
                                                    <th>평균객단가</th>
                                                    <th>매출비중</th>
                                                    <th>방문빈도</th>
                                                    <th>주구매 상품군 <span>※ 기준 : 구매금액(상단) <em>구매고객수(하단)</em></span></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td class="color_brown">우수고객</td>
                                                    <td>52.2세</td>
                                                    <td>여 : 74% / 남 : 26%</td>
                                                    <td>3,170만</td>
                                                    <td>16%</td>
                                                    <td>월 4.5회</td>
                                                    <td>
                                                        <div class="product_list">
                                                            <span><em>1</em>가전<br />기초화장</span>
                                                            <span><em>2</em>캐릭터<br />스포츠</span>
                                                            <span><em>3</em>기초화장<br />레져</span>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="color_purple">상위 20%</td>
                                                    <td>45.4세</td>
                                                    <td>여 : 77% / 남 : 23%</td>
                                                    <td>490만</td>
                                                    <td>78%</td>
                                                    <td>월 1.7회</td>
                                                    <td>
                                                        <div class="product_list">
                                                            <span><em>1</em>가전<br />스포츠</span>
                                                            <span><em>2</em>레져<br />진유니</span>
                                                            <span><em>3</em>스포츠<br />레져</span>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="color_green">하위 80%</td>
                                                    <td>43.9세</td>
                                                    <td>여 : 70% / 남 : 30%</td>
                                                    <td>30만</td>
                                                    <td>22%</td>
                                                    <td>월 0.3회</td>
                                                    <td>
                                                        <div class="product_list">
                                                            <span><em>1</em>스포츠<br />스포츠</span>
                                                            <span><em>2</em>레져<br />진유니</span>
                                                            <span><em>3</em>진유니<br />영캐주얼</span>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            </div>
            <div id="debot">
                <a href="#">
                    <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/ico_debot.png" alt="D.BOT" />
                </a>
            </div>
        </div>
        <div id="landing_pop" class="landing_pop">
            <div class="landing_pop_in">
                <div class="pop_btn_area"> 
                    <button class="landing_pop_close" type="button" onclick="landing_pop_close(this)">
                        <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_pop_close.png" alt="닫기">
                    </button>
                </div>
                <div class="pop_content_area" id="pop_cnt_area">
                    
                </div>
                <div class="pop_check_area">
                    <div class="tableCheck">
                        <label class="container type_along" for="today_check">오늘 하루 열지 않음
                            <input role="checkbox" type="checkbox" id="today_check" >
                            <span class="checkmark"></span>
                        </label>
                    </div>
                </div>
            </div>
        </div>
    <!-- //wrapper -->
</body>
</html>
