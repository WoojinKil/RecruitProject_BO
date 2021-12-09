<%-- 
   1. 파일명   : pbbs1019
   2. 파일설명 : 카테고리관리
   3. 작성일   : 2019-12-17
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>
<script type="text/javascript">
var code_master_grid;
var code_detail_grid;
var target_row = null;
var rowID;

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
        gridid    : 'code_master_grid',	    	// 그리드 id
        pagerid   : 'code_master_grid_pager',	// 그리드 페이지 id
        gridBtnYn : 'Y',						// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        // column info
        columns   :[
        	        {name:'STATUS', label:'상태', align:'center', editable:false, width:20},
        		    {name:'CTEGRY_MST_CD', label:'카테고리마스터코드', width:80, required:true, editable:false, editoptions:{
		                maxlength:12,
		                dataInit: function(element){
		                     $(element).keyup(function() {
		                         // 한글 입력 방지
		                         element.value = element.value.replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' );
		                     });
		                 }
		             }},
                     {name:'CTEGRY_MST_NM', label:'카테고리마스터코드명', editable:true, edittype:'text', width:200, required:true, editoptions:{maxlength:25, dataInit: fn_changeGridDate }},   // 저장 필수값은 required:true를 준다             
                     {name:'CTEGRY_MST_DESC', label:'카테고리마스터설명', editable:true, width:100 , editoptions:{maxlength:100, dataInit: fn_changeGridDate}},
                     {name:'US_YN', label:'사용여부', align:'center', editable:true, edittype:'select', formatter:'select', editoptions:{value:'Y:활성화;N:비활성화', dataInit:fn_changeGridDate}, width:60, required:true},
                     {name : 'SYS_CD', label : '시스템명', align : 'center', editable : true, edittype : 'select', formatter : 'select', editoptions : {value:'<c:out value="<%=CodeUtil.getSitGridComboList()%>" />'}, width : 100, required : true},
                     {name:'F_UPD_DTTM',label:'변경일자', align:'center', width:100}
                    ],          
        initval        : {US_YN:'N', CTEGRY_MST_CD:'A00'},    // 컬럼 add 시 초기값
        editmode       : true,                                 	    // 그리드 editable 여부
        gridtitle      : '카테고리 마스터코드 목록',                           	// 그리드명
        multiselect    : true,                                      // checkbox 여부
        //multiboxonly : true,                                      
        formid         : 'search',                                  // 조회조건 form id
        height         : 200,                                       // 그리드 높이
        //shrinkToFit  : true,                              	    // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl      : '/pbbs/getPbbs1019List1',  		    // 그리드 조회 URL
        saveurl        : '/pbbs/savePbbs10191',        		    // 그리드 입력/수정/삭제 URL
        events         : {
        					  ondblClickRow: function(event, rowid) {
	                              var row = code_master_grid.getRowData(rowid);
	                              if (isNotEmpty(row.CTEGRY_MST_CD)) {
	                              	 target_row = row;
	                             	 code_detail_grid.retreive({data:{ctegry_mst_cd:row.CTEGRY_MST_CD}});
	                             	 rowID = rowid;
	                              }
	                          },
	                          onCellSelect: function(event, rowid, icol) {        // 해당 셀 선택시
	                              var row = code_master_grid.getRowData(rowid);
	                          
	                              // 표기형식을 나타내주고 입력할땐 셀을 비워준다.
	                              if (code_master_grid.getColName(icol) == 'CTEGRY_MST_CD') {
	                                 if(row.CTEGRY_MST_CD == "A00") { 
	                                 	code_master_grid.setCell(rowid, 'CTEGRY_MST_CD', '', '', {}, true); 
	                                 }
	                              }
	                              
	                              if(row.JQGRIDCRUD === "C") {
 	                            	  $("#code_master_grid").jqGrid('setColProp', 'CTEGRY_MST_CD', { editable: true });
	                              } else {
	                            	  $("#code_master_grid").jqGrid('setColProp', 'CTEGRY_MST_CD', { editable: false });
	                              }
	                              
	                          },
	                          onSelectRow: function (event, rowid, status, e) {
	                        	  var row = code_master_grid.getRowData(rowid);
	                          }
                          }
    };
    
    var down_config = { 
            gridid    : 'code_detail_grid',	    	// 그리드 id
            pagerid   : 'code_detail_grid_pager',	// 그리드 페이지 id
            // column info
            columns   :[
            	         {name:'STATUS', label:'상태', align:'center', editable:false, width:20},
            			 {name:'CTEGRY_MST_CD',  hidden:true},
            		     {name:'CTEGRY_DTL_CD', label:'카테고리상세코드', align:'center', editable:false, edittype:'text', width:80}, 
                         {name:'CTEGRY_DTL_NM', label:'카테고리상세코드명', editable:true, edittype:'text', width:200, required:true, editoptions:{
                             maxlength:25, dataInit: fn_changeGridDate
                         }},   // 저장 필수값은 required:true를 준다             
                         {name:'SRT_SEQ', width:50,label:'정렬순서', editable:true},
                         {name:'US_YN', label:'사용여부', align:'center', editable:true, edittype:'select', formatter:'select', editoptions:{value:'Y:사용;N:미사용', dataInit: fn_changeGridDate}, width:60, required:true},
                         {name:'REF_VAL1', label:'참조값1', align:'center', editable:true, width:60, editoptions:{maxlength:50, dataInit: fn_changeGridDate}},
                         {name:'REF_VAL2', label:'참조값2', align:'center', editable:true, width:60, editoptions:{maxlength:50, dataInit: fn_changeGridDate}},
                         {name:'REF_VAL3', label:'참조값3', align:'center', editable:true, width:60, editoptions:{maxlength:50, dataInit: fn_changeGridDate}},
                         {name:'F_UPD_DTTM',label:'변경일자', align:'center', width:100}
                         // insert 시 초기값이 필요한 hidden columns
                         
                        ],
            editmode    : true,                               // 그리드 editable 여부
            gridtitle   : '카테고리 상세코드 목록',                        // 그리드명
            multiselect : true,                               // checkbox 여부
            height      : 200,                                // 그리드 높이
            shrinkToFit : true,                               // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
            selecturl   : '/pbbs/getPbbs1019List2',       // 그리드 조회 URL
            saveurl     : '/pbbs/savePbbs10192',          // 그리드 입력/수정/삭제 URL
        };
    
    code_master_grid = new UxGrid(up_config);
    code_master_grid.init();
    
    code_detail_grid = new UxGrid(down_config);
    code_detail_grid.init();
    
    code_master_grid.setGridWidth($('.tblType1').width());
    code_detail_grid.setGridWidth($('.tblType1').width());
    
    $("#cb_code_master_grid").css("display","none");
    
    // 마스터 저장 버튼 클릭 시 
    $("#btn_code_master_save").click(function() {
    	var rowid = code_master_grid.getSelectRowIDs();
        var row = code_master_grid.getRowData(rowid);
        
    	if(row.CTEGRY_MST_CD == "A00") { 
            alert("코드ID를 입력해주세요.");
            
        }else {
	        // 코드id 수정못하도록 set false
	       // code_master_grid.save( {success:function(){$("#code_master_grid").jqGrid('setColProp', 'MST_CD', { editable: false });}});
	        
	        //console.log(data);
        	fn_Save();
        }
    });
    
    // 마스터 행추가 버튼 클릭 시
    $("#btn_code_master_add").click(function() {
    	// default 값 세팅
        code_master_grid.add({success:function(){code_detail_grid.init();}});
        $("#code_master_grid").jqGrid('setColProp', 'CTEGRY_MST_CD', { editable: true });  

    });
    
 	// 마스터 행삭제 버튼 클릭 시
    $("#btn_code_master_del").click(function() {
    	var rowid = code_master_grid.getSelectRowIDs();
    	var flag = false;
    	
    	if(rowid.length > 0) {
    		
	    	$.each(rowid, function (index, item) {
	    		if(code_master_grid.getRowData(item).US_YN === 'Y') {
	    			flag = true;
	    		} 
	    	});
    	}
    	if (flag) {
	    	 alert("사용중인 코드가 있으므로 삭제할 수 없습니다.");
    	} else {
    		 code_master_grid.remove( {success:function(){code_detail_grid.init();}});
    	}
    });
 	
 	// 마스터 엑셀다운로드 버튼 클릭 시
    $("#btn_code_master_excel").click(function() {
	    var grid_id = "code_master_grid";
	    var rows    = $('#code_master_grid').jqGrid('getGridParam', 'rowNum');
	    var page    = $('#code_master_grid').jqGrid('getGridParam', 'page');
	    var total   = $('#code_master_grid').jqGrid('getGridParam', 'total');
	    var title   = $('#code_master_grid').jqGrid('getGridParam', 'gridtitle');
	    var url     = "/pbbs/getPbbs1019XlsxDwld1";  //페이징 존재
	    var param          = {};
	        param.page     = page;
	        param.rows     = rows;
	        param.filename = "코드마스터 목록";
	    AdvencedExcelDownload(grid_id, url, param);
    });
    
 	// 상세 저장 버튼 클릭 시
    $("#btn_code_detail_save").click(function() {
    	var rowid = code_detail_grid.getSelectRowIDs();
        var row = code_detail_grid.getRowData(rowid);
        
        code_detail_grid.save();
    });
    
 	// 상세 행추가 버튼 클릭 시
    $("#btn_code_detail_add").click(function() {
        // 현재 상위 그리드에서 선택된 값 확인
        var sels = code_master_grid.getSelectRows();
        
        if (target_row == null) {
        	alert('상위 메뉴를 선택하세요.');
            return;
        } else if($("#code_master_grid").jqGrid('getColProp', 'CTEGRY_MST_CD').editable){
        	alert('상위 메뉴 저장후 사용가능합니다.');
            return;       	
        }
        
        // default 값 세팅
        code_detail_grid.add({CTEGRY_MST_CD:target_row.CTEGRY_MST_CD});       
  
    });
    
 	// 상세 행삭제 버튼 클릭 시 
    $("#btn_code_detail_del").click(function() {
    	var rowid = code_detail_grid.getSelectRowIDs();
        var row = code_detail_grid.getRowData(rowid);
        if(row.US_YN == 'Y') { // 만약 사용중인 코드라면 삭제할 수 없다.
           alert("사용중인 코드 이므로 삭제할 수 없습니다.");
           return;
        }
        else {
           code_detail_grid.remove();
        }
    });
    
 	// 상세 엑셀다운로드 버튼 클릭 시 
    $("#btn_code_detail_excel").click(function() {
    	var grid_id = "code_detail_grid";
    	var rows    = $('#code_detail_grid').jqGrid('getGridParam', 'rowNum');
    	var page    = $('#code_detail_grid').jqGrid('getGridParam', 'page');
    	var total   = $('#code_detail_grid').jqGrid('getGridParam', 'total');
    	var title   = $('#code_detail_grid').jqGrid('getGridParam', 'gridtitle');
    	var url     = "/pbbs/getPbbs1019XlsxDwld2";  //페이징 존재
    	var row     = code_master_grid.getRowData(rowID);
    	var param          = {};
    	    param.page     = page;
    	    param.rows     = rows;
    	    param.filename = "코드상세 목록";
    	    param.ctegry_mst_cd   = row.CTEGRY_MST_CD;
    	AdvencedExcelDownload(grid_id, url, param);
    });
 	
    /* var bttn_menu_grid = new UxGrid(bttn_config);
    bttn_menu_grid.init();
    
    $("#btn_bttn_menu_save").click(function() {
        bttn_menu_grid.save();
    }); */
    
    // 
    $("#btn_bttn_menu_add").click(function() {
        // 현재 상위 그리드에서 선택된 값 확인
        var sels = code_detail_grid.getSelectRows();
        if (sels.length == 0) {
            alert('하위 메뉴를 선택하세요');
            return;
        }
        else if (sels.length > 1) {
            alert('하위 메뉴 하나만 선택하세요');
            return;
        }
        // default 값 세팅
        bttn_menu_grid.add({CTEGRY_MST_CD:sels[0].MST_CD});
    });
    
    $("#btn_bttn_menu_del").click(function() {
        bttn_menu_grid.remove();
    });
});

