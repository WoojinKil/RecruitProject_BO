<%-- 
   1. 파일명 : psys1015
   2. 파일설명 : 가입약관관리
   3. 작성일 : 2018-04-16
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">

var term_grid;
var term_editor;
var editor_setting;

var save_clu_cls_cd = "";

$(document).ready(function(){
	
	$("#ds_mst_cd").val('MBR0002');
	$("#tp_mst_cd").val('MBR0001');
	$("#search > #clu_tp_cd").val('10');
	
	$('.tblType1').width();
	
	// 공통코드 설정
	$("#mst_cd_arr").val(new Array('MBR0002'));
	
	ajax({
		url		: '/psys/getPsysCommon',
		data	: $("form[name=frm_sysCdDtl]").serialize(),
		success	: function(data) {
			for(i=0; i<data.selectData.length; i++)
				$("#clu_cls_cd").append("<option value='" + data.selectData[i].CD + "'>" + data.selectData[i].CD_NM + "</option> ");
		}
	});

	$("#btn_term_save").hide();
	$("#btn_term_edit").hide();
	
	var grid_config = { 
		gridid	: 'term_grid',
		pagerid	: '',
		columns	:[
			{name : 'CLU_SEQ', label : '약관순번', hidden : true},
			{name : 'CLU_CTS', label : '약관내용', hidden : true},
			{name : 'CLU_TP_CD', label : '약관구분코드', hidden : true},									// MBR0001 코드
			{name : 'CLU_TP_CD_NM', label : '사이트', /* width : 100, */ align : 'center', sortable : false, hidden : true},	// MBR0001 코드명
			{name : 'CLU_CLS_CD', label : '약관유형코드', hidden : true},									// MBR0002 코드
			{name : 'CLU_CLS_CD_NM', label : '약관명', /* width : 200, */ sortable : false,
			 cellattr : function(rowIdx, value, rowJson, colAttr, rowData){
					if(isNotEmpty(rowJson.CLU_CLS_CD_NM))
						return 'style="cursor: pointer; text-decoration: underline;"';
				}
			},
			{name : 'US_YN', label:'사용여부',  /* width : 150, */ align:'center', sortable:false, formatter:'select', editoptions:{value:'Y:사용;N:미사용'}},
			{name : 'CRT_DTTM', label:'등록일시', /* width : 200, */ align:'center', editable:false, sorttype:"date", formatter : "date", formatoptions : {srcformat : 'U', newformat: "Y-m-d H:i:s"}},
        ],
		editmode	: true,						// 그리드 editable 여부
		gridtitle	: '약관 목록',						// 그리드명
		multiselect	: false,							// checkbox 여부
		formid		: 'search',						// 조회조건 form id
		shrinkToFit	: true,							// 컬럼 width 자동조정
		autowidth	: true,
		height		: 200,							// 그리드 높이
		cellEdit	: false,
		selecturl	: '/psys/getPsys1015List',	// 그리드 조회 URL
		saveurl		: '/psys/savePsys1005',		// 그리드 입력/수정/삭제 URL
		events		: {
			onCellSelect: function(event, rowIdx, colIdx, value){

				if(term_grid.getColName(colIdx) != 'CLU_CLS_CD_NM')
					return;
				
				$("#table_bottom").show();
				
				var row = term_grid.getRowData(rowIdx);

				$("#clu_cls_cd").val(row.CLU_CLS_CD);
				$("#form_termInfo > #clu_tp_cd").val(row.CLU_TP_CD);
				
				if(row.US_YN == 'Y')
					$("input:radio[name='us_yn']")[0].checked = true;	 
				else
					$("input:radio[name='us_yn']")[1].checked = true;
				

				// 메모리 누수 현상으로 인해 추가 (구글링 하니 해당 문제가 고쳐진 새로운 버전이 있는 것으로 확인 되지만...)
				if(term_editor.instances['clu_cts'])
					term_editor.instances['clu_cts'].destroy(true);
				term_editor.replace('clu_cts', editor_setting);

				if(row.CLU_SEQ!='0')
				{
					$("#insert_yn").val("N");
					$("#clu_seq").val(row.CLU_SEQ);
					
					$("#btn_term_save").hide();
					$("#btn_term_mod").show();
					term_editor.instances['clu_cts'].setData(row.CLU_CTS);
				}
				else
				{
					$("#insert_yn").val("Y");
					$("#clu_seq").val("");
					
					$("#btn_term_save").show();
					$("#btn_term_mod").hide();
					term_editor.instances['clu_cts'].setData("");
				}
			},
			gridComplete : function() { // 그리드가 조회되면서 첫번째 로우 선택
				
				if($('#term_grid').jqGrid('getGridParam', 'records') > 0)
				{
					if(isEmpty(save_clu_cls_cd))
						term_grid.setCellFocus(1, 2); // 첫번째 행 선택
					else
					{
						// 저장 후 재조회 인 경우
						var idx = term_grid.getRowIndexByValue("CLU_CLS_CD", save_clu_cls_cd);
						
						if(idx.length < 1)
							term_grid.setCellFocus(1, 2); // 첫번째 행 선택
						else
							term_grid.setCellFocus(idx[0], 2); // 저장된 행 선택
							
						save_clu_cls_cd = "";
					}
				}
			},
		},
	};
    
    term_grid = new UxGrid(grid_config);
    term_grid.init();
    term_grid.setGridWidth($('.tblType1').width());

	$("#form_termInfo").submit(function(e){

		if(fn_validationCheck())
		{
			$("#clu_cts").val(term_editor.instances['clu_cts'].getData());
			
			var data = new FormData($(this)[0]);

			$.ajax({
				url			: _context + '/psys/savePsys1015',
				type		: 'POST',
				data		: data,
				mimeType	: "multipart/form-data",
				contentType	: false,
				cache		: false,
				processData	: false,
				success		: function(data){
					
					data = JSON.parse(data);
					
					if(data.RESULT == "S")
					{
						alert('저장되었습니다');	
						$("#btn_search").trigger('click');
					}
					else
					{
						alert("일시적 오류입니다\n잠시후 다시 시도하세요.")
					}
				}
			});
		}
		e.preventDefault(); //Prevent Default action. 
   	});
    
	// CKEDITOR 세팅
	term_editor = CKEDITOR;
	
	editor_setting = {	// 해당 이름으로 된 textarea에 에디터를 적용
			width		: '100%',
			height		: '165px',
//	 		readOnly	: true,					// 에디터 읽기 전용 설정 (조회 후 해제)
//			enterMode	: CKEDITOR.ENTER_BR,
			filebrowserImageUploadUrl : _context +'/board/updateImageUpload.adm' //여기 경로로 파일을 전달하여 업로드 시킨다.
	};
	
	term_editor.replace('clu_cts', editor_setting);

	term_editor.on('dialogDefinition', function(ev){
		var dialogName = ev.data.name;
		var dialogDefinition = ev.data.definition;
      
		switch (dialogName)
		{
			case 'image' : //Image Properties dialog
				dialogDefinition.removeContents('Link');
				dialogDefinition.removeContents('advanced');
				
				// console.log(dialogDefinition);
				
				var infoTab = dialogDefinition.getContents( 'info' )
				infoTab.remove('txtHSpace'); //info 탭 내에 불필요한 엘레멘트들 제거
				infoTab.remove('txtVSpace');
				infoTab.remove('txtBorder');
				infoTab.remove('txtWidth');
				infoTab.remove('txtHeight');
				infoTab.remove('ratioLock');
				
				// console.log(infoTab);	
				break;
		}
	});

});

