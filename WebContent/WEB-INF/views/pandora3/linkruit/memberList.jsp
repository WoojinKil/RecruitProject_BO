<%-- 
   1. 파일명   : MemberList
   2. 파일설명 : 회원관리
   3. 작성일   : 2018-03-27
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>
<script type="text/javascript">
var member_grid;

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
        gridid    : 'member_grid',	    	// 그리드 id
        pagerid   : 'member_grid_pager',	// 그리드 페이지 id
        gridBtnYn : 'Y',						// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        // column info
        columns   : [
            {name : 'MEMBERID', label : '아이디', sortable:false, editable : true, hidden : true},
            {name : 'MEMBERID', label :'아이디' },
            {name : 'MEMBERNAME', label :'이름'},
           
            {name : 'MEMBERBIRTH', label : '생년월일', align : 'center', editable : true},
            {name : 'MEMBERPW', label : '비밀번호', sortable:false, editable : true},
            {name : 'MEMBERPWCONFIRM', label : '비밀번호확인', align : 'center', editable : true},
            {name : 'MEMBERROOT', label : '검색경로',   align : 'center', editable : true, edittype:'select', formatter:'select',
           	 editoptions:{maxlength:25, dataInit: fn_changeGridDate,
       		  value :   '회사 홈페이지 방문:회사 홈페이지 방문;'
       		  		   +'인터넷 검색:인터넷 검색;'
       		  		   +'구인 사이트:구인 사이트;'
       		  		   +'지인:지인;'
       		  		   +'기타:기타'
       	 
       	 
         } 
            
            },
            {name : 'MEMBERPHONENUMBER1', label : '휴대폰 번호-1',   align : 'center', editable : true},
            {name : 'MEMBERPHONENUMBER2', label : '휴대폰 번호-2',   align : 'center', editable : true},
            {name : 'MEMBERPHONENUMBER3', label : '휴대폰 번호-3',   align : 'center', editable : true},
            {name : 'MEMBERREGDATE', label : '가입일자',   align : 'center', editable : true},
            {name : 'MEMBERUPDATEDATE', label : '갱신일자',   align : 'center', editable : false}
        ],          
