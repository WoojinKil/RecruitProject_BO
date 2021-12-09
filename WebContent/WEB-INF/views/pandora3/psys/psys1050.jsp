<%--
   1. 파일명   : psys1050
   2. 파일설명: 조직별직책권한관리
   3. 작성일   : 2020-02-28
   4. 작성자   : TANINE
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>

<script type="text/javascript">

//zTree Setting
var _tree_setting = {
    view    : {selectedMulti : false},
    edit    : {enable : false, showRemoveBtn : false, showRenameBtn : false},
    data    : {keep : {parent : true, leaf : true},
               simpleData : {enable : true, idKey: "id", pIdKey : "pId", rootPId : 0}
    },
    callback: {
        onClick     : fn_onClick,
    }
};

$(document).ready(function(){

    // 공통코드 설정  - BDP0011 : 조직별등급관리 , BDP0012 : 직무관리, BDP0013 : 직책관리, BDP0014 : 시스템구분관리
    $("#mst_cd_arr").val(new Array('BDP0011','BDP0012','BDP0013', 'BDP0014'));

    // 공통코드 조회
    fn_psysCommonSearch();

    var adm_grid_config = {
        gridid      : 'adm_grid',
        pagerid     : 'adm_grid_pager',
        gridBtnYn   : 'Y',                  // 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        columns     : [
                        {name:'STATUS', label:'상태', align:'center', editable:false, width:20},
                        {name : 'GRP_ROL_ID'    , label : '통합그룹코드', hidden : true},
                        {name : 'ORG_CD'     , label : '조직코드'  , hidden : true},
                        {name : 'HR_POS_CD'    , label : '직책코드'  , hidden : true},
                        {name : 'JOB_CD'       , label : '직무코드'  , hidden : true},
                        {name : 'CSTR_CD'       , label : '자점코드'  , hidden : true},
                        {name : 'SYS_CL_CD'     , label : '시스템구분코드'  , hidden : true},
                        {name : 'GRP_ROL_NM'    , label :'통합그룹권한명',align : 'left', editable : false},
                        {name : 'SYS_CL_NM'     , label :'시스템<br>구분명' ,align : 'center', editable : false, width: 80},
                        {name : 'HR_POS_NM'    , label :'직책명'     ,align : 'left', editable : false},
                        {name : 'JOB_NM'       , label :'직무명'     ,align : 'left', editable : false},
                        {name : 'SHOP_GRDE_CD'  , label :'매장<br>그룹코드' ,align : 'center', editable : false, width: 80},
                        {name : 'BUY_GRDE_CD'   , label :'매입<br>그룹코드' ,align : 'center', editable : false, width: 80},
                        {name : 'CSTR_NM'       , label :'소속점'     ,align : 'left', editable : false, width: 80},
                        {name : 'MSTRS_USPR_ID' , label :'BI라이센스'  ,align : 'left', editable : false},
                        {name : 'EXCV_YN' , label :'임원여부'  ,align : 'left', editable : false},
                       ],
        editmode    : true,                                // 그리드 editable 여부
        gridtitle   : '직책 권한 목록',                          // 그리드명
        formid      : 'search',                             // 조회조건 form id
        height      : 200,                                  // 그리드 높이
        multiselect    : true,                             		    // checkbox 여부
        shrinkToFit : true,                                 // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현
        selecturl   : '/psys/getPsys1050OrgAthrList',       // 그리드 조회 URL
        events      : {
                         onSelectRow: function(event, rowid) {

                         },
                         ondblClickRow : function (event, rowid, irow, icolondblClickRow) {
                        	var row = adm_grid.getRowData(rowid);
                            // 하단 폼 데이터 세팅
                            fn_detailInfoSetting(row);
                         }

                       }
    };
    adm_grid = new UxGrid(adm_grid_config);
    adm_grid.init();
    adm_grid.setGridWidth($('#table_org').width());

    // 조직 목록 조회 (트리)
    fn_getOrgTree();

    // 통합권한그룹 및 자점 리스트 조회 (select box 목록)
    fn_getSelListSearch()
});

