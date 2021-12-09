<%-- 
   1. 파일명 : psys1017
   2. 파일설명 : BO회원 가입
   3. 작성일 : 2018-04-16
   4. 작성자 : TANINE
--%>
<?xml version="1.0" encoding="UTF-8" ?>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!-- 헤더파일 include -->

<%@ include file="/WEB-INF/views/pandora3/common/include/meta.jsp" %>
<script type="text/javascript">

var new_usr_id;
var dupIdFlag = false;
$(document).ready(function(){

    // 이용약관 & 개인정보 수집 및 이용에 대한 동의여부
    $('input[type="checkbox"][name="agree"]').change(function(){
        var all_cnt = $("input:checkbox[name=agree]").length;
        var chked_cnt = $("input:checkbox[name=agree]:checked").length;
        var checked = false;
        
        if(all_cnt == chked_cnt)
            checked = true;
        
        $("#signAgreeAll").prop("checked", checked);
    });
    
    // 이용약관 및 개인정보 수집 및 이용에 전체동의
    $('input[type="checkbox"][name="signAgreeAll"]').change(function(){ 
        var checked = $(this).is(":checked");

        $('input[type="checkbox"][name="agree"]').each(function(){
            if(checked)
            {
                if(!$(this).is(":checked"))
                    $(this).prop("checked", checked);
            }
            else
            {
                $(this).prop("checked", checked);
            }
        });
    });
    
    
    // 메인으로 가기 클릭
    $("#goMain").click(function(){
        window.top.location.href= _context + '/login/forward.login.adm';
    });
    
    // 로그인 아이디 영문 숫자만 입력되도록
    $("#lgn_id").on("keyup change", function () {
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
        }
    });
    // 포커스 아웃 시
    $("#lgn_id").on("blur", function () {
        var $that = $(this);
        
        if($("#lgn_id").val().length > 3) {
            
               ajax({
                    url: "/psys/getPsys1009UsrInfVldYn"
                   , data : {lgn_id : $(this).val()}
                   , success : function (data) {
                       
                       if(data.RESULT == _boolean_success) {
                           
                           if(data.lgnIdVldYn == "N") {
                               $that.closest("tr").find(".error-msg").show();
                               $that.closest("tr").find(".error-msg").text("사용 불가능한 아이디입니다.");
                               dupIdFlag = false;
                           } else {
                               $that.closest("tr").find(".error-msg").show();
                               $that.closest("tr").find(".error-msg").text("사용 가능한 아이디입니다.");
                               dupIdFlag = true;
                           }
                       }
                   }
               });
        } else {
            $that.closest("tr").find(".error-msg").show();
            $that.closest("tr").find(".error-msg").text("아이디를 3글자 이상 입력해주세요.");
        }
    });   
    
    $("#registerBtn").on("click", function () {
        
        
        if(!$("#signAgree1").prop("checked")) {
            alert("이용약관에 동의해주시기 바랍니다.");
            $("#signAgree1").focus();
            return false;
        }
        
           // 입력값 유효성 체크
        if(fn_validationCheck()) {
            // DB정보 확인(이메일 / 아이디)
            fn_userInfoCheck();
        }
        
    });
    
    
    getVipRolList();
    
    $("#rol_id").on("change", function () {
        $("#rol_nm").val($(this).find("option:selected").text());
    });
});


function getVipRolList() {
    
    ajax({
        url     : "/psys/selectVipRolList",
        success : function (data) {
            if (data.RESULT == _boolean_success) {
                var html = "";
                $(data.rows).each(function (index){
                    html += "<option value="+ this.ROL_ID +">"+ this.ROL_NM +"</option>"
                });
                $("#rol_id").append(html);
            }
        }

    });
    
}

