//이전 페이저 정보
var preUrl = {

	preUrl : '',
	lgnId : '',
	usrNm : '',
	usrEmlAdr : '',
	usrSsCd : '',
	actvYn : '',

	setPreUrl : function (url) {
		this.preUrl = url
	},
	getPreUrl : function () {
		return this.preUrl;
	},

	setLgnId : function (lgnId) {
		this.lgnId = lgnId;
	},
	getLgnId : function () {
		return this.lgnId;
	},

	setUsrNm : function (usrNm) {
		this.usrNm = usrNm;
	},
	getUsrNm : function () {
		return this.usrNm;
	},

	setUsrEmlAdr : function (usrEmlAdr) {
		this.usrEmlAdr = usrEmlAdr;
	},
	getUsrEmlAdr : function () {
		return this.usrEmlAdr;
	},

	setUsrSsCd : function (usrSsCd) {
		this.usrSsCd = usrSsCd
	},
	getUsrSsCd : function () {
		return this.usrSsCd;
	},

	setActvYn : function (actvYn) {
		this.actvYn = actvYn
	},
	getActvYn : function () {
		return this.actvYn;
	}

}


//연속 문자 방지
//연속된 문자 카운트

function stck(str, limit) {

    var o, d, p, n = 0, l = limit == null ? 4 : limit;
    for (var i = 0; i < str.length; i++) {
        var c = str.charCodeAt(i);
        if (i > 0 && (p = o - c) > -2 && p < 2 && (n = p == d ? n + 1 : 0) > l - 3) return false;
        d = p, o = c;
    }
    return true;
}
//space 방지
function noSpaceForm(obj) { // 공백사용못하게
    var str_space = /\s/;  // 공백체크
    if(str_space.exec(obj.value)) { //공백 체크
        obj.value = obj.value.replace(' ',''); // 공백제거
        return false;
    }
 // onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);"
}
//비밀번호 복잡도
function chkPwd(str){

	 var pw = str;
	 var num = pw.search(/[0-9]/g);
	 var eng = pw.search(/[a-z]/ig);
	 var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

	 if(!stck(pw,3)){
		 alert("연속된 문자 사용 불가합니다.");
		 return false;
	 }

	 if(pw.length < 8 || pw.length > 20){
	  alert("비밀번호 8자리 ~ 20자리 이내로 입력해주세요.");
	  return false;
	 }
	 if(pw.search(/₩s/) != -1){
	  alert("비밀번호는 공백업이 입력해주세요.");
	  return false;
	 } if(num < 0 || eng < 0 || spe < 0 ){
	  alert("영문,숫자, 특수문자를 혼합하여 입력해주세요.");
	  return false;
	 }
	 return true;
	}
//--- 비밀번호 복잡도

function ajax(ops) {

	//String 일 경우 menu_seq 처리 방법을 다르게 해야함
	if(ops.data) {
		if(typeof(ops.data) == 'string') {
			//String
			if(ops.data.indexOf("=")>=0){ // stringfly 로 들어 올 경우
				ops.data += "&_mnu_seq="+_menu_id;
			} else {
				ops.data += "_mnu_seq="+_menu_id;
			}
		} else {
			//Object
			ops.data = $.extend(ops.data,{_mnu_seq : _menu_id });
		}
	}

	return jQuery.ajax({
		url: _context + ops.url,
		type: ops.method||"POST",
		data: ops.data||{_mnu_seq : _menu_id},
		dataType:ops.dataType||'json',
		async:ops.async||false,
		beforeSend: function() {
			if(ops.beforeSend) eval(ops.beforeSend)();
		},
		success: function(result){
			if (checkMenuBttnAccess(result) && checkResult(result)) {
				eval(ops.success)(result);
			}
		},
		complete : function() {
			if(ops.complete) eval(ops.complete)();
		},
		error : function(error) {
			if(ops.error) eval(ops.error)(error);
		}
	});
}

function checkResult(result) {
	var isPass = true;
	if (result.RESULT == _boolean_fail) {
		if(result.MSG){
			alert(result.MSG);
		}else{
			alert('작업이 정상적으로 실행되지 않았습니다 잠시후 다시 시도하세요');
		}
		isPass = false;
	}
	return isPass;
}

var errorFlag = false;
// 권한 체크
function checkMenuBttnAccess(result) {
	var isPass = true;
	// 권한 체크가 실패이고
	if (result.AUTH_CHECK_RESULT == _boolean_fail && errorFlag == false) {
		// 메시지 출력
		alert(result.AUTH_CHECK_MESSAGE);

		// 로그인 페이지로 가야 한다면
		if (result.AUTH_CHECK_ACTION == _action_login || result.AUTH_CHECK_ACTION == _action_none) {
			popup({url:"/login/forward.login.adm"
				, winname:"_top"
				, title:"로그인"
				, scrollbars:false
				, autoresize:false
				, params : {_pre_url : parent.preUrl.getPreUrl(), lgn_id : parent.preUrl.getLgnId() , usr_nm : parent.preUrl.getUsrNm(),
					usr_eml_addr : parent.preUrl.getUsrEmlAdr(), usr_stat_cd : parent.preUrl.getUsrSsCd(), actv_yn : parent.preUrl.getActvYn()}
			});
		}
		isPass = false;
		errorFlag = true;
		
	}
	
	return isPass;
}

function goMenu(url, title) {
	var val = Math.floor(Math.random() * 100000000) + 1;
	if (url.indexOf("?") > 0) {
		url = url + "&_val=" + val;
	}
	else {
		url = url + "?_val=" + val;
	}
	document.getElementById('iFrmCont').src = _context + url;
}

/**
 * 팝업공통
 * @param pin
 * @returns
 */