//grid resizing
$(window).resize(function() {
  adm_grid.setGridWidth($('#table_org').width());
});

/******************************
 * 트리 제어
 ******************************/

// 노드 클릭 이벤트
function fn_onClick(event, id)
{
	// 우측 영역 초기화
    fn_reset();

    var tree = $.fn.zTree.getZTreeObj("tree_org")
    var node = tree.getSelectedNodes();
    var org  = node[0];

    // status 리셋
    $("#status").val("");

    // 선택한 조직의 구성원 조회
    adm_grid.retreive({data:{org_cd:org.id}});

    // 조직코드 세팅
    $("#org_cd").val(org.id);

    tree.selectNode(org);
}

/******************************
 * 컴포넌트 이벤트
 ******************************/

//BI라이센스 클릭 시 팝업 호출
function btn_onclick_PopSearch () {

  var org_cd = $("#org_cd").val();

  if(isEmpty($("#org_cd").val())) {
      alert('조직을 선택하세요.');
      return false;
  }

  // 팝업 호출
  bpopup({
      url:"/psys/forward.psys1050p001.adm"
    , params    : {callback : "fn_CallBack_setInfo", target_id : _menu_id, bi_mstrs_cd : $("#inp_mstrs_uspr_id").val()}
    , title     : "BI 라이센스 목록"
    , type      : "m"
    , height    : "450px"
    , id        : "psys1050p001"
});
}
//BI라이센스 팝업 콜백
function fn_CallBack_setInfo(row)
{
  $("#inp_mstrs_uspr_id").val(row.BI_MSTRS_CD);
}

// 상세 영역 초기화
function fn_reset()
{
    // 폼 영역 초기화
    $("#form_org").reset();

    // 비활성화
    fn_disableControl(true);

    // 상태값 초기화
    $('#status').val('');
}

// 그리드 row 클릭 시 하단 폼 데이터 세팅
function fn_detailInfoSetting(rowInfo)
{
     // 활성화
     fn_disableControl(false);

	 $("#sel_hr_pos_cd").val(rowInfo.HR_POS_CD);       // 직책코드
     $("#sel_job_cd").val(rowInfo.JOB_CD);             // 직무코드
     $("#sel_grp_rol_id").val(rowInfo.GRP_ROL_ID);       // 통합권한그룹코드
     $("#sel_cstr_cd").val(rowInfo.CSTR_CD);             // 소석점코드
     $("#sel_shop_grde_cd").val(rowInfo.SHOP_GRDE_CD);   // 매장등급코드
     $("#sel_buy_grde_cd").val(rowInfo.BUY_GRDE_CD);     // 매입등급코드
     $("#sel_sys_cls_cd").val(rowInfo.SYS_CL_CD);         // 시스템구분코드
     $("#inp_mstrs_uspr_id").val(rowInfo.MSTRS_USPR_ID); // BI라이센스
     $("#excv_yn").val(rowInfo.EXCV_YN); // BI라이센스
     $("#status").val("U");                              // 상태값 업데이트

     // 비활성화
     $("#sel_grp_rol_id").prop("disabled", true);        // 통합권한그룹코드
     $("#sel_sys_cls_cd").prop("disabled" , true);        // 시스템구분코드
}

// 하단 폼 disabled 제어
function fn_disableControl(type)
{
    $('#form_org .select').prop("disabled", type);
    $('#form_org .text').prop("disabled"  , type);
    $('#btn_mstrs_pop').prop("disabled"   , type);
}
/******************************
 * 공통 버튼
 ******************************/

// 공통 - 조회 버튼
function fn_Search() {

    //그리드 초기화
    adm_grid.clearGridData();

    // 우측 영역 초기화
    fn_reset();

    // 조직 목록(트리) 조회
    fn_getOrgTree();
}

