<%-- 
   1. 파일명 : psys1009
   2. 파일설명: BO사용자 추가
   3. 작성일 : 2018-03-27
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
	
	// 공통코드 복수 설정
	$("#mst_cd_arr").val(new Array('MSTS'))
	
	ajax({
		url		: '/psys/getPsysCommon',
		data	: $("form[name=frm_sysCdDtl]").serialize(),
		success	: function(data) {
			for(i=0; i<data.selectData.length; i++)
				$("#usr_stat_cd").append("<option value='" + data.selectData[i].CD+ "'>" + data.selectData[i].CD_NM + "</option> ");
			
			// 탈퇴(2) 미인증(3) 상태 제거
			$("#usr_stat_cd option[value!='1']").remove();
			
			// 미인증 상태로 가입 시, 인증메일 전송 실패하면 해당 회원은 정보 수정 불가 (미인증 회원->BO 로그인불가->이메일주소수정불가)
			// 이 경우, DB에서 처리하는 방법만 남게 되므로 미인증 상태 제거
		}
	});
	
	// form submit process
	$("#form_userInfo").submit(function(e) {
		ajax({
			url		: "/psys/getPsys1009UsrInfVldYn",
			data	: {lgn_id : $("#lgn_id").val(), usr_eml_addr : $("#usr_eml_addr").val()},
			async	: false,
			success	: function(data) {
				if("N" == data.lgnIdVldYn) {
					alert("사용할 수 없는 아이디 입니다.");
					$("#login_id").focus();
					return;
				} else if("N" == data.emlAdrVldYn) {
					alert("이미 가입회원 및 탈퇴회원으로 등록된 메일주소 입니다.\n다른 메일주소를 입력해주세요.");
					$("#email").focus();
					return;
				} else if("Y" == data.lgnIdVldYn && "Y" == data.emlAdrVldYn) {
					// 유효성 검사를 통과한 데이터를 등록
					fn_saveSysUerInfo();
				}
			}
		});
		e.preventDefault();
	});
	
	// 로그인 아이디 영문 숫자만 입력되도록
	$("input[name=lgn_id]").keyup(function(event) {
		if (!(event.keyCode>=37 && event.keyCode<=40))
			$(this).val($(this).val().replace(/[^a-z0-9]/gi, ''));
	});
	
	
	//사이트 리스트 취득
	getSystemList();
	
	
	$("#org_cd").on("click", function () {
		
		var sys_cd = $("#sys_cd").val();
		if(isEmpty(sys_cd)) {
			
			alert("시스템을 선택해주세요.");
			return false;
		} 
		
		// b공통 팝업.
		bpopup({
			  url:"/psys/forward.psys1009p001.adm"
			, params: {sys_cd : sys_cd, callback : "fn_inputOrgNm", target_id : _menu_id}
			, title : "조직 선택"
			, type: "xl"
			, height:"600px"
			, id : "psys1009p1"
		});
		
	});
	
	$("#sys_cd").on("change", function () {
		
		var sys_cd = $(this).val();
		$("#org_nm").val("");
		
		//슈퍼 관리자
		$("#org_cd").val("0");
		$("#org_nm").attr("disabled",true);
		
	});
	
});

//폼 데이터 유효성 검사(INPUT)
function fn_validatonCheck(){
	
	// INPUT FORM CHECK
	var temp = $('input[type="text"], input[type="password"]').not('input[name=org_nm]');
	
	for(var i=0 ; i < temp.length ; i++)
	{
		if(isEmpty(temp[i].value))
		{
			alert($('label[for=' + temp[i].id + ']').text() + "를 입력해주세요.");
			$("#" + temp[i].id).focus();
			return false;
		}
	}

	var usr_eml_addr = $("#usr_eml_addr").val();
	var reg_exp = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	
	// 이메일 양식
	if(!reg_exp.test(usr_eml_addr))
	{
		alert("이메일 양식이 잘못되었습니다.");
		$("#usr_eml_addr").focus();
		return false;
	}
	
	var lgn_pwd = $("#lgn_pwd").val();
	
	// 비밀번호 양식
	if(lgn_pwd.length < 6 || lgn_pwd.length > 20)
	{
		alert("비밀번호는 6자 이상 20자 이내로 입력해 주세요.");
		$("#lgn_pwd").focus();
		return false;
	}
	
	// 시스템 구분 = > 사이트 번호
	var sys_cd = $("#sys_cd").val();
	if(isEmpty(sys_cd)) {
		alert("시스템을 선택해주세요.");
		return false;
	}
	
	// 사이트별 조직도 번호
	var org_cd = $("#org_cd").val();
	if(isEmpty(org_cd)) {
		alert("조직을 선택해주세요.");
		$("#org_cd").focus();
		return false;
	}
	
	
	return true;
}