function popup(pin) {
		var defaultProps = {
			winname:"",
			title:"",
			_title:"",
			params:{},
			scrollbars:false,
			resizable:true,
			action:false
		};

		if (!pin.width) {
			switch (pin.type) {
				case "s":
					pin.width = "390px";
					break;
				case "sl":
					pin.width = "480px";
					pin.height = "340px";
					break;
				case "m":
					pin.width = "590px";
					break;
				case "l":
					pin.width = "730px";
					pin.height = "510px";
					break;
				case "xl":
					pin.width = "840px";
					break;
				case "xml":
					pin.width = "900px";
					pin.height = "720px";
					break;
				case "xxl":
					pin.width = "100%";
					break;
			}
		}
		if ( !pin.height ) {
			pin.height = "400";
		}

		pin = $.extend(defaultProps, pin||{});

		var form = $();
		var params = "";
		var openUrl = "";
		//post방식
		if( pin.action ){
			form = $('<form></form>').attr('id','popupAction').attr('method', 'post').css('display','none').attr('target', pin.winname).attr('action', _context + pin.url);
			$.each(pin.params, function(name, value){
				var element = $('<input></input>').attr('name', name).attr('value', value);
				form.append(element);
			});
			var element = $('<input></input>').attr('name', '_title').attr('value', pin.title);
			form.append(element);
			$('body').append(form);

			openUrl = 'about:blank';
		}
		//get방식
		else {
			$.each(pin.params, function(name, value){
				if ($.isArray(value)) {
					$.each(value, function(index, value){
						params += ("&" + name + "=" + encodeURI(value));
					});
				} else {
					params += ("&" + name + "=" + encodeURI(value));
				}
			});

			openUrl = _context + pin.url + "?_title=" + encodeURI(pin.title) + params;
		}

		var _left = (screen.width)/2 - (pin.width+"").replace(/px/, '')/2 ;
		var _top = (screen.height)/2 - (pin.height+"").replace(/px/, '')/2;
		var win = window.open(
			openUrl,
			pin.winname,
			"menubar=no, scrollbars=" + (pin.scrollbars ? "yes" : "no") + ", resizable=" + (pin.resizable ? "yes" : "no") + ", status=yes, width=" + pin.width + ", height=" + pin.height+ ",top=" + _top + ",left=" + _left + ""
		);

		//post일때 submit
		if (pin.action) {
			form.submit();
		}

		//포커스
		if (win != undefined && win != null) {
			win.focus();
		}

		return win;
}
function popupTab(pin) {
	var defaultProps = {
			winname:"",
			title:"",
			_title:"",
			params:{},
			scrollbars:false,
			resizable:true,
			action:false
	};

	if (!pin.width) {
		switch (pin.type) {
		case "s":
			pin.width = "390px";
			break;
		case "sl":
			pin.width = "480px";
			pin.height = "340px";
			break;
		case "m":
			pin.width = "590px";
			break;
		case "l":
			pin.width = "730px";
			pin.height = "510px";
			break;
		case "xl":
			pin.width = "840px";
			break;
		case "xml":
			pin.width = "900px";
			pin.height = "720px";
			break;
		case "xxl":
			pin.width = "100%";
			break;
		}
	}
	if ( !pin.height ) {
		pin.height = "400";
	}

	pin = $.extend(defaultProps, pin||{});

	var form = $();
	var params = "";
	var openUrl = "";
	//post방식
	if( pin.action ){
		form = $('<form></form>').attr('id','popupAction').attr('method', 'post').css('display','none').attr('target', pin.winname).attr('action', _context + pin.url);
		$.each(pin.params, function(name, value){
			var element = $('<input></input>').attr('name', name).attr('value', value);
			form.append(element);
		});
		var element = $('<input></input>').attr('name', '_title').attr('value', pin.title);
		form.append(element);
		$('body').append(form);

		openUrl = 'about:blank';
	}
	//get방식
	else {
		$.each(pin.params, function(name, value){
			if ($.isArray(value)) {
				$.each(value, function(index, value){
					params += ("&" + name + "=" + encodeURI(value));
				});
			} else {
				params += ("&" + name + "=" + encodeURI(value));
			}
		});

		openUrl = _context + pin.url + "?_title=" + encodeURI(pin.title) + params;
	}

	var _left = (screen.width)/2 - (pin.width+"").replace(/px/, '')/2 ;
	var _top = (screen.height)/2 - (pin.height+"").replace(/px/, '')/2;
	var win = window.open(
			openUrl,
			pin.winname

	);

	//post일때 submit
	if (pin.action) {
		form.submit();
	}

	//포커스
	if (win != undefined && win != null) {
		win.focus();
	}

	return win;
}

/**
 * B 팝업공통
 * @param pin
 * @returns bPopup
 */
function bpopup(pin){
	var defaultProps = {
			winname:"",
			title:"",
			_title:"",
			params:{},
			scrollbars:false,
			resizable:true,
			action:false
		};
		if (!pin.width) {
			switch (pin.type) {
				case "s":
					pin.width = "390px";
					break;
				case "sl":
					pin.width = "480px";
					pin.height = "340px";
					break;
				case "m":
					pin.width = "590px";
					break;
				case "l":
					pin.width = "730px";
					pin.height = "510px";
					break;
				case "xl":
					pin.width = "840px";
					break;
				case "xml":
					pin.width = "900px";
					pin.height = "720px";
					break;
				case "xxl":
					pin.width = "100%";
					break;
			}
		}
		if ( !pin.height ) {
			pin.height = "400px";
		}

		pin = $.extend(defaultProps, pin||{});

		var params = "";
		var openUrl = "";

		//메뉴 정보 추가
		if(pin.params) {
			if(typeof(pin.params) =="object") {
				pin.params = $.extend(pin.params,{_mnu_seq : _menu_id});
			}
		} else {
			pin.params = {_mnu_seq : _menu_id};
		}

		$.each(pin.params, function(name, value){
			if ($.isArray(value)) {
				$.each(value, function(index, value){
					params += ("&" + name + "=" + encodeURI(value));
				});
			} else {
				params += ("&" + name + "=" + encodeURI(value));
			}
		});

		openUrl = _context + pin.url + "?_title=" + encodeURI(pin.title) + params;
		var _left = (screen.width)/2 - (pin.width+"").replace(/px/, '')/2 ;
		var _top = (screen.height)/2 - (pin.height+"").replace(/px/, '')/2;

		/* 팝업 안에 팝업 - typeTwo로 구분 */
		if(pin.class2 == "typeTwo") {
			var $layer_popup1 = $('<div class="layer_popup ' + pin.class2 + '" id = "' + pin.id +'" style="width:' + pin.width +';height:' + pin.height + ';"></div>');
		} else {
			var $layer_popup1 = $('<div class="layer_popup" id = "' + pin.id +'" style="width:' + pin.width +';height:' + pin.height + ';"></div>');
		}

		var $layer_close_btn = $('<button class="btn_layer_close2 popClose'+pin.id+'" type="button" onclick="fn_onclick_close('+pin.id+')"><img src="' + _context + '/resources/pandora3/images/common_new/img_pop_close.png" alt="닫기" /></button>')
		var $layer_content = $('<div class="layer_content" style="width:100%;"></div>');

		$layer_popup1.append($layer_close_btn);
		$layer_popup1.append($layer_content);

		parent.$("body").append($layer_popup1);
		if(pin.class2 == "typeTwo") {
			parent.$('body .layer_popup.typeTwo').bPopup({
	        	content:'iframe',
	        	contentContainer:'.layer_popup.typeTwo .layer_content',
	        	// 팝업 1개이상일 경우 id를 못 찾아 수정
	        	// closeClass	: 'btn_layer_close2' + pin.id,
	            position: [50+'%', 50+'%'],
	            loadUrl: openUrl
	        });

		} else {
			parent.$('body .layer_popup').bPopup({
	        	content:'iframe',
	        	contentContainer:'.layer_content',
	        	// 팝업 1개이상일 경우 id를 못 찾아 수정
	        	// closeClass	: 'btn_layer_close2' + pin.id,
	            position: [50+'%', 50+'%'],
	            loadUrl: openUrl
	        });
		}
}

function fn_onclick_close(id){
	parent.$('#'+id.id).bPopup().close();
}

function displayLayer(id, disp) {
	$("#"+id).css('display',disp);
}

