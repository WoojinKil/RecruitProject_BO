<%-- 
   1. 파일명 : accessStatistics
   2. 파일설명: 진입통계 목록
   3. 작성일 : 2017-12-28 최초작성
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<style>
</style>
<script type="text/javascript">

var static_grid;

$(document).ready(function(){
	
	var grid_config = { 
		gridid	: 'static_grid',
		pagerid	: 'static_grid_pager',
		columns	: [
			{name : 'SEQ_NO', width : 100, label : '모듈번호', hidden : true},
			{name : 'STD_YMD_TP', width : 100, label : ' ', align : 'center', editable : false,
			 formatter : function(value, options, rowJson){ 
					var type = $("#sch_type").val();

					if (type == "02")
						return value + "월";
					else if (type == "03")
						return value + "년";

					return value;
				}
			},
			{name : 'VISR_CNT', width : 100, label : '방문자수', align : 'right', editable : false, formatter : fn_formatNumber},
			{name : 'SCRN_ACS_CNT', width : 100, label : '페이지뷰', align : 'right', editable : false, formatter : fn_formatNumber}
		],
		editmode	: true,									// 그리드 editable 여부
		gridtitle	: '진입통계목록',							// 그리드명
		multiselect	: true,									// checkbox 여부
		formid		: 'search',								// 조회조건 form id
		shrinkToFit	: true,									// 컬럼 width 자동조정
		autowidth	: true,
		height		: 420,								// 그리드 높이
		cellEdit	: false,
		selecturl	: '/main/selectStaticsGridList',	// 그리드 조회 URL
	};
	
	static_grid = new UxGrid(grid_config);
	static_grid.init();
	static_grid.setGridWidth($('.tblType1').width());
	
	// 조회버튼 클릭 이벤트
	$("#btn_retreive").click(function(){
		
		// 페이징이 1page를 초과할 시 초기화
		if($("#static_grid").jqGrid('getGridParam', 'page') > 1)
			$("#static_grid").jqGrid('setGridParam', {'page' : 1});

		static_grid.retreive({
			success : function(){
				var type = $("#sch_type").val();
				var year = $("#sch_dt").val().replace(/-/gi, "").substring(0,4);
				var txt = "";
				
				if(type == "01")
					txt = "기준일";
				else if(type == "02")
					txt = "기준월 (" + year + "년)";
				else if(type == "03")
					txt = "기준연도";

				$("#jqgh_static_grid_STD_YMD_TP").text(txt);
			}
		});
		
		fn_setCount();
	});
	
	// DATAPICKER 초기화
	$("#sch_dt").datepicker({
		defaultDate	: "d",
		changeMonth	: true,
		changeYear	: true,
		dateFormat	: 'yy-mm-dd',
	}).keyup(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	});
	
	$("#sch_dt").val($.dateToString(new Date()));
	
	$("#btn_retreive").trigger("click");

});

// grid resizing
$(window).resize(function(){
	static_grid.setGridWidth($('.tblType1').width());
});

function fn_setCount()
{
	ajax({
		url		: '/main/selectStaticsCntList',
		data	: {sch_dt : $("#sch_dt").val()},
		success	: function(data){

			$("#tgtVisitorCnt").text(fn_formatNumber(data.tgtVisitorCnt));
			$("#tgtPageViewCnt").text(fn_formatNumber(data.tgtPageViewCnt));
			
			$("#totVisitorCnt").text(fn_formatNumber(data.totVisitorCnt));
			$("#totPageViewCnt").text(fn_formatNumber(data.totPageViewCnt));

		}
	});
}

//숫자 쉼표 추가
function fn_formatNumber(value, options, rowJson)
{
	if(isEmpty(value))
		return 0;
	else
		return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
			<div class="subConTit">
				<h1><%=_title%></h1>
				<div class="breadcrumb">
					<span class="home">홈</span>
					<span class="depth1">회원관리</span>
					<span class="depth2">회원정보관리</span>
					<span class="depth3">회원정보통합조회</span>
				</div>
			</div>    
	        <div class="frameTopTable">
				<form name="search" id="search" onsubmit="return false">
					<div class="rightTableBtn">
						<div class="tableBtn">
							<button type="button" class="btn_common btn_default" id="btn_retreive">조회</button>
						</div>
					</div>
					<table class="tblType1 mB60">
						<colgroup>
							<col width="15%" />
							<col width="35%" />
							<col width="15%" />
							<col width="35%" />
						</colgroup>
						<tr>
							<th>기준일자</th>
							<td><span class="txt_pw"><input type="text" name="sch_dt" id="sch_dt" /></span></td>
							<th>추출유형</th>
							<td>
								<span class="txt_pw">
									<select class="select " name="sch_type" id="sch_type">
										<option value="01">일자별</option>
										<option value="02">월별</option> 
										<option value="03">연도별</option>
									</select>
								</span>
							</td>
						</tr>
						<tr>
							<th>전체현황</th>
							<td><b>방문자수 : </b><span id="totVisitorCnt"></span>&nbsp;/&nbsp; <b>페이지뷰 : </b><span id="totPageViewCnt"></span></td>
							<th id="stdStatic">기준현황</th>
							<td><b>방문자수 : </b><span id="tgtVisitorCnt"></span>&nbsp;/&nbsp; <b>페이지뷰 : </b><span id="tgtPageViewCnt"></span></td>
						</tr>
					</table>
				</form>
			</div>
			<div class="bgBorder"></div> 
			<table class="tblType3">
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
			<!-- Grid -->
			<table id="static_grid"></table>
			<div id="static_grid_pager"></div>
			<!-- Grid // -->
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
