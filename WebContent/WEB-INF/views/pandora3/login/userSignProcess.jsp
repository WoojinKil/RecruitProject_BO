<%-- 
    작성자 : 
    개요 : 메인 > 회원가입 > 약관동의
    수정사항 :
        2017-11-28 최초작성
--%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/meta.jsp" %>
<script type="text/javascript">
var new_user_id;
$(document).ready(function() {
	
	// 초기 화면 설정(show,hide,hide)
	displayControll(1,2,3);
	
	// 이용약관 & 개인정보 수집 및 이용에 대한 동의여부
	$('input[type="checkbox"][name="agree"]').change(function() {
		var all_cnt = $("input:checkbox[name=agree]").length;
		var chked_cnt = $("input:checkbox[name=agree]:checked").length;
		var checked = false;
		if(all_cnt == chked_cnt) checked = true;
		$("#signAgreeAll").prop("checked", checked);
	});
	
	// 이용약관 및 개인정보 수집 및 이용에 전체동의
	$('input[type="checkbox"][name="signAgreeAll"]').change(function() { 
		var checkedVal = $(this).is(":checked");
		$('input[type="checkbox"][name="agree"]').each(function() {
			if(checkedVal) {
				if(!$(this).is(":checked")) {
					$(this).prop("checked", checkedVal);
				}
			}else {
				$(this).prop("checked", checkedVal);
			}
		});
	});
	
	
	// 유효성 검사 Error Msg 초기화
	$('input.form-control.signForm').each(function() {
		$(this).focusout(function() {
			$(this).parent().parent().find('p').hide();	
		})
	});
	$('select.form-control.signForm').each(function() {
		$(this).focusout(function() {
			$(this).parent().parent().find('p').hide();	
		})
	});
	
	// 메인으로 가기 클릭
	$("#goMain").click(function() {
		window.location.replace("${pageContext.request.contextPath}");
	});
	
	$("#callCertMail").click(function() {
		sendCertEmail(new_user_id);
	})
	
	// 로그인 아이디 영문 숫자만 입력되도록
	$("input[name=login_id]").keyup(function(event){ 
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
		}
	});

});
// 화면 설정 (show, hide, hide)
function displayControll(t1, t2, t3) {
	$("#tab-"+t2).hide();
	$("#tab-"+t3).hide();
	$("#tab-"+t1).show();
	$(".joinTab").find("li").removeClass("active")
	$(".joinTab").find("li").eq(t1-1).addClass("active");
	$(".error-msg").hide();
	$("html,body").animate({scrollTop:0},30);
	
}
// 다음단계 진행
function nextProc(step) {
	// 정보입력으로 이동 시
	if(step == "step2") {
		// 약관 동의하기 유효성 체크
		var validFlag = true;
		$('input[type="checkbox"]').each(function() {
			if($(this).attr("id").indexOf("signAgree") > -1) {
				if(!$(this).is(":checked")) {
					validFlag = false;
					alert("이용약관에 동의해주시기 바랍니다.");
					return false;
					
				}
			}
		});
		if(validFlag) {
			displayControll(2,1,3);
		}	
	} 
	// 이메일 인증으로 이동시(입력정보 SUBMIT)
	else if(step == "step3") {
		// 입력값 유효성 체크
		if(validationChk()) {
			// DB정보 확인(이메일 / 아이디)
			dbInfoCheck();
		} 	
	}
}
// 이전단계 복귀
function prevProc(step) {
	if(step == "step1") {
		// 약관 동의하기 초기화
		$('input[type="checkbox"]').each(function() {
			if($(this).attr("id").indexOf("signAgree") > -1) 
				$(this).prop("checked", false);
		});
		displayControll(1,2,3);
	} else if(step == "back") {
		$("#goMain").trigger('click');
	}
}

//입력값 유효성/필수 체크
function validationChk() {
	
	// 이메일 형식 및 중복 체크
	var mailMsg1 = "정확한 이메일 주소를 입력해 주세요.";
	var email = $("#email").val();
	var reg = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	if (!reg.test(email)){
		$("#email").parent().parent().find('p').text(mailMsg1).show();
		$("#email").focus();
		return false;
	}
	// 패스워드 
	var pw = $("#pw").val();
	if(pw.length < 6 || pw.length > 20) {
		$("#pw").parent().parent().find('p').show();
		$("#pw").focus();
		return false;
	}
	// 패스워드 확인
	if($("#pw").val() != $("#pw_confirm").val()) {
		$("#pw_confirm").parent().parent().find('p').show();
		$("#pw_confirm").focus();
		return false;
	}
	// 로그인 아이디 : 필수체크
	if($("#login_id").val().length < 4) {
		var msg1 = "아이디를 입력 해주세요.";
		$("#login_id").parent().parent().find('p').text(msg1).show();
		$("#login_id").focus();
		return false;
	}
	// 유저명
	if($("#user_nm").val().length < 2) {
		$("#user_nm").parent().parent().find('p').show();
		$("#user_nm").focus();
		return false;
	}
	return true;
}

