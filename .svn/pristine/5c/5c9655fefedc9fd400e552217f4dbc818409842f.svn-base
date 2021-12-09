
<%-- 
   1. 파일명   : psys1005
   2. 파일설명 : 코드관리
   3. 작성일   : 2018-03-27
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>
<script type="text/javascript">
var code_master_grid;
var code_detail_grid;
var target_row ="";
$(document).ready(function(){
    var up_config = { 
        gridid    : 'code_master_grid',	    	// 그리드 id
        pagerid   : 'code_master_grid_pager',	// 그리드 페이지 id
        gridBtnYn : 'Y',						// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        // column info
        columns   :[
        		    {name:'STATUS', label:'상태', align:'center', editable:false, width:20},
        		    {name:'MST_CD', label:'코드 ID', width:80, required:true, editable:false, editoptions:{
		                maxlength:12,
		                dataInit: function(element){
		                     $(element).keyup(function() {
		                         // 한글 입력 방지
		                         element.value = element.value.replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' );
		                     });
		                 }
		             }},
                     {name:'MST_CD_NM', label:'마스터코드명', editable:true, edittype:'text', width:200, required:true, editoptions:{maxlength:25, }},   // 저장 필수값은 required:true를 준다             
                     {name:'US_YN', label:'활성화여부', align:'center', editable:true, edittype:'select', formatter:'select', editoptions:{value:'Y:활성화;N:비활성화'}, width:60, required:true},
                     {name:'MST_CD_DESC', label:'비고', editable:true, width:100 , editoptions:{maxlength:100}},
                     {name:'F_UPD_DTTM',label:'변경일자', align:'center', width:100}
                    ],          
        initval        : {US_YN:'Y', SRT_SEQ:999, MST_CD:'A00'},    // 컬럼 add 시 초기값
        editmode       : true,                                 	    // 그리드 editable 여부
        gridtitle      : '코드마스터 목록',                           	// 그리드명
        multiselect    : true,                             		    // checkbox 여부
        //multiboxonly : true,                                      
        formid         : 'search',                                  // 조회조건 form id
        height         : 200,                                       // 그리드 높이
        //shrinkToFit  : true,                              	    // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl      : '/psys/getPsys1005List1',  		    // 그리드 조회 URL
        saveurl        : '/psys/savePsys10051',        		    // 그리드 입력/수정/삭제 URL
        events         : {
	                          ondblClickRow : function (event, rowid, irow, icol) {
	                        	  var row = code_master_grid.getRowData(rowid);
	                        	  target_row = row;
	                        	  if (isNotEmpty(row.MST_CD)) {
		                             	 code_detail_grid.retreive({data:{mst_cd:row.MST_CD}});
	                              }
	                          },
	                          onCellSelect: function(event, rowid, icol) {        // 해당 셀 선택시
	                              var row = code_master_grid.getRowData(rowid);
	                              code_detail_grid.clearGridData();
	                              target_row = "";	
	                              // 표기형식을 나타내주고 입력할땐 셀을 비워준다.
	                              if (code_master_grid.getColName(icol) == 'MST_CD') {
	                                 if(row.MST_CD == "A00") { 
	                                 	code_master_grid.setCell(rowid, 'MST_CD', '', '', {}, true); 
	                                 }
	                              }
	                          }
                          }
    };
    
    var down_config = { 
            gridid    : 'code_detail_grid',	    	// 그리드 id
            pagerid   : 'code_detail_grid_pager',	// 그리드 페이지 id
            // column info
            columns   :[
            		     {name:'STATUS', label:'상태', align:'center', editable:false, width:20},
            		     {name:'CD', label:'코드 ID', align:'center', editable:false, edittype:'text', width:80}, 
                         {name:'CD_NM', label:'상세코드명', editable:true, edittype:'text', width:200, required:true, editoptions:{
                             maxlength:25,
                         }},   // 저장 필수값은 required:true를 준다             
                         {name:'US_YN', label:'사용여부', align:'center', editable:true, edittype:'select', formatter:'select', editoptions:{value:'Y:사용;N:미사용'}, width:60, required:true},
                         {name:'REF_1', label:'보조1', align:'center', editable:true, width:60, editoptions:{maxlength:50}},
                         {name:'REF_2', label:'보조2', align:'center', editable:true, width:60, editoptions:{maxlength:50}},
                         {name:'REF_3', label:'보조3', align:'center', editable:true, width:60, editoptions:{maxlength:50}},
                         {name:'CD_DESC', label:'비고', editable:true, width:100, editoptions:{
                             maxlength:100
                         }},
                         {name:'F_UPD_DTTM',label:'변경일자', align:'center', width:100},
                         // insert 시 초기값이 필요한 hidden columns
                         {name:'MST_CD',  hidden:true}
                        ],
            editmode    : true,                               // 그리드 editable 여부
            gridtitle   : '코드상세 목록',                        // 그리드명
            multiselect : true,                               // checkbox 여부
            height      : 200,                                // 그리드 높이
            shrinkToFit : true,                               // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
            selecturl   : '/psys/getPsys1005List2',       // 그리드 조회 URL
            saveurl     : '/psys/savePsys10052',          // 그리드 입력/수정/삭제 URL
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
        
    	if(row.MST_CD == "A00") { 
            alert("코드ID를 입력해주세요.");
            
        }else {
	        // 코드id 수정못하도록 set false
	        code_master_grid.save({
	        	success : function(){
					$("#code_master_grid").jqGrid('setColProp', 'MST_CD', { editable: false });
					target_row = ""; 
			}});  
        }
    });
    
    // 마스터 행추가 버튼 클릭 시
    $("#btn_code_master_add").click(function() {
    	// default 값 세팅
    	
        code_master_grid.add({success:function(){code_detail_grid.init();}});
    	
    	
    	var rowid = code_master_grid.getSelectRowIDs();
    	console.log(rowid[0]);
    	console.log(code_master_grid.getRowData(rowid[0]));
    	
    	code_master_grid.setCell(rowid[0], 'MST_CD', '', '', {}, true); 
       // $("#code_master_grid").jqGrid('editCell', rowid[0],'MST_CD', true);  

    });
    
 	// 마스터 행삭제 버튼 클릭 시
    $("#btn_code_master_del").click(function() {
    	var rowid = code_master_grid.getSelectRowIDs();
    	var row = code_master_grid.getRowData(rowid);
    	if(row.US_YN == 'N') { // 만약 사용중인 코드라면 삭제할 수 없다.
    	  alert("사용중인 코드 이므로 삭제할 수 없습니다.")
    	  return;
    	}
    	else {
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
	    var url     = "/psys/getPsys1005XlsxDwld1";  //페이징 존재
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
        var status = target_row.JQGRIDCRUD;
        console.log(status);
        if (status == undefined) {
        	alert("상위 메뉴를 선택해주세요.");
        	return false;
    	} else if (status !== "") {
        	alert('상위 메뉴 저장후 사용가능합니다.');
            return false;
        } else if ( target_row ==="") {
        	alert("상위 메뉴를 선택해주세요.");
        	return false;
        }
        
        
        // default 값 세팅
        code_detail_grid.add({MST_CD:target_row.MST_CD});       
  
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
    
 	// 상세 엑셀다운로드 버튼 클륵 시 
    $("#btn_code_detail_excel").click(function() {
    	var grid_id = "code_detail_grid";
    	var rows    = $('#code_detail_grid').jqGrid('getGridParam', 'rowNum');
    	var page    = $('#code_detail_grid').jqGrid('getGridParam', 'page');
    	var total   = $('#code_detail_grid').jqGrid('getGridParam', 'total');
    	var title   = $('#code_detail_grid').jqGrid('getGridParam', 'gridtitle');
    	var url     = "/psys/getPsys1005XlsxDwld2";  //페이징 존재
    	var rowid   = code_master_grid.getSelectRowIDs();
    	var row     = code_master_grid.getRowData(rowid);
    	var param          = {};
    	    param.page     = page;
    	    param.rows     = rows;
    	    param.filename = "코드상세 목록";
    	    param.mst_cd   = row.MST_CD;
    	AdvencedExcelDownload(grid_id, url, param);
    });
 	
    /* var bttn_menu_grid = new UxGrid(bttn_config);
    bttn_menu_grid.init();
    
    $("#btn_bttn_menu_save").click(function() {
        bttn_menu_grid.save();
    }); */
    
    // 
    $("#btn_bttn_menu_add").click(function() {
        //현재 상위 그리드에서 선택된 값 확인
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
        bttn_menu_grid.add({MST_CD:sels[0].MST_CD});
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
	
	target_row = "";
	
	code_master_grid.retreive(); //{success:function(){alert('retreive success');}}
    code_detail_grid.clearGridData();
 	// 코드id 수정못하도록 set false
    $("#code_master_grid").jqGrid('setColProp', 'MST_CD', { editable: false });
    $("#code_detail_grid").jqGrid('setColProp', 'CD'    , { editable: false });     
}

</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
		<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>	
			<!-- search -->
			<form id="search" name="search" onsubmit="return false">
				<table class="tblType1 mB60">
					<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>
					<tr>
						<th>코드 ID</th>
						<td><span class="txt_pw"><input type="text" name="mst_cd" id="mst_cd" class="text" /></span></td>
						<th>마스터코드명</th>
						<td><span class="txt_pw"><input type="text" name="mst_cd_nm" id="mst_cd_nm"
							class="text" /></span></td>
					</tr>
				</table>
			</form>
			<br/>
			<!-- search // -->
			<!-- Master Grid -->
			<div class="tableBtnWrap gridBtn">
				<div class="tableBtn">
					<button id="btn_code_master_save" class="btn_common btn_default">저장</button>
					<button id="btn_code_master_add" class="btn_common btn_default">행추가</button>
					<button id="btn_code_master_del" class="btn_common btn_default">행삭제</button>
					<button id="btn_code_master_excel" class="btn_common btn_default">엑셀다운로드</button>
				</div>
			</div>
			<table id="code_master_grid"></table>
			<div id="code_master_grid_pager"></div>
			<!-- Master Grid // -->
			<div class="mB60"></div>
			
			<!-- Detail Grid -->
			<div class="tableBtnWrap gridBtn">
				<div class="tableBtn">
					<button id="btn_code_detail_save" class="btn_common btn_default">저장</button>
					<button id="btn_code_detail_add" class="btn_common btn_default">행추가</button>
					<button id="btn_code_detail_del" class="btn_common btn_default">행삭제</button>
					<button id="btn_code_detail_excel" class="btn_common btn_default">엑셀다운로드</button>
				</div>
			</div>
			<table id="code_detail_grid"></table>
			<div id="code_detail_grid_pager"></div>
			<!-- Detail Grid // -->
			<br />
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>
