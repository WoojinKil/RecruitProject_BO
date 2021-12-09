<%-- 
   1. 파일명 : pcmp1000
   2. 파일설명 : 회사관리 (목록)
   3. 작성일 : 2020-05-19
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var cmpny_grid;
var use_sys_grid;

var sys_cd = '';
$(document).ready(function() {
	
    var cmpny_config = { 
        gridid    : 'cmpny_grid',	    // 그리드 id
        pagerid   : 'cmpny_grid_pager',	// 그리드 페이지 id
        gridBtnYn : 'Y',				// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        // column info
        columns:[{name:'CMPNY_CD', label:'회사코드', editable:false,  width:60},
                 {name:'CMPNY_NM', label:'회사명', align:'center', editable:false, width:200},
                 {name:'BIZ_REG_NO_VAL', label:'사업자등록번호', align:'center', editable:false,  width:150},
                 {name:'RPRSNT_NM', label:'대표자명', align:'center', editable:false,  width:100},
                 {name:'REP_TELNO', label:'대표연락처', align:'center', editable:false,  width:120},
                 {name:'REP_FAX_TELNO', label:'FAX번호', align:'center', editable:false,  width:120},
                 {name:'US_YN', label:'사용여부', align:'center', editable:false,  width:80},                 
                 {name:'USE_CNTRT_DY', label:'사용계약일자', align:'center', editable:false,  width:120},
                 {name:'FEE_TYP_CD', label:'요금제',  width:200},
                 {name:'LINK', label:'편집',  width:100 , editable:false, formatter:imageFormatter}                 
                 /* {name:'SYS_CD', label:'사이트번호', hidden:true,  width:200}  -- CMPNY_M테이블에 sys_cd 추가시 필요 */                 
                 ],
        initval     : {},	                                        // 컬럼 add 시 초기값
        editmode    : false,							            // 그리드 editable 여부
        gridtitle   : '회사목록',						            	// 그리드명
        multiselect : true,							                // checkbox 여부
        formid      : 'search',							            // 조회조건 form id
        height      : '150',							 	        // 그리드 높이
        selecturl   : '/pcmp/getPcmp1000List',	                    // 그리드 조회 URL
        events      : {    
        				ondblClickRow: function(event, rowid, irow, icol) {
	                    	var row = cmpny_grid.getRowData(rowid);
	                        if (isNotEmpty(row.CMPNY_CD)) {
	                        	use_sys_grid.retreive({data:{cmpny_cd:row.CMPNY_CD}});  
	                        }
	                    }, 
        				onCellSelect: function(event, rowid, icol, conts){
	                    	var row = cmpny_grid.getRowData(rowid);
    				        var sys_cd = $("#sys_info").val();
        					if(cmpny_grid.getColName(icol) == 'LINK'){
        						//상세보기 팝업
        				        bpopup({
        							  url:"/pcmp/forward.pcmp1002.adm"
        							, params	: {sys_cd : sys_cd, cmpny_cd : row.CMPNY_CD}
        							, title		: "회사상세" 
        							, type		: "l"
        							, height	: "800px"
        							, width     : "1200px"
        							, id        : "pcmp1002"
        						});	       					
        				    }
        				}
      	}
    };    
    
    var use_sys_config = {
            
            gridid  : 'use_sys_grid',			// 그리드 id
            pagerid : 'use_sys_grid_pager',	// // 그리드 페이지 id
            // column info
            columns:[
            	     {name : 'SYS_CD', label : '시스템코드', align:'center', editable:false, width:60},
                     {name : 'SYS_NM', label : '시스템명', width:100},
            	     {name : 'TPIC_NM', label:'담당자명', align:'center', editable:false, width:60},	
            	     {name : 'CNTRT_STA_DY' , label:'계약시작일자',  editable:false, align:'center',  sortable:false, width:150},                       
                     {name : 'CNTRT_END_DY', label:'계약종료일자', editable:false, align:'center',  sortable:false, width:150},
                     {name : 'PRD_GBCD', label:'상품구분코드', editable:false, width:60, sortable:false, hidden:true},
                     {name : 'PRD_NM', label:'상품구분', editable:false, width:60, sortable:false}
                     ],
            initval     : {},								// 컬럼 add 시 초기값
            editmode    : false,								// 그리드 editable 여부
            gridtitle   : '사용시스템',						// 그리드명
            multiselect : false,								// checkbox 여부
            height      : '200',							// 그리드 높이
            shrinkToFit : true,								// true인경우 column의 width 자동조정, false인경우 정해진 width데로 구현(가로스크롤바필요시 false)
            selecturl   : '/pcmp/getPcmp1100List',	    // 그리드 조회 URL
//          saveurl     : '/pcmp/savePcmp1100List'		// 그리드 입력/수정/삭제 URL
    };

    cmpny_grid = new UxGrid(cmpny_config);
    cmpny_grid.init();
    use_sys_grid = new UxGrid(use_sys_config);
    use_sys_grid.init();
    
    cmpny_grid.setGridWidth($('.tblType1').width());
    use_sys_grid.setGridWidth($('.tblType1').width());
    
    
      
    // 회사관리 신규 버튼 클릭 시
    $("#btn_cmpny_add").click(function() {
        var sys_cd = $("#sys_info").val();

        bpopup({
			  url:"/pcmp/forward.pcmp1001.adm"
			, params	: {sys_cd : sys_cd}
			, title		: "회사등록" 
			, type		: "l"
			, height	: "800px"
			, width     : "1200px"
			, id        : "pcmp1001"
		});		     
    });
    
    // 회사관리 삭제 버튼 클릭 시
    $("#btn_cmpny_del").click(function() {
    	cmpny_grid.remove();
    });
    
    // 회사검색 버튼 클릭
    $("#cmpny_search_btn").click(function(){
     	var srch_txt = $("#srch_txt").val().replace(" ","");
     	console.log(srch_txt);
     	ajax({
     	    url: "/pcmp/searchCmpny",
     	    data:{srch_txt: srch_txt},
     	    success:function(data) {
    	   			if (data.RESULT == "S") {
       					var dataCnt = data.rows.length;
       					console.log(dataCnt);
       					if(dataCnt == 1){
       						$("#srch_txt").val(data.rows[0].CMPNY_CD);
       						$("#srch_result_txt").val(data.rows[0].CMPNY_NM); 
       					}else{	
	       			     	bpopup({
	       			     		  url:"/pcmp/forward.pcmp1000p001.adm"
	       						, params: {srch_txt: srch_txt, callback:"getCmpnyInfo", target_id : _menu_id}
	       						, title:"회사검색팝업"
	       						, type: "l"
	       						, height:"370"
	       						, id: "pcmp1000p001"
	       					}); 
       					}
       				}
     	    }
     	});
     });
    
  	//사이트 리스트 취득
    getSystemList();
 	
 	//시스템 변경 시 재 검색
    $("#sys_info").on("change", function () {
		fn_Search();
	});  
    
});

