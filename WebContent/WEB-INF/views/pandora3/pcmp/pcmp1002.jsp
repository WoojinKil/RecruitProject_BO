<%--
   1. 파일명 : pcmp1002
   2. 파일설명 : 회사상세
   3. 작성일 : 2020-05-29
   4. 작성자 : TANINE
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_header.jsp" %>
<script type="text/javascript">
var use_sys_grid;
var chg_flag = "update"; 
var sys_cd = '<%= parameterMap.getValue("sys_cd") %>';
var cmpny_cd = '<%= parameterMap.getValue("cmpny_cd") %>';
var dblchkflag = false;


//formData datepicker
var obj1 = {
		autoUpdateInput	: false,
		showDropdowns: true,
        singleDatePicker: false,
	    locale: {
	        format: 'YYYY-MM-DD'
	    }
	};
	
//grid datepicker	
var obj2 = {
		autoUpdateInput	: false,
		showDropdowns: true,
        singleDatePicker: true,
	    locale: {
	        format: 'YYYY-MM-DD'
	    }
	};

//Grid내 datepicker
function fn_datePicker(e) { 
	$(e).daterangepicker(obj2, function(start, end , separator ) {
		$(e).val(start);
	});
}


//회사정보 불러오기
function getCmpnyInfo(){
	ajax({
        url:"/pcmp/getPcmpInfo",
        data:{cmpny_cd : cmpny_cd},
        success:function(data){
            if (data.RESULT == _boolean_success) {
            	if(isNotEmpty(data.cmpnyInfoMap)){
            		var map = data.cmpnyInfoMap;
            		$("#cmpny_cd").val(map.cmpny_cd);
            		$("#cmpny_nm").val(map.cmpny_nm);
            		$("#biz_reg_no_val").val(map.biz_reg_no_val);
            		$("#cmpny_no_val").val(map.cmpny_no_val);            		
            		$("#rprsnt_nm").val(map.rprsnt_nm);
            		$("#biztp_val").val(map.biztp_val);
            		$("#bizitm_val").val(map.bizitm_val);
            		$("#rep_telno").val(map.rep_telno);
            		$("#rep_fax_telno").val(map.rep_fax_telno);
            		$("#cmpny_stat_gbcd").val(map.cmpny_stat_gbcd);
/*             		$("#use_cntrt_dy").val(map.use_cntrt_dy);
            		$("#fee_typ_cd").val(map.fee_typ_cd);
            		$("#adrs_gbcd").val(map.adrs_gbcd); */
            		$("#zipcd").val(map.zipcd);
            		$("#bizplc_1_adrs").val(map.bizplc_1_adrs);
            		$("#bizplc_2_adrs").val(map.bizplc_2_adrs);
            		$("#tpic_nm").val(map.tpic_nm);
            		$("#tpic_email").val(map.tpic_email);
            		$("#opr_mngr_pswd").val(map.opr_mngr_pswd);  
           			$("#c_cntrt_sta_dy").val(map.cntrt_sta_dy);
           			$("#c_cntrt_end_dy").val(map.cntrt_end_dy);
            	} 
            }
        }
    });
	
	// formData내 datepicker 재설정
	$("#c_cntrt_sta_dy").daterangepicker(obj1, function(start, end, separator ) {
		$("#c_cntrt_sta_dy").val(start);
		$("#c_cntrt_end_dy").val(end);
	});
}

//회사별 사용시스템 저장
function fn_save(){  	
	if(fn_ValidtaionCheck()) {
		// 그리드 입력중인 경우 포커스 제거
		$("#use_sys_grid").editCell(0, 0, false);
		use_sys_grid.save();  // {success:function(){alert('save success');}}
	}	
}

//저장 전 form 유효성 체크
function validChk() {	
    var retVal = true;
    
	// 1. formData 빈칸 확인
	$('input[type="text"], input[type="hidden"], input[type="password"]').each(function() {
		var id = $(this).attr("id");
		var value = $(this).val();
		// 필수체크
		if(isEmpty(value)) {
			var div = id + "_chk";
			console.log(div);
			$("#"+div).css('color','red'); 
			$("#"+div).text('필수입력사항입니다.'); 
			retVal = false;
			$("#"+id).focus();
			return retVal;
		}
	});
    return retVal;    
}

