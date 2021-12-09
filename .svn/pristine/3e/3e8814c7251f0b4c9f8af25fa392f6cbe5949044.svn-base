<%--
   1. 파일명   : psys1000
   2. 파일설명 : 동적그리드샘플
   3. 작성일   : 2018-03-27
   4. 작성자   : TANINE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/header.jsp"%>
<script type="text/javascript">
var code_master_grid;
var adm_rol_info;
$(document).ready(function(){
	// 동적 컬럼 기본값 설정
	var defaultCol = new Array();
	/* 특정 컬럼 옵션값 설정
	tgt : 옵션 설정할 컬럼 (해당 컬럼의 NAME)
	opt : 설정할 옵션 값 (배열로 설정)
	*/
	var optionalCol = new Array();
    ajax({
	        url     : "/pdsp/getPdsp1011ListSit",
	        success : function (data) {
	            if (data.RESULT == "S") {
	                var sitListCnt = data.rows.length;
	                defaultCol.push( {name : 'GRP_ROL_ID', label : '그룹 권한ID', editable : false, hidden:true},
	                        {name : 'GRP_ROL_IDS', label : '그룹 매핑 권한들  ', editable : false, hidden:true},
	                        {name : 'GRP_ROL_NM', label : '통합 그룹명', editable : false, align : 'center'}
	                        );
	                $(data.rows).each(function (index) {
	                	defaultCol.push(  {name :this.SYS_PTH.replace("/",""), label : this.SYS_NM});
	                	//optionalCol.push({tgt: this.SYS_PTH.replace("/",""), opt:{editable:true, edittype:'select', formatter:'select',editoptions:{value:'Y:사용;N:미사용'}}});
	                	optionalCol.push({tgt: this.SYS_PTH.replace("/",""), opt:{editable:true, edittype:'select', formatter: fn_makeRolSelectbox, formatoptions:{sys_cd:this.SYS_CD,sys_abrv:this.SYS_PTH.replace("/","")} }});
	                });
	                console.log(optionalCol);
					makeGrid();
	            }
	        }
	    });

    ajax({
        url     : "/psys/selectRolList",
        data : {sys_cd :0},
        success : function (data) {
            if (data.RESULT == "S") {
            	adm_rol_info = data.rows;
            }
        }
    });
    console.log(adm_rol_info);


	//optionalCol.push({tgt: "US_YN", opt:{editable:true, edittype:'select', formatter:'select',editoptions:{value:'Y:사용;N:미사용'}}});


	function makeGrid(){
    	// 공통 그리드 옵션
    	var config = {
            gridid       : 'code_master_grid',	    	// 그리드 id
            pagerid      : 'code_master_grid_pager',	// 그리드 페이지 id
            gridBtnYn    : 'Y',							// 상단 그리드 버튼 여부 ( 그리드 1개 일때 필수 'Y', 상/하단 그리드 일 경우 상단 그리드만 필수'Y' )
    		editmode     : true,
    		gridtitle    : '코드마스터 목록',
    		multiselect  : true,
    		multiboxonly : true,
    		formid       : 'search',
    		height       : 'auto',
    		shrinkToFit  : true,
    		selecturl    : '/psys/selectTsysAdmGrpRolList',
    		setCol       : '',
    		events       : {
    		}
    	};

    	// 동적 그리드 생성
    	code_master_grid = fn_UxGrid(config, '', defaultCol);
    	code_master_grid.init();
    	code_master_grid.setcolprop(optionalCol);
    	code_master_grid.setGridWidth($('.tblType1').width());
	}

});

//grid resizing
$(window).resize(function() {
	code_master_grid.setGridWidth($('.tblType1').width());
});

//조회: 내부 로직 사용자 정의
function fn_Search(){
	code_master_grid.retreive();
}

function fn_makeRolSelectbox(cellValue, options, row) {

	//console.log(cellValue);
	//console.log( options.colModel.formatoptions);
	//console.log(row);
	//alert("Aaaa");
	var rol_id ="";
	$.each(row, function(key, value){
	    //alert('key:' + key + ' / ' + 'value:' + value);
	    if(key == options.colModel.formatoptions.sys_abrv){
	    	rol_id = value;
	    }
	});
	var selectHtml = "<select class='w100''>";
	selectHtml += "<option value='0'>선택안함</option>"
	for(var i=0; i < adm_rol_info.length; i++){
	   var selected ="";
		if(options.colModel.formatoptions.sys_cd == adm_rol_info[i].SYS_CD ){
			if(rol_id ==  adm_rol_info[i].ROL_ID){
				  selected ="selected";
			  }
			selectHtml += "<option value='" + adm_rol_info[i].ROL_ID +"'" + selected+ ">"+adm_rol_info[i].ROL_NM+"</option>"
		}

	}
	selectHtml +="</select>"
	return selectHtml;
}

</script>
</head>
<body>
	<div class="frameWrap">
		<div class="subCon">
			<%@ include file="/WEB-INF/views/pandora3/common/include/btnList.jsp" %>
			<!-- <form id="search" name="search" onsubmit="return false">
				<table class="tblType1 typeRow mB60">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><span class="necessary">검색유형</span></th>
						<td><select id="sch_type", name="sch_type" class="select"><option value="TYPE1">TYPE1</option><option value="TYPE2">TYPE2</option></select></td>
					</tr>
				</table>
			</form> -->
			<div class="frameTopTable">
				<form id="search" name="search" onsubmit="return false">
		            <table class="tblType1 typeShort">
		            	<colgroup>
							<col style="width: 117px;" />
							<col style="" />
							<col style="width: 117px;" />
							<col style="" />
						</colgroup>
						<tbody>
							<tr>
								<th><span class="necessary">검색유형</span></th>
								<td><select id="sch_type", name="sch_type" class="select"><option value="TYPE1">TYPE1</option><option value="TYPE2">TYPE2</option></select></td>
				                <th></th>
				                <td></td>
							</tr>
						</tbody>
		            </table>
		       </form>
			</div>
			<div class="bgBorder"></div>

			<table id="code_master_grid"></table>
			<div id="code_master_grid_pager"></div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/footer.jsp"%>