// Submit form
function fn_submitForm(action)
{
	$("#clu_cls_cd").prop("disabled", false);
	$("#form_termInfo").submit();
	$("#clu_cls_cd").prop("disabled", true);
	
	save_clu_cls_cd = $("#clu_cls_cd").val();
}

// grid resizing
$(window).resize(function() {
	term_grid.setGridWidth($('.tblType1').width());
});

// Input Form 유효성
function fn_validationCheck()
{
	var contents = term_editor.instances['clu_cts'].getData();

	if(isEmpty(contents))
	{
		alert("상세내용을 입력해주세요.");
		
		term_editor.on('instanceReady', function(event){
			term_editor.instances.clu_cts.focus();
		});
		
		term_editor.instances.clu_cts.focus();
		
		return false;
	}
	
	return true;
}

// 조회 : 내부 로직 사용자 정의
function fn_Search(){
	 
    // 하단 INPUT TEXT 초기화
   
    // 하단 Editor 영역 내용 초기화
    term_editor.instances['clu_cts'].setData("");
    
    // 버튼 숨김
    $("#btn_term_mod").hide();
    $("#btn_term_save").hide();
    
    // 하단 상세 영역 숨김
    $("#table_bottom").hide();
    
    // 데이터 조회
    term_grid.retreive(); // {success:function(){alert('retreive success');}}
}

