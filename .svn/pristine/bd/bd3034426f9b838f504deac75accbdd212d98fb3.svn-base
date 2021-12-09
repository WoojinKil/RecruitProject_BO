<%-- 
   1. 파일명 : pbbs1016
   2. 파일설명: 일정관리
   3. 작성일 : 2019-01-11
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
					title: dataList[i].SCD_NM, 
					start: dataList[i].F_ST_DTTM,
					end: dataList[i].F_ED_DTTM,
					//id:dataList[i].REG_ID
					cts: dataList[i].CTS, 
					user: dataList[i].USR_NM, 
					lct: dataList[i].LCT, 
					ady_yn: dataList[i].ADY_YN, 
					schedule_id: dataList[i].SCD_SEQ, 
					color: '#ff9f89',
					crtr_id: dataList[i].CRTR_ID
					});
			}
		}
	});
	return events;
}

$(document).ready(function() {
	
	$('#calendar').fullCalendar({
		header: {
		left: ' ',
		center: 'title',
		right: 'prev,next'
		},
		defaultDate: new Date(),
		locale: 'ko',
		navLinks: true, 		// can click day/week names to navigate views
		businessHours: true,  // display business hours
		editable: true,
		allDayDefault: false,
		defaultView: "month",
		//events:calendarData(),
		eventLimit:true,
		views:{
			agenda:{
				eventLimit:5
			}
		},
		customButtons: { 
			custom1: {
				text: '일정등록',
				id: 'check1',
				click: function() {
					chg_flag = "insert";
					//$("#title_name").css("display", "");
					$("#deleteButton").css("display", "none");
					$("#changeButton").css("display", "inline");
					$("#title").val("");
					$("#user").html(userNm);
					$("#lct").val("");
					$("#cts").val("");
					$("#cal_st_dt").val(moment(currentTime).format("YYYY-MM-DD"));
					$("#_st_dt_hh").val(moment(currentTime).format('HH'));
					$("#_st_dt_mm").val(moment(currentTime).format('mm'));
					$("#cal_ed_dt").val(moment(currentTime).format("YYYY-MM-DD"));
					$("#_ed_dt_hh").val(moment(currentTime).format('HH'));
					$("#_ed_dt_mm").val(moment(currentTime).format('mm'));
					$("#eventContent").dialog({ modal: true, title: '일정등록', width:500, closeText:''});
				}
			},
			custom2:{
				text: button_title,
				id:'myPlan',
				click: function(){
					if(isEmpty(my_schedule)){
						my_schedule = true;
						button_title = '나의일정';
					}else{
						my_schedule = null;
						button_title = '전체일정';
					}
					
					calendarData();
					$('#calendar').fullCalendar( 'removeEvents' );
					$('#calendar').fullCalendar( 'addEventSource', {events:calendarData()} );
				}
			}
		},
		dayClick: function(date, jsEvent, view, resourceObj) {  
			chg_flag = "insert";
			var clickDate = moment(date._i).format("YYYY-MM-DD");
			var currentDate = moment(currentTime).format("YYYY-MM-DD");
			
			if(clickDate < currentDate){
				alert("지나간 일정은 등록할 수 없습니다.");
			}else{
				//데이터 초기화
				//$("#title_name").css("display", "");
				$("#deleteButton").css("display", "none");
				$("#changeButton").css("display", "inline");
				$("#title").val("");
				$("#user").html(userNm);
				$("#lct").val("");
				$("#cts").val("");
				$("#cal_st_dt").val(clickDate);
				$("#_st_dt_hh").val(moment(currentTime).format('HH'));
				$("#_st_dt_mm").val(moment(currentTime).format('mm'));
				$("#cal_ed_dt").val(clickDate);
				$("#_ed_dt_hh").val(moment(currentTime).format('HH'));
				$("#_ed_dt_mm").val(moment(currentTime).format('mm'));
				$("#eventContent").dialog({ modal: true, title: '일정등록', width:500, closeText:''});
			}
			
		},
		eventRender: function (event, element) {
			chg_flag = "update";
			//초기화
			$("#lct").val("");
			$("#cts").val("");
			element.click(function() {
				schedule_id = event.schedule_id;
				
				//$("#title_name").css("display", "none");
				$("#changeButton").css("display", "inline");
				$("#deleteButton").css("display", "inline");
				if(event.crtr_id != userId){
					$("#title2").html(event.title);
					$("#lct2").html(event.lct);
					$("#user2").html(event.user);
					if(event.start != null){
						$("#cal_st_dt2").html(event.start.format('YYYY-MM-DD HH:mm'));
					}else{
						$("#cal_st_dt2").html(moment(currentTime).format('YYYY-MM-DD HH:mm'));
					}
					if(event.end != null){
						$("#cal_ed_dt2").html(event.end.format('YYYY-MM-DD HH:mm'));
					}else{
						$("#cal_ed_dt2").html(moment(currentTime).format('YYYY-MM-DD HH:mm'));
					}
					$("#cts2").html(event.cts);
					$("#eventContent2").dialog({ modal: true, title: '일정상세', width:500, closeText:''});
				}else{
					$("#title").val(event.title);
					$("#lct").val(event.lct);
					$("#user").html(event.user);
					if(event.start != null){
						$("#cal_st_dt").val(event.start.format('YYYY-MM-DD'));
						$("#_st_dt_hh").val(event.start.format('HH'));
						$("#_st_dt_mm").val(event.start.format('mm'));  
					}else{
						$("#cal_st_dt").val(moment(currentTime).format('YYYY-MM-DD'));
						$("#_st_dt_hh").val(moment(currentTime).format('HH'));
						$("#_st_dt_mm").val(moment(currentTime).format('mm'));
					}
					if(event.end != null){
						$("#cal_ed_dt").val(event.end.format('YYYY-MM-DD'));
						$("#_ed_dt_hh").val(event.end.format('HH'));
						$("#_ed_dt_mm").val(event.end.format('mm'));
					}else{
						$("#cal_ed_dt").val(moment(currentTime).format('YYYY-MM-DD'));
						$("#_ed_dt_hh").val(moment(currentTime).format('HH'));
						$("#_ed_dt_mm").val(moment(currentTime).format('mm'));
					}
					$("#cts").val(event.cts);
					$("#eventContent").dialog({ modal: true, title: '일정상세', width:500, closeText:''});
				}
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
			if(clickDate < currentDate){
				alert("지나간 일정으로 변경할 수 없습니다.");
				revertFunc();
				return false;
			}
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
		
		startDate = startDate + $("#_st_dt_hh").val() + $("#_st_dt_mm").val()+"00";
		endDate = endDate + $("#_ed_dt_hh").val() + $("#_ed_dt_mm").val()+"59";
		
		formData.append("scd_nm", $("#title").val());
		formData.append("lct", $("#lct").val());
		formData.append("st_dttm", startDate);
		formData.append("ed_dttm", endDate);
		formData.append("cts", $("#cts").val());
		
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

//초기화
function doInit() {
	setDatepicker("#cal", "_st_dt", "_ed_dt");
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
	if(isEmpty(title)){
		alert("제목을 입력해주세요.");
		$("#title").focus();
		retVal = false;
		return retVal;
	}
	
	var cts = $("#cts").val().replace(/ /g,"");
	if(isEmpty(cts)){
		alert("내용을 입력해주세요.");
		$("#cts").focus();
		retVal = false;
		return retVal
	}
	
	// 스트링타입의 날짜포맷 ex) "2019-01-17 10:13"
	var strFromDate = $("#cal_st_dt").val() + " " + $("#_st_dt_hh").val() + ":" + $("#_st_dt_mm").val();
	var strToDate   = $("#cal_ed_dt").val()   + " " + $("#_ed_dt_hh").val()   + ":" + $("#_ed_dt_mm").val();
	
	//과거일정 등록 제한
	var currentDate = moment(currentTime).format('YYYY-MM-DD');
	if($("#cal_st_dt").val() < currentDate){
		alert("지나간 일정은 등록할 수 없습니다.");
		return false;
	}
	// 팝업 전시시작일시, 종료일시 유효성 검사
	if(!validDateChk(strFromDate, strToDate)) {
		return false;
	}
	
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
.fc-sat { color:#0000FF;  }	/* 토요일 */
.fc-sun { color:#FF0000; }	/* 일요일 */

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

</style> 
<body>
	<div class="frameWrap">
		<div class="subCon">
		<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
			<%-- <div class="subConTit">
			
				<h1><%=_title %></h1>
				<div class="breadcrumb">
					<span class="home">홈</span>
					<span class="depth1">회원관리</span>
					<span class="depth2">회원정보관리</span>
					<span class="depth3">회원정보통합조회</span>
				</div>
			</div> --%>
			<div class="full_calendar type_small">
				<div class="calendar" id="calendar"></div>
			</div>
			<div id="calendarModal" class="modal fade">
				<div class="calendar_popup" id="eventContent" title="Event Details" style="display:none;">
					<table class="tblType">
						<tr>
							<td class="vv">사용자</td>
							<td><span id="user"></span></td>
						</tr>
						<tr id="title_name">
							<td class="vv">제목</td>
							<td><input type="text" id="title" style="width:100%"></td>
						</tr>
						<tr>
							<td>&nbsp;장소</td>
							<td><input type="text" id="lct"></td>
						</tr>
						<tr>
							<td class="vv">시작일</td>
							<td><input type="text" id="cal_st_dt"><select id="_st_dt_hh" class="select"></select> :<select id="_st_dt_mm" class="select"></select></td>
						</tr>
						<tr>
							<td class="vv">종료일</td>
							<td><input type="text" id="cal_ed_dt"><select id="_ed_dt_hh" class="select"></select> :<select id="_ed_dt_mm" class="select"></select></td>
						</tr>
						<tr>
							<td class="vv">내용</td>
							<td><textarea id="cts" style="width:100%" rows="4"></textarea></td>
						</tr>
					</table>
					<br/>
					<div class="buttons" style="text-align: center">
					<div style="display: inline-block;">
						<button class="btn-small btn-primary" id="changeButton" style="display: inline-block;">저장</button>
						<button class="btn-small btn-primary" id="deleteButton" style="display: inline-block;">삭제</button>
					</div>
					</div>
					<!-- <p><strong><a id="eventLink" href="" target="_blank">Read More</a></strong></p> -->
				</div>
				<div class="calendar_popup" id="eventContent2" title="Event Details" style="display:none;">
					<table class="tblType">
						<tr>
							<td>사용자</td>
							<td><span id="user2"></span></td>
						</tr>
						<tr>
							<td>제목</td>
							<td><span id="title2"></span></td>
						</tr>
						<tr>
							<td>장소</td>
							<td><span id="lct2"></span></td>
						</tr>
						<tr>
							<td>시작일</td>
							<td><span id="cal_st_dt2"></span></td>
						</tr>
						<tr>
							<td>종료일</td>
							<td><span id="cal_ed_dt2"></span></td>
						</tr>
						<tr>
							<td>내용</td>
							<td><textarea id="cts2" style="width:100%" rows="4" disabled></textarea></td>
						</tr>
					</table>
					<br/>
					<!-- <p><strong><a id="eventLink" href="" target="_blank">Read More</a></strong></p> -->
				</div>
				<form name="frm_write" id="frm_write" enctype="multipart/form-data" method="post" onsubmit="return false;">
				</form>
			</div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
