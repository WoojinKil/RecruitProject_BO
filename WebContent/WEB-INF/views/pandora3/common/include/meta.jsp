<%--
    개요 : meta(공통)
    수정사항 :
        2017-11-01 최초작성
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- css, js 파일들 및 상수들 선언한 meta 파일 -->
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/pandora3/css/common.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/pandora3/css/contents.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/pandora3/css/zTreeStyle.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/pandora3/css/jquery.jqplot.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/pandora3/css/jquery-ui.red.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/pandora3/css/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/pandora3/css/ui.multiselect.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/pandora3/css/MonthPicker.css" />
<link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/pandora3/fullcalendar/css/daterangepicker.css' />
<link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/pandora3/css/common_new.css' />
<link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/pandora3/css/lotte_bdp.css' />
<link rel="stylesheet" type="text/css" media="screen" href='${pageContext.request.contextPath}/resources/pandora3/css/landing.css?time=20200413' />
<%

String _gridRowList = kr.co.ta9.pandora3.common.conf.Config.get("grid.rows.list");
String _gridRows = kr.co.ta9.pandora3.common.conf.Config.getArray("grid.rows.list")[0];
String _metaType =request.getParameter("type")!=null && request.getParameter("type").toString()!="" ?request.getParameter("type").toString(): "";
String _metaMnuSeq = request.getParameter("_mnu_seq")!=null && request.getParameter("_mnu_seq").toString()!="" ?request.getParameter("_mnu_seq").toString(): "";

%>
<!-- jsp에서 사용할 변수들 선언 -->
<script type="text/javascript">
var _context = '<c:out escapeXml="true" value="${pageContext.request.contextPath}" />';
var _package_img = _context + "/resources/pandora3";
var _menu_id ='<c:out escapeXml="true" value="<%=_metaMnuSeq%>" />';

var _boolean_fail ='<c:out escapeXml="true" value="<%=kr.co.ta9.pandora3.common.conf.Const.BOOLEAN_FAIL%>" />';
var _boolean_success = '<c:out escapeXml="true" value="<%=kr.co.ta9.pandora3.common.conf.Const.BOOLEAN_SUCCESS%>" />';
var _boolean_true = '<c:out escapeXml="true" value="<%=kr.co.ta9.pandora3.common.conf.Const.BOOLEAN_TRUE%>" />';
var _boolean_false = '<c:out escapeXml="true" value="<%=kr.co.ta9.pandora3.common.conf.Const.BOOLEAN_FALSE%>" />';
var _boolean_duplicated = '<c:out escapeXml="true" value="<%=kr.co.ta9.pandora3.common.conf.Const.BOOLEAN_DUPLICATED%>" />';
var _action_login = '<c:out escapeXml="true" value="<%=kr.co.ta9.pandora3.app.conf.AppConst.ACTION_LOGIN%>" />';
var _action_none = '<c:out escapeXml="true" value="<%=kr.co.ta9.pandora3.app.conf.AppConst.ACTION_NONE%>" />';
var _grid_rows = '<c:out escapeXml="true" value="<%=_gridRows%>" />';
var _grid_rows_list = [<c:out escapeXml="true" value="<%=_gridRowList%>" />] ;
var _grid_size = '<c:out escapeXml="true" value="<%=kr.co.ta9.pandora3.app.conf.AppConst.GRID_SIZE%>" />';
var _grid_data = '<c:out escapeXml="true" value="<%=kr.co.ta9.pandora3.app.conf.AppConst.GRID_DATA%>" />';
var _grid_crud = '<c:out escapeXml="true" value="<%=kr.co.ta9.pandora3.app.conf.AppConst.GRID_CRUD%>" />';
var _pageX = 0;
var _pageY = 0;
var _filePreFix = "/vip/resources";
var _type ='<c:out escapeXml="true" value="<%=_metaType%>" />';
var _currUrl ='<c:out escapeXml="true" value="<%=request.getServletPath()%>" />';
var _sys_cd = 0;    // 2020-05-18 사내프로젝트 sys_cd = 18


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
<title>PANDORA3</title>
<!-- favicon -->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/pandora3/images/favi.ico"/>