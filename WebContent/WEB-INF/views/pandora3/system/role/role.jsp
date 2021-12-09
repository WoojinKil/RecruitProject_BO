<%-- 
    작성자 : 조성대
    개요 : 권한관리
    수정사항 :
        2015-04-03 최초작성
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<script type="text/javascript">
var role_grid;
$(document).ready(function() {  
    var role_config = { 
        // grid id
        gridid: 'role_grid',
        pagerid: 'role_grid_pager',
        // column info
        columns:[{name:'ROLE_ID', label:'권한ID',editable:true, align:'center',  sorttype:'int', width:60,editoptions:{
        
        	dataInit:function(element){
                $(element).keyup(function() {
                    // 한글 입력 방지
                    element.value = element.value.replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' );
                });
            }
        }},
                 {name:'ROLE_NM', label:'권한명', editable:true, edittype:'text', width:200, required:true},
                 {name:'US_YN', label:'사용여부', align:'center', editable:true, edittype:'select', formatter:'select', editoptions:{value:'Y:사용;N:미사용'}, width:80, required:true},
                 {name:'APLY_START_DATE', label:'적용시작일자', align:'center', editable:true, width:120, required:true, formatter:'date', formatoptions: {srcformat: 'U',newformat:'Y-m-d H:i'}, editoptions:{dataInit:function(e){$(e).datepicker({dateFormat:'yy-mm-dd',changeYear:true,changeMonth:true});}}},
                 {name:'APLY_END_DATE', label:'적용종료일자', align:'center', editable:true, width:120, required:true, formatter:'date', formatoptions: {srcformat: 'U',newformat:'Y-m-d H:i'}, editoptions:{dataInit:function(e){$(e).datepicker({dateFormat:'yy-mm-dd',changeYear:true,changeMonth:true});}}},
                 {name:'MOD_DATE',label:'변경일자', align:'center', width:100, formatter:'date', formatoptions: {srcformat: 'U',newformat:'Y-m-d'}}
        ],
        initval: {US_YN:'Y', APLY_END_DATE:'9999-12-31 23:59'}, // 컬럼 add 시 초기값
        editmode: true,                   // 그리드 editable 여부
        gridtitle: '권한 목록',      // 그리드명
        multiselect: true,                // checkbox 여부
        formid: 'search',                 // 조회조건 form id
        height: 400,                      // 그리드 높이
        
        shrinkToFit: true,                               // true인경우 column의 width 자동조정, false인경우 정해진 width대로 구현(가로스크롤바필요시 false)
        selecturl: '/system/selectSysUserRoleList.do',   // 그리드 조회 URL
        saveurl: '/system/updateSysUserRoleList.do',     // 그리드 입력/수정/삭제 URL
        events: {}
    };    
    
    role_grid = new UxGrid(role_config);
    role_grid.init();
    role_grid.setGridWidth($('.tblType1').width());
    $("#btn_retreive").click(function() {
        role_grid.retreive(); //{success:function(){alert('retreive success');}}
    });
    
    $("#btn_role_save").click(function() {
        role_grid.save();  // {success:function(){alert('save success');}}
    });
    
    $("#btn_role_add").click(function() {
        role_grid.add({APLY_START_DATE:$.timestampToString(new Date())});
    });
    
    $("#btn_role_del").click(function() {
        role_grid.remove(); // {success:function(){alert('remove success');}}
    });
});// grid resizing
$(window).resize(function() {
	role_grid.setGridWidth($('.tblType1').width());
});
</script>
</head>
<body id="app">
    <div class="subCon">
        <h1><%=_title %></h1>     
       
     
            <form name="search" id="search" name="search" onsubmit="return false">
            <table class="tblType1" border="0">
            		<colgroup>
						<col width="10%" />
						<col width="27%" />
						<col width="15%" />
						<col width="28%" />
						<col width="20%" />
					</colgroup>   
            <tr>
                <th>권한명</th>
                <td>
                  <span class="txt_pw">  <input type="text" name="role_nm" id="role_nm" class="text" value="" />
                  </span>
                </td>                
                <th>사용여부</th>
                <td>
                   <select name="us_yn" id="us_yn" class="select">
                       <option value="">전체</options>
                       <option value="Y">사용</option>
                       <option value="N">미사용</option>
                   </select>
                </td>
                <td>
                <div class="grid_btn">
                <button class="btn_common btn_darkGray" id="btn_retreive">조회</button>
                </div>
                </td>
            </tr>
            </table>
            </form>
   
        <!-- search // -->
        <table class="tblType3">
				<tr>
					<td>
        <div class="grid_btn">
           <button class="btn_common btn_darkGray" id="btn_role_save">저장</button>
           <button class="btn_common btn_darkGray" id="btn_role_add">추가</button>
           <button class="btn_common btn_darkGray" id="btn_role_del">삭제</button>
        </div>
        	</td>
				</tr>
			</table>
        <!-- Grid -->
        <table id="role_grid"></table> 
        <div id="role_grid_pager"></div>
        <!-- Grid // -->    
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