function fn_saveSysUerInfo() {
	ajax({
		url		: '/psys/savePsys1009',
		data	: $("#form_userInfo").serialize(),
		async	: false,
		success	: function(data) {
			
			if (data.RESULT == "S") {
				if($("#usr_stat_cd").val() == 3) { // 미인증 상태로 가입 시 인증메일 전송
					fn_sendCertEmail(data.NEW_USER_ID);
				} else {
					alert('저장되었습니다.');
				}
				
				$("#form_userInfo").reset();
				addTabInFrame("/psys/forward.psys1007.adm", "CHG");
				
			} else {
				alert("일시적 오류입니다\n잠시후 다시 시도하세요.");
				e.preventDefault();
			}
		},
	});
}

function fn_sendCertEmail(usr_id) {
	if(isNotEmpty(usr_id)) {
		jQuery.ajax({
			url		: _context + "/psys/sndCertEml",
			type	:  "POST",
			data	: {usr_id : usr_id},
			dataType: 'json',
			async	: false,
			success	: function(data){
				if (data.RESULT == _boolean_success) {
					alert("인증 메일이 전송되었습니다.");
				} else {
					alert("인증 메일 전송이 실패했습니다. 잠시후 다시 시도하세요.");
				}
			}
		});	
	}
}

/**************************************************
 * 공통 버튼 
 **************************************************/
 
// 조회: 내부 로직 사용자 정의
function fn_Search() {
}

// 추가: 내부 로직 사용자 정의
function fn_AddRow() {
}

// 저장: 내부 로직 사용자 정의
function fn_Save() {
	// INPUT FORM 데이터가 유효하면
	if(fn_validatonCheck()){
		// 회원 등록
		$("#form_userInfo").submit();	
	}
}

// 삭제: 내부 로직 사용자 정의
function fn_DelRow() {
}

// 프린트: 내부 로직 사용자 정의
function fn_Print() {
}

// 엑셀다운로드: 내부 로직 사용자 정의
function fn_ExcelDownload() {
}

function fn_inputOrgNm(row) {
	
	var org_nm = row.HR_UP_ORG_NM + " > " + row.ORG_NM;
	
	$("#org_cd").val(row.ORG_CD);
	$("#org_nm").val(org_nm);
		
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
						$("#sys_cd option").remove();
						html += "<option  class='passOption' value="+ this.SYS_CD +" selected='selected' >"+ this.SYS_NM +"</option>"
						return false;
					} else {
						html += "<option class='passOption' value="+ this.SYS_CD +">"+ this.SYS_NM +"</option>"
					}
				});
				$("#sys_cd").append(html);
			}
		}
	});
}

</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon hidden">
			<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp"%>
			<form id="form_userInfo" name="form_userInfo" onsubmit="return false;">
				<table class="tblType1">
					<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>
					<tr>
						<th><label for="lgn_id" class="vv">아이디</label></th>
						<td>
							<span class="txt_pw">
								<input type="text" name="lgn_id" id="lgn_id" value="" class="w100" maxlength="15" />
							</span>
						</td>
						<th><label for="usr_eml_addr" class="vv">이메일</label></th>
						<td>
							<span class="txt_pw">
								<input type="text" name="usr_eml_addr" id="usr_eml_addr" value="" class="w100" />
							</span>
						</td>
					</tr>
					<tr>
						<th><label for="usr_nm" class="vv">이름</label></th>
						<td>
							<span class="txt_pw">
								<input type="text" name="usr_nm" id="usr_nm" value="" class="w100" maxlength="20" />
							</span>
						</td>
						<th><label for="lgn_pwd" class="vv">비밀번호</label></th>
						<td>
							<span class="txt_pw">
								<input type="password" name="lgn_pwd" id="lgn_pwd" value="" class="w100" maxlength="20" />
							</span>
						</td>
					</tr>
					<tr>
						<th>상태</th>
						<td>
							<select id="usr_stat_cd" name="usr_stat_cd" class="select"></select>
						</td>
						<th>계정활성화</th>
						<td>
							<span class="txt_pw">
								<select class="select" name="actv_yn" id="actv_yn">
									<option value="Y">활성화</option>
									<option value="N">비활성화</option>
								</select>
							</span>
						</td>
					</tr>
					<tr>
						<th><label for="sys_cd" class="vv">시스템</label></th>
						<td>
							<span class="txt_pw">
								<select id="sys_cd" name="sys_cd" class="select">
									<option class="passOption" value=''>선택</option>
								</select>
							</span>
						</td>
						<th><label for="org_nm" class="vv">조직 추가</label></th>
						<td>
							<span class="txt_pw">
								<input type="hidden" name="org_cd" id="org_cd" value="" />
								<input type="text" name="org_nm" id="org_nm" value="" class="w100" maxlength="20"  readonly="readonly" />
							</span>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>

	<form name="frm_sysCdDtl" id="frm_sysCdDtl" onsubmit="return false;">
		<input type="hidden" name="mst_cd_arr" id="mst_cd_arr" />
	</form>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>
