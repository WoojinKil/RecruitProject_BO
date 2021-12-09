<%-- 
   1. 파일명 : psys1031
   2. 파일설명: 조직별권한관리
   3. 작성일 : 2019-03-14
   4. 작성자 : TANINE
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>

<script type="text/javascript">
// 하위조직 그리드
var org_grid;

//zTree Setting
var _tree_setting = {
    view    : {selectedMulti : false},
    edit    : {enable : false, showRemoveBtn : false, showRenameBtn : false},
    data    : {keep : {parent : true, leaf : true},
               simpleData : {enable : true, idKey: "id", pIdKey : "pId", rootPId : 0}
    },
    callback: {
        beforeDrag  : fn_beforeDrag,
        beforeClick : fn_beforeClick,
        beforeRemove: fn_beforeRemove,
        beforeRename: fn_beforeRename,
        onClick     : fn_onClick,
        onRemove    : fn_onRemove,
        onRename    : fn_onRename
    }
};

//전역변수
var _nodes;                 // 트리노드
var _new_cnt    = 1;        // 임시Id SEQ
var _flag_edit  = false;    // 메뉴편집 진행 플래그
var _flag_cut   = false;    // 메뉴 자르기 진행 플래그
var _flag_copy  = false;    // 메뉴 복사 진행 플래그
var _flag_save  = false;    // 저장된 메뉴 여부
var _edit_org   = '';       // 편집 진행중인 메뉴 정보
var _curr_lvl   = '';       // 클릭된 계층
var _curr_src   = '';       // 현재 작업 노드
var _curr_type  = '';       // 현재 작업 (ex.복사/자르기)
var _copy_obj   = '';       // 복사 대상 노드


//달력
function fn_datePicker(e)
{
    $(e).datepicker({dateFormat:'yy-mm-dd', changeYear : true, changeMonth : true});
}

$(document).ready(function(){
    
    
    // 사용자 그리드 설정
    // 그리드 초기화 : 시스템 회원 목록
    var adm_grid_config = {
        gridid      : 'adm_grid',
        pagerid     : 'adm_grid_pager',
        gridBtnYn   : 'N',                  // 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        columns     : [
                       {name : 'ORG_CD', label :'조직SEQ', hidden : true},
                       {name : 'LGN_ID', label : '아이디', align : 'center', sortable : false, editable : false, hidden : true},
                       {name : 'USR_ID', label :'사번',align : 'center', editable : false},
                       {name : 'USR_NM', label : '성명', align : 'center', sortable : false, editable : false},
                       {name : 'POS_NM', label : '직책', align : 'center', sortable : false, editable : false},
                       {name : 'JOB_NM', label : '직무명', align : 'center', sortable : false, editable : false},
                       {name : 'ACTV_YN', label : '계정활성화', align : 'center', sortable : false, editable : false, edittype:'select', formatter : 'select', editoptions : {value : 'Y:활성화;N:비활성화'}}
                       ],
        editmode    : false,                                // 그리드 editable 여부
        gridtitle   : '권한 목록',                      // 그리드명
//      multiselect : true,                                 // checkbox 여부
        formid      : 'search',                             // 조회조건 form id
        height      : 201,                                  // 그리드 높이
        shrinkToFit : true,                                 // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현
        selecturl   : '/psys/getPsys1031OrgAdmList',    // 그리드 조회 URL
        saveurl     : '/psys/savePsys1031AdmList',      // 그리드 입력/수정/삭제 URL
        events      : {
        }
    };
    adm_grid = new UxGrid(adm_grid_config);
    adm_grid.init();
    adm_grid.setGridWidth($('#table_org').width());
    $("#adm_grid").jqGrid("setLabel", "rn", "NO");
    
    // 트리 영역 네비게이션 버튼 이벤트 설정
    $("#node_add").bind("click", fn_nodeAdd);
    $("#node_del").bind("click", fn_nodeDelete);
    $("#node_reset").bind("click", fn_nodeReset);
    $("#node_copy").bind("click", fn_nodeCopy);
    $("#node_cut").bind("click", fn_nodeCut);
    $("#node_paste").bind("click", fn_nodePaste);

    

    // 시스템 회원 목록 그리드 - 저장 버튼 클릭
    $("#btn_menu_save").click(function() {
        adm_grid.save();
    });
    

    
    
    // 상세영역 submit 바인딩
    $("#form_org").submit(fn_submit);
    
    //조회
    fn_getOrgTree();
    
    
    $("#btn_grp_rol_pop").on("click", function () {
        
        var org_cd = $("#org_cd").val();
        
        if(isEmpty($("#org_cd").val()) || org_cd < 1) {
            alert('조직을 선택하세요.');
            return false;
        }
        
        bpopup({
            url:"/psys/forward.psys1031p001.adm"
          , params    : {callback : "fn_setGrpRolInfo", target_id : _menu_id}
          , title     : "시스템 권한 그룹 목록"
          , type      : "m"
          , height    : "450px"
          , id        : "psys1031p1"
      });
    });
    
    //권한 삭제 버튼 클릭시
    $("#btn_grp_rol_del").on("click", function () {
        
        var org_cd = $("#org_cd").val();
        
        if(isEmpty($("#org_cd").val()) || org_cd < 1) {
            alert('조직을 선택하세요.');
            return false;
        }
        
        if(confirm($("#org_nm").val() + "조직의 " + "[" + $("#grp_rol_nm").val() + "] 권한을 삭제하시겠습니까?")) {
            
            ajax({
                url     : "/psys/deleteTsysAdmOrgGrpRolRtnn.adm",
                data    : {org_cd : org_cd},
                success : function(data) {
                    
                    if(data.RESULT = "S") {
                        alert("권한이 삭제되었습니다.");
                        
                        fn_reset();
                      //그리드 초기화
                        adm_grid.clearGridData();
                        
                        fn_getOrgTree();
                    }
                    
                }
            });
            
        }
        
    });
    
});

