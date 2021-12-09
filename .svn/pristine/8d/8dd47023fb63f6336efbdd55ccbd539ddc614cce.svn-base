<%-- 
   1. 파일명 : pbbs3001
   2. 파일설명: 점사은행사
   3. 작성일 : 2020-02-21
   4. 작성자 : 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Arrays,java.util.List" %>
<script type="text/javascript">
<%
Date nowTime = new Date();
SimpleDateFormat sfMM = new SimpleDateFormat("MM");
SimpleDateFormat sfYYYY = new SimpleDateFormat("yyyy");	
%>
var menu_id = _menu_id;
var bpcm3001_grid;
var cnt = 0; 

//현재월이 11월이후이면 내년 캘린더까지 선택가능
//현재월이 11월이전이면 해당년도 캘린더까지 선택가능
//start
var toDayMM = '<%= sfMM.format(nowTime) %>';
var toDayYYYY = '<%= sfYYYY.format(nowTime) %>';
var maxDate = "";
var toDayintMm = parseInt(toDayMM, 10);
if(toDayintMm<11){
	maxDate = toDayYYYY + "1231";
} else {
	var yyyyPlus = parseInt(toDayYYYY, 10) + 1 ;
	maxDate = yyyyPlus + "1231";
}
//end
var obj = {
		autoUpdateInput	: false,
		showDropdowns: true,
		linkedCalendars: false,
		singleDatePicker: true,
		/* 날짜/일시 선택 start */
	    timePicker: false,
	    minDate : moment(), //과거일자는 입력못하도록 막는 기능
	    maxDate : maxDate,
	    //viewModel : 'month',
	    locale: {
	        format: 'YYYY-MM-DD'
	    }
		/* 날짜/일시 선택 end */
	};
	
$(document).ready(function() {
	
    $("#calStart").daterangepicker(obj, function(start, end, separator) {	    
	    $("#calStart").val(start);	    
	});
    
    $("#calEnd").daterangepicker(obj, function(start, end, separator) {	    
	    $("#calEnd").val(end);	    
	});
        
	$("#txt_evtNm").keyup(function(){
		checkByte();
    });
	
	$("#search input[type=text]").keypress(function(e) { 
		if (e.keyCode == 13){
			fn_Search();
		}
	});
//     $("#calEnd").on('click', function () {
//    	 $("#calStart").trigger('click');
//    });
    
    // 조회버튼 
    $("#btn_search").click(function() {
		fn_Search();
	});	
    
    // 조회버튼 
    $("#btn_init").click(function() {
		fn_Init();
	});
    
    _grid_rows = 10;
    _grid_rows_list = [10,50,100];
    
	// 그리드 초기화
	var module_config = {
		// 그리드, 페이징 ID
		gridid:'bpcm3001_grid',
		pagerid:'bpcm3001_grid_pager',
		// 컬럼 정보
		//사은진행상태 01: 진행중 02:마감임박 03:종료
		columns:[{name:'THKU_EVNT_NO', width:50, label:'이벤트코드', align: "center", hidden:true},
		         {name:'THKU_EVNT_MDCLS_NM', width:30, label:'유형', align: "center", hidden:false},
			     /* {name:'EVNT_NM', width:150, label:'사은명', hidden:false}, */
				 {name:'EVNT_NM', label:'사은행사명', align: 'left', width:150, hidden:false
		             ,formatter: function(cellValue,options,rowdata,action){
		                	var str ="";
		                	
		                	if(rowdata.THKU_EVNT_PRGRS_STAT_CD == "03"){
		                		str ="<span class='board_inf'>종료</span>" + cellValue;
		                	} else if(rowdata.THKU_EVNT_PRGRS_STAT_CD == "02") {
		                		str ="<span class='board_inf'>마감임박</span>" + cellValue;
		                	} else {
		                		str = cellValue;
		                	}
		                	return str;
		                }
	             },
			     {name:'EVNT_DT', width:50, label:'행사기간', hidden:false},
			     {name:'EVNT_SMRY_2_INFO', width:50, label:'요약정보2', hidden:true},
				 {name:'THKU_EVNT_PRGRS_STAT_CD',  label:'사은진행상태', align:'center', hidden:true, width:50}],
		editmode:true,			// 그리드 editable 여부
		//gridtitle:'행사목록',	// 그리드명
		formid:'search',		// 조회조건 form id
		shrinkToFit:true,		// width 고정여부
		autowidth:false,         // 컬럼 width 자동조정여부	
		height:410,				// 그리드 높이
		cellEdit:false,
		loadonce : true,
		selecturl:'/pbbs/getBpcm3001List', // 그리드 조회 URL
		events:{
			onCellSelect:function(event, rowid, icol, value) {
				var row = bpcm3001_grid.getRowData(rowid);

				var _evnt_no = row.THKU_EVNT_NO;			               
				bpopup({
				   	  url:"/pbbs/forward.bpcm3001p001.adm"
				   	, params	: {target_id : _menu_id, thku_evnt_no :  _evnt_no}
				   	, title		: "사은행사 요약정보"   
				   	, type		: "s"
				   	, id        : "bpcm3001p1"
				   });
			}
		}
	};
	bpcm3001_grid = new UxGrid(module_config);
	bpcm3001_grid.init();
	
	bpcm3001_grid.setGridWidth($('.board_search').width());

	fn_Init();
	
	$("#bpcm3001_grid").jqGrid("setLabel", "rn", "NO.", {"width":"50"});
	
});