// DBCheck
function dbInfoCheck(){
	var msg2 = "이미 사용중인 이메일 주소입니다.";
	$.ajax({
		url: _context + '/main/login/chkEmailOverlap',
		type : "POST",
		data : {email:$("#email").val()} ,
		dataType : "json",
		success: function(data){    
			if("N" == data.isEmailYn) {
				$("#email").parent().parent().find('p').text(msg2).show();
				$("#email").focus();
				return false;
			} else {
				ajax({
					url : "/main/chkSysUserId",
					data : {login_id :$("#login_id").val()},
					success:function(data) {
						//console.log(data.isLoginIdYn);
						if("N" == data.isLoginIdYn) {
							$("#login_id").parent().parent().find('p').text("사용할 수 없는 아이디 입니다.").show();
							$("#login_id").focus();
							return false;
						} else {
							$.ajax({
						        type : "POST",
						        url : _context + '/system/registUserReturnId',
						        data : $("form[name=userSignForm]").serialize(),
						        dataType : "json",
						        async : false, // true:비동기, false:동기
						        cache : false,
						        timeout : 30000,
						        success : function(data) {
						        	//console.log(data.RESULT)
									if(data.RESULT == "S") {
										//console.log(data.NEW_USER_ID);
										new_user_id = data.NEW_USER_ID;
										sendCertEmail(data.NEW_USER_ID);
										displayControll(3,1,2);
									} else {
										alert("일시적 오류입니다\n잠시후 다시 시도하세요.")
									}
						        }
						    });
						}
					}
				});
			}
		}
	});	
}
function sendCertEmail(user_id) {
	if(isNotEmpty(user_id)) {
		jQuery.ajax({
		    url: _context + "/system/sendCertEmail",
		    type: "POST",
		    data: {
		    	   user_id : user_id
		    },
		    dataType:'json',
		    async:false,
		    success: function(data){
		       if (data.RESULT == _boolean_success) {
		       //console.log("EMAIL SEND SUCCESS")
		       }
		    }
		});	
	}
}
</script>
</head>
<body>
<!-- wrapper -->
<div id="wrapper">
	<!-- header -->