// 공통 - 저장 버튼
function fn_Save()
{
    if(isEmpty($("#org_cd").val())) {
         alert('조직을 먼저 선택하세요.');
         return false;
     }

    // 필수체크
    if(gfn_checkFormEmpty("form_org")) {
        return false;
    }

    if(!confirm("저장하시겠습니까?")){
        return false;
    }
    // 비활성화 시 select box disable 된 data 값 안넘어가서 활성화로 변경
    fn_disableControl(false);

    fn_savePsys();
}

// 공통 - 신규버튼()
function fn_New()
{
    if(isEmpty($("#org_cd").val()) || org_cd < 1) {
        alert('조직을 먼저 선택하세요.');
        return false;
    }

    // 폼 화면 리셋
    fn_reset();

	// 활성화
     fn_disableControl(false);

    // 상태 신규로 변경
    $("#status").val("C");

}

//마스터 행삭제 버튼 클릭 시
function fn_Delete() {
	adm_grid.remove( {success:function(){adm_grid.init();}});
}
/******************************
 * Server
 ******************************/
// 공통코드 조회
function fn_psysCommonSearch()
{
    ajax({
        url     : '/psys/getPsysCommon',
        data    : $("form[name=frm_sysCdDtl]").serialize(),
        success : function(data) {

           for(i=0; i<data.selectData.length; i++){
               // 등급코드
               if(data.selectData[i].MST_CD == "BDP0011"){
                   $("#sel_shop_grde_cd").append("<option value='" + data.selectData[i].CD_NM + "'>" + data.selectData[i].CD_NM + "</option> ");  // 매장등급코드
                   $("#sel_buy_grde_cd").append("<option value='"  + data.selectData[i].CD_NM + "'>" + data.selectData[i].CD_NM + "</option> ");   // 매입등급코드
               }

               // 직무코드
               if(data.selectData[i].MST_CD == "BDP0012")
                   $("#sel_job_cd").append("<option value='" + data.selectData[i].REF_1 + "'>" + data.selectData[i].REF_1 + " | " + data.selectData[i].CD_NM + "</option> ");

               // 직책코드
               if(data.selectData[i].MST_CD == "BDP0013")
                   $("#sel_hr_pos_cd").append("<option value='" + data.selectData[i].REF_1 + "'>" + data.selectData[i].REF_1 + " | " + data.selectData[i].CD_NM + "</option> ");

               // 시스템구분코드
               if(data.selectData[i].MST_CD == "BDP0014")
                   $("#sel_sys_cls_cd").append("<option value='" + data.selectData[i].REF_1 + "'>" + data.selectData[i].REF_1 + " | " + data.selectData[i].CD_NM + "</option> ");
            }
        }
    });
}

// 통합권한그룹 및 자점 리스트 조회
function fn_getSelListSearch()
{
    ajax({
        url         : '/psys/getPsys1050SelList.adm',
        success     : function(data){
            // 통합권한그룹 리스트
        	for(i=0; i<data.grpRolList.length; i++){
                $("#sel_grp_rol_id").append("<option value='" + data.grpRolList[i].GRP_ROL_ID + "'>" + data.grpRolList[i].GRP_ROL_ID + " | " + data.grpRolList[i].GRP_ROL_NM + "</option> ");
            }
            // 소속점 리스트
            for(i=0; i<data.cstrList.length; i++){
                $("#sel_cstr_cd").append("<option value='" + data.cstrList[i].CSTR_CD + "'>"+ data.cstrList[i].CSTR_CD + " | " + data.cstrList[i].CSTR_NM + "</option> ");
            }
        }
    });
}

//조직 목록 조회 (트리)
function fn_getOrgTree(org_cd)
{
    ajax({
        url         : '/psys/getPsys1031List01.adm',
        success     : function(data){

            $.fn.zTree.init($("#tree_org"), _tree_setting, data.mapList);

            if(isNotEmpty(org_cd)) {
                var tree = $.fn.zTree.getZTreeObj("tree_org");
                var node = tree.getNodesByParam("id", parseInt(org_cd, 10), null)

                if(node.length > 0) {
                    $("#" + node[0].tId + "_a").trigger('click');
                }
            }
        }
    });
}