function displayIframe(id) {
	var t = $("#"+id);
	t.show();

	var subW = t.width();
	var subH = t.height();
	t.find('iframe').css('width',subW).css('height',subH);
	t.mouseleave(function(){
		t.hide();
	});
}

function fn_combo4(tid,sid){
	var posi = $("#"+tid).css('left');
	if (posi == "-250px") {
		moveElement(tid, 0, 41, 10);
		$("#"+sid).attr("src", $("#"+sid).attr("src").replace("_off.gif", "_on.gif"));
	}else{
		moveElement(tid, -250, 41, 10);
		$("#"+sid).attr("src", $("#"+sid).attr("src").replace("_on.gif", "_off.gif"));
	}
}

function moveElement(elementID,final_x,final_y,interval) {

	  if (!document.getElementById) return false;
	  if (!document.getElementById(elementID)) return false;
	  var elem = document.getElementById(elementID);

	  if (elem.movement) {
		clearTimeout(elem.movement);
	  }
	  if (!elem.style.left) {
		elem.style.left = "-200px";
	  }
	  if (!elem.style.top) {
		elem.style.top = "41px";
	  }
	  var xpos = parseInt(elem.style.left);
	  var ypos = parseInt(elem.style.top);
	  if (xpos == final_x && ypos == final_y) {
		return true;
	  }
	  if (xpos < final_x) {
		var dist = Math.ceil((final_x - xpos)/10);
		xpos = xpos + dist;
	  }
	  if (xpos > final_x) {
		var dist = Math.ceil((xpos - final_x)/10);
		xpos = xpos - dist;
	  }
	  if (ypos < final_y) {
		var dist = Math.ceil((final_y - ypos)/10);
		ypos = ypos + dist;
	  }
	  if (ypos > final_y) {
		var dist = Math.ceil((ypos - final_y)/10);
		ypos = ypos - dist;
	  }
	  elem.style.left = xpos + "px";
	  elem.style.top = ypos + "px";
	  var repeat = "moveElement('"+elementID+"',"+final_x+","+final_y+","+interval+")";
	  elem.movement = setTimeout(repeat,interval);

		//	bo 왼쪽 검색 레이어 위치
	  	if($(document).scrollTop() > 0 && $(document).scrollTop() < 41){
			$("#lnb").css({"top":(41-parseInt($(document).scrollTop()))+"px"});
		} else if($(document).scrollTop() == 0){
			$("#lnb").css({"top":"41px"});
		} else {
			$("#lnb").css({"top":"0px"});
		}
}

function ShowHideOn(name) {
	var obj=document.getElementById(name);

	if(obj.style.display == 'none') {
		obj.style.display = 'block';
	} else {
		obj.style.display = "none";
	}
}

/**
 * json object를 string으로 변환
 * @param json
 * @returns
 */
function jsonToString(json) {
    if (!json) return '""';
    if (typeof(json) == 'string') return '"'+json+'"';
    if (typeof(json) == 'number' || typeof(json) == 'boolean') return json;
    if (json instanceof Array)
    {
        var elems = [];
        for(var idx=0; idx < json.length; idx++)
            elems.push(jsonToString(json[idx]));
        return '['+elems.join(',')+']';
    }
    if (json instanceof Date)
        return '"'+json.format('yyyy-mm-dd hh:nn:ss')+'"';
    var items = [];
    for ( var key in json )
    {
        var str = key+':';

        switch(typeof json[key])
        {
            case 'function': // function 인경우 무시한다.
                continue;
            case 'undefined':
                break;
            case 'string': case 'number': case 'boolean': case 'object':
                str += jsonToString(json[key]);
                break;
            default:    // 데이터 유형이 기술되지 않은 객체에 대해서 문자열로 변환한다.
                str = key+':{type:"'+typeof(json[key])+'",value:"'+json[key]+'"}';
                break;
        }
        items.push(str);
    }
    return '{'+items.join(',')+'}';
}

/**
 * form 내용을 json 형태로 변환
 */
$.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

/**
 * 이벤트 bind 여부 check
 */
$.fn.isBound = function(type) {
    var data = $._data(this[0], 'events')[type];

    if (data === undefined || data.length === 0) {
        return false;
    }

    return true;
};

function isEmpty(val) {
	if (val == null || val == '' || val == undefined || ( val != null && typeof val == "object" && !Object.keys(val).length )) {
		return true;
	}
	else {
		return false;
	}
}

function isNotEmpty(val) {
	return !isEmpty(val);
}


/**
 * layer를 뛰운다. active x 위에서도 보여질 수 있도록 iframe 처리한다.
 * pin:{
 * 		id:string,		layer의ID :ID로 레이어를 참조할 수 있다.
 * 		width:string,	layer의 폭
 * 		height:string,	layer의 높이
 * 		top:string,		layer의 x좌표 -> 미지정시 마우스의 현재 위치
 * 		left:string		layer의 y좌표 -> 미지정시 마우스의 현재 위치
 * 		html:HTML,		layer의 내용
 * 		show:boolean,	기본적으로 보임 -> 미지정시 true
 * 		center:boolean,	레이어를 무조건 화면의 중앙에 위치 시킨다.
 * 		resize:boolean	내용에 맞춰서 크기 변경 여부 (디폴트 false)
 *
 * 		centerpop:boolean	팝업화면의 중앙위치 표시여부 (디폴트 false) // 2013.02.01
 * }
 */
