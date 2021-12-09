<%-- 
   1. 파일명 : sample1017
   2. 파일설명 : 공지사항 게시글 상세  : 일반게시판
   3. 작성일 : 2019-09-09
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/bFileControl.js"></script>
<style>.b_type1{display:none;}</style>
<script type="text/javascript">
var board_editor;
var newFileFlag = false;

$(document).ready(function() {
	// 게시판 정보 조회 : 일반게시판
	ajax({
		url:'/pdsp/getPdsp1009List1.adm',
		success:function(data) {
			var boardModuleList = data.boardModuleList;
			for(var i = 0; i < boardModuleList.length; i++) {
				if(_param == boardModuleList[i].MODL_SEQ) {
					$("#modl_nm").text(boardModuleList[i].MODL_NM);
					$("#modl_tp").val(boardModuleList[i].MODL_TP);
					modFormInit(boardModuleList[i].MODL_TP);
					break;
				}
			}
		}
	});
	
	// 수정 버튼 클릭 시
	$("#btn_mod1, #btn_mod2, #btn_mod4, #btn_mod6").click(function() {
		if(validChk()) {
			submitFormWrite();
		}
	});

	// 목록 버튼 클릭 시
	$("#btn_list1, #btn_list2, #btn_list4, #btn_list6").click(function() {
 		addTabInFrame("/psys/forward.sample1016.adm", "CHG", encodeURIComponent(_param3));
	});
	
	
	// 초기화
	doInit();
});

// 초기화
function doInit() {
	// 게시글 상세 조회
	getDocDtl();
	

}




// 게시글 상세 조회
function getDocDtl() {
	// DATAPICKER 초기화
	$("#pbl_date").datepicker({
		changeMonth:true,
		changeYear:true,
		dateFormat:'yy-mm-dd',	
	}).attr("readonly", true);
	
	// 일반컨텐츠 : 게시글 상세
	ajax({
		url:"/pbbs/getPbbs1005DocDtlList",
		data:{modl_seq: _param, doc_seq:_param2, modl_tp:$("#modl_tp").val()},
		success: function(data) {
			// 상세 정보 설정
			if(isNotEmpty(data.tbbsDocInfMap)) {
				var map = data.tbbsDocInfMap;
				var user_nm = map.user_nm;
				var lgn_id = map.lgn_id;
				var crt_dttm = $.timestampToString(new Date(map.crt_dttm));
				if(isEmpty(user_nm)) user_nm = "-";
				if(isEmpty(lgn_id)) lgn_id = "-";
				// TYPE1 단독
				$("#ctg_seq").val(map.ctg_seq);
				$("#author").val(map.author);
				$("#total_page_num").val(map.total_page_num);
				$("#pbl_date").val(map.pbl_date);
				$("#contents_table").val(map.contents_table);
				// TYPE1&TYPE2 공통
				$("#titl").text(map.titl);
				$("input[name='cmt_pms_stat']:radio[value='"+map.cmt_pms_stat+"']").attr("checked",true);
				$("input[name='notc_yn']:radio[value='"+map.notc_yn+"']").attr("checked",true);
				$("#lgn_id").text(lgn_id);
				$("#crt_dttm").text(crt_dttm.substring(0,4)+"-"+crt_dttm.substring(5,7)+"-"+crt_dttm.substring(8,10));
				/* board_editor.instances['cts'].setData(map.cs); */
				$("#editorCts2").html(map.cts);
				
				// TYPE4 단독
				$("#org_img_name").attr("href", "javascript:fileDown("+ map.fl_seq +");");
				$("#org_img_name").text(map.ori_fl_nm);
				
				$(".new_img").hide();	
				$(".org_img").show();
				newFileFlag = false;
				
			}else {
				alert("해당하는 게시글이 존재하지 않습니다. 다시 조회해주세요.");
				return;
			}
		}
	});
}

