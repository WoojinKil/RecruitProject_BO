<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- jsp에서 사용할 변수들 선언 -->
<script type="text/javascript">
var _context = "${pageContext.request.contextPath}";
var _package_img = _context + "/resources/pandora3";
var _menu_id = '<%=request.getParameter("_mnu_seq")%>'
var _boolean_fail = '<%=kr.co.ta9.pandora3.common.conf.Const.BOOLEAN_FAIL%>';
var _boolean_success = '<%=kr.co.ta9.pandora3.common.conf.Const.BOOLEAN_SUCCESS%>';
var _boolean_true = '<%=kr.co.ta9.pandora3.common.conf.Const.BOOLEAN_TRUE%>';
var _boolean_false = '<%=kr.co.ta9.pandora3.common.conf.Const.BOOLEAN_FALSE%>';
var _boolean_duplicated = '<%=kr.co.ta9.pandora3.common.conf.Const.BOOLEAN_DUPLICATED%>';
var _action_login = '<%=kr.co.ta9.pandora3.app.conf.AppConst.ACTION_LOGIN%>';
var _action_none = '<%=kr.co.ta9.pandora3.app.conf.AppConst.ACTION_NONE%>';
var _grid_rows = <%=kr.co.ta9.pandora3.common.conf.Config.getArray("grid.rows.list")[0]%>;
var _grid_rows_list = [<%=kr.co.ta9.pandora3.common.conf.Config.get("grid.rows.list")%>];
var _grid_size = '<%=kr.co.ta9.pandora3.app.conf.AppConst.GRID_SIZE%>';
var _grid_data = '<%=kr.co.ta9.pandora3.app.conf.AppConst.GRID_DATA%>';
var _grid_crud = '<%=kr.co.ta9.pandora3.app.conf.AppConst.GRID_CRUD%>';
var _pageX = 0;
var _pageY = 0;
var _filePreFix = "/vip/resources";
var _type = '<%=request.getParameter("type")!=null && request.getParameter("type").toString()!="" ?request.getParameter("type"): ""%>'
var _currUrl ="<%=request.getServletPath()%>";
var _sys_cd = 11;
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jquery-1.11.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jquery-latest.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jquery.browser.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jquery-ui-1.11.3/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jqGrid-4.8.1/i18n/grid.locale-en.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jqGrid-4.8.1/jquery.jqGrid.src.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/zTree_v3/jquery.ztree.core.js?js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/zTree_v3/jquery.ztree.all.js"></script>
<!--[if lt IE 9]><script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jquery.jqplot.1.0/excanvas.js"></script><![endif]-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jquery.jqplot.1.0/jquery.jqplot.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/jquery/jquery.MultiFile.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/jquery.bpopup.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/date.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/grid.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/MonthPicker.js"></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/resources/pandora3/fullcalendar/js/moment.min.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/resources/pandora3/fullcalendar/js/daterangepicker.js'></script>
<script>
function sendOK(){
	var url = $("#gbn").val()
	var apiType = $("#api").val()
	var usrID =$("#lgn_id").val();
	 $("#usr_id").val(usrID);

	jQuery.ajax({
		url: url + apiType,
		type: "POST",
		data: $("form[name=form1]").serializeObject(),
		dataType:'json',
		async:false,
		beforeSend: function() {
		},
		success: function(data){
			console.log(data);
			//result

			var result = JSON.stringify(data);
			$("#result").empty();
			$("#result").val(result);



		},
		complete : function() {
		},
		error : function(error) {
		}
	});
}

</script>
</head>
<body>
<form name="form1" method="post" id="form1">
<input type="hidden" id="v" name="v" />
<input type="hidden" id="sys_cd" name="sys_cd"  value="11"/>
<input type="hidden" id="usr_id" name="usr_id"  />
<input type="hidden" id="page" name="page"  value="1" />
<input type="hidden" id="rows" name="rows"  value="50"/>
<input type="hidden" id="modl_seq" name="modl_seq"  value="15073"/>
<input type="hidden" id="doc_seq" name="doc_seq"  value="21321"/>
<input type="hidden" id="sch_dt" name="sch_dt"  value="20200206"/>
	<table width="1024" border="1">
		<tr>
			<td height="30" width="30%"> 구분</td>
			<td>
				<select id="gbn" name="gbn">
					<option value="http://localhost:8080/pandora3/">로컬</option>
					<option value="http://10.7.23.58:8080/">개발</option>
					<option value="https://bigdataportal.dpt.co.kr/">운영</option>
				</select>
			</td>
		</tr>
		<tr>
			<td height="30"> API 종류</td>
			<td>
				<select id="api" name="api">
					<option value="api/mobileLogin">일반로그인</option>
					<option value="api/mobileLogin">SLO로그인</option>
					<option value="api/getMobileTsysAdmMnuList">메뉴조회</option>
					<option value="api/noticeList">공지사항목록</option>
					<option value="api/noticeView">공지사항상세</option>
					<option value="api/schduleInfo">일정관리</option>
				</select>
			</td>
		</tr>
		<tr>
			<td height="30">아이디</td>
			<td><input type="text" id="lgn_id"  name="lgn_id" style="width:100px;"></td>
		</tr>
		<tr>
			<td height="30">비밀번호</td>
			<td><input type="password" id="lgn_pwd"  name="lgn_pwd" style="width:100px;"></td>
		</tr>
		<tr>
			<td colspan="2" height="30">><input type="button" value="확인"  onclick="javascript: sendOK();"></td>

		</tr>
	</table>
  <p></p>
  <p></p>
  <p></p>
  <p></p>
  <p></p>
  <table>
		<tr>
			<td> 결과</td>
			<td><textarea id="result"   rows="10" cols="70"></textarea></td>
		</tr>
	</table>
</form>
</body>
</html>
