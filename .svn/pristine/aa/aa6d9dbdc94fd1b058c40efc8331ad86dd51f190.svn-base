<%--
   1. 파일명  : pdsp1007
   2. 파일설명: 메인팝업 등록
   3. 작성일  : 2018-03-29
   4. 작성자  : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var newFileFlag = true;
$(document).ready(function() {

	getSystemList();
	
	
	
	
	// 쓰기 서브밋
	$("#frm_regist").submit(function(e) {
		var formData = new FormData($(this)[0]);
		var data2 = JSON.stringify($(this).serializeArray());
		$.ajax({
			url: _context + '/psdp/insertPdsp1007.adm',
			type: 'POST',
			data: formData,
			mimeType:"multipart/form-data",
			contentType: false,
			cache: false,
			processData:false,
			success: function(data) {
				var json = eval('('+data+')');
				if(json.result == "S") {
					alert("팝업이 등록되었습니다.");
					addTabInFrame("/pdsp/forward.pdsp1005.adm", "CHG");
				} else {
					alert("작업이 정상적으로 실행되지 않았습니다. 잠시후 다시 시도하세요");
				}
			}
		});
	e.preventDefault();
	});

	doInit();

	// byte 표시
	// @param inputTarget, byteTextTarget, maxByte
	byteTextShow("#top_txt", "#top_txt_text", 50);
	byteTextShow("#mid_txt", "#mid_txt_text", 100);

	// 전시기간 날짜 초기화 셋팅
    var today  = new Date();
    $("#sch_st_dt").val(formatDate(today));

    var addMonthDay = addMonth(today);
    $("#sch_ed_dt").val(formatDate(addMonthDay));
    
    // 팝업 종류 radio 변경 시, form 하위요소 변경
    $("input[name=pop_kd_cd]").change(function(){
    	var popKdCd = $(this).val();
    		
    	// 10 - text popup, 20 - url popup
    	if(popKdCd == "10") {
    		$("tr[data-popup=url]").hide();
    		$("tr[data-popup=text]").show();
    		$("tr[data-popup=url] th label[for]").removeClass("vv");
    		$("tr[data-popup=text] th label[for]").addClass("vv");
    	}else if(popKdCd == "20") {
    		$("tr[data-popup=text]").hide();
    		$("tr[data-popup=url]").show();
    		$("tr[data-popup=text] th label[for]").removeClass("vv");
    		$("tr[data-popup=url] th label[for]").addClass("vv");
    	}
    });
});

//초기화
function doInit() {
	// 최초 FOCUS
	$("#title").focus();

	// 전시기간(시작일/종료일)
	setDatepicker("#sch", "_st_dt", "_ed_dt");
	
	initSelectNumbers();
}

//Form 전송용 DateTime 설정
function formSetDateTime(id, isFrom, isTo) {

	var idPrefixs = "#h_";
	var idSuffixs = ["_st_dt","_ed_dt"];
	var flagArr = new Array();
	flagArr.push(isFrom);
	flagArr.push(isTo);

	for(var i = 0; i < idSuffixs.length; i++) {
		if(flagArr[i]) {
			var DtHms = $("#"+id+idSuffixs[i]).val().replace(/-/gi, "") + $("#"+idSuffixs[i]+"_hh").val() + $("#"+idSuffixs[i]+"_mm").val() + $("#"+idSuffixs[i]+"_ss").val();
			$(idPrefixs+id+idSuffixs[i]).val(DtHms);
		}else{
			$(idPrefixs+id+idSuffixs[i]).val("");
		}
	}
}

//목록: 내부 로직 사용자 정의
function fn_List() {
	addTabInFrame("/pdsp/forward.pdsp1005.adm", "CHG");
}

//저장: 내부 로직 사용자 정의
function fn_Save() {

	formSetDateTime("sch", isNotEmpty($("#sch_st_dt").val()), isNotEmpty($("#sch_ed_dt").val()));
	
	$("#newFileFlag").val(newFileFlag);
	
	// 입력 값 필수 체크
	if(!validChk($("#frm_regist")))	return false;
	
	// 팝업 전시시작일시, 종료일시 유효성 검사
	var strFromDate = $("#sch_st_dt").val() + " " + $("#_st_dt_hh").val() + ":" + $("#_st_dt_mm").val() + ":" + $("#_st_dt_ss").val();
	var strToDate   = $("#sch_ed_dt").val()   + " " + $("#_ed_dt_hh").val()   + ":" + $("#_ed_dt_mm").val()   + ":" + $("#_ed_dt_ss").val();
	if(!validDateChk(strFromDate, strToDate)) return false;
	
	if(!confirm("작성내용을 저장하시겠습니까?")) return false;
		
	$("#frm_regist").submit();
}