//저장 전 Grid 유효성 체크
function fn_ValidaionCheck() {	
	var data = use_sys_grid.getRowData();
	var dNum = data.length;

	if(dNum == 0 ) return dNum;	
	else if(dNum >0){
		for(var i=0 ; i<dNum ; i++) {		
			if(data[i].JQGRIDCRUD == "") continue;
			
			if(data[i].CNTRT_STA_DY > data[i].CNTRT_END_DY) {
				alert("계약 종료일자는 계약 시작일자보다 크거나 같아야 합니다.");
				use_sys_grid.setCellFocus(i+1, 7);
				dNum = -1;
				return dNum;
			}
		}	
	}
	return dNum;
}

//쓰기 서브밋
function submitFormWrite() {
    if(!confirm("작성글을 저장하시겠습니까?")) return false;
    // 1. formData 유효성 확인   
 	if(!validChk()) return false;
    // 2. 사업자등록번호 중복검사여부 확인
    if(!dblchkflag) {
    	alert("사업자등록번호 중복확인을 해주세요."); 
    	return false;
    }
    // 3. Grid 유효성 확인
    var dNum = fn_ValidaionCheck();
 	if(0 == dNum) saveFormData();
 	else if(0 < dNum) {
 		saveFormData();
 		fn_save();
 	}else if(0 > dNum){
 		return false;
 	}	
}

//FormData 저장
function saveFormData(){
    var formData = new FormData($('#frm_write')[0]);

/*  formData.append("use_cntrt_dy", $("#use_cntrt_dy").val() );
    formData.append("fee_typ_cd", $("#fee_typ_cd").val() );
    formData.append("adrs_gbcd", $("#adrs_gbcd").val() ); */
    
    $.ajax({
        url:_context + "/pcmp/savePcmp1001",
        type:'POST',
        data:formData,
        mimeType:"multipart/form-data",
        contentType:false,
        cache:false,
        processData:false,
        success:function(data) {
            var json = eval('('+data+')');
            if(_boolean_success == json.RESULT) {
            	saveflag = true;
                alert("법인정보가 등록되었습니다.");
                // 통합게시글조회 화면 추가
            	parent.$('.layer_popup').bPopup().close();  
                parent.tabs.tabs("refresh");
            }
        },
        error:function(request,status,error){
            alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
        },
         complete : function(data) {
            console.log("완료");
        }
    });
}


$(document).ready(function(){	
	getCmpnyInfo();

    var use_sys_config = {
    		
            gridid  : 'use_sys_grid',			// 그리드 id
            pagerid : 'use_sys_grid_pager',	    // 그리드 페이지 id
            // column info
            columns:[
       	             {name : 'CMPNY_CD', label : '회사코드', align:'center', editable:false, width:60 , hidden:true },
            	     {name : 'STATUS', label : '상태', align:'center', editable:false, width:60},
			         {name : 'SYS_CD', label : '사용시스템', align : 'center', editable : true, edittype : 'select', formatter : 'select', editoptions : {value : '<c:out value="<%=CodeUtil.getWrkSysComboList()%>" />'}, width : 100, required : true},         	                    
            	     {name : 'TPIC_NM', label:'담당자명', align:'center', editable:true, width:100, required : true},	
			         {name : 'CNTRT_STA_DY', label : '계약시작일자', align : 'center', editable : true, width : 120, editoptions : {maxlength : 10, dataInit : fn_datePicker}, required : true}, 
			         {name : 'CNTRT_END_DY', label : '계약종료일자', align : 'center', editable : true, width : 120, editoptions : {maxlength : 10, dataInit : fn_datePicker}, required : true},
        	 	     {name : 'PRD_GBCD', label:'상품구분코드', editable:true, edittype : 'select', formatter : 'select', editoptions : {value:'<%=CodeUtil.getGridComboList("PRD_GBCD")%>'}, required : true}
                     ],
            initval     : {},		                 // 컬럼 add 시 초기값
            editmode    : true,						 // 그리드 editable 여부
            gridtitle   : '사용시스템',						// 그리드명
            multiselect : true,								// checkbox 여부
            height      : '200',							// 그리드 높이
            shrinkToFit : true,								// true인경우 column의 width 자동조정, false인경우 정해진 width데로 구현(가로스크롤바필요시 false)
	        selecturl   : '/pcmp/getPcmp1100List',	    // 그리드 조회 URL
            saveurl     : '/pcmp/savePcmp1001SysList'		// 그리드 입력/수정/삭제 URL
    };

    use_sys_grid = new UxGrid(use_sys_config);
    use_sys_grid.init();  
    use_sys_grid.retreive({data:{cmpny_cd:$("#cmpny_cd").val()}});
 	// grid resizing
 	$(window).resize(function() {
 	    use_sys_grid.setGridWidth($('.tblType1').width());
	});   

 	
    // 사용시스템 행추가 버튼 클릭 시
    $("#btn_use_sys_add").click(function() {
    	// default 값 세팅 및 Grid에 발번한 회사코드 추가
        var targetRowId = use_sys_grid.add();
    	var data = use_sys_grid.getSelectRowIDs();
        $("#use_sys_grid").jqGrid('setColProp', 'SYS_CD', { editable: true });
        $("#use_sys_grid").setCell(data,'CMPNY_CD', $("#cmpny_cd").val());  
    });
    
 	// 사용시스템 행삭제 버튼 클릭 시
    $("#btn_use_sys_del").click(function() {
    	var rowid = use_sys_grid.getSelectRowIDs();
    	var flag = false;
    	
    	if(rowid.length > 0) {    		
	    	$.each(rowid, function (index, item) {
	    		use_sys_grid.remove(); 
	    	});
    	}else {
    		alert("삭제할 행을 선택해주세요.");
    	}
    });
 	
 	// 전체 저장
 	$("#btn_save").click(function(){	    
 		submitFormWrite();
 	});
 	
});