// grid resizing
$(window).resize(function() {
    adm_grid.setGridWidth($('#table_org').width());
});

/******************************
 * 트리 제어
 ******************************/
 
// 드래그 방지
function fn_beforeDrag(id, node)
{
    return false;   
}

// 클릭 이벤트 발생 전 이벤트
function fn_beforeClick(id, node)
{
    // 수정 / 자르기 / 복사 중인 경우
    if(_flag_edit || _flag_cut || _flag_copy)
    {
        var tree = $.fn.zTree.getZTreeObj("tree_org");
            
        var edit_node = tree.getSelectedNodes()[0];
        
        var mode = (_flag_cut) ? "이동" : (_flag_copy) ? "복사" : "수정";  
            
        if(node != edit_node)
            alert("현재 " + mode + " 중인 조직이 있습니다.\n먼저 내용을 저장하신 후 다시 진행해 주세요.");
        
        return false;
    }
    
    return true;
}

// 삭제 전 EVENT
function fn_beforeRemove(id, node)
{
    return confirm("[" + node.name + "] 을 삭제하시겠습니까? \n(하위 조직과 해당 조직의 사용자 조직 정보도 같이 삭제됩니다.)");
}

// 이름 변경 전 EVENT
function fn_beforeRename(id, node, name)
{
    if(isEmpty(name))
    {
        setTimeout(function(){
            $.fn.zTree.getZTreeObj("tree_org").cancelEditName();
            alert("메뉴 명을 입력해 주세요.");            
        }, 0);
        return false;
    }
    
    return true;
}

// 노드 클릭 이벤트
function fn_onClick(event, id)
{
    // 우측 영역 초기화
    fn_reset();
    
    // 우측 영역 활성화
    $("#form_org input").not(".readonlyTxt").attr("readonly", false);
    
    var tree = $.fn.zTree.getZTreeObj("tree_org")
    var node = tree.getSelectedNodes();
    var org  = node[0];
    
    // 데이터를 상세정보 Form에 설정
    $("#up_org_cd").val(org.pid);
    $("#org_cd").val(org.id);
    $("#org_nm").val(org.name);
    $("#grp_rol_nm").val(org.grp_rol_nm);
    $("#mstr_nm").val(org.mstr_nm);
    $("#cstr_nm").val(org.cstr_nm);
    
    // status U로 셋팅
    $("#status").val("U");
    
    // 선택한 조직의 구성원 조회
    adm_grid.retreive({data:{org_cd:org.id}});
    
    
    
    // 트리 컨트롤 값 셋팅
    // 선택 메뉴의 설정정보(DB저장여부)를 전역변수에 저장(복사의 경우 예외)
    if("Y" == org.isSaved && "copy" != _curr_type) {
        _flag_save = true;
        _curr_lvl = node.level;
    } else {
        _flag_save = false;
    }
    
    tree.selectNode(org);
}

