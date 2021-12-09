<%-- 
   1. 파일명 : breadCrumb
   2. 파일설명: (공통) BUSINESS IT ACADEMY 네비게이션 영역
   3. 작성일 : 2019-03-26
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
$(document).ready(function() {
	// 1뎁스 메뉴 정보 조회
    $.ajax({
        url     : _context + '/display/select1DepthMnuInf',
        type    : 'POST',
        data    : {sys_cd : '0', tmpl_seq : _curr_tmpl_seq},
        async   : true,
        success : function(data) {
            data = JSON.parse(data);
            var mapInf = data.mapInf;
            if(isNotEmpty(mapInf)) {
            	var up_tmpl_seq = mapInf.up_tmpl_seq;
                up_mnu_nm = mapInf.up_mnu_nm;
                $('.lnb').append('<li class="list hide"><span class="currentNav">' + up_mnu_nm + '</span></li>');
                // 학원소개
                if("AINTR" == _bbs_tp_cd || "AFCL" == _bbs_tp_cd || "ALNDG" == _bbs_tp_cd) $("#topBanner").addClass("typeIntroduction");        
                // 커뮤니티
                else if("NOTI" == _bbs_tp_cd || "FAQ" == _bbs_tp_cd) $("#topBanner").addClass("typeCommunity");
                // 수강안내
                else if("CNS" == _bbs_tp_cd || "INTRO" == _bbs_tp_cd) $("#topBanner").addClass("typeCourse");
                // 오시는길
                else if("ACOA" == _bbs_tp_cd) $("#topBanner").addClass("typeContact");
                $('.subTitle').append(up_mnu_nm);
                // 2뎁스 메뉴 목록 조회
                get2DepthMenuList(up_tmpl_seq);
            }
        }
    });
});

// 2뎁스 메뉴 목록 조회
function get2DepthMenuList(up_tmpl_seq) {
	// 2뎁스 메뉴 목록 조회
	$.ajax({
        url     : _context + '/display/select2DepthMnuList',
        type    : 'POST',
        data    : {sys_cd : '0', up_tmpl_seq : up_tmpl_seq},
        async   : true,
        success : function(data) {
        	data = JSON.parse(data);
            var mapList = data.mapList;
            var mapListLen = mapList.length;
            if(mapListLen > 0) {
            	if(mapListLen == 1) $('.lnb').append('<li class="list hide" id="2dph_list">');
            	else $('.lnb').append('<li class="list" id="2dph_list">');
            	for(var i = 0; i < mapListLen; i++) {
            		if(_curr_tmpl_seq == mapList[i].tmpl_seq) {
            			curr_mnu_nm = mapList[i].mnu_nm;
            			$('#2dph_list').append('<span class="currentNav">' + curr_mnu_nm + '</span>');
            			$(".title.typeBoard").append(curr_mnu_nm);
            			break;
            		}
            	}
            	if(mapListLen > 1) {
            		$('#2dph_list').append('<ul class="lnbMore">');
                	for(var i = 0; i < mapListLen; i++) {
                		if(isNotEmpty(mapList[i].url)) {
                			$('.lnbMore').append('<li><a href="' + _context + chgEmptyUrl(mapList[i].url) + '">' + mapList[i].mnu_nm + '</a></li>');
                		}else {
                			$('.lnbMore').append('<li><a href="#" onclick="javascript:alert(\'준비중입니다.\');return false;">' + mapList[i].mnu_nm + '</a></li>');
                		}
                	}
                	$('#2dph_list').append('</ul>');
            	}
            	$('.lnb').append('</li>');
            	$('#breadCrumbs').css("visibility", "visible");
            	$('#content').css("visibility", "visible");
            }
        }
    });
}
</script>
			<!-- TopBanner -->
			<div id="topBanner">
				<h2 class="subTitle"></h2>
			</div>
			<!-- //TopBanner -->
        	<!-- BreadCrumbs -->
			<div id="breadCrumbs" style="visibility:hidden;">
				<div class="breadInner">
					<a href="/" class="homeWrap">HOME</a>
					<ul class="lnb">
					</ul>
				</div>
			</div>
			<!-- //BreadCrumbs -->
			<!-- Content -->
			<div id="content" style="visibility:hidden;">
				<div class="subContent">
					<h3 class="title typeBoard"></h3>