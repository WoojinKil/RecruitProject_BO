<%-- 
   1. 파일명   : psys1001sp
   2. 파일설명 : 권한별 사용자관리
   3. 작성일   : 2018-03-28
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var role_grid;
var menu_grid;
var bttn_grid;
var beforeRowId = "";
$(document).ready(function() {
    var role_config = { 
        gridid    : 'role_grid',	    // 그리드 id
        pagerid   : 'role_grid_pager',	// 그리드 페이지 id
        gridBtnYn : 'Y',				// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        // column info
        columns:[{name:'ROL_ID', label:'권한ID',editable:true, align:'center',  sorttype:'int', width:60,editoptions:{
        	dataInit:function(element){
                $(element).keyup(function() {
                    // 한글 입력 방지
                    element.value = element.value.replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' );
                });
            }
        }},
                 {name:'ROL_NM', label:'권한명', editable:true, edittype:'text', width:200, required:true},
                 {name:'US_YN', label:'사용여부', align:'center', editable:true, edittype:'select', formatter:'select', editoptions:{value:'Y:사용;N:미사용'}, width:80, required:true},
                 {name:'F_APL_ST_DT', label:'적용시작일자', align:'center', editable:true, width:120, required:true,formatoptions: {srcformat: 'U',newformat:'Y-m-d'} },
                 {name:'F_APL_ED_DT', label:'적용종료일자', align:'center', editable:true, width:120, required:true, formatoptions: {srcformat: 'U',newformat:'Y-m-d'} },
                 {name:'UPD_DTTM',label:'변경일자', align:'center', width:100, formatter:'date', formatoptions: {srcformat: 'U',newformat:'Y-m-d'}}
        ],
        initval:  {US_YN:'Y', APL_ED_DT:'9999-12-31'}, // 컬럼 add 시 초기값
        editmode: false,                   	// 그리드 editable 여부
        gridtitle: '권한 목록',      			// 그리드명
        multiselect: false,             	// checkbox 여부
        formid: 'search',                	// 조회조건 form id
        height: 'auto',                    	// 그리드 높이
        selecturl: '/psys/getPsys1006List',   // 그리드 조회 URL
        saveurl: '/psys/savePsys1006List',    // 그리드 입력/수정/삭제 URL
        events: {    
            ondblClickRow: function (event, rowid, irow, icol) {
                var row = role_grid.getRowData(rowid);
                if (isNotEmpty(row.ROL_ID)) {
                     menu_grid.retreive({data:{rol_id:row.ROL_ID}});
                }
            }
        }
    };    
    
    var menu_config = { 
            // grid id
            gridid: 'menu_grid',
            pagerid: 'menu_grid_pager',
            // column info
            columns:[{name:'ROL_ID', label:'권한ID', align:'center',  sorttype:'int', width:60, required:true, sortable:false},           
            		 {name:'USR_ID', label:'사용자ID', hidden:true, required:true, sortable:false},
            		 {name:'APL_ST_DT', label:'적용시작일자',  hidden:true, required:true},
            		 {name:'APL_ED_DT', label:'적용종료일자', hidden:true, required:true},
                     {name:'LGN_ID', label:'로그인ID',  sorttype:'int', width:100, sortable:false},
                     {name:'USR_NM', label:'사용자명', width:100, sortable:false, editable:false, editoptions:{
                    	 dataEvents:[
                    		 {type:'keyup', fn:function(e){// keyup Event
                    			 
                    			 // 사용자명이 변경됐을 때 jqgird 해당 row 초기화
                    			 changeCharEvent(e, function(){
                    				 var selectedRowId = $("#menu_grid").jqGrid ('getGridParam', 'selrow');
                    				 
                    				 $("#menu_grid").jqGrid('setRowData', selectedRowId, { ROL_ID:'',
						                  APL_ST_DT:'',
						                  APL_ED_DT:'',
						                  USR_ID:'',
						                  LGN_ID:'',
						                  USR_EML_ADDR:'',
						                });
                    				 return;
                    			 });
                    		 }},
                    		 {type:'keydown', fn:function(e){// keydown Event
                    		 		
                    			 	// enter or tab keydown event발생 시, data가 1개면 grid에 load되고, 그외는 팝업 호출
                    		 		enterOrTabKeyEvent(e, function(){
                    		 			
                    		 			var selectedRowId = $('#menu_grid').jqGrid ('getGridParam', 'selrow');
                    		 			$('#menu_grid').jqGrid ('editCell', selectedRowId, 0, false);
                    		 			var usrNm = $("#menu_grid").jqGrid('getCell', selectedRowId, 'USR_NM');
                    		 			
                    		 			if(false) {
                    		 				
                    		 			} else {
                    		 				ajax({
                        		 				url: '/psys/getPsys1001spList.adm',
                        		 				data : {"usrNm" : usrNm},
                        		 				success: function(data) {
                       		 						var sels = role_grid.getSelectRows();
                       		 						
                       		 						if(data.rows.length == 1) { // data가 1개면 grid에 로드
                       		 							if(isDuplicateGridData(menu_grid, {"key" : "USR_ID", "value" : data.rows[0].USR_ID})) {
                       		 								alert("중복 데이터입니다.");
                       		 								return;
                       		 							}
                       		 							
                       		 							$('#menu_grid').jqGrid('setRowData', selectedRowId, { ROL_ID:sels[0].ROL_ID,
                       		 			                  APL_ST_DT:sels[0].APL_ST_DT,
                       		 			                  APL_ED_DT:sels[0].APL_ED_DT,
                       		 			                  USR_ID:data.rows[0].USR_ID,
                       		 			                  LGN_ID:data.rows[0].LGN_ID,
                       		 			                  USR_NM:data.rows[0].USR_NM,
                       		 			                  USR_EML_ADDR:data.rows[0].USR_EML_ADDR
                       		 			                });
                       		 						} else { 
                       		 							// 사용자 검색 팝업 호출
                       		 							userGridComnPopup(usrNm, selectedRowId);
                       		 						}
                        		 				}
                        		 			});
                    		 			}
                    		 		});
                     		 }}] 
                     }},
                     {name:'USR_NM_SEARCH',width:25, formatter:formatEvent, sortable:false},
                     {name:'USR_EML_ADDR', label:'이메일', width:150, sortable:false},               
                    {name:'F_CRT_DTTM',label:'등록일자', align:'center', width:100, sortable:false},
                    {name:'F_UPD_DTTM',label:'변경일자', align:'center', width:100, sortable:false}
            ],
            initval: {}, 					// 컬럼 add 시 초기값
            editmode: true,                 // 그리드 editable 여부
            gridtitle: '사용자권한 목록',      	// 그리드명
            multiselect: true,              // checkbox 여부
            height: 'auto',                    // 그리드 높이
            shrinkToFit: true,              // true인경우 column의 width 자동조정, false인경우 정해진 width데로 구현(가로스크롤바필요시 false)
            selecturl: '/psys/getPsys1008List',   // 그리드 조회 URL
            saveurl: '/psys/savePsys1008List',     // 그리드 입력/수정/삭제 URL
            events: {    
                onSelectRow: function(event, rowid) { 
                    var row = menu_grid.getRowData(rowid);
                    if (isNotEmpty(row.MNU_SEQ) && isNotEmpty(row.ROL_ID)) {
                         bttn_grid.retreive({data:{role_id:row.ROL_ID, menu_id:row.MNU_SEQ}});
                    }
                },
                onCellSelect: function(obj, rowid, icol) {
                	// 추가된 row만 edit 가능하게 셋팅
                	var row = $('#menu_grid').getRowData(rowid);
                	
                	// editable 제어
                	if(row.JQGRIDCRUD == "C") {
                		$('#menu_grid').setColProp ('USR_NM', {editable:true});
                		
                		// 다른 row 이동 시, formatter button hide 처리
                    	if (beforeRowId != rowid) {
                    		$("#searchBtn_" + beforeRowId).hide();
                    		beforeRowId = rowid;
                    	}
                    	
                    	// cell 이동에 따른 formatter button show/hide처리
                    	var cols = $('#menu_grid').jqGrid('getGridParam', 'colModel');
                    	
                    	if (cols[icol].name == "USR_NM") {
                    		$("#searchBtn_" + rowid).show();
                    	} else {
                    		$("#searchBtn_" + rowid).hide();
                    	}
                	}else {
                		$('#menu_grid').setColProp ('USR_NM', {editable:false});
                	}
                }
            }
        };
    role_grid = new UxGrid(role_config);
    role_grid.init();
    menu_grid = new UxGrid(menu_config);
    menu_grid.init();
    
    role_grid.setGridWidth($('.tblType1').width());
    menu_grid.setGridWidth($('.tblType1').width());
    
    //var newWidth = $("#menu_grid_user_nm").width() + $("#menu_grid_user_nm_search").outerWidth(true);
    /* jQuery("#menu_grid").jqGrid("setLabel", "USR_NM", "<em>사용자명</em>", "", {style: "border-right:0 none;padding-left: 45px;box-sizing: border-box;"}); */
    jQuery("#menu_grid").jqGrid("setLabel", "USR_NM", "<em>사용자명</em>", "", {style: "width: auto;", colspan: "2"});
    jQuery("#menu_grid").jqGrid("setLabel", "USR_NM_SEARCH", "", "", {style: "display: none"});
    
    $("#btn_menu_save").click(function() {
        menu_grid.save();  // {success:function(){alert('save success');}}
    });
    
    $("#btn_menu_add").click(function() {
        var sels = role_grid.getSelectRows();
        if (sels.length == 0) {
            alert('권한을 선택하세요');
            return;z
        }
        else if (sels.length > 1) {
            alert('권한을 하나만 선택하세요');
            return;
        }
        
        menu_grid.add();
    });
    
    $("#btn_menu_del").click(function() {
        menu_grid.remove(); // {success:function(){alert('remove success');}}
    });
    
    // input 공통 팝업 호출 시, enter key or tab key 이벤트 함수 호출
    var target = "rol_nm";
    inputEnterOrTabKeyEvent(target, function(){
    	var searchVal = $("#" + target).val();
    	
    	userInputComnPopup(searchVal, target);
    });
    
});