// 직책권한 매핑 저장
function fn_savePsys()
{
	 var amdgriddata = getSaveData("adm_grid");
	 var data  = "amdgriddata="+amdgriddata+"&_pre_url="+parent.preUrl.getPreUrl()+"&"+$("form[name=form_org]").serialize();
	 console.log(amdgriddata);
	 console.log("data1: ", $.isEmptyObject(amdgriddata));
	 if(JSON.parse(amdgriddata).length <= 0 && typeof(masterdata) == 'undefined' && isEmpty($("#status").val())) {
		 alert("변경 사항이 없습니다.");
	        return ;
	 }
    ajax({
        url  : '/psys/savePsys1050OrgAthr',
        data : data,
        async : false,
        success: function(data) {
            console.log(data.RESULT);
            console.log(data);
            if(data.RESULT == "S") {
                alert('저장되었습니다');
                $('#form_org').clearFormData();
                //fn_Search();
                //전체 조직 취득
                var allOrg = $.fn.zTree.getZTreeObj("tree_org");
                //선택 조직 취득
                var selOrg = allOrg.getSelectedNodes();
                $("#" + selOrg[0].tId + "_a").click();
                return;
            } else if(data.RESULT == "F" && !isEmpty(data.MGS)){
                alert(data.MGS);
                return;
            } else {
                alert("일시적 오류입니다\n잠시후 다시 시도하세요.")
                e.preventDefault();
                return;
            }
        }
    });
}
var expand_count = 0;
function tree_all(thisobj) {
    var $this = $(thisobj);

    var zTree = $.fn.zTree.getZTreeObj("tree_org"),
    type = $(thisobj).attr("data-type");

    var totNodes = zTree.getNodes();
    var nodes =totNodes[0].children;

    if (type == "expandAll" && expand_count == 0) {
        $(thisobj).attr("data-type", "collapseAll");
        $this.text("전체닫기");
        $this.addClass("on");
        zTree.expandAll(true);

        expand_count++;

    } else if (type == "collapseAll" && expand_count == 1) {
        $(thisobj).attr("data-type", "expandAll");
        $this.text("전체열기");
        $this.removeClass("on");
        zTree.expandAll(false);

        expand_count = 0;
    }
}

function selOnduCd(target){
	var findStr = $(target).find("option:selected").val() ;
	if(findStr==""){
		$('#sel_hr_pos_cd').val("");
		$('#sel_job_cd').prop("disabled", false);
	}else{
		$('#sel_job_cd').prop("disabled", true);
	}
}

function selJbfnCd(target){
	var findStr = $(target).find("option:selected").val() ;
	if(findStr==""){
		$('#sel_job_cd').val("");
		$('#sel_hr_pos_cd').prop("disabled", false);
	}else{
		$('#sel_hr_pos_cd').prop("disabled", true);
	}
}

