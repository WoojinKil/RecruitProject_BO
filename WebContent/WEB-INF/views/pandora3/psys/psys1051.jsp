<%--
   1. 파일명   : psys1051
   2. 파일설명: 조직별매장매입관리
   3. 작성일   : 2020-02-28
   4. 작성자   : TANINE
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>

<script type="text/javascript">

var org_cls_cd = "";
var up_org_cd = "";

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

    // 매장조직 jqGrid - Start
    var shop_str_grid_config = {
        gridid      : 'shop_str_grid',
        pagerid     : '',
        gridBtnYn   : '',                  // 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        columns     : [
//                     {name : 'STATUS'   , label :'상태'    , align:'center', editable:false, width:20},
                       {name : 'MSTR_CD'    , label :'모점코드'  , align : 'center', editable : false, width: 40, sortable:false},
                       {name : 'MSTR_NM'    , label :'모점명'   , align : 'left'  , editable : false, width: 100, sortable:false},
                       {name : 'SHOP_STR_CD', label :'자점코드'  , align : 'center', editable : false, width: 40, sortable:false},
                       {name : 'CSTR_NM'    , label :'자점명'   , align : 'left'  , editable : false, width: 100, sortable:false},
                       {name : 'RGN_LDR_YN' , label :'지역여부'   , editable : true, edittype : 'select', formatter : 'select', editoptions : {value:'Y:사용;N:미사용'}, width : 100, sortable:false},
                       {name : 'STR_CHK_YN' , label :'체크여부'  , hidden : true},
                       ],
        editmode    : true,                                 // 그리드 editable 여부
        gridtitle   : '소속점',                               // 그리드명
        formid      : 'search',                             // 조회조건 form id
        height      : 200,                                  // 그리드 높이
        multiselect : true,                                 // checkbox 여부
        shrinkToFit : true,                                 // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현
        selecturl   : '/psys/getPsys1051StrList',           // 그리드 조회 URL
        events      : {
                         onSelectRow: function(event, rowid, e) {
                             var row = shop_str_grid.getRowData(rowid);
                             
                             // 점에 해당하는 층  조회
//                              shop_flr_grid.clearGridData();
//                              shop_pc_grid.clearGridData();
                             
                             /* shop_str_grid.getSelectRows().forEach(function(itm, idx){
                            	fn_floorList_search(itm, true, "shop");
                             }); */
                           	fn_floorList_search(row, e, "shop");
                             
                         },
                         gridComplete : function() {
                             var rowIds = shop_str_grid.getDataIDs();

                             if (rowIds.length > 0) {
                                 for (var i = 0; i < rowIds.length; i++) {
                                     var row = shop_str_grid.getRowData(rowIds[i]);
                                     if (row.STR_CHK_YN == 'Y') {
                                         $("#shop_str_grid").jqGrid('setSelection', rowIds[i], true);
//                                       $("#shop_str_grid").setCell(rowIds[i], 'JQGRIDCRUD', null);
//                                       $("#shop_str_grid").setCell(rowIds[i], 'STATUS'    , null);
                                     }
                                 }
                             }
                         }

                       }
    };
    shop_str_grid = new UxGrid(shop_str_grid_config);
    shop_str_grid.init();
    shop_str_grid.setGridWidth($("#tab1").width());
    $("#cb_shop_str_grid").attr("disabled",true).hide();
    $("#jqgh_shop_str_grid_cb").hide();

    var shop_flr_grid_config = {
        gridid      : 'shop_flr_grid',
        pagerid     : '',
        gridBtnYn   : 'Y',                  // 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        columns     : [
                       {name : 'SHOP_STR_CD'        , label :'자점코드'    ,align : 'center', editable : false, width: 40, sortable:false},
                       {name : 'CSTR_NM'        , label :'자점명'     ,align : 'left'  , editable : false, width: 80 , hidden :true, sortable:false},
                       {name : 'SHOP_TEAM_CD'    , label :'층코드'     ,align : 'center', editable : false, width: 40, sortable:false},
                       {name : 'SHOP_TEAM_NM'    , label :'층명'      ,align : 'left'  , editable : false, width: 100, sortable:false},
                       {name : 'SHOP_FLR_CHK_YN', label :'체크여부'  , hidden : true},
                       ],
        editmode    : true,                                 // 그리드 editable 여부
        gridtitle   : '층',                                  // 그리드명
        formid      : 'search',                             // 조회조건 form id
        height      : 300,                                  // 그리드 높이
        multiselect : true,                                 // checkbox 여부
        shrinkToFit : true,                                 // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현
        selecturl   : '/psys/getPsys1050OrgAthrList',       // 그리드 조회 URL
        events      : {
                          onSelectRow: function(event, rowid, e) {
                              var row = shop_flr_grid.getRowData(rowid);
                              // 점/층에 해당하는 PC 조회
                              fn_pcList_search(row, e, "shop");
                          },
                       }
    };
    shop_flr_grid = new UxGrid(shop_flr_grid_config);
    shop_flr_grid.init();
    shop_flr_grid.setGridWidth($(".grid_custom_two > div").width());
    $("#cb_shop_flr_grid").attr("disabled",true).hide();
    $("#jqgh_shop_flr_grid_cb").hide();

    var shop_pc_grid_config = {
        gridid      : 'shop_pc_grid',
        pagerid     : '',
        gridBtnYn   : 'Y',                  // 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        columns     : [
//                        {name : 'STATUS'        , label:'상태'      , align:'center'   , editable:false, width:20},
                       {name : 'SHOP_STR_CD', label :'자점코드'    ,align : 'center', editable : false, width: 40, sortable:false},
                       {name : 'SHOP_TEAM_CD' , label :'층코드'     ,align : 'center', editable : false, width: 40, sortable:false},
                       {name : 'SHOP_PC_CD'  , label :'PC코드'     ,align : 'center', editable : false, width: 40, sortable:false},
                       {name : 'SHOP_PC_NM'  , label :'PC명'      ,align : 'left'  , editable : false, width: 100, sortable:false},
                       {name : 'SHOP_PC_CHK_YN'  , label :'체크여부'  , hidden : true},
                       ],
        editmode    : true,                                 // 그리드 editable 여부
        gridtitle   : 'PC',                                 // 그리드명
        formid      : 'search',                             // 조회조건 form id
        height      : 300,                                  // 그리드 높이
        multiselect : true,                                 // checkbox 여부
        shrinkToFit : true,                                 // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현
        selecturl   : '/psys/getPsys1050OrgAthrList',       // 그리드 조회 URL
        events      : {
                       }
    };
    shop_pc_grid = new UxGrid(shop_pc_grid_config);
    shop_pc_grid.init();
    shop_pc_grid.setGridWidth($(".grid_custom_two > div").width());
    // 매장조직 jqGrid - End

    // 매입조직 jqGrid - Start
    var buy_fld_grid_config = {
        gridid      : 'buy_fld_grid',
        pagerid     : '',
        gridBtnYn   : '',                  // 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        columns     : [
//                     {name : 'STATUS'   , label :'상태'    , align:'center', editable:false, width:20},
                       {name : 'BUY_FLD_CD' , label :'부문코드'  , align : 'center', editable : false, width: 40, sortable:false},
                       {name : 'BUY_FLD_NM' , label :'부문명'   , align : 'left'  , editable : false, width: 100, sortable:false},
                       {name : 'RGN_LDR_YN' , label :'지역여부'   , editable : true, edittype : 'select', formatter : 'select', editoptions : {value:'Y:사용;N:미사용'}, width : 100, sortable:false},
                       {name : 'FLD_CHK_YN' , label :'체크여부'  , hidden : true, sortable:false},
                       ],
        editmode    : true,                                 // 그리드 editable 여부
        gridtitle   : '부문',                                // 그리드명
        formid      : 'search',                             // 조회조건 form id
        height      : 200,                                  // 그리드 높이
        multiselect : true,                                 // checkbox 여부
        shrinkToFit : true,                                 // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현
        selecturl   : '/psys/getPsys1051FldList',           // 그리드 조회 URL
        events      : {
                         onSelectRow: function(event, rowid, e) {
                        	 var row = buy_fld_grid.getRowData(rowid);
                        	 
                            fn_floorList_search(row, e, "buy");
                             
                         },
                         gridComplete : function() {
                             var rowIds = buy_fld_grid.getDataIDs();

                             if (rowIds.length > 0) {
                                 for (var i = 0; i < rowIds.length; i++) {
                                     var row = buy_fld_grid.getRowData(rowIds[i]);
                                     if (row.FLD_CHK_YN == 'Y') {
                                         $("#buy_fld_grid").jqGrid('setSelection', rowIds[i], true);
//                                       $("#shop_str_grid").setCell(rowIds[i], 'JQGRIDCRUD', null);
//                                       $("#shop_str_grid").setCell(rowIds[i], 'STATUS'    , null);
                                     }
                                 }
                             }
                         }

                       }
    };
    buy_fld_grid = new UxGrid(buy_fld_grid_config);
    buy_fld_grid.init();
    buy_fld_grid.setGridWidth($("#tab1").width());
    $("#cb_buy_fld_grid").attr("disabled",true).hide();
    $("#jqgh_buy_fld_grid_cb").hide();

    var buy_team_grid_config = {
        gridid      : 'buy_team_grid',
        pagerid     : '',
        gridBtnYn   : 'Y',                  // 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        columns     : [
                       {name : 'BUY_FLD_CD'     , label :'부문코드'  ,align : 'center', editable : false, width: 30, sortable:false},
                       {name : 'BUY_TEAM_CD'    , label :'팀코드'   ,align : 'center', editable : false, width: 30, sortable:false},
                       {name : 'BUY_TEAM_NM'    , label :'팀명'    ,align : 'left'  , editable : false, width: 100, sortable:false},
                       {name : 'BUY_TEAM_CHK_YN' , label :'체크여부'  , hidden : true},
                       ],
        editmode    : true,                                 // 그리드 editable 여부
        gridtitle   : '층',                                  // 그리드명
        formid      : 'search',                             // 조회조건 form id
        height      : 300,                                  // 그리드 높이
        multiselect : true,                                 // checkbox 여부
        shrinkToFit : true,                                 // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현
        selecturl   : '/psys/getPsys1050OrgAthrList',       // 그리드 조회 URL
        events      : {
                          onSelectRow: function(event, rowid, e) {
                              var row = buy_team_grid.getRowData(rowid);
                              // 점/층에 해당하는 PC 조회
                              fn_pcList_search(row, e, "buy");
                          },
                       }
    };
    buy_team_grid = new UxGrid(buy_team_grid_config);
    buy_team_grid.init();
    buy_team_grid.setGridWidth($(".grid_custom_two > div").width());
    $("#cb_buy_team_grid").attr("disabled",true).hide();
    $("#jqgh_buy_team_grid_cb").hide();

    var buy_pc_grid_config = {
        gridid      : 'buy_pc_grid',
        pagerid     : '',
        gridBtnYn   : 'Y',                  // 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        columns     : [
//                        {name : 'STATUS'        , label:'상태'      , align:'center'   , editable:false, width:20},
                       {name : 'BUY_FLD_CD'    , label :'부문코드'  ,align : 'center', editable : false, width: 30, sortable:false},
                       {name : 'BUY_TEAM_CD'   , label :'팀코드'   ,align : 'left'  , editable : false, width: 30, sortable:false},
                       {name : 'BUY_PC_CD'     , label :'PC코드'  ,align : 'center', editable : false, width: 30, sortable:false},
                       {name : 'BUY_PC_NM'     , label :'PC명'   ,align : 'left'  , editable : false, width: 100, sortable:false},
                       {name : 'BUY_PC_CHK_YN' , label :'체크여부'  , hidden : true},
                       ],
        editmode    : true,                                 // 그리드 editable 여부
        gridtitle   : 'PC',                                 // 그리드명
        formid      : 'search',                             // 조회조건 form id
        height      : 300,                                  // 그리드 높이
        multiselect : true,                                 // checkbox 여부
        shrinkToFit : true,                                 // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현
        selecturl   : '/psys/getPsys1050OrgAthrList',       // 그리드 조회 URL
        events      : {
                       }
    };
    buy_pc_grid = new UxGrid(buy_pc_grid_config);
    buy_pc_grid.init();
    buy_pc_grid.setGridWidth($(".grid_custom_two > div").width());

    // 매입조직 jqGrid - End

    // 조직 목록 조회 (트리)
    fn_getOrgTree();

    // 탭 클릭 시 제어
    $(".tab-wrap .tab-list li a").on('click', function () {
        var $this = $(this);

        $this.closest('ul').find('li').removeClass("active");
        $this.closest('li').addClass("active").siblings().removeClass("");

        var hash = $this[0].hash;
        $this.closest(".tab-wrap").find(".tabMore").removeClass("active");
        $(hash).addClass("active");
    });

    // 검색결과가 없습니다 코멘트  제거
    $(".search_blank").css("display", "none");
    
    
    $("#btnSaveShop").on("click", btnSaveShop);
    $("#btnSaveBuy").on("click", btnSaveBuy);
});


