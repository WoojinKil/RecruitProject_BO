<%-- 
   1. 파일명   : collegeList
   2. 파일설명 : 공고별 지원자 입력정보 조회
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
var college_grid;
var certificate_grid;
var actication_grid;
var career_grid;

var target_row = null;

//채용공고
//지원자
//학력
//자격증
//acti
//경력
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
        		    
        		    {name:'RECRUITNO', label: '공고번호', width:25, editable:false, editoptions:{
		                maxlength:12,
		                dataInit: function(element){
		                     $(element).keyup(function() {
		                         // 한글 입력 방지
		                         element.value = element.value.replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' );
		                     });
		                 }
		             }},
                     {name:'RECRUITNAME', label:'공고 이름', editable:false, edittype:'text', width:100, editoptions:{maxlength:100, dataInit: fn_changeGridDate }},   // 저장 필수값은 required:true를 준다             
                     {name:'TYPENAME', label:'채용형태', align:'center', editable:false, edittype:'select', formatter:'select', editoptions:{value:'공채:공채;수시:수시;기타:기타', dataInit:fn_changeGridDate}, width:25},
                     {name:'RECRUITSCALE', label:'채용규모', editable:false, width:25 , editoptions:{maxlength:10, dataInit: fn_changeGridDate}},
                     {name:'RECRUITSTARTDATETIME',label:'채용시작시간',editable:false, align:'center', width:40, formatter: "date", formatoptions: { dataInit:fn_changeGridDate, newformat: "Y-m-d h:i:s"}},
                     
                     

                     {name:'RECRUITENDDATETIME',label:'채용마감시간',editable:false, align:'center', width:40, formatter: "date", formatoptions: { dataInit:fn_changeGridDate, newformat: "Y-m-d h:i:s"}},
                     {name:'RECRUITWRITEDATE',label:'작성일자',editable:false, align:'center', width:40, formatter: "date", formatoptions: { dataInit:fn_changeGridDate, newformat: "Y-m-d h:i:s"}},
                     {name:'RECRUITCONTENT',label:'공고내용',editable:false, align:'center', width:150},
                     
                     
                     
                    ],          
        
        editmode       : true,                                 	    // 그리드 editable 여부
        gridtitle      : '지원공고 목록',                           	// 그리드명

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
            		     
            		     {name:'APPLICANTNO', label:'수험번호', align:'center', editable:false, width:10},
            		     
                         {name:'APPLICANTID', label:'수험자 아이디', editable:false, edittype:'text', width:15, required:true, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         {name:'MEMBERNAME', label:'수험자 이름', editable: false, edittype:'text', width:15, required:true, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         {name:'MEMBERBIRTH', label:'생년월일', editable:false, edittype:'text', width:10, required:true, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         
                         {name:'FINALAPPLYCHECKED', label:'제출여부', align:'center', editable:false, width:10, edittype:'select', formatter:'select', editoptions:{value:'1:제출;0:미제출', dataInit: fn_changeGridDate}, width:10},
                         {name:'APPLYNO', label:'지원번호', align:'center', editable:true, width:10, editoptions:{maxlength:50, dataInit: fn_changeGridDate}},
                         {name:'APPLICANTMILLITARY', label:'병역여부', align:'center', editable:false, width:10, edittype:'select', formatter:'select', editoptions:{maxlength:70, dataInit: fn_changeGridDate,value:'만기제대:만기제대(소집해제);복무중:복무중;면제:면제;해당사항 없음:해당사항 없음', dataInit: fn_changeGridDate}},
                         {name:'APPLICANTVETERAN', label:'보훈여부', align:'center', editable:false, width:10, edittype:'select', formatter:'select', editoptions:{value:'대상:대상;비대상:비대상', maxlength:50, dataInit: fn_changeGridDate}},
                         {name:'APPLICANTDISABILITY', label:'장애여부', editable:false, width:10, edittype:'select', formatter:'select', editoptions:{ value:'해당없음:해당없음;1급:1급;2급:2급;3급:3급',maxlength:100, dataInit: fn_changeGridDate}},
                         {name:'APPLICANTJOBPROTECT',label:'취업보호 대상자 여부', editable:false, align:'center', width:10, edittype:'select', formatter:'select', editoptions:{ value:'대상:대상;비대상:비대상'}},
                         {name:'APPLICANTHIGHSCHOOLNAME', label:'고등학교명', align:'center', editable:false, width:20, editoptions:{maxlength:50, dataInit: fn_changeGridDate}},
                         {name:'APPLICANTHIGHSCHOOLGRADUATEYEAR', label:'졸업날짜', align:'center', editable:false, width:20, editoptions:{maxlength:50, dataInit: fn_changeGridDate}},
                         {name:'APPLICANTHIGHSCHOOLGRADUATESTATE', label:'졸업여부', align:'center', editable:false, width:20, editoptions:{maxlength:50, dataInit: fn_changeGridDate}},
                         
                         {name:'APPLYDATE', label:'지원날짜', align:'center', editable:false, width:20, editoptions:{maxlength:50, dataInit: fn_changeGridDate}},
                         {name:'APPLICANTASSAY1', label:'자기소개서1', align:'left', editable:false, width:60, hidden:true, editoptions:{ dataInit: fn_changeGridDate}},
                         {name:'APPLICANTASSAY2', label:'자기소개서2', align:'left', editable:false, width:60, hidden:true, editoptions:{dataInit: fn_changeGridDate}},
                         {name:'APPLICANTASSAY3', label:'자기소개서3', align:'left', editable:false, width:60, hidden:true, editoptions:{ dataInit: fn_changeGridDate}}
                         // hidden columns
                         
                        ],
            editmode    : true,                               // 그리드 editable 여부
            gridtitle   : '지원자 목록',                        // 그리드명
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
                    	 college_grid.retreive({data:{APPLICANTNO:row.APPLICANTNO}});
                    	 certificate_grid.retreive({data:{APPLICANTNO:row.APPLICANTNO}});
                    	 activation_grid.retreive({data:{APPLICANTNO:row.APPLICANTNO}});
                    	 career_grid.retreive({data:{APPLICANTNO:row.APPLICANTNO}});
                    	 fn_assayInfo(row);
                     }
					
					
                    
                   
                   	
                    }
                }
            
        };
    
    var down_down_config1 = { 
            gridid    : 'college_grid',	    	// 그리드 id
            pagerid   : 'college_grid_pager',	// 그리드 페이지 id
            // column info
            columns   :[
            			 {name:'COLLEGEREGISTERNO', label:'학력등록번호', align:'center', editable:false, width:20, hidden: true},
      
            		     {name:'APPLICANTNO', label:'수험번호', align:'center', editable:false, width:20},
            		     
                         {name:'APPLICANTID', label:'수험자 아이디', editable:false, edittype:'text', width:30, required:true, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         {name:'MEMBERNAME', label:'수험자 이름', editable: false, edittype:'text', width:25, required:true, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         {name:'COLLEGENAME', label:'학교명', editable:false, edittype:'text', width:30, required:true, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         
                         {name:'COLLEGELOCATION', label:'소재지', align:'center', editable:false, editoptions:{dataInit: fn_changeGridDate}, width:20, required:true},
                         {name:'COLLEGEENTER', label:'입학', align:'center', editable:false, width:25, edittype:'select', formatter:'select' ,
                        	 editoptions:{maxlength:50, dataInit: fn_changeGridDate,
                        		value : '입학:입학;'
                        			   +'편입학:편입학;'
                        			   +'재입학:재입학;'
                        			   +'기타:기타'
                        	 
                       
                         
                        }},
                         
                         {name:'COLLEGEDEGREE', label:'학위', align:'center', editable:false, width:30, 
                        	 editoptions:{maxlength:50, dataInit: fn_changeGridDate,
                         		value : '학사:학사;'
                         			   +'전문학사:전문학사;'
                         			   +'석사:석사;'
                         			   +'박사:박사;'
                         			   +'석박사:석박사'                        	 
                         }},
                         {name:'COLLEGEMAJOR1', label:'주전공', editable:false, edittype:'text', width:30, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                           
                         {name:'COLLEGEMAJOR2', label:'제2전공', editable:false, edittype:'text', width:30, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         {name:'COLLEGEDOUBLEMAJORKIND', label:'제2전공 분류', editable: false, edittype:'text', width:25, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다
                         {name:'COLLEGESCORE', label:'학점', editable:false, edittype:'text', width:30, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         {name:'COLLEGESCOREMAX', label:'학점기준', editable:false, edittype:'text', width:30, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         {name:'COLLEGESTARTDATE', label:'입학기간', editable: false, edittype:'text', width:25, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다
                         {name:'COLLEGEENDDATE', label:'종료기간', editable:false, edittype:'text', width:30, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         {name:'COLLEGEGRADUATE', label:'졸업상태', editable:false, edittype:'text', width:30, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         
                         
                         
                         
                        ],
            editmode    : true,                               // 그리드 editable 여부
            gridtitle   : '학력 목록(전문대 이상)',                        // 그리드명
            height      : 200,                                // 그리드 높이
            shrinkToFit : true,                               // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
            selecturl   : '/linkruit/getCollegeList',       // 그리드 조회 URL
            saveurl     : '/linkruit/saveCollege3',          // 그리드 입력/수정/삭제 URL
            events         : {
				  ondblClickRow: function(event, rowid) {
                    var row = college_grid.getRowData(rowid);
					var applicantNo = row.APPLICANTNO;
					
                    if (isNotEmpty(row.COLLEGEREGISTERNO)) {
                     	 target_row = row;
                    	 //applicant_grid.retreive({data:{APPLICANTNO:row.collegeREGISTERNO}});
                    	 
                    	
                     }
					
					alert(row.COLLEGEREGISTERNO);
                    
                   
                   	
                    }
                }
            
        };
    
    var down_down_config2 = { 
            gridid    : 'certificate_grid',	    	// 그리드 id
            pagerid   : 'certificate_grid_pager',	// 그리드 페이지 id
            // column info
            columns   :[
            			 {name:'CERTIFICATEREGISTERNO', label:'자격증등록번호', align:'center', editable:false, width:20, hidden: true},
      
            		     {name:'APPLICANTNO', label:'수험번호', align:'center', editable:false, width:20},
            		     
                         {name:'APPLICANTID', label:'수험자 아이디', editable:false, edittype:'text', width:30, required:true, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         {name:'MEMBERNAME', label:'수험자 이름', editable: false, edittype:'text', width:25, required:true, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         {name:'CERTIFICATENAME', label:'자격증 이름', editable:false, edittype:'text', width:30, required:true, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         
                         {name:'CERTIFICATESCORE', label:'자격증 등급(점수)', align:'center', editable:false, editoptions:{dataInit: fn_changeGridDate}, width:20, required:true},
                         {name:'CERTIFICATEDATE', label:'취득 날짜', align:'center', editable:false, width:25, editoptions:{maxlength:50, dataInit: fn_changeGridDate}},
                         {name:'CERTIFICATECODE', label:'자격증 번호', align:'center', editable:false, width:50, editoptions:{maxlength:70, dataInit: fn_changeGridDate, dataInit: fn_changeGridDate}},
                         
                        ],
            editmode    : true,                               // 그리드 editable 여부
            gridtitle   : '자격증 목록',                        // 그리드명
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
   
    var down_down_config3 = { 
            gridid    : 'activation_grid',	    	// 그리드 id
            pagerid   : 'activation_grid_pager',	// 그리드 페이지 id
            // column info
            columns   :[
            			 {name:'ACTICATIONREGISTERNO', label:'활동등록번호', align:'center', editable:false, width:20, hidden: true},
      
            		     {name:'APPLICANTNO', label:'수험번호', align:'center', editable:false, width:20},
            		     
                         {name:'APPLICANTID', label:'수험자 아이디', editable:false, edittype:'text', width:30, required:true, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         {name:'MEMBERNAME', label:'수험자 이름', editable: false, edittype:'text', width:25, required:true, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         {name:'ACTIVATIONNAME', label:'활동명', editable:false, edittype:'text', width:30, required:true, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         
                         {name:'ACTIVATIONKIND', label:'종류', align:'center', editable:false, editoptions:{dataInit: fn_changeGridDate}, width:20},
                         {name:'ACTIVATIONROLE', label:'역할', align:'center', editable:false, width:25, edittype:'text'},
                         
                         {name:'ACTIVATIONSTARTDATE', label:'시작기간', align:'center', editable:false, width:30},

                         {name:'ACTIVATIONENDDATE', label:'종료기간', align:'center', editable:false, width:30},
                         {name:'ACTIVATIONORGAN', label:'기관명', editable:false, edittype:'text', width:30, editoptions:{maxlength:25, dataInit: fn_changeGridDate}}   // 저장 필수값은 required:true를 준다  
                         
                         
                        ],
            editmode    : true,                               // 그리드 editable 여부
            gridtitle   : '인턴, 동아리, 교육활동 사항',                        // 그리드명
            height      : 200,                                // 그리드 높이
            shrinkToFit : true,                               // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
            selecturl   : '/linkruit/getActivationList',       // 그리드 조회 URL
            saveurl     : '/linkruit/saveCollege3',          // 그리드 입력/수정/삭제 URL
            events         : {
				  ondblClickRow: function(event, rowid) {
                    var row = college_grid.getRowData(rowid);
					var applicantNo = row.APPLICANTNO;
					
                    if (isNotEmpty(row.COLLEGEREGISTERNO)) {
                     	 target_row = row;
                    	 //applicant_grid.retreive({data:{APPLICANTNO:row.collegeREGISTERNO}});
                    	 
                    	
                     }
					
					alert(row.COLLEGEREGISTERNO);
                    
                   
                   	
                    }
                }
            
        };
    
    var down_down_config4 = { 
            gridid    : 'career_grid',	    	// 그리드 id
            pagerid   : 'career_grid_pager',	// 그리드 페이지 id
            // column info
            columns   :[
            			 {name:'CAREERREGISTERNO', label:'경력등록번호', align:'center', editable:false, width:20, hidden: true},
      
            		     {name:'APPLICANTNO', label:'수험번호', align:'center', editable:false, width:20},
            		     
                         {name:'APPLICANTID', label:'수험자 아이디', editable:false, edittype:'text', width:30, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         {name:'MEMBERNAME', label:'수험자 이름', editable: false, edittype:'text', width:25, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         {name:'CAREERNAME', label:'회사명', editable:false, edittype:'text', width:30, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         
                         {name:'CAREERCONTRACT', label:'근무형태', align:'center', editable:false, editoptions:{dataInit: fn_changeGridDate}, width:20},
                         {name:'CAREERPART', label:'사업부', align:'center', editable:false, width:25, edittype:'text'},
                         
                         {name:'CAREERROLE', label:'직급', align:'center', editable:false, width:30},

                         {name:'CAREERSTARTDATE', label:'시작기간', align:'center', editable:false, width:30},
                         {name:'CAREERENDDATE', label:'종료기간', editable:false, edittype:'text', width:30, editoptions:{maxlength:25, dataInit: fn_changeGridDate}},   // 저장 필수값은 required:true를 준다  
                         {name:'CAREERCONTENT', label:'근무내용', align:'left', editable:false, edittype:'text', width:30, editoptions:{maxlength:25, dataInit: fn_changeGridDate}}   // 저장 필수값은 required:true를 준다
                         
                        ],
            editmode    : true,                               // 그리드 editable 여부
            gridtitle   : '경력 사항(아르바이트 제외)',                        // 그리드명
            height      : 200,                                // 그리드 높이
            shrinkToFit : true,                               // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
            selecturl   : '/linkruit/getCareerList',       // 그리드 조회 URL
            saveurl     : '/linkruit/saveCollege3',          // 그리드 입력/수정/삭제 URL
            events         : {
				  ondblClickRow: function(event, rowid) {
                    var row = college_grid.getRowData(rowid);
					var applicantNo = row.APPLICANTNO;
					
                    if (isNotEmpty(row.COLLEGEREGISTERNO)) {
                     	 target_row = row;
                    	 //applicant_grid.retreive({data:{APPLICANTNO:row.collegeREGISTERNO}});
                    	 
                    	
                     }
					
					alert(row.COLLEGEREGISTERNO);
                    
                   
                   	
                    }
                }
            
        };    
    recruit_notice_grid = new UxGrid(up_config);
    recruit_notice_grid.init();
    
    applicant_grid = new UxGrid(down_config);
    applicant_grid.init();
    
    college_grid = new UxGrid(down_down_config1);
    college_grid.init();
    
    certificate_grid = new UxGrid(down_down_config2);
    certificate_grid.init();
    
    activation_grid = new UxGrid(down_down_config3);
    activation_grid.init();
    
    career_grid = new UxGrid(down_down_config4);
    career_grid.init();
    
    
    recruit_notice_grid.setGridWidth($('.tblType1').width());
    applicant_grid.setGridWidth($('.tblType1').width());
    college_grid.setGridWidth($('.tblType1').width());
    certificate_grid.setGridWidth($('.thlType1').width());
    activation_grid.setGridWidth($('.thlType1').width());
    career_grid.setGridWidth($('.thlType1').width());
    
    $("#cb_recruit_notice_grid").css("display","none");
    
    // 마스터 저장 버튼 클릭 시 
    $("#btn_recruit_notice_save").click(function() {
    	var rowid = recruit_notice_grid.getSelectRowIDs();

        	fn_Save();
        
    });

    
 	// 상세 저장 버튼 클릭 시
    $("#btn_college_save").click(function() {
    	var rowid = college_grid.getSelectRowIDs();
        var row = college_grid.getRowData(rowid);
        
        college_grid.save();
    });
    

 	// 상세 행삭제 버튼 클릭 시 
    $("#btn_college_del").click(function() {
    	var rowid = college_grid.getSelectRowIDs();
        var row = college_grid.getRowData(rowid);
        if(row.US_YN == 'Y') { // 만약 사용중인 코드라면 삭제할 수 없다.
           alert("사용중인 코드 이므로 삭제할 수 없습니다.");
           return;
        }
        else {
        	college_grid.remove();
        }
    });
    
 	// 상세 엑셀다운로드 버튼 클륵 시 
    $("#btn_college_excel").click(function() {
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
	college_grid.setGridWidth($('.tblType1').width());
	certificate_grid.setGridWidth($('.tblType1').width());
	activation_grid.setGridWidth($('.tblType1').width());
	career_grid.setGridWidth($('.tblType1').width());
	
});

//조회: 내부 로직 사용자 정의
function fn_Search(){
	recruit_notice_grid.retreive(); //{success:function(){alert('retreive success');}}
    applicant_grid.clearGridData();
    college_grid.clearGridData();
    certificate_grid.clearGridData();
    activation_grid.clearGridData();
    career_grid.clearGridData();
    
 	// 코드id 수정못하도록 set false
    $("#recruit_notice_grid").jqGrid('setColProp', 'RECRUITNO', { editable: false });
    $("#applicant_grid").jqGrid('setColProp', 'APPLICANTNO'    , { editable: false });     
    $("#college_grid").jqGrid('setColProp', 'COLLEGEREGISTERNO'    , { editable: false });
    $("#certificate_grid").jqGrid('setColProp', 'CERTIFICATEREGISTERNO'    , { editable: false });
    $("#activation_grid").jqGrid('setColProp', 'ACTIVATIONREGISTERNO'    , { editable: false });
    $("#career_grid").jqGrid('setColProp', 'CAREERREGISTERNO'    , { editable: false });
}

//버튼 클릭 시 자기소서개의 값이 출력
function fn_assayInfo(rowInfo){

	$("#applicant_assay1").val(rowInfo.APPLICANTASSAY1);
	$("#applicant_assay2").val(rowInfo.APPLICANTASSAY2);
	$("#applicant_assay3").val(rowInfo.APPLICANTASSAY3);
	
}

function fn_Save(){
	//jqgrid grid 데이터 json 형태로 생성
	var recruitNoticeData = getSaveData("recruit_notice_grid"); //grid_id
    var applicantData  = getSaveData("applicant_grid"); //grid_id
    var collegeData = getSaveData("college_grid"); // grid_id
    var certificateData = getSaveData("certificate_grid"); // grid_id
    var activationData = getSaveData("activation_grid"); // grid_id
    var careerData = getSaveData("career_grid"); // grid_id
    if(isEmpty(recruitNoticeData)) {
    	return false;
    }
    
    //입력폼데이터 파라미터형태로 변경
    var formdata  = $("form[name=search]").serialize();
    var data = 	"recruitNoticeData="+recruitNoticeData+
    			"&applicantData="+applicantData+
    			"&collegeData="+collegeData+
    			"&certificateData="+certificateData+
    			"&activationData="+activationData+
    			"&_pre_url="+parent.preUrl.getPreUrl() +"&" + formdata;
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
								<th>공고번호</th>
								<td><span class="txt_pw"><input type="text" name="recruitno" id="recruitno" class="text" /></span></td>
								<th>공고 이름</th>
								<td><span class="txt_pw"><input type="text" name="recruitname" id="recruitname" class="text" /></span></td>
							</tr>
						</tbody>
		            </table>
		       </form>
			</div>
			<div class="bgBorder"></div>
			<!-- search // -->

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
			<!-- DetailDetail1 Grid -->
			<div class="grid_right_btn">
				<div class="grid_right_btn_in">

					<button id="btn_college_excel" class="btn_common btn_default">
					   <img src="<c:out value='${pageContext.request.contextPath}' />/resources/pandora3/images/common_new/img_download.png" alt="엑셀 다운로드" />
                    </button>
				</div>
			</div>
			<table id="college_grid"></table>
			<div id="college_grid_pager"></div>
			<!-- DetailDetail1 Grid // -->			

			<!-- DetailDetail2 Grid -->
			<div class="grid_right_btn">
				<div class="grid_right_btn_in">

					<button id="btn_certificate_excel" class="btn_common btn_default">
					   <img src="<c:out value='${pageContext.request.contextPath}' />/resources/pandora3/images/common_new/img_download.png" alt="엑셀 다운로드" />
                    </button>
				</div>
			</div>
			<table id="certificate_grid"></table>
			<div id="certificate_grid_pager"></div>
			<!-- DetailDetail2 Grid // -->	
			
			<!-- DetailDetail3 Grid -->
			<div class="grid_right_btn">
				<div class="grid_right_btn_in">

					<button id="btn_certificate_excel" class="btn_common btn_default">
					   <img src="<c:out value='${pageContext.request.contextPath}' />/resources/pandora3/images/common_new/img_download.png" alt="엑셀 다운로드" />
                    </button>
				</div>
			</div>
			<table id="activation_grid"></table>
			<div id="activation_grid_pager"></div>
			<!-- DetailDetail3 Grid // -->	
			
			<!-- DetailDetail4 Grid -->
			<div class="grid_right_btn">
				<div class="grid_right_btn_in">

					<button id="btn_certificate_excel" class="btn_common btn_default">
					   <img src="<c:out value='${pageContext.request.contextPath}' />/resources/pandora3/images/common_new/img_download.png" alt="엑셀 다운로드" />
                    </button>
				</div>
			</div>
			<table id="career_grid"></table>
			<div id="career_grid_pager"></div>
			<!-- DetailDetail4 Grid // -->				
			<br />
			
			<!-- DetailDetail5 Assay -->
			<div class="tableTop">
				<h3 class="title">자기소개서</h3>
			</div>
			<form name="pgmInfoForm1" id="pgmInfoForm1" method="post">
				<table class="tblType1">

					<tr>
						<th>
							<label for="sys_cd">1번 항목</label><br>
							<span>
							 링크 컴퍼니에 3가지 인재상 중에 자신이 부합하다고 생각하는 인재상을 하나 선택하여
							 그렇게 생각하는 이유를 본인의 가치관과 연계하여 교육사항, 경험 및 경력 등
							  구체적인 사례를 들어 기술하여 주십시오.(최대 700자)
							</span>
						</th>
						<td colspan="6"><textarea style="width:100%; height: 200px" id="applicant_assay1" name="applicant_assay1" maxlength="700" readonly="readonly"></textarea></td>
					</tr>
					<tr>
						<th>
							<label for="sys_cd">2번 항목</label><br>
							<span>
							 다른 사람들과 함께 일을 했던 경험에 대해 설명하고,
							 목표를 달성하는 과정에서 팀원들과 의견 차이를 보였던 사례와 갈등을 해결하기 위해 기울인 노력과 방법, 결과를 
							 구체적으로 기술해 주십시오.(최대 700자)
							</span>
						</th>
						<td colspan="6"><textarea style="width:100%; height: 200px" id="applicant_assay2" name="applicant_assay1" maxlength="700" readonly="readonly"></textarea></td>
					<tr>
					<tr>
						<th>
							<label for="sys_cd">3번 항목</label><br>
							<span>
							 지금까지 가장 큰 성취 및 실패에 대하여 기술해 주십시오. (최대 700자)
							
							</span>
						</th>
						<td colspan="6"><textarea style="width:100%; height: 200px" id="applicant_assay3" name="applicant_assay1" maxlength="700" readonly="readonly"></textarea></td>
					<tr>					
				</table>
			</form>
			
			
			
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>
