<%-- 
   1. 파일명   : certificateList
   2. 파일설명 : 공고별 지원자 자격증 관리
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
var certificate_grid;
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
        		    
        		    {name:'RECRUITNO', label: '공고번호', width:25, required:true, editable:false, editoptions:{
		                maxlength:12,
		                dataInit: function(element){
		                     $(element).keyup(function() {
		                         // 한글 입력 방지
		                         element.value = element.value.replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' );
		                     });
		                 }
		             }},
                     {name:'RECRUITNAME', label:'공고 이름', editable:false, edittype:'text', width:100, required:true, editoptions:{maxlength:100, dataInit: fn_changeGridDate }},   // 저장 필수값은 required:true를 준다             
                     {name:'TYPENO', label:'채용형태', align:'center', editable:false, edittype:'select', formatter:'select', editoptions:{value:'T1:공채;T2:수시', dataInit:fn_changeGridDate}, width:25, required:true},
                     {name:'RECRUITSCALE', label:'채용규모', editable:false, width:25 , editoptions:{maxlength:10, dataInit: fn_changeGridDate}},
                     {name:'RECRUITSTARTDATETIME',label:'채용시작시간',editable:false, align:'center', width:40, formatter: "date", formatoptions: { dataInit:fn_changeGridDate, newformat: "Y-m-d h:i:s"}},
                     
                     

                     {name:'RECRUITENDDATETIME',label:'채용마감시간',editable:false, align:'center', width:40, formatter: "date", formatoptions: { dataInit:fn_changeGridDate, newformat: "Y-m-d h:i:s"}},
                     {name:'RECRUITWRITEDATE',label:'작성일자',editable:false, align:'center', width:40, formatter: "date", formatoptions: { dataInit:fn_changeGridDate, newformat: "Y-m-d h:i:s"}},
                     {name:'RECRUITCONTENT',label:'공고내용',editable:false, align:'center', width:150},
                     
                     
                     
                    ],          
        
        editmode       : true,                                 	    // 그리드 editable 여부
        gridtitle      : '지원공고 목록',                           	// 그리드명
        multiselect    : true,                             		    // checkbox 여부
        //multiboxonly : true,                                      
        formid         : 'search',                                  // 조회조건 form id
        height         : 200,                                       // 그리드 높이
        //shrinkToFit  : true,                              	    // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl      : '/linkruit/getRecruitNoticeList',  		    // 그리드 조회 URL
        saveurl        : '/linkruit/saveRecruitNotice1',        		    // 그리드 입력/수정/삭제 URL
        events         : {
        					  ondblClickRow: function(event, rowid) {
	                              var row = recruit_notice_grid.getRowData(rowid);
	                              console.log(row.RECRUITNO + row.RECRUITNAME);
	                              console.log("시작시간"+row.RECRUITSTARTDATETIME);
	                              console.log("마감시간"+row.RECRUITENDDATETIME);
	                              
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
            		     
                         {name:'APPLICANTID', label:'수험자 아이디', editable:false, edittype:'text', width:30, required:true, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         {name:'MEMBERNAME', label:'수험자 이름', editable: false, edittype:'text', width:25, required:true, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         {name:'MEMBERBIRTH', label:'수험자 생년월일', editable:false, edittype:'text', width:30, required:true, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         
                         {name:'FINALAPPLYCHECKED', label:'제출여부', align:'center', editable:true, edittype:'select', formatter:'select', editoptions:{value:'1:제출;0:미제출', dataInit: fn_changeGridDate}, width:20, required:true},
                         {name:'APPLYNO', label:'지원번호', align:'center', editable:true, width:25, editoptions:{maxlength:50, dataInit: fn_changeGridDate}},
                         {name:'APPLICANTMILLITARY', label:'병역여부', align:'center', editable:true, width:50, edittype:'select', formatter:'select', editoptions:{maxlength:70, dataInit: fn_changeGridDate,value:'만기제대:만기제대(소집해제);복무중:복무중;면제:면제;해당사항 없음:해당사항 없음', dataInit: fn_changeGridDate}},
                         {name:'APPLICANTVETERAN', label:'보훈여부', align:'center', editable:true, width:30, edittype:'select', formatter:'select', editoptions:{value:'대상:대상;비대상:비대상', maxlength:50, dataInit: fn_changeGridDate}},
                         {name:'APPLICANTDISABILITY', label:'장애여부', editable:true, width:40, edittype:'select', formatter:'select', editoptions:{ value:'해당없음:해당없음;1급:1급;2급:2급;3급:3급',maxlength:100, dataInit: fn_changeGridDate}},
                         {name:'APPLICANTJOBPROTECT',label:'취업보호 대상자 여부', editable:true, align:'center', width:30, edittype:'select', formatter:'select', editoptions:{ value:'대상:대상;비대상:비대상'}},
                         {name:'APPLYDATE', label:'지원날짜', align:'center', editable:true, width:60, editoptions:{maxlength:50, dataInit: fn_changeGridDate}},
                         // insert 시 초기값이 필요한 hidden columns
                         
                        ],
            editmode    : true,                               // 그리드 editable 여부
            gridtitle   : '자격증 목록',                        // 그리드명
            multiselect : true,                               // checkbox 여부
            height      : 200,                                // 그리드 높이
            shrinkToFit : true,                               // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
            selecturl   : '/linkruit/getApplicantList',       // 그리드 조회 URL
            saveurl     : '/linkruit/saveApplicant2',          // 그리드 입력/수정/삭제 URL
            events         : {
				  ondblClickRow: function(event, rowid) {
                    var row = applicant_grid.getRowData(rowid);
					var applicantNo = row.APPLICANTNO;
					
                    if (isNotEmpty(row.APPLICANTNO)) {
                     	 target_row = row;
                    	 certificate_grid.retreive({data:{APPLICANTNO:row.APPLICANTNO}});
                    	 
                    	
                     }
					
					
                    
                   
                   	
                    }
                }
            
        };
    
    var down_down_config = { 
            gridid    : 'certificate_grid',	    	// 그리드 id
            pagerid   : 'certificate_grid_pager',	// 그리드 페이지 id
            // column info
            columns   :[
            			 {name:'CERTIFICATEREGISTERNO', label:'자격증등록번호', align:'center', editable:false, width:20, hidden: true},
      
            		     {name:'APPLICANTNO', label:'수험번호', align:'center', editable:false, width:20},
            		     
                         {name:'APPLICANTID', label:'수험자 아이디', editable:false, edittype:'text', width:30, required:true, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         {name:'MEMBERNAME', label:'수험자 이름', editable: false, edittype:'text', width:25, required:true, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         {name:'CERTIFICATENAME', label:'자격증 이름', editable:true, edittype:'text', width:30, required:true, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         
                         {name:'CERTIFICATESCORE', label:'자격증 등급(점수)', align:'center', editable:true, editoptions:{dataInit: fn_changeGridDate}, width:20, required:true},
                         {name:'CERTIFICATEDATE', label:'취득 날짜', align:'center', editable:true, width:25, editoptions:{maxlength:50, dataInit: fn_changeGridDate}},
                         {name:'CERTIFICATECODE', label:'자격증 번호', align:'center', editable:true, width:50, editoptions:{maxlength:70, dataInit: fn_changeGridDate, dataInit: fn_changeGridDate}},
                         
                        ],
            editmode    : true,                               // 그리드 editable 여부
            gridtitle   : '자격증 목록',                        // 그리드명
            multiselect : true,                               // checkbox 여부
            height      : 200,                                // 그리드 높이
            shrinkToFit : true,                               // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
            selecturl   : '/linkruit/getCertificateList',       // 그리드 조회 URL
            saveurl     : '/linkruit/saveCertificate3',          // 그리드 입력/수정/삭제 URL
            events         : {
				  ondblClickRow: function(event, rowid) {
                    var row = certificate_grid.getRowData(rowid);
					var applicantNo = row.APPLICANTNO;
					
                    if (isNotEmpty(row.CERTIFICATEREGISTERNO)) {
                     	 target_row = row;
                    	 //applicant_grid.retreive({data:{APPLICANTNO:row.CERTIFICATEREGISTERNO}});
                    	 
                    	
                     }
					
					alert(row.CERTIFICATEREGISTERNO);
                    
                   
                   	
                    }
                }
            
        };
    
    recruit_notice_grid = new UxGrid(up_config);
    recruit_notice_grid.init();
    
    applicant_grid = new UxGrid(down_config);
    applicant_grid.init();
    
    certificate_grid = new UxGrid(down_down_config);
    certificate_grid.init();
    
    recruit_notice_grid.setGridWidth($('.tblType1').width());
    applicant_grid.setGridWidth($('.tblType1').width());
    certificate_grid.setGridWidth($('.tblType1').width());
    
    $("#cb_recruit_notice_grid").css("display","none");
    
    // 마스터 저장 버튼 클릭 시 
    $("#btn_recruit_notice_save").click(function() {
    	var rowid = recruit_notice_grid.getSelectRowIDs();

        	fn_Save();
        
    });

    
 	// 상세 저장 버튼 클릭 시
    $("#btn_certificate_save").click(function() {
    	var rowid = certificate_grid.getSelectRowIDs();
        var row = certificate_grid.getRowData(rowid);
        
        certificate_grid.save();
    });
    

 	// 상세 행삭제 버튼 클릭 시 
    $("#btn_certificate_del").click(function() {
    	var rowid = certificate_grid.getSelectRowIDs();
        var row = certificate_grid.getRowData(rowid);
        if(row.US_YN == 'Y') { // 만약 사용중인 코드라면 삭제할 수 없다.
           alert("사용중인 코드 이므로 삭제할 수 없습니다.");
           return;
        }
        else {
        	certificate_grid.remove();
        }
    });
    
 	// 상세 엑셀다운로드 버튼 클륵 시 
    $("#btn_certificate_excel").click(function() {
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
	certificate_grid.setGridWidth($('.tblType1').width());
});

//조회: 내부 로직 사용자 정의
function fn_Search(){
	recruit_notice_grid.retreive(); //{success:function(){alert('retreive success');}}
    applicant_grid.clearGridData();
    certificate_grid.clearGridData();
    
 	// 코드id 수정못하도록 set false
    $("#recruit_notice_grid").jqGrid('setColProp', 'RECRUITNO', { editable: false });
    $("#applicant_grid").jqGrid('setColProp', 'APPLICANTNO'    , { editable: false });     
    $("#certificate_grid").jqGrid('setColProp', 'CERTIFICATEREGISTERNO'    , { editable: false });
}

function fn_Save(){
	//jqgrid grid 데이터 json 형태로 생성
	var recruitNoticeData = getSaveData("recruit_notice_grid"); //grid_id
    var applicantData  = getSaveData("applicant_grid"); //grid_id
    var certificateData = getSaveData("certificate_grid"); // grid_id
    if(isEmpty(recruitNoticeData)) {
    	return false;
    }
    
    //입력폼데이터 파라미터형태로 변경
    var formdata  = $("form[name=search]").serialize();
    var data ="recruitNoticeData="+recruitNoticeData+"&applicantData="+applicantData+"&certificateData="+certificateData+"&_pre_url="+parent.preUrl.getPreUrl() +"&" + formdata;
    console.log(data);
	ajax({
   		url: '/linkruit/saveRecruitNotice',
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

				</div>
			</div>
			<table id="recruit_notice_grid"></table>
			<div class="bgBorder"></div>
			<div id="recruit_notice_grid_pager"></div>
			<!-- Master Grid // -->
			
			<!-- Detail1 Grid -->
			<div class="grid_right_btn">
			</div>
			<table id="applicant_grid"></table>
			<div id="applicant_grid_pager"></div>
			<!-- Detail Grid1 // -->
			
			<br />
			<!-- Detail2 Grid -->
			<div class="grid_right_btn">
				<div class="grid_right_btn_in">
					<button id="btn_certificate_save" class="btn_common btn_default">저장</button>
					
					<button id="btn_certificate_del" class="btn_common btn_default">행삭제</button>
					<button id="btn_certificate_excel" class="btn_common btn_default">
					   <img src="<c:out value='${pageContext.request.contextPath}' />/resources/pandora3/images/common_new/img_download.png" alt="엑셀 다운로드" />
                    </button>
				</div>
			</div>
			<table id="certificate_grid"></table>
			<div id="certificate_grid_pager"></div>
			<!-- Detail Grid2 // -->			
			
			<br />
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>