//새로운 데이터 타입을 만들어야 한다. //
function btnSaveShop() {
	
	$("#shop_str_grid").editCell(0, 0, false);
	
	
    var org_cd = $("#org_cd").val();
    var strdate     = shop_str_grid.getSelectRows();    //점 선택 정보.
    var flrdata     = shop_flr_grid.getSelectRows();    //층 선택 정보.
    var pcdata      = shop_pc_grid.getSelectRows();    //pc 선택 정보.
    
	
	var strObjs = {}; // 점에 대한 객체 정보. 
	var flrObjs = {}; // 점,층에 대한 객체 정보
	var dataArray = []; // 실제 저장될 데이터
	var strTemp = []; // 점만 선택시 
	var flrTemp = []; // 점 피씨만 선택 시
	var orgObj = {org_cd : org_cd};
	
	
	if(org_cls_cd == "11") {
		orgObj.up_org_cd = up_org_cd;
		orgObj.up_org_incl_yn = "Y";
	}
	
    
    //기본 소속점 셋팅. 선택된 소속점을 
   	$(strdate).each(function (strIdx, strItm) {
   		if(isEmpty(flrdata)) {
   			dataArray.push($.extend({}, orgObj, strItm));
   		} else {
    		strObjs[strItm.SHOP_STR_CD] = $.extend({}, orgObj, strItm);
   		}
   	});
    
    /* ---------------------------------------------------- */
    
	$(flrdata).each(function (flrIdx, flrItm) {
		
		//중복 데이터가 있을경우 extend 한다. 
		if(strObjs.hasOwnProperty(flrItm.SHOP_STR_CD)) {
			if(strTemp.indexOf(flrItm.SHOP_STR_CD) == -1) {
				strTemp.push(flrItm.SHOP_STR_CD);
			}			
			if(isEmpty(pcdata)) {
				dataArray.push($.extend({}, strObjs[flrItm.SHOP_STR_CD], flrItm));
			} else {
				flrObjs[flrItm.SHOP_STR_CD + flrItm.SHOP_TEAM_CD] = $.extend({}, strObjs[flrItm.SHOP_STR_CD], flrItm);
			}
			
		} 
	});
    
    $(strTemp).each(function(idx, itm) {
		delete strObjs[itm];
    });
	
	$(pcdata).each(function (pcIdx, pcItm) {
		
		if(flrTemp.indexOf(pcItm.SHOP_STR_CD + pcItm.SHOP_TEAM_CD) == -1) {
			flrTemp.push(pcItm.SHOP_STR_CD + pcItm.SHOP_TEAM_CD);
        }       
		if(flrObjs.hasOwnProperty(pcItm.SHOP_STR_CD + pcItm.SHOP_TEAM_CD)) {
			dataArray.push($.extend({}, flrObjs[pcItm.SHOP_STR_CD + pcItm.SHOP_TEAM_CD], pcItm));
		} else {
			dataArray.push(flrObjs[pcItm.SHOP_STR_CD + pcItm.SHOP_TEAM_CD]);
		}
    });
	
	$(flrTemp).each(function(idx, itm) {
        delete flrObjs[itm];
    });
	
	
	// 점만 선택한 경우 저장 배열에 push
	Object.keys(strObjs).forEach(function (itm, idx) {
		dataArray.push(strObjs[itm]);
	});
	//점 , 피씨만 선택한 경우 배열에 psuh
	Object.keys(flrObjs).forEach(function (itm, idx) {
		dataArray.push(flrObjs[itm]);
	});
    
    var data        = "strdate="+JSON.stringify(dataArray).replace(/&/gi, "")+"&dataType=shop&_pre_url="+parent.preUrl.getPreUrl()+"&org_cd="+org_cd;
    
    ajax({
        url: '/psys/saveShopAll',
        data : data ,
        async : false,
        success: function(data) {
            if (data.RESULT == "S") {
                alert('저장되었습니다');   
                return;
            } else {
                alert("일시적 오류입니다\n잠시후 다시 시도하세요.")
                // e.preventDefault();
                return;
            }
        }
    });
    
	
}