// 추가 : 내부 로직 사용자 정의
function fn_AddRow() {
}

// 저장 : 내부 로직 사용자 정의
function fn_Save() {
}

// 삭제 : 내부 로직 사용자 정의
function fn_DelRow() {
//	term_grid.remove(); // {success:function(){alert('remove success');}}
}

// 프린트 : 내부 로직 사용자 정의
function fn_Print(){
}

// 엑셀다운로드 : 내부 로직 사용자 정의
function fn_ExcelDownload(){
	var grid_id	= "term_grid";
	var rows	= $('#term_grid').jqGrid('getGridParam', 'rowNum');
	var title	= $('#term_grid').jqGrid('getGridParam', 'gridtitle');
	var url		= "/psys/getPsys1015XlsxDwld";
	var param	= {};

	param.fileName	= "시스템 가입약관 목록";
	param.rows		= rows;
	
	AdvencedExcelDownload(grid_id, url, param);
}

</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
			<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp"%>
			<form name="search" id="search" onsubmit="return false">
				<input type="hidden" id="ds_mst_cd" name="ds_mst_cd" value="" />
				<input type="hidden" id="tp_mst_cd" name="tp_mst_cd" value="" />
				<input type="hidden" id="clu_tp_cd" name="clu_tp_cd" value="" />
				<table class="tblType1 mB60">
					<colgroup>
						<col width="15%" />
						<col width="85%" />
					</colgroup>
					<tr>
						<th>약관명</th>
						<td><span class="txt_pw"><input type="text" name="sch_cd_nm" id="sch_cd_nm" class="w45" /></span></td>
					</tr>
				</table>
			</form>
			<br/>
			
			<table id="term_grid"></table>
			<div id="term_grid_pager"></div>

			<div class="table_bottom mT60">
				<form name="form_termInfo" id="form_termInfo" onsubmit="return false">
					<input type="hidden" id="clu_seq" name="clu_seq" value="" />
					<input type="hidden" id="clu_tp_cd" name="clu_tp_cd" value="" />
					<input type="hidden" id="insert_yn" name="insert_yn" value="" />
					<div class="gd_row">
						<div class="tableBtnWrap">
							<p class="tableTitle">약관 상세</p>
							<div class="tableBtn">
								<a href="javascript:fn_submitForm();" class="btn_common btn_default" id="btn_term_save" style="display: none;">등록</a>
								<a href="javascript:fn_submitForm();" class="btn_common btn_default" id="btn_term_mod" style="display: none;">수정</a>
							</div>
						</div>
					</div>
					<table class="tblType1">
						<colgroup>
							<col width="15%" />
							<col width="35%" />
							<col width="15%" />
							<col width="35%" />
						</colgroup>
						<tr>
							<th>약관명</th>
							<td>
								<span class="txt_pw">
									<select name="clu_cls_cd" id="clu_cls_cd" class="select" disabled="true">
									</select>
								</span>
							</td>
							<th>사용여부</th>
							<td>
								<div class="radio">
									<span class="txt_pw"><input name="us_yn" id="use_y" type="radio" value="Y" checked="checked"><label for="use_y">사용</label></span>
									<span class="txt_pw"><input name="us_yn" id="use_n" type="radio" value="N"><label for="use_n">미사용</label></span>
								</div>
							</td>
						</tr>
						<tr style="height:280px">
							<th><span class="vv">상세내용</span>
							<td colspan="3"><textarea name="clu_cts" id="clu_cts"></textarea></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	<form name="frm_sysCdDtl" id="frm_sysCdDtl" submit="return false;">
		<input type="hidden" name="mst_cd_arr" id="mst_cd_arr" />
	</form>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
