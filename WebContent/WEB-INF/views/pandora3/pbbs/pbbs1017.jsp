<%-- 
   1. 파일명 : pbbs1017
   2. 파일설명: 캠페인 정보
   3. 작성일 : 2019-07-01
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<link href='${pageContext.request.contextPath}/resources/pandora3/fullcalendar/css/fullcalendar.min.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/pandora3/fullcalendar/css/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='${pageContext.request.contextPath}/resources/pandora3/fullcalendar/js/moment.min.js'></script>
<%-- <script src='${pageContext.request.contextPath}/resources/pandora3/fullcalendar/js/jquery.min.js'></script> --%>
<script src='${pageContext.request.contextPath}/resources/pandora3/fullcalendar/js/jquery-ui.min.js'></script>
<script src='${pageContext.request.contextPath}/resources/pandora3/fullcalendar/js/fullcalendar.js'></script>
<script src='${pageContext.request.contextPath}/resources/pandora3/fullcalendar/js/ko.js'></script>

<script src=""></script>
<script type="text/javascript">
var chg_flag = "insert"; 
var currentTime = new Date();
var schedule_id;
var userId = '<%=userInfo.getUser_id() %>';
var userNm = '<%=userInfo.getUser_nm() %>';
var my_schedule = null;
var button_title = '나의일정';
//캘린더 정보
function calendarData(){
    var events = [];
    ajax({
        url:'/pbbs/getPbbs1016ScdList',
        data:{my_schedule:my_schedule},
        success: function(data){
            var dataList = data.rows;
            for(i=0; i<dataList.length; i++) {
                //events.push({title: dataList[i].SCHEDULE_NAME,start: dataList[i].START_DATE,end: dataList[i].END_DATE, text: dataList[i].text, user: dataList[i].USER_NM, lct: dataList[i].LOCATION, outsideWork: dataList[i].OUTSIDE_WORK, schedule_id: dataList[i].SCHEDULE_ID, color: '#ff9f89'})
                events.push({
                    title: unescapeHtml(dataList[i].SCD_NM) , 
                    start: dataList[i].F_ST_DTTM,
                    end: dataList[i].F_ED_DTTM,
                    //id:dataList[i].REG_ID
                    cts: unescapeHtml(dataList[i].CTS), 
                    user: dataList[i].USR_NM, 
                    lct: dataList[i].LCT, 
//                     ady_yn: dataList[i].ADY_YN, 
                    schedule_id: dataList[i].SCD_SEQ,
                    color: '#caeff1',
                    crtr_id: dataList[i].CRTR_ID,
                    cstr_cd : dataList[i].CSTR_CD,
                    scd_cl_cd : dataList[i].SCD_CL_CD,
                    tit1 : dataList[i].TIT1,
                    tit2 : dataList[i].TIT2
                    });
            }
        }
    });
    return events;
}

