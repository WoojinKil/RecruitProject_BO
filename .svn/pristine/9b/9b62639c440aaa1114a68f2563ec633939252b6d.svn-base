<%-- 
   1. 파일명 : header
   2. 파일설명: (공통) BUSINESS IT ACADEMY 헤더 영역
   3. 작성일 : 2019-03-25
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
$(document).ready(function() {
	// 메인인 경우 "main" Class 추가
	if(isEmpty(location.search)) $("#header").addClass("main"); 
	else $("#header").removeClass("main");
	var bmain = true;
	
	// 프론트 메뉴 목록 조회(2뎁스 구조)
    $.ajax({
        url     : _context + '/display/selectFrntMnuList',
        type    : 'POST',
        data    : {sys_cd : '0'},
        async   : true,
        success : function(data) {
            data = JSON.parse(data);
            var mapList = data.mapList;
            
            var dsply_no = 0;
            var mnu_ative_flag = true;
            for(var i = 0; i < mapList.length; i++) {
            	dsply_no = mapList[i].dsply_no;
            	// 1뎁스
            	if("1" == mapList[i].mnu_dpth) {
            		$('.menuInner').append('<li class="menuList" id="list_' + dsply_no + '"><a href="' + _context + chgEmptyUrl(mapList[i].url) + '">' + mapList[i].mnu_nm + '</a></li>');
            		$('#list_' + dsply_no).append('<ul class="subMenu" id="subMenu_' + mapList[i].tmpl_seq + '"></ul>');
            	}
            	// 2뎁스
            	else if("2" == mapList[i].mnu_dpth) {
            		if(isNotEmpty(mapList[i].url)) {
            			// 서브 메뉴 활성화
            			if(_curr_tmpl_seq == mapList[i].tmpl_seq) {
            				$('#subMenu_' + mapList[i].up_tmpl_seq).append('<li id="subMenu_' + mapList[i].up_tmpl_seq + "_" + mapList[i].tmpl_seq + '"><a href="' + _context + chgEmptyUrl(mapList[i].url) + '" class="active">' + mapList[i].mnu_nm + '</a></li>');
            			}
            			// 서브 메뉴 비활성화
            			else {
            				$('#subMenu_' + mapList[i].up_tmpl_seq).append('<li id="subMenu_' + mapList[i].up_tmpl_seq + "_" + mapList[i].tmpl_seq + '"><a href="' + _context + chgEmptyUrl(mapList[i].url) + '">' + mapList[i].mnu_nm + '</a></li>');
            			}
            		}else {
            			// 서브 메뉴 비활성화
            			$('#subMenu_' + mapList[i].up_tmpl_seq).append('<li id="subMenu_' + mapList[i].up_tmpl_seq + "_" + mapList[i].tmpl_seq + '"><a href="#" onclick="javascript:alert(\'준비중입니다.\');return false;">' + mapList[i].mnu_nm + '</a></li>');
            		}
            	}
            }
            $('#header').css("visibility", "visible");
            <%if(request.getServletPath().indexOf("/main.jsp")>=0){ %>
            	doInit();
           <% } %>
           		 
        }
    });
});
</script>
        <!-- Header -->
        <div id="header">
            <div class="headerInner">
            	<div class="headerContent">
	                <h1 class="logo"><a href="/">BUSINESS IT ACADEMY</a></h1>
	                <div class="gnb">
	                    <div class="menuWrap">
	                        <ul class="menuInner">
	                        </ul>
	                    </div>
	                </div>
            	</div>
            	<div class='headerBg'></div>
            </div>
        </div>
        <!-- //Header -->