$(window).resize(function() {
	role_grid.setGridWidth($('.tblType1').width());
	menu_grid.setGridWidth($('.tblType1').width());
	jQuery("#menu_grid").jqGrid("setLabel", "USR_NM", "<em>사용자명</em>", "", {style: "width: auto;"});
});

//조회: 내부 로직 사용자 정의
function fn_Search() {
	role_grid.retreive(); //{success:function(){alert('retreive success');}}
    menu_grid.clearGridData();
}

// jqgrid 내 버튼 생성 이벤트
function formatEvent(cellvalue, options, rowObject){ 
  	/* return "<button id='searchBtn_"+options.rowId+"' onclick='customSearch(" + options.rowId + ")' class='btn_common btn_default' style='float:right;display: none;'>검색</button>"; */﻿﻿﻿﻿﻿
  	return "<button id='searchBtn_"+options.rowId+"' onclick='customSearch(" + options.rowId + ")' class='btn_common btn_default btn_user_search'><img src='"+_context+"/resources/pandora3/images/common/img-table-search.png' alt='검색 버튼' class='searchBtn2'/>검색</button>";﻿﻿﻿﻿
}

// formatter 버튼 이벤트
function customSearch(rowId) {
	// grid edit 모드 종료 후 getter
	menu_grid.editcomplete();
	var usrNm = $("#menu_grid").jqGrid('getCell', rowId, 'USR_NM');
	
	userGridComnPopup(usrNm, rowId);
}

