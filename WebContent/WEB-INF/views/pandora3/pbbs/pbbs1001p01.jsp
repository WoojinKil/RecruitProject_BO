<%-- 
   1. 파일명 : psys1001p01
   2. 파일설명 : 템플릿 맵핑 추가 팝업
   3. 작성일 : 2018-03-27
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_header.jsp" %>
<script type="text/javascript">
var selRow;
$(document).ready(function() {
    var menu_config = {
    	// 그리드, 페이징 ID
        gridid:'menu_grid',
        pagerid:'menu_grid_pager',
        // 컬럼 정보
        columns:[{name:'SEL', label:'선택', align:'center', width:30, edittype:"radio", sortable:false, formatter:function(cellValue, option) {
        		     return '<input type="radio" name="menuRadio"  />';
		         }},
        	     {name:'TMPL_SEQ', label:'템플릿ID', align:'center', width:60, hidden:true},
                 {name:'TOP_MENU_NM', label:'상위메뉴명', width:100, sortable:false},
                 {name:'MID_MENU_NM', label:'중간메뉴명', width:100, sortable:false},
                 {name:'BOT_MENU_NM', label:'하위메뉴명', width:100, sortable:false}],
        editmode:false, 	// 그리드 editable 여부
        gridtitle:'메뉴 목록',	// 그리드명
        multiselect:false,	// checkbox 여부
        formid:'search',	// 조회조건 form id
        height:150,			// 그리드 높이
        selecturl:'/pbbs/getPbbs1001p01ModlMpnList', // 그리드 조회 URL
        events:{
        	beforeSelectRow:function(event, rowid) {
        		selRow = menu_grid.getRowData(rowid);
            }
        }
    };
    
    var menu_grid = new UxGrid(menu_config);
    menu_grid.init();
    menu_grid.setGridWidth($('.tblType1').width());
    
    // 조회 버튼 클릭 시 
    $("#btn_retreive").click(function() {
        menu_grid.retreive();
    });
    
    // 선택 버튼 클릭 시
    $("#btn_keyword_select").click(function() {
    	if(isEmpty(selRow)) {
    		alert('메뉴를 선택해 주세요.');
            return;
    	}
    	
    	// 메뉴매핑 여부 조회 후 매핑메뉴 정보 로드 및 저장
    	if(confirm("선택하신 메뉴를 맵핑하시겠습니까?")) {
    		existMenuMapped(selRow);
    	}
    });  
    
    // 닫기 버튼 클릭 시
    $("#btn_close").click(function() {
    	parent.$('.layer_popup').bPopup().close();    
    });
});

// 그리드 리사이징
$(window).resize(function() {
	menu_grid.setGridWidth($('.tblType1').width());
});

// 메뉴매핑 여부 조회 후 매핑메뉴 정보 로드
function existMenuMapped(selRow) {
	var tmpSeq = selRow.TMPL_SEQ;
	
	$.ajax({
		url:_context + '/pbbs/getPbbs1001p01ModlMpnYn',
		type:'POST',
		data:{tmp_seq:tmpSeq},
		success:function(data) {
			var json = eval('('+data+')');
			if(_boolean_success == json.RESULT) {
				if("N" == json.modl_mpn_yn) {
					
					
					//호출된 iframe id 획득
					var iframeId = '#tab-' + '<%= parameterMap.getValue("target_id") %>';

					//ifram 객체 획득
					var $frame = parent.$(iframeId)[0];
					
					//ifram 접근
			     	var gocoderFrameGo = $frame.contentWindow || $frame.contentDocument ;
					
					
					//callback 함수 실행
			     	gocoderFrameGo.<%= parameterMap.getValue("callback") %>(selRow, <%=parameterMap.getValue("rowId")%>, <%=parameterMap.getValue("modlSeq")%>);
					
					parent.$('.layer_popup').bPopup().close();
					
					
					
				}else {
					alert("이미 맵핑된 게시판입니다.");
					return;
				}
			}else {
				alert("작업이 정상적으로 실행되지 않았습니다. 잠시후 다시 시도하세요.");
				return;
			}
		}
	});
}
</script>
</head>
<body id="pop">
	<div class="frameWrap">
	    <div class="subCon comPopup">
	        <h1><%=_title %></h1>
	        <div class="subConIn">
		        <!-- search -->
		        <form name="search" id="search" name="search" onsubmit="return false">
			        <div class="frameTopTable">
				        <table class="tblType1">     
					        <colgroup>
								<col width="85px;">
								<col width="">
							</colgroup>
							<tbody>
					            <tr>
					                <th>메뉴명</th>
					                <td>
					                   <span class="txt_pw"><input type="text" name="mnu_nm" id="mnu_nm" class="text" value="" /></span>
					                </td>
					            </tr>
				            </tbody>
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
		        
		        <div class="grid_btn">
					<button type="button" class="btn_layer_close btn_common btn_gray" id="btn_close" name="btn_close">닫기</button>
					<button type="button" class="btn_common btn_black" id="btn_keyword_select" name="btn_keyword_select">선택</button>
				</div>
	        </div>
	    </div>
     </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_footer.jsp" %>
