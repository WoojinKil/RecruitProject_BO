<%-- 
   1. 파일명 : psys1025
   2. 파일설명 : 공통팝업관리
   3. 작성일 : 2019-01-28
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3Front/js/common/jquery.bpopup.min.js"></script>
<style>
.layer_popup {background-color:#fff;border-radius:0;border:1px solid #000;color:#000;display:none;padding:0px;min-width:400px;min-height: 180px}
.layer_popup .btn_close{cursor:pointer;position:absolute;right:10px;top:5px}
</style>
<script type="text/javascript">
var menu_id = '<%=parameterMap.getValue("_menu_id")%>';
var comPopup_grid;
var msg = "";
$(document).ready(function(){
	
	var comPopup_config = { 
		gridid    : 'comPopup_grid',	    // 그리드 id
        pagerid   : 'comPopup_grid_pager',	// 그리드 페이지 id
        gridBtnYn : 'Y',					// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
		// column info
		columns   : [
				      {name:'CRT_DTTM'   , hidden:true},
				      {name:'POPUP_ID'   , label:'팝업코드', width:50, align:'center'},
				      {name:'POPUP_NM'   , label:'팝업명' , width:50},
				      {name:'US_YN'      , label:'사용여부', align:'center', editable:true, edittype:'select', formatter:'select', editoptions:{value:'Y:사용;N:미사용'}, width:20, required:true},
				      {name:'POPUP_DESC' , hidden:true},
				      {name:'GRD_CONF'   , hidden:true},
				      {name:'SCH_SYNX'   , hidden:true},
				      {name:'FROM_SYNX'  , hidden:true},
				      {name:'WHERE_SYNX' , hidden:true},
				      {name:'WHERE_ADD'  , hidden:true},
				      {name:'SRT_SYNX'   , hidden:true},
				      {name:'SCH_BOX'    , hidden:true},
				      {name:'POPUP_WDT'  , hidden:true},
				      {name:'POPUP_HGT'  , hidden:true},
				      {name:'PG_YN'      , hidden:true},
				      {name:'USR_NM'     , hidden:true}
		             ],
		gridtitle   : '팝업관리',                                     // 그리드명
		formid      : 'search',                                    // 조회조건 form id
		shrinkToFit : true,                                        // 컬럼 width 자동조정
		autowidth   : true,
		/* height      : 600,   */                                       // 그리드 높이
		cellEdit    : false,
		selecturl   : '/psys/getPsys1025List',                 // 그리드 조회 URL
		events: {
			gridComplete : function() { // 그리드가 조회되면서 첫번째 로우 선택
				var grid = $("#comPopup_grid"),
			    ids = grid.jqGrid("getDataIDs");
			    if(ids && ids.length > 0){
			        grid.jqGrid("setSelection", ids[0]);
			    }
			},			
            onSelectRow: function(event, rowid) { // 그리드 선택시 이벤트 발생
                var row = comPopup_grid.getRowData(rowid);
                // 데이터 셋팅
                fn_detailPopupInfo(row);
            }
		}
	};
	
	comPopup_grid = new UxGrid(comPopup_config);
	comPopup_grid.init();
	comPopup_grid.setGridWidth($(".frameTopTable").width()*(49/100));
	
	//팝업사이즈 default값
	$("#popup_wdt").val('500');
	$("#popup_hgt").val('500');
	$("#reg_type").val("I");
	
	// 미리보기 버튼 클릭 시
	$("#btn_prev").click(function() {
		var popupId   = $("#popup_id").val();
		var popupNm   = $("#popup_nm").val();
		var popupWdt  = $("#popup_wdt").val();
		var popupHgt = $("#popup_hgt").val();
		
		if(validChk($("#popupForm"))){
			userComnPopup(popupId, popupNm, popupWdt, popupHgt);
		}
	});
	
	fn_Search();
	
	// 팝업코드 영문 숫자만 입력되도록
	$("input[name=popup_id]").keyup(function(event){ 
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
		}
	});
	
	//팝업 크기 숫자만 입력
	onlyNumberKeyUp($("#popup_wdt"));
	onlyNumberKeyUp($("#popup_hgt"));
	
	//작성자 readonly
	$("input[name=usr_nm]").prop("readonly", true);
});

// grid resizing
$(window).resize(function(){
	/* comPopup_grid.setGridWidth($(window).width()/3); */
	comPopup_grid.setGridWidth($(".frameTopTable").width()*(49/100));
});

// 신규버튼 클릭 시
function fn_New(){
	// 초기화
	$("input[name=popup_id]").prop("readonly", false).removeClass("inputReadonly");
	$('#popupForm').clearFormData();
	$("#reg_type").val("I");
	$("#pg_yn").val("Y");
	$("#usr_nm").val('<%=userInfo.getUser_nm() %>');
	$("#us_yn").val("Y").prop("selected", true);
	$("#popup_wdt").val('500');
	$("#popup_hgt").val('500');
}