//input 검색 button
function inputSearch() {
	var target = "rol_nm";
	var searchVal = $("#"+target).val();
	
	userInputComnPopup(searchVal, target);
}

// 사용자 정의 공통 팝업 콜백 함수
function callbackGridFunc(rows, callbackParamVal) {
	var sels   = role_grid.getSelectRows();
	var usrId = rows[0].USR_ID;
	var rowId  = callbackParamVal;
	
	if(isDuplicateGridData(menu_grid, {"key":"USR_ID", "value":usrId})){
		alert("이미 등록된 사용자명입니다.");
		return false;
	}
	
	$('#menu_grid').jqGrid('setRowData', rowId, { ROL_ID:sels[0].ROL_ID,
								                  APL_ST_DT:sels[0].APL_ST_DT,
								                  APL_ED_DT:sels[0].APL_ED_DT,
								                  USR_ID:usrId,
								                  LGN_ID:rows[0].LGN_ID,
								                  USR_NM:rows[0].USR_NM,
								                  USR_EML_ADDR:rows[0].USR_EML_ADDR,
								                });
}

// grid 사용자 정의 검색 공통팝업 호출
function userGridComnPopup (usrNm, rowId) {
    
	// 공통 팝업 코드
	var params = {
   	  	"popup_id" : "SYS1003"
   	  	 , "callType"        : "grid"                                    // type 종류 : grid, input(필수)			
	     , "searchValue"     : usrNm                                    // 검색한 값
	     , "callbackFunc"    :"callbackGridFunc"                         // 사용자 정의 콜백함수 - 파라미터는 고정값 (필수)	
		 , "callbackParamVal": rowId                                     // type이 grid이면 부모 grid의 rowId값 (필수)
	     , "popupType"       : "A"                                       // A - window open popup , B - layer popup
	     , "popupMenuId"     : _menu_id                                  // layer popup의 자식  iframe값을 알기 위한 값
    };
	
	comPopup(params);	
}