</script>
<style type="text/css">
.pop_grid {margin-top:20px; border:1px solid #dddddd}
</style>
</head>
<body id="pop">
	<div class="frameWrap">
		<div class="subCon">
			<h1><%=_title %></h1>
			<div class="subConIn">
				<div class="subConScroll">	
					<!-- 회사정보 -->
					<form name="frm_write" id="frm_write" enctype="multipart/form-data" method="post" onsubmit="return false;">
					<table class="tblType1">   
		            	<colgroup>
		              		<col style="width: 15%;" />
		 					<col style="width: 30%;" />
							<col style="width: 15%;" />
							<col style="width: 30%;" />
							<col style="width: 10%;"/>
						</colgroup>
						<tbody>
					        <tr>
					          <th><label for="cmpny_nm" class="vv necessary">회사명</label></th> 
					          <td>
					            <span class="txt_pw">
					            	<input type="text" id="cmpny_nm" name="cmpny_nm" class="w60" maxlength="50"/>
					            	<input type="text" id="cmpny_cd" name="cmpny_cd" class="w30" style="border:none; background:transparent;" readonly="readonly"/>						            	
					            </span>
					            <div id="cmpny_nm_chk" class="regex_chk"></div>
					          </td>
					          <th><label for="biz_reg_no_val" class="vv necessary">사업자등록번호</label></th>
					          <td>
					            <span class="txt_pw">
					            	<input type="text" id="biz_reg_no_val" name="biz_reg_no_val" class="w80" maxlength="10" readonly="readonly"/> 
					            </span>
					            <div id="biz_reg_no_val_chk" class="regex_chk"></div>					            
					          </td>
					          <td>
					          	<button id="chk_dbl_biz_btn" class="btn_common btn_default" style="height:100%">중복확인</button>
					          </td>
					        </tr>
					        <tr>
					          <th><label for="biztp_val" class="vv necessary">업태</label></th>
					          <td>
					          	<span class="txt_pw">
					            	<input type="text" id="biztp_val" name="biztp_val" class="w60" maxlength="50"/>
					            </span>
					            <div id="biztp_val_chk" class="regex_chk"></div>							          
					          </td>
					          <th><label for="bizitm_val" class="vv necessary">종목</label></th>
					          <td colspan="2">
					          	<span class="txt_pw">
					            	<input type="text" id="bizitm_val" name="bizitm_val" class="w60" maxlength="50"/>
					            </span>
					            <div id="bizitm_val_chk" class="regex_chk"></div>						          
					          </td>
					        </tr>
					        <tr>
					          <th><label for="rprsnt_nm" class="vv necessary">대표자</label></th>
					          <td>
					            <span class="txt_pw">
					            	<input type="text" id="rprsnt_nm" name="rprsnt_nm" class="w60" maxlength="50" />
					            </span>
					            <div id="rprsnt_nm_chk" class="regex_chk"></div>						          
					          </td>
					          <th rowspan="2"><label for="bizplc_1_adrs" class="vv necessary">사업장주소</label></th>
					          <td rowspan="2">
					            <span class="txt_pw">
					            	<input type="text" id="bizplc_1_adrs" name="bizplc_1_adrs" class="w100" maxlength="100"/>
					            </span>
					            <span class="txt_pw">
					            	<input type="text" id="bizplc_2_adrs" name="bizplc_2_adrs" class="w70" maxlength="100"/>
					           		<input type="text" id="zipcd" name="zipcd" class="w25" maxlength="10" style="float: right;"/>
					            </span>
					            <div id="adrs_chk" class="regex_chk"></div>	
					            <div id="zipcd_chk" class="regex_chk"></div>						            
					          </td> 
					          <td rowspan="2">
					          	<button class="btn_common btn_default" style="height:100%">주소찾기</button>
					          </td>         
					        </tr>
					        <tr>
					        	<th><label for="cmpny_no_val" class="vv necessary">법인등록번호</label></th>
					        	<td>
						            <span class="txt_pw">
						            	<input type="text" id="cmpny_no_val" name="cmpny_no_val" class="w60" maxlength="13"/>
						            </span>					        	
					            <div id="cmpny_no_val_chk" class="regex_chk"></div>						        	
					        	</td>
					        </tr>
					        <tr>
					          <th><label for="rep_telno" class="vv necessary">전화번호</label></th>
					          <td>
					            <span class="txt_pw">
					            	<input type="text" id="rep_telno" name="rep_telno" class="w60" maxlength="11"/>
					            </span>           
					            <div id="rep_telno_chk" class="regex_chk"></div>					          
					          </td>
					          <th><label for="rep_fax_telno" class="vv necessary">FAX번호</label></th>
					          <td colspan="2">
					            <span class="txt_pw">
					            	<input type="text" id="rep_fax_telno" name="rep_fax_telno" class="w60" maxlength="11"/>
					            </span>           
					            <div id="rep_fax_telno_chk" class="regex_chk"></div>						          
					          </td>
					        </tr>
					        <tr>
					          <th><label for="tpic_nm" class="vv necessary">담당자</label></th>
					          <td>
					            <span class="txt_pw">
					            	<input type="text" id="tpic_nm" name="tpic_nm" class="w60" maxlength="10"/>
					            </span>
					            <div id="tpic_nm_chk" class="regex_chk"></div>								          
					          </td>
					          <th><label for="tpic_email" class="vv necessary">담당자 E-mail</label></th>
					          <td colspan="2">
					            <span class="txt_pw">
					            	<input type="text" id="tpic_email" name="tpic_email" class="w60" maxlength="50"/>
					            </span>
					            <div id="tpic_email_chk" class="regex_chk"></div>						          
					          </td>          
					        </tr>
					        <tr>
					          <th><label for="c_cntrt_sta_dy" class="vv necessary">계약기간</label></th>
								<td class="typeCal" colspan="2">
									<div class="cals_div">
										<span class="txt_pw"><input class="cals w100" type="text" value="" name="c_cntrt_sta_dy" id="c_cntrt_sta_dy" autocomplete="off" /></span>
										<span class="space w10">~</span>
										<span class="txt_pw"><input class="cals w100" type="text" value="" name="c_cntrt_end_dy" id="c_cntrt_end_dy" autocomplete="off" /></span>
									</div>
					            	<div id="calendar_chk" class="regex_chk"></div>										
								</td>
					          <td colspan="2"></td>
					        </tr>
					        <tr>
					          <th><label for="cmpny_stat_gbcd" class="vv necessary">회사상태</label></th>
					          <td>
					          	<span class="w60" ><%=CodeUtil.getSelectComboList("CMPNY_STAT", "cmpny_stat_gbcd", "선택") %></span>
					            <div id="cmpny_stat_gbcd_chk" class="regex_chk"></div>	
					          </td>
					          <td colspan="3"></td>
					        </tr>
					        <tr>
					          <th><label for="opr_mngr_pswd" class="vv necessary">운영관리자 비밀번호</label></th>
					          <td> 
					            <span class="txt_pw">
						            <input type="password" id="opr_mngr_pswd" name="opr_mngr_pswd" class="w60" maxlength="20"/>						            
					            </span>
					            <div id="opr_mngr_pswd_chk" class="regex_chk"></div>
					          </td> 
					          <td colspan="3"></td>    
					        </tr>
					        <tr>
					          <th colspan="5"><label class="vv necessary">비밀번호는 숫자, 영문자, 특수문자 포함하여 8~20자 이내로 설정바랍니다.</label></th>  
					        </tr>
						</tbody>
		            </table>
					</form>
					<!-- // 회사정보 -->
					
					<div class="bgBorder"></div>	
					
					<!-- Grid -->
					<div class="grid_right_btn">
						<div id="btn_menu_grid" class="grid_right_btn_in">
							<button class="btn_common btn_default" id="btn_use_sys_add">행추가</button>
							<button class="btn_common btn_default" id="btn_use_sys_del">행삭제</button>
						</div>
					</div>
					<table id="use_sys_grid"></table>
					<div id="use_sys_grid_pager"></div>
					<!-- Grid // -->
				</div>
				<div class="btnWrap">
					<button type="button" class="btn_common btn_gray" id="btn_save">수정</button>
				</div>				
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
//정규표현식
var pwPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,20}$/;
var emailPattern = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;
var nameEngPattern = /^[a-zA-Z]*$/;
var nameKoPattern = /^[가-힣]+$/;
/* var bizRegPattern = /^\d{10}$/; */
var cmpRegPattern = /^\d{13}$/;
var telPattern = /^\d{10,11}$/;

