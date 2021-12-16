<%-- 
   1. 파일명   : 공지사항관리
   2. 파일설명 : 회원관리
   3. 작성일   : 2018-03-27
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>
<script type="text/javascript">
var bbs_grid;

var target_row = null;


function fn_changeGridDate(element, row) {
	var gridId = $(element).closest("table").attr("id");
	$(element).on("propertychange change keyup paste input", function () {
		var chk = $("input:checkbox[id='jqg_" + gridId +"_"+ row.rowId +"']").is(":checked");
			if(chk != true) {
        		$("#"+gridId).jqGrid("setSelection", row.rowId, true);
			}
    	 
     });
}

$(document).ready(function(){
    var up_config = { 
        gridid    : 'bbs_grid',	    	// 그리드 id
        pagerid   : 'bbs_grid_pager',	// 그리드 페이지 id
        gridBtnYn : 'Y',						// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        // column info
        columns   : [
            {name : 'BBSNO', label : '게시판번호', sortable:false, editable : true, hidden : true},

            {name : 'BBSTITLE', label : '제목',   align : 'center', editable : true},
            {name : 'BBSCONTENT', label : '내용', edittype:'textarea',  align : 'left', editable : true},
            {name : 'BBSHIT', label : '조회수',   align : 'center', editable : false},
            {name : 'BBSWRITEDATE', label : '작성일자',   align : 'center', editable : false},
            {name : 'BBSUPDATEDATE', label : '갱신일자',   align : 'center', editable : false}
        ],          
        initval     : {SORT_ORD : 999}, // 컬럼 add 시 초기값
        editmode    : true,                                 // 그리드 editable 여부
        gridtitle   : '게시판 목록',                        // 그리드명
        multiselect : true,                                 // checkbox 여부
        formid      : 'search',                             // 조회조건 form id
        height      : '300',                                // 그리드 높이
        shrinkToFit : true,                                 // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl   : '/linkruit/getBbsList',          // 그리드 조회 URL
        saveurl     : '/linkruit/saveBbs',             // 그리드 입력/수정/삭제 URL
        events         : {

	                          onCellSelect: function(event, rowid, icol) {        // 해당 셀 선택시
	                              var row = bbs_grid.getRowData(rowid);
	                          
	                              // 표기형식을 나타내주고 입력할땐 셀을 비워준다.
	                              if (bbs_grid.getColName(icol) == 'bbsID') {
	                                 if(row.bbsID == "") { 
	                                	 bbs_grid.setCell(rowid, 'bbsID', '', '', {}, true); 
	                                 }
	                              }
	                              
	                              if(row.JQGRIDCRUD === "C") {
 	                            	  $("#bbs_grid").jqGrid('setColProp', 'bbsID', { editable: true });
	                              } else {
	                            	  $("#bbs_grid").jqGrid('setColProp', 'bbsID', { editable: false });
	                              }
	                              
	                          },
	                          onSelectRow: function (event, rowid, status, e) {
	                        	  var row = bbs_grid.getRowData(rowid);
	                        	  
	                          }
                          }
    };
    

    bbs_grid = new UxGrid(up_config);
    bbs_grid.init();

    bbs_grid.setGridWidth($('.tblType1').width());
    
    
    $("#cb_bbs_grid").css("display","none");
    
    // 마스터 저장 버튼 클릭 시 
    $("#btn_bbs_save").click(function() {

    	var rowid = bbs_grid.getSelectRowIDs();
        
        var row = bbs_grid.getRowData(rowid);
        var bbstitle = row.BBSTITLE;
        var bbscontent = row.bbscontent;
        
        
        

       
        if(bbstitle == "" || bbscontent == ""){
        	alert("제목과 내용을 입력해주세요.");
        	return false;
        	
        	
        }else {
	        // 코드id 수정못하도록 set false
	       // bbs_grid.save( {success:function(){$("#bbs_grid").jqGrid('setColProp', 'bbsID', { editable: false });}});
	        
	        //console.log(data);
        	fn_Save();
        }
    });
    
    // 마스터 행추가 버튼 클릭 시
    $("#btn_bbs_add").click(function() {
    	// default 값 세팅
       
        $("#bbs_grid").jqGrid('setColProp', 'BBSNO', { editable: true });

    });
    
 	// 마스터 행삭제 버튼 클릭 시
    $("#btn_bbs_del").click(function() {
    	var rowid = bbs_grid.getSelectRowIDs();
    	var flag = false;
    	
    	if(rowid.length > 0) {
    		
	    	$.each(rowid, function (index, item) {
	    		if(bbs_grid.getRowData(item).US_YN === 'Y') {
	    			flag = true;
	    		} 
	    	});
    	}
    	if (flag) {
	    	 alert("사용중인 코드가 있으므로 삭제할 수 없습니다.");
    	} else {
    		 bbs_grid.remove( );
    	}
    });
 	
 	// 마스터 엑셀다운로드 버튼 클릭 시
    $("#btn_bbs_excel").click(function() {
	    var grid_id = "bbs_grid";
	    var rows    = $('#bbs_grid').jqGrid('getGridParam', 'rowNum');
	    var page    = $('#bbs_grid').jqGrid('getGridParam', 'page');
	    var total   = $('#bbs_grid').jqGrid('getGridParam', 'total');
	    var title   = $('#bbs_grid').jqGrid('getGridParam', 'gridtitle');
	    var url     = "/psys/getPsys1005XlsxDwld1";  //페이징 존재
	    var param          = {};
	        param.page     = page;
	        param.rows     = rows;
	        param.filename = "코드마스터 목록";
	    AdvencedExcelDownload(grid_id, url, param);
    });
    
    $("#btn_bbs_add").click(function() {
    	// default 값 세팅
        bbs_grid.add({success:function(){bbs_grid.init();}});
        

    });
    

    // 
    $("#btn_bttn_menu_add").click(function() {
        // 현재 상위 그리드에서 선택된 값 확인

        // default 값 세팅
        bttn_menu_grid.add({bbsID:sels[0].bbsID});
    });
    
    $("#btn_bttn_menu_del").click(function() {
        bttn_menu_grid.remove();
    });
});

