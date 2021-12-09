<%-- 
   1. 파일명   : psys1028
   2. 파일설명 : 공통 메세지 샘플
   3. 작성일   : 2019-02-01
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
	$(".btn_default").click(function() {
		var id = $(this).attr("id");
		var idArr = id.split("_");
		var type = idArr[0];
		var layerYn = idArr[1];
		var msg = idArr[2];
		openMsg(type, layerYn, msg);
	});
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

function openMsg(type, layerYn, msg) {
	if("Y" == layerYn) {
		if("ALERT" == type) {
			GMsgLayer.alert(msg);
		}else if("CONFIRM" == type) {
			GMsgLayer.confirm(msg);
		}else if("ERROR" == type) {
			GMsgLayer.error(msg);
		}
	}else {
		if("ALERT" == type || "ERROR" == type) {
			alert(msg);
		}else if("CONFIRM" == type) {
			confirm(msg);
		}
	}
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
					<col width="33%"/>
					<col width="33%"/>
					<col width="*"/>
				</colgroup>
				<tr>
					<th>
						<label>메세지 KEY / 내용</label>
					</th>
					<th>
						<label>유틸 종류<br/>-. S : Spring taglib<br/>-. M : MessageUtil</label>
					</th>
					<th>
						<label>메세지 출력</label>
					</th>
				</tr>
				<tr>
					<th colspan="3">√. 라벨</th>
				</tr>
				<tr>
					<td>MSG.LABEL.000001 / 제목</td>
					<td>S</td>
					<td><s:message code="MSG.LABEL.000001"></s:message></td>
				</tr>
				<tr>
					<td>MSG.LABEL.000001 / 제목</td>
					<td>M</td>
					<td><%=MessageUtil.getMsg("MSG.LABEL.000001")%></td>
				</tr>
				<tr>
					<td>MSG.LABEL.000002 / {0}의 내용</td>
					<td>S</td>
					<td><s:message code="MSG.LABEL.000002" arguments="공통 메세지 샘픔"></s:message></td>
				</tr>
				<tr>
					<td>MSG.LABEL.000002 / {0}의 내용</td>
					<td>M</td>
					<td><%=MessageUtil.getMsg("MSG.LABEL.000002", new String[]{"공통 메세지 샘플"})%></td>
				</tr>
				<tr>
					<th colspan="3">√. ALERT</th>
				</tr>
				<tr>
					<td>MSG.ALERT.000001 / 정상적으로 저장되었습니다.</td>
					<td>S</td>
					<td>
						<input type="button" id="ALERT_N_<s:message code="MSG.ALERT.000001"></s:message>" value="Alert!" class="btn_common btn_default" />
						<input type="button" id="ALERT_Y_<s:message code="MSG.ALERT.000001"></s:message>" value="Alert Layer!" class="btn_common btn_default" />
					</td>
				</tr>
				<tr>
					<td>MSG.ALERT.000001 / 정상적으로 저장되었습니다.</td>
					<td>M</td>
					<td>
						<input type="button" id="ALERT_N_<%=MessageUtil.getMsg("MSG.ALERT.000001")%>" value="Alert!" class="btn_common btn_default" />
						<input type="button" id="ALERT_Y_<%=MessageUtil.getMsg("MSG.ALERT.000001")%>" value="Alert Layer!" class="btn_common btn_default" />
					</td>
				</tr>
				<tr>
					<td>MSG.ALERT.000002 / 작업이 정상적으로 실행되지 않았습니다. 잠시후 다시 시도하세요.</td>
					<td>S</td>
					<td>
						<input type="button" id="ALERT_N_<s:message code="MSG.ALERT.000002"></s:message>" value="Alert!" class="btn_common btn_default" />
						<input type="button" id="ALERT_Y_<s:message code="MSG.ALERT.000002"></s:message>" value="Alert Layer!" class="btn_common btn_default" />
					</td>
				</tr>
				<tr>
					<td>MSG.ALERT.000002 / 작업이 정상적으로 실행되지 않았습니다. 잠시후 다시 시도하세요.</td>
					<td>M</td>
					<td>
						<input type="button" id="ALERT_N_<%=MessageUtil.getMsg("MSG.ALERT.000002")%>" value="Alert!" class="btn_common btn_default" />
						<input type="button" id="ALERT_Y_<%=MessageUtil.getMsg("MSG.ALERT.000002")%>" value="Alert Layer!" class="btn_common btn_default" />
					</td>
				</tr>
				<tr>
					<td>MSG.ALERT.000003 / {0}에 최소 {1}자까지 입력하셔야 합니다.</td>
					<td>S</td>
					<td>
						<input type="button" id="ALERT_N_<s:message code="MSG.ALERT.000003" arguments="입력란,5"></s:message>" value="Alert!" class="btn_common btn_default" />
						<input type="button" id="ALERT_Y_<s:message code="MSG.ALERT.000003" arguments="입력란,5"></s:message>" value="Alert Layer!" class="btn_common btn_default" />
					</td>
				</tr>
				<tr>
					<td>MSG.ALERT.000003 / {0}에 최소 {1}자까지 입력하셔야 합니다.</td>
					<td>M</td>
					<td>
						<input type="button" id="ALERT_N_<%=MessageUtil.getMsg("MSG.ALERT.000003", new String[]{"입력란", "5"})%>" value="Alert!" class="btn_common btn_default" />
						<input type="button" id="ALERT_Y_<%=MessageUtil.getMsg("MSG.ALERT.000003", new String[]{"입력란", "5"})%>" value="Alert Layer!" class="btn_common btn_default" />
					</td>
				</tr>
				<tr>
					<th colspan="3">√. CONFIRM</th>
				</tr>
				<tr>
					<td>MSG.CONFIRM.000001 / 저장하시겠습니까?</td>
					<td>S</td>
					<td>
						<input type="button" id="CONFIRM_N_<s:message code="MSG.CONFIRM.000001"></s:message>" value="Confirm!" class="btn_common btn_default" />
						<input type="button" id="CONFIRM_Y_<s:message code="MSG.CONFIRM.000001"></s:message>" value="Confirm Layer!" class="btn_common btn_default" />
					</td>
				</tr>
				<tr>
					<td>MSG.CONFIRM.000001 / 저장하시겠습니까?</td>
					<td>M</td>
					<td>
						<input type="button" id="CONFIRM_N_<%=MessageUtil.getMsg("MSG.CONFIRM.000001")%>" value="Confirm!" class="btn_common btn_default" />
						<input type="button" id="CONFIRM_Y_<%=MessageUtil.getMsg("MSG.CONFIRM.000001")%>" value="Confirm Layer!" class="btn_common btn_default" />
					</td>
				</tr>
				<tr>
					<td>MSG.CONFIRM.000002 / 삭제하시겠습니까?</td>
					<td>S</td>
					<td>
						<input type="button" id="CONFIRM_N_<s:message code="MSG.CONFIRM.000002"></s:message>" value="Confirm!" class="btn_common btn_default" />
						<input type="button" id="CONFIRM_Y_<s:message code="MSG.CONFIRM.000002"></s:message>" value="Confirm Layer!" class="btn_common btn_default" />
					</td>
				</tr>
				<tr>
					<td>MSG.CONFIRM.000002 / 삭제하시겠습니까?</td>
					<td>M</td>
					<td>
						<input type="button" id="CONFIRM_N_<%=MessageUtil.getMsg("MSG.CONFIRM.000002")%>" value="Confirm!" class="btn_common btn_default" />
						<input type="button" id="CONFIRM_Y_<%=MessageUtil.getMsg("MSG.CONFIRM.000002")%>" value="Confirm Layer!" class="btn_common btn_default" />
					</td>
				</tr>
				<tr>
					<td>MSG.CONFIRM.000003 / {0}을 저장하시겠습니까?</td>
					<td>S</td>
					<td>
						<input type="button" id="CONFIRM_N_<s:message code="MSG.CONFIRM.000003" arguments="수정된 내용"></s:message>" value="Confirm!" class="btn_common btn_default" />
						<input type="button" id="CONFIRM_Y_<s:message code="MSG.CONFIRM.000003" arguments="수정된 내용"></s:message>" value="Confirm Layer!" class="btn_common btn_default" />
					</td>
				</tr>
				<tr>
					<td>MSG.CONFIRM.000003 / {0}을 저장하시겠습니까?</td>
					<td>M</td>
					<td>
						<input type="button" id="CONFIRM_N_<%=MessageUtil.getMsg("MSG.CONFIRM.000003", new String[]{"수정된 내용"})%>" value="Confirm!" class="btn_common btn_default" />
						<input type="button" id="CONFIRM_Y_<%=MessageUtil.getMsg("MSG.CONFIRM.000003", new String[]{"수정된 내용"})%>" value="Confirm Layer!" class="btn_common btn_default" />
					</td>
				</tr>
				<tr>
					<th colspan="3">√. ERROR</th>
				</tr>
				<tr>
					<td>MSG.ERROR.000001 / 실행 중 오류가 발생했습니다. 관리자에게 문의해주세요.</td>
					<td>S</td>
					<td>
						<input type="button" id="ERROR_N_<s:message code="MSG.ERROR.000001"></s:message>" value="Error!" class="btn_common btn_default" />
						<input type="button" id="ERROR_Y_<s:message code="MSG.ERROR.000001"></s:message>" value="Error Layer!" class="btn_common btn_default" />
					</td>
				</tr>
				<tr>
					<td>MSG.ERROR.000001 / 실행 중 오류가 발생했습니다. 관리자에게 문의해주세요.</td>
					<td>M</td>
					<td>
						<input type="button" id="ERROR_N_<%=MessageUtil.getMsg("MSG.ERROR.000001")%>" value="Error!" class="btn_common btn_default" />
						<input type="button" id="ERROR_Y_<%=MessageUtil.getMsg("MSG.ERROR.000001")%>" value="Error Layer!" class="btn_common btn_default" />
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>