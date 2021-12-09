<%-- 
   1. 파일명 : psys1049
   2. 파일설명 : VIP 권한 신청 
   3. 작성일 : 2019-10-10
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_header.jsp" %>
<script type="text/javascript">
var rol_grid;
$('#b-iframe', parent.document).closest(".layer_popup").find(".btn_layer_close2").css("display", "none");
$(document).ready(function() {
    
    $("#btn_close").click(function() {
        ajax({
                url     :'/main/logout',
                success : function(data){
                    parent.$('.layer_popup').bPopup().close();
                }
            });
    });
    
    
    $("#rol_id").on("change", function () {
        $("#rol_nm").val($(this).find("option:selected").text());
    });
    
    
    $("#athr_app_btn").on("click", function() {
        if(fn_validationCheck()) {
            
            // 권한 신청
            ajax({
                url : '/main/saveApplRol.adm',
                data : $("#athrAppForm").serialize(),
                success : function (data) {
                    ajax({
                        url     :'/main/logout',
                        success : function(data){
                            alert("권한 신청이 완료되었습니다.");
                            
                            //프레임이 아닐경우.
                            if(isEmpty(_menu_id) || _menu_id == "null") {
                                parent.$('.layer_popup').bPopup().close();
                            }
                        }
                    });
                }
            })
            
        }
    });
    
    ajax({
        url     : "/main/getUserSystemRolInfo",
        success : function (data) {
            if (data.RESULT == _boolean_success) {
                if(isEmpty(data.SITINFO) || isEmpty(data.USERINFO)) {
                    alert("사용자 또는 시스템 정보가 잘못되었습니다.");
                    return false;
                } else if (isEmpty(data.ROLLIST)) {
                    alert("신청할 권한이 존재하지 않습니다.");
                    return false;
                } else {
                    //권한 
                    var html = "";
                    $(data.ROLLIST).each(function (index){
                        html += "<option value="+ this.ROL_ID +">"+ this.ROL_NM +"</option>"
                    });
                    $("#rol_id").append(html);
                    
                    //사이트
                    $("#sys_nm").val(data.SITINFO.SYS_NM);
                    $("#sys_cd").val(data.SITINFO.SYS_CD);
                    
                    //로그인 사용자
                    $("#usr_id").val(data.USERINFO.USR_ID);
                    $("#usr_nm").val(data.USERINFO.USR_NM);
                    $("#org_cd").val(data.USERINFO.ORG_CD);
                    $("#org_nm").val(data.USERINFO.ORG_NM);
                    
                }


            }
        }

    });
    
    
    
    
});

function fn_validationCheck() {
    
    
    var rol_id = $("#rol_id").val();
    var appl_rsn_cont = $("#appl_rsn_cont").val();
    
    if(isEmpty(rol_id)) {
        alert("권한을 선택해주세요.");
        return false;
    }
    
    if(isEmpty(appl_rsn_cont)){
        alert("신청 사유를 입력해주세요.");
        return false;
    }
    
    
    return true;
}

$(window).resize(function() {
    rol_grid.setGridWidth($('.tblType1').width());
});
</script>
</head>
<body id="pop">
    <div class="frameWrap">
        <div class="subCon">
            <h1><%=_title %></h1>
            <div class="subConIn">
                <div class="subConScroll">
                    <!-- 조회조건 -->
                    <form name="athrAppForm" id="athrAppForm" name="athrAppForm" onsubmit="return false">
                        <input type="hidden" value="" name="sys_cd" id="sys_cd" />
                        <input type="hidden" value="" name="org_cd" id="org_cd" />
                        <input type="hidden" value="" name="org_nm" id="org_nm" />
                        <input type="hidden" value="" name="rol_nm" id="rol_nm" />
                        <div class="frameTopTable">
                            <table class="tblType1">
                                <colgroup>
                                    <col width="85px;" />
                                    <col width="" />
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th>
                                            <label for="usr_id" class="vv">사원번호</label>
                                        </th>
                                        <td>
                                            <span class="txt_pw">
                                                <input name="usr_id" id="usr_id" class="" type="text" placeholder="아이디를 입력하세요." maxlength="15">
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            <label for="usr_nm" class="vv">사원명</label>
                                        </th>
                                        <td>
                                            <span class="txt_pw">
                                                <input name="usr_nm" id="usr_nm" class="" type="text" value="" placeholder="이름을 입력하세요." maxlength="20">
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            <label for="sys_nm" class="vv">시스템명</label>
                                        </th>
                                        <td>
                                            <span class="txt_pw">
                                                <input name="sys_nm" id="sys_nm" class="form-control signForm w100" type="text" value="" >
                                            </span>
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
                                    </tr>
                                    <tr>
                                        <th>
                                            <label for="appl_rsn_cont" class="vv necessary">신청사유</label>
                                        </th>
                                        <td>
                                            <span class="txt_pw">
                                                <input name="appl_rsn_cont" id="appl_rsn_cont" class="form-control signForm w100" type="text" value="" placeholder="신청사유를 입력해주세요." maxlength="100">
                                            </span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="grid_btn">
            <button type="button" class="btn_layer_close btn_common btn_gray" name="athr_app_btn" id="athr_app_btn">신청</button>
            <button type="button" class="btn_layer_close btn_common btn_gray" name="btn_close" id="btn_close">닫기</button>
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_footer.jsp" %>