function btnSaveBuy() {
	
	$("#buy_fld_grid").editCell(0, 0, false);
	
	var org_cd = $("#org_cd").val();
    var flddate     = buy_fld_grid.getSelectRows();    // 매입 부분 선택 정보.
    var teamdata    = buy_team_grid.getSelectRows();   //매입 팀 선택 정보.
    var pcdata      = buy_pc_grid.getSelectRows();    //매입 pc 선택 정보.
    
    var orgObj = {org_cd : org_cd};
    if(org_cls_cd == "11") {
        orgObj.up_org_cd = up_org_cd;
        orgObj.up_org_incl_yn = "Y";
    }
    
    if(isEmpty(org_cd) || isEmpty(flddate)) {
        alert("저장할 데이터를 선택해주세요.");
    }
    
    var fldObjs = {}; // 점에 대한 객체 정보. 
    var teamObjs = {}; // 점,층에 대한 객체 정보
    var dataArray = []; // 실제 저장될 데이터
    var fldTemp = []; // 점만 선택시 
    var teamTemp = []; // 점 피씨만 선택 시
    
    
    
    //기본 소속점 셋팅. 선택된 소속점을 
    $(flddate).each(function (fldIdx, fldItm) {
        if(isEmpty(teamdata)) {
            dataArray.push($.extend({}, orgObj, fldItm));
        } else {
        	fldObjs[fldItm.BUY_FLD_CD] = $.extend({}, orgObj, fldItm);
        }
    });
    
    $(teamdata).each(function (teamIdx, teamItm) {
        
        //중복 데이터가 있을경우 extend 한다. 
        if(fldObjs.hasOwnProperty(teamItm.BUY_FLD_CD)) {
            if(fldTemp.indexOf(teamItm.BUY_FLD_CD) == -1) {
            	fldTemp.push(teamItm.BUY_FLD_CD);
            }           
            if(isEmpty(pcdata)) {
                dataArray.push($.extend({}, fldObjs[teamItm.BUY_FLD_CD], teamItm));
            } else {
            	teamObjs[teamItm.BUY_FLD_CD + teamItm.BUY_TEAM_CD] = $.extend({}, fldObjs[teamItm.BUY_FLD_CD], teamItm);
            }
            
        } 
    });
    
    $(fldTemp).each(function(idx, itm) {
        delete fldObjs[itm];
    });
    
    
    $(pcdata).each(function (pcIdx, pcItm) {
        
        if(teamTemp.indexOf(pcItm.BUY_FLD_CD + pcItm.BUY_TEAM_CD) == -1) {
        	teamTemp.push(pcItm.BUY_FLD_CD + pcItm.BUY_TEAM_CD);
        }       
        if(teamObjs.hasOwnProperty(pcItm.BUY_FLD_CD + pcItm.BUY_TEAM_CD)) {
            dataArray.push($.extend({}, teamObjs[pcItm.BUY_FLD_CD + pcItm.BUY_TEAM_CD], pcItm));
        } else {
            dataArray.push(teamObjs[pcItm.BUY_FLD_CD + pcItm.BUY_TEAM_CD]);
        }
    });
    
    $(teamTemp).each(function(idx, itm) {
        delete teamObjs[itm];
    });
    
    
    // 점만 선택한 경우 저장 배열에 push
    Object.keys(fldObjs).forEach(function (itm, idx) {
        dataArray.push(fldObjs[itm]);
    });
    //점 , 피씨만 선택한 경우 배열에 psuh
    Object.keys(teamObjs).forEach(function (itm, idx) {
        dataArray.push(teamObjs[itm]);
    });
    
    
    
  var data        = "strdate="+JSON.stringify(dataArray).replace(/&/gi, "")+"&dataType=buy&_pre_url="+parent.preUrl.getPreUrl()+"&org_cd="+org_cd;
    
    ajax({
        url: '/psys/saveShopAll',
        data : data ,
        async : false,
        success: function(data) {
            if (data.RESULT == "S") {
                alert('저장되었습니다');   
                return;
            } else {
                alert("일시적 오류입니다\n잠시후 다시 시도하세요.")
                // e.preventDefault();
                return;
            }
        }
    });
    
}

