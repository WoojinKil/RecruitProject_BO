<%--
   1. 파일명 : pbbs4001
   2. 파일설명: 공지사항
   3. 작성일 : 2020-02-21
   4. 작성자 :
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>
<script type="text/javascript">
var menu_id = _menu_id;
var bpcm4001_grid;
var modl_seq = 15073;
var ctegry_dtl_cd = '<%= parameterMap.getValue("ctegry_dtl_cd") %>';
var page = '<%= parameterMap.getValue("page") %>';
var sch_type_txt;
if(JSON.parse(_param3) != null){
	sch_type_txt = JSON.parse(_param3).sch_type_txt;
}


if(isNotEmpty(parent.bdp_doc_seq)) {
	
	var url = "/pbbs/forward.bpcm4001DTL.adm?modl_seq="+modl_seq+"&doc_seq="+parent.bdp_doc_seq+"&ctegry_dtl_cd="+ctegry_dtl_cd;

    var param3 = {
          doc_seq : parent.bdp_doc_seq,
          modl_seq : modl_seq,
          ctegry_dtl_cd : ctegry_dtl_cd,
          sch_type_txt : $("#txt_titl").val()
          
    }

    parent.addTab(menu_id, "공지사항", url, '' , '' , encodeURIComponent(JSON.stringify(param3)));
}

var obj = {
	    autoUpdateInput : false,
	    showDropdowns: true,
	    /* 날짜/일시 선택 start */
//	     timePicker: true,
	    locale: {
	        format: 'YYYY-MM-DD'
	    }
	    /* 날짜/일시 선택 end */
	};

