<%-- 
   1. 파일명 : psys1030p001
   2. 파일설명 : 권한 검색 팝업
   3. 작성일 : 2018-03-27
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_header.jsp" %>
<script type="text/javascript">
var org_grid;
var sys_cd = '<%= parameterMap.getValue("sys_cd") %>';

$(document).ready(function() {
	var org_config = { 
		gridid		: 'org_grid',
		pagerid		: '',
        columns		: [
        	{name : 'ORG_CD', label : '조직 번호', align: 'center',  hidden : true},
			{name : 'UP_ORG_CD', label : '상위 조직 번호', align : 'center', hidden : true},
			{name: 'HR_UP_ORG_NM', label:'상위 조직 이름'},
			{name: 'ORG_NM', label:'조직 이름'}
		],
		editmode	: false,							// 그리드 editable 여부
		gridtitle	: '조직 목록',							// 그리드명
		formid		: 'search',							// 조회조건 form id
		height		: 500,								// 그리드 높이
		selecturl	: '/psys/getPsys1009List',	// 그리드 조회 URL
		events      : {
			// 더블 클릭 이벤트			
			ondblClickRow : function(obj, irow, icol) {
				
				var row = org_grid.getRowData(irow);
				<%-- eval('opener.<%= parameterMap.getValue("callback") %>')(row);
		        window.close(); --%>	
		      	//호출된 iframe id 획득
				var iframeId = '#tab-' + '<%= parameterMap.getValue("target_id") %>';

				//ifram 객체 획득
				var $frame = parent.$(iframeId)[0];
				
				//ifram 접근
		     	var gocoderFrameGo = $frame.contentWindow || $frame.contentDocument ;
				
				//callback 함수 실행
		     	gocoderFrameGo.<%= parameterMap.getValue("callback") %>(row);
		        
		        parent.$('.layer_popup').bPopup().close();
		        
			}
		}
	};
	org_grid = new UxGrid(org_config);
	org_grid.init();
	org_grid.setGridWidth($('.tblType1').width());

	
	$("#sys_cd").val(sys_cd);
	org_grid.retreive();
	
	$("#btn_retreive").on("click", function() {
		alert("서비스 준비중입니다.");
	});	
	
    
});



$(window).resize(function() {
	org_grid.setGridWidth($('.tblType1').width());
});
</script>
</head>
<body id="pop">
	<div class="frameWrap">
		<div class="subCon comPopup">
			<h1><%=_title %></h1>
			
			<!-- 조회조건 -->
			<!-- 조회조건 -->
			<form name="search" id="search" name="search" onsubmit="return false">
				<input type="hidden" id="sys_cd" name="sys_cd" value="<%= parameterMap.getValue("sys_cd") %>" />
				
				<table class="tblType1 mB60">
					<colgroup>
						<col width="20%" />
						<col width="*" />
						<col width="70px" />
					</colgroup>
					<tr>
						<th>조직명</th>
						<td>
							<span class="txt_pw"><input type="text" name="mnu_nm" id="mnu_nm" class="text w100" style="" maxlength="100" /></span>
						</td>
						<td>
							<div class="grid_btn">
								<button class="btn_common btn_default" id="btn_retreive">조회</button>
							</div>
						</td>
					</tr>
				</table>
			</form>
			<!-- 조회조건  // -->

			<!-- Grid -->
			<table id="org_grid"></table>
			<div id="org_grid_pager"></div>
			<!-- Grid // -->
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_footer.jsp" %>