//      initval     : {US_YN : 'Y', SORT_ORD : 999, MST_CD : 'A00'}, // 컬럼 add 시 초기값
        editmode    : true,                                 // 그리드 editable 여부
        gridtitle   : '사원관리 목록',                        // 그리드명
        multiselect : true,                                 // checkbox 여부
        formid      : 'search',                             // 조회조건 form id
        height      : '300',                                // 그리드 높이
        shrinkToFit : true,                                 // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl   : '/linkruit/getMemberList',          // 그리드 조회 URL
        saveurl     : '/linkruit/saveMember',             // 그리드 입력/수정/삭제 URL
        events         : {

	                          onCellSelect: function(event, rowid, icol) {        // 해당 셀 선택시
	                              var row = member_grid.getRowData(rowid);
	                          
	                              // 표기형식을 나타내주고 입력할땐 셀을 비워준다.
	                              if (member_grid.getColName(icol) == 'MEMBERID') {
	                                 if(row.MEMBERID == "") { 
	                                	 member_grid.setCell(rowid, 'MEMBERID', '', '', {}, true); 
	                                 }
	                              }
	                              
	                              if(row.JQGRIDCRUD === "C") {
 	                            	  $("#member_grid").jqGrid('setColProp', 'MEMBERID', { editable: true });
	                              } else {
	                            	  $("#member_grid").jqGrid('setColProp', 'MEMBERID', { editable: false });
	                              }
	                              
	                          },
	                          onSelectRow: function (event, rowid, status, e) {
	                        	  var row = member_grid.getRowData(rowid);
	                        	  
	                          }
                          }
    };
    

    member_grid = new UxGrid(up_config);
    member_grid.init();

    member_grid.setGridWidth($('.tblType1').width());
    
    
    $("#cb_member_grid").css("display","none");
    
    // 마스터 저장 버튼 클릭 시 
    $("#btn_member_save").click(function() {
    	var rowid = member_grid.getSelectRowIDs();
        
        var row = member_grid.getRowData(rowid);
        var name = row.MEMBERNAME;

       
        if(name == ""){
        	alert("이름을 입력해주세요.");
        	return false;
        	
        	
        }else {
	        // 코드id 수정못하도록 set false
	       // member_grid.save( {success:function(){$("#member_grid").jqGrid('setColProp', 'MEMBERID', { editable: false });}});
	        
	        //console.log(data);
        	fn_Save();
        }
    });
    
    // 마스터 행추가 버튼 클릭 시
    $("#btn_member_add").click(function() {
    	// default 값 세팅
       
        $("#member_grid").jqGrid('setColProp', 'MEMBERID', { editable: true });

    });
    
 	// 마스터 행삭제 버튼 클릭 시
    $("#btn_member_del").click(function() {
    	var rowid = member_grid.getSelectRowIDs();
    	var flag = false;
    	
    	if(rowid.length > 0) {
    		
	    	$.each(rowid, function (index, item) {
	    		if(member_grid.getRowData(item).US_YN === 'Y') {
	    			flag = true;
	    		} 
	    	});
    	}
    	if (flag) {
	    	 alert("사용중인 코드가 있으므로 삭제할 수 없습니다.");
    	} else {
    		 member_grid.remove( );
    	}
    });
 	
 	// 마스터 엑셀다운로드 버튼 클릭 시
    $("#btn_member_excel").click(function() {
	    var grid_id = "member_grid";
	    var rows    = $('#member_grid').jqGrid('getGridParam', 'rowNum');
	    var page    = $('#member_grid').jqGrid('getGridParam', 'page');
	    var total   = $('#member_grid').jqGrid('getGridParam', 'total');
	    var title   = $('#member_grid').jqGrid('getGridParam', 'gridtitle');
	    var url     = "/psys/getPsys1005XlsxDwld1";  //페이징 존재
	    var param          = {};
	        param.page     = page;
	        param.rows     = rows;
	        param.filename = "코드마스터 목록";
	    AdvencedExcelDownload(grid_id, url, param);
    });
    


    // 
    $("#btn_bttn_menu_add").click(function() {
        // 현재 상위 그리드에서 선택된 값 확인

        // default 값 세팅
        bttn_menu_grid.add({MEMBERID:sels[0].MEMBERID});
    });
    
    $("#btn_bttn_menu_del").click(function() {
        bttn_menu_grid.remove();
    });
});

//grid resizing
$(window).resize(function() {
	member_grid.setGridWidth($('.tblType1').width());
	
});

//조회: 내부 로직 사용자 정의
function fn_Search(){
	member_grid.retreive(); //{success:function(){alert('retreive success');}}
    
 	// 코드id 수정못하도록 set false
    $("#member_grid").jqGrid('setColProp', 'MEMBERID', { editable: false });
    
}

function fn_Save(){
	//jqgrid grid 데이터 json 형태로 생성
	var memberData = getSaveData("member_grid"); //grid_id
    
    if(isEmpty(memberData)) {
    	return false;
    }
    
    //입력폼데이터 파라미터형태로 변경
    var formdata  = $("form[name=search]").serialize();
    var data ="memberData="+memberData+"&_pre_url="+parent.preUrl.getPreUrl() +"&" + formdata;
    console.log(data);
	ajax({
   		url: '/linkruit/saveMember',
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
								<th>아이디</th>
								<td><span class="txt_pw"><input type="text" name="memberid" id="memberid" class="text" /></span></td>
								<th>성명</th>
								<td><span class="txt_pw"><input type="text" name="membername" id="membername" class="text" /></span></td>
							</tr>
						</tbody>
		            </table>
		       </form>
			</div>
			<div class="bgBorder"></div>
			<!-- search // -->
			<div class="grid_right_btn">
				<div class="grid_right_btn_in">
					<button id="btn_member_save" class="btn_common btn_default">저장</button>
					<button id="btn_member_add" class="btn_common btn_default">행추가</button>
					<button id="btn_member_del" class="btn_common btn_default">행삭제</button>
					<button id="btn_member_excel" class="btn_common btn_default">
                        <img src="<c:out value='${pageContext.request.contextPath}' />/resources/pandora3/images/common_new/img_download.png" alt="엑셀 다운로드" />
                    </button>
				</div>
			</div>
			<table id="member_grid"></table>
			<div class="bgBorder"></div>
			<div id="member_grid_pager"></div>
			<!-- Master Grid // -->
			

			<br />
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>