/* var biz_reg_no_val = document.getElementById("biz_reg_no_val"); */
var cmpny_no_val = document.getElementById("cmpny_no_val");
var rprsnt_nm = document.getElementById("rprsnt_nm");
var tpic_nm = document.getElementById("tpic_nm");
var rep_telno = document.getElementById("rep_telno");
var rep_fax_telno = document.getElementById("rep_fax_telno");
var tpic_email = document.getElementById("tpic_email");
var opr_mngr_pswd = document.getElementById("opr_mngr_pswd");

/* function biz_reg_no_val_chk(){
	if(!bizRegPattern.test(biz_reg_no_val.value)) {
		$("#biz_reg_no_val_chk").text("사업자등록번호는 숫자 10자리로 입력하세요."); 
		biz_reg_no_val.value = "";
		return false;
	}else{
		$("#biz_reg_no_val_chk").text(""); 
	}
}	 */

function cmpny_no_val_chk(){
	if(!cmpRegPattern.test(cmpny_no_val.value)) {
		$("#cmpny_no_val_chk").text("법인등록번호는 숫자 13자리로 입력하세요."); 
		cmpny_no_val.value = "";
		return false;
	}else{
		$("#cmpny_no_val_chk").text("");
	}
}	

function rprsnt_nm_chk(){
	if(!nameEngPattern.test(rprsnt_nm.value) && !nameKoPattern.test(rprsnt_nm.value)) {
		$("#rprsnt_nm_chk").text("이름은 한글 또는 영문으로만 작성가능합니다."); 
		rprsnt_nm.value = "";
		return false;
	}else{
		$("#rprsnt_nm_chk").text(""); 
	}
}
function tpic_nm_chk(){
	if(!nameEngPattern.test(tpic_nm.value) && !nameKoPattern.test(tpic_nm.value)) {
		$("#tpic_nm_chk").text("이름은 한글 또는 영문으로만 작성가능합니다."); 
		tpic_nm.value = "";
		return false;
	}else{
		$("#tpic_nm_chk").text(""); 
	}
}

