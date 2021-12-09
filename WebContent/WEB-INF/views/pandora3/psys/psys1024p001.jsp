<%-- 
   1. 파일명 : psys1024p001
   2. 파일설명 : 메뉴 리스트 조회
   3. 작성일 : 2018-04-27
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>
<script type="text/javascript">
var menu_grid;

$(document).ready(function(){
	
	// 공통코드 복수 설정
	$("#mst_cd_arr").val(new Array( 'SYS002', 'SYS001'))
	ajax({
		url: '/psys/getPsysCommon',
		data : $("form[name=frm_sysCdDtl]").serialize(),
		success: function(data) {
			//makeData(data.selectData);
		},
	});
	
    var menu_config = { 
        // grid id
        gridid: 'menu_grid',
        pagerid: 'menu_grid_pager',
        // column info
        columns:[{name:'MNU_SEQ', label:'메뉴ID',editable:false, align:'center'},
        		 {name:'MNU_NM', label:'메뉴명',editable:false},
        		 {name:'FRNT_YN', label:'구분',editable:false, align:'center', formatter: 'select', editoptions:{value:'Y:FO;N:BO'}}
		],          
        editmode: true,                                  // 그리드 editable 여부
        gridtitle: '프로그램 목록',                          // 그리드명
        multiselect: false,                              // checkbox 여부
        formid: 'search',                                // 조회조건 form id
        height: 150,                                     // 그리드 높이
        shrinkToFit: true,                               // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl: '/psys/getPsys1024P001List',  // 그리드 조회 URL
        events: {
                 onCellSelect: function(event, rowid, icol) {        // 해당 셀 선택시
                    var row = menu_grid.getRowData(rowid);
                 
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
    
      
    menu_grid = new UxGrid(menu_config);
    menu_grid.init();
    menu_grid.setGridWidth($('.tblType1').width());
    
    $("#btn_retreive").click(function() {
        menu_grid.retreive({data:{sys_cd:$("#sys_info").val()}});
    });
    
    getSystemList();
});

//grid resizing
$(window).resize(function() {
	menu_grid.setGridWidth($('.tblType1').width());
});

//사이트 리스트 취득
function getSystemList() {
    var html = "";
    ajax({
        url     : "/pdsp/getPdsp1011ListSit",
        data    : {sys_cd : _sys_cd} , 
        success : function (data) {
            if (data.RESULT == "S") {
                var sitListCnt = data.rows.length;
                $(data.rows).each(function (index) {
                    // 조회 건수가 하나일 경우 단일 하나의 시스템
                    if(sitListCnt == 1) {
                        html += "<option value="+ this.SYS_CD +" selected='selected' >"+ this.SYS_NM +"</option>"
                        return false;
                    } else {
                        html += "<option value="+ this.SYS_CD +">"+ this.SYS_NM +"</option>"
                        $("#sys_info").closest('div').show();
                    }
                });
                $("#sys_info").append(html);
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
				<div class="subConScroll">	
					<form name="search" id="search" onsubmit="return false">
						<div class="frameTopTable">	
							<table class="tblType1">
								<colgroup>
									<col width="85px;" />
									<col width="" />
									<col width="85px;" />
									<col width="" />
								</colgroup>
								<tr>
									<th>사이트명</th>
									<td>
                                        <select id="sys_info" name="sys_info" class="select" >
                                            <option value="">전체</option>
                                        </select>
                                    </td>
									<th>메뉴명</th>
									<td><span class="txt_pw"><input type="text" name="sch_mnu_nm" id="sch_mnu_nm" class="w100"/></span></td>
								</tr>
							</table>
						</div>
						<div class="btnWrap">
							<button type="button" class="btn_common btn_gray" id="btn_retreive">조회</button>
						</div>
					</form>
					<!-- search // -->
					<!-- Grid -->
					<table id="menu_grid"></table>
					<div id="menu_grid_pager"></div>
					<!-- Grid // -->
				</div>
			</div>
		</div>
		<form name="frm_sysCdDtl" id="frm_sysCdDtl" submit="return false;">
			<input type="hidden" name="mst_cd_arr" id="mst_cd_arr" />
		</form>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>