//입력값 유효성/필수 체크
function fn_validationCheck(){
    
    var msg = "";
    
    $(".error-msg").hide();
    
       // 로그인 아이디 : 필수체크
    if($("#lgn_id").val().length < 4) {
        $("#lgn_id").closest("tr").find(".error-msg").show();
        $("#lgn_id").closest("tr").find(".error-msg").text("아이디를 입력해주세요.");
        $("#lgn_id").focus();
        return false;
    }

    //회원아이디 중복
    if(!dupIdFlag) {
        alert("아이디가 중복되었습니다.");
         $("#lgn_id").closest("tr").find(".error-msg").show();
         $("#lgn_id").closest("tr").find(".error-msg").text("사용 불가능한 아이디입니다.");
        return false;
    }
    
    // 유저명
    if($("#usr_nm").val().length < 2) {
        $("#usr_nm").closest("tr").find(".error-msg").show();
        $("#usr_nm").closest("tr").find(".error-msg").text("아이디를 입력해주세요.");
        $("#usr_nm").focus();
        return false;
    }
    
    // 패스워드 
    var lgn_pwd = $("#lgn_pwd").val();

    if(!chkPwd(lgn_pwd)) {
        $("#lgn_pwd").closest("tr").find(".error-msg").show();
        $("#lgn_pwd").closest("tr").find(".error-msg").text("비밀번호는 6자 이상 20자 이내로 입력해 주세요.");
        $("#lgn_pwd").focus();
        return false;
    }
    // 패스워드 확인
    if($("#lgn_pwd").val() != $("#lgn_pwd_cfm").val()) {
        $("#lgn_pwd_cfm").closest("tr").find(".error-msg").show();
        $("#lgn_pwd_cfm").closest("tr").find(".error-msg").text("입력하신 비밀번호와 일치하지 않습니다.");
        $("#lgn_pwd_cfm").focus();
        return false;
    }
    
    var regExp = /^\d{3}-\d{3,4}-\d{4}$/;
    
    var usr_mbl_no = $("#usr_mbl_no_1").val() + "-" + $("#usr_mbl_no_2").val() + "-" + $("#usr_mbl_no_3").val();
    if(!regExp.test(usr_mbl_no)) {
       $("#usr_mbl_no_1").closest("tr").find(".error-msg").show();
       $("#usr_mbl_no_1").closest("tr").find(".error-msg").text("휴대 전화 번호를 올바르게 입력해주세요.");
       
       return false;
    }
    
    // 소속회사 명
    if($("#blco_nm").val().length < 2) {
        $("#blco_nm").closest("tr").find(".error-msg").show();
        $("#blco_nm").closest("tr").find(".error-msg").text("소속회사를 입력해주세요.");
        $("#blco_nm").focus();
        return false;
    }
    
    // 권한 선택
    
    if(isEmpty($("#rol_id").val())) {
        $("#rol_id").closest("tr").find(".error-msg").show();
        $("#rol_id").closest("tr").find(".error-msg").text("신청할 권한을 선택해주세요.");
        $("#rol_id").focus();
        return false;
    }
    
    
    return true;
}

// DBCheck
function fn_userInfoCheck(){

    $.ajax({
        type    : "POST",
        url     : _context + '/psys/savePsys1017.do',
        data    : $("form[name=userSignForm]").serialize(),
        dataType: "json",
        success : function(data){
            if(data.RESULT == "S" && isNotEmpty(data.NEW_USR_ID)) {
                new_usr_id = data.NEW_USR_ID;
                alert("회원가입이 완료되었습니다.");
                window.top.location.href= _context + '/login/forward.login.adm';
            }
            else
                alert("회원 등록 중 오류가 발생했습니다.\n잠시 후 다시 시도하세요");
        }
    });
}


function onlyNumber(event) {
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 9 || keyID == 46 || keyID == 37 || keyID == 39 ) 
        return;
    else
        return false;
}

function removeChar(event) {
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
        return;
    else
        event.target.value = event.target.value.replace(/[^0-9]/g, "");
}


