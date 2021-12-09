<%-- 
   1. 파일명 : bpcm2008p002
   2. 파일설명 : 브랜드 팝업
   3. 작성일 : 2019-10-10
   4. 작성자 : 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일 include -->
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_header.jsp" %>
<script type="text/javascript">
var brnd_grid;

$(document).ready(function(){
	
    var menu_config = { 
        // grid id
        gridid: 'brnd_grid',
        pagerid: '',
        // column info
        columns:[
	        	{name:'BRND_CD', label:'브랜드', align:'center', width:30},
        		 {name:'BRND_NM', label:'브랜드명', align:'left', width:50},
        ],
        editmode: false,                   	// 그리드 editable 여부
        gridtitle: '',                      // 그리드명
        multiselect: true,                	// checkbox 여부
        formid: 'search',                 	// 조회조건 form id
        height: 290,                      	// 그리드 높이
        rownumWidth : 40,
        loadonce : true,                    // 상단정렬기능
        selecturl: '/bpcm/getBpcm2008Brnd', // 그리드 조회 URL
        search: true,
        events: {}
    };    
    
    var brnd_grid = new UxGrid(menu_config);
    brnd_grid.init();
    brnd_grid.setGridWidth($('.subConScroll').width());
    $("#brnd_grid").jqGrid("setLabel", "rn", "NO");
    
    $(".ui-jqgrid").addClass("pop_grid"); 
    
    $("#btn_retreive").click(function() {
    	if($("#brnd_cd").val().replace(/ /g,"").length < 1){
    		alert("브랜드명을입력해주세요");
    		return false;
    	}else{
    		brnd_grid.retreive(); 
    	}
    });  
	
    // 엔터입력시 자동조회
	$(document).on('keyup', '#brnd_cd', function(e){
		if(event.keyCode==13){
			if($("#brnd_cd").val().replace(/ /g,"").length < 1){
	            alert("브랜드명을입력해주세요");
	            return false;
			}else{
				brnd_grid.retreive();
			}
			
		} 
	});	
    
    $("#btn_select").click(function() {
        var rows = brnd_grid.getSelectRows();

        if (rows.length == 0) {
        	alert('<%=MessageUtil.getMsg("MSG.CMPGN.ALERT.000057")%>'); //브랜드를 선택해주세요.
            return;
        }    

        if (rows.length > 1) {
        	alert('<%=MessageUtil.getMsg("MSG.CMPGN.ALERT.000069")%>'); //한 개만 선택할 수 있습니다.
            return;
        }
        
        var cstrCd = "";
                
    	for(var i = 0; i < rows.length; i++) {
     		
    		cstrCd = rows[i].CSTR_CD;
    		
    	}        
        
    	
   		//호출된 iframe id 획득
		var iframeId = '#tab-' + '<%= parameterMap.getValue("target_id") %>';

		//ifram 객체 획득
		var $frame = parent.$(iframeId)[0];
		
		//ifram 접근
	 	var gocoderFrameGo = $frame.contentWindow || $frame.contentDocument ;
		
		//callback 함수 실행
	 	gocoderFrameGo.<%= parameterMap.getValue("callback") %>(rows);
		
		parent.$('.layer_popup').bPopup().close();
		
    });  
    
    $(".btn_layer_close").click(function() {
    	parent.$('.layer_popup').bPopup().close();
    });
    
//     $("#btn_retreive").click(function() {
//     	brnd_grid.retreive(); //{success:function(){alert('retreive success');}}
//     });  
    
});

$(window).resize(function() {
	brnd_grid.setGridWidth($('.subConScroll').width());
});


</script>
</head>
<style>
html,body{height:100%;}
</style>
</head>
<body id="pop">
	<div class="frameWrap">
		<div class="subCon">
			<h1><%=_title %></h1>
			<div class="subConIn">
			    <div class="subConScroll">
					<!-- 조회조건 -->
					<form name="search" id="search" onsubmit="return false"><!--  style="display:none;" style='visibility:hidden;' -->
						<div class="frameTopTable">
						    <table class="tblType1">
						    	<colgroup>
						    		<col width="25%" />
						    		<col width="25%" />
						    		<col width="25%" />
						    		<col width="25%" />
						    	</colgroup>
								
					    		<tr>
					    			<th>브랜드코드/명</th>
	                                <td>
	                                   <input type="hidden" name="cstr_cd" id="cstr_cd" value="<%= parameterMap.getValue("cstr_cd") %>"/>
	                                   <span class="txt_pw"> <input type="text" name="brnd_cd" id="brnd_cd" class="text" style="width:200px;" value="" /></span>
	                                </td> 
					    		</tr>
					    	</table>
	                    </div>
						<div class="btnWrap">
							<button type="button" class="btn_common btn_gray" id="btn_retreive">조회</button>
						</div>
						<br/> 
					</form>
					<!-- 조회조건  // -->
					<!-- Grid -->
					<table id="brnd_grid"></table>
				    <div id="test_paginate"></div>
					<!-- Grid // -->
				</div>
			</div>
			<div class="grid_btn">
				<button type="button" class="btn_common btn_black" id="btn_select" name="btn_select">선택</button>
				<button type="button" class="btn_layer_close btn_common btn_gray" name="btn_close">닫기</button>
			</div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/pandora3/common/include/pop_footer.jsp" %>

