<%-- 
    개요 : 회사검색 팝업
    수정사항 : 2020.05.28
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>
<script type="text/javascript">
var cmpny_grid;
var srch_txt = '<%= parameterMap.getValue("srch_txt") %>';

$(document).ready(function(){
	$("#srch_txt").val(srch_txt);
	
    var cmpny_config = { 
        // grid id
        gridid: 'cmpny_grid',
        pagerid: 'cmpny_grid_pager',
        // column info
        columns:[{name:'CMPNY_CD', label:'법인코드',editable:false},
            	 {name:'CMPNY_NM', label:'법인명',editable:false},
        		 {name:'RPRSNT_NM', label:'대표자명',editable:false},
        		 {name:'BIZ_REG_NO_VAL', label:'사업자등록번호',editable:false}
		],          
        editmode: false,                                  // 그리드 editable 여부
        gridtitle: '회사 목록',                         // 그리드명
        multiselect: false,                              // checkbox 여부
        formid: 'search',                                // 조회조건 form id
        height: 150,                                     // 그리드 높이
        shrinkToFit: true,                               // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl: '/pcmp/searchCmpny',  // 그리드 조회 URL
        events: {
        		ondblClickRow: function(event, rowid, irow, icol) {        // 해당 셀 선택시
                    var row = cmpny_grid.getRowData(rowid);
        			
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
    
      
    cmpny_grid = new UxGrid(cmpny_config);
    cmpny_grid.init();
    cmpny_grid.setGridWidth($('.tblType1').width());
    //Grid 조회
    cmpny_grid.retreive();

    $("#btn_close").click(function(){
        parent.$('.layer_popup').bPopup().close();
    });

    
});

//grid resizing
$(window).resize(function() {
	cmpny_grid.setGridWidth($('.tblType1').width());
});


</script>
</head>
<body id="pop">
	<div class="frameWrap">
		<div class="subCon">
			<h1><%=_title %></h1>
			<div class="subConIn">
				<form name="search" id="search" onsubmit="return false">
					<input type="hidden" name="srch_txt" id="srch_txt" />
				</form>
				<!-- search // -->
				<!-- Grid -->
				<table id="cmpny_grid"></table>
				<div id="cmpny_grid_pager"></div>
				<!-- Grid // -->
			</div>
		</div>
        <div class="grid_btn">
            <button type="button" class="btn_common btn_gray" id="btn_close" name="btn_close">닫기</button>
        </div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>