createLayer = function(pin) {
	pin = $.extend({top:_pageY, left:_pageX, show:true, resize:false, centerpop:false}, pin||{});
	if (!pin.id) {
		alert('Layer id를 지정하세요!');
		return;
	}
	if (!pin.width) {
		alert('width를 지정하세요!');
		return;
	}
	if (!pin.height) {
		alert('height를 지정하세요!');
		return;
	}

	if (pin.center) {

		if (pin.centerpop) {
			pin.left = (document.documentElement.clientWidth)/2 - pin.width.replace(/px/g, '')/2 ;
		} else {
			pin.left = document.documentElement.scrollTop + (document.documentElement.clientWidth)/2 - pin.width.replace(/px/g, '')/2 ;
		}

		pin.top = document.documentElement.scrollTop + (document.documentElement.clientHeight)/2 - pin.height.replace(/px/g, '')/2;
		//var h=document.documentElement.clientHeight;
		//contentLry.style.top = h/2 - contentLry.offsetHeight/2 + "px";
	} else {
		if (document.body.scrollWidth - pin.left < pin.width.replace(/px/g, '')) {
			//pin.left = pin.left - pin.width.replace(/px/g, '');  //update by gondra 10-03
			pin.left = pin.left - ( pin.width.replace(/px/g, '') - (document.body.scrollWidth - pin.left));
		}
		if (document.documentElement.clientHeight - pin.top < pin.height.replace(/px/g, '')) {
			//pin.top = pin.top - pin.height.replace(/px/g, '');  //update by gondra 10-03
			pin.top = pin.top - ( pin.height.replace(/px/g, '') - (document.documentElement.clientHeight - pin.top )  );
		}

	}

	var display = $('#' + pin.id).css('display');

	if (typeof(display) == "undefined") {	//layer 미생성 단계
		var display = pin.show ? "block" : "none" ;

		if (navigator.appVersion.indexOf('MSIE 7') > 0) {	//IE 7
			pin.width = parseInt(pin.width.replace(/px/g, ''), 10);
			pin.height = parseInt(pin.height.replace(/px/g, ''), 10) + 10;
		} else {
			pin.width = parseInt(pin.width.replace(/px/g, ''), 10);
			pin.height = parseInt(pin.height.replace(/px/g, ''), 10);
		}

		var iframe = $('<iframe></iframe>');
		iframe.attr('id', pin.id + "_IFRAME").css('display', 'block').css('position', 'absolute').css('top', '0px').css('left', '0px');
		iframe.css('z-index', '-1').css('filter', 'alpha(opacity=0)').css('opacity', '0').css('-moz-opacity', '0');
		iframe.css('width', pin.width).css('height', pin.height);
		iframe.attr('src', 'about:blank');

		var maindiv = $('<div></div>').attr('id', pin.id + "_CONTAINER").css('display', display).css('position', 'relative').css('width', pin.width).css('height', pin.height);	//실제 내용이 삽일될 영역
		if (pin.html) {
			maindiv.append(pin.html);
		}

		var outterdiv = $('<div></div>').attr('id', pin.id).css('display', 'block').css('position', 'absolute').css('top', pin.top)
			.css('left', pin.left).css('z-index', '100');

		outterdiv.append(maindiv);
		outterdiv.append(iframe);

		$('body').append(outterdiv);

		if (pin.resize) {
			outterdiv.css('height', maindiv.attr('scrollHeight'));
			outterdiv.css('width', maindiv.attr('scrollWidth'));
			iframe.css('height', maindiv.attr('scrollHeight'));
			iframe.css('width', maindiv.attr('scrollWidth'));
		}

	} else if (display == 'block') {
		$('#' + pin.id).remove();
	} else if (display == 'none') {
		$('#' + pin.id).show();
	}
}

/**
 * layer 내용 채우기
 * pin:{
 * 		id:string,			//layer ID
 * 		contents:object,		//append 될 내용(text, html, $)
 * 		resize:boolean	내용에 맞춰서 크기 변경 여부 (디폴트 false)
 * }
 */
writeLayer = function(pin) {
	pin = $.extend({resize:false}, pin||{});
	var maindiv = $('#' + pin.id + "_CONTAINER");
	maindiv.empty();	//기존 내용이 있다면 비운다.
	maindiv.append(pin.contents);

	var outterdiv = $('#' + pin.id);
	var iframe = $('#' + pin.id + "_IFRAME");

	if (pin.resize) {
		outterdiv.css('height', maindiv.attr('scrollHeight'));
		outterdiv.css('width', maindiv.attr('scrollWidth'));
		iframe.css('height', maindiv.attr('scrollHeight'));
		iframe.css('width', maindiv.attr('scrollWidth'));
	}
};

/**
 * layer 보임/숨김
 * pin:{
 * 		show:boolean	true:보임, false:숨김
 * }
 */
showLayer = function(pin) {
	pin = pin||{};
	if (!pin.id) {
		alert('Layer id를 지정하세요!');
		return;
	}
	if (pin.show == true) {
		$('#' + pin.id).show();
	} else if (pin.show == false) {
		$('#' + pin.id).hide();
	}
}

/**
 * layer 제거
 * pin:{
 * 		id:string	//layer의 아이디
 * }
 */
removeLayer = function(pin) {
	pin = pin||{};
	$('#' + pin.id).remove();
}

/**
 * datepicker 한글 설정
 */
$.datepicker.setDefaults({
    dateFormat: 'yy-mm-dd',
    prevText: '이전 달',
    nextText: '다음 달',
    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
    showMonthAfterYear: true,
    yearSuffix: '년'
});

/**
 * datepicker 설정
 *  - prefix : 날짜 공통 Element id (#id)
 *  - from : id 뒤에 추가할 명칭 : from 용
 *  - to : id 뒤에 추가할 명칭 : to 용
 */
function setDatepicker(prefix, from, to,dateformat) {
	var termArr = new Array();
	termArr.push(prefix + from);
	termArr.push(prefix + to);

	for(i=0 ; i<termArr.length ; i++)
	{
		$(termArr[i]).datepicker({
			dateFormat	: 'yy-mm',
			onClose		: function(selectedDate){

				// 19.03.11 캘린더를 통해 입력하지 않은 경우에도 min/max 설정 되도록 추가
				var format = /\d{4}-\d{2}-\d{2}/;

				// YYYY-MM-DD 형태가 아닌 경우, 해당 형태로 변경
				if(!format.test(selectedDate))
				{
					selectedDate = selectedDate.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
					$(this).val(selectedDate);
				}

				var datelimit = "";
				var tgt_id = "";
				var org_cd = "#" + this.id;

				if(org_cd.indexOf(from) > -1)
				{
					datelimit = "minDate";
					tgt_id = org_cd.replace(from, to);
				}
				else
				{
					datelimit = "maxDate";
					tgt_id = org_cd.replace(to, from);
				}

				$(tgt_id).datepicker("option", datelimit, selectedDate);
			}
		});

		$(termArr[i]).keydown(function(e){
			return restrictionsKey(e);
		});

		$(termArr[i]).keyup(function(){
			$(this).val($(this).val().replace(/[^0-9]/g, ""));
		});
	}
}
/**
 * 공통코드 SELECT BOX 생성
 *  sysCdDtlMap : -Ajax로 취득한 공통코드 목록
 */
function makeSelectBoxSysCdDtl(sysCdDtlMap) {
	for(i=0; i<sysCdDtlMap.length; i++) {
		if("MSTS" == sysCdDtlMap[i].MST_CD) {
			$("#usr_stat_cd").append("<option value='" + sysCdDtlMap[i].CD+ "'>" + sysCdDtlMap[i].CD_NM + "</option> ");
		}
		else if("PQST" == sysCdDtlMap[i].MST_CD) {
			$("#pwd_qst").append("<option value='" + sysCdDtlMap[i].CD+ "'>" + sysCdDtlMap[i].CD_NM + "</option> ");
		}
		else if("USER_AUTH" == sysCdDtlMap[i].MST_CD) {
			$("#usr_auth_tp_cd").append("<option value='" + sysCdDtlMap[i].CD+ "'>" + sysCdDtlMap[i].CD_NM + "</option> ");
		}
		else if("RECRUIT_GB" == sysCdDtlMap[i].MST_CD) {
			$("#recruit_gb").append("<option value='" + sysCdDtlMap[i].CD+ "'>" + sysCdDtlMap[i].CD_NM + "</option> ");
		}
		else if("CLOSE_GB" == sysCdDtlMap[i].MST_CD) {
			$("#close_gb").append("<option value='" + sysCdDtlMap[i].CD+ "'>" + sysCdDtlMap[i].CD_NM + "</option> ");
		}
	}
}