//grid resizing
$(window).resize(function() {
    shop_str_grid.setGridWidth($("#tab1").width());
    shop_flr_grid.setGridWidth($(".grid_custom_two > div").width());
    shop_pc_grid.setGridWidth($(".grid_custom_two > div").width());
});

/******************************
 * 트리 제어
 ******************************/

// 노드 클릭 이벤트
function fn_onClick(event, id)
{
    var tree = $.fn.zTree.getZTreeObj("tree_org")
    var node = tree.getSelectedNodes();
    var org  = node[0];

    // 그리드 초기화
    fn_reSet();

    // 소속점 조회
    shop_str_grid.retreive({data:{org_cd:org.id}});
    buy_fld_grid.retreive({data:{org_cd:org.id}});
    
    if(isNotEmpty(org.org_cls_cd) && org.org_cls_cd == "11") {
    	org_cls_cd = org.org_cls_cd;
    	up_org_cd = org.pId;
    }
    

    // 조직코드 세팅
    $("#org_cd").val(org.id);

    tree.selectNode(org);
}

/******************************
 * 컴포넌트 이벤트
 ******************************/


//체크 해제 시 층,PC 그리드에 세팅 된 데이터 삭제
function fn_gridDelRowData(gridIdObj, fpType, rowInfo, orgType)
{
   var idx = gridIdObj.getDataIDs();

   for(var i=0 ; i < idx.length ; i++)
   {
       var row = gridIdObj.getRowData(idx[i]);
       if(orgType == "shop"){
           if(fpType == "floor" && row.SHOP_STR_CD == rowInfo.SHOP_STR_CD) {
        	   
               if($("input:checkbox[id='jqg_"+ gridIdObj.gridid.replace('#','') +"_"+ idx[i] +"']").is(":checked")) {
                   $(gridIdObj.gridid).jqGrid('setSelection', idx[i], true);
               }
               gridIdObj.delRowData(idx[i]);
           }

           if(fpType == "pc" && row.SHOP_STR_CD == rowInfo.SHOP_STR_CD && row.SHOP_TEAM_CD == rowInfo.SHOP_TEAM_CD) {
        	   if($("input:checkbox[id='jqg_"+ gridIdObj.gridid.replace('#','') +"_"+ idx[i] +"']").is(":checked")) {
                   $(gridIdObj.gridid).jqGrid('setSelection', idx[i], true);
               }
               gridIdObj.delRowData(idx[i]);
           }
       }else{
           if(fpType == "floor" && row.BUY_FLD_CD == rowInfo.BUY_FLD_CD) {
        	   if($("input:checkbox[id='jqg_"+ gridIdObj.gridid.replace('#','') +"_"+ idx[i] +"']").is(":checked")) {
                   $(gridIdObj.gridid).jqGrid('setSelection', idx[i], true);
               }
               gridIdObj.delRowData(idx[i]);
           }

           if(fpType == "pc" && row.BUY_FLD_CD == rowInfo.BUY_FLD_CD && row.BUY_TEAM_CD == rowInfo.BUY_TEAM_CD) {
        	   if($("input:checkbox[id='jqg_"+ gridIdObj.gridid.replace('#','') +"_"+ idx[i] +"']").is(":checked")) {
                   $(gridIdObj.gridid).jqGrid('setSelection', idx[i], true);
               }
               gridIdObj.delRowData(idx[i]);
           }
       }
   }
}

