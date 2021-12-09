<%-- 
   1. 파일명 : psys1003p001
   2. 파일설명 : 메뉴권한관리팝업
   3. 작성일 : 2018-03-27
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_header.jsp" %>
<script type="text/javascript">

var sys_cd = '<%= parameterMap.getValue("sys_cd") %>';

$(document).ready(function(){
	
	var menu_config = { 
		gridid		: 'menu_grid',
		pagerid		: 'menu_grid_pager',
        columns		: [
        	{name : 'SYS_NM', label : '사이트명', hidden : true},
            {name : 'SYS_CD', label : '사이트번호', hidden : true},
			{name : 'MNU_SEQ', label : '메뉴ID', align : 'center', width : 60},
			{name : 'MIDD_MNU_NM', label : '상위메뉴명', width : 100},   
			{name : 'MNU_NM', label : '메뉴명', width : 100},
			{name : 'US_YN', label : '사용여부',align : 'center', width : 100, formatter: function(cellValue, rowObject, options){
				return cellValue == "Y" ? "사용" : "미사용";
			}}
		],
		editmode	: false,						// 그리드 editable 여부
		gridtitle	: '',							// 그리드명
		multiselect	: true,							// checkbox 여부
		formid		: 'search',						// 조회조건 form id
		height		: 150,							// 그리드 높이
		selecturl	: '/psys/getPsys1003P001',	// 그리드 조회 URL
		events		: {}
	};
    
	var menu_grid = new UxGrid(menu_config);
	menu_grid.init();
	menu_grid.setGridWidth($('.tblType1').width());
    
    $(".ui-jqgrid").addClass("pop_grid");
    
	$("#btn_retreive").click(function() {
		menu_grid.retreive(); // {success:function(){alert('retreive success');}}
	});  
    
	$("#btn_select").click(function(){
		var rows = menu_grid.getSelectRows();
		
		if(rows.length == 0)
		{
			alert('메뉴를 선택해 주세요');
			return;
		}
		
		//호출된 iframe id 획득
		var iframeId = '#tab-' + '<%= parameterMap.getValue("target_id") %>';

		//ifram 객체 획득
		var $frame = parent.$(iframeId)[0];
		
		//ifram 접근
     	var gocoderFrameGo = $frame.contentWindow || $frame.contentDocument ;
		
		//callback 함수 실행
     	gocoderFrameGo.<%= parameterMap.getValue("callback") %>(rows);
		
		parent.$('.layer_popup').bPopup().close();
  
	});  
    
	$("#btn_close").click(function(){
		parent.$('.layer_popup').bPopup().close();
	});  
});

$(window).resize(function() {
	menu_grid.setGridWidth($('.tblType1').width());
});

</script>
<style type="text/css">
.pop_grid {margin-top:20px; border:1px solid #dddddd}
</style>
</head>
<body id="pop">
	<div class="frameWrap">
		<div class="subCon">
			<h1><%=_title %></h1>
			<div class="subConIn">
				<div class="subConScroll">
			
					<!-- 조회조건 -->
					<form name="search" id="search" name="search" onsubmit="return false">
						<input type="hidden" name="sys_cd" id="sys_cd" value="<%= parameterMap.getValue("sys_cd") %>" />
						<div class="frameTopTable">
							<table class="tblType1">
								<colgroup>
									<col width="85px;" />
									<col width="" />
									<col width="85px;" />
									<col width="" />
								</colgroup>
								
								<tr>
									<th>메뉴명</th>
									<td>
										<span class="txt_pw"><input type="text" name="mnu_nm" id="mnu_nm" class="text" value="" /></span>
									</td>
									<th>사용여부</th>
									<td>
										<span class="txt_pw">
											<select name="us_yn" id="us_yn" class="select">
												<option value="">전체</option>
												<option value="Y">사용</option>
												<option value="N">미사용</option>
											</select>
										</span>
									</td>
									<!-- 
									<td>
										<div class="grid_btn">
											<button class="btn_common btn_default" id="btn_retreive">조회</button>
										</div>
									</td> -->
								</tr>
							</table>
						</div>
						<div class="btnWrap">
							<button type="button" class="btn_common btn_gray" id="btn_retreive">조회</button>
						</div>
					</form>
					<!-- 조회조건  // -->
		
					<!-- Grid -->
					<table id="menu_grid"></table>
					<div id="menu_grid_pager"></div>
					<!-- Grid // -->
				</div>
			</div>
			<div class="grid_btn">
				<button type="button" class="btn_common btn_black" id="btn_select" name="btn_select">선택</button>
				<button type="button" class="btn_common btn_gray" id="btn_close" name="btn_close">닫기</button>
			</div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_footer.jsp" %>