// 탭 새창으로 띄우기(Frame 속에서만 사용 가능)
function addTabInFrame(url, param, param3) {
	ajax({
		url:'/main/selectTsysAdmMnuTgt.adm',
		data: {url : url},
		success: function(data) {
			if(isNotEmpty(data.menuInfoMap.mnu_seq)) {
				parent.addTab(data.menuInfoMap.mnu_seq, data.menuInfoMap.mnu_nm, url, param, "", param3);
			}
		}
	});
}

// 숫자만 입력 받기
function onlyNumber(e) {
	var rtnValue = false;
	var nArrKeyCode = new Array(
		48, 49, 50, 51, 52, 53, 54, 55, 56, 57, // 0 ~ 9 Key
		96, 97, 98, 99, 100, 101, 102, 103, 104, 105, // 키패드 0 ~ 9 Key
		//189, 109, // -, 키패드 - Key
		8, 46, // Back Space, Delete Key
		37, 39, // ←, → 방향 Key
		9, // Tab Key
		35, 36 // End, Home Key
	);
	for(var i = 0; i < nArrKeyCode.length; i++) {
		if(nArrKeyCode[i] == e.keyCode) {
			rtnValue = true;
			break;
		}
	}
	return rtnValue;
}

// Back Space, Delete Key, ←, → 방향 Key만 허용
function restrictionsKey(e) {
	var rtnValue = false;
	var nArrKeyCode = new Array(
		8, 46, // Back Space, Delete Key
		37, 39 // ←, → 방향 Key
	);
	for( var i = 0; i < nArrKeyCode.length; i++ ) {
		if(nArrKeyCode[ i ] == e.keyCode) {
			rtnValue = true;
			break;
		}
	}
	return rtnValue;
}

// 시분초 셋팅
function initSelectNumbers(){
	var val = '';
	var html = '';
	var idPrefixs = ["#_st_dt_","#_ed_dt_"];
	for(var g = 0; g < idPrefixs.length; g++) {
		html = '';
		for(var i = 0; i < 6; i++){
			for(j = 0; j < 10; j++){
				val = i + "" + j;
				html += "<option value='"+ val +"'>"+ val +"</option>\n";
				if(i == 2 && j == 3){$(idPrefixs[g]+"hh").append(html);}
				if(i == 5 && j == 9){
					$(idPrefixs[g]+"mm").append(html);
					$(idPrefixs[g]+"ss").append(html);
				}
			}
		}
	}
}

// 파일첨부 : 파일경로 입력
function ChangeText(oFileInput, sTargetID){
	var fileObj = oFileInput.files[0];
	var fileName = "";
	if(typeof fileObj !== "undefined") {
		fileName = oFileInput.files[0].name;
	}
	document.getElementById(sTargetID).value = fileName;
}

// 한글여부 판단
function is_hangul_char(ch) {
	c = ch.charCodeAt(0);
	if( 0x1100<=c && c<=0x11FF ) return true;
	if( 0x3130<=c && c<=0x318F ) return true;
	if( 0xAC00<=c && c<=0xD7A3 ) return true;
	return false;
}

// 숫자만 입력 받기(KeyUp)
function onlyNumberKeyUp(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	});
}

//태그/특수문자/공백 제거
function removeNotText(str) {
	return str.trim().replace(/(<([^>]+)>)/ig,"").replace(/\n/g, "");
}

//파일 다운로드
function fileDownload(fl_seq) {
	if(isEmpty(fl_seq)) return false;
	window.open(_context + "/content/filedownload.adm?fl_seq="+fl_seq,"_blank");
}

//파일 다운로드
function fileDown(fl_seq) {
	if(isEmpty(fl_seq)) return false;
	window.open(_context + "/content/filedownloads3.adm?fl_seq="+fl_seq,"_blank");
}

// 글자 바이트 체크 : are_name - textarea객체, ari_max - 제한길이 수
function f_chk_byte(aro_name, ari_max) {
	var ls_str= aro_name.value;
	var li_str_len = ls_str.length;
	var li_max= ari_max;
	var i= 0;
	var li_byte= 0;
	var li_len= 0;
	var ls_one_char = "";
	var ls_str2= "";

	for(i=0; i< li_str_len; i++) {
		ls_one_char = ls_str.charAt(i);
		if (escape(ls_one_char).length > 4)
			  li_byte += 2;
		else
			  li_byte++;
		if (li_byte <= li_max) li_len = i + 1;
	}

	if(li_byte > li_max) {
		alert("입력 최대 Byte 수는" +ari_max + "Byte 입니다.");
		ls_str2 = ls_str.substr(0, li_len);
		aro_name.value = ls_str2;
	}
	aro_name.focus();
}

/* 공통 코드 가져오기(복수)
 * 작성일 : 2019-01-04
 * @param mst_cd_str_arr string타입의 마스터코드  복수의 공통 코드를 가져올 경우 콤마로 묶어준다. ex) 'BBS0001,COM0001'
 * @param callBackFunc 결과값을 받을 콜백함수
 */
function getCommonCodeNm(mst_cd_str_arr, callBackFunc) {
	ajax({
		url: '/psys/getPsysCommon.adm',
		data : {'mst_cd_arr' : mst_cd_str_arr},
		success: function(data) {
			callBackFunc(data.selectData);
		},
	});
}

/* 공통 코드 값 Y,N 변환
 * 작성일 : 2019-01-04
 * @param data
 */
function setYnValue(data) {
	if(data == '10') { // 사용
		return 'Y'
	} else { // 미사용
		return 'N'
	}
}

/**
 * 바이트수 반환
 *
 * @param obj : tag jquery object
 * @returns {Number}
 */
function byteCheck(obj){
    var codeByte = 0;
    for (var idx = 0; idx < obj.val().length; idx++) {
        var oneChar = escape(obj.val().charAt(idx));
        if ( oneChar.length == 1 ) {
            codeByte ++;
        } else if (oneChar.indexOf("%u") != -1) {
            codeByte += 2;
        } else if (oneChar.indexOf("%") != -1) {
            codeByte ++;
        }
    }

    return codeByte;
}

/**
 * 글등록시, 바이트 변화 체크
 *
 * @param target
 * @returns {Number}
 */
function byteKeyupCheck(target, byteTarget, maxByte){

	$(document).on("keyup", target, function(){
        var nByte = byteCheck($(target));
        $(byteTarget).text(nByte);
        if (nByte > maxByte) {
            $(byteTarget).css("font-weight", "bold");
            $(byteTarget).css("color", "red");
        } else {
            $(byteTarget).css("font-weight", "normal");
            $(byteTarget).css("color", "#333");
        }
    });
}

/**
 * 글등록시, 화면에 바이트 수 표시
 *
 * @param textTarget - 글자 입력하는 타겟
 * @param byteTarget - 바이트 수 표시하는 타겟
 * @param maxByte - 최대바이트값
 */
function byteTextShow(inputTarget, byteTextTarget, maxByte){
	var nByte = byteCheck($(inputTarget));

    $(byteTextTarget).text(nByte);

    // 글등록시, 바이트 변화 체크
    byteKeyupCheck(inputTarget, byteTextTarget, maxByte);
}