// 삭제 후 EVENT
function fn_onRemove(e, id, node)
{
    // 선택되었던 메뉴가 DB에 저장된 메뉴인 경우
    if("Y" == node.isSaved)
        fn_deleteOrgByNode(node, true);
    
    fn_reset();
}

// 이름 변경 후 Event
function fn_onRename(e, id, node)
{
    // 변경된 조직 명 반영
    $("#org_nm").val(node.name);

    // 상태 변경 (신규-신규 / 그외-수정)
    if($("#status").val() != "C")
        $("#status").val("U");
}

// 노드 추가
function fn_nodeAdd(e)
{
    if(_flag_edit)
    {
        alert("현재 편집중인 신규 조직 정보가 있습니다.\n내용을 저장 하신 후 다시 진행해주세요.");
        return false;
    }
    
    var tree = $.fn.zTree.getZTreeObj("tree_org");
    var node = tree.getSelectedNodes();
    var edit_node = node[0];
    
    // 신규 생성될 메뉴의 설정값
    var name = "새 메뉴";      // 메뉴명 기본값
    var isParent = true;    // 하위 메뉴 허용 여부 (기본:허용)
    var parentId = null;    // 상위 조직
    var org_dpth = 1;
    
    // 조직 추가 허용 여부 (기본:허용)
    var flag_add_org = true;
    
    // 선택 메뉴가 존재하는 경우
    if(isNotEmpty(edit_node))
    {
        // 선택된 메뉴의 정보 확인 (하위허용여부)
        isParent = edit_node.isParent;
        
        // 하위허용일 경우
        if(isParent)
        {
            parentId = edit_node.id;
            org_dpth = edit_node.level +1;
            
            // 신규 생성될 3Depth 메뉴는 하위 생성 불가
            if(edit_node.level == 3)
                isParent = false;
        }
        // 하위불가인 경우
        else
            flag_add_org = false;
    }
    // 선택 메뉴가 없는 경우 (최상층 메뉴 추가 시 메인메뉴 유무 판단)
    else if(isNotEmpty(tree.getNodes()[0]))
    {
        alert("메인 메뉴는 한개만 설정이 가능합니다.\n등록된 메인 메뉴를 선택하시고 [메뉴추가] 버튼을 눌러주세요.");
        return false;
    }
    
    if(flag_add_org)
    {
        var option = {};
        option.id = "TMP" + _new_cnt++; 
        option.pId = parentId;
        option.name = name;
        option.isParent = isParent;
        option.isSaved = "N";
        option.org_dpth = org_dpth;
        
        edit_node = tree.addNodes(edit_node, option);
        
        // 메뉴 상세정보 문구 변경
        $("#form_title").addClass("dispMenuAddTit");
        $("#form_title").text($("#form_title").text().replace("상세", "추가"));
        
        // 우측 영역 초기화
        fn_reset();
        
        // 우측 영역 활성화
        $("#form_org input").not(".readonlyTxt").attr("readonly", true);
        
        // 상세정보 Hidden값 설정
        $("#up_org_cd").val(parentId);
        $("#org_dpth").val(org_dpth);
        
        // 새로 생성한 메뉴로 포커스
        tree.editName(edit_node[0]);
        
        // 새로 생성한 메뉴의 정보를 전역변수에 임시 저장
        _edit_org = edit_node[0];
        
        // status C로 셋팅
        $("#status").val("C");
        
        // 정상적으로 메뉴추가가 완료되면 메뉴추가진행플래그를 진행중으로 변경
        _flag_edit = true;
    }
    else
        alert("선택하신 메뉴는 하위 메뉴를 추가할 수 없는 메뉴입니다.");
    
}

// 노드 삭제
function fn_nodeDelete(e)
{
    // 현재 선택 중인 메뉴 확인
    var tree = $.fn.zTree.getZTreeObj("tree_org");
    var node = tree.getSelectedNodes();

    // 선택된 메뉴가 하나도 없으면
    if(node.length == 0)
    {
        alert("삭제대상 조직을 선택해주세요.");
        return false;
    }
    node = node[0];
    
    //여기 선택된 메뉴가 DB에 저장된 메뉴인 경우
    if("Y" == node.isSaved)
        fn_deleteOrgByNode(node, false);
    // 선택된 메뉴가 DB저장 전의 메뉴인 경우
    else {
        //  메뉴 트리정보 삭제
        $("#"+node.tId).find("span.button.remove").trigger('click');
        
        // 삭제 후 메뉴 상세정보 Form값 초기화
        fn_reset();
    }
}