//조직 맵핑 된 row 체크
function fn_gridSetSelection(gridIdObj, orgType)
{
   var rowIdx = gridIdObj.getDataIDs();
   for(var i=0 ; i < rowIdx.length ; i++) {
       var row = gridIdObj.getRowData(rowIdx[i]);

       if( (orgType == "shop" && (row.SHOP_FLR_CHK_YN || row.SHOP_PC_CHK_YN) == 'Y' )
            || (orgType == "buy" && (row.BUY_TEAM_CHK_YN || row.BUY_PC_CHK_YN) == 'Y')) {
           if(!$("input:checkbox[id='jqg_"+ gridIdObj.gridid.replace('#','') +"_"+ rowIdx[i] +"']").is(":checked")) {
               $(gridIdObj.gridid).jqGrid('setSelection', rowIdx[i], true);
           }

       }
   }
}

// 그리드 초기화
function fn_reSet()
{
    shop_str_grid.clearGridData();
    shop_flr_grid.clearGridData();
    shop_pc_grid.clearGridData();
    
    buy_fld_grid.clearGridData();
    buy_team_grid.clearGridData();
    buy_pc_grid.clearGridData();

}
/******************************
 * 공통 버튼
 ******************************/

// 공통 - 조회 버튼
function fn_Search()
{
    // 그리드 초기화
    fn_reSet();

    // 조직 목록(트리) 조회
    fn_getOrgTree();

    // 소속점 조회
//     shop_str_grid.retreive({data:{org_cd:'0000002596'}});

//     $('#shop_str_grid').trigger('reloadGrid');

}