//조회: 내부 로직 사용자 정의
function fn_Search(){
	comPopup_grid.retreive();
}

//저장: 내부 로직 사용자 정의
function fn_Save(){
	
	if(validChk($("#popupForm"))){//필수값체크
		if($("#reg_type").val() == "U"){
			saveData();
		}else{
			if(validCodeCheck()){
				saveData();
			}else{
				alert(msg);
			}
		}
	}
}
//삭제: 내부 로직 사용자 정의
function fn_DelRow(){
	if(!confirm("삭제하시겠습니까?")){
		return false;
	}
	$("#reg_type").val("D");
	saveData();
}

//그리드 셀 선택시 상세내역 출력
function fn_detailPopupInfo(rowInfo){
	var popupId   = rowInfo.POPUP_ID;
	var popupNm   = rowInfo.POPUP_NM;
	var popupDesc = rowInfo.POPUP_DESC;
	var grdConf   = rowInfo.GRD_CONF;
	var schSynx   = rowInfo.SCH_SYNX;
	var fromSynx  = rowInfo.FROM_SYNX;
	var whereSynx = rowInfo.WHERE_SYNX;
	var whereAdd  = rowInfo.WHERE_ADD;
	var srtSynx   = rowInfo.SRT_SYNX;
	var schBox    = rowInfo.SCH_BOX;
	var popupWdt  = rowInfo.POPUP_WDT;
	var popupHgt  = rowInfo.POPUP_HGT;
	var pgYn      = rowInfo.PG_YN;
	var usrNm     = rowInfo.USR_NM;
	var usYn      = rowInfo.US_YN;
	
	$("#popup_id").val(popupId);
	$("#popup_nm").val(popupNm);
	$("#popup_desc").val(popupDesc);
	$("#grd_conf").val(grdConf);
	$("#sch_synx").val(schSynx);
	$("#from_synx").val(fromSynx);
	$("#where_synx").val(whereSynx);
	$("#where_add").val(whereAdd);
	$("#srt_synx").val(srtSynx);
	$("#sch_box").val(schBox);
	$("#popup_wdt").val(popupWdt);
	$("#popup_hgt").val(popupHgt);
	$("#pg_yn").val(pgYn);
	$("#usr_nm").val(usrNm);
	$("#us_yn").val(usYn).prop("selected", true);
	$("#reg_type").val("U");
	
	// primary key 비활성화
	$("input[name=popup_id]").prop("readonly", true).addClass("inputReadonly");
	$("input[name=usr_nm]").prop("readonly", true).addClass("inputReadonly");
	
	/* var cnt = $("input:checkbox[name=btnInfo]").length;
	 $("input:checkbox[name=btnInfo]").prop("checked",false);
	for(var i =0; i < cnt; i++){
		var objBtnInfo =  $('#btnInfo'+(i+1));
		var val =objBtnInfo.val();
		if(btnInfo.indexOf(val)>=0){
			objBtnInfo.prop("checked", true);
		}
	} */
}

//팝업코드 중복확인
function validCodeCheck(){
	var flag = true;
	//팝업코드 중복체크
	var rows = comPopup_grid.getRowData();
	var popupId = $("#popup_id").val().toUpperCase();
	// 기존에 추가되어있는지 확인                   
	for (var k = 0; k < rows.length; k++) {
		if (popupId == rows[k].POPUP_ID) {
			msg  = "이미 존재하는 팝업코드입니다."
			return false;
		}
	}
	
	return flag;
}
//데이터 저장, 삭제, 수정
function saveData(){
	
	// uri encoding
	$("#grd_conf").val(encodeURIComponent($("#grd_conf").val()));
	$("#sch_box").val(encodeURIComponent($("#sch_box").val()));
	
	ajax({
		url: '/psys/savePsys1025.adm',
		data : $("form[name=popupForm]").serialize(),
		async : false,
		success: function(data) {
			if(data.RESULT == "S") {
				if($("#reg_type").val() == "U"){
					alert('저장되었습니다.');
				}else if($("#reg_type").val() == "D"){
					alert("미사용처리되었습니다.")
				}
				$('#popupForm').clearFormData();
				fn_Search();
				return;
			}
		}
	});
}

//사용자 검색 공통팝업 호출
function userComnPopup (popupId, popupNm, popupWdt, popupHgt) {
	popup({url:"/common/forward.comPopupPreview.adm"
        , params: {"popup_id" : popupId}
        , winname:popupId
        , title:popupNm                          
        , width: popupWdt
        , height: popupHgt
        , action: true
        , scrollbars:false
        , autoresize:false
    });
}

