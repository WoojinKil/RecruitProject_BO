<%--
   1. 파일명 : bpcm4001DTL
   2. 파일설명: 공지사항
   3. 작성일 : 2020-02-25
   4. 작성자 :
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/pandora3/js/common/bpcmFileControl.js"></script>
<script type="text/javascript">
var menu_id = _menu_id;
var bpcm4001_grid;
var doc_seq = '<%= parameterMap.getValue("doc_seq") %>';
var modl_seq = '<%= parameterMap.getValue("modl_seq") %>';
var ctegry_dtl_cd = '<%= parameterMap.getValue("ctegry_dtl_cd") %>';
var page = '<%= parameterMap.getValue("page") %>';
parent.bdp_doc_seq = "";
$(document).ready(function() {
	fn_Search();


    // 목록버튼
    $("#btn_goList").click(function() {
    	var sch_type_txt = JSON.parse(_param3).sch_type_txt;

    	var url = "/pbbs/forward.pbbs4001.adm?modl_seq="+modl_seq+"&ctegry_dtl_cd="+ctegry_dtl_cd+"&page="+page;
		var param3 = {
				modl_seq : modl_seq,
				ctegry_dtl_cd : ctegry_dtl_cd,
				sch_type_txt : sch_type_txt
		}

		parent.addTab(menu_id, "공지사항", url, '' , '' , encodeURIComponent(JSON.stringify(param3)));

	});
});

//파일 다운로드
function fn_fileDown(fl_seq) {
	if(isEmpty(fl_seq)) return false;
	window.open(_context + "/content/filedownloads3?fl_seq="+fl_seq,"_blank");
}

//조회 : 내부 로직 사용자 정의
function fn_Search() {
	var html_1 = "";     /*제목*/
	var html_2 = "";     /*내용*/

	ajax({
		url 	: "/bpcm/getBpcm4001Dtl",
		data    : { doc_seq : doc_seq,
                    modl_seq : modl_seq },
		success : function (data) {
			if (data.RESULT == "S") {

				    var list = data.rows;

					var notcYn = list.notc_yn;
					var titl = list.titl2;
					var crtDttm = list.f_crt_dttm;
					var newflag = list.newflag;
					var cts = list.cts;

					if(notcYn == 'Y'){
						html_1 += "<span class='import'>중요</span>" //공지여부
					}
					if(newflag*1 <= 7) {
						html_2 +=" <span class='new'> N </span> ";
                	}

					html_1 += "<h2 class='title'><span>"+titl+"</span>"; //제목
					html_1 += html_2;
					html_1 += "</h2>";
					html_1 += "<span class='date'>"+crtDttm+"</span>"; //작성일

					$(".notice_title").append(html_1);
					$(".notice_title").closest('div').show();

					$(".notice_content").html("<p>"+list.cts+"</p>");
					$(".notice_content").closest('div').show();

				// 파일리스트(원문)
				var flList = data.tbbsFlInfMapList;
				if(flList.length > 0) {
					var flTotSize = 0;
					for(var i = 0; i < flList.length; i++) {
						var flSeq = flList[i].FL_SEQ;
						var srcFlNm = flList[i].ORI_FL_NM;
						var flSize = parseInt(flList[i].FL_SIZE, 10);
						var uplFlNm = flList[i].UPL_FL_NM;
						var flExt = flList[i].FL_EXT;
						var thumbYn = flList[i].THUMB_YN;

		                if(cts.indexOf(uplFlNm)>=0){
							str = "<li id='fileBox" + flSeq + "' class='fileBox' style='display:none;'>"
						}else{
							str = "<li id='fileBox" + flSeq + "' class='fileBox'>"
						}

		                var seq = '\"' + flSeq + '\"';

						str += "<div class='file_name'><a href='#' onclick='javascript:fn_fileDown(" + flSeq + ");return false;' title='클릭하면 파일이 다운로드됩니다.' >" + srcFlNm + "<span class='volumn'> (" + formatBytes(flSize, 2) + ") </span></a>";
						str += "<span class='file_down'>"
						str += "<img src='${pageContext.request.contextPath}/resources/pandora3/images/img_file_download.png' alt='파일 다운로드'>"
						str += "</span>"
		                str += "<input type='hidden' id='fileNm" + flSeq + "' value='" + srcFlNm + "' />"
		                str += "<input type='hidden' id='filePath" + flSeq + "' value='" + uplFlNm + "' />"
		                str += "<input type='hidden' id='fileExt" + flSeq + "' value='" + flExt + "' />"
		                str += "<input type='hidden' id='fileSize" + flSeq + "' value='" + flSize + "' />"
		                str += "</div>";
		                str += "</li>";

						if(flSeq == 1) $("#fileList").show();
						$("#fileList").append(str);

						flSeq++;
					}
				}
			}
		}
	});
}

//공지사항 제목,내용 조회
// fn_getDocInfo();


//공지사항 제목,내용 조회
function fn_getDocInfo(){
	var html = "";

	ajax({
		url 	: "/bpcm/getDocInfo",
		data    : { doc_seq : <%= parameterMap.getValue("doc_seq") %> },
		success : function (data) {
			if (data.RESULT == "S") {
				html += "<textarea readonly='readonly' style='width:100% ; height:260px; overflow:auto;'>제목:  "+data.rows[0].TITL+"\n내용:  "+data.rows[0].CTS+"</textarea>"
				$(".subConScroll").append(html);
			}
		}
	});
}

</script>
</head>
<body class="">
    <div class="frameWrap">
    	<div class="subCon typeSearch">
	   		<div class="subConIn alignCenter">
				<div class="board_search">
					<div class="board_title">
						<h3 class="title type_notice detail">공지사항 </h3>
					</div>
				</div>
				<div class="notice_detail">
					<div class="notice_in">
						<div class="notice_title">
						</div>
						<div class="notice_content" id="notice_content">
						</div>
						<div class="notile_file_list">
							<ul class="file_list" id="fileList">
                            </ul>
						</div>
					</div>
				</div>
				<div class="notice_btn">
			   		<div class="m_btn_wrap">
						<button class="m_btn_default full" id="btn_goList" >목록</button>
					</div>
		   		</div>
    		</div>
    	</div>
    </div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>