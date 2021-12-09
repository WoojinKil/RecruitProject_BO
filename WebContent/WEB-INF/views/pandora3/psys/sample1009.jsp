<%-- 
    개요 : BO 프로그램관리
    수정사항 :
        2018-03-30 최초작성
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>
<script type="text/javascript">
var pgm_grid;

$(document).ready(function(){
	
	// 공통코드 복수 설정
	$("#mst_cd_arr").val(new Array( 'SYS002', 'SYS001'))
	ajax({
		url: '/psys/getPsysCommon.adm',
		data : $("form[name=frm_sysCdDtl]").serialize(),
		success: function(data) {
			makeData(data.selectData);
		},
	});
	
    var pgm_config = { 
        gridid    : 'pgm_grid',	    	// 그리드 id
        pagerid   : 'pgm_grid_pager',	// 그리드 페이지 id
        gridBtnYn : 'Y',				// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        // column info
        columns   : [{name:'SYS_CD', label:'시스템코드',editable:false,hidden:true },
             	     {name:'SYS_NM', label:'시스템명',editable:false},
        	 	     {name:'PGM_ID', label:'프로그램ID',editable:false},
        	 	     {name:'PGM_NM', label:'프로그램명',editable:false},
        	 	     {name:'TRG_URL', label:'URL',editable:false},
        	 	     {name:'BTN_SCH',label:'조회', align:'center',formatter:'checkbox'},
        	 	     {name:'BTN_ADD',label:'추가', align:'center',formatter:'checkbox'},
			  	     {name:'BTN_SV', label:'저장',align:'center',formatter:'checkbox'},
			  	     {name:'BTN_DEL', label:'삭제', align:'center',formatter:'checkbox'},
			  	     {name:'BTN_XLS_DOWNLOAD', label:'엑셀다운로드', align:'center',formatter:'checkbox'},
			  	     {name:'BTN_XLS_UPLOAD', label:'엑셀업로드', align:'center',formatter:'checkbox'},
			 	     {name:'BTN_PRN', label:'인쇄', align:'center',formatter:'checkbox'}, 
			 	     {name:'BTN_APV', label:'승인', align:'center',formatter:'checkbox'},
			 	     {name:'BTN_HCO', label:'도움말', align:'center',formatter:'checkbox'},
			 	     {name:'BTN_NEW', label:'신규', align:'center',formatter:'checkbox'},
			 	     {name:'BTN_ADDROW', label:'행추가', align:'center',formatter:'checkbox'},
			 	     {name:'BTN_DELROW', label:'행삭제', align:'center',formatter:'checkbox'},
			 	     {name:'US_YN', label:'사용여부', align:'center'},
			 	     {name:'PGM_DESC', label:'프로그램설명', align:'left'},
			 	     {name:'BTN_INF', label:'버튼정보', align:'left', hidden:true}
		             ],          
        editmode    : true,                                  // 그리드 editable 여부
        gridtitle   : '프로그램 목록',                           // 그리드명
        multiselect : false,                                 // checkbox 여부
        formid      : 'search',                              // 조회조건 form id
        height      : 200,                                   // 그리드 높이
        shrinkToFit : true,                                  // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl   : '/psys/getPsys1001List',           	 // 그리드 조회 URL
        events      : {
	                       onSelectRow: function(event, rowid) {
	                           var row = pgm_grid.getRowData(rowid);
	                       },
	                       onCellSelect: function(event, rowid, icol) {        // 해당 셀 선택시
	                           var row = pgm_grid.getRowData(rowid);
	                           fn_detailPgmInfo(row);
	                       }
       }
    };
    
      
    pgm_grid = new UxGrid(pgm_config);
    pgm_grid.init();
    pgm_grid.setGridWidth($('.tblType1').width());
    
    $("#btn_pgm_add").click(function() {
    	pgm_grid.add({APLY_START_DATE:$.timestampToString(new Date())});
    });
    
    $("#btn_pgm_del").click(function() {
    	pgm_grid.remove();
    });    
    
});

// 신규버튼 클릭 시
function fn_New(){
	$('#pgmInfoForm1').clearFormData();
	$("#pgm_id").prop("readonly", false);
}

//grid resizing
$(window).resize(function() {
	pgm_grid.setGridWidth($('.tblType1').width());
});

// 공통코드 조회 후 selectBox 및 checkBox 데이터 세팅
function makeData(sysCdDtlMap) {
	var index=1;
	var spnBtn = $('#btnInfo');
	for(i=0; i<sysCdDtlMap.length; i++) {
		if("SYS001" == sysCdDtlMap[i].MST_CD) {
			/* spnBtn.append('<input type="checkbox" name="btnInfo"  id=btnInfo'+(index) +' value="'+ sysCdDtlMap[i].CD+'"/><label for=btnInfo'+(index)+'>'+ sysCdDtlMap[i].CD_NM+'</label>'); */
			spnBtn.append('<div class="tableCheck"><label class="container typeInspect">'+ sysCdDtlMap[i].CD_NM+'<input type="checkbox" name="btnInfo"  id=btnInfo'+(index) +' value="'+ sysCdDtlMap[i].CD+'"/><span class="checkmark"></span></label></div>');
			index++;
		}
		if("SYS002"==sysCdDtlMap[i].MST_CD){
			$("#sys_cd").append("<option value='" + sysCdDtlMap[i].CD+ "'>" + sysCdDtlMap[i].CD_NM + "</option> ");
			$("#srch_sys_cd").append("<option value='" + sysCdDtlMap[i].CD+ "'>" + sysCdDtlMap[i].CD_NM + "</option> ");
		}
	}
}

