<%-- 
   1. 파일명 : psys1008p001
   2. 파일설명 : 시스템사용자권한관리팝업
   3. 작성일 : 2018-03-28
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_header.jsp"%>

<script type="text/javascript">
var user_grid;

$(document).ready(function(){
	var gird_config = {
		gridid	: 'user_grid',
		pagerid	: 'user_grid_pager',
		columns	: [
			{name : 'USR_ID', label : '사용자ID', width : 60, align : 'center', hidden : true},
			{name : 'LGN_ID', label : '로그인ID',	width : 60, align : 'center'},
			{name : 'USR_NM',  label : '사용자명', width : 100},   
			{name : 'USR_EML_ADDR', label : '이메일', width : 100, hidden : true},
			{name : 'ORG_NM', label : '소속', width : 100},
			{name : 'USR_STAT_CD', label : '상태', align : 'center', sortable : false, editable : false, formatter : 'select', editoptions : {value : '<%=CodeUtil.getGridComboList("MSTS")%>'}},
	        {name : 'ACTV_YN', label : '계정활성화', align : 'center', sortable : false, editable : false, edittype:'select', formatter : 'select', editoptions : {value : 'Y:활성화;N:비활성화'}}
		],	
		editmode	: false,                   		// 그리드 editable 여부
		gridtitle	: '',      			// 그리드명
		multiselect	: true,                			// checkbox 여부
		formid		: 'search',                 	// 조회조건 form id
		height		: 150,                      	// 그리드 높이
		selecturl	: '/psys/getPsys1007List',	// 그리드 조회 URL
		events		: {}
	};

    var user_grid = new UxGrid(gird_config);
    user_grid.init();
    user_grid.setGridWidth($('.tblType1').width());

    $(".ui-jqgrid").addClass("pop_grid");
    
    $("#btn_retreive").click(function() {
    	user_grid.retreive(); // {success:function(){alert('retreive success');}}
    });

    $("#btn_keyword_select").click(function(){
        var rows = user_grid.getSelectRows();
        
        if(rows.length == 0)
        {
            alert('사용자를 선택해 주세요');
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
    
    $("#btn_close").click(function() {
    	parent.$('.layer_popup').bPopup().close();
    });    
});

$(window).resize(function() {
	user_grid.setGridWidth($('.tblType1').width());
});

</script>
<style type="text/css">
.pop_grid {margin-top:20px; border:1px solid #dddddd}
</style>
</head>
<body id="pop">
	<div class="frameWrap">
		<div class="subCon">
			<h1><%=_title%></h1>
	
			<div class="subConIn">
				<div class="subConScroll">
					<!-- 조회조건 -->
					<form name="search" id="search" name="search" onsubmit="return false">
						<div class="frameTopTable">
							<table class="tblType1">
								<colgroup>
									<col width="85px;" />
									<col width="" />
								</colgroup>
								<tr>
									<th>사용자명</th>
									<td>
										<span class="txt_pw">
											<input type="text" name="usr_nm" id="usr_nm" class="text" style="" value="" />
										</span>
									</td>
								</tr>
							</table>
						</div>
						<div class="btnWrap">
							<button type="button" class="btn_common btn_gray" id="btn_retreive">조회</button>
						</div>
					</form>
					<!-- 조회조건  // -->
			
					<!-- 그리드 -->
					<table id="user_grid"></table>
					<div id="user_grid_pager"></div>
					<!-- 그리드 // -->
				</div>
			</div>
			<div class="grid_btn">
				<button type="button" class="btn_common btn_black" id="btn_keyword_select" name="btn_keyword_select">선택</button>
				<button type="button" class="btn_common btn_gray" id="btn_close" name="btn_close">닫기</button>
			</div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_footer.jsp"%>