/**
 * date 날짜 포맷
 * @return yyyy-mm-dd
 */
function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-');
}

/**
 * 한달후 날짜
 * @return yyyy-mm-dd
 */
function addMonth(selectedDate) {
   var date = selectedDate;

   return new Date(date.setMonth(date.getMonth() + 1));
}

/**
 * 날짜 유효성 체크
 * 시작일시가 종료일시보다 값이 작은지 체크
 * @param strFromDate - 스트링타입의 시작일시
 * @param strToDate   - 스트링타입의 종료일시
 * @param param       - 게시글 등록시에만 1년 기간 유효성 체크
 */
function validDateChk(strFromDate, strToDate, param) {

   // parsing date
   var fromDate  = new Date(strFromDate);
   var toDate    = new Date(strToDate);

   // 시작일보다 종료일이 더커야한다.
   if(fromDate > toDate){
      alert('종료 일시는 시작 일시보다 커야 합니다.');
      return false;
   }

   if("REG" == param) {
	   var diff = Math.abs(fromDate.getTime() - toDate.getTime());
	    diff = Math.ceil(diff / (1000 * 3600 * 24));

	   // 종료일을 시작일보다 최대 1년 설정
	   if(diff > 365) {
	      alert('종료 일시는 시작 일시보다 1년 이하여야 합니다.');
	      return false;
	   }
   }

   return true;
}

/**
 * 필수값 유효성 체크
 * class에 "vv"이 포함되어 있는 필수입력의 null값 체크 및 byte 체크
 * @param compForm
 */
function validChk(compForm){
	var dataValue = "";
	var labelName = "";
	var label     = "";
	var className = "";
	var labelText = "";
	var ch        = 0;

	for(var i=0; i<compForm[0].length; i++){

		var objTarget = compForm[0][i];
		var objTargetId = compForm[0][i].id;
		var labelObj =  $("label[for ='"+ objTargetId +"']");

		if(isNotEmpty(labelObj)){
			for(var j=0; j<labelObj.length; j++){
				//label class가 vv인 것만 추출(type input, select, textarea)
				if(labelObj[j].className.indexOf("vv") > -1){
					//공백체크
					dataValue = objTarget.value.replace(/ /g,"");
					//enter체크
					dataValue = dataValue.replace(/\n/g, "");
					//value값이 null인거 체크
					if(isEmpty(dataValue)){
					    labelText = labelObj[j].textContent;
					    if(objTarget.type == "select-one") {
					        // combo-box인 경우
					        alert(labelText + "를 선택해주세요.");
					    } else {
					        alert(labelText + "를 입력해주세요.");
					    }
						objTarget.focus();
						return false;
					}
				}else if(objTarget.type == "radio") { //라디오박스 체크

					labelName = objTarget.name;
					label     = $("label[for="+labelName+"]")[0];
					//label이 없을 경우
					if(label == undefined){
						continue;
					}
					className = label.className;
					labelText = label.textContent;
					var radiobox = document.getElementsByName(labelName);
					ch =0;

					if(className == "vv"){

						for(var k=0;k<radiobox.length;k++){
							if(radiobox[k].checked){
								ch++;
							}
						}
						if(ch < 1){
							alert(labelText + " 값을 선택해주세요.");
							return false;
						}
					}

				}else if(objTarget.type == "checkbox") { //체크박스

					labelName = objTarget.name;
					label     = $("label[for="+labelName+"]")[0];
					//label이 없을 경우
					if(label == undefined){
						continue;
					}
					className = label.className;
					labelText = label.textContent;
					var checkbox = document.getElementsByName(labelName);
					ch =0;

					if(className == "vv"){

						for(var k=0;k<checkbox.length;k++){
							if(checkbox[k].checked){
								ch++;
							}
						}
						if(ch < 1){
							alert(labelText + " 체크박스를 선택해주세요.");
							return false;
						}
					}
				}

				// byte check
				var maxByte = objTarget.getAttribute("data-maxbyte");
				var target  = objTarget.id;

				// tag 속성에 data-maxbyte=300를 추가후, byte 체크
				if(isNotEmpty(maxByte)) {
					if(byteCheck($("#" + target)) > maxByte){
						labelText = labelObj[j].textContent;
						alert(labelText + "은(는) " + maxByte + "자를 넘을 수 없습니다.");
						objTarget.focus();
						return false;
				    }
				}
			}
		}
	}

	return true;
}
/**
 * 파일 다운로드 폼 전송 : POST 방식
 * @param url    : 전송 URL
 * @param params : 파라미터
 */
function fileDownFormSubmit(pin) {
	var form = form = $('<form></form>').attr('id', 'fileDownAction').attr('method', 'post').css('display', 'none').attr('target', 'fileDown').attr('action', _context + pin.url);
	$.each(pin.params, function(name, value) {
		var element = $('<input></input>').attr('name', name).attr('value', value);
		form.append(element);
	});
	$('body').append(form);
	form.submit();
}

/**
 * 체크박스 전체 선택/해제
 * @param id     : 전체 선택 체크박스 id
 * @param name   : 전체 선택할 체크박스 name
 * @param totCnt : 체크박스 총 건수
 */
function checkedAll(id, name, totCnt) {
	var checkedAllVal = $("#"+id).prop("checked");
	if(checkedAllVal) {
		$("#"+name+"_checked_cnt").val(parseInt(totCnt, 10));
	}else {
		$("#"+name+"_checked_cnt").val(0);
	}
	$("input[name="+name+"]").prop("checked", checkedAllVal);
}

/**
 * 체크박스 체크여부 판단
 * @param id     : 현재 체크한 체크박스 id
 * @param name   : 현재 체크한 체크박스 name
 * @param allId  : 전체 선택 체크박스 id
 * @param totCnt : 체크박스 총 건수
 */
function checkedYn(id, name, allId, totCnt) {
	var checkedCnt = $("#"+name+"_checked_cnt").val();
	if($("#"+id).prop("checked")) checkedCnt = parseInt(checkedCnt, 10) + 1;
	else checkedCnt = parseInt(checkedCnt, 10) - 1;
	$("#"+name+"_checked_cnt").val(checkedCnt);

	var checked = false;
	if(checkedCnt == totCnt) checked = true;
	$("#"+allId).prop("checked", checked);
}

/**
 * iframe request
 * @param options - 여러가지 설정값
 */
function iframeReq(options) {
	var form = $();
	var params = "";
	var openUrl = "";

	if( options.action ){ // post방식

		if($("#iframeAction").length > 0) {
			$("#iframeAction").remove();
		}

		form = $('<form></form>').attr('id','iframeAction')
		                         .attr('method', 'post')
		                         .css('display','none')
		                         .attr('target', options.iframeName)
		                         .attr('action', _context + options.url);
		$.each(options.params, function(name, value){
			var element = $('<input></input>').attr('name', name).attr('value', value);
			form.append(element);
		});
		var element = $('<input></input>').attr('name', '_title').attr('value', options.title);
		form.append(element);
		$('body').append(form);

		// 전송
		form.submit();

	} else { // get방식
		$.each(options.params, function(name, value){
			if ($.isArray(value)) {
				$.each(value, function(index, value){
					params += ("&" + name + "=" + encodeURI(value));
				});
			} else {
				params += ("&" + name + "=" + encodeURI(value));
			}
		});

		openUrl = _context + options.url + "?_title=" + encodeURI(options.title) + params;

		// iframe src load
		options.iframeId.src = openUrl;
	}
}

