<%-- 
   1. 파일명   : applicantList
   2. 파일설명 : 지원자관리
   3. 작성일   : 2018-03-27
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>
<script type="text/javascript">
var recruit_notice_grid;
var applicant_grid;
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
        gridid    : 'recruit_notice_grid',	    	// 그리드 id
        pagerid   : 'recruit_notice_grid_pager',	// 그리드 페이지 id
        gridBtnYn : 'Y',						// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        // column info
        columns   :[
        		    
        		    {name:'RECRUITNO', label: '공고번호', width:80, required:true, editable:false, editoptions:{
		                maxlength:12,
		                dataInit: function(element){
		                     $(element).keyup(function() {
		                         // 한글 입력 방지
		                         element.value = element.value.replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' );
		                     });
		                 }
		             }},
                     {name:'RECRUITNAME', label:'공고 이름', editable:true, edittype:'text', width:200, required:true, editoptions:{maxlength:25, dataInit: fn_changeGridDate }},   // 저장 필수값은 required:true를 준다             
                     {name:'TYPENO', label:'채용 형태', align:'center', editable:true, edittype:'select', formatter:'select', editoptions:{value:'T1:공채; T2:수시', dataInit:fn_changeGridDate}, width:60, required:true},
                     {name:'RECRUITSCALE', label:'채용규모', editable:true, width:100 , editoptions:{maxlength:100, dataInit: fn_changeGridDate}},
                     {name:'RECRUITENDDATETIME',label:'채용마감시간', align:'center', width:100}
                    ],          
        initval        : {typeNo:'T1', SRT_SEQ:999, recruitNo:'A00'},    // 컬럼 add 시 초기값
        editmode       : true,                                 	    // 그리드 editable 여부
        gridtitle      : '지원공고 목록',                           	// 그리드명
        multiselect    : true,                             		    // checkbox 여부
        //multiboxonly : true,                                      
        formid         : 'search',                                  // 조회조건 form id
        height         : 200,                                       // 그리드 높이
        //shrinkToFit  : true,                              	    // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl      : '/linkruit/getRecruitNoticeList',  		    // 그리드 조회 URL
        saveurl        : '/psys/savePsys10051',        		    // 그리드 입력/수정/삭제 URL
        events         : {
        					  ondblClickRow: function(event, rowid) {
	                              var row = recruit_notice_grid.getRowData(rowid);
	                              if (isNotEmpty(row.RECRUITNO)) {
	                              	 target_row = row;
	                             	 applicant_grid.retreive({data:{RECRUITNO:row.RECRUITNO}});
	                             	
	                              }
	                          },
	                          onCellSelect: function(event, rowid, icol) {        // 해당 셀 선택시
	                              var row = recruit_notice_grid.getRowData(rowid);
	                          
	                              // 표기형식을 나타내주고 입력할땐 셀을 비워준다.
	                              if (recruit_notice_grid.getColName(icol) == 'RECRUITNO') {
	                                 if(row.RECRUITNO == "A00") { 
	                                	 recruit_notice_grid.setCell(rowid, 'RECRUITNO', '', '', {}, true); 
	                                 }
	                              }
	                              
	                              if(row.JQGRIDCRUD === "C") {
 	                            	  $("#recruit_notice_grid").jqGrid('setColProp', 'RECRUITNO', { editable: true });
	                              } else {
	                            	  $("#recruit_notice_grid").jqGrid('setColProp', 'RECRUITNO', { editable: false });
	                              }
	                              
	                          },
	                          onSelectRow: function (event, rowid, status, e) {
	                        	  var row = recruit_notice_grid.getRowData(rowid);
	                        	  
	                          }
                          }
    };
    
    var down_config = { 
            gridid    : 'applicant_grid',	    	// 그리드 id
            pagerid   : 'applicant_grid_pager',	// 그리드 페이지 id
            // column info
            columns   :[
            		     {name:'APPLICANTNO', label:'수험번호', align:'center', editable:false, width:20},
            		     {name:'APPLICANTNO', label:'수험번호', align:'center', editable:false, edittype:'text', width:80}, 
                         {name:'APPLICANTID', label:'수험자 아이디', editable:true, edittype:'text', width:200, required:true, editoptions:{
                             maxlength:25, dataInit: fn_changeGridDate
                         }},   // 저장 필수값은 required:true를 준다             
                         {name:'FINALAPPLYCHECKED', label:'제출여부', align:'center', editable:true, edittype:'select', formatter:'select', editoptions:{value:'1:제출;0:미제출', dataInit: fn_changeGridDate}, width:60, required:true},
                         {name:'APPLYNO', label:'직무번호', align:'center', editable:true, width:60, editoptions:{maxlength:50, dataInit: fn_changeGridDate}},
                         {name:'APPLICANTMILLITARY', label:'병역여부', align:'center', editable:true, width:60, editoptions:{maxlength:50, dataInit: fn_changeGridDate}},
                         {name:'APPLICANTVETERAN', label:'보훈여부', align:'center', editable:true, width:60, editoptions:{maxlength:50, dataInit: fn_changeGridDate}},
                         {name:'APPLICANTDISABILITY', label:'장애여부', editable:true, width:100, editoptions:{maxlength:100, dataInit: fn_changeGridDate}},
                         {name:'APPLICANTJOBPROTECT',label:'취업보호 대상자 여부', align:'center', width:100},
                         {name:'APPLYDATE', label:'지원날짜', align:'center', editable:true, width:60, editoptions:{maxlength:50, dataInit: fn_changeGridDate}},
                         // insert 시 초기값이 필요한 hidden columns
                         {name:'RECRUITNO',  hidden:true}
                        ],
            editmode    : true,                               // 그리드 editable 여부
            gridtitle   : '지원자 목록',                        // 그리드명
            multiselect : true,                               // checkbox 여부
            height      : 200,                                // 그리드 높이
            shrinkToFit : true,                               // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
            selecturl   : '/linkruit/getApplicantList',       // 그리드 조회 URL
            saveurl     : '/psys/savePsys10052',          // 그리드 입력/수정/삭제 URL
        };
    
    recruit_notice_grid = new UxGrid(up_config);
    recruit_notice_grid.init();
    
    applicant_grid = new UxGrid(down_config);
    applicant_grid.init();
    
    recruit_notice_grid.setGridWidth($('.tblType1').width());
    applicant_grid.setGridWidth($('.tblType1').width());
    
    $("#cb_recruit_notice_grid").css("display","none");
    
    // 마스터 저장 버튼 클릭 시 
    $("#btn_recruit_notice_save").click(function() {
    	var rowid = recruit_notice_grid.getSelectRowIDs();
        var row = recruit_notice_grid.getRowData(rowid);
        
    	if(row.RECRIUTNO == "A00") { 
            alert("코드ID를 입력해주세요.");
            
        }else {
	        // 코드id 수정못하도록 set false
	       // recruit_notice_grid.save( {success:function(){$("#recruit_notice_grid").jqGrid('setColProp', 'RECRUITNO', { editable: false });}});
	        
	        //console.log(data);
        	fn_Save();
        }
    });
    
    // 마스터 행추가 버튼 클릭 시
    $("#btn_recruit_notice_add").click(function() {
    	// default 값 세팅
        recruit_notice_grid.add({success:function(){applicant_grid.init();}});
        $("#recruit_notice_grid").jqGrid('setColProp', 'RECRUITNO', { editable: true });

    });
    
 	// 마스터 행삭제 버튼 클릭 시
    $("#btn_recruit_notice_del").click(function() {
    	var rowid = recruit_notice_grid.getSelectRowIDs();
    	var flag = false;
    	
    	if(rowid.length > 0) {
    		
	    	$.each(rowid, function (index, item) {
	    		if(recruit_notice_grid.getRowData(item).US_YN === 'Y') {
	    			flag = true;
	    		} 
	    	});
    	}
    	if (flag) {
	    	 alert("사용중인 코드가 있으므로 삭제할 수 없습니다.");
    	} else {
    		 recruit_notice_grid.remove( {success:function(){applicant_grid.init();}});
    	}
    });
 	
 	// 마스터 엑셀다운로드 버튼 클릭 시
    $("#btn_recruit_notice_excel").click(function() {
	    var grid_id = "recruit_notice_grid";
	    var rows    = $('#recruit_notice_grid').jqGrid('getGridParam', 'rowNum');
	    var page    = $('#recruit_notice_grid').jqGrid('getGridParam', 'page');
	    var total   = $('#recruit_notice_grid').jqGrid('getGridParam', 'total');
	    var title   = $('#recruit_notice_grid').jqGrid('getGridParam', 'gridtitle');
	    var url     = "/psys/getPsys1005XlsxDwld1";  //페이징 존재
	    var param          = {};
	        param.page     = page;
	        param.rows     = rows;
	        param.filename = "코드마스터 목록";
	    AdvencedExcelDownload(grid_id, url, param);
    });
    
 	// 상세 저장 버튼 클릭 시
    $("#btn_applicant_save").click(function() {
    	var rowid = applicant_grid.getSelectRowIDs();
        var row = applicant_grid.getRowData(rowid);
        
        applicant_grid.save();
    });
    
 	// 상세 행추가 버튼 클릭 시
    $("#btn_applicant_add").click(function() {
        // 현재 상위 그리드에서 선택된 값 확인
        var sels = recruit_notice_grid.getSelectRows();
        
        if (target_row == null) {
        	alert('상위 메뉴를 선택하세요.');
            return;
        } else if($("#recruit_notice_grid").jqGrid('getColProp', 'RECRUITNO').editable){
        	alert('상위 메뉴 저장후 사용가능합니다.');
            return;       	
        }
        
        // default 값 세팅
        applicant_grid.add({RECRUITNO:target_row.RECRUITNO});       
  
    });
    
 	// 상세 행삭제 버튼 클릭 시 
    $("#btn_applicant_del").click(function() {
    	var rowid = applicant_grid.getSelectRowIDs();
        var row = applicant_grid.getRowData(rowid);
        if(row.US_YN == 'Y') { // 만약 사용중인 코드라면 삭제할 수 없다.
           alert("사용중인 코드 이므로 삭제할 수 없습니다.");
           return;
        }
        else {
           applicant_grid.remove();
        }
    });
    
 	// 상세 엑셀다운로드 버튼 클륵 시 
    $("#btn_applicant_excel").click(function() {
    	var grid_id = "applicant_grid";
    	var rows    = $('#applicant_grid').jqGrid('getGridParam', 'rowNum');
    	var page    = $('#applicant_grid').jqGrid('getGridParam', 'page');
    	var total   = $('#applicant_grid').jqGrid('getGridParam', 'total');
    	var title   = $('#applicant_grid').jqGrid('getGridParam', 'gridtitle');
    	var url     = "/psys/getPsys1005XlsxDwld2";  //페이징 존재
    	var rowid   = recruit_notice_grid.getSelectRowIDs();
    	var row     = recruit_notice_grid.getRowData(rowid);
    	var param          = {};
    	    param.page     = page;
    	    param.rows     = rows;
    	    param.filename = "코드상세 목록";
    	    param.RECRUITNO   = row.RECRUITNO;
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
        var sels = applicant_grid.getSelectRows();
        if (sels.length == 0) {
            alert('하위 메뉴를 선택하세요');
            return;
        }
        else if (sels.length > 1) {
            alert('하위 메뉴 하나만 선택하세요');
            return;
        }
        // default 값 세팅
        bttn_menu_grid.add({RECRUITNO:sels[0].RECRUITNO});
    });
    
    $("#btn_bttn_menu_del").click(function() {
        bttn_menu_grid.remove();
    });
});

