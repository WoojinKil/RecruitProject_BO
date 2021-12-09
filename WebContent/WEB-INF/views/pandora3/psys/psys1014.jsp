<%-- 
   1. 파일명 : psys1014
   2. 파일설명: BO정보 변경 페이지
   3. 작성일 : 2018-04-11
   4. 작성자 : TANINE
--%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3Front/js/common/jquery.bpopup.min.js"></script>
<script type="text/javascript">

var org_usr_eml_addr;

$(document).ready(function(){

	onlyNumberKeyUp($("#usr_mbl_no_1"));
	onlyNumberKeyUp($("#usr_mbl_no_2"));
	onlyNumberKeyUp($("#usr_mbl_no_3"));
	onlyNumberKeyUp($("#usr_tel_no_1"));
	onlyNumberKeyUp($("#usr_tel_no_2"));
	onlyNumberKeyUp($("#usr_tel_no_3"));
	
	$.ajax({
		url		: _context+"/psys/getPsys1014UsrInf",
		type	: 'POST',
		success	: function(result){

			result = JSON.parse(result);

			var user_info = result.AdminInfo[0];

			if(isNotEmpty(user_info))
			{
				org_usr_eml_addr = user_info.USR_EML_ADDR;
				
				$("#lgn_id").text(user_info.LGN_ID);
				$("#usr_eml_addr").val(user_info.USR_EML_ADDR);
				$("#usr_nm").val(user_info.USR_NM);
				$("#usr_zip_cd").val(user_info.USR_ZIP_CD);
				$("#rod_addr").val(user_info.ROD_ADDR)
				$("#lno_addr").val(user_info.LNO_ADDR);
				$("#dtl_addr").val(user_info.DTL_ADDR);
			}
			else
			{
				alert("해당하는 회원이 존재하지 않습니다. 다시 조회해주세요.");
			}
		}
	});

});


//폼 데이터 유효성 검사(INPUT)
function fn_validationCheck()
{
	// INPUT FORM CHECK
	var temp = ['usr_eml_addr', 'usr_nm'];
	
	for(var i=0 ; i < temp.length ; i++)
	{
		if(isEmpty($("#" + temp[i]).val()))
		{
			alert($('label[for=' + temp[i] + ']').text() + "을 입력해주세요.");
			$("#" + temp[i]).focus();
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
	
	return true;
}

function fn_updUsrInf()
{

	if(fn_validationCheck())
	{
		if(org_usr_eml_addr == $("#usr_eml_addr").val())
		{
			$("#usr_eml_addr").prop("disabled", true);
			fn_saveUsrInf();
			$("#usr_eml_addr").prop("disabled", false);
		}
		else
		{
			ajax({
				url		: '/psys/updatePsys1014',
				data	: {usr_eml_addr:$("#usr_eml_addr").val()},
				async	: false,
				success	: function(data) {
					if(data.RESULT == "S")
					{
						alert("이메일변경 인증 메일을 보냈습니다.");
						fn_saveUsrInf();
					}
					else if(data.RESULT=="P1")
					{	
						alert("이미존재하는 이메일입니다.");
					}
					else
					{
						alert("일시적 오류입니다\n잠시후 다시 시도하세요.");
						e.preventDefault();
						return;
					}
				},
			});
		}
	}
}


function fn_saveUsrInf(){
	
	ajax({
		url		: '/psys/savePsys1014',
		data	: $("form[name=form_userInfo]").serialize(),
		async	: false,
		success	: function(data){

			if(data.RESULT == "S")
			{
				alert('저장되었습니다. 재로그인 해주세요.');

				ajax({
					url		:'/main/logout',
					success	: function(data){
						popup({ url		: "/login/forward.login.adm",
								winname	: "_top",
								title	: "로그인",
								scrollbars : false,
								autoresize : false
						});
					}
				});
			}
			else
			{
				alert("일시적 오류입니다\n잠시후 다시 시도하세요.")
				e.preventDefault();
				return;
			}
		},
	});
}

//비밀번호 변경 팝업
function fn_chgPwd()
{
	parent.callPopupPWChange();
}

</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
			<h1>회원상세정보</h1>
			<form name="form_userInfo" id="form_userInfo" submit="return false;">
				<table class="tblType1">
					<colspan>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colspan>
					<tr>
						<th class="vv">아이디</th>
						<td><span class="txt_pw" name="lgn_id" id="lgn_id"></span></td>
						<th class="vv">비밀번호</th>
						<td><button class="btn_common btn_default" id="btn_pw_change" name="btn_chg_pwd" onClick="fn_chgPwd();">비밀번호 변경</button></td>
					</tr>
					<tr>
						<th class="vv"><label for="usr_eml_addr">이메일</label></th>
						<td colspan="3"><span class="txt_pw"><input type="text" name="usr_eml_addr" id="usr_eml_addr" value="" class="w40" /></span></td>
					</tr>
					<tr>
						<th class="vv"><label for="usr_nm">이름</label></th>
						<td colspan="3"><span class="txt_pw"><input type="text" name="usr_nm" id="usr_nm" value="" class="w25" maxlength="20" readonly /></span></td>
					</tr>
					<tr>
						<th><label for="usr_mbl_no">휴대폰번호</label></th>
						<td colspan="3">
							<span class="txt_pw">
								<input type="text" name="usr_mbl_no_1" id="usr_mbl_no_1" value="" class="w10" maxlength="4" />
								-
								<input type="text" name="usr_mbl_no_2" id="usr_mbl_no_2" value="" class="w10" maxlength="4" />
								-
								<input type="text" name="usr_mbl_no_3" id="usr_mbl_no_3" value="" class="w10" maxlength="4" />
							</span>
						</td>
					</tr>
					<tr>
						<th><label for="usr_tel_no_1">전화번호</label></th>
						<td colspan="3">
							<span class="txt_pw">
								<input type="text" name="usr_tel_no_1" id="usr_tel_no_1" value="" class="w10" maxlength="4" />
								-
								<input type="text" name="usr_tel_no_2" id="usr_tel_no_2" value="" class="w10" maxlength="4" />
								-
								<input type="text" name="usr_tel_no_3" id="usr_tel_no_3" value="" class="w10" maxlength="4" />
							</span>
						</td>
					</tr>
					<tr style="display: none">
						<th><label for="usr_adr">주소</label></th>
						<td>
							<span class="txt_pw">
								<input type="text" name="usr_zip_cd" id="usr_zip_cd" value="" class="w10" />
								-
								<input type="text" name="lno_addr" id="lno_addr" value="" class="w10" />
							</span>
						</td>
					</tr>
					<tr style="display: none">
						<th></th>
						<td>
							<span class="txt_pw">
								<input type="text" name="rod_addr" id="rod_addr" value="" class="w25" />
								<input type="text" name="dtl_addr" id="dtl_addr" value="" class="w25" />
							</span>
						</td>
					</tr>
				</table>

			</form>
			<div class="buttons" style="text-align:center; margin-top:20px;">
				<div style="display:inline-block;">
					<button class="btn-small btn-primary" id="btn_usr_inf" style="display: inline-block;" onclick="fn_updUsrInf()">변경</button>
				</div>
			</div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