/**
 * 공통 팝업 호출 함수
 * @param params       - 0. popup_id         - 공통 팝업 코드(필수)
 *                       1. callType         - type 종류 : grid, input(필수)
 *                       2. searchValue      - 검색한 값
 *                       3. callbackFunc     - 사용자 정의 콜백함수 - 파라미터는 고정값 (필수)
 *                       4. callbackParamVal - type이 grid이면 부모 grid의 rowId값, input이면 타겟 id값(필수)
 *                       5. popupType        - A - window open popup default, B - layer popup(필수)
 *                       6. popupMenuId      - layer popup의 자식  iframe id를 알기 위한 값
 */
var count = 0;
function comPopup(params) {
	var valid        = true;
	var popupUrl     = "/common/forward.comPopup.adm";
	params.popupType = params.popupType || "A";

	// 필수 값 validation check
	$.each(params, function(key, value){
		if(key != "searchValue" && isEmpty(value)) {
			alert("공통 팝업 필수 값 확인해주세요.");
			valid = false;
		}
	});

	if(!valid) {
		return valid;
	}

	// 공통 팝업 넓이, 높이 설정
	ajax({
		url:'/main/selectCommonPopupGrid',
		data: params,
		success: function(data) {

			var popupW = isEmpty(data.width) ? 500 : parseInt(data.width);
			var popupH = isEmpty(data.height) ? 500 : parseInt(data.height);

			// IE get method 한글 encoding error
			params.searchValue = encodeURIComponent(params.searchValue);

			if(params.popupType == "A") {
				// window open popup 호출
				popup({url      : popupUrl
			        , params    : params
			        , winname   : "comPopup" + count
			        , title     : "공통팝업"
			        , type      : "m"
			        , action    : true
			        , scrollbars: false
			        , autoresize: false
			        , width     : popupW
			        , height    : popupH
			    });
			} else if (params.popupType == "B") { // layer popup 호출

				// popupUrl get method
				popupUrl += "?"
				$.each(params, function(key, value){
					popupUrl +=key + "=" + value + "&"
				});
				popupUrl = popupUrl.substring(0, popupUrl.length - 1);

				parent.openPopLayer(popupUrl, {width: popupW, height: popupH});
			}
		}
	});
	count++;
}
/**
 * enter key or tab key down event 함수
 * @param target       - 타겟 id값
 * @param callBackFunc - 콜백 함수
 */
function inputEnterOrTabKeyEvent(target, callBackFunc){

	$("#"+ target).keydown(function(e){
		if(e.keyCode == 13 || e.keyCode == 9){
			callBackFunc();
		}
	});

}
$.fn.clearFormData = function() {
    return this.each(function() {
        var type = this.type, tag = this.tagName.toLowerCase();
        if (tag === 'form'){
            return $(':input',this).clearFormData();
        }
        if (type === 'text' || type === 'password' || type === 'hidden' || tag === 'textarea'){
            this.value = '';
        }else if (type === 'checkbox'){
            this.checked = false;
        }
        /*
        else if (type === 'checkbox' || type === 'radio'){
            this.checked = false;
        }else if (tag === 'select'){
            this.selectedIndex = -1;
        }
        */
    });
};

/**
 * 공통 팝업 닫기 함수
 * @param thisobj  - 클릭한 버튼
 */
function framePopClose(thisobj) {
	b_popup.close();
}

/**
 * 숫자만 입력 가능
 * @param event
 */
function onlyNumber(event)
{
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 9 || keyID == 46 || keyID == 37 || keyID == 39 )
		return;
	else
		return false;
}

/**
 * 숫자 외 문자열 제거
 * @param event
 */
function removeChar(event)
{
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 )
		return;
	else
		event.target.value = event.target.value.replace(/[^0-9]/g, "");
}

/**
 * Form 전송용 DateTime 설정
 *
 * @ formatYn : 포멧적용 여부 (YYYY-MM-DD HH:MM:SS 또는 YYYYMMDDHHMMSS)
 * @ prefix : 접두사 (필수)
 * @ suffix : 접미사 (생략 시 ["_st_dt", "_ed_dt"])
 * @ target : 값 설정 대상 접두사
 *
 * [사용 예]
 * 일자입력	: sch_st_dt
 * hidden	: h_sch_st_dt
 * 시분초		: _st_dt_hh / _st_dt_mm / _st_dt_ss
 *
 * 2019-03-12 10:35:47
 * fn_SetDateTime(true, "sch", ["_st_dt", "_ed_dt"], "h_")
 * fn_SetDateTime(true, "sch")
 *
 * 20190312103547
 * fn_SetDateTime(false, "sch", ["_st_dt", "_ed_dt"], "h_")
 * fn_SetDateTime(false, "sch")
 *
 **/
function fn_SetDateTime(formatYn, prefix, suffix, target)
{
	if(isEmpty(suffix))
		suffix = ["_st_dt","_ed_dt"];

	if(isEmpty(target))
		target = ["#h_" + prefix + suffix[0], "#h_" + prefix + suffix[1]];
	else
		target = [target + prefix + suffix[0], target + prefix + suffix[1]];

	var time = ["_hh", "_mm", "_ss"];

	for(var i in suffix)
	{
		var date = $("#" + prefix + suffix[i]).val();

		if(isEmpty(date))
			continue;

		if(formatYn)
			$(target[i]).val(date + " ");
		else
			$(target[i]).val(date.replace(/-/g, ""));

		for(var t in time)
		{
			$(target[i]).val($(target[i]).val() + $("#" + suffix[i] + time[t]).val());

			if(formatYn && t < time.length - 1)
				$(target[i]).val($(target[i]).val() + ":");
		}
	}
}
/**
 * 자바스크립트 태그 무력화 함수
 *
 **/
function removeScript(str){
	str = str.replace(/\<[sS][cC][rR][iI][pP][tT]\>/gi, "&lt;script&gt;").replace(/\<\/[sS][cC][rR][iI][pP][tT]\>/gi,"&lt;/script&gt").trim();

	return str;
}
/**
 * 핸드폰번호 및 전화번호 유효성 검사
 *
 **/
function validTelNo(target1, target2, target3){
	var str1 = $("#"+target1).val();
	var str2 = $("#"+target2).val();
	var str3 = $("#"+target3).val();

	var result = false;

	if((str1 != null && str1 != '')
		&& (str2 != null && str2 != '')
		&& (str3 != null && str3 != '')) {

		var totalLen = str1.length + str2.length + str3.length;

		if(totalLen == 11 || totalLen == 10) {

			var regExp1 = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})$/;
			var regExp2 = /^([0-9]{3,4})$/;
			var regExp3 = /^([0-9]{4})$/;

			if(regExp1.test(str1) && regExp2.test(str2) && regExp3.test(str3)) {
				result = true;
			}
		}
	} else {
		// 초기화
		$("#"+target1).val('');
		$("#"+target2).val('');
		$("#"+target3).val('');
		result = true;
	}

	return result;
}