//초기화
function fn_Init(){
    
	fn_getEvtTp(); //이벤트유형
	$("#cbo_evtTp").val(""); 
	
	$("#calStart").val("");      //행사기간
	$("#calEnd").val("");        //행사기간
	$("#txt_evtNm").val("");      //사은명	
	
	bpcm3001_grid.retreive();
}

// 조회 : 내부 로직 사용자 정의
function fn_Search() {
	
	var calStart = $("#calStart").val();      //행사기간
	var calEnd =  $("#calEnd").val();        //행사기간
	
	if ( (calStart != null && calStart != '') && (calEnd != null && calEnd != '') ){
		if ( calStart >  calEnd) {
<%-- 			alert('<%=MessageUtil.getMsg("MSG.EVNT.ALERT.0001")%>'); //시작일자가 종료일자보다 클 수 없습니다. --%>
			return false;
		}
	}
	
	if($("#bpcm3001_grid").jqGrid('getGridParam', 'page') > 1) $("#bpcm3001_grid").jqGrid('setGridParam', {'page':1});
		bpcm3001_grid.retreive();
}

//사은행사 유형 selectbox 생성
function fn_getEvtTp(){
	var html = "";
		
	ajax({
		url 	: "/bpcm/getComnCdList",
		data    : { grp_cd : $("#grp_cd").val() },
		success : function (data) {
			if (data.RESULT == "S") {
				$("#cbo_evtTp option").remove();
				
				var catListCnt = data.rows.length;
				html += "<option value=''>전체</option>"
				$(data.rows).each(function (index) {
					html += "<option value="+ this.THKU_EVNT_MDCLS_CD +">"+ this.THKU_EVNT_MDCLS_NM +"</option>"
					$("#cbo_evtTp").closest('div').show();
				});
				$("#cbo_evtTp").append(html);
			}
		}
	});
}

function checkByte() {
	
    var totalByte = 0;
    var message = $("#txt_evtNm").val();
    var limitByte = 100;
    
    for(var i =0; i < message.length; i++) {
       var currentByte = message.charCodeAt(i);
       if(currentByte > 128) totalByte += 2;
       else totalByte++;
    }

    // 입력된 바이트 수가 limitByet를 초과 할 경우 경고창 
    if(totalByte > limitByte) {
    	$("#txt_evtNm").val(cutByteLength(message,limitByte));	
<%--        alert(limitByte+'<%=MessageUtil.getMsg("MSG.EVNT.ALERT.0002")%>'); //limitByte byte를 초과할 수 없습니다. --%>
       return;
    }
}

function cutByteLength (s, len) {

	if (s == null || s.length == 0) {
		return 0;
	}
	var size = 0;
	var rIndex = s.length;

	for ( var i = 0; i < s.length; i++) {
		size += this.getBytes(s.charAt(i));
		if( size == len ) {
			rIndex = i + 1;
			break;
		} else if( size > len ) {
			rIndex = i;
			break;
		}
	}

	return s.substring(0, rIndex);
}