// 공통 - 저장 버튼
function fn_Save()
{
    if(isEmpty($("#org_cd").val())) {
         alert('조직을 먼저 선택하세요.');
         return false;
     }

    if(isEmpty($("#status").val())) {
        alert("변경 사항이 없습니다.");
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

/******************************
 * Server
 ******************************/

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

function fn_floorList_search(rowInfo, eType, orgType)
{
    var dataObj = {};
    if(orgType == "shop") {
        gId     = shop_flr_grid;
        dataObj = {cstr_cd : rowInfo.SHOP_STR_CD, org_cd : $("#org_cd").val(), type : orgType};
    } else {
        gId     = buy_team_grid;
        dataObj = {buy_fld_cd: rowInfo.BUY_FLD_CD, org_cd : $("#org_cd").val(), type : orgType};
    }

    if(eType == true) {
        ajax({
              url       : '/psys/getPsys1051floorList'
            , data      : dataObj
            , success   : function(data){
                   if(data.RESULT != "S")
                   {
                       alert("조회 시 오류 가 발생했습니다.");
                       return;
                   }
                   

                    // 데이터 세팅
                    gId.addRowData(0, data.rows);

                    // 조직 맵핑 된 row 체크
                    fn_gridSetSelection(gId, orgType);
                }
            , error  : function(data){
                alert("조회 시 오류 가 발생했습니다.");
            }
        });

    } else {
        // 체크 해제 시  그리드에 세팅 된 데이터 삭제
        fn_gridDelRowData(gId, "floor", rowInfo, orgType);
//         fn_gridDelRowData(shop_pc_grid;, "floor", rowInfo, orgType);
    }

}

function fn_pcList_search(rowInfo, eType, orgType)
{
    var dataObj = {};
    if(orgType == "shop") {
        gId     = shop_pc_grid;
        dataObj = {
                   cstr_cd       : rowInfo.SHOP_STR_CD
                 , shop_floor_cd : rowInfo.SHOP_TEAM_CD
                 , org_cd     : $("#org_cd").val()
                 , type : orgType
                   }
    } else{
        gId     = buy_pc_grid;
        dataObj = {
                    buy_fld_cd    : rowInfo.BUY_FLD_CD
                  , buy_team_cd   : rowInfo.BUY_TEAM_CD
                  , org_cd     : $("#org_cd").val()
                  , type : orgType
                   }
    }

    if(eType == true)
    {
        ajax({
              url       : '/psys/getPsys1051PcList'
            , data      : dataObj
            , success   : function(data){
                   if(data.RESULT != "S")
                   {
                       alert("조회 시 오류 가 발생했습니다.");
                       return;
                   }

                    // 데이터 세팅
                    gId.addRowData(0, data.rows);

                    // 조직 맵핑 된 row 체크
                    fn_gridSetSelection(gId, orgType);
                }
            , error  : function(data){
                alert("조회 시 오류 가 발생했습니다.");
            }
        });

    } else {
        // 체크 해제 시 PC 그리드에 세팅 된 데이터 삭제
        fn_gridDelRowData(gId, "pc", rowInfo, orgType);
    }
}

// 직책권한 매핑 저장
function fn_savePsys()
{
    ajax({
        url  : '/psys/savePsys1050OrgAthr',
        data : $("form[name=form_org]").serialize(),
        async : false,
        success: function(data) {
            if(data.RESULT == "S") {
                alert('저장되었습니다');
                $('#form_org').clearFormData();
                fn_Search();
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
<!--                         <table id="adm_grid"></table> -->
                        <div class="menuInfo">
                            <div class="tableTop first">
                                <h3 class="title">상세정보</h3>
                            </div>
                            <form name="form_org" id="form_org" enctype="multipart/form-data" method="post" onsubmit="return false;">
                                <input type="hidden" name="status"       id="status" />
                                <input type="hidden" name="org_cd"    id="org_cd" />
                                <div class="tab-wrap">
                                    <ul class="tab-list">
                                        <li class="active"><a href="#tab1" class="tab-link" onclick="return false;">매장조직</a></li>
                                        <li><a href="#tab2" class="tab-link" onclick="return false;" >매입조직</a></li>
                                    </ul>
                                    <style>
                                        .grid_custom_two{font-size:0;}
                                        .grid_custom_two > div{display:inline-block; vertical-align: top; width: 49.5%;}
                                        .grid_custom_two > div + div{margin-left:1%;}
                                    </style>
                                    <div id="tab1" class="tabMore active">
                                        <div class="tab-right-btn">
                                            <input type="button" class="btn_common btn_default" id="btnSaveShop" value="저장" />
                                        </div>
                                        <table id="shop_str_grid"></table>
                                        <div class="grid_custom_two">
                                            <div>
                                                <table id="shop_flr_grid"></table>
                                            </div>
                                            <div>
                                                <table id="shop_pc_grid"></table>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="tab2" class="tabMore">
                                        <div class="tab-right-btn">
                                            <input type="button" class="btn_common btn_default" id="btnSaveBuy" value="저장" />
                                        </div>
                                        <table id="buy_fld_grid"></table>
                                        <div class="grid_custom_two">
                                            <div>
                                                <table id="buy_team_grid"></table>
                                            </div>
                                            <div>
                                                <table id="buy_pc_grid"></table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
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
