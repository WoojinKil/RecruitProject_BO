<%-- 
   1. 파일명 : psys1032
   2. 파일설명 : 메뉴권한관리
   3. 작성일 : 2018-05-31
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var log_seq = '<%= parameterMap.getValue("log_seq") %>';



$(document).ready(function () {
 	ajax({
		url : "/psys/getPsys1032p001.adm",
		type: 'POST',
		data: {log_seq : log_seq},
		success: function(data) {
			
			if(data.RESULT = "S") {
				setBatchDetail(data.batchMap);
				
			} else {
				alert("잠시후 다시 시도해주세요.")
			}
		}		
	});
 	
});

//배치 내용 
function setBatchDetail(batchMap) {
	
	//배치 시작 및 종료 일자
	var batch_st_ed_dt = batchMap.F_BATCH_ST_DT + " ~ " + batchMap.F_BATCH_ED_DT;
	
	//배치 작업 시작 및 종료 일자 *종료일자가 없으면 시작일자만 표출.
	var batch_wrk_st_ed_dt = (batchMap.F_BATCH_WRK_ED_DT) ? batchMap.F_BATCH_WRK_ST_DT + " ~ " + batchMap.F_BATCH_WRK_ED_DT : batchMap.F_BATCH_WRK_ST_DT
			
	//윈도우 및 리눅스 개행
	var batch_log_1 = (batchMap.BATCH_LOG_1_CTS) ? batchMap.BATCH_LOG_1_CTS.replace(/(\\n|\\r\\n)/gi, "<br />") : ""; 
	var batch_log_2 = (batchMap.BATCH_LOG_2_CTS) ? batchMap.BATCH_LOG_2_CTS.replace(/(\\n|\\r\\n)/gi, "<br />") : "";
		
	$("#batch_nm").text(batchMap.BATCH_SEQ);
	$("#batch_st_ed_dt").text(batch_st_ed_dt);
	$("#batch_wrk_st_ed_dt").text(batch_wrk_st_ed_dt);
	$("#batch_log_1").html(batch_log_1);
	$("#batch_log_2").html(batch_log_2);

}


</script>

</head>
<body id="pop">
	<div class="frameWrap">
		<div class="subCon">
		<h1><%=_title %></h1>	
			<div class="subConIn">
				<div class="subConScroll">
					<table class="tblType1">
						<colgroup>
							<col width="85px;" />
							<col width="" />
						</colgroup>
						<tr>
							<th>배치명</th>
							<td>
								<span class="txt_pw"  id="batch_nm">
								</span>
							</td>
						</tr>
						<tr>
							<th>배치 시작/종료일</th>
							<td>
								<span class="txt_pw" id="batch_st_ed_dt" >
								</span>
							</td>
						</tr>
						<tr>
							<th>작업 시작/종료일</th>
							<td>
								<span class="txt_pw" id="batch_wrk_st_ed_dt">
								</span>
							</td>
						</tr>
						<tr>
							<th>로그 1</th>
							<td height="200" valign="top"  >
								 <div style="overflow:auto;   height:100%; width:100%;" id="batch_log_1">
								 </div>
							</td>
						</tr>
						<tr>
							<th>로그 2</th>
							<td height="200" valign="top">
								 <div style="overflow:auto; height:100%; width:100%;" id="batch_log_2">
								 </div>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