//grid resizing
$(window).resize(function() {
	code_master_grid.setGridWidth($('.tblType1').width());
	code_detail_grid.setGridWidth($('.tblType1').width());
});

//조회: 내부 로직 사용자 정의
function fn_Search(){
	code_master_grid.retreive(); //{success:function(){alert('retreive success');}}
    code_detail_grid.clearGridData();
 	// 코드id 수정못하도록 set false
    $("#code_master_grid").jqGrid('setColProp', 'CTEGRY_MST_CD', { editable: false });
    $("#code_detail_grid").jqGrid('setColProp', 'CD'    , { editable: false });     
}

function fn_Save(){
	//jqgrid grid 데이터 json 형태로 생성
	var masterdata = getSaveData("code_master_grid"); //grid_id
    var dtldata  = getSaveData("code_detail_grid"); //grid_id
    //입력폼데이터 파라미터형태로 변경
    var formdata  = $("form[name=search]").serialize();
    var data ="masterdata="+masterdata+"&dtldata="+dtldata+"&_pre_url="+parent.preUrl.getPreUrl() +"&" + formdata; 
	ajax({
   		url: '/pbbs/savePbbs1019',
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
								<th>코드 ID</th>
								<td><span class="txt_pw"><input type="text" name="ctegry_mst_cd" id="ctegry_mst_cd" class="text" /></span></td>
								<th>마스터코드명</th>
								<td><span class="txt_pw"><input type="text" name="ctegry_mst_nm" id="ctegry_mst_nm" class="text" /></span></td>
							</tr>
						</tbody>
		            </table>
		       </form>
			</div>
			<div class="bgBorder"></div>
			<!-- search // -->
			<div class="grid_right_btn">
				<div class="grid_right_btn_in">
					<button id="btn_code_master_save" class="btn_common btn_default">저장</button>
					<button id="btn_code_master_add" class="btn_common btn_default">행추가</button>
					<button id="btn_code_master_del" class="btn_common btn_default">행삭제</button>
					<button id="btn_code_master_excel" class="btn_common btn_default">
					<img src="<c:out value='${pageContext.request.contextPath}' />/resources/pandora3/images/common_new/img_download.png" alt="엑셀 다운로드" />
					</button>
				</div>
			</div>
			<!-- Master Grid -->
			<!-- <div class="tableBtnWrap gridBtn">
				<div class="tableBtn">
					<button id="btn_code_master_save" class="btn_common btn_default">저장</button>
					<button id="btn_code_master_add" class="btn_common btn_default">행추가</button>
					<button id="btn_code_master_del" class="btn_common btn_default">행삭제</button>
					<button id="btn_code_master_excel" class="btn_common btn_default">엑셀다운로드</button>
				</div>
			</div> -->
			<table id="code_master_grid"></table>
			<div class="bgBorder"></div>
			<div id="code_master_grid_pager"></div>
			<!-- Master Grid // -->
			
			<!-- Detail Grid -->
			<div class="grid_right_btn">
				<div class="grid_right_btn_in">
					<button id="btn_code_detail_save" class="btn_common btn_default">저장</button>
					<button id="btn_code_detail_add" class="btn_common btn_default">행추가</button>
					<button id="btn_code_detail_del" class="btn_common btn_default">행삭제</button>
					<button id="btn_code_detail_excel" class="btn_common btn_default">
					<img src="<c:out value='${pageContext.request.contextPath}' />/resources/pandora3/images/common_new/img_download.png" alt="엑셀 다운로드" />
					</button>
				</div>
			</div>
		<!--<div class="tableBtnWrap gridBtn">
				<div class="tableBtn">
					<button id="btn_code_detail_save" class="btn_common btn_default">저장</button>
					<button id="btn_code_detail_add" class="btn_common btn_default">행추가</button>
					<button id="btn_code_detail_del" class="btn_common btn_default">행삭제</button>
					<button id="btn_code_detail_excel" class="btn_common btn_default">엑셀다운로드</button>
				</div>
			</div> -->
			<table id="code_detail_grid"></table>
			<div id="code_detail_grid_pager"></div>
			<!-- Detail Grid // -->
			<br />
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>