//byte 체크
function getBytes(str){
    var cnt = 0;
    for(var i =0; i<str.length;i++) {
        cnt += (str.charCodeAt(i) >128) ? 3 : 1;
    }
    return cnt;
}

//그리드 리사이징
$(window).resize(function() {
	bpcm3001_grid.setGridWidth($('.board_search').width());
});

function search_toggle(thisobj) {
	var $this = $(thisobj);
	var search_height = $this.closest(".board_search").find(".search_area").height();
	var grid = $this.closest(".subCon.typeSearch").find(".grid_flow .ui-jqgrid-bdiv");
	var grid_height = $this.closest(".subCon.typeSearch").find(".grid_flow .ui-jqgrid-bdiv").height();

	$this.closest(".board_search").find(".search_area").stop().slideToggle(400);
	$this.toggleClass("on");

	if($this.hasClass("on")) {
		grid.height(grid_height - search_height);
	} else {
		grid.height(grid_height + search_height);
	}

}
</script>
</head>
<body class="bpn_wrap">
<style> 
	#bpcm3001_grid{table-layout:auto;}
	#bpcm3001_grid .jqgrid-rownum{width:50px !important;}
</style>
   <div class="frameWrap">
	   	<div class="subCon typeSearch">
<%-- 	   	<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %> --%>
	   		<div class="subConIn alignCenter">
				<div class="board_search">
					<div class="board_title">
						<h3 class="title">점사은행사</h3>
						<div class="slide_toggle">
							<button type="button" class="on" onclick="search_toggle(this)">
								<img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_search_arrow.png" alt="조회영역 펼침, 닫침">
							</button>
						</div>
					</div>
					<div class="search_area">
					   	<div class="frameTopTable"> 
					   	 		<form name="search" id="search" onsubmit="return false;">			   		
					   			<div class="tbl_wrap">
					   				<table class="tblType1">
							   			<colgroup>
										   <col width="120px" />
										   <col width="398px" />
										   <col width="120px" />
										   <col width="" />
							   			</colgroup>
							   			<tr>
							   				<th>사은행사명</th>
							   				<td>
							   					<span class="txt_pw">
                                                    <input type="text" name="evnt_nm" id="txt_evtNm" class="typeLong" value="" autocomplete="off">
								                 </span>							                   
							   				</td>
							   				<th>행사기간</th>
							   				<td class="typeCal">
												<div class="cals_div">
						                        	<span class="txt_pw"><input class="cal_type2" type="text" id="calStart" name="evnt_st_dt" autocomplete="off"/></span>
						                        	<span class="space">~</span>
						                        	<span class="txt_pw"><input class="cal_type2" type="text" id="calEnd" name="evnt_end_dt" autocomplete="off" /></span>
						                        </div>
							   				</td>
							   				<!-- <td><span class="txt_pw"><input type="text" name="thm_nm" id="thm_nm" class="w100"/></span></td> -->
							   				
							   			</tr>
							   			<tr>
							   				<th>유형</th>
							   				<td>
							   					<span class="txt_pw">
							   					   <input type="hidden" id="grp_cd" name="grp_cd" value="C05600">
								                   <select id = "cbo_evtTp" class="select" name="thku_evnt_mdcls_cd">
								                   </select>
								                 </span>
							   				</td>
							   			</tr>
							   		</table>
					   			</div>
					   			</form>
							   <div class="serarch_btn">
								   <div class="m_btn_wrap">
									<button id ="btn_init" class="m_btn_default">초기화</button>
									<button id ="btn_search" class="m_btn_default full">검색</button>
								</div>
							   </div>
				   		</div>
					</div>
				</div>
		   		<form name="frm_sysCdDtl" id="frm_sysCdDtl" submit="return false;">	   	
		   			<input type="hidden" name="mst_cd_arr" id="mst_cd_arr" />		
			   </form>
			   	<div class="type_board">
			   		<table id="bpcm3001_grid"></table>
			   	</div>
		   		 
		   		<div id="bpcm3001_grid_pager"></div>
		   	</div>
   		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>