//grid resizing
$(window).resize(function() {
	bbs_grid.setGridWidth($('.tblType1').width());
	
});

//조회: 내부 로직 사용자 정의
function fn_Search(){
	bbs_grid.retreive(); //{success:function(){alert('retreive success');}}
    
 	// 코드id 수정못하도록 set false
    $("#bbs_grid").jqGrid('setColProp', 'BBSNO', { editable: false });
    
}

function fn_Save(){
	//jqgrid grid 데이터 json 형태로 생성
	var bbsData = getSaveData("bbs_grid"); //grid_id
    console.log(bbsData);
    if(isEmpty(bbsData)) {
    	return false;
    }
    
    //입력폼데이터 파라미터형태로 변경
    var formdata  = $("form[name=search]").serialize();
    var data ="bbsData="+bbsData+"&_pre_url="+parent.preUrl.getPreUrl() +"&" + formdata;
    console.log(data);
	ajax({
   		url: '/linkruit/saveBbs',
   		data : data ,
   		async : false,
   		success: function(data) {
   			if(data.RESULT == "S") {
   				alert('저장되었습니다');	
   				fn_Search();
   				return;
   			}else {
   				alert("일시적 오류입니다\n잠시후 다시 시도하세요.")
   				e.preventDefault();
   				return;
   			}
   		}
   	});
}

</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
		<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
			<!-- search -->
			<div class="frameTopTable">          
				<form id="search" name="search" onsubmit="return false">
		            <table class="tblType1 typeShort">   
		            	<colgroup>
							<col style="width: 117px;" />
							<col style="" />
							<col style="width: 117px;" />
							<col style="" />
						</colgroup>   
						<tbody>
							<tr>
								<th>제목</th>
								<td><span class="txt_pw"><input type="text" name="bbstitle" id="bbstitle" class="text" /></span></td>
								<th>내용</th>
								<td><span class="txt_pw"><input type="text" name="bbscontent" id="bbscontent" class="text" /></span></td>
							</tr>
						</tbody>
		            </table>
		       </form>
			</div>
			<div class="bgBorder"></div>
			<!-- search // -->
			<div class="grid_right_btn">
				<div class="grid_right_btn_in">
					<button id="btn_bbs_save" class="btn_common btn_default">저장</button>
					<button id="btn_bbs_add" class="btn_common btn_default">행추가</button>
					<button id="btn_bbs_del" class="btn_common btn_default">행삭제</button>
					<button id="btn_bbs_excel" class="btn_common btn_default">
                        <img src="<c:out value='${pageContext.request.contextPath}' />/resources/pandora3/images/common_new/img_download.png" alt="엑셀 다운로드" />
                    </button>
				</div>
			</div>
			<table id="bbs_grid"></table>
			<div class="bgBorder"></div>
			<div id="bbs_grid_pager"></div>
			<!-- Master Grid // -->
			

			<br />
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>