</script>
</head>
<body>
	<style>
		.gridPopup:after{content:""; display:block; clear:both;}
		.gridPopup{display:table; width:98%;}
		.gridPopup .ui-jqgrid{display:table-cell;}
		.gridPopup .popupTable{margin-top:30px; margin-left:20px; padding-left:20px; border-left:1px solid #ccc;}
		.popupTable{}
	</style>
	<div class="frameWrap">
		<div class="subCon">
		<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
			<div class="frameTopTable"> 
				<form name="search" id="search" onsubmit="return false">
					<table class="tblType1">
						<colgroup>
							<col style="width: 117px;" />
							<col style="" />
							<col style="width: 117px;" />
							<col style="" />
						</colgroup>   
						<tr>
							<th class="w15">팝업코드</th>
							<td><span class="txt_pw"><input type="text" name="sch_popup_id" id="sch_popup_id" class="text "/></span></td>
							<th class="w15">팝업명</th>
							<td class="typePop">
								<span class="txt_pw"><input type="text" name="sch_popup_nm" id="sch_popup_nm" class="text "/></span>
								<button class="btn_common btn_default" id="btn_prev" name="btn_prev" >미리보기</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="bgBorder"></div>
			<!-- <table class="tblType3"><tr><td>&nbsp;</td></tr></table> -->
			<!-- Grid -->
			<div class="gd_row">
				<div class="gd_inner">
					<div class="gd_col_6">
						<table id="comPopup_grid"></table>
						<div id="comPopup_grid_pager"></div> 
					</div>
					<div class="gd_col_6">
						<form name="popupForm" id="popupForm"  method="post">
							<input type="hidden" id="reg_type" name="reg_type"/>
							<input type="hidden" id="pg_yn" name="pg_yn" value="Y"/>
							<div class="tableBtnWrap">
			                  <p class="tableTitle">팝업정보</p>
			               	</div>
							<div class="popupTable">
								<table class="tblType1">
									<tr>
										<th>
											<label for="popup_id" class="vv necessary">팝업코드</label>
										</th>
										<td><span class="txt_pw"><input type="text" name="popup_id" id="popup_id" class="not-kor w100"/></span></td>
										<th>
											<label for="popup_nm" class="vv necessary">팝업타이틀</label>
										</th>
										<td><span class="txt_pw"><input type="text" name="popup_nm" id="popup_nm" class="w100" data-maxbyte="300"/></span></td>
									</tr>
									<tr>
										<th>
											<label for="popup_desc" >팝업정보</label>
										</th>
										<td colspan="3"><span class="txt_pw"><input type="text" name="popup_desc" id="popup_desc" class="w100"/></span></td>
									</tr>
									<tr>
										<th>
											<label for="usr_nm" >작성자</label>
										</th>
										<td><span class="txt_pw"><input type="text" name="usr_nm" id="usr_nm" class="w50 inputReadonly" value="<%=userInfo.getUser_nm() %>" readonly/></span></td>
										<th>
											<label for="us_yn" class="">사용여부</label>
										</th>
										<td>
											<span class="txt_pw">
												<select class="select" name="us_yn" id="us_yn">
													<option value="Y">사용</options>
													<option value="N">미사용</options>
												</select>
											</span>
										</td>
										
									</tr>
									<tr>
										<th>
											<label for="grd_conf" class="vv necessary">그리드설정</label>
										</th>
										<td colspan="3"><span class="txt_pw"><textarea name="grd_conf" id="grd_conf" class="textarea w100 h80"></textarea></span></td>
									</tr>
									<tr>
										<th>
											<label for="sch_synx" class="vv necessary">선택구문</label>
										</th>
										<td colspan="3"><span class="txt_pw"><textarea name="sch_synx" id="sch_synx" class="textarea w100 h80"></textarea></span></td>
									</tr>
									<tr>
										<th>
											<label for="from_synx" class="vv necessary">테이블구문</label>
										</th>
										<td colspan="3"><span class="txt_pw"><textarea name="from_synx" id="from_synx" class="textarea w100 h40"></textarea></span></td>
									</tr>
									<tr>
										<th>
											<label for="where_synx" class="vv necessary">조건구문</label>
										</th>
										<td colspan="3"><span class="txt_pw"><textarea name="where_synx" id="where_synx" class="textarea w100 h40"></textarea></span></td>
									</tr>
									<tr>
										<th>
											<label for="where_add" >추가조건구문<br>(검색조건)</label>
										</th>
										<td colspan="3"><span class="txt_pw"><input type="text" name="where_add" id="where_add" class="w100"/></span></td>
									</tr>
									<tr>
										<th>
											<label for="srt_synx" >그룹구문</label>
										</th>
										<td colspan="3"><span class="txt_pw"><textarea name="srt_synx" id="srt_synx" class="textarea w100 h40" data-maxbyte="500"></textarea></span></td>
									</tr>
									<tr>
										<th>
											<label for="sch_box" class="vv necessary">조건콤보설정</label>
										</th>
										<td colspan="3"><span class="txt_pw"><textarea name="sch_box" id="sch_box" class="textarea w100 h80"></textarea></span></td>
									</tr>
									<tr>
										<th><label for="popup_wdt" class="">너비</label></th>
										<td><span class="txt_pw"><input type="text" name="popup_wdt" id="popup_wdt" class="w100" maxlength="20"/></span></td>
										<th><label for="popup_hgt" class="">높이</label></th>
										<td><span class="txt_pw"><input type="text" name="popup_hgt" id="popup_hgt" class="w100" maxlength="20"/></span></td>
									</tr>
								</table>
							</div>
						</form>
					</div>
				</div>
			</div>
				<%-- <div class="gridPopup">
					<table id="comPopup_grid"></table>
					<div id="comPopup_grid_pager"></div> 
					<form name="popupForm" id="popupForm"  method="post">
						<input type="hidden" id="reg_type" name="reg_type"/>
						<input type="hidden" id="pg_yn" name="pg_yn" value="Y"/>
						<div class="popupTable">
							<table class="tblType1">
								<tr>
									<th><label for="popup_id" class="vv">팝업코드</label></th>
									<td><span class="txt_pw"><input type="text" name="popup_id" id="popup_id" class="not-kor w100"/></span></td>
									<th><label for="popup_nm" class="vv">팝업타이틀</label></th>
									<td><span class="txt_pw"><input type="text" name="popup_nm" id="popup_nm" class="w100" data-maxbyte="300"/></span></td>
								</tr>
								<tr>
									<th><label for="popup_desc" class="">&nbsp;팝업정보</label></th>
									<td colspan="3"><span class="txt_pw"><input type="text" name="popup_desc" id="popup_desc" class="w100"/></span></td>
								</tr>
								<tr>
									<th><label for="usr_nm" class="">&nbsp;작성자</label></th>
									<td><span class="txt_pw"><input type="text" name="usr_nm" id="usr_nm" class="w50 inputReadonly" value="<%=userInfo.getUser_nm() %>" readonly/></span></td>
									<th><label for="us_yn" class="">&nbsp;사용여부</label></th>
									<td>
										<span class="txt_pw">
											<select class="select" name="us_yn" id="us_yn">
												<option value="Y">사용</options>
												<option value="N">미사용</options>
											</select>
										</span>
									</td>
									
								</tr>
								<tr>
									<th><label for="grd_conf" class="vv">그리드설정</label></th>
									<td colspan="3"><span class="txt_pw"><textarea name="grd_conf" id="grd_conf" class="textarea w100 h80"></textarea></span></td>
								</tr>
								<tr>
									<th><label for="sch_synx" class="vv">선택구문</label></th>
									<td colspan="3"><span class="txt_pw"><textarea name="sch_synx" id="sch_synx" class="textarea w100 h80"></textarea></span></td>
								</tr>
								<tr>
									<th><label for="from_synx" class="vv">테이블구문</label></th>
									<td colspan="3"><span class="txt_pw"><textarea name="from_synx" id="from_synx" class="textarea w100 h40"></textarea></span></td>
								</tr>
								<tr>
									<th><label for="where_synx" class="vv">조건구문</label></th>
									<td colspan="3"><span class="txt_pw"><textarea name="where_synx" id="where_synx" class="textarea w100 h40"></textarea></span></td>
								</tr>
								<tr>
									<th><label for="where_add" class="">&nbsp;추가조건구문<br>&nbsp;(검색조건)</label></th>
									<td colspan="3"><span class="txt_pw"><input type="text" name="where_add" id="where_add" class="w100"/></span></td>
								</tr>
								<tr>
									<th><label for="srt_synx" class="">&nbsp;그룹구문</label></th>
									<td colspan="3"><span class="txt_pw"><textarea name="srt_synx" id="srt_synx" class="textarea w100 h40" data-maxbyte="500"></textarea></span></td>
								</tr>
								<tr>
									<th><label for="sch_box" class="vv">조건콤보설정</label></th>
									<td colspan="3"><span class="txt_pw"><textarea name="sch_box" id="sch_box" class="textarea w100 h80"></textarea></span></td>
								</tr>
								<tr>
									<th><label for="popup_wdt" class="">&nbsp;너비</label></th>
									<td><span class="txt_pw"><input type="text" name="popup_wdt" id="popup_wdt" class="w100" maxlength="20"/></span></td>
									<th><label for="popup_hgt" class="">&nbsp;높이</label></th>
									<td><span class="txt_pw"><input type="text" name="popup_hgt" id="popup_hgt" class="w100" maxlength="20"/></span></td>
								</tr>
							</table>
						</div>
					</form>
				</div> --%>
			<!-- Grid // -->
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
