<%-- 
   1. 파일명 : sample1002
   2. 파일설명 : 정보변경이력
   3. 작성일 : 2019-07-03
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
	$("#search > #clu_tp_cd").val('20');
	
	$('.tblType1').width();
	
	// 공통코드 설정
	$("#mst_cd_arr").val(new Array('MBR0002'));
	
	ajax({
		url		: '/psys/getPsysCommon',
		data	: $("form[name=frm_sysCdDtl]").serialize(),
		success	: function(data) {
			for(i=0; i<data.selectData.length; i++){
				$("#clu_cls_cd").append("<option value='" + data.selectData[i].CD + "'>" + data.selectData[i].CD_NM + "</option> ");
				$("#clu_cls_cd1").append("<option value='" + data.selectData[i].CD + "'>" + data.selectData[i].CD_NM + "</option> ");
				$("#clu_cls_cd2").append("<option value='" + data.selectData[i].CD + "'>" + data.selectData[i].CD_NM + "</option> ");
			}
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
			{name : 'CLU_HST_SEQ', label : '약관이력', hidden : true},
			{name : 'CLU_TP_CD', label : '약관구분코드', hidden : true},									// MBR0001 코드
			{name : 'CLU_TP_CD_NM', label : '사이트', width : 100, align : 'center', sortable : false},	// MBR0001 코드명
			{name : 'CLU_CLS_CD', label : '약관유형코드', hidden : true},									// MBR0002 코드
			{name : 'CLU_CLS_CD_NM', label : '약관명', width : 200, sortable : false,
			 cellattr : function(rowIdx, value, rowJson, colAttr, rowData){
					if(isNotEmpty(rowJson.CLU_CLS_CD_NM))
						return 'style="cursor: pointer; text-decoration: underline;"';
				}
			},
			{name : 'US_YN', label:'사용여부',  width : 150, align:'center', sortable:false, formatter:'select', editoptions:{value:'Y:사용;N:미사용'}},
			{name : 'CRT_DTTM', label:'등록일시', width : 200, align:'center', editable:false, sorttype:"date", formatter : "date", formatoptions : {srcformat : 'U', newformat: "Y-m-d H:i:s"}},
        ],
		editmode	: true,						// 그리드 editable 여부
		gridtitle	: '변경이력',						// 그리드명
		multiselect	: false,							// checkbox 여부
		formid		: 'search',						// 조회조건 form id
		shrinkToFit	: true,							// 컬럼 width 자동조정
		autowidth	: true,
		cellEdit	: false,
		selecturl	: '/psys/getPsys1023List',	// 그리드 조회 URL
		saveurl		: '/sample/saveSample1002',		// 그리드 입력/수정/삭제 URL
		events		: {
			onCellSelect: function(event, rowIdx, colIdx, value){

				if(term_grid.getColName(colIdx) != 'CLU_CLS_CD_NM')
					return;
				
				var row = term_grid.getRowData(1);

				$("#clu_cls_cd1").val(row.CLU_CLS_CD);
				$("#clu_cls_cd2").val(row.CLU_CLS_CD);
				$("#form_termInfo > #clu_tp_cd").val(row.CLU_TP_CD);
				$("#clu_hst_seq").val(row.CLU_HST_SEQ);
				
				if(row.US_YN == 'Y')
					$("input:radio[name='us_yn']")[0].checked = true;	 
				else
					$("input:radio[name='us_yn']")[1].checked = true;

				$("#insert_yn1").val("N");
				$("#clu_seq1").val(row.CLU_SEQ);
				$("#clu_cts1").val(row.CLU_CTS);
				
				$("#insert_yn2").val("N");
				$("#clu_seq2").val(row.CLU_SEQ);
				$("#clu_cts2").val(row.CLU_CTS);
				//term_editor.instances['clu_cts'].setData(row.CLU_CTS);
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
    
	fn_Search();
	
	$("#clu_cts2").attr("disabled",true);
    $("#clu_cls_cd2").attr("disabled",true);
    $("input[name=us_yn2]").attr("disabled",true);
     
	// 라디오버튼 클릭시 이벤트 발생
    $("input:radio[name=radio]").click(function(){
 
        if($("input[name=radio]:checked").val() == "Y"){
            $("#clu_cts2").attr("disabled",true);
            $("#clu_cls_cd2").attr("disabled",true);
            $("input[name=us_yn2]").attr("disabled",true);
            
            $("#clu_cts").attr("disabled",false);
            $("#clu_cls_cd").attr("disabled",false);
            $("input[name=us_yn]").attr("disabled",false);
        }else if($("input[name=radio]:checked").val() == "N"){
            $("#clu_cts").attr("disabled",true);
            $("#clu_cls_cd").attr("disabled",true);
            $("input[name=us_yn]").attr("disabled",true);
            
            $("#clu_cts2").attr("disabled",false);
            $("#clu_cls_cd2").attr("disabled",false);
            $("input[name=us_yn2]").attr("disabled",false);
        }
    });
	
});

// grid resizing
$(window).resize(function() {
	term_grid.setGridWidth($('.tblType1').width());
});

// 조회 : 내부 로직 사용자 정의
function fn_Search(){
	
    // 데이터 조회
    term_grid.retreive(); // {success:function(){alert('retreive success');}}
}

// 추가 : 내부 로직 사용자 정의
function fn_AddRow() {
}

// 저장 : 내부 로직 사용자 정의
function fn_Save() {
	var data = $("form[name=form_termInfo]").serialize();

	if($("input[name=radio]:checked").val() == "N"){
		data = $("form[name=form_termInfo2]").serialize();
	}
	
	ajax({
		url: '/sample/saveSample1002.adm',
		data : data,
		async : false,
		success: function(data) {
			if(data.RESULT == "S") {
				alert('저장되었습니다');
				fn_Search();
				$("#clu_seq").val("");
				$("#clu_cts").val("");
				
			} else {
				alert("일시적 오류입니다\n잠시후 다시 시도하세요.")
				e.preventDefault();
				return;
			}
		},
	});
	
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
}

</script>
</head>
<style>
.sampleWrap:after{content:""; display:block; clear:both;}
.sampleWrap .sample1{float:left; width: 47%; margin-top:10px;}
.sampleWrap .sample2{float:left; width: 47%; margin-top:10px;}
</style>
<body>
	<div class="frameWrap">
		<div class="subCon">
			<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp"%>
			<form name="search" id="search" onsubmit="return false">
				<input type="hidden" id="ds_mst_cd" name="ds_mst_cd" value="" />
				<input type="hidden" id="tp_mst_cd" name="tp_mst_cd" value="" />
				<input type="hidden" id="clu_tp_cd" name="clu_tp_cd" value="" />
			</form>
			<br/>
			<div >
				<form name="form_termInfo1" id="form_termInfo1" onsubmit="return false">
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
									<select name="clu_cls_cd" id="clu_cls_cd1" class="select" disabled="true">
									</select>
								</span>
							</td>
							<th>사용여부</th>
							<td>
								<div class="radio">
									<span class="txt_pw"><input name="us_yn1" id="use_y" type="radio" value="Y" checked="checked" disabled="true"><label for="use_y">사용</label></span>
									<span class="txt_pw"><input name="us_yn1" id="use_n" type="radio" value="N"><label for="use_n" disabled="true">미사용</label></span>
								</div>
							</td>
						</tr>
						<tr >
							<th><span class="vv">상세내용</span>
							<td colspan="3"><textarea name="clu_cts" id="clu_cts1" disabled="true" style="width:100%" rows="3"></textarea></td>
						</tr>
					</table>
				</form>
			</div>
			<div class="sampleWrap">
			<div class="sample1">
				<input type="radio" name="radio" value="Y" checked="checked" /> 추가
				<form name="form_termInfo" id="form_termInfo" onsubmit="return false">
					<input type="hidden" id="clu_seq" name="clu_seq" value="1" />
					<input type="hidden" id="clu_tp_cd" name="clu_tp_cd" value="" />
					<input type="hidden" id="insert_yn" name="insert_yn" value="Y" />
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
									<select name="clu_cls_cd" id="clu_cls_cd" class="select" >
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
						<tr>
							<th><span class="vv">상세내용</span>
							<td colspan="3"><textarea name="clu_cts" id="clu_cts" style="width:100%" rows="3"></textarea></td>
						</tr>
					</table>
				</form>
				</div>
				<div class="sample2">
				<input type="radio" name="radio" value="N" /> 변경
				<form name="form_termInfo2" id="form_termInfo2" onsubmit="return false">
					<input type="hidden" id="clu_seq" name="clu_seq" value="1" />
					<input type="hidden" id="clu_tp_cd" name="clu_tp_cd" value="" />
					<input type="hidden" id="clu_hst_seq" name="clu_hst_seq" value="" />					
					<input type="hidden" id="insert_yn" name="insert_yn" value="N" />
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
									<select name="clu_cls_cd" id="clu_cls_cd2" class="select" >
									</select>
								</span>
							</td>
							<th>사용여부</th>
							<td>
								<div class="radio">
									<span class="txt_pw"><input name="us_yn2" id="use_y" type="radio" value="Y" checked="checked"><label for="use_y">사용</label></span>
									<span class="txt_pw"><input name="us_yn2" id="use_n" type="radio" value="N"><label for="use_n">미사용</label></span>
								</div>
							</td>
						</tr>
						<tr>
							<th><span class="vv">상세내용</span>
							<td colspan="3"><textarea name="clu_cts" id="clu_cts2" style="width:100%" rows="3"></textarea></td>
						</tr>
					</table>
				</form>
				</div>
			</div>
			</br>
			<table id="term_grid"></table>
			<div id="term_grid_pager"></div>
		</div>
	</div>
	<form name="frm_sysCdDtl" id="frm_sysCdDtl" submit="return false;">
		<input type="hidden" name="mst_cd_arr" id="mst_cd_arr" />
	</form>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