//사이트 리스트 취득
function getSystemList() {
    var html = "";
    ajax({
        url     : "/pdsp/getPdsp1011ListSit",
        data    : {sys_cd : _sys_cd}, 
        success : function (data) {
            if (data.RESULT == "S") {
                var sitListCnt = data.rows.length;
                $(data.rows).each(function (index) {
                    // 조회 건수가 하나일 경우 사이트 하나
                    if(sitListCnt == 1) {
                        html += "<option  class='passOption' value="+ this.SYS_CD +" selected='selected' >"+ this.SYS_NM +"</option>"
                        return false;
                    } else {
                        html += "<option class='passOption' value="+ this.SYS_CD +">"+ this.SYS_NM +"</option>"
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
<body>
	<div class="frameWrap">
		<div class="subCon">
		<%@ include file="/WEB-INF/views/pandora3/common/include/btnList2.jsp" %>
			<form name="frm_regist" id="frm_regist" enctype="multipart/form-data" method="post" onsubmit="return false;">
			<input type="hidden" name="newFileFlag" id="newFileFlag"/>
			<table class="tblType1 type_register">
				<colgroup>
					<col width="15%" />
					<col width="25%" />
					<col width="*" />
				</colgroup>
				<tr>
					<th><label for="sys_info" class="vv">사이트명</label></th>
					<td colspan="2">
						<select id="sys_info" name="sys_info" class="select" >
							<option  class="passOption" value="">선택</option>
						</select>
					</td>
				</tr>
				<tr>
					<th><label for="pop_nm" class="vv">팝업명</label></th>
					<td colspan="2">
						<span class="txt_pw"><input type="text" name="pop_nm" id="pop_nm" class="w70" data-maxbyte="300" /></span>
					</td>
				</tr>
				<tr>
					<th><label for="pop_tp_cd" class="vv">팝업종류</label></th>
					<td colspan="2">
						<div class="radio">
							<span><input name="pop_kd_cd" id="pop_kd_cd_01" type="radio" value="10" checked><label for="pop_kd_cd_01">TEXT 팝업</label></span>
							<span><input name="pop_kd_cd" id="pop_kd_cd_02" type="radio" value="20"><label for="pop_kd_cd_02">URL 팝업</label></span>
						</div>
					</td>
				</tr>
				<tr data-popup="url" style="display:none;">
					<th><label for="pop_url" class="">팝업URL</label><p class="pad-left-4"></p></th>
					<td colspan="2"><span class="txt_pw"><input type="text" name="pop_url" id="pop_url" class="w100" data-maxbyte="255" title="팝업URL"/></span></td>
				</tr>
				<tr data-popup="text">
					<th><label for="top_txt" class="vv">상단문구</label><p class="pad-left-4">&nbsp;(<label id="top_txt_text"></label>/50byte)</p></th>
					<td colspan="2"><span class="txt_pw"><input type="text" name="top_txt" id="top_txt" class="w100" data-maxbyte="50" title="상단문구"/></span></td>
				</tr>
				<tr data-popup="text">
					<th><label for="mid_txt" class="vv">중단문구</label><p class="pad-left-4">&nbsp;(<label id="mid_txt_text"></label>/100byte)</p></th>
					<td colspan="2"><span class="txt_pw"><textarea name="mid_txt" id="mid_txt" class="textarea w100 h80" data-maxbyte="100" title="중단문구"></textarea></span></td>
				</tr>
				<tr data-popup="text">
					<th><label for="btm_txt" class="vv">하단문구</label></th>
					<td colspan="2"><span class="txt_pw"><textarea name="btm_txt" id="btm_txt" class="textarea w100 h80"></textarea></span></td>
				</tr>
				<tr data-popup="text">
					<th><label for="bkg_tp_cd" class="vv">팝업배경</label></th>
					<td colspan="2"> 
						<div class="radio">
							<span><input name="bkg_tp_cd" id="bkg_tp_cd_01" type="radio" value="01"><label for="bkg_tp_cd_01">파랑(패턴)</label></span>
							<span><input name="bkg_tp_cd" id="bkg_tp_cd_02" type="radio" value="02" checked><label for="bkg_tp_cd_02">노랑</label></span>
							<span><input name="bkg_tp_cd" id="bkg_tp_cd_03" type="radio" value="03" checked><label for="bkg_tp_cd_03">파랑(이미지)</label></span>
						</div>
					</td>
				</tr>
				<tr>
					<th><label for="pop_tp_cd" class="vv">팝업유형</label></th>
					<td>
						<div class="radio">
							<span><input name="pop_tp_cd" id="pop_tp_cd_01" type="radio" value="01"><label for="pop_tp_cd_01">팝업크기(대)</label></span>
							<span><input name="pop_tp_cd" id="pop_tp_cd_02" type="radio" value="02" checked><label for="pop_tp_cd_02">팝업크기(소)</label></span>
						</div>
					</td>
					<td>
						<p><b class="required">*(대) - </b>가로 : <b>500px</b>&nbsp;&nbsp;세로 : <b>700px</b></p>
						<p><b class="required">*(소) - </b>가로 : <b>500px</b>&nbsp;&nbsp;세로 : <b>400px</b></p>
					</td>
				</tr>
				<tr>
					<th><label for="dsply_yn" class="vv">전시여부</label></th>
					<td colspan="2">
						<div class="radio">
							<span><input name="dsply_yn" id="dsply_yn_y" type="radio" value="Y"><label for="dsply_yn_y">전시</label></span>
							<span><input name="dsply_yn" id="dsply_yn_n" type="radio" value="N"><label for="dsply_yn_n">비전시</label></span>
						</div>
					</td>
				</tr>
<!-- 				<tr> -->
<!-- 					<th><label for="fileTxt" class="vv">팝업 이미지 파일</label></th> -->
<!-- 					<td> -->
<!-- 						<span class="fileAdd w100"> -->
<!-- 							<input id="fileTxt" type="text" class="w60" value="" placeholder="선택된 파일 없음" readonly> -->
<!-- 							<input type="button" value="파일첨부" class="btn_common btn_blue" onclick="javascript:document.getElementById('img_files').click();"> -->
<!-- 							<input id="img_files" type="file" style='visibility:hidden;' name="img_files" onchange="ChangeText(this, 'fileTxt');" accept=".jpg, .jpeg, .bmp, .gif, .png"/> -->
<!-- 						</span> -->
<!-- 					</td> -->
<!-- 					<td><p><b class="required">*허용확장자 :</b> .jpg, .jpeg, .png, .gif, .bmp,</p></td> -->
<!-- 				</tr> -->
				<tr>
					<th><label for="sch_st_dt" class="vv">전시시작일시</label></th>
					<td colspan="2" class="type_show"> 
						<span class="txt_pw type_date">
							<input type="text" id="sch_st_dt"/>
						</span>
						<span class="txt_pw type_three"> 
							<select id="_st_dt_hh" class="select"></select>
							<span class="colon">:</span>
							<select id="_st_dt_mm" class="select"></select>
							<span class="colon">:</span>
							<select id="_st_dt_ss" class="select"></select>
						</span>
						<input type="hidden" id="h_sch_st_dt" name="sch_st_dt" />
					</td>
				</tr>
				<tr>
					<th><label for="sch_ed_dt" class="vv">전시종료일시</label></th>
					<td colspan="2" class="type_show"> 
						<span class="txt_pw type_date">
							<input type="text" id="sch_ed_dt"/>
						</span>
						<span class="txt_pw type_three">
							<select id="_ed_dt_hh" class="select"></select>
							<span class="colon">:</span>
							<select id="_ed_dt_mm" class="select"></select> 
							<span class="colon">:</span>
							<select id="_ed_dt_ss" class="select"></select>
						</span>
						<input type="hidden" id="h_sch_ed_dt" name="sch_ed_dt" />
					</td>
				</tr>
			</table>
			</form>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>