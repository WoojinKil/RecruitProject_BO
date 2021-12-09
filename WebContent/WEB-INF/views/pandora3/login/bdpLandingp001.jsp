<%-- 
   1. 파일명 : loginp001
   2. 파일설명 : 권한 신청 
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
    
    
    var rol_config = { 
        gridid      : 'rol_grid',
        pagerid     : 'rol_grid_pager',
        columns     : [
            {name : 'ROL_ID', label : '권한ID',  hidden:true},
            {name : 'USR_ID', label : '사용자ID', hidden:true},
            {name : 'USR_NM', label : '사용자명', hidden:true},
            {name : 'MSTR_CD', label : '모점코드', hidden:true},
            {name : 'MSTR_NM', label : '모점명', hidden:true},
            {name : 'CSTR_CD', label : '자점코드', hidden:true},
            {name : 'CSTR_NM', label : '자점명', hidden:true},
            {name : 'POS_CD', label : '직책코드', hidden:true},
            {name : 'POS_NM', label : '직책명', hidden:true},
            {name : 'SYS_NM', label : '사이트명', hidden:true},
            {name : 'USR_NM', label : '사용자명', hidden:true},
            {name : 'APVL_YN', label : '승인여부', hidden:true},
            {name : 'ORG_CD', label : '회원조직코드', hidden:true},
            {name : 'ORG_NM', label : '회원조직명', hidden:true},
            {name : 'APPL_STAT_CD', label : '신청 상태 코드', hidden:true},
            {name : 'SYS_CD', label : '시스템 이름', align : 'center', editable : false, edittype : 'select', formatter : 'select', editoptions : {value:'<c:out value="<%=CodeUtil.getSitGridComboList()%>" />'}, width : 100},
            {name : 'ROL_NM', label : '권한명', editable : false, align : 'center', edittype : 'text', width : 200, editoptions : {maxlength:300}},
            {name : 'F_APL_ST_DT', label : '적용시작일자', align : 'center', editable : false, width : 120}, 
            {name : 'F_APL_ED_DT', label : '적용종료일자', align : 'center', editable : false, width : 120},
            {name : 'F_UPD_DTTM', label : '변경일자', align : 'center', editable : false, width : 100},
        ],
        editmode    :  true,                            // 그리드 editable 여부
        gridtitle   : '권한 목록',                          // 그리드명
        height      : 300,                              // 그리드 높이
        selecturl   : '/main/selectTsysAdmOrgGrpRolList.adm',// 그리드 조회 URL
        saveurl     : '/main/saveApplRol.adm',           // 그리드 저장
        events      : {
        }
    };
    rol_grid = new UxGrid(rol_config);
    rol_grid.init();
    rol_grid.setGridWidth($('.tblType1').width());
    
    
    //권한 조회
    rol_grid.retreive();
    
    //신청하기 버튼 클릭
    $("#athr_app_btn").on("click", function () {
        
        
        var rowIds = rol_grid.getDataIDs();
        
        for(var i = 0; i < rowIds.length; i++) {
            $("#rol_grid").jqGrid('setCell', rowIds[i], 'APPL_STAT_CD', '60');
            $("#rol_grid").jqGrid('setCell', rowIds[i], 'JQGRIDCRUD', 'C');
            $("#rol_grid").jqGrid('setCell', rowIds[i], 'APVL_YN', 'Y');
        }
        
        rol_grid.save({success:function(){
        	parent.fn_landingReload();
        }});
        
        parent.$('.layer_popup').bPopup().close();
        
    })
    
    
    
});

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
                    <form name="search" id="search" name="search" onsubmit="return false">
                        <div class="frameTopTable">
                            <table class="tblType1">
                                <colgroup>
                                    <col width="85px;" />
                                    <col width="" />
                                </colgroup>
                            </table>
                        </div>
                    </form>
                    
                    <!-- 조회조건  // -->
                    <!-- Grid -->
                    <table id="rol_grid"></table>
                    <div id="rol_grid_pager"></div>
                    <!-- Grid // -->
                </div>
            </div>
        </div>
        <div class="grid_btn">
            <button type="button" class="btn_layer_close btn_common btn_gray" name="athr_app_btn" id="athr_app_btn">확인</button>
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_footer.jsp" %>
