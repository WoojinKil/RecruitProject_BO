<%-- 
   1. 파일명   : sample1005
   2. 파일설명 : 데이터 별 그리드 샘플
   3. 작성일   : 2018-07-15
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>




<script type="text/javascript">
var role_grid;
// 한글 입력 방지
// 달력

var obj = {
	autoUpdateInput	: false,
	showDropdowns: true,
	linkedCalendars: false,
// 	minDate : moment(),
	/* 날짜/일시 선택 start */
    //viewModel : 'month',
    locale: {
        format: 'YYYY-MM-DD'
    }
	/* 날짜/일시 선택 end */
};
   


$(document).ready(function(){
	

	    /*
	     	daterangepicker 사용시 div로 input을 감싸고 div의 클래스 "cals_div"를 추가해야 함.
	     	input의 클래스는 cals를 추가 해야 한다.
	    */
	
	    $("input[name=viewModel]").on('change', function () {
	    	obj.viewModel = $(this).val();
	    	daterange(obj);
	    	daterange2(obj);
	    });
	    
	    $("input[name=singleDatePicker]").on('change', function () {
	    	obj.singleDatePicker = $(this).prop("checked");
	    	daterange(obj);
	    	daterange2(obj);
	    });
	    
	    $("input[name=showDropdowns]").on('change', function () {
	    	obj.showDropdowns = $(this).prop("checked");
	    	daterange(obj);
	    	daterange2(obj);
	    });
	    
	    
	    
	    $("#cal").daterangepicker(obj, function(start, end, separator) {
		    
		    $("#cal").val(start + separator + end);
		    
		}); 
	    
	    $("#calStart").daterangepicker(obj, function(start, end, separator) {
		    
		    $("#calStart").val(start);
		    $("#calEnd").val(end);
		    
		});
		
	    $("#calStart2").daterangepicker(obj, function(start, end, separator) {
		    
		    $("#calStart2").val(start);
		    $("#calEnd2").val(end);
		    
		});
	    
	    $("#calStart3").daterangepicker(obj, function(start, end, separator) {
		    
		    $("#calStart3").val(start);
		    $("#calEnd3").val(end);
		    
		});
	    $("#calStart4").daterangepicker(obj, function(start, end, separator) {
		    
		    $("#calStart4").val(start);
		    $("#calEnd4").val(end);
		    
		});
	    
	    $("#calEnd").on('click', function () {
	    	 $("#calStart").trigger('click');
	    });
	    
	    $("#calEnd2").on('click', function () {
	    	 $("#calStart2").trigger('click');
	    });
	    
	    $("#calEnd3").on('click', function () {
	    	 $("#calStart3").trigger('click');
	    });
	    
	    $("#calEnd4").on('click', function () {
	    	 $("#calStart4").trigger('click');
	    });
	    
});

var daterange =  function(obj) {
	$("#cal").val("");
	$("#cal").daterangepicker(obj, function(start, end, separator) {
		if(obj.singleDatePicker === true) {
			$("#cal").val(start);
		} else {
		    $("#cal").val(start + separator + end);
			
		}
	});
}

var daterange2 =  function(obj) {
	$("#calStart").val("");
	$("#calEnd").val("");
	$("#calStart").daterangepicker(obj, function(start, end, separator) {
		if(obj.singleDatePicker === true) {
			$("#calStart").val(start);
		} else {
			$("#calStart").val(start);
		    $("#calEnd").val(end);
		}
	});
}

</script>
</head>
<body id="app">
	<div class="frameWrap">
	    <div class="subCon">
		    <div class="subConTit">
				<h1 class="title">
					<button class="btnPageBookMark" id="btnPageBookMark">즐겨찾기</button>
					<span class="subTitle">daterangepicker 샘플</span>
					<button type="button" class="questionBtn">
						<img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_question.png" alt="">
					</button>
				</h1>
				<!-- <div class="breadcrumb">
					<span class="home">홈</span>
					<span class="depth1"></span>
					<span class="depth2"></span>
					<span class="depth3"></span>
				</div> -->
			</div>
	        <table class="tblType1 typeRow mB20">
				<colgroup>
					<col width="15%"/>
					<col width="*"/>
				</colgroup>
				<tr>
					<th><label for="" class="vv necessary">달력 종류</label></th>
					<td>
						<ul class="radioWrap typeOnline">
							<li>
								<input type="radio" name="viewModel"  value="day" checked="checked" id="tableRadio1">
								<label for="tableRadio1" >DayPicker(일 단위)</label>
							</li>
							<li>
								<input type="radio" name="viewModel" value="month" id="tableRadio2">
								<label for="tableRadio2">MonthPicker(월 단위) </label>
							</li>
						</ul>
					</td>
				</tr>
				<tr>
					<th><label for="" class="">싱글 달력 여부</label></th>
					<td>
						<div class="tableCheck">
							<label class="container typeInspect">singleDatePicker(달력 하나만 사용하기)
								<input type="checkbox" name="singleDatePicker" checked="checked" />
								<span class="checkmark"></span>
							</label>
						</div>
					</td>
				</tr>
				<tr>
					<th><label for="cal" class="vv necessary">캘린더 1</label></th>
					<td>
						<div class="cals_div">
							<span class="txt_pw"><input class="cals two_cals" type="text" value="" id="cal" autocomplete="off" /></span>
						</div>
					</td>
					</tr>
				<tr>
					<th><label for="" class="vv necessary">캘린더 2</label></th>
					<td>
						<div class="cals_div">
							<span class="txt_pw"><input class="cals w25" type="text" value="2019-10-23" id="calStart" autocomplete="off" /></span>
							<span>~</span>
							<span class="txt_pw"><input class="cals w25" type="text" value="2020-12-25" id="calEnd" autocomplete="off" /></span>
						</div>
					</td>
				</tr>
				<tr>
					<th><label for="" class="vv necessary">캘린더 3</label></th>
					<td>
						<div class="cals_div">
							<span class="txt_pw"><input class="cals w25" type="text" value="2019-12" id="calStart2" autocomplete="off" /></span>
							<span>~</span>
							<span class="txt_pw"><input class="cals w25" type="text" value="2019-12" id="calEnd2" autocomplete="off" /></span>
						</div>
					</td>
				</tr>
				<tr>
					<th><label for="" class="vv necessary">캘린더 4 </label></th>
					<td>
						<div class="cals_div">
							<span class="txt_pw"><input class="cals w25" type="text" value="2019-12-26" id="calStart3" autocomplete="off" /></span>
							<span>~</span>
							<span class="txt_pw"><input class="cals w25" type="text" value="2019-12-27" id="calEnd3" autocomplete="off" /></span>
						</div>
					</td>
				</tr>
				<tr>
					<th><label for="" class="vv necessary">캘린더 5 </label></th>
					<td>
						<div class="cals_div">
							<span class="txt_pw"><input class="cals w25" type="text" value="" id="calStart4" autocomplete="off" /></span>
							<span>~</span>
							<span class="txt_pw"><input class="cals w25" type="text" value="" id="calEnd4" autocomplete="off" /></span>
						</div>
					</td>
				</tr>
			</table>
			         <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
            <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
            <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
            <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
            <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
            <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
	    </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