// 그리드 셀 클릭 시 하단 상세정보 세팅
function fn_detailPgmInfo(rowInfo){
	
	$("#sys_cd").val(rowInfo.SYS_CD);
	$("#pgm_id").val(rowInfo.PGM_ID);
	$("#pgm_nm").val(rowInfo.PGM_NM);
	$("#trg_url").val(rowInfo.TRG_URL);
	$("#us_yn").val(rowInfo.US_YN);
	$("#pgm_desc").val(rowInfo.PGM_DESC);
	$("#reg_type").val("U");
	$("#pgm_id").prop("readonly",true);
	
	var btnInf  = rowInfo.BTN_INF;
	
	// 버튼정보 세팅
	$("input:checkbox[name=btnInfo]").prop("checked",false);
	
	var cnt = $("input:checkbox[name=btnInfo]").length;
	for(var i =0; i < cnt; i++){
		var objBtnInfo = $('#btnInfo'+(i+1));
		var val        = objBtnInfo.val();
		if(btnInf.indexOf(val)>=0){
			objBtnInfo.prop("checked", true);
		}
	}
}

//조회: 내부 로직 사용자 정의
function fn_Search(){
	$('#pgmInfoForm1').clearFormData();
	pgm_grid.retreive(); 
}

//저장: 내부 로직 사용자 정의
function fn_Save(){
	
	// 입력 값 필수 체크
	if(!validChk($("#pgmInfoForm1")))	return false;	
	
	ajax({
   		url: '/psys/savePsys1001',
   		data : $("form[name=pgmInfoForm1]").serialize(),
   		async : false,
   		success: function(data) {
   			
   			if(data.RESULT == "S") {
   				alert('저장되었습니다');	
   				$('#pgmInfoForm1').clearFormData();
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

//프린트: 내부 로직 사용자 정의
function fn_Print(){
  //   var data = makePrintXmlData()
	var param  = makePrintJsonData();    
	var filenm = "/resources/pandora3/ireport/pgm_info_report_xml.jasper";
	var url    = "/pandora3/print/print_json.jsp";
	var form   = document.getElementById("printForm");
	document.getElementById("data").value   = param;
	document.getElementById("filenm").value = filenm;
	window.open('', 'printviewer', 'width=1024px,height=768px');
	form.action = url;
	form.target = "printviewer";
	form.method = "post";
	form.submit();
}

//엑셀다운로드: 내부 로직 사용자 정의
function fn_ExcelDownload(){
	var grid_id = "pgm_grid";
	var rows    = $('#pgm_grid').jqGrid('getGridParam', 'records');
	var page    = $('#pgm_grid').jqGrid('getGridParam', 'page');
	var total   = $('#pgm_grid').jqGrid('getGridParam', 'total');
	var title   = $('#pgm_grid').jqGrid('getGridParam', 'gridtitle');
	var url     = "/psys/getPsys1001ExcelDownload";  //페이징 존재
	var param          = {};
	    param.page     = page;
	    param.rows     = rows;
	    param.filename = "프로그램 목록";
	AdvencedExcelDownload(grid_id, url, param);
}

function makePrintXmlData (){
	var xmlInfo ="";
	xmlInfo = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
	xmlInfo += "<PrintList>";
	var rowIds = pgm_grid.getDataIDs();
	var printList = []; // 삽입, 갱신할 열 배열
	for(var i = 0; i < rowIds.length; i++) {
		var row = pgm_grid.getRowData(rowIds[i]);
		xmlInfo += "<PrintInfo>";
		xmlInfo+="<sys_nm>"+ row.SYS_NM+"</sys_nm> ";
		xmlInfo+="<pgm_id>"+ row.PGM_ID+"</pgm_id> ";
		xmlInfo+="<pgm_nm>"+ row.PGM_NM+"</pgm_nm> ";
		xmlInfo+="<trg_url>"+ row.TRG_URL+"</trg_url> ";
		 xmlInfo += "</PrintInfo>";
	}
	xmlInfo += "</PrintList>";
 
	return xmlInfo;
};
 
function makePrintJsonData (){
	var rowIds = pgm_grid.getDataIDs();
	var printList = []; // 삽입, 갱신할 열 배열
	for(var i = 0; i < rowIds.length; i++) {
		var row = pgm_grid.getRowData(rowIds[i]);
		printList.push(row);
	}
	return 	JSON.stringify(printList);
};

</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
		<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>	
			<!-- search -->	
			<!-- <form name="search" id="search" onsubmit="return false">
			<table class="tblType1 mB60">
				<colgroup>
					<col width="13%" />
					<col width="30.5%" />
					<col width="13%" />
					<col width="30.5%" />
					<col width="13%" />
				</colgroup>
				<tr>
					<th>시스템구분</th>
					<td><select id="srch_sys_cd" name="srch_sys_cd" class="select"><option value=""  selected="selected">전체</option></select></td>
					<th>프로그램명</th>
					<td colspan="2"><span class="txt_pw"><input type="text" name="srch_pgm_nm" id="srch_pgm_nm" class="w100"/></span></td>
				</tr>
			</table>
			table class="tblType3">
				<tr>
					<td>
						<div class="grid_btn">
						<button class="btn_common btn_darkGray" id="btn_pgm_add">추가</button>
						<button class="btn_common btn_darkGray" id="btn_pgm_del">삭제</button>
						</div>
					</td>
				</tr>
			</table
			</form> -->
			
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
								<th><span>시스템구분</span></th>
								<td><select id="srch_sys_cd" name="srch_sys_cd" class="select"><option value=""  selected="selected">전체</option></select></td>
								<th>프로그램명</th>
								<td><span class="txt_pw"><input type="text" name="srch_pgm_nm" id="srch_pgm_nm" /></span></td>
							</tr>
						</tbody>
		            </table>
		       </form>
			</div>
			<div class="bgBorder"></div>
			<!-- search // -->
			
			<!-- Grid -->
			<table id="pgm_grid"></table>
			<div id="pgm_grid_pager"></div>
			<!-- Grid // -->
			
			<div class="bgBorder"></div>
			<!-- form -->
			<form name="pgmInfoForm1" id="pgmInfoForm1"  method="post">
			<input type="hidden" id="reg_type" name="reg_type"  />
			<table class="tblType1 mT60">
				<!-- <colgroup>
					<col width="15%" />
					<col width="35%" />
					<col width="15%" />
					<col width="35%" />
				</colgroup> -->
				<colgroup>
					<col style="width: 117px;">
					<col style="width: ">
					<col style="width: ">
					<col style="width: 117px;">
					<col style="width: ">
					<col style="width: ">
				</colgroup>
				<tr>
					<th>
						<label for="sys_cd" class="vv necessary">시스템명</label>
					</th>
					<td colspan="4"><span class="txt_pw"><select id="sys_cd" name="sys_cd" class="select"><option value="">선택</option></select></span></td>
					<td class="noBor"></td>
				</tr>
				<tr>
					<th>
						<label for="pgm_id" class="vv necessary">프로그램ID</label>
					</th>
					<td>
						<span class="txt_pw"><input type="text" name="pgm_id" id="pgm_id" value="" class="w100" maxlength="15"/></span>
					</td>
					<td class="noBor"></td>
					<th>
						<label for="pgm_nm" class="vv necessary">프로그램명</label>
					</th>
					<td>
						<span class="txt_pw"><input type="text" name="pgm_nm" id="pgm_nm" value="" class="w100" maxlength="300"/></span>
					</td>
					<td class="noBor"></td>
				</tr>
				<tr>
					<th>
						<label for="trg_url" class="vv necessary">url</label>
					</th>
					<td>
						<span class="txt_pw"><input type="text" name="trg_url" id="trg_url" value="" class="w100" maxlength="500"/></span>
					</td>
					<td class="noBor"></td>
					<th>
						<label for="us_yn" class="vv necessary">사용여부</label>
					</th>
					<td>
						<span class="txt_pw"><select class="select" name="us_yn" id="us_yn"><option value="Y">사용</option><option value="N">미사용</option></select></span>
					</td>
					<td class="noBor"></td>
				</tr>
				<tr>
					<th>
						<label for="pgm_desc" class="vv necessary">프로그램설명</label>
					</th>
					<td colspan="4">
						<span class="txt_pw"><input type="text" name="pgm_desc" id="pgm_desc" value="" class="w100" maxlength="20"/></span>
					</td>
					<td class="noBor"></td>
				</tr>
				<tr>
					<th>
						<label class="vv necessary">버튼정보</label>
					</th>
					<td colspan="4">
						<span id="btnInfo"></span>
					</td>
					<td class="noBor"></td>
				</tr>
				</table>
			</form>
			<!-- form// -->
	        <div class="bottomBtnWrap">
				<button type="button" class="btn_common btn_gray">이전</button>
				<button type="button" class="btn_common btn_dark">저장</button>
			</div>
		</div>
		<form name="frm_sysCdDtl" id="frm_sysCdDtl" submit="return false;">
		<input type="hidden" name="mst_cd_arr" id="mst_cd_arr" />
	</form>
	<form id="printForm">
		  <input type="hidden" id="data" name="data" />
		  <input type="hidden" id="filenm" name="filenm" />
	</form>	
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>
