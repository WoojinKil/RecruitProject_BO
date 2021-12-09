<%-- 
   1. 파일명 : btnList
   2. 파일설명: 버튼 리스트(include)
   3. 작성일 : 2018-04-09
   4. 작성자 : TANINE
--%>
<%@page import="kr.co.ta9.pandora3.app.util.CommonUtil"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

String requestUri = (String)request.getAttribute("javax.servlet.forward.request_uri");
String usrIp = CommonUtil.getRemoteIpAddr(request);
String accessVDI = "Y";
boolean accessUrlFlag = false;

// context 가 설정되어있을경우 context명은 뺀다
String contextPath = request.getContextPath();
if (contextPath != null && requestUri.indexOf(contextPath) == 0) {
    requestUri = requestUri.substring(contextPath.length());
}

String jsonString = session.getAttribute("MENU_LIST").toString();

JSONParser jsonParse = new JSONParser();
JSONObject jsonObj = (JSONObject) jsonParse.parse(jsonString);

JSONArray personArray = (JSONArray) jsonObj.get("SESSION_MENU_LIST");

List<Map<String,Object>> menuListMap = (List<Map<String, Object>>) personArray;

if(menuListMap != null) {
    for(Map<String, Object> map : menuListMap) {
        if(map.containsValue(requestUri)) {
            accessUrlFlag = true;
            if("Y".equals(map.get("VDI_SCRN_YN"))) {
            	accessVDI = CommonUtil.getVdi(usrIp);      // VDI 허용여부확인
            }
        };
        
    }
}

if(!accessUrlFlag) {
    String _path = request.getContextPath();
    _path += "/error/forward.errorFrame404.adm";
    response.sendRedirect(_path);
}

//N일 경우 VDI가 Y인데 허용되지 않았을 경우.       --추가한 부분: vdi.ip 에러로 일단 주석처리함 2020.05.19
/* 
if("N".equals(accessVDI)) {
	String _path = request.getContextPath();
	_path += "/error/forward.vdiFrame404.adm";
	response.sendRedirect(_path);
} 
*/

%>