/** 입력한 select id에 속한 데이터목록을 조회하는 함수
 *  작성일 : 2019-08-06
 *  @param params       : 0. sel_id  - select 조회 할 쿼리 id (필수)
 *                        1. p1 ~ p9 - where 조건 파라미터
 *  @param callBackFunc : 결과값을 받을 콜백함수
 *  호출 sample :
 *  var params = {
   	  	            "sel_id"        : "selectPsysList"
   	  	           , "p1"           : "BBS0001"
   	  	           , "p2"           : ""
   	  	           , "p3"           : ""
   	  	           , "p4"           : ""
   	  	           , "p5"           : ""
                  };
	getPsysCommonInfoList(params, function callBackFunc(data) {
		for(var i in data) {
		}
	});
 */
function getPsysCommonInfoList(params, callBackFunc) {

	if(params.sel_id == undefined || params.sel_id == null || params.sel_id == "" )
		GMsgLayer.alert("조회 할 select id는 필수 입니다.");
		return false;

	ajax({
		url: '/psys/getPsysCommonInfoList.adm',
		data : {'params' : params},
		success: function(data) {
			callBackFunc(data.selectCommData);
		},
	});
}

/** 메뉴별 상단그리드 버튼 목록 조회
 *  작성일 : 2019-08-12
 *
 */
function getBtnListSetting() {

	var titleBar = $(".ui-jqgrid-titlebar").eq(0);

	if( titleBar.length > 0 ){

		// 버튼 왼쪽에 위치
		titleBar.css('float','left');

		// 조회버튼만 상단, 그 외의 버튼은 상단 그리드 타이틀 오른쪽에 위치
		var html = '<div class="grid_btn" id="btn_info">';

		$.each(_btnDateList, function(index, pgminfo){

			var pgmBtnCd = pgminfo.PGM_BTN_CD;
			var cd_nm    = pgminfo.CD_NM;
			var ref_1    = pgminfo.REF_1;

			if(ref_1 != "search") {
				if(ref_1 === "excelDownload"){
					titleBar.addClass("typeExcel");
					$(".grid_right_btn").addClass("typeExcel");

					html+=('<button class="btn_common btn_default" id="btn_'+ref_1+'" name="_btnList" value="'+pgmBtnCd+'"><img src="' + _context + '/resources/pandora3/images/common_new/img_download.png" alt="엑셀 다운로드" /></button>' );
				} else {
					html+=('<button class="btn_common btn_default" id="btn_'+ref_1+'" name="_btnList" value="'+pgmBtnCd+'">'+cd_nm+'</button>' );
				}

			}
		});



		html+=("</div>");

		titleBar.append(html);

		// 버튼 조작 제약
		chkBtnControl();
	}
}

/** 로딩 start 공통(iframe 안)
 *  작성일 : 2019-11-18
 *
 */

function loading_start(fn, param){

	$("iframe", parent.document).closest("#tabs").find(".loading").show().animate({"opacity" : "1"}, {
	    complete: function() {
	    	return fn(param)
	    }
	  });
}

/** 로딩 end 공통(iframe 안)
 *  작성일 : 2019-11-18
 *
 */
function loading_end() {
	$("iframe", parent.document).closest("#tabs").find(".loading").hide();
}

/** 메인 로딩 start
 *  작성일 : 2019-11-18
 *
 */
function main_loading_start() {
	$("#tabs").find(".loading").show();
}

/** 메인 로딩 start
 *  작성일 : 2019-11-18
 *
 */
function main_loading_end() {
	$("#tabs").find(".loading").hide();
}

/** 새로고침 시 로딩 restart
 *  작성일 : 2019-11-15
 *
 */
window.onbeforeunload = function(e){
    parent.main_loading_start();
}

/** 3자리마다 , 찍기
 *  작성일 : 2019-12-11
 *
 */
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

/** 도움말 팝업 미리 보기
 *  작성일 : 2020-01-17
 *
 */
function helpPopup(text) {
	var popOption = {
			display: "block",
			position: "absolute",
			left: "50%",
			top: "50%",
			transform: "translate(-50%, -50%)",
			width: "800px",
			height: "600px",
			overflow: "auto",
			background:"#fff"
	};

	var popVer = 'helpPop';
	var $layer_popup1 = $('<div class="layer_popup2" data-test id="helpPopup1"></div>');
	var $layer_popup_bg = $('<div class="layer_popup2_bg"></div>');
	var $layer_img = $('<div class="mainPopWrap">'
				  +	  	'<div class="helpPopCon">'
				  +	  	'<h2 class="custom_title">도움말</h2>'
				  +		'<div class="txt" id="txt">'+text+'</div>'
				  +	  	'</div>'
				  +	  	'<p class="btn_mainPopClose" onclick="layer_pop_close(this)"><img src="' + _context + '/resources/pandora3/images/common/main_popup_btn.png" alt="닫기" /></p>'
				  +'</div>');

$layer_popup1.append($layer_img);
$("body", parent.document).append($layer_popup1).append($layer_popup_bg);

$(".layer_popup2", parent.document).css(popOption);

}

/** 도움말 팝업 닫기
 *  작성일 : 2020-01-17
 *
 */
function layer_pop_close(thisobj) {
	var $this = $(thisobj);

	$this.closest(".layer_popup2").remove();
	$(".layer_popup2_bg").remove();
}

/*************************
 * FORM/TABLE 하위 컴포넌트 값 입력여부 확인 후 메시지 알림 (체크박스 제외)
 *
 * @formId			: FORM 또는 TABLE ID (필수)
 * @visibleOnlyYn	: hidden 값 체크 여부 / 미입력시 체크 안함 (선택)
 *
 * gfn_checkFormEmpty("addSlctInfo");
 *************************/
function gfn_checkFormEmpty(formId, visibleOnlyYn)
{
	if(isEmpty(formId))
		return;

	if(isEmpty(visibleOnlyYn))
		visibleOnlyYn = "Y";

	var result = false;

	$("#" + formId).find("input, select, textarea").each(function(idx, obj){

		if(visibleOnlyYn == "Y" && obj.type == "hidden")
			return;

		var label = "label[for*='" + obj.id + "']";

		// 필수 입력인 경우
		if($(label).hasClass("necessary"))
		{
			if(isEmpty(obj.value) || obj.value == "-선택-")
			{
				// 최대 매출 브랜드 비율 값을 입력해주세요.
				alert($(label).text() + " 값을 입력해주세요.");

				// 미입력 컴포넌트에 포커스
				$(obj).focus();

				// 결과 값 설정
				result = true;

				// 체크 중단
				return false;
			}
		}
	});

	// TODO : RADIO 체크

	return result;
}

function grid_stop_propagation(event, thisobj){
	event.stopPropagation();
}