$(document).ready(function() {

	$("#modl_seq").val(modl_seq);
	$("#ctegry_dtl_cd").val(ctegry_dtl_cd);
	$("#txt_titl").val(""); //공지사항 초기화
	$("#txt_titl").val(sch_type_txt);
	
	$("#txt_titl").keyup(function(){
		checkByte();
    });


    // 조회버튼
    $("#btn_search").click(function() {
		fn_Search();
	});

    _grid_rows = 10;
    _grid_rows_list = [10,50,100];

	// 그리드 초기화
	var module_config = {
		// 그리드, 페이징 ID
		gridid:'bpcm4001_grid',
		pagerid:'bpcm4001_grid_pager',
		// 컬럼 정보
		columns:[{name:'DOC_SEQ', width:50, label:'글번호', align: "left", hidden:true},
		         {name:'NOTC_YN', width:50, label:'공지여부', align: "center", hidden:true},
		         {name:'MODL_NM', width:90, label:'게시판 명', sortable:false, hidden:true},
		         {name:'CTEGRY_DTL_NM', width:90, label:'카테고리', sortable:false, hidden:true},
		         {name:'NOTC_YN', width:50, label:'중요여부', align:'center', sortable:false, hidden:true, editable:false, formatter:'select',edittype:'select', editoptions:{value:'Y:중요;N:일반'}},
		         {name:'TITL', width:280, label:'제목', sortable:false,  align: 'left', 
		                formatter: function(cellValue,options,rowdata,action){
		                    var str ="";
		                    
		                    if(rowdata.NOTC_YN == "Y"){
		                        str ="<span class='board_inf'>중요</span>" +"[" + rowdata.CTEGRY_DTL_NM + "] " + cellValue;
		                    } else {
		                        str = "[" + rowdata.CTEGRY_DTL_NM + "] " +cellValue;
		                    }
		                    return str;
		            }},
		         {name:'DSPLY_STAT', width:50, label:'게시여부', align:'center', sortable:false, hidden:true},
		         {name:'F_CRT_DTTM', width:50, label:'작성일', align: "center", hidden:false},
		         {name:'NEWFLAG', width:50, label:'새글여부', align: "center", hidden:true}],
		editmode:true,			// 그리드 editable 여부
		gridtitle:'',	// 그리드명
		formid:'search',		// 조회조건 form id
		shrinkToFit:true,		// width 고정여부
		autowidth:true,         // 컬럼 width 자동조정여부
		height:500,				// 그리드 높이
		cellEdit:false,
		rownumbers  : false,									// 그리드 로우 넘버 표시 여부
		selecturl:'/bpcm/getBpcm4001List', // 그리드 조회 URL
		events:{
// 			onCellSelect:function(event, rowid, icol, conts) {
// 				var row = bpcm4001_grid.getRowData(rowid);

// 				var obj = $("#bpcm4001_grid");
// 				var id = obj.jqGrid('getCell', rowid, 'DOC_SEQ');
// 				ctegry_dtl_cd = obj.jqGrid('getCell', rowid, 'CTEGRY_DTL_CD');
// 				var url = "/pbbs/forward.bpcm4001DTL.adm?modl_seq="+modl_seq+"&doc_seq="+id+"&ctegry_dtl_cd="+ctegry_dtl_cd+"&page="+$("#bpcm4001_grid").jqGrid('getGridParam', 'page');

// 				var param3 = {
//                       doc_seq : id,
//                       modl_seq : modl_seq,
//                       ctegry_dtl_cd : ctegry_dtl_cd
// 				}

// 				parent.addTab(menu_id, "공지사항", url, '' , '' , encodeURIComponent(JSON.stringify(param3)));

// 			}
			onCellSelect:function(event, rowid, icol, conts) {
				var row = bpcm4001_grid.getRowData(rowid);

				var obj = $("#bpcm4001_grid");
				var id = obj.jqGrid('getCell', rowid, 'DOC_SEQ');

				ctegry_dtl_cd = $("#ctegry_dtl_cd").val();

				var url = "/pbbs/forward.bpcm4001DTL.adm?modl_seq="+modl_seq+"&doc_seq="+id+"&ctegry_dtl_cd="+ctegry_dtl_cd+"&page="+$("#bpcm4001_grid").jqGrid('getGridParam', 'page');

				var param3 = {
                      doc_seq : id,
                      modl_seq : modl_seq,
                      ctegry_dtl_cd : ctegry_dtl_cd,
                      sch_type_txt : $("#txt_titl").val()
                      
				}

				parent.addTab(menu_id, "공지사항", url, '' , '' , encodeURIComponent(JSON.stringify(param3)));

			}
		}
	};
	bpcm4001_grid = new UxGrid(module_config);
	bpcm4001_grid.init();
	bpcm4001_grid.setGridWidth($('.board_search').width());

	//카테고리 조회
	fn_getEvtTp();

	//상세에서 목록으로 이동시 카테고리 조회 세팅하기
	fn_findCtegry();
	
	//게시판 명 검색조건 조회
	getModlNm();
	
	//상세에서 목록으로 이동시 페이지 세팅
	$("#bpcm4001_grid").jqGrid('setGridParam', {'page': page});//파라미터 초기화
	
	bpcm4001_grid.retreive();
	
    // 조회조건 : 작성기간 날짜 초기화
    var today = new Date();
//     $("#sch_st_dt").val(formatDate(today));
    var addMonthDay = addMonth(today);
//     $("#sch_ed_dt").val(formatDate(addMonthDay));

    $("#sch_st_dt").daterangepicker(obj, function(start, end, separator) {

        $("#sch_st_dt").val(start);
        $("#sch_ed_dt").val(end);

    });

    $("#sch_ed_dt").on('click', function () {
         $("#sch_st_dt").trigger('click');
    });
   
});

// 조회 : 내부 로직 사용자 정의
function fn_Search() {
	if($("#bpcm4001_grid").jqGrid('getGridParam', 'page') > 1) $("#bpcm4001_grid").jqGrid('setGridParam', {'page':1});
    bpcm4001_grid.retreive();
}

//조회 : 내부 로직 사용자 정의
function getList(ctegry_dtl_cd) {

	$("#txt_titl").val("");
	$("#ctegry_dtl_cd").val(ctegry_dtl_cd);
	bpcm4001_grid.retreive();
}