// 수정 폼 초기화
function modFormInit(modl_tp) {
	$(".b_type").show();
	// BOARD TYPE1
	if("B_TYPE1" == modl_tp) {
		$(".b_type1").show();
		$(".b_type2").hide();
		$(".b_type4").hide();
		$(".b_type6").hide();
	}
	// BOARD TYPE2
	else if("B_TYPE2" == modl_tp) {
		$(".b_type1").hide();
		$(".b_type2").show();
		$(".b_type4").hide();
		$(".b_type6").hide();
	}
	// BOARD TYPE4
	else if("B_TYPE4" == modl_tp) {
		$(".b_type1").hide();
		$(".b_type2").hide();
		$(".b_type4").show();
		$(".b_type6").hide();
	}
	// BOARD TYPE4
	else if("B_TYPE6" == modl_tp) {
		$(".b_type1").hide();
		$(".b_type2").hide();
		$(".b_type4").hide();
		$(".b_type6").show();
	}
}
</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
		<h1><%=_title %></h1>	
			<table class="tblType1">
				<colgroup>
					<col width="15%" />
					<col width="35%" />
					<col width="15%" />
					<col width="35%" />
				</colgroup>
				<tr>
					<th>게시판종류</th>
					<td id="modl_nm"></td>
					<th class="b_type1" style="display:none;"><label for="ctg_seq" class="vv">분류</label></th>
					<td class="b_type1" style="display:none;">
						<span class="txt_pw">
							<select class="select w20" name="ctg_seq" id="ctg_seq">
								<option value="880">기본</option>
								<option value="881">수탁</option>
								<option value="882">성과</option>
							</select>
						</span>
						<div class="grid_btn">
							<button type="button" class="btn_common btn_default" id="btn_list1">목록</button>
							<button type="button" class="btn_common btn_default" id="btn_mod1">수정</button>
						</div>
					</td>
					<td class="b_type2" colspan="2" style="display:none;">
						<div class="grid_btn">
							<button type="button" class="btn_common btn_default" id="btn_list2">목록</button>
							<button type="button" class="btn_common btn_default" id="btn_mod2">수정</button>
						</div>
					</td>
					<td class="b_type4" colspan="2">
						<div class="grid_btn">
							<button type="button" class="btn_common btn_default" id="btn_list4">목록</button>
							<button type="button" class="btn_common btn_default" id="btn_mod4">수정</button>
						</div>
					</td>
					<td class="b_type6" colspan="2">
						<div class="grid_btn">
							<button type="button" class="btn_common btn_default" id="btn_list6">목록</button>
							<button type="button" class="btn_common btn_default" id="btn_mod6">수정</button>
						</div>
					</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><span id="lgn_id"></span></td>
					<th>작성일</th>
					<td><span id="crt_dttm"></span></td>
				</tr>
				<tr>
					<th><label for="titl" class="vv">제목</label></th>
					<td colspan="3"><span class="txt_pw" id="titl"></span></td>
				</tr>
				<tr class="b_type1" style="display:none;">
					<th><label for="author" class="vv">저자</label></th>
					<td colspan="3"><span class="txt_pw"><input type="text" name="author" id="author" class="w100" placeholder="*연구보고서의 저자를 입력하세요."/></span></td>
				</tr>
				<tr class="b_type1" style="display:none;">
					<th><label for="total_page_num" class="vv">면수</label></th>
					<td><span class="txt_pw"><input type="text" name="total_page_num" id="total_page_num" class="w100" placeholder="*총 페이지 숫자를 입력해주세요."/></span></td>
					<th><label for="pbl_date" class="vv">발행일</label></th>
					<td><span class="txt_pw"><input type="text" name="pbl_date" id="pbl_date" class="w100" placeholder="*발행일을 입력해주세요. (yyyy-mm-dd)"/></span></td>
				</tr>
				<tr class="b_type1" style="display:none;">
					<th><label for="contents_table" class="vv">목차</label></th>
					<td colspan="3"><textarea id="contents_table" name="contents_table" class="textarea w100 h80" placeholder="*목차를 입력해주세요."></textarea></td>
				</tr>
				<tr class="b_type" style="display:none;">
					<th><label for="fileTxt">썸네일 이미지</label></th>
					<td class="org_img">
						<a href="#" id="org_img_name" style="height:26px;font-size:13px;font-weight: bold;"></a>
					</td>
					<td class="org_img" colspan="2"></td>
					<td class="new_img">
						<form name="frm_img" id="frm_img" enctype="multipart/form-data" method="post" onsubmit="return false;">
						<span class="fileAdd w100">
							<input id="fileTxt" type="text" class="w70" value="" placeholder="선택된 파일 없음" readonly>
							<input type="button" value="파일첨부" class="btn_common btn_default" onclick="javascript:document.getElementById('img_files').click();">
							<input id="img_files" type="file" style='visibility:hidden;' name="img_files" onchange="ChangeText(this, 'fileTxt');" accept=".jpg, .jpeg, .bmp, .gif, .png"/>
						</span>
						</form>
					</td>
					<td class="new_img" colspan="3"><p><b class="required">*허용확장자 :</b> .jpg, .jpeg, .png, .gif, .bmp</p></td>
				</tr>
			</table>
			<div class="resultView">
				<div class="editor">
					<div id="editorCts2"></div>
					
					<!-- <textarea name="cts" id="cts"></textarea> -->
				</div>
			</div>
			<input type="hidden" name="modl_tp" id="modl_tp"/>
			<form name="frm_file" id="frm_file" enctype="multipart/form-data" method="post" onsubmit="return false;">
				<div id="fileContainer" style="display:none;">
					<input type="file" id="files" name="files" multiple="multiple" />
				</div>
			</form>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