</script>
</head>
<body>
    <div class="frameWrap">
        <div class="subCon on clear">
            <%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
            <div class="treeWrap">
                <div class="treeInner">
                    <!--  메뉴 구성 -->
                    <div class="tblType1 menuEdit treeList">
                        <div class="leftTop">
                            <h3>조직구성</h3>
                            <div class="treeBtn">
                                <button class="btn_common btn_default treeOpen" data-type="expandAll" id="tree_all" onclick="tree_all(this)">
                                    전체열기
                                </button>
                            </div>
                        </div>
                        <div class="leftBottom">
                            <ul id="tree_org" class="ztree menuEdit h590">

                            </ul>
                        </div>
                    </div>
                    <!-- 조직 상세 정보 -->
                    <div class="detailInfo">
                        <table id="adm_grid"></table>
                        <div class="menuInfo">
                            <div class="tableTop first">
                                <h3 class="title">상세정보</h3>
                            </div>
                            <form name="form_org" id="form_org" enctype="multipart/form-data" method="post" onsubmit="return false;">
                                <input type="hidden" name="status"       id="status" />
                                <input type="hidden" name="org_cd"    id="org_cd" />
                                <table id="table_org" class="tblType1">
                                    <tr>
                                        <th>
                                            <label for="sel_grp_rol_id" class="vv necessary">통합권한그룹코드</label>
                                        </th>
                                        <td colspan="2">
                                            <span class="txt_pw">
                                                <select id="sel_grp_rol_id" name="grp_rol_id" class="select" disabled><option value="">-선택-</option></select>
                                            </span>
                                        </td>
                                        <th>
                                            <label for="sel_sys_cls_cd" class="vv necessary">시스템구분코드</label>
                                        </th>
                                        <td colspan="3">
                                            <span class="txt_pw">
                                                <select id="sel_sys_cls_cd" name="sys_cls_cd" class="select" disabled><option value="">-선택-</option></select>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            <label for="inp_mstrs_uspr_id" >BI라이센스</label>
                                        </th>
                                        <td colspan="2">
                                            <span class="txt_pw typeBtn" style="float:left;">
                                                <input type="text" name="mstrs_uspr_id" id="inp_mstrs_uspr_id" class="text" value="" maxlength="32" disabled/>
                                                <button type="button" id="btn_mstrs_pop" onclick="btn_onclick_PopSearch()" class="btn_common btn_default" style="float:left;" disabled>
                                                    <img src="${pageContext.request.contextPath}/resources/pandora3/images/common/img-table-search.png" alt="검색 버튼" class="searchBtn2" />
                                                </button>
                                            </span>
                                        </td>
                                        <th>
                                            <label for="sel_cstr_cd">소속점</label>
                                        </th>
                                        <td colspan="3">
                                            <span class="txt_pw">
                                                <select id="sel_cstr_cd" name="cstr_cd" class="select" disabled ><option value="">-선택-</option></select>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            <label for="sel_hr_pos_cd" >직책</label>
                                        </th>
                                        <td colspan="2">
                                            <span class="txt_pw">
                                                <select id="sel_hr_pos_cd" name="hr_pos_cd" class="select" disabled onchange="selOnduCd(this)"><option value="">-선택-</option></select>
                                            </span>
                                        </td>
                                        <th>
                                            <label for="sel_job_cd">직무</label>
                                        </th>
                                        <td colspan="3">
                                            <span class="txt_pw">
                                                <select id="sel_job_cd" name="job_cd" class="select" disabled onchange="selJbfnCd(this)"><option value="">-선택-</option></select>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            <label for="sel_shop_grde_cd" >매장등급</label>
                                        </th>
                                        <td colspan="2">
                                            <span class="txt_pw">
                                                <select id="sel_shop_grde_cd" name="shop_grde_cd" class="select" disabled><option value="">-선택-</option></select>
                                            </span>
                                        </td>
                                        <th>
                                            <label for="sel_buy_grde_cd" >매입등급</label>
                                        </th>
                                        <td>
                                            <span class="txt_pw">
                                                <select id="sel_buy_grde_cd" name="buy_grde_cd" class="select" disabled><option value="">-선택-</option></select>
                                            </span>
                                        </td>
                                        <th>
                                            <label for="excv_yn" class="vv necessary" >임원여부</label>
                                        </th>
                                           <td>
                                            <span class="txt_pw">
                                                <select id="excv_yn" name="excv_yn" class="select" disabled>
                                                    <option value="">-선택-</option>
                                                	<option value="N">N</option>
                                                	<option value="Y">Y</option>
                                                </select>
                                            </span>
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </div>
                    </div>

                    </div>
                    <!--// 조직 상세 정보 -->
                </div>
            </div>
    </div>
    <form name="frm_sysCdDtl" id="frm_sysCdDtl" submit="return false;">
        <input type="hidden" name="mst_cd_arr" id="mst_cd_arr" />
    </form>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