//grid resizing
$(window).resize(function() {
	cmpny_grid.setGridWidth($('.tblType1').width());
	use_sys_grid.setGridWidth($('.tblType1').width());
});

//jqGrid 컬럼 내용 변환 (이미지 삽입)
function imageFormatter(cellvalue, options, rowObject) {
    return '<span class="pointer"><img src="${pageContext.request.contextPath}/resources/pandora3/images/common/btn_search.png" alt="검색" /></span>';
}


//회사 검색 팝업 callback 함수
function getCmpnyInfo(row){
	//console.log(row);
	$("#srch_txt").val(row.CMPNY_CD);
	$("#srch_result_txt").val(row.CMPNY_NM);
}
    
//조회: 내부 로직 사용자 정의
function fn_Search(){
	
	var sys_cd = $("#sys_info").val();
	$("#sys_cd").val(sys_cd);
	
	cmpny_grid.retreive(); 
	use_sys_grid.clearGridData();      
}

//사이트 리스트 취득
function getSystemList() {
	var html = "";
	ajax({
		url 	: "/pdsp/getPdsp1011ListSit",
		data 	: {sys_cd : _sys_cd} , 
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
<body id="app">
	<div class="frameWrap">
	    <div class="subCon">
	    	<%@ include file="/WEB-INF/views/pandora3/common/include/btnList2.jsp" %>
	    	<!-- search -->
	    	<div class="tableTopLeft gridBtn">
				<div class="selectInner" style="display: none;">
					<label for="sys_info">시스템 : </label>
					<select id="sys_info" name="sys_info" class="select" >
						<option value="">전체</option>
					</select>
				</div>
			</div>
			<div class="frameTopTable">  
	            <form name="search" id="search" name="search" onsubmit="return false">
	            	<input type="hidden" name="sys_cd" id="sys_cd" value="" />
		            <table class="tblType1">  
				        <colgroup>
		                    <col style="width: 15%;">
		                    <col style="width: *;">
		                </colgroup>
			            <tr>
			                <th>회사코드/명</th>
			                <td>
			                    <span class="txt_pw">
			                    	<input type="text" name="srch_txt" id="srch_txt" class="text" value="" maxlength="300"/>
                    				<input type="text" name="srch_result_txt" id="srch_result_txt" class="text" value="" maxlength="300" readonly="readonly"/>
			                    </span>
			                    <button type="button" id="cmpny_search_btn">?</button>
			                </td>                  
			            </tr>
		            </table>
	            </form>
            </div>
            <div class="bgBorder"></div>
	        <!-- search // -->
	        <!-- Grid -->
	        <div class="grid_right_btn">
				<div id="btn_cmpny_grid" class="grid_right_btn_in">
<!-- 				<button class="btn_common btn_default" id="btn_cmpny_save">저장</button> -->
					<button class="btn_common btn_default" id="btn_cmpny_add">신규</button>
					<button class="btn_common btn_default" id="btn_cmpny_del">삭제</button>
<%-- 				<button class="btn_common btn_default" id="btn_cmpny_excel">
					   <img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_download.png" alt="엑셀 다운로드" />
                    </button> --%>
				</div>
			</div>
			
	        <table id="cmpny_grid"></table> 	        
	        <div class="bgBorder"></div>
	        <div id="cmpny_grid_pager"></div>	       
			
	        <table id="use_sys_grid"></table> 
	        <div id="use_sys_grid_pager"></div>
	        <br/>
	        <!-- Grid // -->    
	    </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