<%-- 	<%@ include file="/WEB-INF/views/pandora3Front/common/include/header.jsp" %> --%>
	<!-- //header -->
	   <!-- container -->
		<div class="contents-container join-agree">
			<!-- title -->
			<h1 class="page-header">회원가입</h1>
			<p class="text-size4">판도라 홈페이지를 찾아주셔서 감사합니다.</p>
			<p class="text-small">홈페이지 회원으로 가입하시면 판도라에서 제공하는 다양한 정보들을 보다 편리하게 이용하실 수 있습니다.</p>
			<!--// title -->
			<!-- tab -->
			<ul class="joinTab">
				<li><span class="text-small">Step 01</span>약관동의</li>
				<li><span class="text-small">Step 02</span>정보입력</li>
				<li><span class="text-small">Step 03</span>이메일인증</li>
			</ul>
			<!--// tab -->
			<!-- contents -->
			<div id="tab-1">
				<h2 class="m-t-50">약관 동의</h2>
				<div class="join-agree-box">
					<div class="content">${termsArr[0].note_cont}</div>
					<div class="check-box"><input type="checkbox" id="signAgree1" name="agree" /><label for="signAgree1">이용 약관에 동의합니다.</label></div>
				</div>
				<h2 class="m-t-50">개인정보 취급방침</h2>
				<div class="join-agree-box">
					<div class="content">${termsArr[1].note_cont}</div>
					<div class="check-box"><input type="checkbox" id="signAgree2" name="agree" /><label for="signAgree2">개인정보 수집 및 이용에 동의합니다.</label></div>
				</div>
				<div class="join-agreeall-box m-t-50"><input type="checkbox" id="signAgreeAll" name="signAgreeAll" value="ALL" /><label for="signAgreeAll">이용약관 및 개인정보 수집 및 이용에 전체동의</label></div>
				<div class="buttons text-center m-t-50 m-b-80">
					<button class="btn-big btn-primary" onclick="javascript:nextProc('step2');return false;">동의하기</button>
					<button class="btn-big btn-danger" onclick="javascript:prevProc('back');return false;">취소</button>
				</div>
			</div>
			<!--// contents -->
			
			<div id="tab-2">
				<!-- form : 정보 입력 -->
				<form name="userSignForm" onsubmit="return false;">
					<div class="join-form">
						<div class="row">
							<div class="col-md-3">이메일주소<span class="required">*</span></div>
							<div class="col-md-5"><input name="email" id="email"  class="form-control signForm" type="text" value="" placeholder="이메일 주소를 입력하세요."></div>
							<div class="col-md-4"><p class="error-msg">	</p></div>
						</div>
						<div class="row">
							<div class="col-md-3">비밀번호<span class="required">*</span></div>
							<div class="col-md-5"><input name="pw" id="pw" class="form-control signForm" type="password" value="" placeholder="비밀번호를 입력하세요." maxlength="20"></div>
							<div class="col-md-4"><p class="error-msg">비밀번호는 6자 이상 20자 이내로 입력해 주세요.</p></div>
						</div>
						<div class="row">
							<div class="col-md-3">비밀번호 확인<span class="required">*</span></div>
							<div class="col-md-5"><input name="pw_confirm" id="pw_confirm" class="form-control signForm" type="password" value="" placeholder="비밀번호를 재입력하세요." maxlength="20"></div>
							<div class="col-md-4"><p class="error-msg">입력하신 비밀번호와 일치하지 않습니다.</p></div>
						</div>
						<div class="row">
							<div class="col-md-3">아이디<span class="required">*</span></div>
							<div class="col-md-5"><input name="login_id" id="login_id" class="form-control signForm" type="text" value="" placeholder="아이디를 입력하세요." maxlength="15"></div>
							<div class="col-md-4"><p class="error-msg"></p></div>
						</div>
						<div class="row">
							<div class="col-md-3">이름<span class="required">*</span></div>
							<div class="col-md-5"><input name="user_nm" id="user_nm" class="form-control signForm" type="text" value="" placeholder="이름을 입력하세요." maxlength="20"></div>
							<div class="col-md-4"><p class="error-msg">이름을 입력하세요.</p></div>
						</div>
					<%-- 	<div class="row">
							<div class="col-md-3">비밀번호찾기 질문/답변 <span class="required">*</span></div>
							<div class="col-md-5">
								<%=CodeUtil.getSelectComboList("PQST", "pw_question", "비밀번호 찾기 질문을 선택하세요.", "", "", "class=\"form-control signForm\"")%>
								<input id="pw_answer" name="pw_answer" class="form-control m-t-5 signForm" type="text" value="" placeholder="비밀번호 찾기 답변을 입력하세요.">
							</div>
							<div class="col-md-4"><p class="error-msg"></p></div>
						</div> --%>
						<!-- <div class="row">
							<div class="col-md-3">이메일 수신 동의</div>
							<div class="col-md-5">
								<input type="radio" value="Y" id="mailing_y" name="mailing_yn"> <label for="mailing_y">예</label>&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" value="N" id="mailing_n" name="mailing_yn" checked> <label for="mailing_n">아니요</label>
							</div>
							<div class="col-md-4"></div>
						</div> -->
					</div>
					<!-- button -->
					<div class="buttons text-center m-t-50 m-b-80">
						<button class="btn-big btn-primary m-r-10" onclick="javascript:nextProc('step3');return false;">회원가입</button>
						<button class="btn-big btn-danger" onclick="javascript:prevProc('step1');return false;">취소</button>
					</div>
					<!--// button -->
				</form>
				<!--// form -->
			</div>
			
			<div id="tab-3">
				<div class="join-end-box">
						<h3>판도라 홈페이지 회원 가입을 축하합니다.</h3>
						<p>회원가입 시 입력하신  이메일로 인증 메일을 전송하였습니다.</p>
						<p>이메일을 확인 후, 메일에 포함된 인증 URL을 클릭하시면 판도라 홈페이지를 정상적으로 이용하실 수 있습니다.</p>
						<br/>
						<p>인증메일이 수신되지 않았을 경우 '스팸함'을 확인해 보시기 바랍니다.</p>
						<p>스팸함에도 인증메일이 수신되지 않았을 경우 아래 '인증메일 재전송'을 선택해 주시기 바랍니다.</p>
				</div>
				<div class="buttons text-center m-t-50 m-b-80">
					<button class="btn-big btn-primary m-r-10" type="button" id="goMain">메인 페이지</button>
					<button class="btn-big btn-danger" type="button" id="callCertMail">인증메일 재전송</button>
				</div>
			</div>	
		</div>
		<!--// container -->
		
		<!-- footer -->
		<footer id="footer">
		<%-- 	<%@ include file="/WEB-INF/views/pandora3Front/common/include/footer.jsp" %>	 --%>
		</footer>
		<!--// footer -->
	</div>
	<!--// wrapper -->

</body>
</html>