function rep_telno_chk(){
	if(!telPattern.test(rep_telno.value)) {
		$("#rep_telno_chk").text("전화번호는 숫자 10-11자리로 작성가능합니다."); 
		rep_telno.value = "";
		return false;
	}else{
		$("#rep_telno_chk").text(""); 
	}
}
function rep_fax_telno_chk(){
	if(!telPattern.test(rep_fax_telno.value)) {
		$("#rep_fax_telno_chk").text("전화번호는 숫자 10-11자리로 작성가능합니다."); 
		rep_fax_telno.value = "";
		return false;
	}else{
		$("#rep_fax_telno_chk").text(""); 
	}
}

function tpic_email_chk(){
	if(!emailPattern.test(tpic_email.value)) {
		$("#tpic_email_chk").text("이메일 작성방식을 확인해주세요. 예) ta9@gmail.com "); 
		tpic_email.value = "";
		return false;
	}else{
		$("#tpic_email_chk").text(""); 
	}
}

function opr_mngr_pswd_chk(){
	if(!pwPattern.test(opr_mngr_pswd.value)) {
		$("#opr_mngr_pswd_chk").text("비밀번호 양식을 확인해주세요. "); 
		opr_mngr_pswd.value = "";
		return false;
	}else{
		$("#opr_mngr_pswd_chk").text(""); 
	}
}

/* biz_reg_no_val.addEventListener('blur', biz_reg_no_val_chk); */
cmpny_no_val.addEventListener('blur', cmpny_no_val_chk);
rprsnt_nm.addEventListener('blur', rprsnt_nm_chk);
tpic_nm.addEventListener('blur', tpic_nm_chk);
rep_telno.addEventListener('blur', rep_telno_chk);
rep_fax_telno.addEventListener('blur', rep_fax_telno_chk);
tpic_email.addEventListener('blur', tpic_email_chk);
opr_mngr_pswd.addEventListener('blur', opr_mngr_pswd_chk);


</script>
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_footer.jsp" %>