</script>
<style>
/* íšŒì›ê°€ìž… */
.join_type{background:#e8e8e8;}
.join_type .txt_pw input{height:30px; line-height:30px;}
.join_type .error-msg{color:red;}
.join_type .main_title{position: relative; font-size: 35px; height:40px; line-height: 40px; font-family: 'Noto Sans KR', sans-serif; text-align: center;}
.join_type .join_area{width:1090px; margin:50px auto; padding:20px; background: #fff; border: 1px solid #ddd;}
.join_type .join_area .term_agree{padding:20px 0;}
.join_type .join_area .term_agree .title{padding:20px 0; height: 23px; line-height: 23px; font-size: 20px; color: #333333; font-weight: 400; font-family: "Noto Sans KR", Dotum, ë‹ì›€, sans-serif;}
.join_type .join_area .term_agree .desc{overflow-y:auto; height:150px; border:1px solid #ddd; padding:10px;}
.join_type .join_area .term_agree .desc .content{padding:20px; background: #ffffff; padding: 0 6px 0 5px; font-size: 12px; color: #666; font-family: 'Dotum', 'ë‹ì›€', sans-serif;}

.join_type .agree_check{margin-top:5px; text-align:right;}
.join_type .agree_check.type_all{text-align: center; margin: 10px 0;}

.join_type .tblType1 tr td,
.join_type .tblType1 tr th{border-left:0 none; padding:13px 10px 12px;}
.join_type .tblType1 tr td{}
.join_type .tblType1 tr td:first-child,
.join_type .tblType1 tr th:first-child{border-right:1px solid #ccc;}

.join_type .tblType1 .join_phone{font-size:0;}
.join_type .tblType1 .join_phone .txt_pw{display:inline-block; vertical-align:top; width:30%; font-size: 12px;}
.join_type .tblType1 .join_phone .space{display:inline-block; vertical-align:top; width:5%; height:30px; line-height:30px; text-align:center;}
.join_type .bottomBtnWrap .btn_common{width:85px; height:40px; line-height:40px;}
.join_type .tblType1 .select{height:30px; line-height:30px;}
</style>
</head>
<body class="join_type">
    <!-- wrapper -->
    <div id="wrapper">
        <!-- container -->
        <div class="contents-container join_area">
            <!-- contents -->
            <div id="tab-1">
                <h1 class="main_title">회원가입</h1>
                <div class="term_agree">
                    <h2 class="title">정보보호 서약서</h2>
                    <div class="desc">
                        <div class="content"><c:out value="${tmbrCluArr[0].clu_cts}" /></div>
                    </div>
                    <h2 class="title">개인정보수집동의</h2>
                    <div class="desc">
                        <div class="content"><c:out value="${tmbrCluArr[1].clu_cts}" /></div>
                    </div>
                    <div class="agree_check">
                        <div class="tableCheck">
                            <label class="container typeInspect" for="signAgree1">이용 약관에 동의합니다.<input type="checkbox" id="signAgree1" name="agree">
                                <span class="checkmark"></span>
                            </label>
                        </div>
                    </div>
                </div>
                
                <div class="user_input_area">
                    <form name="userSignForm" method="post">
                        <input type="hidden" value="" name="rol_nm" id="rol_nm" />
                        <table class="tblType1">
                            <colgroup>
                                <col style="width: 20%">
                                <col style="width: 60%">
                                <col style="width: 20%">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>
                                        <label for="lgn_id" class="vv necessary">아이디</label>
                                    </th>
                                    <td>
                                        <span class="txt_pw">
                                            <input name="lgn_id" id="lgn_id" class="" type="text" placeholder="영문자, 숫자 포함 3글자에서 15글자내로 입력해주세요." maxlength="15">
                                        </span>
                                    </td>
                                    <td>
                                        <span class="error-msg"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <label for="usr_nm" class="vv necessary">이름</label>
                                    </th>
                                    <td>
                                        <span class="txt_pw">
                                            <input name="usr_nm" id="usr_nm" class="" type="text" value="" placeholder="이름을 입력하세요." maxlength="20">
                                        </span>
                                    </td>
                                    <td>
                                        <span class="error-msg"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <label for="lgn_pwd" class="vv necessary">비밀번호</label>
                                    </th>
                                    <td>
                                        <span class="txt_pw">
                                            <input name="lgn_pwd" id="lgn_pwd" class="form-control signForm w100" type="password" value="" onkeyup="noSpaceForm(this)" onchange="noSpaceForm(this)"
                                            placeholder="영문자,숫자, 특수문자를 혼하하여 6자이상 20자 이내로 입력해주세요." maxlength="20">
                                        </span>
                                    </td>
                                    <td>
                                        <span class="error-msg"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <label for="lgn_pwd_cfm" class="vv necessary">비밀번호 확인</label>
                                    </th>
                                    <td>
                                        <span class="txt_pw">
                                            <input name="lgn_pwd_cfm" id="lgn_pwd_cfm" class="form-control signForm w100" type="password"  onkeyup="noSpaceForm(this)"
                                                onchange="noSpaceForm(this)" placeholder="비밀번호를 재입력하세요." maxlength="20">
                                        </span>
                                    </td>
                                    <td>
                                        <span class="error-msg"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <label for="usr_mbl_no_1" class="vv necessary">휴대 전화</label>
                                    </th>
                                    <td class="join_phone">
                                        <span class="txt_pw">
                                            <select name="usr_mbl_no_1" id="usr_mbl_no_1" class="select form-control signForm width-25">
                                                <option>010</option>
                                                <option>011</option>
                                                <option>016</option>
                                                <option>017</option>
                                                <option>018</option>
                                                <option>019</option>
                                            </select>
                                        </span>
                                        <span class="space">-</span>
                                        <span class="txt_pw">
                                            <input name="usr_mbl_no_2" id="usr_mbl_no_2" class="form-control signForm width-25" type="text" value="" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' maxlength="4">
                                        </span>
                                        <span class="space">-</span>
                                        <span class="txt_pw">
                                            <input name="usr_mbl_no_3" id="usr_mbl_no_3" class="form-control signForm width-25" type="text" value="" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' maxlength="4">
                                        </span>
                                    </td>
                                    <td>
                                        <span class="error-msg"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <label for="blco_nm" class="vv necessary">소속회사</label>
                                    </th>
                                    <td>
                                        <span class="txt_pw">
                                            <input name="blco_nm" id="blco_nm" class="form-control signForm w100" type="text" value="" placeholder="소속회사를 입력해주세요." maxlength="100">
                                        </span>
                                    </td>
                                    <td>
                                        <span class="error-msg"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <label for="rol_id" class="vv necessary">신청권한</label>
                                    </th>
                                    <td class="join_phone">
                                        <span class="txt_pw">
                                            <select name="rol_id" id="rol_id" class="select form-control signForm width-25">
                                                <option value="">선택</option>
                                            </select>
                                        </span>
                                    </td>
                                     <td>
                                        <span class="error-msg"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <label for="서비스" class="vv necessary">모점/자점</label>
                                    </th>
                                    <td class="join_phone">
                                        <span class="txt_pw">
                                            <select name="서비스" id="서비스" class="select form-control signForm width-25">
                                                <option value="">선택</option>
                                            </select>
                                            <select name="서비스" id="서비스" class="select form-control signForm width-25">
                                                <option value="">선택</option>
                                            </select>
                                        </span>
                                    </td>
                                    <td>
                                        <span class="error-msg"></span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                    <div class="bottomBtnWrap nonFloating">
                        <button type="button" class="btn_common btn_dark" id="registerBtn">회원가입</button>
                        <button type="button" class="btn_common btn_gray">취소</button>
                    </div>
                </div>
            <!--// contents -->
            </div>
        <!--// container -->
        </div>
    </div>
    <!--// wrapper -->
</body>
</html>