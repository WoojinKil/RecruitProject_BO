<%-- 
   1. 파일명   : psys1027
   2. 파일설명 : 공통 코드 샘플(콤보/라디오/체크)
   3. 작성일   : 2019-01-28
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/fileControl.js"></script>
<script type="text/javascript">
var menu_id = '<%=parameterMap.getValue("_menu_id")%>';

$(document).ready(function() {
	
});

// 조회: 내부 로직 사용자 정의
function fn_Search() {
}
// 추가: 내부 로직 사용자 정의
function fn_AddRow() {
}
// 저장: 내부 로직 사용자 정의
function fn_Save() {
}
// 삭제: 내부 로직 사용자 정의
function fn_DelRow() { 
}
// 프린트: 내부 로직 사용자 정의
function fn_Print() {
}
// 엑셀다운로드: 내부 로직 사용자 정의
function fn_ExcelDownload() {
}

function chgCombo(obj) {
	alert("선택한 값은 [" + obj.value + "] 입니다.");
}
</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
			<div class="subConTit">
				<h1><%=_title %></h1>
			</div>
			<table class="tblType1 mB20">
				<colgroup>
					<col width="15%"/>
					<col width="*"/>
				</colgroup>
				<tr>
				<th class="category" colspan="2">√. 콤보</th>
				</tr>
				<tr>
				<th><label>①. 콤보 - 기본</label></th>
				<td>
					<span class="w100">
						<%=CodeUtil.getSelectComboList("COLOR", "combo01")%>&nbsp;|&nbsp;
						<%=CodeUtil.getSelectComboList("COLOR", "combo02", "전체")%>&nbsp;|&nbsp;
						<%=CodeUtil.getSelectComboList("COLOR", "combo03", "전체", "10")%>&nbsp;|&nbsp;
						<%=CodeUtil.getSelectComboList("COLOR", "combo04", "전체", "10", "ALL")%>&nbsp;|&nbsp;
						<%=CodeUtil.getSelectComboList("COLOR", "combo05", "전체", "10", "ALL", "onchange=\"chgCombo(this)\"")%>&nbsp;|&nbsp;사용여부 →&nbsp;
						Y&nbsp;:&nbsp;<%=CodeUtil.getSelectComboList("COLOR", "combo06", "전체", "", "", "onchange=\"chgCombo(this)\"", Const.BOOLEAN_TRUE)%>
						N&nbsp;:&nbsp;<%=CodeUtil.getSelectComboList("COLOR", "combo07", "전체", "", "", "onchange=\"chgCombo(this)\"", Const.BOOLEAN_FALSE)%>
					</span>
				</td>
				</tr>
				<tr>
				<th><label>②. 콤보 - 참조값1</label></th>
				<td>
					<span class="w100">
						<%=CodeUtil.getSelectComboListRef1("COLOR", "combo08", "1")%>&nbsp;|&nbsp;
						<%=CodeUtil.getSelectComboListRef1("COLOR", "combo09", "1", "전체")%>&nbsp;|&nbsp;
						<%=CodeUtil.getSelectComboListRef1("COLOR", "combo10", "1", "전체", "20")%>&nbsp;|&nbsp;
						<%=CodeUtil.getSelectComboListRef1("COLOR", "combo11", "1", "전체", "20", "ALL")%>&nbsp;|&nbsp;
						<%=CodeUtil.getSelectComboListRef1("COLOR", "combo12", "1", "전체", "20", "ALL", "onchange=\"chgCombo(this)\"")%>&nbsp;|&nbsp;사용여부 →&nbsp;
						Y&nbsp;:&nbsp;<%=CodeUtil.getSelectComboListRef1("COLOR", "combo13", "", "전체", "", "", "onchange=\"chgCombo(this)\"", Const.BOOLEAN_TRUE)%>
						N&nbsp;:&nbsp;<%=CodeUtil.getSelectComboListRef1("COLOR", "combo14", "", "전체", "", "", "onchange=\"chgCombo(this)\"", Const.BOOLEAN_FALSE)%>
					</span>
				</td>
				</tr>
				<tr>
				<th><label>③. 콤보 - 참조값1, 2</label></th>
				<td>
					<span class="w100">
						<%=CodeUtil.getSelectComboListRef2("COLOR", "combo15", "1", "2")%>&nbsp;|&nbsp;
						<%=CodeUtil.getSelectComboListRef2("COLOR", "combo16", "1", "2", "전체")%>&nbsp;|&nbsp;
						<%=CodeUtil.getSelectComboListRef2("COLOR", "combo17", "1", "2", "전체", "30")%>&nbsp;|&nbsp;
						<%=CodeUtil.getSelectComboListRef2("COLOR", "combo18", "1", "2", "전체", "30", "ALL")%>&nbsp;|&nbsp;
						<%=CodeUtil.getSelectComboListRef2("COLOR", "combo19", "1", "2", "전체", "30", "ALL", "onchange=\"chgCombo(this)\"")%>&nbsp;|&nbsp;사용여부 →&nbsp;
						Y&nbsp;:&nbsp;<%=CodeUtil.getSelectComboListRef2("COLOR", "combo20", "", "", "전체", "", "", "onchange=\"chgCombo(this)\"", Const.BOOLEAN_TRUE)%>
						N&nbsp;:&nbsp;<%=CodeUtil.getSelectComboListRef2("COLOR", "combo21", "", "", "전체", "", "", "onchange=\"chgCombo(this)\"", Const.BOOLEAN_FALSE)%>
					</span>
				</td>
				<tr>
				<th><label>③. 콤보 - 참조값1, 2, 3</label></th>
				<td>
					<span class="w100">
						<%=CodeUtil.getSelectComboListRef3("COLOR", "combo22", "1", "2", "3")%>&nbsp;|&nbsp;
						<%=CodeUtil.getSelectComboListRef3("COLOR", "combo23", "1", "2", "3", "전체")%>&nbsp;|&nbsp;
						<%=CodeUtil.getSelectComboListRef3("COLOR", "combo24", "1", "2", "3", "전체", "40")%>&nbsp;|&nbsp;
						<%=CodeUtil.getSelectComboListRef3("COLOR", "combo25", "1", "2", "3", "전체", "40", "ALL")%>&nbsp;|&nbsp;
						<%=CodeUtil.getSelectComboListRef3("COLOR", "combo26", "1", "2", "3", "전체", "40", "ALL", "onchange=\"chgCombo(this)\"")%>&nbsp;|&nbsp;사용여부 →&nbsp;
						Y&nbsp;:&nbsp;<%=CodeUtil.getSelectComboListRef3("COLOR", "combo27", "", "", "", "전체", "", "", "onchange=\"chgCombo(this)\"", Const.BOOLEAN_TRUE)%>
						N&nbsp;:&nbsp;<%=CodeUtil.getSelectComboListRef3("COLOR", "combo28", "", "", "", "전체", "", "", "onchange=\"chgCombo(this)\"", Const.BOOLEAN_FALSE)%>
					</span>
				</td>
				</tr>
			</table>
			
			<table class="tblType1 mB20">
				<colgroup>
					<col width="15%"/>
					<col width="*"/>
				</colgroup>
				<tr>
				<th class="category" colspan="2">√. 라디오</th>
				</tr>
				<tr>
				<th><label>①. 라디오 - 기본</label></th>
				<td>
					<%=CodeUtil.getRadioBoxList("COLOR", "radio01")%><br/>
					<%=CodeUtil.getRadioBoxList("COLOR", "radio02", "10")%><br/>
					사용여부 → Y<br/><br/>
					<%=CodeUtil.getRadioBoxList("COLOR", "radio03", "10", Const.BOOLEAN_TRUE)%><br/>
					사용여부 → N<br/><br/>
					<%=CodeUtil.getRadioBoxList("COLOR", "radio04", "70", Const.BOOLEAN_FALSE)%>
				</td>
				</tr>
				<tr>
				<th><label>②. 라디오 - 참조값1</label></th>
				<td>
					<%=CodeUtil.getRadioBoxListRef1("COLOR", "radio05", "1")%><br/>
					<%=CodeUtil.getRadioBoxListRef1("COLOR", "radio06", "1", "20")%><br/>
					사용여부 → Y<br/><br/>
					<%=CodeUtil.getRadioBoxListRef1("COLOR", "radio07", "", "20", Const.BOOLEAN_TRUE)%><br/>
					사용여부 → N<br/><br/>
					<%=CodeUtil.getRadioBoxListRef1("COLOR", "radio08", "", "70", Const.BOOLEAN_FALSE)%><br/>
				</td>
				</tr>
				<tr>
				<th><label>③. 라디오 - 참조값1, 2</label></th>
				<td>
					<%=CodeUtil.getRadioBoxListRef2("COLOR", "radio09", "1", "2")%><br/>
					<%=CodeUtil.getRadioBoxListRef2("COLOR", "radio10", "1", "2", "30")%><br/>
					사용여부 → Y<br/><br/>
					<%=CodeUtil.getRadioBoxListRef2("COLOR", "radio11", "", "", "30", Const.BOOLEAN_TRUE)%><br/>
					사용여부 → N<br/><br/>
					<%=CodeUtil.getRadioBoxListRef2("COLOR", "radio12", "", "", "70", Const.BOOLEAN_FALSE)%><br/>
				</td>
				</tr>
				<tr>
				<th><label>③. 라디오 - 참조값1, 2, 3</label></th>
				<td>
					<%=CodeUtil.getRadioBoxListRef3("COLOR", "radio13", "1", "2", "3")%><br/>
					<%=CodeUtil.getRadioBoxListRef3("COLOR", "radio14", "1", "2", "3", "40")%><br/>
					사용여부 → Y<br/><br/>
					<%=CodeUtil.getRadioBoxListRef3("COLOR", "radio15", "", "", "", "40", Const.BOOLEAN_TRUE)%><br/>
					사용여부 → N<br/><br/>
					<%=CodeUtil.getRadioBoxListRef3("COLOR", "radio16", "", "", "", "70", Const.BOOLEAN_FALSE)%><br/>
				</td>
				</tr>
			</table>
			
			<table class="tblType1 mB20">
				<colgroup>
					<col width="15%"/>
					<col width="*"/>
				</colgroup>
				<tr>
				<th class="category" colspan="2">√. 체크</th>
				</tr>
				<tr>
				<th><label>①. 체크 - 기본</label></th>
				<td>
					<%=CodeUtil.getCheckBoxList("COLOR", "check01")%><br/>
					<%=CodeUtil.getCheckBoxList("COLOR", "check02", "전체")%><br/>
					<%=CodeUtil.getCheckBoxList("COLOR", "check03", "전체", "10")%><br/>
					사용여부 → Y<br/><br/>
					<%=CodeUtil.getCheckBoxList("COLOR", "check04", "전체", "10", Const.BOOLEAN_TRUE)%><br/>
					사용여부 → N<br/><br/>
					<%=CodeUtil.getCheckBoxList("COLOR", "check05", "전체", "70", Const.BOOLEAN_FALSE)%>
					
				</td>
				</tr>
				<tr>
				<th><label>②. 체크 - 참조값1</label></th>
				<td>
					<%=CodeUtil.getCheckBoxListRef1("COLOR", "check06", "1")%><br/>
					<%=CodeUtil.getCheckBoxListRef1("COLOR", "check07", "1", "전체")%><br/>
					<%=CodeUtil.getCheckBoxListRef1("COLOR", "check08", "1", "전체", "20")%><br/>
					사용여부 → Y<br/><br/>
					<%=CodeUtil.getCheckBoxListRef1("COLOR", "check09", "", "", "20", Const.BOOLEAN_TRUE)%><br/>
					사용여부 → N<br/><br/>
					<%=CodeUtil.getCheckBoxListRef1("COLOR", "check10", "", "", "70", Const.BOOLEAN_FALSE)%><br/>
				</td>
				</tr>
				<tr>
				<th><label>③. 체크 - 참조값1, 2</label></th>
				<td>
					<%=CodeUtil.getCheckBoxListRef2("COLOR", "check11", "1", "2")%><br/>
					<%=CodeUtil.getCheckBoxListRef2("COLOR", "check12", "1", "2", "전체")%><br/>
					<%=CodeUtil.getCheckBoxListRef2("COLOR", "check13", "1", "2", "전체", "30")%><br/>
					사용여부 → Y<br/><br/>
					<%=CodeUtil.getCheckBoxListRef2("COLOR", "check14", "", "", "", "30", Const.BOOLEAN_TRUE)%><br/>
					사용여부 → N<br/><br/>
					<%=CodeUtil.getCheckBoxListRef2("COLOR", "check15", "", "", "", "70", Const.BOOLEAN_FALSE)%><br/>
				</td>
				</tr>
				<tr>
				<th><label>③. 체크 - 참조값1, 2, 3</label></th>
				<td>
					<%=CodeUtil.getCheckBoxListRef3("COLOR", "check16", "1", "2", "3")%><br/>
					<%=CodeUtil.getCheckBoxListRef3("COLOR", "check17", "1", "2", "3", "전체")%><br/>
					<%=CodeUtil.getCheckBoxListRef3("COLOR", "check18", "1", "2", "3", "전체", "40")%><br/>
					사용여부 → Y<br/><br/>
					<%=CodeUtil.getCheckBoxListRef3("COLOR", "check19", "", "", "", "", "40", Const.BOOLEAN_TRUE)%><br/>
					사용여부 → N<br/><br/>
					<%=CodeUtil.getCheckBoxListRef3("COLOR", "check20", "", "", "", "", "70", Const.BOOLEAN_FALSE)%><br/>
				</td>
				</tr>
			</table>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>