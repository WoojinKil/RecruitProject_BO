<%--
   1. 파일명    : psys1050p001
   2. 파일설명 : BI라이센스계정 팝업
   3. 작성일    : 2020-02-28
   4. 작성자    : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_header.jsp" %>
<script type="text/javascript">
var rol_grid;

$(document).ready(function() {
	var rol_config = {
		gridid		: 'rol_grid',
		pagerid		: '',
        columns		: [
			{name : 'BI_MSTRS_CD', label : 'BI라이센스코드', align : 'left', sorttype : 'int'},
			{name : 'BI_MSTRS_NM', label : '계정명'      , align : 'left'},
		],
		editmode	:  false,							// 그리드 editable 여부
		gridtitle	: 'BI라이센스계정목록',					// 그리드명
		multiselect	:  false,							// checkbox 여부
		formid		: 'search',							// 조회조건 form id
		height		: 150,								// 그리드 높이
		selecturl	: '/psys/getPsys1050p001bIList',    // 그리드 조회 URL
		events      : {

			ondblClickRow: function (event, rowid, irow, icol) {

				var row = rol_grid.getRowData(rowid);

			    //호출된 iframe id 획득
		        var iframeId = '#tab-' + '<%= parameterMap.getValue("target_id") %>';

		        //ifram 객체 획득
		        var $frame = parent.$(iframeId)[0];

		        //ifram 접근
		        var gocoderFrameGo = $frame.contentWindow || $frame.contentDocument ;

		        //callback 함수 실행
		        gocoderFrameGo.<%= parameterMap.getValue("callback") %>(row);

		        parent.$('.layer_popup').bPopup().close();

			},
		}
	};
	rol_grid = new UxGrid(rol_config);
	rol_grid.init();
	rol_grid.setGridWidth($('.tblType1').width());

	// 조회조건에 코드 세팅
	var bi_mstrs_cd = '<%= parameterMap.getValue("bi_mstrs_cd") %>';
	$("#inp_bi_mstrs_cd").val(bi_mstrs_cd);
   if(bi_mstrs_cd.length >0){
	// 자동조회
		rol_grid.retreive();
   }


	// 조회버튼 클릭 시
	$("#btn_retreive").click(function() {
		rol_grid.retreive();
	});

    $("#btn_close").click(function() {
    	parent.$('.layer_popup').bPopup().close();
    });

    $("#btn_select").click(function() {
        var rowId = rol_grid.getSelectRowIDs(); // multiselect가 false 이면 단건 조회

        if(isEmpty(rowId)) {
        	alert("BI라이센스를 선택해 주세요.");
        	return false;
        }

        var row = rol_grid.getRowData(rowId);

        //호출된 iframe id 획득
        var iframeId = '#tab-' + '<%= parameterMap.getValue("target_id") %>';

        //ifram 객체 획득
        var $frame = parent.$(iframeId)[0];

        //ifram 접근
        var gocoderFrameGo = $frame.contentWindow || $frame.contentDocument ;

        //callback 함수 실행
        gocoderFrameGo.<%= parameterMap.getValue("callback") %>(row);

        parent.$('.layer_popup').bPopup().close();

    });
});

$(window).resize(function() {
	rol_grid.setGridWidth($('.tblType1').width());
});
</script>
</head>
<body id="pop">
	<div class="frameWrap">
		<div class="subCon">
			<h1><%=_title %></h1>
			<div class="subConIn">
				<div class="subConScroll">
					<!-- 조회조건 -->
					<form name="search" id="search" name="search" onsubmit="return false">
					    <input type="hidden" name="us_yn" value="Y" />
						<div class="frameTopTable">
							<table class="tblType1">
								<colgroup>
									<col width="120px;" />
									<col width="" />
								</colgroup>
								<tr>
									<th>BI라이센스코드</th>
									<td>
										<span class="txt_pw"><input type="text" name="bi_mstrs_cd" id="inp_bi_mstrs_cd" class="text w80" style="" maxlength="32" /></span>
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
					<table id="rol_grid"></table>
					<div id="rol_grid_pager"></div>
					<!-- Grid // -->
				</div>
			</div>
			<div class="grid_btn">
			    <button type="button" class="btn_common btn_gray" id="btn_select" name="btn_select">선택</button>
				<button type="button" class="btn_common btn_gray" id="btn_close"  name="btn_close">닫기</button>
			</div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_footer.jsp" %>