//grid resizing
$(window).resize(function() {
	recruit_notice_grid.setGridWidth($('.tblType1').width());
	applicant_grid.setGridWidth($('.tblType1').width());
});

//조회: 내부 로직 사용자 정의
function fn_Search(){
	recruit_notice_grid.retreive(); //{success:function(){alert('retreive success');}}
    applicant_grid.clearGridData();
 	// 코드id 수정못하도록 set false
    $("#recruit_notice_grid").jqGrid('setColProp', 'RECRUITNO', { editable: false });
    $("#applicant_grid").jqGrid('setColProp', 'CD'    , { editable: false });     
}

function fn_Save(){
	//jqgrid grid 데이터 json 형태로 생성
	var masterdata = getSaveData("recruit_notice_grid"); //grid_id
    var dtldata  = getSaveData("applicant_grid"); //grid_id
    if(isEmpty(masterdata)) {
    	return false;
    }
    //입력폼데이터 파라미터형태로 변경
    var formdata  = $("form[name=search]").serialize();
    var data ="masterdata="+masterdata+"&dtldata="+dtldata+"&_pre_url="+parent.preUrl.getPreUrl() +"&" + formdata; 
	ajax({
   		url: '/psys/savePsys1005',
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
								<td><span class="txt_pw"><input type="text" name="RECRUITNO" id="RECRUITNO" class="text" /></span></td>
								<th>마스터코드명</th>
								<td><span class="txt_pw"><input type="text" name="RECRUITNO_nm" id="RECRUITNO_nm" class="text" /></span></td>
							</tr>
						</tbody>
		            </table>
		       </form>
			</div>
			<div class="bgBorder"></div>
			<!-- search // -->
			<div class="grid_right_btn">
				<div class="grid_right_btn_in">
					<button id="btn_recruit_notice_save" class="btn_common btn_default">저장</button>
					<button id="btn_recruit_notice_add" class="btn_common btn_default">행추가</button>
					<button id="btn_recruit_notice_del" class="btn_common btn_default">행삭제</button>
					<button id="btn_recruit_notice_excel" class="btn_common btn_default">
                        <img src="<c:out value='${pageContext.request.contextPath}' />/resources/pandora3/images/common_new/img_download.png" alt="엑셀 다운로드" />
                    </button>
				</div>
			</div>
			<table id="recruit_notice_grid"></table>
			<div class="bgBorder"></div>
			<div id="recruit_notice_grid_pager"></div>
			<!-- Master Grid // -->
			
			<!-- Detail Grid -->
			<div class="grid_right_btn">
				<div class="grid_right_btn_in">
					<button id="btn_applicant_save" class="btn_common btn_default">저장</button>
					<button id="btn_applicant_add" class="btn_common btn_default">행추가</button>
					<button id="btn_applicant_del" class="btn_common btn_default">행삭제</button>
					<button id="btn_applicant_excel" class="btn_common btn_default">
					   <img src="<c:out value='${pageContext.request.contextPath}' />/resources/pandora3/images/common_new/img_download.png" alt="엑셀 다운로드" />
                    </button>
				</div>
			</div>
			<table id="applicant_grid"></table>
			<div id="applicant_grid_pager"></div>
			<!-- Detail Grid // -->
			<br />
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>
