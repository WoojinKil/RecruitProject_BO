<%-- 
    개요 : BO 프로그램관리
    수정사항 :
        2018-03-30 최초작성
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>
<script type="text/javascript">
var pgm_grid;

$(document).ready(function(){
	
	
    var pgm_config = { 
        // grid id
        gridid: 'pgm_grid',
        pagerid: 'pgm_grid_pager',
        // column info
        columns:[{name:'SYS_CD', label:'시스템코드',editable:false,hidden:true },
            	{name:'SYS_NM', label:'시스템명',editable:false},
        		{name:'PGM_ID', label:'화면ID',editable:false},
        		{name:'PGM_NM', label:'화면명',editable:false},
        		{name:'TRG_URL', label:'URL',editable:false}
		],          
        editmode: true,                                  // 그리드 editable 여부
        gridtitle: '프로그램 목록',                         // 그리드명
        multiselect: false,                              // checkbox 여부
        formid: 'search',                                // 조회조건 form id
        height: 150,                                     // 그리드 높이
        shrinkToFit: true,                               // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl: '/psys/getPsys1001List',  // 그리드 조회 URL
        events: {
        		ondblClickRow: function(event, rowid, irow, icol) {        // 해당 셀 선택시
                    var row = pgm_grid.getRowData(rowid);
        			
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
    
      
    pgm_grid = new UxGrid(pgm_config);
    pgm_grid.init();
    pgm_grid.setGridWidth($('.tblType1').width());
    
    $("#btn_retreive").click(function() {
        pgm_grid.retreive();
    });
    
    $("#btn_close").click(function(){
        parent.$('.layer_popup').bPopup().close();
    });
    
    $("#btn_select").click(function() {
    	var rowId = pgm_grid.getSelectRowIDs(); // multiselect가 false 이면 단건 조회
    	
        if(isEmpty(rowId)) {
            alert("프로그램을 선택해 주세요.");
            return false;
        }
    	
    	var row = pgm_grid.getRowData(rowId);
        
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
    
    getSystemList();
});

//grid resizing
$(window).resize(function() {
	pgm_grid.setGridWidth($('.tblType1').width());
});


//사이트 리스트 취득
function getSystemList() {
    var html = "";
    ajax({
        url     : "/pdsp/getPdsp1011ListSit",
        data    : {}, 
        success : function (data) {
            if (data.RESULT == "S") {
                $(data.rows).each(function (index) {
        			$("#srch_sys_cd").append("<option value='" + this.SYS_CD + "'>" + this.SYS_NM + "</option> ");
                });
            }
        }
    });
}



</script>
</head>
<body id="pop">
	<div class="frameWrap">
		<div class="subCon">
			<h1><%=_title %></h1>
			<div class="subConIn">
				<form name="search" id="search" onsubmit="return false">
					<div class="frameTopTable">
						<table class="tblType1">
							<colgroup>
								<col style="width: 85px;" />
								<col style="width:" />
								<col style="width:" />
								<col style="width:85px;" />
								<col style="width:" />
								<col style="width:" />
							</colgroup>
							<tr>
								<th>시스템구분</th>
								<td colspan="2"><span class="txt_pw"><select id="srch_sys_cd" class="select" name="srch_sys_cd"><option value=""  selected="selected">전체</option></select></span></td>
								<th>프로그램명</th>
								<td colspan="2"><span class="txt_pw"><input type="text" name="srch_pgm_nm" id="srch_pgm_nm" class="w100"/></span></td>
							</tr>
						</table>
					</div>
					<div class="btnWrap">
						<button type="button" class="btn_common btn_gray" id="btn_retreive">조회</button>
					</div>
				</form>
				<!-- search // -->
				<!-- Grid -->
				<table id="pgm_grid"></table>
				<div id="pgm_grid_pager"></div>
				<!-- Grid // -->
				<form name="frm_sysCdDtl" id="frm_sysCdDtl" submit="return false;">
					<input type="hidden" name="mst_cd_arr" id="mst_cd_arr" />
				</form>
			</div>
		</div>
        <div class="grid_btn">
            <button type="button" class="btn_common btn_black" id="btn_select" name="btn_select">선택</button>
            <button type="button" class="btn_common btn_gray" id="btn_close" name="btn_close">닫기</button>
        </div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>