// 노드 편집중단
function fn_nodeReset(e)
{
    if(confirm("편집 중단 시 바로 직전에 저장한 조직 정보까지만 반영됩니다.\n편집을 중단하시겠습니까?"))
        window.location.reload();
}

// 노드 복사
function fn_nodeCopy(e)
{
    // TODO : 작업 체크 여기서도 해야 하는 것이 아닌가.. ??
            
    var tree = $.fn.zTree.getZTreeObj("tree_org");
    var node = tree.getSelectedNodes();
    
    if(node.length < 1)
    {
        alert("대상 조직 선택 후 [복사]버튼을 클릭해주세요.");
        return;
    }
    
    _curr_type = "copy";
    fn_setSourceNode(node[0]);
}

// 노드 자르기
function fn_nodeCut(e)
{
    // TODO : 작업 체크 여기서도 해야 하는 것이 아닌가.. ??
            
    var tree = $.fn.zTree.getZTreeObj("tree_org");
    var node = tree.getSelectedNodes();
    
    if(node.length < 1)
    {
        alert("대상 조직 선택 후 [자르기]버튼을 클릭해주세요.");
        return;
    }
    
    _curr_type = "cut";
    fn_setSourceNode(node[0]);
}

// 노드 붙여넣기
function fn_nodePaste(e)
{
    if (isEmpty(_curr_src))
    {
        alert("조직 선택 - [복사]나 [자르기] 버튼을 클릭 후 진행해주세요.");
        return;
    }
    
    var tree = $.fn.zTree.getZTreeObj("tree_org");
    var node = tree.getSelectedNodes();
    var target = (node.length > 0) ? node[0] : null;
    
    if(isEmpty(target))
    {
        alert("붙여넣을 상위 조직을 선택해주세요.");
        $("#" + _curr_src.tId + "_a").trigger('click');
        return;
    }
    else if(_curr_src === target)
    {
        alert("기존메뉴와 동일한 위치로는 복사/붙이기를 사용하실 수 없습니다.");
        return;
    }
    else if(target && target.level == 0 && !_curr_src.isParent) // 1Depth에 사용불가 메뉴 체크
    {
        // 현재 선택된 메뉴(이동할 메뉴)가 메인 메뉴인 경우
        alert("메인 메뉴의 하위로 지정가능한 메뉴가 아닙니다.");
        return;
    }
    else if(target && target.org_dpth != _curr_src.org_dpth) // 다른계층간의 이동을 제한(부모의 계층이 동일한 경우만 이동을 허용)
    {
        alert("메뉴 레벨이 같은 경우만 복사/이동이 가능합니다.");
        $("#" + _curr_src.tId + "_a").trigger('click');
        return;
    }
    else if(_curr_type === "copy")
    {
        var change_node = fn_getChangeNode(_curr_src, target);
        target = tree.copyNode(target, change_node, "inner");
        $("#" + target.tId + "_a").trigger('click');
        _flag_copy = true;
    }
    else if(_curr_type === "cut")
    {
        // 동일한 상위 메뉴를 가진 하위 메뉴간의 이동은 불가
        if((target && _curr_src.parentId === target.tId) || (!target && !_curr_src.parentId))
        {
            alert("이미 선택된 메뉴의 하위메뉴로 지정되어 있습니다.");
            $("#" + _curr_src.tId + "_a").trigger('click');
            return;
        }
        
        // 이동할 메뉴 데이터 설정(상위 메뉴 아이디)
        if(isNotEmpty(target))
            $("#up_org_cd").val(target.id);

        target = tree.moveNode(target, _curr_src, "inner");
        target = _curr_src;
        $("#" + target.tId + "_a").trigger('click');
        _flag_cut = true;
    }
    
    fn_setSourceNode();
    delete target.isCur;
}

// 임시 노드 값 설정
function fn_setSourceNode(node)
{
    var tree = $.fn.zTree.getZTreeObj("tree_org");
    
    if(isNotEmpty(_copy_obj))
    {
        var temp = _copy_obj;
        
        delete temp.isCur;
        
        _copy_obj = null;
        
        fn_setNodeCss(temp);
    }
    
    _copy_obj = node;
    
    if(isNotEmpty(node))
    {
        _copy_obj.isCur = true;
        tree.cancelSelectedNode();
        fn_setNodeCss(_copy_obj);
    }
}

