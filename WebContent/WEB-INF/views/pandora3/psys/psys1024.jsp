<%-- 
   1. 파일명 : psys1024
   2. 파일설명 : 도움말
   3. 작성일 : 2018-04-26
   4. 작성자 : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp" %>
<style>
.layer_popup {background-color:#fff;border-radius:0;border:1px solid #000;color:#000;display:none;padding:0px;min-width:400px;min-height: 180px}
.layer_popup .btn_close{cursor:pointer;position:absolute;right:10px;top:5px}
</style>
<script type="text/javascript">
var menu_id = _menu_id;
var help_grid;
var term_editor;
var insert_yn = "N";

$(document).ready(function(){
	// 공통코드 복수 설정
	$("#mst_cd_arr").val(new Array( 'MBR0002'))
	ajax({
		url: '/psys/getPsysCommon',
		data : $("form[name=frm_sysCdDtl]").serialize(),
		success: function(data) {
		},
	});	

	$("#btn_term_save").show();
    var help_config = { 
        // grid id
        gridid: 'help_grid',
        pagerid: 'help_grid_pager',
        gridBtnYn   : 'Y',						// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
        // column info
        columns:[{name:'HCO_CTS', label:'도움말내용', hidden:true},
                 {name:'SYS_CD', label:'시스템번호', hidden:true},
       			 {name:'STATUS', label:'상태', align:'center', editable:false, width:20},
                 {name:'SYS_NM', label:'시스템명', editable:false},
                 {name:'MNU_SEQ', label:'메뉴ID', width:50, align:'center', sortable:false},
                 {name:'MNU_NM', label:'메뉴명', width:100,
                  cellattr: function(rowId, tv, rowObject, cm, rdata){
	 				if(isNotEmpty(rowObject.MNU_NM)){
	 					return 'style="cursor: pointer; text-decoration: underline;"'
	 				}
      		 	 }},
                 {name:'FRNT_YN', label:'구분', width:50, align:'center', formatter: 'select', editoptions:{value:'Y:FO;N:BO'}},
                 {name:'LGN_ID', label:'등록자', width:50, sortable:false},
                 {name:'F_CRT_DTTM' , label:'등록일', width:80, align:'center', sortable:false},
                 {name:'PREVIEW' , label :'도움말보기', width:50, align : 'center'
 					, formatter : function(cellValue, options, rowObject){
 						return "<input type='button' value='보기' class='btn_common btn_gray' onclick=\"callPopupPreview(\'"+options.rowId+"\')\">";}
                 }
        ],
        editmode: true,                   // 그리드 editable 여부
        gridtitle: '도움말 목록',            // 그리드명
        multiselect: true,                // checkbox 여부
        formid: 'search',                 // 조회조건 form id
        shrinkToFit: true,                // 컬럼 width 자동조정
        autowidth: true,
        height: 100,                       // 그리드 높이
        cellEdit:false,
        selecturl: '/psys/getPsys1024List',   // 그리드 조회 URL
        saveurl: '/psys/deletePsys1024',     // 그리드 입력/수정/삭제 URL
        events: {
			onCellSelect: function(event, rowid, icol, conts) {
				var row = help_grid.getRowData(rowid);
				$("#mnu_seq").val(row.MNU_SEQ);
				
				if (help_grid.getColName(icol) == 'MNU_NM') {
					if(row.MNU_SEQ!=0){
						// 버튼 제어(등록, 수정)
						$("#btn_term_save").hide();
						$("#btn_term_mod").show();
						// 메뉴명 제어
						$("#mnu_nm").val(row.MNU_NM);
						//$("#mnu_nm").
						term_editor.instances['hco_cts'].setData(row.HCO_CTS);
					}else{
						// 도움말 상세 초기화
						hcoInfInit();
						$("#cd_nm").val(row.CD_NM);
					}
				}
			}
		}
	};
    
    help_grid = new UxGrid(help_config);
    help_grid.init();
    help_grid.setGridWidth($('.tblType1').width());
    
    
    $("#btn_term_add").click(function() {
		term_editor.instances['hco_cts'].setReadOnly(false);
    });
    
   	$("#frm_help").submit(function(e) {
		var submitOK = false;
   		if(validInputBtm()) {
   			submitOK = true; 
   		}
   		if(submitOK) {
			$("#editor_yn").val("Y");
			$("#insert_yn").val(insert_yn);
			$("#hco_cts").val(term_editor.instances['hco_cts'].getData());
			var formData = new FormData($(this)[0]);
			$.ajax({
				url: _context + '/psys/savePsys1024',
				type: 'POST',
				data: formData,
				mimeType:"multipart/form-data",
				contentType: false,
				cache: false,
				processData:false,
				success: function(data) {
					data = JSON.parse(data);
					if(data.RESULT == "S") {
						alert('저장되었습니다');	
						$("#btn_search").trigger('click');
					} else {
						if(data.MSG){
							alert(data.MSG);
						}else{
							alert('작업이 정상적으로 실행되지 않았습니다 잠시후 다시 시도하세요');
						}
					}
				},
			});
		}
		e.preventDefault(); //Prevent Default action. 
   	});
    
	// CKEDITOR 세팅
    term_editor = CKEDITOR;
    term_editor.replace('hco_cts', {//해당 이름으로 된 textarea에 에디터를 적용
        width:'100%',
        height:'200px',
//      enterMode : CKEDITOR.ENTER_BR,
        filebrowserImageUploadUrl: _context +'/board/updateImageUpload.adm' //여기 경로로 파일을 전달하여 업로드 시킨다.
    });
     
    term_editor.on('dialogDefinition', function( ev ){
        var dialogName = ev.data.name;
        var dialogDefinition = ev.data.definition;
      
        switch (dialogName) {
            case 'image': //Image Properties dialog
                dialogDefinition.removeContents('Link');
                dialogDefinition.removeContents('advanced');
                //console.log(dialogDefinition);
                var infoTab = dialogDefinition.getContents( 'info' )
                infoTab.remove('txtHSpace'); //info 탭 내에 불필요한 엘레멘트들 제거
                infoTab.remove('txtVSpace');
                infoTab.remove('txtBorder');
                infoTab.remove('txtWidth');
                infoTab.remove('txtHeight');
                infoTab.remove('ratioLock');
                //console.log(infoTab);	
                break;
        }
    });
		
	// 메뉴등록
	$("#btn_get_tmp_menu").click(function() {
		//var url = $("#mnu_seq option:selected").attr("url");;
		//$("#url").val(url);	
		
		bpopup({
			  url:"/psys/forward.psys1024p001.adm"
			, params	: {callback : "getMenuList", target_id : _menu_id}
			, title		: "메뉴검색팝업"                          
			, type		: "l"
			, height	: "600px"
			, id        : "psys1024p1"
		});
		
	});
	
	//사이트 정보 갖고 오기
	getSystemList();
});
//팝업 미리보기
 function callPopupPreview(rowid) {
	
	var popImgUrl;
	var popOption = {};
    var popSize = {};
    var pointX = 0;
    var pointY = 0;
	var popVer = 'helpPop'
	var row = help_grid.getRowData(rowid);
	var grid = $("#help_grid").jqGrid("getRowData", rowid);
	var text = grid.HCO_CTS;
	
    /* var $layer_popup1 = $('<div class="layer_popup" id="PreviewPop1"></div>'); */
   /*  var $layer_img = $('<div class="mainPopWrap '+popSize+' '+popVer+'">'
    				  +	  '<div class="helpPopCon">'
    				  +		'<div class="txt" id="txt">'+text+'</div>'
    				  +	  '</div>'
    				  +	  '<p class="btn_mainPopClose" ><img src="${pageContext.request.contextPath}/resources/pandora3/images/common/main_popup_btn.png" alt="닫기" /></p>'
    				  +'</div>'); */
    				  
    var $layer_popup1 = $('<div class="layer_popup typeIfr" id="PreviewPop1"></div>');
    var $layer_img = $('<div class="frameWrap">'
      				  +	  '<button type="button" class="btn_layer_close2" ><img src="${pageContext.request.contextPath}/resources/pandora3/images/common_new/img_pop_close.png" alt="닫기" /></button>'
	  				  +	  '<div class="subCon">'
	  				  +		'<h1>'+text+'</h1>'
	  				  +	    '<div class="subConIn">'
	  				  +	      '<div class="subConScroll">'
	  				  
	  				  +	      '</div>'
	  				  +	    '</div>'
	  				  +	  '</div>'
	  				  +'</div>');
    $("body").append($layer_popup1);
    $layer_popup1.append($layer_img);
    $(".layer_popup").css(popOption);
    
    b_popup = $(".layer_popup").bPopup({
        opacity: 0.3,
        closeClass : "btn_layer_close2",
        position: ["50%", "50%"]
    });
    /* $(".layer_popup").draggable(); */
}


//선택된 프로그램 입력
function getMenuList(row){
	$("#mnu_nm").val(row.MNU_NM);
	$("#mnu_seq").val(row.MNU_SEQ);
}

// Submit form
function submitForm(action) {
	if ("SAVE" == action) {
		insert_yn= "Y";
	} else {
	    insert_yn= "N";
	}	
	$("#frm_help").submit();
}

// grid resizing
$(window).resize(function() {
	help_grid.setGridWidth($('.tblType1').width());
});

// Input Form 유효성
function validInputBtm() {
	var validFlag = true;
	$("#frm_help").find('input[type="text"]').each(function() {
		var id = $(this).attr("id");
		var value = $(this).val();
		// 필수체크
		if(isEmpty(value)) {
			var label = $('label');
			for(i=0; i<label.length; i++) {
				if($(label[i]).attr("for") == id) {
					validFlag = false;
					alert($(label[i]).text()+"를 입력해주세요");
					$("#"+id).focus();
					break;
				} 
			}
		}
	});
	if(validFlag) {
		var text = term_editor.instances['hco_cts'].getData();
		if(isEmpty(text)) {
			alert("상세내용을 입력해주세요.");
			term_editor.on('instanceReady', function(event) {
				term_editor.instances.text.focus();
			});
			term_editor.instances.text.focus();
			validFlag = false;
			return validFlag;
		}	
	}
	return validFlag;
}

//조회: 내부 로직 사용자 정의
function fn_Search() {
	 // 페이징이 1page를 초과할 시 초기화
    if($("#help_grid").jqGrid('getGridParam', 'page') > 1) $("#help_grid").jqGrid('setGridParam', {'page' : 1});
 	// 도움말 상세 초기화
	hcoInfInit();
    // 데이터 조회
    help_grid.retreive({data:{sys_cd:$("#sys_info").val()}}); //{success:function(){alert('retreive success');}}
}
// 추가: 내부 로직 사용자 정의
function fn_AddRow() {
	// 도움말 상세 초기화
	hcoInfInit();
}
// 삭제: 내부 로직 사용자 정의
function fn_DelRow() {
	help_grid.remove();
}

// 삭제: 내부 로직 사용자 정의
function fn_DelRow() {
	help_grid.remove();
}

//공통 - 저장 버튼 
function fn_Save() {
	help_grid.save();
}

//엑셀다운로드: 내부 로직 사용자 정의
function fn_ExcelDownload(){
	var grid_id = "help_grid";
	var rows = $('#help_grid').jqGrid('getGridParam', 'rowNum');
	var page = $('#help_grid').jqGrid('getGridParam', 'page');
	var total = $('#help_grid').jqGrid('getGridParam', 'total');
	var title = $('#help_grid').jqGrid('getGridParam', 'gridtitle');
	var url = "/psys/getPsys1024XlsxDwld";  //페이징 존재
	var param ={};
	param.page=page;
	param.rows=rows;
	param.filename ="도움말 목록";
	AdvencedExcelDownload(grid_id,url,param);
}

// 도움말 상세 초기화
function hcoInfInit() {
	// 버튼제어
	$("#btn_term_mod").hide();
    $("#btn_term_save").show();
	// 메뉴명 초기화
	$("#mnu_nm").val("");
	$("#mnu_seq").val("");
	// 상세내용 초기화
    term_editor.instances['hco_cts'].setData("");
}

//사이트 리스트 취득
function getSystemList() {
    var html = "";
    ajax({
        url     : "/pdsp/getPdsp1011ListSit",
//         data    : {sys_cd : _sys_cd} , 
        success : function (data) {
            if (data.RESULT == "S") {
                var sitListCnt = data.rows.length;
                $(data.rows).each(function (index) {
                    // 조회 건수가 하나일 경우 단일 하나의 시스템
                    if(sitListCnt == 1) {
                        html += "<option value="+ this.SYS_CD +" selected='selected' >"+ this.SYS_NM +"</option>"
                        return false;
                    } else {
                        html += "<option value="+ this.SYS_CD +">"+ this.SYS_NM +"</option>"
                        $("#sys_info").closest('div').show();
                    }
                });
                $("#sys_info").append(html);
            }
        }
    });
    
}
</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
		
		<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
		<div class="frameTopTable">
			<form name="search" id="search" onsubmit="return false">
				<table class="tblType1">
					<colgroup>
						<col style="width: 117px;" />
						<col style="" />
						<col style="width: 117px;" />
						<col style="" />
					</colgroup>
					<tr>
		                <th>시스템명</th>
		                <td>
                            <select id="sys_info" name="sys_info" class="select" >
                                <option value="">전체</option>
                            </select>
		                </td>
		                <th>메뉴명</th>
		                <td>
		                    <span class="txt_pw"><input type="text" name="sch_mnu_nm" id="sch_mnu_nm" class="text" value="" maxlength="12" maxlength="300"/></span>
		                </td>
					</tr>
				</table>
			</form>
		</div>
		
		<div class="bgBorder"></div>
		
		<table id="help_grid"></table> 
		<div id="help_grid_pager"></div>
		
		<div class="bgBorder"></div>
		<div class="table_bottom">
			<div class="grid_right_btn">
				<div class="grid_right_btn_in">
					<a href="javascript:hcoInfInit();"class="btn_common btn_default" id="btn_term_new">신규</a>
				</div>
			</div>
			<div class="tableTop">
				<h3 class="title">도움말 상세</h3>
			</div>
			<form name="frm_help" id="frm_help" onsubmit="return false">
				<input type="hidden" id="mnu_seq" name="mnu_seq" value=""/>
				<input type="hidden" id="editor_yn" name="editor_yn" value=""/>
				<input type="hidden" id="insert_yn" name="insert_yn" value=""/>
				<!-- <div class="tableBtnWrap">
					<p class="tableTitle">도움말 상세</p>
					<div class="tableBtn">
						<a href="javascript:submitForm('SAVE');"class="btn_common btn_default" id="btn_term_save" style="display:none;">등록</a>
						<a href="javascript:submitForm('MOD');"class="btn_common btn_default" id="btn_term_mod" style="display:none;">수정</a>
					</div>
				</div> -->
				<table class="tblType1">
					<!-- <colgroup>
						<col width="15%"/>
						<col width="*"/>
					</colgroup> -->
					<colgroup>
						<col style="width: 117px;">
						<col style="width: ">
					</colgroup>
					<tr>
						<!-- <th><label for="mnu_nm" class="vv">메뉴명</label></th>
						<td>
							<span class="txt_pw"><input type="text" id="mnu_nm" name="mnu_nm" class="w80"  readonly="readonly"/></span>
							<a href="#" id="btn_get_tmp_menu" class="btn_common btn_default btn_input_right">메뉴검색</a>
						</td> -->
						
						<th>
							<label for="mnu_nm" class="vv necessary">메뉴명</label>
						</th>
						<td>
							<span class="txt_pw typeRightBtn">
								<input type="text" name="mnu_nm" id="mnu_nm" value="" maxlength="15"/>
								<a href="#" id="btn_get_tmp_menu" class="btn_common btn_default btn_input_right">메뉴검색</a>
							</span>
							
						</td>
					</tr>
					<tr>
						<!-- <th><label for="hco_cts" class="vv">상세내용</label></th>
						<td><textarea name="hco_cts" id="hco_cts"></textarea></td> -->
						<th>
							<label for="hco_cts" class="vv necessary">상세내용ID</label>
						</th>
						<td>
							<span class="txt_pw"><textarea name="hco_cts" id="hco_cts"></textarea></span>
						</td>
					</tr>
				</table>
			</form>
		</div>
            <div class="bottomBtnWrap nonFloating">
                <a href="javascript:submitForm('SAVE');"class="btn_common btn_gray" id="btn_term_save" style="display:none;">저장</a>
                <a href="javascript:submitForm('MOD');"class="btn_common btn_gray" id="btn_term_mod" style="display:none;">수정</a>
            </div>
		</div>
	</div>
	<form name="frm_sysCdDtl" id="frm_sysCdDtl" onsubmit="return false;">
		<input type="hidden" name="mst_cd_arr" id="mst_cd_arr" />
	</form>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp" %>