// input 사용자 정의 검색 공통팝업 호출
function userInputComnPopup (searchVal, target) {
    
	// 공통 팝업 코드
	var params = {
   	  	"popup_id" : "SYS1007"
   	  	 , "callType"        : "input"                                     // type 종류 : grid, input (필수)			
  	     , "searchValue"     : searchVal                                   // 검색한 값
  	     , "callbackFunc"    : "callbackInputFunc"                         // 사용자 정의 콜백함수 - 파라미터는 고정값 (필수)
  		 , "callbackParamVal": target                                      // type이 input이면 타겟 id값 (필수)
  		 , "popupType"       : "B"                                         // A - window open popup , B - layer popup
  	     , "popupMenuId"     : _menu_id                                    // layer popup의 자식  iframe값을 알기 위한 값
    };
	
	comPopup(params);
}

function callbackInputFunc(rows, callbackParamVal) {
	var target = callbackParamVal;
	var email  = rows[0].ROL_NM;
	
	$("#" + target).val(email);
}

</script>
</head>
<body id="app">
	<div class="frameWrap">
	    <div class="subCon">
		<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
			<div class="frameTopTable">          
				<form name="search" id="search" name="search" onsubmit="return false">
		            <table class="tblType1">   
		            	<colgroup>
							<col style="width: 117px;" />
							<col style="" />
							<col style="width: 117px;" />
							<col style="" />
						</colgroup>   
						<tbody>
				            <tr>
				                <th>권한명</th>
				                <td>
				                    <span class="txt_pw typeBtn" style="float:left;">
				                    	<input type="text" name="rol_nm" id="rol_nm" class="text" value="" maxlength="12" maxbyte="300"/>
				                    	<button type="button" onclick="inputSearch()" class="btn_common btn_default" style="float:left;"><img src="${pageContext.request.contextPath}/resources/pandora3/images/common/img-table-search.png" alt="검색 버튼" class="searchBtn2" /></button>
			                       	</span>	                       	
				                </td>                
				                <th>사용여부</th>
				                <td>
				                 <span class="txt_pw">
				                   <select name="us_yn" id="us_yn" class="select">
				                       <option value="">전체</options>
				                       <option value="Y">사용</option>
				                       <option value="N">미사용</option>
				                   </select>
				                 </span>
				                </td>
				            </tr>
						</tbody>
		            </table>
		       </form>
			</div>  
	        <!-- search // -->
			<div class="bgBorder"></div>
	        <!-- Grid -->
	        <table id="role_grid"></table> 
	        <div id="role_grid_pager"></div>
			<div class="bgBorder"></div>
	        
	        <!-- 사용자 지정 버튼 -->
			<div class="grid_right_btn">
				<div class="grid_right_btn_in">
				   <button class="btn_common btn_default" id="btn_menu_save">저장</button>
		           <button class="btn_common btn_default" id="btn_menu_add">추가</button>
		           <button class="btn_common btn_default" id="btn_menu_del">삭제</button>
				</div>
			</div>
			<!-- 사용자 지정 버튼 // -->
	        <!-- <div class="tableBtnWrap gridBtn">
				<div class="tableBtn">
				   <button class="btn_common btn_default" id="btn_menu_save">저장</button>
		           <button class="btn_common btn_default" id="btn_menu_add">추가</button>
		           <button class="btn_common btn_default" id="btn_menu_del">삭제</button>
				</div>
			</div> -->
	        <table id="menu_grid"></table> 
	        <div id="menu_grid_pager"></div>
	        <br/>
	    </div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