//상세에서 목록으로 이동시 카테고리 세팅
function fn_findCtegry(){
	$(".on").removeClass("on");

	var param = ctegry_dtl_cd;
    jQuery('a[ctegry_dtl_cd="'+param+'"]').parent().addClass("on");

}

//카테고리 조회하기
function fn_getEvtTp(){
	
	var html = "";
	
	ajax({
		url 	: "/bpcm/getBoardCtgList",
		data    : { modl_seq : "15073" },
		success : function (data) {
// 			for(var i = 0; i < data.rows.length; i++) {
// 				var dtlNm = "<option value=" + data.rows[i]["CTEGRY_DTL_CD"] + ">" + data.rows[i]["CTEGRY_DTL_NM"] + "</option>";
// 				$("#ctegry_dtl_cd").append(dtlNm);
// 			}
			if (data.RESULT == "S") {

				var catListCnt = data.rows.length;

				html +="<li class='catlistDtl on'>";
				html +="<a href='#' ctegry_dtl_cd='' onclick='getList(); return false;'>전체</a></li>";

				$(data.rows).each(function (index) {
					var str = '\"'+this.CTEGRY_DTL_CD+'\"';

                    var temp = "<li class='catlistDtl'><a href='#' ctegry_dtl_cd="+str+" onclick='getList("+str+"); return false;'>"+this.CTEGRY_DTL_NM+"</a></li>";
                    html += temp;

					$("#catList").closest('div').show();
				});
				$("#catList").append(html);

			    $(".catlistDtl > a").click(function() {
			    	$(".on").removeClass("on");     // a 태그의 클래스 명 test를 삭제
			    	$( this ).parent( "li" ).addClass("on");        // a 태그에 클래스 명 test를 추가
			    });
			}
		}
	});
}

//게시판 명 검색조건 조회
function getModlNm(){
	ajax({
		url 	: "/bpcm/getModlNm",
		data    : { modl_seq : "15073" },
		success : function (data) {
			$("#modl_seq").val(data.rows[0]["MODL_NM"]);
		}
	});
}

function checkByte() {

    var totalByte = 0;
    var message = $("#txt_titl").val();
    var limitByte = 100;

    for(var i =0; i < message.length; i++) {
       var currentByte = message.charCodeAt(i);
       if(currentByte > 128) totalByte += 2;
       else totalByte++;
    }

    // 입력된 바이트 수가 limitByet를 초과 할 경우 경고창
    if(totalByte > limitByte) {
    	$("#txt_titl").val(cutByteLength(message,limitByte));
<%--     	alert(limitByte+'<%=MessageUtil.getMsg("MSG.EVNT.ALERT.0002")%>'); //limitByte byte를 초과할 수 없습니다. --%>
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

// 그리드 리사이징
$(window).resize(function() {
	bpcm4001_grid.setGridWidth($('.board_search').width());
});
</script>
</head>
<body class="">
    <div class="frameWrap">
    	<div class="subCon typeSearch">
	   		<div class="subConIn alignCenter">
				<div class="board_search">
					<div class="board_title">
						<h3 class="title type_notice">공지사항 </h3>
					</div>
				</div>
				<div class="board_tab_area">
				    <form name="search" id="search" onsubmit="return false">
					<div class="board_tab_in">
						<ul class="board_tab_list" id ="catList">
						</ul>

						<div class="tab_search">
							<input type="text" class="board_search" id="txt_titl" name="sch_type_txt" placeholder="검색어 입력" autocomplete="off"  maxlength="250">
							<button id ="btn_search">
								<img src="${pageContext.request.contextPath}/resources/pandora3/images/img_board_search_btn.png" alt="공지사항 조회">
							</button>
						</div>
						<input type="hidden" id="modl_seq" name="modl_seq">
						<input type="hidden" id="ctegry_dtl_cd" name="ctegry_dtl_cd">
					</div>
					</form>
				</div>
				<div class="type_board no_head">
		    		<table id="bpcm4001_grid">
		    		</table>
				</div>
	    		<div id="bpcm4001_grid_pager"></div>
    		</div>
    	</div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>