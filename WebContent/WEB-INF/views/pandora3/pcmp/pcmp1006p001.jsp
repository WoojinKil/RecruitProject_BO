<%-- 
   1. 파일명 : pcmp1006p001
   2. 파일설명 : 직책/직무팝업
   3. 작성일 : 2020-05-25
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_header.jsp" %>
<script type="text/javascript">
var content = '<%= parameterMap.getValue("content") %>';
$(document).ready(function(){
	
	var popup_config = { 
		gridid		: 'popup_grid',
		pagerid		: 'popup_grid_pager',
        columns		: [
        	{name : 'CMPNY_CD', label : '법인코드', hidden : true},
            {name : 'CONTENT_CD', label : '코드', hidden : true},
			{name : 'CONTENT_NM', label : '이름', align : 'center', width : 60},
			{name : 'CONTENT_RMK', label : '비고', width : 100}
		],
		editmode	: false,						// 그리드 editable 여부
		gridtitle	: '',							// 그리드명
		multiselect	: false,							// checkbox 여부
		formid		: 'search',						// 조회조건 form id
		height		: '100%',							// 그리드 높이
		selecturl	: '/pcmp/getPcmp1006p001',		// 그리드 조회 URL
		events		: {

		}
	};



    
    var popup_grid = new UxGrid(popup_config);
	popup_grid.init(); 
	popup_grid.setGridWidth($('.tblType1').width());
	popup_grid.retreive();
	
    if(content == 'staflevel'){
    	jQuery("#popup_grid").jqGrid("setLabel", "CONTENT_NM", "직급명");
    }else if(content == 'stafduty'){
    	jQuery("#popup_grid").jqGrid("setLabel", "CONTENT_NM", "직책명");
    }else if(content == 'stafjob'){
    	jQuery("#popup_grid").jqGrid("setLabel", "CONTENT_NM", "직무명");
    }
	
    $(".ui-jqgrid").addClass("pop_grid");
    
	$("#btn_retreive").click(function() {
		popup_grid.retreive(); // {success:function(){alert('retreive success');}}
	});  
    
	$("#btn_select").click(function(){
		var rows = popup_grid.getSelectRows();
		var content = '<%= parameterMap.getValue("content") %>';
		if(rows.length == 0)
		{
			alert('항목을 선택해 주세요');
			return;
		}
		
		//호출된 iframe id 획득
		var iframeId = '#tab-' + '<%= parameterMap.getValue("target_id") %>';

		//ifram 객체 획득
		var $frame = parent.$(iframeId)[0];
		
		//ifram 접근
     	var gocoderFrameGo = $frame.contentWindow || $frame.contentDocument ;
		
		//callback 함수 실행
     	gocoderFrameGo.<%= parameterMap.getValue("callback") %>(rows, content);
		
		parent.$('.layer_popup').bPopup().close();
  
	});  
    
	$("#btn_close").click(function(){
		parent.$('.layer_popup').bPopup().close();
	});  
});

$(window).resize(function() {
	popup_grid.setGridWidth($('.tblType1').width());
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
					<form name="search" id="search" name="search" onsubmit="return false" autocomplete="off">
						<input type="hidden" name="cmpny_cd" id="cmpny_cd" value="<%= parameterMap.getValue("cmpny_cd") %>" />
						<input type="hidden" name="content" id="content" value="<%= parameterMap.getValue("content") %>" />
						<div class="frameTopTable">
							<table class="tblType1">
								<colgroup>
									<col width="85px;" />
									<col width="" />
								</colgroup>
								
								<tr>
									<th>이름</th>
									<td>
										<span class="txt_pw"><input type="text" name="content_nm" id="content_nm" class="text" value="" /></span>
									</td>
								</tr>
							</table>
						</div>
						<div class="btnWrap">
							<button type="button" class="btn_common btn_gray" id="btn_retreive">조회</button>
						</div>
					</form>
					<!-- 조회조건  // -->
		
					<!-- Grid -->
					<table id="popup_grid"></table>
					<div id="popup_grid_pager"></div>
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