<!-------------- 수정 ------------->
<div class="subConTit">
	<style>
	.layer_popup {border: 0 none !important; -webkit-box-sizing: border-box; box-sizing: border-box;}
	.helpPop .helpPopCon .custom_title{position: relative; font-size: 22px; font-weight: 400; color: #333; height: 40px; line-height: 40px; margin: 0 0 14px 0;font-family: 'Noto Sans KR', sans-serif; border-bottom: 2px solid #666; text-align:left;}
	.helpPop .helpPopCon .txt img{max-width:100%; margin:0 auto;}
	</style>
	<h1 class="title">
		<button class="btnPageBookMark" id="btnPageBookMark">즐겨찾기</button>
		<span class="subTitle"><%= _title %></span>
		<button type="button" class="questionBtn" id="questionBtn">
			<img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_question.png" alt="">
		</button>
		<div class="grid_btn" id="btn_info"></div>
	</h1>
	<!-- <div class="breadcrumb">
		<span class="home">홈</span>
		<span class="depth1"></span>
		<span class="depth2"></span>
		<span class="depth3"></span>
	</div> -->
</div>
<!-- <div class="pageBtnWrap"></div> -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/jquery.bpopup.min.js"></script>
<script type="text/javascript">
var helpText;
var _btnDateList;
var _existBookMark="N";

$(document).ready(function(){
	// breadCrumb(홈 > 시스템관리 > 코드관리 > 코드관리) 메뉴 조회	
	getBreadCrumb(_menu_id);
	parent.checkBookMark();
	
	/*즐겨찾기 등록*/	
	$("#btnPageBookMark").click(function() {
		var selectedTabIdx=0;
		var objNav = parent.$(".ui-tabs-nav li");
		var _tab_cnt = objNav.length;
		var currMenuId =0;
		for(var idx=0; idx < _tab_cnt; idx++){
			var tmpSelected = $(objNav[idx]).attr("aria-selected");
			if(tmpSelected=="true"){
				var tabId =$(objNav[idx]).children('a').attr("href");
				currMenuId =  parent.$(tabId).get(0).contentWindow._menu_id;
			}
		}
		if(_existBookMark=="N"){
			ajax({
				url: '/psys/insertTsysAdmFvrt',
				data :  {mnu_seq:currMenuId},
				success: function(data) {
					changePageBookMark();
				}
			});
		}else{
			if(confirm("즐겨찾기를 삭제하시겠습니까?")){
				ajax({
					url: '/psys/deleteTsysAdmFvrt',
					data :  {mnu_seq:currMenuId},
					success: function(data) {
						_existBookMark=="N";
						checkBookMark();
					}
				});
			}else{
				return;
			}
		}
	});
   
   /*즐겨찾기유무 체크*/
	checkBookMark();
   
   
   $("#questionBtn").on("click", function () {
	   getHelpInfo();
   });
});

function  checkBookMark(){
	 var selectedTabIdx=0;
		var objNav = parent.$(".ui-tabs-nav li");
		var _tab_cnt = objNav.length;
		var currMenuId =0;
		for(var idx=0; idx < _tab_cnt; idx++){
			var tmpSelected = $(objNav[idx]).attr("aria-selected");
			if(tmpSelected=="true"){
				var tabId =$(objNav[idx]).children('a').attr("href");
				currMenuId =  parent.$(tabId).get(0).contentWindow._menu_id;
			}
	  }
		ajax({
			url: '/psys/selectExistTsysAdmFvrt',
			data :  {mnu_seq:currMenuId},
			success: function(data) {
				if(data.EXIST_YN=="Y"){
					$( "#btnPageBookMark" ).addClass( "on" );
					_existBookMark ="Y";
				}else{
					$( "#btnPageBookMark" ).removeClass( "on" );
					_existBookMark ="N";
				}
			}
		})
	  
 }	

function changePageBookMark(){
	$( "#btnPageBookMark" ).addClass( "on" );
	_existBookMark ="Y";
}

function getBtnList(){
	// 메뉴별 버튼 목록 조회
	ajax({
		url: '/psys/getTsysPgmInfBtnList',
		data :  {mnu_seq:_menu_id},
		success: function(data) {
			makePgmBtnData(data.rows);
			_btnDateList = data.rows;
		}
	});
}

function makePgmBtnData(data){
	var btn_info = $('#btn_info');
	
	$.each(data, function(index, pgminfo){
		var pgmBtnCd = pgminfo.PGM_BTN_CD;
		var cd_nm = pgminfo.CD_NM;
		var ref_1= pgminfo.REF_1;
		
		// 조회버튼 외의 버튼은 grid.js에서 호출
		if(ref_1 == "search" ) {
			btn_info.append('<button class="btn_common btn_gray" id="btn_'+ref_1+'" name="_btnList" value="'+pgmBtnCd+'">'+cd_nm+'</button>' );
			
			$("#btn_search").click(function() {
				fn_Search();
			});			
		}
	});
}
function getHelpInfo(){
	ajax({
		url: '/psys/getPsys1024Inf',
		data: {mnu_seq: _menu_id},
		success: function(data){
			
			if(isNotEmpty(data.rows[0])) {
				
				helpText = data.rows[0].HCO_CTS
				helpPopup(helpText);
			} 
		}
	})
}

/* 버튼 제약 공통 정의
 * 버튼 ID
	1.btn_retreive	: 조회버튼
	2.btn_add		: 추가버튼
	3.btn_save		: 저장버튼
	4.btn_delete	: 삭제버튼
 * 버튼 제약 함수
	1.버튼 표시 제약 : chkBtnView
	2.버튼 조작 제약 : chkBtnControl
 */
function chkBtnView(result) {
	var _menuInfo = parent.menu_list;
	var _btnList ;
	if(_menuInfo.length){
		$.each(_menuInfo, function(index, menu){
				var menuId = menu.MENU_ID;
				if(menuId==_menu_id){
					_btnList = menu.BTN_INFO;
				}
		});
	}
	var cnt =$("[name=_btnList]").length;
	var obj =$("[name=_btnList]")
	for(var i =0; i < cnt; i++){
		 var btnVal =  obj[i].value;
		
		if(_btnList.indexOf(btnVal)>=0){
			$("#"+obj[i].id).css("display","");
		}else{
			$("#"+obj[i].id).css("display","none");
		}
	}
}

function chkBtnControl(result) {
// 	$("#btn_search").click(function() {
// 		fn_Search();
// 	});
	$("#btn_add").click(function() {
		fn_Add();
	});
	$("#btn_save").click(function() {
		fn_Save();
	});
	$("#btn_delete").click(function() {
		fn_Delete();
	});
	$("#btn_prnt").click(function() {
		fn_Print();
	});
	$("#btn_excelDownload").click(function() {
		fn_ExcelDownload();
	});
	$("#btn_admission").click(function() {
		fn_Admission();
	});
	$("#btn_help").click(function() {
		getHelpInfo();
	});
	// 2019-01-15 목록 버튼 추가
	$("#btn_list").click(function() {
		fn_List();
	});
	$("#btn_addRow").click(function() {
		fn_AddRow();
	});
	$("#btn_delRow").click(function() {
		fn_DelRow();
	});
	$("#btn_new").click(function() {
		fn_New();
	});
}

/*
 * breadCrumb(홈 > 시스템관리 > 코드관리 > 코드관리) 메뉴 조회
 */
function getBreadCrumb(mnu_seq) {
	ajax({
		url: '/psys/getTsysAdmMnuBreadCrumb',
		data: {mnu_seq: mnu_seq},
		success: function(data){
			$(".depth1").text(data.TOP_MNU_NM);
			$(".depth2").text(data.MIDD_MNU_NM);
			$(".depth3").text(data.BTM_MNU_NM);
		}
	});
}

// 함수 호출
getBtnList();
//chkBtnView();
// chkBtnControl();
</script>