// 노드 CSS 설정 변경
function fn_setNodeCss(node)
{
    var obj = $("#" + node.tId + "_a");
    
    obj.removeClass("copy").removeClass("cut");
    
    if(node === _copy_obj)
    {
        if(_curr_type == "copy" || _curr_type == "cut")
            aObj.addClass(_curr_type);
    }
}

// 복사 대상 데이터 변경
function fn_getChangeNode(node, parentNode)
{
    // 복사할 데이터 최상위 변경
    node.id = "";
    node.up_org_cd = "";
    
    // 복사할 데이터 필수 요소 Object 설정
    var topDataArray = new Array();
    var midDataArray = new Array();
    var btmDataArray = new Array();
    var obj = new Object();
    
    obj.up_org_cd = parentNode.id;
    obj.org_nm = node.name+"_복사";
    obj.org_dpth = parseInt(parentNode.level, 10) + 1;
    
    topDataArray.push(obj);

    var mid_group = 1;
    
    // 하위메뉴가 존재하는지 판단(최대 Depth가 3Depth이므로 3Depth까지 판단)
    if(isNotEmpty(node.children))
    {
        // 2Depth판단
        for(var i=0; i<node.children.length; i++)
        {
            // 복사할 데이터 변경
            node.children[i].id = "";
            node.children[i].org_cd = "";
            node.children[i].name = node.children[i].name + "_복사";
            
            // 복사할 데이터 필수요소 Object 설정
            var obj_m = new Object();
            
            obj_m.org_nm = node.children[i].name;
            obj_m.org_dpth = node.children[i].org_dpth;
            obj_m.mid_group = mid_group;
            
            midDataArray.push(obj_m);
            
            // 3Depth판단
            if(isNotEmpty(node.children[i].children))
            {
                for(var j=0; j<node.children[i].children.length; j++)
                {
                    node.children[i].children[j].name = node.children[i].children[j].name + "_복사";

                    // 복사할 데이터 필수요소 Object 설정
                    var obj_b = new Object();
                    
                    obj_b.org_nm = node.children[i].children[j].name;
                    obj_b.org_dpth = node.children[i].children[j].org_dpth;
                    obj_b.mid_group = mid_group;
                    
                    btmDataArray.push(obj_b);
                }
            }
            
            mid_group++;
        }
    }
    
    var totalInfo = new Object();
    if(topDataArray.length > 0) totalInfo.topDataInfo = topDataArray;
    if(midDataArray.length > 0) totalInfo.midDataInfo = midDataArray;
    if(btmDataArray.length > 0) totalInfo.btmDataInfo = btmDataArray;
    
    _copy_obj = totalInfo;
    
    return node;
}

/******************************
 * 컴포넌트 이벤트
 ******************************/
 
// 상세 영역 초기화
function fn_reset()
{
    // 폼 영역 초기화
    $("#form_org").reset();
    $("#form_org input").attr("readonly", true);
    
    // 그리드 데이터 삭제
    //org_grid.clearGridData();   
}

// 우측 영역에 상세정보 설정
function fn_setOrgInfo()
{
    
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
    // C 신규 / U 수정 / D 삭제
    if(isEmpty($("#status").val()))
    {
        alert("변경 사항이 없습니다.");
        return;
    }

    $("#form_title").removeClass("dispMenuAddTit");
    $("#form_title").text($("#form_title").text().replace("추가", "상세"));

    $("#form_org").submit();
}

function fn_deleteOrgByNode(node, confirm)
{
    if(confirm)
    {
        if(!confirm("[" + node.name + "] 을 삭제하시겠습니까? \n(하위 조직과 해당 조직의 사용자 조직 정보도 같이 삭제됩니다.)"))
            return;
    }
    
    var param = new Array();
    param.push(node.id);
    
    fn_deleteOrg(param, '');
}
/******************************
 * Server
 ******************************/
 