$(document).ready(function() {
    
    $('#calendar').fullCalendar({
        header: {
        left: '',
        center: 'prev,title,next',
        right: 'month'
        },
        defaultDate: new Date(),
        locale: 'ko',
        navLinks: true,         // can click day/week names to navigate views
        businessHours: true,  // display business hours
        editable: true,
        allDayDefault: false,
        defaultView: "month",
        events:calendarData(),
        eventLimit:true,
        buttonText: {
         	month:    '이전'
        },
        views:{
            agenda:{
                eventLimit:5
            }
        },
        dayClick: function(date, jsEvent, view, resourceObj) {  
            chg_flag = "insert";
            var clickDate = moment(date._i).format("YYYY-MM-DD");
            var currentDate = moment(currentTime).format("YYYY-MM-DD");
            //데이터 초기화
            $("#title").val("");
            $("#lct").val("");
            $("#cts").val("");
            $("#cal_st_dt").val(clickDate);
            $("#cal_ed_dt").val(clickDate);
            $("#scd_cl_cd option[value='']" ).prop("selected", true);
            schedule_id="";
        },
        eventRender: function (event, element) {
            
            //초기화
            $("#lct").val("");
            $("#cts").val("");
            element.click(function() {
                chg_flag = "update";
                schedule_id = event.schedule_id;
                $("#title").val(event.title);
                $("#lct").val(event.lct);
                $("#user").html(event.user);
                if(event.start != null){
                    $("#cal_st_dt").val(event.start.format('YYYY-MM-DD'));
                }else{
                    $("#cal_st_dt").val(moment(currentTime).format('YYYY-MM-DD'));
                }
                if(event.end != null){
                    $("#cal_ed_dt").val(event.end.format('YYYY-MM-DD'));
                }else{
                    $("#cal_ed_dt").val(moment(currentTime).format('YYYY-MM-DD'));
                }
                $("#cts").val(event.cts);
                $("#scd_cl_cd option[value='"+ event.scd_cl_cd +"']" ).prop("selected", true);
                
//                 if(event.ady_yn =='Y'){
//                     $("#target").prop("checked", true);
//                 }else{
//                     $("#promotion").prop("checked", true);
//                 }
                
            });
        },
        eventDrop: function(event, delta, revertFunc){
            //등록자만 일정변경 가능
            if(event.crtr_id != userId){
                revertFunc();
                return false;
            }
            //과거일정 등록 제한
            var clickDate = moment(event.start).format("YYYY-MM-DD");
            var currentDate = moment(currentTime).format("YYYY-MM-DD");
            
            if(!confirm("일정을 변경하시겠습니까?")){
                revertFunc();
            }else{
                chg_flag = "update";
                var events = calendarData();
                var formData = new FormData($('#frm_write')[0]);
                var endDate = null;
                
                for(var i=0; i<events.length; i++){
                    if(events[i].schedule_id == event.schedule_id){
                        formData.append("scd_seq", events[i].schedule_id);
                        endDate = events[i].end;
                    }
                }
                formData.append("st_dttm", event.start.format("YYYYMMDDhhmmss"));
                if(isNotEmpty(event.end)){
                    formData.append("ed_dttm", event.end.format("YYYYMMDDhhmmss"));
                }else{
                    var endDttm = event.start.format("YYYYMMDD") + endDate.substr(11,2)+endDate.substr(14,2)+"59";
                    formData.append("ed_dttm", endDttm);
                } 
                formData.append("chg_flag", "update");
                
                saveData(formData);
                
            }
        } 
    });

    doInit();
    
    //신규버튼
     $("#newButton").click(function(){
    	 schedule_id = "";
    	 $("#scd_cl_cd").val("");
    	 $("#calendarForm").clearFormData();
    	 chg_flag = "insert";
     });
    
    //저장버튼
    $("#changeButton").click(function(){
        
        var events = calendarData();
        var formData = new FormData($('#frm_write')[0]);
        
        for(var i=0; i<events.length; i++){
            if(events[i].schedule_id == schedule_id){
                formData.append("scd_seq", events[i].schedule_id);
            }
        }
        
        var startDate = moment($("#cal_st_dt").val()).format("YYYYMMDD");
        var endDate = moment($("#cal_ed_dt").val()).format("YYYYMMDD");
        startDate = startDate + "000000";
        endDate = endDate + "235959";
        
        formData.append("scd_nm", $("#title").val());
        formData.append("lct", $("#lct").val());
        formData.append("st_dttm", startDate);
        formData.append("ed_dttm", endDate);
        formData.append("cts", $("#cts").val());
//         formData.append("ady_yn",$("input[name=ady_yn]:checked").val());
        formData.append("scd_cl_cd",$("#scd_cl_cd").val());
        
        if(chg_flag == "insert"){
            formData.append("chg_flag", "insert");
        }else if(chg_flag == "update"){
            formData.append("chg_flag", "update");
        }
        if(validChk()){
            saveData(formData);
        }
        
    });
    
    //삭제버튼
    $("#deleteButton").click(function(){
        var events = calendarData();
        var formData = new FormData($('#frm_write')[0]);
        chg_flag = "delete";
        
        for(var i=0; i<events.length; i++){
            if(events[i].schedule_id == schedule_id){
                formData.append("scd_seq", events[i].schedule_id);
            }
        }
        
        if(!confirm("삭제하시겠습니까?")){
            return false;
        }
        formData.append("chg_flag", "delete");
        
        saveData(formData);
        
    });
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

//초기화
function doInit() {
	var obj = {
		    autoUpdateInput : false,
		    showDropdowns: true,
		    linkedCalendars: false,
		//  minDate : moment(),
		    /* 날짜/일시 선택 start */
// 		    timePicker: true,
// 		    timePicker24Hour : true,
		    //viewModel : 'month',
		    locale: {
		        format: 'YYYY-MM-DD'
		    }
		    /* 날짜/일시 선택 end */
		};
    
    $("#cal_st_dt").daterangepicker(obj, function(start, end, separator) {
        
        $("#cal_st_dt").val(start);
        $("#cal_ed_dt").val(end);
        
    });
    
    
    $("#cal_ed_dt").on('click', function () {
        $("#cal_st_dt").trigger('click');
   });
    
    initSelectNumbers();
}
//일정 등록, 수정, 삭제
function saveData(formData){
    $.ajax({
        url : _context + "/pbbs/savePbbs1016ScdInf",
        type: 'POST',
        data: formData,
        mimeType:"multipart/form-data",
        contentType: false,
        cache: false,
        processData:false,
        success: function(data) {
            var json = eval('('+data+')');
            if(json.RESULT == _boolean_success) {
                if(chg_flag == "delete"){
                    alert("삭제되었습니다.");
                }else{
                    alert("저장되었습니다.");
                }
                $('.ui-dialog-titlebar-close').trigger('click');
                $('#calendar').fullCalendar( 'removeEvents' );
                $('#calendar').fullCalendar( 'addEventSource', {events:calendarData()} );
            }
        }
    });
}

function validChk(){
    var retVal = true;
    //필수값 체크
    var title = $("#title").val().replace(/ /g,"");
    if(isEmpty($("#scd_cl_cd").val())){
        alert("스케쥴 구분을 선택해 주세요.");
        return false;
    }
    if(isEmpty(title)){
        alert("일정명을 입력해주세요.");
        $("#title").focus();
        retVal = false;
        return retVal;
    }
    
    /* var cts = $("#cts").val().replace(/ /g,"");
    if(isEmpty(cts)){
        alert("내용을 입력해주세요.");
        $("#cts").focus();
        retVal = false;
        return retVal
    } */
    
//     if(isEmpty($("input[name=ady_yn]:checked").val())){
//         alert("캠페인유형을 선택해주세요.");
//         $("input[name=ady_yn]").focus();
//         retVal = false;
//         return retVal
//     }
    
    
    
    return retVal;
}
</script>
<style>

body {
    margin: 40px 10px;
    padding: 0;
    font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
    font-size: 14px;
}

.fc-widget-header { 
    padding-top:5px; 
    padding-bottom:5px;
} 
.fc-sat { color:#0000FF;  } /* 토요일 */
.fc-sun { color:#FF0000; }  /* 일요일 */

.calendar_popup {
    background-color:#fff;
    border-radius:0;
    color:#000;
    display:none;
    padding:30px;
    width:400px;
}
.calendar_popup table{
    width:100%;
}
.calendar_popup td {
    padding:3px;
}

.tblType{width:98%;}
.tblType td{border-bottom:1px solid #e0e0e0;}
.tblType tr th{padding:10px 20px;font-size:12px;line-height:14px;font-weight:600;/* 2019-01-14 문자열 왼쪽정렬 수정 및 자간추가 */text-align:left;background:#fafafa;margin-left:80px;letter-spacing:1px;}
.tblType.sub tr th{padding:0px;font-size:12px;line-height:14px;font-weight:600;text-align:center;background:#fafafa;}
.tblType tr td{padding:10px 20px}
.tblType tr td:first-child{border-right:1px solid #e0e0e0;}

.ui-dialog-titlebar-close{ background:#337fd7 }

.ui-draggable-handle{ 
    border-bottom:2px solid #e0e0e0;
    padding:10px;
}
.ui-dialog .ui-dialog-titlebar {padding:0.5em 1.5em 0;}
.ui-dialog .ui-dialog-content{padding:0;}  

#ui-id-1{width:98%;color:#333333;font-size:14px;font-weight:bold;text-align:left;line-height:20px;border:0px solid #dddacf;height:26px;padding:0 0 0 10px;background:url('${pageContext.request.contextPath}/resources/pandora3/images/common/h1_bar.gif') no-repeat 0px 3px;}

.buttons{padding-bottom: 10px}

.fc-time{
   display : none;
}
.fc-row .fc-content-skeleton tbody tr:nth-child(1) .fc-day-grid-event {
    background-color: #caeff1 !important;
    border-color: #caeff1 !important
}
.fc-row .fc-content-skeleton tbody tr:nth-child(2) .fc-day-grid-event {
    background-color: #fdd3d3 !important;
    border-color: #fdd3d3 !important;
}
.fc-row .fc-content-skeleton tbody tr:nth-child(3) .fc-day-grid-event {
    background-color: #f9fdd3 !important;
    border-color: #f9fdd3 !important;
}
.fc-row .fc-content-skeleton tbody tr:nth-child(4) .fc-day-grid-event {
    background-color: #d3fdec !important;
    border-color: #d3fdec !important;
}
.frameWrap .fc-unthemed .fc-popover .fc-day-grid-event:nth-child(1){
    background-color: #caeff1 !important;
    border-color: #caeff1 !important
}
.frameWrap .fc-unthemed .fc-popover .fc-day-grid-event:nth-child(2){
    background-color: #fdd3d3 !important;
    border-color: #fdd3d3 !important;
}
.frameWrap .fc-unthemed .fc-popover .fc-day-grid-event:nth-child(3){
    background-color: #f9fdd3 !important;
    border-color: #f9fdd3 !important;
}
.frameWrap .fc-unthemed .fc-popover .fc-day-grid-event:nth-child(4){
    background-color: #d3fdec !important;
    border-color: #d3fdec !important;
}
.calendar_btn {
    position: absolute;
    right: 0;
}

</style> 
<body>
    <div class="frameWrap">
        <div class="subCon">
            <div class="subConTit typeCalender">
                <%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
                <%-- <h1 class="title"><%=_title %></h1>
                <div class="breadcrumb">
                    <span class="home">홈</span>
                    <span class="depth1">회원관리</span>
                    <span class="depth2">회원정보관리</span>
                    <span class="depth3">회원정보통합조회</span>
                </div> --%>
            </div>
            <div class="calendarWrap">
            	<div class="left">
	            	<div class="full_calendar">
	            		<div id="calendar"></div>
	            	</div>
            	</div>
            	<div class="right">
            		<div id="calendarInfo">
            		   <h3 class="cal_title">정보
            		   <span class="calendar_btn">
            		   		<button class="btn_common btn_default" id="newButton">신규</button>
            		   		<button class="btn_common btn_default" id="deleteButton">삭제</button>
            		   		<button class="btn_common btn_default" id="changeButton">저장</button>
            		   	</span>
            		   </h3>
            		   <form name="calendarForm" id="calendarForm" method="post">
	                   <table class="tblType1 typeRow mB20">
							<colgroup> 
								<col width="25%"/>
								<col width="*"/>
							</colgroup>
							<tr>
								<th><label class="vv">구분</label></th>
								<td>
									<div><%=CodeUtil.getSelectComboList("SCD_CL_CD","scd_cl_cd","선택안함","") %></div>
								</td>
							</tr>
							<tr>
								<th><label class="vv">일정명</label></th>
								<td>
									<span class="txt_pw">
										<input type="text" id="title" class="w100">
									</span>
								</td>
							</tr>
							<tr>
								<th><label class="vv">기간</label></th>
								<td class="typeCal">
									<div class="cals_div">
										<span class="txt_pw"><input class="cals w100" type="text" value="" id="cal_st_dt" autocomplete="off" /></span>
										<span class="space w10">~</span>
										<span class="txt_pw"><input class="cals w100" type="text" value="" id="cal_ed_dt" autocomplete="off" /></span>
									</div>
								</td>
							</tr>
							<!-- <tr>
								<th><label class="vv">대상지점</label></th>
								<td>
									<span class="txt_pw">
										<input type="text" id="lct" class="w100">
									</span>
								</td>
							</tr>
							<tr>
								<th><label class="vv">캠페인 템플릿</label></th>
								<td>
									<span class="txt_pw">
										<input type="text" id="no_title2" class="w100">
									</span>
								</td>
							</tr>
							<tr>
								<th><label class="vv">캠페인 분류</label></th>
								<td>
									<span class="txt_pw">
										<input type="text" id="no_title3" class="w100">
									</span>
								</td>
							</tr>
							<tr>
								<th><label class="vv">캠페인 유형</label></th>
								<td>
									<ul class="radioWrap typeOnline">
										<li>
											<input type="radio" name="ady_yn" id="target" value="Y">
											<label for="target" >타겟 캠페인</label>
										</li>
										<li>
											<input type="radio" name="ady_yn" id="promotion" value="N">
											<label for="promotion">홍보 캠페인</label>
										</li>
									</ul>
								</td>
							</tr>
							<tr>
								<th><label class="vv">비고</label></th>
								<td>
									<span class="txt_pw">
										<textarea id="cts" class="w100" rows="4"></textarea>
									</span>
								</td>
							</tr> -->
						</table>
						</form>
	                    <form name="frm_write" id="frm_write" enctype="multipart/form-data" method="post" onsubmit="return false;">
	                    </form>
	                </div>
            	</div>
            </div>
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