// 조직 목록 조회
function fn_getOrgTree(org_cd) {
    
    
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

//상세 영역 Form 저장
function fn_submit(e)
{
    var formData = new FormData($(this)[0]);
    
    $.ajax({
        url         : _context + '/psys/savePsys1031',
        type        : 'POST',
        data        : formData,
        mimeType    :"multipart/form-data",
        contentType : false,
        cache       : false,
        processData : false,
        success     : function(data){

            data = JSON.parse(data);

            if(data.RESULT == "S")
            {
                alert('저장되었습니다');
                
                $("#org_cd").val(data.org_cd);

                // 트리 플래그 초기화               
                _new_cnt    = 1;        // 임시Id SEQ
                _flag_edit  = false;    // 메뉴편집 진행 플래그
                _flag_cut   = false;    // 메뉴 자르기 진행 플래그
                _flag_copy  = false;    // 메뉴 복사 진행 플래그
                _flag_save  = false;    // 저장된 메뉴 여부
                _edit_org   = '';       // 편집 진행중인 메뉴 정보
                _curr_lvl   = '';       // 클릭된 계층
                _curr_src   = '';       // 현재 작업 노드
                _curr_type  = '';       // 현재 작업 (ex.복사/자르기)
                _copy_obj   = '';       // 복사 대상 노드         
                
                // 트리 재조회
                fn_getOrgTree(data.org_cd);
                
                // 하위 조직 그리드 재조회
            }
            else
                alert("일시적 오류입니다. 잠시후 다시 시도하세요.")
        }
    });
    
    e.preventDefault(); //Prevent Default action.
}
 
function fn_deleteOrg(param, up_org_cd)
{
    ajax({
        url     : "/psys/savePsys1031OrgList.adm",
        data    : {org_seq_arr:param, staus : "D"},
        success : function(data){
            
            if(data.RESULT = "S")
            {
                alert("메뉴가 삭제되었습니다.");
                fn_getOrgTree();
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

//권한 조회 POPUP Callback
function fn_setGrpRolInfo(row) {
    $("#grp_rol_id").val(row.GRP_ROL_ID);
    $("#grp_rol_nm").val(row.GRP_ROL_NM);
}

</script>
</head>
<body>
    <div class="frameWrap">
        <div class="subCon on clear">
            <%@ include file="/WEB-INF/views/pandora3/common/include/btnList2.jsp"%>
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
                        <div class="menuInfo">
                            <div class="tableTop first">
                                <h3 class="title">상세정보</h3>
                            </div>
                            <form name="form_org" id="form_org" enctype="multipart/form-data" method="post" onsubmit="return false;">
                                <input type="hidden" name="grp_rol_id" value="" id="grp_rol_id" />
                                <input type="hidden" name="status" id="status" />
                                <input type="hidden" name="up_org_cd" id="up_org_cd" />
                                <input type="hidden" name="org_dpth" id="org_dpth" />
                                <table id="table_org" class="tblType1">
                                    <colgroup>
                                        <col style="width:" />
                                        <col style="width:" />
                                        <col style="width:" />
                                        <col style="width:" />
                                        <col style="width:" />
                                        <col style="width:" />
                                    </colgroup>
                                    <tr>
                                        <th>
                                            <label for="org_nm" class="vv necessary">조직명</label>
                                        </th>
                                        <td colspan="2"><span class="txt_pw"><input type="text" id="org_nm" name="org_nm" class="w100" /></span></td>
                                        <th>
                                            <label for="org_cd">조직번호</label>
                                        </th>
                                        <td colspan="2"><span class="txt_pw"><input type="text" id="org_cd" name="org_cd" class="w100 readonlyTxt" readonly/></span></td>
                                    </tr>
                                    <tr>
                                    <tr>
                                        <th>조직별 통합그룹권한</th>
                                        <td colspan="5">
                                            <span class="txt_pw">
                                                <input type="text" id="grp_rol_nm" name="grp_rol_nm" class="w40" />
                                            </span>
                                            <a href="#" id="btn_grp_rol_pop" class="btn_common btn_default btn_input_right">권한조회</a>
                                            <a href="#" id="btn_grp_rol_del" class="btn_common btn_default btn_input_right">권한삭제</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            <label for="mstr_nm">모점</label>
                                        </th>
                                        <td colspan="2"><span class="txt_pw"><input type="text" id="mstr_nm" name="mstr_nm" class="w100 readonlyTxt" readonly/></span></td>
                                        <th>
                                            <label for="cstr_nm">자점</label>
                                        </th>
                                        <td colspan="2"><span class="txt_pw"><input type="text" id="cstr_nm" name="cstr_nm" class="w100 readonlyTxt" readonly/></span></td>
                                    </tr>
                                </table>
                            </form>
                        </div>
                        
                        <!-- Grid : TOP GRID-->
                        <table id="adm_grid"></table>
                        <div id="adm_grid_pager"></div>
        
                    </div>
        
                    </div>
                    <!--// 조직 상세 정보 -->
                </div>
            </div>
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
