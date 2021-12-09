 /**
 * @(#) xjsv.js version v2.14 korean
 *
 * Copyright(저작권) Do Not Erase This Comment!!! (이 주석문을 지우지 말것)
 *
 * This xjsv.js and xjsv.css is used for making easy to validate form fields
 * to develop enterprise web application.
 * Some functionality does not works in Netscape, so use Internet Explorer is recommanded.
 * when distribute this script, keep original zipped archive with whole source and document.
 * In case of this comment be keeped, you can use and modificate this source freely.
 * when you would modified this script source,
 * you should update all related documents and version information
 * If you feel that your modification is good to enough,
 * plz feel free send your source to early authors.
 * also you can add your name on the authors list.
 * for detailed function lists and references, see user's guide and developer's guide
 *
 * 이 xjsv.js 및 xjsv.css는 DHTML과 J-스크립트를 이용하여 기업환경
 * 웹 응용프로그램에서의 폼 필드 유효성 검사를 쉽게 하는데 사용된다.
 * 일부기능은 넷스케이프에서 작동되지 않을수도 있으며 익스플로를 사용하는것을
 * 권장한다.
 * 이 스크립트를 배포할 시에는 반드시 문서와 예제화일이 포함되어 압축되어 있는
 * 최초 형태 그대로 배포하여야 한다.
 * 이 주석문이 유지되는한 마음껏 이 소스를 변경 및 사용할 수 있다.
 * 이 스크립트 소스가 수정되는 경우 모든 document와 버젼 정보는 수정되어야 한다.
 * 만약 당신의 변경사항이 마음에 드는경우 당신의 소스를 기존 변경자들에게 보내는데
 * 부담을 느낄 필요는 없다.
 * 또한 당신의 이름을 저자목록에 추가할 수도 있다.
 * 각 펑션등에 대한 자세한 설명은 사용자 가이드 및 개발자 가이드를 참고하라.
 *
 * MODIFICATION HISTORY
 * DATE     Version    DEVELOPER                  DESCRIPTION
 * 2000/04/04 1.0        SungJo Kim                 Initial Release
 * 2000/09/15 1.1        Park Su hyun
 * 2000/10/30 1.2        SungJo Kim
 * 2001/06/13 1.5        TK Shin                    change to Document Object Model
 * 2001/07/12 2.0        TK Shin                    Adding componets
 * 2001/09/14 2.01       TK Shin                    Fixed Bugs(date, double submit)
 * 2001/09/27 2.02       TK Shin                    Fixed Bugs(event Object Exception Fix), IME Support
 * 2001/11/22 2.10       TK Shin                    send_value, auto_focus Support. 
 *                                                  check/uncheck, getNextFocus, getPreFocus methods,   setXjsvOption method
 * 2001/12/17 2.11       TK Shin                    auto_focus bugfix.
 *                                                  is_value Support, readonly_this Support.
 * 2002/01/09 2.12       TK Shin                    show/hide logic fix. hexa validator error message fix.
 *                                                  ee_on_key_up/ee_on_key_up event fire fix.
 *                                                  lable, focus_this, show_this, Support.
 * 2002/01/11 2.13       TK Shin                    psn logic fix [checkDigit = (checkDigit >= 10 ) ? checkDigit-10:checkDigit;]
 *                                                  getByte() method Support, maxByte, minByte Support.
 * 2002/04/22 2.14       TK Shin                    fix memroy leak (on xboj)
 *
 *
 * AUTHORS LIST       E-MAIL                   HOMEPAGE
 * SungJo Kim         javalife@korea.com       http://
 * TK Shin            lovemine@nownuri.net     http://www.lovemine.pe.kr
 * Park Su hyun       shypark@lgeds.lg.co.kr   http://
 *
 */


// 전역변수와 상수를 정의한다.
var XJSV_ACTIVATE = true;
var XJSV_VALIDATION_ACTIVATE = true;
var XJSV_MAGIC_QUOTE_ON = true;
var XJSV_ESCAPE_ON      = false;
var XJSV_CSS_PLAINED = true;
var XJSV_DISABLSUBMIT_ONSUBMIT = true;
var XJSV_ERASE_VALUE_DISABLE = true;
var XJSV_DYNAMIC_SEND_VALUE = true;

var XJSV_SHOW_STYLE = "inline";
    //block /inline /inline-block /list-item /table-header-group /table-footer-group 

var XJSV_REQUIRED_IGNORE_WHITESPACE = true;
var XJSV_DEFAULT_REQUIRED_SKIN = "xjs_required03";
var XJSV_MSG_PREFIX     = "입력오류 발생 : ";
var XJSV_MSG_UNKNOWN    = "지정되지 않은 에러입니다. \n관리자에게 에러 발생상황을 알려주십시요";
var XJSV_DEFAULT_DATE_MASK = "9999-99-99";
var XJSV_DEFAULT_PSN_MASK  = "999999-9999999";
var XJSV_DEFAULT_CSN_MASK  = "999-99-99999";
var XJSV_DEFAULT_NUM_FILTER       = "[0-9]";
var XJSV_DEFAULT_ALPHA_FILTER     = "[A-Za-z]";
var XJSV_DEFAULT_ALNUM_FILTER     = "[A-Za-z0-9]";
var XJSV_DEFAULT_FLOAT_FILTER     = "[0-9\\.\\-\\+]";
var XJSV_DEFAULT_INTEGER_FILTER     = "[0-9\\-\\+]";
var XJSV_DEFAULT_HEXA_FILTER       = "[a-fA-F0-9]";
var XJSV_DEFAULT_LO_ALPHA_FILTER  = "[a-z]";
var XJSV_DEFAULT_UP_ALPHA_FILTER  = "[A-Z]";

// ( ) [ ] { } < > " ' ` ~  $ ! # % ^ & @  , . ; :  \ / |  * = - ?
var XJSV_DEFAULT_SPECIAL_CHAR  = /(\(|\)|\[|\]|\{|\}|\<|\>|\"|\'|\`|\~|\$|\!|\#|\%|\^|\&|\@|\,|\.|\;|\:|\\|\/|\||\*|\=|\-|\?)*/g;
var XJSV_DEFAULT_WHITE_SPACE   = /\s/g;

var XJSV_DEFAULT_SKIN_DIR = "/common/scripts/images/";
var XJSV_BALLOON_BGCOLOR = "";
var XJSV_BALLOON_FORECOLOR = "black";

//// Global Variables for balloon assistant
var xjs_balloon_dek;               //
var xjs_balloon_Xoffset=-2;        // modify these values to ...
var xjs_balloon_Yoffset=-35;       // change the popup position.
var xjs_balloon_yyy=-1000;

//// Global Variables for detecting browser
var xjs_is_iex = null;      //if Browser is Internet Explorer
var xjs_is_nav = null;      //if Browser is Netscape
var xjs_is_old_nav = null;  //if Browser is old version of Netscape


////////////////////////////////////////////////////////////////////////////////////////////////
///
///   Form 객체
///
////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////
// 메소드명 : form.initialize()
// 대상객체 : form 객체(this)
// 내    용 : form의 method 및 event를 redefine하고
//            form이 가지는 각 elements에 관련된 초기화 작업을 수행한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function ff_initialize()
{

  //if (this.onsubmit) this.oldSubmit = this.onsubmit;

  //this.onsubmit = fe_onsubmit;
  //this.disableSubmitOnSubmit = fm_disable_submit_on_submit;
  //this.fireSubmit = fm_fire_submit;

  this.validate = fm_validate;

  this.unMasking = fm_un_masking;
  this.masking = fm_masking;

  this.enable = fm_enable;
  this.disable = fm_disable;

  this.show = fm_show;
  this.hide = fm_hide;
  this.checking = fm_checking;
  this.unChecking = fm_unChecking;
  this.getNextFocus = fm_get_next_focus;
  this.getPreFocus = fm_get_pre_focus;

  this.escape = fm_escape;
  this.unEscape = fm_unescape;

  this.magicQuoteAdd = fm_magic_quote_add;
  this.magicQuoteErase = fm_magic_quote_erase;

    this.fireSubmitInputTypeObj = new Object;
    this.setSubmitInputTypeObj = fm_set_submit_input_type_ojb;
    this.createHiddenInputType = fm_create_hidden_input_type;
    this.addSendValue = fm_add_send_value;
    
  for(var idx=0; idx < this.elements.length ; idx++){
    this.elements[idx].initialize = em_initialize;
    this.elements[idx].initialize(this);
  }

}

//////////////////////////////////////////////////////////
// 이벤트명 : form.onsubmit()
// 대상객체 : form 객체(this)
// 격발시기 : Fires when a form is about to be submitted.
// 리 턴 값 : boolean(false only) 이벤트를 false시킨다.
// 내    용 : form이 submit되었을때, fireSubmit()을 수행한다.
// 작 성 자 : 김성조 -> 신택규
//////////////////////////////////////////////////////////
function fe_onsubmit() {
  this.fireSubmit();
}

//////////////////////////////////////////////////////////
// 메소드명 : form.fireSubmit()
// 대상객체 : form 객체(this)
// 격발시기 : Fires when a form is about to be submitted.
// 리 턴 값 : boolean(false only) 이벤트를 false시킨다.
// 내    용 : validate 및 user_onsubmit등을 수행하고 실제의 submit()을 격발한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////

function fm_fire_submit() {


  if (!this.validate()) {
     if (event) event.returnValue = false;
     return false;
  }

  if ( this.getAttribute("confirm") && !confirm(this.getAttribute("confirm")) ) {
     if (event) event.returnValue = false;
     return false;
  }

  this.unMasking();
  
  if (this.oldSubmit && this.oldSubmit() == false)  {
     if (event) event.returnValue = false;
     return false;
  }

  if (XJSV_MAGIC_QUOTE_ON) this.magicQuoteAdd();
  if (XJSV_ESCAPE_ON) this.escape();

    if (XJSV_DYNAMIC_SEND_VALUE && event && event.type=="submit") this.addSendValue();
        
  if (XJSV_DISABLSUBMIT_ONSUBMIT) this.disableSubmitOnSubmit();

    if (!event) this.submit();

//below method doesn't call because this.submit is gone
// if (event) event.returnValue = false;
// return false;
}

//////////////////////////////////////////////////////////
// 메소드명 : form.validate()
// 대상객체 : form 객체(this)
// 리 턴 값 : boolean(true / false)
// 내    용 : 모든 element의 validate 함수를 호출한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function fm_validate()
{
  if (!XJSV_VALIDATION_ACTIVATE) return true;

  for(var idx=0; idx < this.elements.length ; idx++){
    if (this.elements[idx].validate && this.elements[idx].validate() == false ) {
      return false;
    }
  }

  return true;
}

//////////////////////////////////////////////////////////
// 메소드명 : form.masking()
// 대상객체 : form 객체(this)
// 내    용 : 모든 element를 masking한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function fm_masking()
{
  for(var idx=0; idx < this.elements.length ; idx++)
    if (this.elements[idx].masking) this.elements[idx].masking();

}

//////////////////////////////////////////////////////////
// 메소드명 : form.unMasking()
// 대상객체 : form 객체(this)
// 내    용 : 모든 element의 mask를 없앤다.(submit되는 실제 value로 만든다.)
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function fm_un_masking()
{
  for(var idx=0; idx < this.elements.length ; idx++){
    if (this.elements[idx].stripMasking)  this.elements[idx].stripMasking();
    else if (this.elements[idx].unMasking) this.elements[idx].unMasking();
  }
}

//////////////////////////////////////////////////////////
// 메소드명 : form.disable(fields)
// 대상객체 : form 객체(this)
// 파라메터 : fields : Disable시킬 elements의 name
// 내    용 : fields에 해당하는 element를 Disable시킨다.
// 작 성 자 : 김성조 -> 신택규
//////////////////////////////////////////////////////////
function fm_disable(fields)
{
  var node = null;
  var ss = fields.split(",");
  for(var j in  ss )  {
    if ( ss[j] == "" || !this.elements[ss[j]]) continue;
    node = this.elements[ss[j]];

    if (typeof(node.name) == "undefined") {
      for (idx = 0 ; idx<node.length ; idx++)
        if (node[idx].disable) node[idx].disable();
    }else{
        if (node.disable) node.disable();
    }

  }
}

//////////////////////////////////////////////////////////
// 메소드명 : form.enable(fields)
// 대상객체 : form 객체(this)
// 파라메터 : fields : Enable시킬 elements의 name
// 내    용 : fields에 해당하는 element를 Enable시킨다.
// 작 성 자 : 김성조 -> 신택규
//////////////////////////////////////////////////////////
function fm_enable(fields)
{
  var node = null;
  var ss = fields.split(",");
  for(var j in  ss )  {
    if ( ss[j] == "" || !this.elements[ss[j]]) continue;
    node = this.elements[ss[j]];

    if (typeof(node.name) == "undefined") {
      for (idx = 0 ; idx<node.length ; idx++)
        if (node[idx].enable) node[idx].enable();
    }else{
        if (node.enable) node.enable();
    }
  }
}


//////////////////////////////////////////////////////////
// 메소드명 : form.show(fields)
// 대상객체 : form 객체(this)
// 파라메터 : fields : Show할  elements의 name
// 내    용 : fields에 해당하는 element를 Show한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function fm_show(fields)
{
  var node = null;
  var ss = fields.split(",");
  for(var j in  ss )  {
    if ( ss[j] == "" || !this.elements[ss[j]]) continue;
    node = this.elements[ss[j]];

    if (typeof(node.name) == "undefined") {
      for (idx = 0 ; idx<node.length ; idx++)
        if (node[idx].show) node[idx].show();
    }else{
        if (node.show) node.show();
    }
  }
}


//////////////////////////////////////////////////////////
// 메소드명 : form.hide(fields)
// 대상객체 : form 객체(this)
// 파라메터 : fields : Show할  elements의 name
// 내    용 : fields에 해당하는 element를 Hide한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function fm_hide(fields)
{
  var node = null;
  var ss = fields.split(",");
  for(var j in  ss )  {
    if ( ss[j] == "" || !this.elements[ss[j]]) continue;
    node = this.elements[ss[j]];

    if (typeof(node.name) == "undefined") {
      for (idx = 0 ; idx<node.length ; idx++)
        if (node[idx].hide) node[idx].hide();
    }else{
        if (node.hide) node.hide();
    }
  }
}

//////////////////////////////////////////////////////////
// 메소드명 : form.escape()
// 대상객체 : form 객체(this)
// 내    용 : 모든 element의 value값을 인코딩한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function fm_escape()
{
  for(var idx=0; idx < this.elements.length ; idx++){
    var node = this.elements[idx];
    if ( (  node.type != "button" && node.type != "submit" && node.type != "reset" ) && node.value)
      node.value = escape(node.value);
  }
}

//////////////////////////////////////////////////////////
// 메소드명 : form.unEscape()
// 대상객체 : form 객체(this)
// 내    용 : 모든 element의 value값을 디코딩한다
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function fm_unescape()
{
  for(var idx=0; idx < this.elements.length ; idx++){
    if (this.elements[idx].value)
      this.elements[idx].value = unescape(this.elements[idx].value);
  }
}

//////////////////////////////////////////////////////////
// 메소드명 : form.magicQuoteAdd()
// 대상객체 : form 객체(this)
// 내    용 : 모든 element의 value값에 Magic Quote를 더한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function fm_magic_quote_add()
{
  for(var idx=0; idx < this.elements.length ; idx++){
    if (this.elements[idx].value && this.elements[idx].magicQuoteAdd)
      this.elements[idx].value = this.elements[idx].magicQuoteAdd();
  }
}


//////////////////////////////////////////////////////////
// 메소드명 : form.magicQuoteErase()
// 대상객체 : form 객체(this)
// 내    용 : 모든 element의 value값에서 Magic Quote를 뺀다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function fm_magic_quote_erase()
{
  for(var idx=0; idx < this.elements.length ; idx++){
    if (this.elements[idx].value && this.elements[idx].magicQuoteErase)
      this.elements[idx].value = this.elements[idx].magicQuoteErase();
  }
}

//////////////////////////////////////////////////////////
// 메소드명 : form.disableSubmitOnSubmit()
// 대상객체 : form 객체(this)
// 내    용 : XJSV_DISABLSUBMIT_ONSUBMIT이 설정되어 있으면 submit시에 모든 submit버튼을 disable시킨다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function fm_disable_submit_on_submit()
{
  for(var idx=0; idx < this.elements.length ; idx++){
    if (this.elements[idx].type == "submit" || this.elements[idx].type == "image")  {
      this.elements[idx].disable();
    }
  }
}

//////////////////////////////////////////////////////////
// 메소드명 : form.createHiddenInputType()
// 대상객체 : form 객체(this)
// 파라메터 : inputName 생성할 hidden input-type의 name
//            inputName 생성할 hidden input-type의 value
// 내    용 : form에 inputName의 input객체(hidden)을 dynamic하게 생성하고 value값을 inputValue로 설정한다.
//            이미 같은 이름의 input객체가 있는 경우에는 value값만을 inputValue로 설정한다.
// 작 성 자 : 신택규
// 적용버젼 : xsjv 2.1
//////////////////////////////////////////////////////////
function fm_create_hidden_input_type(inputName, inputValue){

    var oElement = null;

    if (typeof(eval("this."+inputName))== "undefined") { //input ojbect is not exist
      var oHid=document.createElement("input");
      oHid.type = "hidden";
      oHid.id = inputName;
      oHid.name = inputName;
      this.insertBefore(oHid);
        oElement = oHid;
    } else {
        oElement = eval("this."+inputName);
    }
    oElement.value = inputValue;
}

//////////////////////////////////////////////////////////
// 메소드명 : form.setSubmitInputTypeObj()
// 대상객체 : form 객체(this)
// 내    용 : submit을 fire한 input 객체(sumit/images)를 form의 attribute로 세팅한다.
// 작 성 자 : 신택규
// 적용버젼 : xsjv 2.1
//////////////////////////////////////////////////////////
function fm_set_submit_input_type_ojb(obj){
    this.fireSubmitInputTypeObj = obj;
}

//////////////////////////////////////////////////////////
// 메소드명 : form.addSendValue()
// 대상객체 : form 객체(this)
// 내    용 : form에 send_value로 정의된 문자열을 사용하여 hidden값들을 세팅한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function fm_add_send_value(){
  var type = this.fireSubmitInputTypeObj.type;

    if (!( type == "submit" || type == "image" )) return;
    
    var pStr = this.fireSubmitInputTypeObj.getAttribute("send_value");

    if (pStr == null || pStr =="" ) return;

  var ss = pStr.split("&");
  for(var j in  ss )  { 
    if ( ss[j] == "" ) continue;
    var tt = ss[j].split("=");
    this.createHiddenInputType(tt[0],tt[1]);
  }    

}        


//////////////////////////////////////////////////////////
// 메소드명 : form.checking()
// 대상객체 : form 객체(this)
// 파라메터 : objName : check element의 이름
// 내    용 : form이 가지고 있는 checkbox 혹은 radio버튼중 이름과 일치하는것을 check한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function fm_checking(objName)
{ 
    for(var idx=0; idx < this.elements.length ; idx++){
    if ( this.elements[idx].name == objName && this.elements[idx].type == "checkbox" || this.elements[idx].type == "radio" ) this.elements[idx].checking();
  }
}


//////////////////////////////////////////////////////////
// 메소드명 : form.unChecking()
// 대상객체 : form 객체(this)
// 파라메터 : objName : unCheck할 element의 이름
// 내    용 : form이 가지고 있는 checkbox 혹은 radio버튼중 이름과 일치하는것을 uncheck한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function fm_unChecking(objName)
{
    for(var idx=0; idx < this.elements.length ; idx++){
    if ( this.elements[idx].name == objName &&     this.elements[idx].type == "checkbox" || this.elements[idx].type == "radio" ) this.elements[idx].unChecking();
  }
}

////////////////////////////////////////////////////////
// 메소드명 : form.getNextFocus()
// 대상객체 : form 객체 (this)
// 파라메터 : selfObj : 현재 focus를 가지고 있는 객체 (element)
//           objName : next로 focus할 객체의 name
// 리 턴 값 : 찾아진 next focus 객체.
// 내    용 : next로 focus할 객체를 찾아 return한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function fm_get_next_focus(selfObj, objName)
{

    if (objName) return typeof( this.elements[objName].name) == "undefined" ? this.elements[objName][0] : this.elements[objName]; 

    var selfEleIndex = this.elements.length;
    
    for(var idx=0; idx < this.elements.length ; idx++){
    if ( this.elements[idx] == selfObj ) selfEleIndex = idx;
  }
  
  do{
      selfEleIndex ++;
    } while (this.elements[selfEleIndex].readOnly || this.elements[selfEleIndex].isAttribute("lable" ) || this.elements[selfEleIndex].style.display == "none" );

  if (selfEleIndex >= this.elements.length) selfEleIndex = 0;

//  alert(this.elements[selfEleIndex].name);
  return this.elements[selfEleIndex];

  /* find next focus in document not form
    var nextEle = null;
    
  var init = this.sourceIndex+1;

  for ( i=init; document.all.length > i ; i++) {
      if (document.all[i].tagName == "INPUT" || document.all[i].tagName == "TEXTAREA") { nextEle = document.all[i]; break; }
  }
  
  for ( i=0; !nextEle && document.all.length > i ; i++) {
      if (document.all[i].tagName == "INPUT" || document.all[i].tagName == "TEXTAREA") { nextEle = document.all[i]; break; }
     }

  return nextEle;
  */
}

/////////////////////////////////////////////////////////
// 메소드명 : form.getPreFocus()
// 대상객체 : form 객체 (this)
// 파라메터 : selfObj : 현재 focus를 가지고 있는 객체 (element)
//           objName : pre로 focus할 객체의 name
// 리 턴 값 : 찾아진 pre focus 객체.
// 내    용 : pre로 focus할 객체를 찾아 return한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function fm_get_pre_focus(selfObj, objName)
{
    var preEle = null;
    
    if (objName) return typeof( this.elements[objName].name) == "undefined" ? this.elements[objName][0] : this.elements[objName]; 

    var selfEleIndex = 0;
    
    for(var idx=0; idx < this.elements.length ; idx++){
    if ( this.elements[idx] == selfObj ) selfEleIndex = idx;
  }
  
  do{
      selfEleIndex --;
    } while (this.elements[selfEleIndex].readOnly || this.elements[selfEleIndex].isAttribute("lable" ) || this.elements[selfEleIndex].style.display == "none" );
  
  if (selfEleIndex < 0 ) selfEleIndex = this.elements.length-1;
  
  return this.elements[selfEleIndex];

}

////////////////////////////////////////////////////////////////////////////////////////////////
///
///   element 객체
///
////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////
// 메소드명 : element.initialize(parent)
// 대상객체 : element 객체 (this)
// 파라메터 : parent : 부모클래스 (form)
// 내    용 : element의 method, event 및 attribute를 redefine한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_initialize(parent)
{
    //constant data;
    this.parent = parent; //Parent - form
    this.hideValue = ""; //use this when enable/disable, show/hide
    this.impotence = false; //use this XJSV_DISABLSUBMIT_ONSUBMIT is true and user use back button

    //store original events and redirct events;
    if (this.onkeypress) this.old_onkeypress = this.onkeypress;
    if (this.onkeyup) this.old_onkeyup = this.onkeyup;
    if (this.onfocus) this.old_onfocus = this.onfocus;
    if (this.onblur) this.old_onblur = this.onblur;
    if (this.onchange) this.old_onchange = this.onchange;
    if (this.onclick) this.old_onclick = this.onclick;
    if (this.onmouseover) this.old_onmouseover = this.onmouseover;
    if (this.onmouseout) this.old_onmouseout = this.onmouseout;

    this.onkeypress = null;  //used for only filter
    this.onkeyup = ee_on_keyup;  //used for only auto_focus
    this.onfocus = ee_on_focus;
    this.onblur = ee_on_blur;
    this.onchange = ee_on_change;
    this.onclick = ee_on_click;
    this.onmouseover = ee_on_mouse_over;
    this.onmouseout = ee_on_out;

    //Method for UI - Controller
    this.uiContollerFactory = em_uic_factory;
    this.applyUic = em_apply_uic;
    this.enableUic = em_enable_uic;

    this.uicCss = em_uic_css;
    this.uicFilter = em_uic_filter;
    this.uicMask = em_uic_mask;

    this.strippers = new Array;
    this.addStripper = em_add_stripper;
    this.stripping = em_stripping;

    this.assistants = new Array;
    this.addAssistant = em_add_assistant;
    this.assistantShow = em_assistant_show;
    this.assistantKill = em_assistant_kill;

    //data & event redirct for filter;
    this.xjs_filter = null;

    //data & event redirct for mask;
    this.xjs_mask = null;
    this.masking = null;
    this.unMasking = null;
    this.stripMasking = null;

    //data & method for validation
    this.validators = new Array;
    this.validatorFactory = em_validator_factory;
    this.enableValidator = em_enable_validator;
    this.addValidator = em_add_validator;
    this.validate = em_validate;

    //data & method for Dynamic UI - Handler
    this.uich = new Array;
    this.duihFactory = em_duih_factory;
    this.enableDuih = em_enable_duih;
    this.addDuih = em_add_duih;
    this.fireDuih = em_fire_duih;

    //Method for Utilities
    this.enable = em_enable;
    this.disable = em_disable;
    this.getByte = em_getByte;
    
    this.show = em_show;
    this.hide = em_hide;
    this.checking = em_checking;
    this.unChecking = em_unChecking;
    this.makeReadOnly = em_make_read_only;
    this.storeValue = em_store_value;
    this.restoreValue = em_restore_value;

    this.isAttribute = em_is_attribute;
    this.isAttrValue = em_is_attribute_value;

    this.magicQuoteAdd = em_magic_quote_add;
    this.magicQuoteErase = em_magic_quote_erase;

    //Execute method for Initialize
    this.uiContollerFactory();
    this.validatorFactory();
    this.duihFactory();

}

////////////////////////////////////////////////////////////////////////////////////////////////
///
///   element 객체 User Events
///
////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////
// 이벤트명 : element.onkeypress()
// 대상객체 : element 객체 (this)
// 격발시기 : Fires when the user presses an alphanumeric key.
// 리 턴 값 : boolean(false only) 이벤트를 false시킨다.
// 내    용 : 키가 눌릴때 element.xjs_filter에 의거하여 키입력을 막는다.
// 작 성 자 : 김성조 -> 신택규
//////////////////////////////////////////////////////////
function ee_on_key_press(){

  if (this.xjs_filter) {
    var sKey = String.fromCharCode(event.keyCode);
    var re = new RegExp(this.xjs_filter);

    // Enter는 키검사를 하지 않는다.
    if(sKey!="\r" && !re.test(sKey)) event.returnValue=false;
  }

  if (this.old_onkeypress) this.old_onkeypress();
}

/////////////////////////////////////////////////////////
// 이벤트명 : element.onkeyup()
// 대상객체 : element 객체 (this)
// 격발시기 : Fires when the user presses an alphanumeric key.
// 리 턴 값 : boolean(false only) 이벤트를 false시킨다.
// 내    용 : 키가 눌릴때 auto_focus를 체크한다.
// 작 성 자 : 김성조 -> 신택규
//////////////////////////////////////////////////////////
function ee_on_key_up(){

    if ( event.keyCode !=9 && event.keyCode !=16  && this.isAttribute("auto_focus") && this.value.length >= this.getAttribute("maxlength") ) {
      var nextItem = this.parent.getNextFocus(this);
      nextItem.focus();
  }

  if (this.old_onkeyup) this.old_onkeyup();
}

/////////////////////////////////////////////////////////
// 이벤트명 : element.onfocus()
// 대상객체 : element 객체 (this)
// 격발시기 : Fires when the element receives the focus.
// 내    용 : element에 포커스가 들어오면 masking 및 select를 수행한다.
// 작 성 자 : 김성조 -> 신택규
//////////////////////////////////////////////////////////
function ee_on_focus()
{

  if ( this.assistants.length && this.assistantShow ) this.assistantShow("status_bar");

    if (this.readOnly || this.isAttribute("lable" ) || this.style.display == "none" ) {
         this.blur(); 
         //this.parent.getNextFocus(this).focus(); 
         }
  
  if ( this.value && !this.readOnly) {
    if ( ( this.type == "text" || this.type == "password" ) && this.unMasking)
      this.unMasking();
    if ( ( this.type == "text" || this.type == "password" ) && this.select)
      this.select();
  }

  if(this.old_onfocus) this.old_onfocus();
}

function ee_on_keyup() {

	if (this.assistants.length && this.assistantShow ) this.assistantShow("status_bar");
	
	if(this.old_onfocus) this.old_onfocus();
	
	if ( ( this.type == "text" || this.type == "password" || this.type == "textarea" || this.type == "file") && this.fireDuih)
	    this.fireDuih();

	if ( this.value ) {
    	if ( ( this.type == "text" || this.type == "password" ) && this.masking)
			this.masking();
    	if ( ( this.type == "text" || this.type == "password" || this.type == "textarea" || this.type == "file") && this.stripping)
			this.stripping();
	}
	
	if(this.old_onkeyup) this.old_onkeyup();
}

/////////////////////////////////////////////////////////
// 이벤트명 : element.onblur()
// 대상객체 : element 객체 (this)
// 격발시기 : Fires when the object element the input focus.
// 내    용 : element가 포커스를 잃으면 unmasking 및 Duih를 수행한다.
// 작 성 자 : 김성조 -> 신택규
//////////////////////////////////////////////////////////
function ee_on_blur()
{

  if ( this.assistants.length && this.assistantKill ) this.assistantKill("status_bar");

  if ( ( this.type == "text" || this.type == "password" || this.type == "textarea" || this.type == "file") && this.fireDuih)
    this.fireDuih();

  if ( this.value ) {
    if ( ( this.type == "text" || this.type == "password" ) && this.masking)
      this.masking();
    if ( ( this.type == "text" || this.type == "password" || this.type == "textarea" || this.type == "file") && this.stripping)
      this.stripping();
  }

  if(this.old_onblur ) this.old_onblur();
}

/////////////////////////////////////////////////////////
// 이벤트명 : element.onchange()
// 대상객체 : element 객체 (this)
// 격발시기 : Fires when the contents of the object or selection have changed.
// 내    용 : element의 내용이 바뀌면 Duih를 수행한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function ee_on_change()
{

  if ( ( this.type == "select-one" || this.type == "select-multiple" ) && this.fireDuih)
    this.fireDuih();

  if(this.old_onchange ) this.old_onchange();
}


/////////////////////////////////////////////////////////
// 이벤트명 : element.onclick()
// 대상객체 : element 객체 (this)
// 격발시기 : Fires when the user clicks the left mouse button on the object.
// 내    용 : element를 클릭하면 Duih를 수행한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function ee_on_click()
{
  if ( ( this.type == "radio" || this.type == "checkbox" ) && this.fireDuih)
    this.fireDuih();

    if ( this.type == "submit" )
      this.parent.setSubmitInputTypeObj(this);
      
  if(this.old_onclick ) this.old_onclick();
}


/////////////////////////////////////////////////////////
// 이벤트명 : element.onmouseover()
// 대상객체 : element 객체 (this)
// 격발시기 : Fires when the user clicks the left mouse button on the object.
// 내    용 : element를 클릭하면 Duih를 수행한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function ee_on_mouse_over()
{
  if ( this.assistants.length && this.assistantShow ) this.assistantShow("balloon");

  if(this.old_onmouseover ) this.old_onmouseover();
}

/////////////////////////////////////////////////////////
// 이벤트명 : element.onmouseout()
// 대상객체 : element 객체 (this)
// 격발시기 : Fires when the user clicks the left mouse button on the object.
// 내    용 : element를 클릭하면 Duih를 수행한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function ee_on_out()
{
  if ( this.assistants.length && this.assistantKill ) this.assistantKill("balloon");

  if(this.old_onmouseout ) this.old_onmouseout();

}

/////////////////////////////////////////////////////////
// 메소드명 : element.isAttribute(attr)
// 대상객체 : element 객체 (this)
// 파라메터 : attr : element가 가진 attribute
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element가 주어진 attribute를 가지는지 체크한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_is_attribute(attr)
{
  return ( this.getAttribute(attr) != null ) ? true : false;
}

/////////////////////////////////////////////////////////
// 메소드명 : element.isAttrValue(attr)
// 대상객체 : element 객체 (this)
// 파라메터 : attr : element가 가진 attribute
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element가 주어진 attribute를 가지는고 값을 가지는지 체크한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_is_attribute_value(attr)
{
  return ( this.getAttribute(attr)  ) ? true : false;
}

/////////////////////////////////////////////////////////
// 메소드명 : element.getByte()
// 대상객체 : element 객체 (this)
// 리 턴 값 : value의 byte값
// 내    용 : 대상 element의 value의 byte값을 구한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_getByte()
{

  if (typeof(this.value) == "undefined" || typeof(this.value.length) == "undefined" ) return 0;
  
  var str = this.value;

  var len=0, j;

  for (i=0, j=str.length; i<j; i++, len++)
  {
    if ( (str.charCodeAt(i)<0)||(str.charCodeAt(i)>127) )
     {
          len = len+1;
     }
  }

  return len;
}

/////////////////////////////////////////////////////////
// 메소드명 : element.enable()
// 대상객체 : element 객체 (this)
// 내    용 : element를 enable시키고 값을 복구시킨다.
// 작 성 자 : 김성조 -> 신택규
//////////////////////////////////////////////////////////
function em_enable()
{
   if (!this.isAttribute("disabled")) return;

  switch (this.type) {
    case "text" :
    case "password" :
    case "textarea" :
    case "select-one" :
    case "select-multiple" :
    case "image" :
    case "file" :
      this.restoreValue();
      this.removeAttribute("disabled");
      this.style.backgroundColor = "#ffffff";
    break;

    case "radio" :
    case "checkbox" :
      this.restoreValue();
      this.removeAttribute("disabled");
    break;

    case "button" :
    case "submit" :
    case "reset" :
      this.removeAttribute("disabled");
      this.style.backgroundColor = "#dfdfde";
    break;

    default :
    break;
 }
  this.impotence = false;
}

/////////////////////////////////////////////////////////
// 메소드명 : element.disable()
// 대상객체 : element 객체 (this)
// 내    용 : element를 disable시키고 값을 없앤다.
// 작 성 자 : 김성조 -> 신택규
//////////////////////////////////////////////////////////
function em_disable()
{
   if (this.getAttribute("disabled")) return;

  switch (this.type) {
    case "text" :
    case "password" :
    case "textarea" :
    case "select-one" :
    case "select-multiple" :
    case "image" :
    case "file" :
      this.storeValue();
      this.setAttribute("disabled",true);
      this.style.backgroundColor = "#cccccc";
    break;

    case "radio" :
    case "checkbox" :
      this.storeValue();
      this.setAttribute("disabled",true);
    break;


    case "button" :
    case "submit" :
    case "reset" :
      this.setAttribute("disabled",true);
      this.style.backgroundColor = "#cccccc";
    break;

    default :
    break;
 }

  this.impotence = true;


}


/////////////////////////////////////////////////////////
// 메소드명 : element.show()
// 대상객체 : element 객체 (this)
// 내    용 : element를 show하고 값을 복구시킨다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_show()
{

   // use this.style.visibility visible/hidden if postion blocked.
   if (this.style.display == XJSV_SHOW_STYLE ) return; 

  switch (this.type) {
    case "text" :
    case "password" :
    case "textarea" :
    case "button" :
    case "submit" :
    case "reset" :
    case "radio" :
    case "checkbox" :
    case "select-one" :
    case "select-multiple" :
    case "image" :
    case "file" :
      this.restoreValue();
      this.style.display = XJSV_SHOW_STYLE;
    break;

    default :
    break;
 }

  this.impotence = false;

}

/////////////////////////////////////////////////////////
// 메소드명 : element.hide()
// 대상객체 : element 객체 (this)
// 내    용 : element를 hide시키고 값을 없앤다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_hide()
{
   if (this.style.display == "none" ) return;

  switch (this.type) {
    case "text" :
    case "password" :
    case "textarea" :
    case "button" :
    case "submit" :
    case "reset" :
    case "radio" :
    case "checkbox" :
    case "select-one" :
    case "select-multiple" :
    case "image" :
    case "file" :
      this.storeValue();
      this.style.display = "none";
    break;

    default :
    break;
 }
  this.impotence = true;
}

/////////////////////////////////////////////////////////
// 메소드명 : element.checking()
// 대상객체 : element 객체 (this)
// 내    용 : element(checkBox, radio)를 checking한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_checking()
{

  switch (this.type) {
    case "checkbox" :
    case "radio" :
            this.checked  = true; 
    break;

    default :
    break;
 }

}

/////////////////////////////////////////////////////////
// 메소드명 : element.unchecking()
// 대상객체 : element 객체 (this)
// 내    용 : element(checkBox, radio)를 unchecking한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_unChecking()
{

  switch (this.type) {
    case "checkbox" :
    case "radio" :
            this.checked  = false; 
    break;

    default :
    break;
 }

}

/////////////////////////////////////////////////////////
// 메소드명 : element.makeReadOnly()
// 대상객체 : element 객체 (this)
// 파라메터 : flag : true이면 readonly, false이면 writerable이다.
// 내    용 : element의 readOnly속성을 설정한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_make_read_only(flag)
{
 
  if (flag) {
      if (this.readOnly || this.getAttribute("disabled")) return;
  } else {
      if (!this.readOnly || !this.isAttribute("disabled")) return;
    }
  switch (this.type) {
    case "text" :
    case "password" :
    case "textarea" :
    if (flag) {
      this.readOnly = true;
      this.style.backgroundColor = "#FFFFCC";
    } else {
      this.readOnly = false;
      this.style.backgroundColor = "#ffffff";       
    }
    break;

    default :
    break;
 }
}

/////////////////////////////////////////////////////////
// 메소드명 : element.storeValue()
// 대상객체 : element 객체 (this)
// 내    용 : 대상  element가 hide/disable되었을때 value값을 저장하고 지운다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_store_value()
{
  if (!XJSV_ERASE_VALUE_DISABLE) return;
  if (this.value == "" || this.value == null ) return;
    this.hideValue = this.value;
    this.value = "";
}

/////////////////////////////////////////////////////////
// 메소드명 : element.restoreValue()
// 대상객체 : element 객체 (this)
// 내    용 : 대상  element가 show/enable되었을때 value값을 restore한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_restore_value()
{
  if (!XJSV_ERASE_VALUE_DISABLE) return;
  if (this.hideValue == "" || this.hideValue == null ) return;
    this.value = this.hideValue;
    this.hideValue = "";
}


/////////////////////////////////////////////////////////
// 메소드명 : element.magicQuoteAdd()
// 대상객체 : element 객체 (this)
// 내    용 : 대상  element의 value값에 Magic Quote를 더한다.
// 리 턴 값 : value값에 Magic Quote를 더한 String
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_magic_quote_add()
{
  if (!this.value) return ; //입력값 없는 경우는 Pass

  magicquote = this.value;
  magicquote = magicquote.replace(/\\/ig ,"\\\\");
  magicquote = magicquote.replace(/\'/ig ,"\\'");
  magicquote = magicquote.replace(/\"/ig ,"\\\"");

  return magicquote;
}

/////////////////////////////////////////////////////////
// 메소드명 : element.magicQuoteErase()
// 대상객체 : element 객체 (this)
// 내    용 : 대상  element의 value값에서 Magic Quote를 뺀다.
// 리 턴 값 : value값에 Magic Quote를 뺀 String
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_magic_quote_erase()
{
  if (!this.value) return ; //입력값 없는 경우는 Pass

  reverse = this.value;
  reverse = reverse.replace(/\\\"/ig ,"\"");
  reverse = reverse.replace(/\\'/ig ,"\'");
  reverse = reverse.replace(/\\\\/ig ,"\\");

  return reverse;
}


/////////////////////////////////////////////////////////
// 메소드명 : element.validate()
// 대상객체 : element 객체 (this)
// 리 턴 값 : boolean(true / false)
// 내    용 : 각 element에 등록된 validator들을 모두 체크하고
 //           정상적이라면 배경색을 흰색으로 바꾼다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_validate()
{

  if ( !this.validators.length ) return true;

  for(var idx=0; idx < this.validators.length ; idx++){
    if (!this.impotence && this.validators[idx].validate && this.validators[idx].validate() == false ) {
      return false;
    }
  }

  if (this.type != "radio" && this.type != "checkbox" ) this.style.backgroundColor = "white";
  else this.style.backgroundColor = "";

  return true;
}

/////////////////////////////////////////////////////////
// 메소드명 : element.stripping()
// 대상객체 : element 객체 (this)
// 내    용 : 각 element에 등록된 stripper들을 모두 fire한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_stripping()
{
  if ( !this.strippers.length ) return true;

  for(var idx=0; idx < this.strippers.length ; idx++){
    if (this.strippers[idx].stripping)
     this.strippers[idx].stripping();
  }
}

/////////////////////////////////////////////////////////
// 메소드명 : element.assistantShow(xjs_key)
// 대상객체 : element 객체 (this)
// 파라메터 : show할 assistant의 종류
// 내    용 : 각 element에 등록된 assistant들을 모두 show 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_assistant_show(xjs_key)
{
  if ( !this.assistants.length ) return true;

  for(var idx=0; idx < this.assistants.length ; idx++){
    if (this.assistants[idx].show && this.assistants[idx].xjs_key == xjs_key )
     this.assistants[idx].show();
  }
}

/////////////////////////////////////////////////////////
// 메소드명 : element.assistantKill(xjs_key)
// 대상객체 : element 객체 (this)
// 파라메터 : show할 assistant의 종류
// 내    용 : 각 element에 등록된 assistant들을 모두 kill 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_assistant_kill(xjs_key)
{
  if ( !this.assistants.length ) return true;

  for(var idx=0; idx < this.assistants.length ; idx++){
    if (this.assistants[idx].kill && this.assistants[idx].xjs_key == xjs_key )
     this.assistants[idx].kill();
  }
}


/////////////////////////////////////////////////////////
// 메소드명 : element.fireDuih()
// 대상객체 : element 객체 (this)
// 내    용 : 각 element에 등록된 duih를 Fire시킨다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_fire_duih()
{
  if ( !this.uich.length ) return;

  for(var idx=0; idx < this.uich.length ; idx++)
    if (this.uich[idx].fireOnEvent) this.uich[idx].fireOnEvent();
}


////////////////////////////////////////////////////////////////////////////////////////////////
///
///   element 객체 메소드 - Dynamic UI Handler
///
////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////
// 메소드명 : element.duihFactory()
// 대상객체 : element 객체 (this)
// 내    용 : 대상  element의 type과 주어진 attribute에 따라 필요한
//            Dynamic UI Handler 를 사용 가능하게 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function  em_duih_factory()
{
    switch (this.type) {

    case "text" :
    case "password" :
    case "textarea" :
    case "radio" :
    case "checkbox" :
    case "select-one" :
    case "select-multiple" :
    case "file" :
        if ( this.isAttrValue("enable_fields") )  this.enableDuih("enable_fields");
        if ( this.isAttrValue("show_fields") )    this.enableDuih("show_fields");
        if ( this.isAttrValue("disable_fields") ) this.enableDuih("disable_fields");
        if ( this.isAttrValue("hide_fields") )    this.enableDuih("hide_fields");
      break;

      default :
      break;
    }
}

/////////////////////////////////////////////////////////
// 메소드명 : element.enableDuih(xjs_key)
// 대상객체 : element 객체 (this)
// 파라메터 : xjs_key : 주어진 duih용 attribute
// 내    용 : 주어진 attribute에 따라 필요한 dui-handler를 element에 등록한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_enable_duih(xjs_key)
{

  switch(xjs_key)
  {

    case "enable_fields" :
        this.addDuih(new xo_dui_handler(this, "enable_fields", "enable_values"));
    break;
    case "show_fields" :
        this.addDuih(new xo_dui_handler(this, "show_fields", "show_values"));
    break;
    case "disable_fields" :
        this.addDuih(new xo_dui_handler(this, "disable_fields", "disable_values"));
    break;
    case "hide_fields" :
        this.addDuih(new xo_dui_handler(this, "hide_fields", "hide_values"));
    break;

    default :
    break;

  }
}

/////////////////////////////////////////////////////////
// 메소드명 : element.addDuih(uichObj)
// 대상객체 : element 객체 (this)
// 파라메터 : uichObj : element에 붙을 dui-handler 객체
// 내    용 : 주어진 dui-handler 객체를 element에 등록한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_add_duih(uichObj)
{
  this.uich[this.uich.length] = uichObj;
}

////////////////////////////////////////////////////////////////////////////////////////////////
///
///   Dynamic UI Handler 객체 & 메소드
///
////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////
// 객 체 명 : xo_handler(parent, xjs_key, xjs_value)
// 파라메터 : parent : 부모 객체 (element 객체)
//            xjs_key : 적용할 element의 names (ex : disable_fields)
//            xjs_value : 격발시킬 값 (ex : disable_values)
// 내    용 : element객체에 등록될 dui-handler 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_dui_handler(parent, xjs_key, xjs_value)
{
    this.parent = parent;
    this.xjs_key = xjs_key;
    this.xjs_doFields = parent.getAttribute(xjs_key);
    this.xjs_ifValues =  parent.isAttribute(xjs_value) ? parent.getAttribute(xjs_value) : null ;

    this.fireOnEvent = xm_fire_on_event;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_dui_handler.fireOnEvent()
// 대상객체 : this : duih 객체 (xo_dui_handler)
// 내    용 : 이벤트 발생시 대상  element의 duih객체로서의 dynamic ui handling을 한다.
// 작 성 자 : 김성조 -> 신택규
//////////////////////////////////////////////////////////
function xm_fire_on_event()
{
  var flag = false;
  //의미적으로 사용자가 지정한 조건을 가진다.
  // (체크박스 체크된경우와 ifvalue에 값과 현재 값이 일치하는 경우등이 true이다.)
  // ifvalue값이 없는경우에는 값이 있으면 true로 생각한다.

  if (( this.parent.type == "checkbox" || this.parent.type == "radio" ))
  {
    if ( this.parent.checked)
       flag = true;
  }else{
    if (this.xjs_ifValues)  {
      var ss;
      ss = this.xjs_ifValues.split(",");
      for(var j in  ss )
        if (this.parent.value == ss[j]) flag = true;
    } else {
        if ( this.parent.value.length > 0 )
          flag = true;
    }
  }

//alert(flag +":" + this.xjs_key + ":"+ this.xjs_ifValues + ":" + this.parent.value);
  //////////////////////////////
  //이곳에서 각 경우별로 enable을 호출한 이유는 on_blur시에 각 경우에 따라
  //함수 핸들러를 사용할 경우 form.enable에서 this(form)를 form으로 인식하지
  //못하고 xo_dui_handler로 인식하기 때문이다.
  //////////////////////////////
  if (flag) {
    switch(this.xjs_key)  {

      case "enable_fields" :
          this.parent.parent.enable(this.xjs_doFields);
      break;
      case "disable_fields" :
          this.parent.parent.disable(this.xjs_doFields);
      break;
      case "show_fields" :
          this.parent.parent.show(this.xjs_doFields);
      break;
      case "hide_fields" :
          this.parent.parent.hide(this.xjs_doFields);
      break;
      default :
      break;
    }

  } else {
    switch(this.xjs_key)  {
      case "enable_fields" :
          this.parent.parent.disable(this.xjs_doFields);
      break;
      case "disable_fields" :
          this.parent.parent.enable(this.xjs_doFields);
      break;
      case "show_fields" :
          this.parent.parent.hide(this.xjs_doFields);
      break;
      case "hide_fields" :
          this.parent.parent.show(this.xjs_doFields);
      break;
      default :
      break;
    }
  }

}


////////////////////////////////////////////////////////////////////////////////////////////////
///
///   element 객체 메소드 - UI-Contoller Factory
///
////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////
// 메소드명 : element.uiContollerFactory()
// 대상객체 : element 객체 (this)
// 내    용 : 대상  element의 type과 주어진 attribute에 따라 필요한
//            UI-Contoller를 사용 가능하게 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function  em_uic_factory()
{
    switch (this.type) {

      case "text" :
        if ( this.isAttrValue("plain-box") || XJSV_CSS_PLAINED ) this.applyUic("plain-box");
        if ( this.isAttribute("required") )  this.applyUic("required");
        if ( this.isAttribute("right") )     this.applyUic("right");
        if ( this.isAttrValue("filter") )    this.applyUic("filter");
        if ( this.isAttribute("integer") )    this.applyUic("integer");
        if ( this.isAttribute("float") )    this.applyUic("float");
        if ( this.isAttribute("hexa") )    this.applyUic("hexa");
        if ( this.isAttribute("credit_card") )    this.applyUic("credit_card");
        if ( this.isAttribute("alphabetic") )    this.applyUic("alphabetic");
        if ( this.isAttribute("numeric") )    this.applyUic("numeric");
        if ( this.isAttribute("alpha_numeric") )    this.applyUic("alpha_numeric");
        if ( this.isAttrValue("mask") )      this.applyUic("mask");
        if ( this.isAttribute("money") )     this.applyUic("money");
        if ( this.isAttribute("dollar") )    this.applyUic("dollar");
        if ( this.isAttribute("date") )      this.applyUic("date");
        if ( this.isAttribute("psn") )    this.applyUic("psn");
        if ( this.isAttribute("csn") )    this.applyUic("csn");
        if ( this.isAttribute("trim") )    this.enableUic("trim");
        if ( this.isAttribute("strip_special_char") )    this.enableUic("strip_special_char");
        if ( this.isAttribute("strip_white_space") )    this.enableUic("strip_white_space");
        if ( this.isAttrValue("balloon") )      this.enableUic("balloon");
        if ( this.isAttrValue("status_bar") )      this.enableUic("status_bar");
        if ( this.isAttribute("disable_this") )    this.applyUic("disable_this");
        if ( this.isAttribute("hide_this") )    this.applyUic("hide_this");
        if ( this.isAttribute("show_this") )    this.applyUic("show_this");
        if ( this.isAttribute("readonly_this") )    this.applyUic("readonly_this");
        if ( this.isAttrValue("ime") )    this.applyUic("ime");
        if ( this.isAttribute("auto_focus") )    this.enableUic("auto_focus");
        if ( this.isAttribute("lable") )    this.applyUic("lable");
        if ( this.isAttribute("focus_this") )  this.applyUic("focus_this");
      break;

      case "password" :
        if ( this.isAttrValue("plain-box") || XJSV_CSS_PLAINED ) this.applyUic("plain-box");
        if ( this.isAttribute("required") )  this.applyUic("required");
        if ( this.isAttribute("right") )     this.applyUic("right");
        if ( this.isAttrValue("filter") )    this.applyUic("filter");
        if ( this.isAttribute("integer") )    this.applyUic("integer");
        if ( this.isAttribute("float") )    this.applyUic("float");
        if ( this.isAttribute("hexa") )    this.applyUic("hexa");
        if ( this.isAttribute("credit_card") )    this.applyUic("credit_card");
        if ( this.isAttribute("alphabetic") )    this.applyUic("alphabetic");
        if ( this.isAttribute("numeric") )    this.applyUic("numeric");
        if ( this.isAttribute("alpha_numeric") )    this.applyUic("alpha_numeric");
        if ( this.isAttribute("psn") )    this.applyUic("psn");
        if ( this.isAttribute("csn") )    this.applyUic("csn");
        if ( this.isAttribute("trim") )    this.enableUic("trim");
        if ( this.isAttribute("strip_special_char") )    this.enableUic("strip_special_char");
        if ( this.isAttribute("strip_white_space") )    this.enableUic("strip_white_space");
        if ( this.isAttrValue("balloon") )      this.enableUic("balloon");
        if ( this.isAttrValue("status_bar") )      this.enableUic("status_bar");
        if ( this.isAttribute("disable_this") )    this.applyUic("disable_this");
        if ( this.isAttribute("hide_this") )    this.applyUic("hide_this");
        if ( this.isAttribute("show_this") )    this.applyUic("show_this");
        if ( this.isAttribute("readonly_this") )    this.applyUic("readonly_this");
        if ( this.isAttrValue("ime") )    this.applyUic("ime");
        if ( this.isAttribute("auto_focus") )    this.enableUic("auto_focus");
        if ( this.isAttribute("focus_this") )  this.applyUic("focus_this");
        
      break;

      case "textarea" :
        if ( this.isAttrValue("plain-box") || XJSV_CSS_PLAINED ) this.applyUic("plain-box");
        if ( this.isAttribute("required") )  this.applyUic("required");
        if ( this.isAttribute("trim") )    this.enableUic("trim");
        if ( this.isAttribute("strip_special_char") )    this.enableUic("strip_special_char");
        if ( this.isAttribute("strip_white_space") )    this.enableUic("strip_white_space");
        if ( this.isAttrValue("balloon") )      this.enableUic("balloon");
        if ( this.isAttrValue("status_bar") )      this.enableUic("status_bar");
        if ( this.isAttribute("disable_this") )    this.applyUic("disable_this");
        if ( this.isAttribute("hide_this") )    this.applyUic("hide_this");
        if ( this.isAttribute("show_this") )    this.applyUic("show_this");
        if ( this.isAttribute("readonly_this") )    this.applyUic("readonly_this");
        if ( this.isAttrValue("ime") )    this.applyUic("ime");
        if ( this.isAttribute("focus_this") )  this.applyUic("focus_this");
      break;

      case "radio" :
        if ( this.isAttrValue("balloon") )      this.enableUic("balloon");
        if ( this.isAttrValue("status_bar") )      this.enableUic("status_bar");
        if ( this.isAttribute("disable_this") )    this.applyUic("disable_this");
        if ( this.isAttribute("hide_this") )    this.applyUic("hide_this");
        if ( this.isAttribute("show_this") )    this.applyUic("show_this");
        if ( this.isAttribute("focus_this") )  this.applyUic("focus_this");
      break;

      case "checkbox" :
        if ( this.isAttribute("required") )  this.applyUic("required");
        if ( this.isAttrValue("balloon") )      this.enableUic("balloon");
        if ( this.isAttrValue("status_bar") )      this.enableUic("status_bar");
        if ( this.isAttribute("disable_this") )    this.applyUic("disable_this");
        if ( this.isAttribute("hide_this") )    this.applyUic("hide_this");
        if ( this.isAttribute("show_this") )    this.applyUic("show_this");
        if ( this.isAttribute("focus_this") )  this.applyUic("focus_this");
      break;

      case "select-one" :
      case "select-multiple" :
        if ( this.isAttrValue("balloon") )      this.enableUic("balloon");
        if ( this.isAttrValue("status_bar") )      this.enableUic("status_bar");
        if ( this.isAttribute("disable_this") )    this.applyUic("disable_this");
        if ( this.isAttribute("hide_this") )    this.applyUic("hide_this");
        if ( this.isAttribute("show_this") )    this.applyUic("show_this");
        if ( this.isAttribute("focus_this") )  this.applyUic("focus_this");
      break;

      case "file" :
        if ( this.isAttrValue("plain-box") || XJSV_CSS_PLAINED ) this.applyUic("plain-box");
        if ( this.isAttribute("required") )  this.applyUic("required");
        if ( this.isAttribute("trim") )    this.enableUic("trim");
        if ( this.isAttrValue("balloon") )      this.enableUic("balloon");
        if ( this.isAttrValue("status_bar") )      this.enableUic("status_bar");
        if ( this.isAttribute("disable_this") )    this.applyUic("disable_this");
        if ( this.isAttribute("hide_this") )    this.applyUic("hide_this");
        if ( this.isAttribute("show_this") )    this.applyUic("show_this");
        if ( this.isAttribute("focus_this") )  this.applyUic("focus_this");
      break;

      case "submit" :
      case "button" :
      case "reset" :
      case "image" :
        if ( this.isAttrValue("plain-box") || XJSV_CSS_PLAINED ) this.applyUic("plain-box");
        if ( this.isAttrValue("balloon") )      this.enableUic("balloon");
        if ( this.isAttrValue("status_bar") )      this.enableUic("status_bar");
        if ( this.isAttribute("disable_this") )    this.applyUic("disable_this");
        if ( this.isAttribute("hide_this") )    this.applyUic("hide_this");
        if ( this.isAttribute("show_this") )    this.applyUic("show_this");
        if ( this.isAttribute("focus_this") )  this.applyUic("focus_this");

      break;
      default :
      break;
    }
}


/////////////////////////////////////////////////////////
// 메소드명 : element.applyUic(xjs_key)
// 대상객체 : element 객체 (this)
// 파라메터 : xjs_key : 주어진 UI-Contoller(UIC)용 attribute
// 내    용 : 주어진 attribute에 따라 필요한 UIC를 element에 적용한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_apply_uic(xjs_key)
{
  switch(xjs_key)
  {
    case "plain-box" :
        switch(this.type) {
        case "text" :
        case "password" :
          this.uicCss("xjs_edit_box");
        break;

        case "button" :
        case "reset" :
        case "submit" :
          this.uicCss("xjs_button");
        break;

        case "file" :
        case "textarea" :
          this.uicCss("xjs_plain");

        break;

        default :
        break;
        }

    break;

    case "required" : //means "required" willbe activate
      switch(this.getAttribute("required")) {
        case "skin01" :
          this.uicCss("xjs_required01");
        break;
        case "skin02" :
          this.uicCss("xjs_required02");
        break;
        case "skin03" :
          this.uicCss("xjs_required03");
        break;
        case "skin04" :
          this.uicCss("xjs_required04");
        break;
        case "skin05" :
          this.uicCss("xjs_required05");
        break;
        default :
          this.uicCss(XJSV_DEFAULT_REQUIRED_SKIN);
        break;
      }
    break;

    case "right" :
        this.uicCss("xjs_right" );
    break;

    case "filter" :
        this.uicFilter(this.getAttribute("filter"));
    break;

    case "integer" :
        if ( !this.isAttrValue("filter") ) this.uicFilter(XJSV_DEFAULT_INTEGER_FILTER);
    break;

    case "float" :
        if ( !this.isAttrValue("filter") ) this.uicFilter(XJSV_DEFAULT_FLOAT_FILTER);
    break;

    case "hexa" :
        if ( !this.isAttrValue("filter") ) this.uicFilter(XJSV_DEFAULT_HEXA_FILTER);
    break;

    case "credit_card" :
        if ( !this.isAttrValue("filter") ) this.uicFilter(XJSV_DEFAULT_NUM_FILTER);
    break;

    case "alphabetic" :
        if ( !this.isAttrValue("filter") ) this.uicFilter(XJSV_DEFAULT_ALPHA_FILTER);
    break;

    case "numeric" :
        if ( !this.isAttrValue("filter") ) this.uicFilter(XJSV_DEFAULT_NUM_FILTER);
    break;

    case "alpha_numeric" :
        if ( !this.isAttrValue("filter") ) this.uicFilter(XJSV_DEFAULT_ALNUM_FILTER);
    break;

    case "mask" :
        this.uicMask(this.getAttribute("mask"));
    break;

    case "money" :
        this.uicMask(null, em_money_masking);
        if ( !this.isAttrValue("filter") ) this.uicFilter(XJSV_DEFAULT_NUM_FILTER);
    break;

    case "dollar" :
        this.uicMask(null, em_dollar_masking);
        if ( !this.isAttrValue("filter") ) this.uicFilter(XJSV_DEFAULT_NUM_FILTER);
    break;

    case "date" :
        this.isAttrValue("mask") ?
          this.uicMask(this.getAttribute("mask")) : this.uicMask(XJSV_DEFAULT_DATE_MASK);
        if (!this.isAttrValue("filter") ) this.uicFilter(XJSV_DEFAULT_NUM_FILTER);
    break;

    case "psn" :
        this.isAttrValue("mask") ?
          this.uicMask(this.getAttribute("mask")) : this.uicMask(XJSV_DEFAULT_PSN_MASK);
        if (!this.isAttrValue("filter") ) this.uicFilter(XJSV_DEFAULT_NUM_FILTER);
    break;

    case "csn" :
        this.isAttrValue("mask") ?
          this.uicMask(this.getAttribute("mask")) : this.uicMask(XJSV_DEFAULT_CSN_MASK);
        if (!this.isAttrValue("filter") ) this.uicFilter(XJSV_DEFAULT_NUM_FILTER);
    break;

    case "disable_this" :
        this.disable();
    break;

    case "hide_this" :
        this.hide();
    break;

    case "show_this" :
        this.show();
    break;

    case "focus_this" :
        if (this.focus) this.focus();
    break;

    case "readonly_this" :
        this.makeReadOnly(true);
    break;

    case "ime" :
      switch(this.getAttribute("ime")) {
        case "kor" :
          this.uicCss("xjs_imeKor");
        break;
        case "eng" :
          this.uicCss("xjs_imeEng");
        break;
        case "engOnly" :
          this.uicCss("xjs_imeDis");
        break;
      }
    break;    

      case "lable" : 
          this.uicCss("xjs_lable");
          //this.style.
      break;

    default :
    break;
  }
}


/////////////////////////////////////////////////////////
// 메소드명 : element.enableUic(xjs_key)
// 대상객체 : element 객체 (this)
// 파라메터 : xjs_key : 주어진 UI-Controller 용 attribute
// 내    용 : 주어진 attribute에 따라 필요한 UIC를 element에 등록한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_enable_uic(xjs_key)
{
  switch(xjs_key)
  {

    case "trim" :
        this.addStripper(new xo_trim(this));
    break;

    case "strip_special_char" :
        this.addStripper(new xo_strip_special_char(this));
    break;

    case "strip_white_space" :
        this.addStripper(new xo_strip_white_space(this));
    break;

    case "balloon" :
        this.addAssistant(new xo_balloon(this));
    break;

    case "status_bar" :
        this.addAssistant(new xo_status_bar(this));
    break;

    case "auto_focus" :
         this.onkeyup = ee_on_key_up;
    break;


    default :
    break;

}

}

/////////////////////////////////////////////////////////
// 메소드명 : element.addStripper(stripperObj)
// 대상객체 : element 객체 (this)
// 파라메터 : stripperObj : element에 붙을 Stripper 객체
// 내    용 : 주어진 Stripper 객체를 element에 등록한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_add_stripper(stripperObj)
{
  this.strippers[this.strippers.length] = stripperObj;
}

/////////////////////////////////////////////////////////
// 메소드명 : element.addAssistant(assistantObj)
// 대상객체 : element 객체 (this)
// 파라메터 : assistantObj : element에 붙을 assistant 객체
// 내    용 : 주어진 assistant 객체를 element에 등록한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_add_assistant(assistantObj)
{
  this.assistants[this.assistants.length] = assistantObj;
}

////////////////////////////////////////////////////////////////////////////////////////////////
///
///   element 객체 메소드 - UI-Contoller Method
///
////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////
// 메소드명 : element.uicCss(attr)
// 대상객체 : element 객체 (this)
// 파라메터 : attr : element에 적용할 CSS Class_name
// 내    용 : 주어진 CSS Class_name을 element에 적용한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_uic_css(attr)
{
  if (!this.isAttrValue("className") ) {
    this.setAttribute("className", attr);
    return;
  }

  var old_class = this.getAttribute("className");

  if (old_class.indexOf(attr) == -1 )
    this.setAttribute("className", old_class + " " + attr);
}



/////////////////////////////////////////////////////////
// 메소드명 : element.uicFilter(filter)
// 대상객체 : element 객체 (this)
// 파라메터 : filter : element에 적용할 Filter Reg Exp.
// 내    용 : 기존 filter가 없다면 주어진 filter를 element에 세팅하고
//            onkeypress 이벤트를 redirect한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_uic_filter(filter)
{
   if (this.xjs_filter) return;

   this.xjs_filter = filter;
   this.onkeypress = ee_on_key_press;
}


/////////////////////////////////////////////////////////
// 메소드명 : element.uicMask(mask, maskHdl, unmaskHdl, maskStripHdl)
// 대상객체 : element 객체 (this)
// 파라메터 : mask, maskHdl, unmaskHdl, maskStripHdl (역순으로 생략가능)
//           mask          : element에 적용할 mask Reg Exp.
//           maskHdl       : element에 적용할 masking method - default : em_masking
//           unmaskHdl     : element에 적용할 masking method - default : em_unMasking
//           maskStripHdl  : element에 적용할 masking method - default : null
// 내    용 : 주어진 mask를 element에 세팅하고
//            masking handler를 등록한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_uic_mask(mask, maskHdl, unmaskHdl, maskStripHdl)
{
  if (this.xjs_mask) return;

  this.xjs_mask = mask;

  this.masking     = (maskHdl) ? maskHdl : em_masking;
  this.unMasking   = (unmaskHdl) ? unmaskHdl : em_unMasking;
  this.maskStriper = maskStripHdl ? maskStripHdl : null ; //unmasking값과 실제 넘겨야 할 값이 다른 경우를 대비(reserved).

}


////////////////////////////////////////////////////////////////////////////////////////////////
///
///   element 객체 메소드 - UI-Contoller Event Redirector
///
////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////
// 메소드명 : element.masking()
// 대상객체 : element 객체 (this)
// 내    용 : 일반적인 masking을 담당한다.
// 작 성 자 : 김성조 -> 신택규
//////////////////////////////////////////////////////////
function em_masking() {

 if (!this.xjs_mask) return;

 var sStr = this.value.replace( /(\/|\$|\^|\*|\(|\)|\+|\.|\?|\\|\{|\}|\||\[|\]|-|:)/g,"");
 var tStr="";
 var idx;
 var jdx=0;
 var tLen = sStr.length +1 ;

 for(var idx=0; idx< sStr.length; idx++){
     tStr += sStr.charAt(idx);
     jdx++;
     if (jdx < this.xjs_mask.length && this.xjs_mask.charAt(jdx)!="9") tStr += this.xjs_mask.charAt(jdx++);
 }

 this.value = tStr;

}

/////////////////////////////////////////////////////////
// 메소드명 : element.masking()
// 대상객체 : element 객체 (this)
// 내    용 : money에 관련된 masking을 담당한다.
// 작 성 자 : 김성조 -> 신택규
//////////////////////////////////////////////////////////
function em_money_masking() {

  var sMoney = this.value.replace(/,/g,"");
  var tMoney = "";
  var i;
  var j=0;
  var tLen =sMoney.length;

  if (tLen <= 3 ) return ;

  for(i=0;i<tLen;i++){
    if (i!=0 && ( i % 3 == tLen % 3) ) tMoney += ",";
    if(i < tLen ) tMoney += sMoney.charAt(i);
  }

  this.value = tMoney;
}

/////////////////////////////////////////////////////////
// 메소드명 : element.masking()
// 대상객체 : element 객체 (this)
// 내    용 : dollar에 관련된 masking을 담당한다.
// 작 성 자 : 김성조 -> 신택규
//////////////////////////////////////////////////////////
function em_dollar_masking() {

  var sMoney = this.value.replace(/(\,|\.)/g,"");

  if ( sMoney.length <= 2 ) return sMoney;

  var fir_sMoney = sMoney.substr(0, sMoney.length - 2);
  var sec_sMoney = sMoney.substr(sMoney.length - 2, 2);

  var tMoney="";
  var i;
  var j=0;
  var tLen =fir_sMoney.length;

  if (fir_sMoney.length <= 3 ) return fir_sMoney + "." + sec_sMoney;

  for(i=0;i<tLen;i++){
    if (i!=0 && ( i % 3 == tLen % 3) )     tMoney += ",";
    if(i < fir_sMoney.length ) tMoney += fir_sMoney.charAt(i);
  }

  this.value = tMoney + "." + sec_sMoney;

}

/////////////////////////////////////////////////////////
// 메소드명 : element.unMasking()
// 대상객체 : element 객체 (this)
// 내    용 : element에 관련된 masking을 제거한다.
// 작 성 자 : 김성조 -> 신택규
//////////////////////////////////////////////////////////
function em_unMasking() {

// if (!this.xjs_mask || this.vaue =="") return;
 if (this.vaue =="") return;
  this.value = this.value.replace(/(\,|\.|\-|\/)/g,"");

}

///////////////////////////////////////////////////////////////////////////////////////////////
///
///   UI-Contoll User 객체 & 메소드 (stripper)
///
////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////
// 객 체 명 : xo_trim(parent) (trim - trailing space 제거)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 trim UIC 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_trim(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "trim";
    this.xjs_value = parent.getAttribute(this.xjs_key);

    //validation method
    this.stripping = xm_trim_stripping;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_trim.stripping()
// 대상객체 : this : UIC 객체 (xo_trim)
// 내    용 : 대상  element의 UIC객체로서의 stripping을 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_trim_stripping()
{
  if (!this.parent.value) return ; //입력값 없는 경우는 Pass

  switch (this.xjs_value) {

      case "left" :
        tsTarget = this.parent.value.replace(/^\s*/,"");
      break;

      case "right" :
        tsTarget = this.parent.value.replace(/\s*$/,"");
      break;

      default :
        tsTarget = this.parent.value.replace(/^\s*/ ,"").replace(/\s*$/ ,"");
      break;
  }

  this.parent.value = tsTarget;

}

/////////////////////////////////////////////////////////
// 객 체 명 : xo_strip_special_char(parent)
//              (strip_special_char - special_char 제거)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 strip_special_char UIC 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_strip_special_char(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "strip_special_char";

    //validation method
    this.stripping = xm_special_char_stripping;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_strip_special_char.stripping()
// 대상객체 : this : UIC 객체 (xo_strip_special_char)
// 내    용 : 대상  element의 UIC객체로서의 stripping을 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_special_char_stripping()
{
  if (!this.parent.value) return ; //입력값 없는 경우는 Pass

  var specialRegExp = XJSV_DEFAULT_SPECIAL_CHAR;
  tsTarget = this.parent.value.replace(specialRegExp,"");

  this.parent.value = tsTarget;
}

/////////////////////////////////////////////////////////
// 객 체 명 : xo_strip_white_space(parent)
//             (strip_white_space - trailing space 제거)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 strip_white_space UIC 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_strip_white_space(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "strip_white_space";

    //validation method
    this.stripping = xm_white_space_stripping;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_strip_white_space.stripping()
// 대상객체 : this : UIC 객체 (xo_strip_white_space)
// 내    용 : 대상  element의 UIC객체로서의 stripping을 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_white_space_stripping()
{
  if (!this.parent.value) return ; //입력값 없는 경우는 Pass

  var whiteSpaceRegExp = XJSV_DEFAULT_WHITE_SPACE;
  tsTarget = this.parent.value.replace(whiteSpaceRegExp, "");

  this.parent.value = tsTarget;

}

///////////////////////////////////////////////////////////////////////////////////////////////
///
///   UI-Contoll User 객체 & 메소드 (assistant)
///
////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////
// 객 체 명 : xo_balloon(parent) (balloon - 풍선도움말)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 balloon UIC 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_balloon(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "balloon";
    this.xjs_value = parent.getAttribute(this.xjs_key);
    this.xjs_skin = parent.getAttribute("balloon_skin");

    //validation method
    this.show = xm_balloon_show;
    this.kill = xm_balloon_kill;
    this.getSkin = xm_balloon_get_skin;
}

/////////////////////////////////////////////////////////
// 메소드명 : xo_balloon.show()
// 대상객체 : this : UIC 객체 (xo_balloon)
// 내    용 : 대상  element의 UIC객체로서의 show 한다.
// 작 성 자 : ???? -> 신택규
//////////////////////////////////////////////////////////
function xm_balloon_show()
{

  if ( xjs_balloon_dek.visibility =="visible" ) return;

  if (!xjs_is_old_nav) {

    xjs_balloon_yyy = xjs_balloon_Yoffset;

    if (xjs_is_nav) {
      xjs_balloon_dek.document.write(this.getSkin(this.xjs_value));
      xjs_balloon_dek.document.close();
      xjs_balloon_dek.visibility="visible"
    }

    if (xjs_is_iex) {
      document.all("xjs_dek").innerHTML = (this.getSkin(this.xjs_value));
      xjs_balloon_dek.visibility="visible";
     }

  } else {// if (xjs_is_old_nav)
    alert(msg);
    return;
  }
}

/////////////////////////////////////////////////////////
// 메소드명 : xo_balloon.kill()
// 대상객체 : this : UIC 객체 (xo_balloon)
// 내    용 : 대상  element의 UIC객체로서의 kill 한다.
// 작 성 자 : ???? -> 신택규
//////////////////////////////////////////////////////////
function xm_balloon_kill()
{
  if (xjs_balloon_dek.visibility == "hidden" ) return;

  if (!xjs_is_old_nav) {
    xjs_balloon_yyy=-1000;
    xjs_balloon_dek.visibility="hidden";
  }
}

/////////////////////////////////////////////////////////
// 메소드명 : xo_balloon.getSkin()
// 대상객체 : this : UIC 객체 (xo_balloon)
// 리 턴 값 : string : 테이블을 포함한 balloon skin(html)
// 내    용 : 대상  element의 UIC객체로서의 balloon skin을 리턴한다.
// 작 성 자 : ???? -> 신택규
//////////////////////////////////////////////////////////
function xm_balloon_get_skin(content)
{
  
  var default_skin = false;
  var skin_index = 0;
 
  var dir = XJSV_DEFAULT_SKIN_DIR;
  var skin = new Array ( new Array(dir+"bar01a.gif", dir+"bar01b.gif", dir+"bar01c.gif"),
                                                 new Array(dir+"bar01a.gif", dir+"bar01b.gif", dir+"bar01c.gif"),
                                                 new Array(dir+"bar02a.gif", dir+"bar02b.gif", dir+"bar02c.gif"),
                                                 new Array(dir+"bar03a.gif", dir+"bar03b.gif", dir+"bar03c.gif"),
                                                 new Array(dir+"bar04a.gif", dir+"bar04b.gif", dir+"bar04c.gif"),
                                                 new Array(dir+"bar05a.gif", dir+"bar05b.gif", dir+"bar05c.gif"),
                                                 new Array(dir+"bar06a.gif", dir+"bar06b.gif", dir+"bar06c.gif"),
                                                 new Array(dir+"bar07a.gif", dir+"bar07b.gif", dir+"bar07c.gif"),
                                                 new Array(dir+"bar08a.gif", dir+"bar08b.gif", dir+"bar08c.gif"),
                                                 new Array(dir+"bar09a.gif", dir+"bar09b.gif", dir+"bar09c.gif"),
                                                 new Array(dir+"bar10a.gif", dir+"bar10b.gif", dir+"bar10c.gif")
                                                 );

    if (this.xjs_skin) {
        var skin_index = parseInt(this.xjs_skin.substring(4,6),10);
        if ( skin_index <= 0 || skin_index > skin.length) default_skin = true;
    } else { default_skin = true; }

    if (default_skin) {
      content = "<TABLE BORDER=1 CELLPADDING=2 CELLSPACING=0  bgcolor='" + XJSV_BALLOON_BGCOLOR + "' > " +
              "<TR><TD ALIGN=left nowrap>" +
              "<font color='" +  XJSV_BALLOON_FORECOLOR + "'>" +
              content +
              "</font>" +
              "</TD></TR>" +
              "</TABLE>";
  } else { //has skin
      content = "<table border='0' cellspacing='0' cellpadding='0' bgcolor='" + XJSV_BALLOON_BGCOLOR + "' > " +
            "<tr><td align='right'><img src='"+ skin[skin_index][0] +"'></td>" +
            "<td background='"+ skin[skin_index][1] +"' nowrap>" +
            "<font color='" +  XJSV_BALLOON_FORECOLOR + "'>" +
            content + 
            "</font>" +
            "</td>" +
            "<td ><img src='"+ skin[skin_index][2] +"'></td></tr>" +
            "</table>";      
  }        
    
  return content;
}

/////////////////////////////////////////////////////////
// 객 체 명 : xo_status_bar(parent) (status_bar - 상태바)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 status_bar UIC 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_status_bar(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "status_bar";
    this.xjs_value = parent.getAttribute(this.xjs_key);

    //validation method
    this.show = xm_status_bar_show;
    this.kill = xm_status_bar_kill;
}

/////////////////////////////////////////////////////////
// 메소드명 : xo_status_bar.show()
// 대상객체 : this : UIC 객체 (xo_status_bar)
// 내    용 : 대상  element의 UIC객체로서의 show 한다.
// 작 성 자 : ???? -> 신택규
//////////////////////////////////////////////////////////
function xm_status_bar_show()
{
  window.status = this.xjs_value ;
}

/////////////////////////////////////////////////////////
// 메소드명 : xo_status_bar.kill()
// 대상객체 : this : UIC 객체 (xo_status_bar)
// 내    용 : 대상  element의 UIC객체로서의 kill 한다.
// 작 성 자 : ???? -> 신택규
//////////////////////////////////////////////////////////
function xm_status_bar_kill()
{
  window.status = "" ;

}


////////////////////////////////////////////////////////////////////////////////////////////////
///
///   element 객체 메소드 - Validator Factory
///
////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////
// 메소드명 : element.validatorFactory()
// 대상객체 : element 객체 (this)
// 내    용 : 대상  element의 type과 주어진 attribute에 따라 필요한
//            Validator를 사용 가능하게 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function  em_validator_factory()
{
    switch (this.type) {

      case "text" :
        if ( this.isAttribute("required") )   this.enableValidator("required");
        if ( this.isAttrValue("minlength") )  this.enableValidator("minlength");
        if ( this.isAttrValue("minvalue") )       this.enableValidator("minvalue");
        if ( this.isAttrValue("maxvalue") )       this.enableValidator("maxvalue");
        if ( this.isAttrValue("minbyte") )  this.enableValidator("minbyte");
        if ( this.isAttrValue("maxbyte") )  this.enableValidator("maxbyte");
        if ( this.isAttribute("alphabetic") )       this.enableValidator("alphabetic");
        if ( this.isAttribute("numeric") )       this.enableValidator("numeric");
        if ( this.isAttribute("alpha_numeric") )       this.enableValidator("alpha_numeric");
        if ( this.isAttribute("integer") )       this.enableValidator("integer");
        if ( this.isAttribute("float") )       this.enableValidator("float");
        if ( this.isAttribute("hexa") )       this.enableValidator("hexa");
        if ( this.isAttribute("date") )       this.enableValidator("date");
        if ( this.isAttribute("psn") )       this.enableValidator("psn");
        if ( this.isAttribute("csn") )       this.enableValidator("csn");
        if ( this.isAttribute("email") )       this.enableValidator("email");
        if ( this.isAttribute("advanced_email") ) this.enableValidator("advanced_email");
        if ( this.isAttribute("domain") )       this.enableValidator("domain");
        if ( this.isAttribute("credit_card") )       this.enableValidator("credit_card");
        if ( this.isAttrValue("mask") )       this.enableValidator("mask");
        if ( this.isAttrValue("reg_exp") )       this.enableValidator("reg_exp");
        if ( this.isAttrValue("is_value") )       this.enableValidator("is_value");
      break;

      case "password" :
        if ( this.isAttribute("required") )   this.enableValidator("required");
        if ( this.isAttrValue("minlength") )  this.enableValidator("minlength");
        if ( this.isAttrValue("minlength") )  this.enableValidator("minlength");
        if ( this.isAttrValue("minvalue") )       this.enableValidator("minvalue");
        if ( this.isAttrValue("maxvalue") )       this.enableValidator("maxvalue");
        if ( this.isAttrValue("minbyte") )  this.enableValidator("minbyte");
        if ( this.isAttrValue("maxbyte") )  this.enableValidator("maxbyte");
        if ( this.isAttribute("alphabetic") )       this.enableValidator("alphabetic");
        if ( this.isAttribute("numeric") )       this.enableValidator("numeric");
        if ( this.isAttribute("alpha_numeric") )       this.enableValidator("alpha_numeric");
        if ( this.isAttribute("integer") )       this.enableValidator("integer");
        if ( this.isAttribute("float") )       this.enableValidator("float");
        if ( this.isAttribute("hexa") )       this.enableValidator("hexa");
        if ( this.isAttribute("psn") )       this.enableValidator("psn");
        if ( this.isAttribute("csn") )       this.enableValidator("csn");
        if ( this.isAttribute("credit_card") )       this.enableValidator("credit_card");
        if ( this.isAttrValue("reg_exp") )       this.enableValidator("reg_exp");
        if ( this.isAttrValue("is_value") )       this.enableValidator("is_value");
      break;

      case "textarea" :
        if ( this.isAttribute("required") )   this.enableValidator("required");
        if ( this.isAttrValue("minlength") )  this.enableValidator("minlength");
        if ( this.isAttrValue("minbyte") )  this.enableValidator("minbyte");
        if ( this.isAttrValue("maxbyte") )  this.enableValidator("maxbyte");
        
      break;

      case "checkbox" :
      case "file" :
        if ( this.isAttribute("required") )   this.enableValidator("required");
      break;

      default :
      break;
    }
}


/////////////////////////////////////////////////////////
// 메소드명 : element.enableValidator(xjs_key)
// 대상객체 : element 객체 (this)
// 파라메터 : xjs_key : 주어진 validator용 attribute
// 내    용 : 주어진 attribute에 따라 필요한 Validator를 element에 등록한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_enable_validator(xjs_key)
{
  switch(xjs_key)
  {

    case "required" : //means "required" willbe activate
        this.addValidator(new xo_required(this));
    break;

    case "minlength" :
        this.addValidator(new xo_min_length(this));

    case "minvalue" :
        this.addValidator(new xo_min_value(this));
    break;

    case "maxvalue" :
        this.addValidator(new xo_max_value(this));
    break;

    case "minbyte" :
        this.addValidator(new xo_min_byte(this));
    break;

    case "maxbyte" :
        this.addValidator(new xo_max_byte(this));
    break;

    case "alphabetic" :
        this.addValidator(new xo_alphabetic(this));
    break;

    case "numeric" :
        this.addValidator(new xo_numeric(this));
    break;

    case "alpha_numeric" :
        this.addValidator(new xo_alpha_numeric(this));
    break;

    case "integer" :
        this.addValidator(new xo_integer(this));
    break;

    case "float" :
        this.addValidator(new xo_float(this));
    break;

    case "hexa" :
        this.addValidator(new xo_hexa(this));
    break;

    case "date" :
        if ( !this.isAttrValue("mask") ) this.addValidator(new xo_mask(this, XJSV_DEFAULT_DATE_MASK));
        this.addValidator(new xo_date(this));
    break;

    case "psn" :
        if ( !this.isAttrValue("mask") ) this.addValidator(new xo_mask(this, XJSV_DEFAULT_PSN_MASK));
        this.addValidator(new xo_psn(this));
    break;

    case "csn" :
        if ( !this.isAttrValue("mask") ) this.addValidator(new xo_mask(this, XJSV_DEFAULT_CSN_MASK));
        this.addValidator(new xo_csn(this));
    break;

    case "email" :
        this.addValidator(new xo_email(this));
    break;

    case "advanced_email" :
        this.addValidator(new xo_advanced_email(this));
    break;

    case "domain" :
        this.addValidator(new xo_domain(this));
    break;

    case "credit_card" :
        this.addValidator(new xo_credit_card(this));
    break;

    case "mask" :
        this.addValidator(new xo_mask(this));
    break;

    case "reg_exp" :
        this.addValidator(new xo_reg_exp(this));
    break;

    case "reg_exp" :
        this.addValidator(new xo_reg_exp(this));
    break;

    case "is_value" :
        this.addValidator(new xo_is_value(this));
    break;

    default :
    break;

  }
}

/////////////////////////////////////////////////////////
// 메소드명 : element.addValidator(validatorObj)
// 대상객체 : element 객체 (this)
// 파라메터 : validatorObj : element에 붙을 validator 객체
// 내    용 : 주어진 validator 객체를 element에 등록한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function em_add_validator(validatorObj)
{
  this.validators[this.validators.length] = validatorObj;
}

///////////////////////////////////////////////////////////////////////////////////////////////
///
///   Validation User 객체 & 메소드 (validator)
///
////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////
// 객 체 명 : xo_required(parent) (required - 필수입력)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 필수입력 validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_required(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "required";

    //validation method
    this.validate = xm_required_validate;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_required.validate()
// 대상객체 : this : validator 객체 (xo_required)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_required_validate()
{
  var flag = true; //true when validation successful.
  var msg = "";

  var regExp_whiteSpace = /^[\s]*$/;

  if (!this.parent.value)
    flag = false;

  if(XJSV_REQUIRED_IGNORE_WHITESPACE && regExp_whiteSpace.test(this.parent.value))
    flag = false;

  if (this.parent.type == "checkbox" && !this.parent.checked )
    flag = false;

 //Validation Logic for required!
  if (!flag) {
    msg = "필수입력입니다";
    this.setMessage(msg);
    if(XJSV_REQUIRED_IGNORE_WHITESPACE)
      this.parent.value = this.parent.value.replace( /(\s)/g,"");
  }

  return flag;

}

/////////////////////////////////////////////////////////
// 객 체 명 : xo_min_length(parent) (minlength - 최소자리수 체크)
// 대상객체 : this : validator 객체 (xo_min_length)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 minlength validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_min_length(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "minlength";
    this.xjs_value = parent.getAttribute(this.xjs_key);

    //validation method
    this.validate = xm_min_length_validate;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_min_length.validate()
// 대상객체 : this : validator 객체 (xo_min_length)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_min_length_validate()
{
  var flag = true; //true when validation successful.
  var msg = "";

  if (!this.parent.value) return flag; //입력값 없는 경우는 Pass

  var tsTarget = this.parent.value;

  //Validation Logic for Min Legnth..
  if (tsTarget.length <  this.xjs_value ) {
    flag = false;
    msg = "입력된 항목의 자릿수가 너무 작습니다. \n최소 " + this.xjs_value + "자리이상입니다.";
    this.setMessage(msg);
  }

  return flag;

}


/////////////////////////////////////////////////////////
// 객 체 명 : xo_min_byte(parent) (minbyte - 최소byte 체크)
// 대상객체 : this : validator 객체 (xo_min_byte)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 minbyte validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_min_byte(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "minbyte";
    this.xjs_value = parent.getAttribute(this.xjs_key);

    //validation method
    this.validate = xm_min_byte_validate;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_min_byte.validate()
// 대상객체 : this : validator 객체 (xo_min_byte)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_min_byte_validate()
{
  var flag = true; //true when validation successful.
  var msg = "";

  if (!this.parent.value) return flag; //입력값 없는 경우는 Pass

  var tsTarget = this.parent.getByte();

  //Validation Logic for Min Legnth..
  if (tsTarget <  this.xjs_value ) {
    flag = false;
    msg = "입력된 항목의 자릿수가 너무 작습니다. \n최소 " + this.xjs_value + "자리이상입니다.";
    msg += "\n (한글 한글자를 2자리로 계산)";
        this.setMessage(msg);
  }

  return flag;

}


/////////////////////////////////////////////////////////
// 객 체 명 : xo_max_byte(parent) (maxbyte - 최소byte 체크)
// 대상객체 : this : validator 객체 (xo_max_byte)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 maxbyte validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_max_byte(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "maxbyte";
    this.xjs_value = parent.getAttribute(this.xjs_key);

    //validation method
    this.validate = xm_max_byte_validate;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_max_byte.validate()
// 대상객체 : this : validator 객체 (xo_max_byte)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_max_byte_validate()
{
  var flag = true; //true when validation successful.
  var msg = "";

  if (!this.parent.value) return flag; //입력값 없는 경우는 Pass

  var tsTarget = this.parent.getByte();

  //Validation Logic for max Legnth..
  if (tsTarget >  this.xjs_value ) {
    flag = false;
    msg = "입력된 항목의 자릿수가 너무 큽니다. \n최대 " + this.xjs_value + "자리이하 입니다.";
    msg += "\n (한글 한글자를 2자리로 계산)";
        this.setMessage(msg);
  }

  return flag;

}



/////////////////////////////////////////////////////////
// 객 체 명 : xo_min_value(parent) (minvalue - 최소값 체크)
// 대상객체 : this : validator 객체 (xo_min_value)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 minvalue validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_min_value(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "minvalue";
    this.xjs_value = parent.getAttribute(this.xjs_key);

    //validation method
    this.validate = xm_min_value_validate;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_min_value.validate()
// 대상객체 : this : validator 객체 (xo_min_value)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_min_value_validate()
{
  var flag = true; //true when validation successful.
  var msg = "";

  if (!this.parent.value) return flag; //입력값 없는 경우는 Pass

  var tsTarget = parseFloat(this.parent.value);

  //Validation Logic for Min Legnth..
  if (tsTarget <  this.xjs_value ) {
    flag = false;
    msg = "입력된 항목의 값이 너무 작습니다. ";
    msg += "\n현재값은 " + parseFloat(this.parent.value) + " 입니다. ";
    msg += "\n최소 " + this.xjs_value + " 이상의 값이라야 합니다.  ";
        
        this.setMessage(msg);
  }

  return flag;

}

/////////////////////////////////////////////////////////
// 객 체 명 : xo_max_value(parent) (maxvalue - 최대값 체크)
// 대상객체 : this : validator 객체 (xo_max_value)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 maxvalue validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_max_value(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "maxvalue";
    this.xjs_value = parent.getAttribute(this.xjs_key);

    //validation method
    this.validate = xm_max_value_validate;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_max_value.validate()
// 대상객체 : this : validator 객체 (xo_max_value)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_max_value_validate()
{
  var flag = true; //true when validation successful.
  var msg = "";

  if (!this.parent.value) return flag; //입력값 없는 경우는 Pass

//  var tsTarget = this.parent.value;
  var tsTarget = parseFloat(this.parent.value);

  //Validation Logic for max Legnth..
  if (tsTarget >  this.xjs_value ) {
    flag = false;
    msg = "입력된 항목의 값이 너무 큽니다. ";
    msg += "\n현재값은 " + parseFloat(this.parent.value) + " 입니다. ";
    msg += "\n최대 " + this.xjs_value + " 이하의 값이라야 합니다.  ";

    this.setMessage(msg);
  }

  return flag;

}

/////////////////////////////////////////////////////////
// 객 체 명 : xo_mask(parent, defaultMask) (mask - 마스크)
// 대상객체 : this : validator 객체 (xo_mask)
// 파라메터 : parent : 부모 객체 (element 객체)
//            defaultMask : 디폴트로 사용할 마스크 - 없으면 mask attribute 값을 가져온다.
// 내    용 : element객체에 등록될 mask validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_mask(parent, defaultMask)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "mask";
    this.xjs_value = (defaultMask) ?
        defaultMask : parent.getAttribute(this.xjs_key) ;

    this.parent.xjs_mask  = this.xjs_value; //important!

    //validation method
    this.validate = xm_mask_validate;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;
}

/////////////////////////////////////////////////////////
// 메소드명 : xo_mask.validate()
// 대상객체 : this : validator 객체 (xo_mask)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 김성조 -> 신택규
//////////////////////////////////////////////////////////
function xm_mask_validate()
{

  var flag = true; //true when validation successful.
  var msg = "";

  if (!this.parent.value) return flag; //입력값아 없는 경우 Pass

  if (!this.xjs_value) return flag;    //등록된 Mask가 없는 경우 Pass

  if (this.parent.unMasking) this.parent.unMasking();  //Validate를 위해서 Remasking한다.
  if (this.parent.masking) this.parent.masking();

  //Validation Logic for Mask..
  var sPattern=this.parent.xjs_mask.replace(/(\$|\^|\*|\(|\)|\+|\.|\?|\\|\{|\}|\||\[|\])/g,"\\$1");
      sPattern=sPattern.replace(/9/g ,"\\d");
      sPattern=sPattern.replace(/x/ig,".");
      sPattern=sPattern.replace(/z/ig,"\\d?");
      sPattern=sPattern.replace(/a/ig,"[A-Za-z]");

  var re=new RegExp("^"+sPattern+"$");

  if(!re.test(this.parent.value))  {
    flag = false;
    msg = "잘못된입력입니다 \n " + this.xjs_value + "형식이어야 합니다.";
    this.setMessage(msg);
  }

  return flag;
}


/////////////////////////////////////////////////////////
// 객 체 명 : xo_date(parent) (date - 날짜체크)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 date validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_date(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "date";

    //validation method
    this.validate = xm_date_validate;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_date.validate()
// 대상객체 : this : validator 객체 (xo_date)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 김성조 -> 신택규
//////////////////////////////////////////////////////////
function xm_date_validate()
{
  var flag = true; //true when validation successful.
  var msg = "";

  if (!this.parent.value) return flag; //입력값이 없는 경우는 Pass

  //Validation Logic for Date..
  var iYear = null;
  var iMonth = null;
  var iDay = null;
  var iDaysInMonth = null;

  var sDate=this.parent.value.replace(/(\,|\.|\-|\/)/g,"");
  var sFormat="YYYYMMDD";  //아직까지 YYYYMMDD의 형태만 지원한다. --;
  var aDaysInMonth=new Array(31,28,31,30,31,30,31,31,30,31,30,31);

  //완전한 날짜의 입력이 들어온 경우이다.
  if ( sDate.length != 8 ) flag = false ;

  if (flag) {
    iYear  = eval(sDate.substr(0,4));
    iMonth = eval(sDate.substr(4,2));
    iDay   = eval(sDate.substr(6,2));
    if (!isNum(iYear) || !isNum(iMonth) || !isNum(iDay) )
      flag = false ;
  }

  if (flag) {
     iDaysInMonth = (iMonth != 2) ? aDaysInMonth[iMonth-1] : (( iYear%4 == 0 && iYear%100 != 0 || iYear % 400==0 ) ? 29 : 28 );
     if( iDay==null || iMonth==null || iYear==null  || iMonth > 12 || iMonth < 1 || iDay < 1 || iDay > iDaysInMonth )
      flag = false ;
  }


  if (!flag) {
    msg = "날짜입력이 잘못되었습니다.";
    this.setMessage(msg);
  }

  return flag;
}


/////////////////////////////////////////////////////////
// 객 체 명 : xo_psn(parent) (psn - 주민등록 번호 체크)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 psn validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_psn(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "psn";

    //validation method
    this.validate = xm_psn_validate;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;

}


/////////////////////////////////////////////////////////
// 메소드명 : xo_psn.validate()
// 대상객체 : this : validator 객체 (xo_psn)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_psn_validate()
{
  var flag = true; //true when validation successful.
  var msg = "";
  var sum = 0;

  if (!this.parent.value) return flag; //입력값이 없는 경우는 Pass

  var psNumber = this.parent.value.replace(/(\,|\.|\-|\/)/g,"");

  for (idx = 0, jdx=2; jdx < 10; idx++, jdx++) {
    sum = sum + ( psNumber.charAt(idx) * jdx );
  }

  for (idx = 8, jdx=2; jdx < 6; idx++, jdx++) {
    sum = sum + ( psNumber.charAt(idx) * jdx );
  }

  var nam = sum % 11;
  var checkDigit = 11 - nam ;

  checkDigit = (checkDigit >= 10 ) ? checkDigit-10:checkDigit;

  if ( !isNum(psNumber) || psNumber.charAt(12) != checkDigit)  {
    flag = false;
    msg = "입력한 주민등록번호가 잘못되었습니다.";
    this.setMessage(msg);
  }

  return flag;
}

/////////////////////////////////////////////////////////
// 객 체 명 : xo_csn(parent) (csn - 사업자 등록 번호 체크)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 csn validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_csn(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "csn";

    //validation method
    this.validate = xm_csn_validate;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_csn.validate()
// 대상객체 : this : validator 객체 (xo_csn)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_csn_validate()
{
  var flag = true; //true when validation successful.
  var msg = "";
  var sum = 0;

  if (!this.parent.value) return flag; //입력값이 없는 경우는 Pass

  var csNumber = this.parent.value.replace(/(\,|\.|\-|\/)/g,"");
  var checkArray = new Array(1,3,7,1,3,7,1,3,5);

  for(idx=0 ; idx < 9 ; idx++)
    sum += csNumber.charAt(idx) * checkArray[idx];

  sum = sum + ((csNumber.charAt(8) * 5 ) / 10);

  var nam = Math.floor(sum) % 10;

  var checkDigit = ( nam == 0 ) ? 0 : 10 - nam;

  if ( !isNum(csNumber) || csNumber.charAt(9) != checkDigit)  {
    flag = false;
    msg = "입력한 사업자 등록번호가 잘못되었습니다.";
    this.setMessage(msg);
  }

  return flag;
}

/////////////////////////////////////////////////////////
// 객 체 명 : xo_advanced_email(parent) (advanced_email - 고급 Email 체크)
// 대상객체 : this : validator 객체 (xo_advanced_email)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 advanced_email validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_advanced_email(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "advanced_email";
    this.xjs_value = parent.getAttribute(this.xjs_key);

    //validation method
    this.validate = xm_advanced_email_validation;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_advanced_email.validate()
// 대상객체 : this : validator 객체 (xo_advanced_email)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_advanced_email_validation()
{
  //this core script from http://javascript.internet.com/forms/email-address-validation.html
  //customize by TKshin.

  var flag = true;
  var msg = "";

  if (!this.parent.value) return flag; //입력값 없는 경우는 Pass

  //Validation Logic for email
  var checkTLD=1;  //wether check well-known domain & two-letter contry domain
  var knownDomsPat=/^(com|net|org|edu|int|mil|gov|arpa|biz|aero|name|coop|info|pro|museum)$/;
  var emailPat=/^(.+)@(.+)$/;
  var specialChars="\\(\\)><@,;:\\\\\\\"\\.\\[\\]";
  var validChars="\[^\\s" + specialChars + "\]";
  var quotedUser="(\"[^\"]*\")";
  var ipDomainPat=/^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]$/;

  var atom=validChars + '+';

  var word="(" + atom + "|" + quotedUser + ")";
  var userPat=new RegExp("^" + word + "(\\." + word + ")*$");
  var domainPat=new RegExp("^" + atom + "(\\." + atom +")*$");

  var tsTarget = this.parent.value;

  var matchArray = tsTarget.match(emailPat);

  if (!matchArray) {
    msg = "이메일 형식에 맞지 않습니다. ";
    this.setMessage(msg);
    return false;
  }

  var user=matchArray[1];
  var domain=matchArray[2];

  for (i=0; i<user.length; i++)
    if (user.charCodeAt(i)>127) {
      msg = "이메일 형식에 맞지 않습니다. \n사용자 이름 부분에 invalid character가 있습니다. ";
      this.setMessage(msg);
      return false;
    }


  for (i=0; i<domain.length; i++)
    if (domain.charCodeAt(i)>127) {
      msg = "이메일 형식에 맞지 않습니다. \n도메인 이름 부분에 invalid character가 있습니다. ";
      this.setMessage(msg);
      return false;
    }

  if (!user.match(userPat)) { // user is not valid
     msg = "이메일 형식에 맞지 않습니다. \n사용자 이름 부분이 잘못되었습니다. ";
     this.setMessage(msg);
     return false;
  }

  // IP Address형태의 Email 체크  E.g. joe@[123.124.233.4] is a legal e-mail address */
  var IPArray=domain.match(ipDomainPat);
  if (IPArray) {
    for (var i=1;i<=4;i++)
      if (IPArray[i]>255) {
         msg = "이메일 형식에 맞지 않습니다. \nIP address 부분이 잘못되었습니다. ";
         this.setMessage(msg);
         return false;
      }
    return true;
  }

  // symbolic 형태의 Domain name 체크
  var atomPat=new RegExp("^" + atom + "$");
  var domArr=domain.split(".");
  var len=domArr.length;

  for (i=0;i<len;i++)
    if (domArr[i].search(atomPat)==-1) {
      msg = "이메일 형식에 맞지 않습니다. \nDomain name 부분이 잘못되었습니다. ";
      this.setMessage(msg);
      return false;
    }


  // TLD 체크
  if (checkTLD && domArr[domArr.length-1].length!=2 && domArr[domArr.length-1].search(knownDomsPat)==-1) {
      msg = "이메일 형식에 맞지 않습니다. \nDomain name이 알려진 도메인이 아닙니다. ";
      this.setMessage(msg);
      return false;
  }


  if (len<2) {
      msg = "이메일 형식에 맞지 않습니다. \nhost name이 없습니다.";
      this.setMessage(msg);
      return false;
  }

  return true;

}

/////////////////////////////////////////////////////////
// 객 체 명 : xo_email(parent) (email - simple Email 체크)
// 대상객체 : this : validator 객체 (xo_email)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 email validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_email(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "email";
    this.xjs_value = parent.getAttribute(this.xjs_key);

    //validation method
    this.validate = xm_email_validate;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_email.validate()
// 대상객체 : this : validator 객체 (xo_email)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_email_validate()
{
  //this core script from http://tech.irt.org/articles/js049/index.htm
  //customize by TKshin.

  var flag = true; //true when validation successful.
  var msg = "";

  if (!this.parent.value) return flag; //입력값 없는 경우는 Pass

  var tsTarget = this.parent.value;
  var regExpEmail = /^\w+((-|\.)\w+)*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]{2,4}$/;

  if(!regExpEmail.test(tsTarget)) {
    flag = false;
    msg = "이메일 형식이 아닙니다.";
    this.setMessage(msg);
  }

  return flag;

}

/////////////////////////////////////////////////////////
// 객 체 명 : xo_domain(parent) (domain - 도메인 주소 체크)
// 대상객체 : this : validator 객체 (xo_domain)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 domain validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_domain(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "domain";
    this.xjs_value = parent.getAttribute(this.xjs_key);

    //validation method
    this.validate = xm_domain_validate;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_domain.validate()
// 대상객체 : this : validator 객체 (xo_email)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_domain_validate()
{

  var flag = true; //true when validation successful.
  var msg = "";

  if (!this.parent.value) return flag; //입력값 없는 경우는 Pass

  var tsTarget = this.parent.value;
  var regExpDomain = /^[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]{2,4}$/;

  if(!regExpDomain.test(tsTarget)) {
    flag = false;
    msg = "도메인 형식이 잘못되었습니다.";
    this.setMessage(msg);
  }

  return flag;

}

/////////////////////////////////////////////////////////
// 객 체 명 : xo_float(parent) (float 체크)
// 대상객체 : this : validator 객체 (xo_float)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 float validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_float(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "float";

    //validation method
    this.validate = xm_float_validate;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_float.validate()
// 대상객체 : this : validator 객체 (xo_float)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_float_validate()
{

  var flag = true; //true when validation successful.
  var msg = "";

  if (!this.parent.value) return flag; //입력값 없는 경우는 Pass

  var tsTarget = this.parent.value;
  var regExp_Float1 = /^(\+|\-|\d*)\d+$/;
  var regExp_Float2 = /^(\-|\+|\d*)\d+(\.|\d)\d*$/;

  if(!regExp_Float1.test(tsTarget) && !regExp_Float2.test(tsTarget)) {
    flag = false;
    msg = "실수형식이 아닙니다.";
    this.setMessage(msg);
  }

  this.parent.value = parseFloat(tsTarget);

  return flag;

}

/////////////////////////////////////////////////////////
// 객 체 명 : xo_integer(parent) (integer 체크)
// 대상객체 : this : validator 객체 (xo_integer)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 integer validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_integer(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "integer";

    //validation method
    this.validate = xm_integer_validate;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_integer.validate()
// 대상객체 : this : validator 객체 (xo_integer)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_integer_validate()
{

  var flag = true; //true when validation successful.
  var msg = "";

  if (!this.parent.value) return flag; //입력값 없는 경우는 Pass

  var tsTarget = this.parent.value;

  var regExp_Integer = /^(\+|\-|\d*)\d+$/;

  if(!regExp_Integer.test(tsTarget)) {
    flag = false;
    msg = "정수형식이 아닙니다.";
    this.setMessage(msg);
  }

  this.parent.value = parseInt(tsTarget);

  return flag;

}

/////////////////////////////////////////////////////////
// 객 체 명 : xo_hexa(parent) (hexa 체크)
// 대상객체 : this : validator 객체 (xo_hexa)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 hexa validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_hexa(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "hexa";

    //validation method
    this.validate = xm_hexa_validate;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_hexa.validate()
// 대상객체 : this : validator 객체 (xo_hexa)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_hexa_validate()
{

  var flag = true; //true when validation successful.
  var msg = "";

  if (!this.parent.value) return flag; //입력값 없는 경우는 Pass

  var tsTarget = this.parent.value;

  var regExp_hexa = /^[a-fA-F0-9]+$/;
  if(!regExp_hexa.test(tsTarget)) {
    flag = false;
    msg = "16진수(Hexa)형식이 아닙니다.";
    this.setMessage(msg);
  }

  this.parent.value = parseInt(tsTarget, 16).toString(16);
  return flag;

}
/////////////////////////////////////////////////////////
// 객 체 명 : xo_alphabetic(parent) (alphabetic 체크)
// 대상객체 : this : validator 객체 (xo_alphabetic)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 alphabetic validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_alphabetic(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "alphabetic";

    //validation method
    this.validate = xm_alphabetic_validate;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;

}


/////////////////////////////////////////////////////////
// 메소드명 : xo_alphabetic.validate()
// 대상객체 : this : validator 객체 (xo_alphabetic)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_alphabetic_validate()
{

  var flag = true; //true when validation successful.
  var msg = "";

  if (!this.parent.value) return flag; //입력값 없는 경우는 Pass

  var tsTarget = this.parent.value;

  var regExp_alphabetic = /^[a-zA-Z]+$/;
  if(!regExp_alphabetic.test(tsTarget)) {
    flag = false;
    msg = "alphabetic형식이 아닙니다.";
    this.setMessage(msg);
  }

  return flag;

}
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 numeric validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_numeric(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "numeric";

    //validation method
    this.validate = xm_numeric_validate;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_numeric.validate()
// 대상객체 : this : validator 객체 (xo_numeric)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_numeric_validate()
{

  var flag = true; //true when validation successful.
  var msg = "";

  if (!this.parent.value) return flag; //입력값 없는 경우는 Pass

  var tsTarget = this.parent.value;

  var regExp_numeric = /^[-0-9]+$/;
  if(!regExp_numeric.test(tsTarget)) {
    flag = false;
    msg = "numeric 형식이 아닙니다.";
    this.setMessage(msg);
  }

  //this.parent.value = parseInt(tsTarget);

  return flag;

}
/////////////////////////////////////////////////////////
// 객 체 명 : xo_alpha_numeric(parent) (alpha_numeric 체크)
// 대상객체 : this : validator 객체 (xo_alpha_numeric)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 alpha_numeric validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_alpha_numeric(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "alpha_numeric";

    //validation method
    this.validate = xm_alpha_numeric_validate;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_alpha_numeric.validate()
// 대상객체 : this : validator 객체 (xo_alpha_numeric)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_alpha_numeric_validate()
{

  var flag = true; //true when validation successful.
  var msg = "";

  if (!this.parent.value) return flag; //입력값 없는 경우는 Pass

  var tsTarget = this.parent.value;

  var regExp_alpha_numeric = /^[a-zA-Z0-9]+$/;

  if(!regExp_alpha_numeric.test(tsTarget)) {
    flag = false;
    msg = "alphabetic 혹은 numeric 형식이 아닙니다.";
    this.setMessage(msg);
  }

  return flag;

}

/////////////////////////////////////////////////////////
// 객 체 명 : xo_credit_card(parent) (credit_card 체크)
// 대상객체 : this : validator 객체 (xo_credit_card)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 credit_card validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_credit_card(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "credit_card";

    //validation method
    this.validate = xm_credit_card_validate;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_credit_card.validate()
// 대상객체 : this : validator 객체 (xo_credit_card)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_credit_card_validate()
{

  var flag = true; //true when validation successful.
  var msg = "";

  if (!this.parent.value) return flag; //입력값 없는 경우는 Pass

  var tsTarget = this.parent.value;

  var sum = 0;
  var mul = 1;
  var len = tsTarget.length;

  // Encoding only works on cards with less than 19 digits
  if (len.length > 19)
    flag = false;

  for (var idx = 0; idx < len; idx++) {
    var digit = tsTarget.substring(len-idx-1,len-idx);
    var tproduct = parseInt(digit ,10)*mul;
    if (tproduct >= 10)
      sum += (tproduct % 10) + 1;
    else
      sum += tproduct;
    if (mul == 1)
      mul++;
    else
      mul--;
  }

  if ((sum % 10) != 0)
    flag = false;

  if(!flag) {
    msg = "Credit Card 번호 형식이 아닙니다.";
    this.setMessage(msg);
  }
  return flag;
}


/////////////////////////////////////////////////////////
// 객 체 명 : xo_reg_exp(parent) (reg_exp 체크)
// 대상객체 : this : validator 객체 (xo_reg_exp)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 regualr expression validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_reg_exp(parent)
{
    //constant data;
    this.parent = parent;
    this.xjs_key = "reg_exp";
    this.xjs_value = parent.getAttribute(this.xjs_key);

    //validation method
    this.validate = xm_reg_exp_validate;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;

}

/////////////////////////////////////////////////////////
// 메소드명 : xo_reg_exp.validate()
// 대상객체 : this : validator 객체 (xo_reg_exp)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_reg_exp_validate()
{

  var flag = true; //true when validation successful.
  var msg = "";

  if (!this.parent.value) return flag; //입력값 없는 경우는 Pass

  var tsTarget = this.parent.value;

  var regularExpression =new RegExp(this.xjs_value);

  //alert(regularExpression.source);

  if(!regularExpression.test(tsTarget)) {
    flag = false;
    msg = "Regular Expression 형식에 맞지 않습니다. \n형식이 " + this.xjs_value + "에 적합해야 합니다.";
    this.setMessage(msg);
  }

  return flag;

}

/////////////////////////////////////////////////////////
// 객 체 명 : xo_is_value(parent) (is_value - 동일값 체크)
// 파라메터 : parent : 부모 객체 (element 객체)
// 내    용 : element객체에 등록될 동일값 체크  validator 객체를 정의한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xo_is_value(parent)
{

    //constant data;
    this.parent = parent;
    this.xjs_key = "is_value";
    this.xjs_value = parent.getAttribute(this.xjs_key);

    //validation method
    this.validate = xm_is_value_validate;

    //Pseudo-inheritance Method
    this.setMessage = xm_common_message;


}

/////////////////////////////////////////////////////////
// 메소드명 : xo_is_value.validate()
// 대상객체 : this : validator 객체 (xo_is_value)
// 리 턴 값 : boolean(true / false)
// 내    용 : 대상  element의 validateor객체로서의 validate를 한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_is_value_validate()
{
  var flag = true; //true when validation successful.
  var msg = "";
  var compateItem = eval(this.xjs_value);

  if (typeof(compateItem) == "undefined") {
    msg = this.parent.name + "에서의 is_value 사용이 틀렸습니다. is_value에 해당하는 입력필드가 존재하지 않습니다.";
    this.setMessage(msg);
    return false;
    
  }
    
  if ( flag && this.parent.value != compateItem.value ) 
    flag = false;

 //Validation Logic for required!
  if (!flag) {
    msg = "입력한 값이 " + compateItem.name + "항목의 값과 틀립니다.";
    this.setMessage(msg);
  }

  return flag;
}

/////////////////////////////////////////////////////////
// 메소드명 : *.setMessage(msg)  (pseudo-inheritance)
// 대상객체 : this : validator 객체 (*)
// 파라메터 : msg  : 출력할 메세지
// 내    용 : 사용자에게 msg를 alert 박스형태로 보이고 배경색상을 노란색으로 변경한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function xm_common_message(msg)
{

  if ( this.parent.isAttribute("itemname") )
    msg = XJSV_MSG_PREFIX +  "항목명(" + this.parent.getAttribute("itemname") + ")\n" + msg;
  else
    msg = XJSV_MSG_PREFIX + msg;

  alert (msg);

  this.parent.style.backgroundColor = "yellow";

  this.parent.focus();

  return ;

}

////////////////////////////////////////////////////////////////////////////////////////////////
///
///   NON 객체 Utility 메소드
///
////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////
// 메소드명 : initializeXjsv()
// 내    용 : 모든 form의 initialize method를 호출한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function initializeXjsv()
{

  xjs_is_iex=(document.all);

  for ( var idx = 0 ; idx < document.forms.length ; idx++)  {
    document.forms[idx].initialize = ff_initialize;
    document.forms[idx].initialize();
  }

  //codes for balloon assistant
  document.writeln("<DIV ID='xjs_dek' CLASS='xjs_dek'></DIV>");
      //xjs_balloon_dek.overflow="hidden";

  if (navigator.appName=="Netscape")
    (document.layers) ? xjs_is_nav = true : xjs_is_old_nav = true;

  if (!xjs_is_old_nav) {
    xjs_balloon_dek = (xjs_is_nav) ? document.xjs_dek : xjs_dek.style;
    if (xjs_is_nav) document.captureEvents(event.MOUSEMOVE);
    document.onmousemove = de_get_mouse;
  }

 if (this.onload) this.oldOnLoad = this.onload;
 this.onload = de_onload;
 this.onunload  = de_on_unload;
 
}

/////////////////////////////////////////////////////////
// 메소드명 : setXjsvOption()
// 내    용 : Xjsv의 Option을 Dynamic하게 세팅한다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function setXjsvOption(opt, value) {
    var command = opt + "=" + value;
    eval(command);
    alert(command);
    alert(XJSV_ERASE_VALUE_DISABLE);
}




/////////////////////////////////////////////////////////
// 이벤트명 : window.onload()
// 파라메터 : e : 이벤트
// 내    용 : window의 onload 이벤트를 가로챈다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function de_onload()
{
   for ( var idx = 0 ; idx < document.forms.length ; idx++)
    if (this.document.forms[idx].masking) document.forms[idx].masking();

  if (XJSV_MAGIC_QUOTE_ON)
    for ( var idx = 0 ; idx < document.forms.length ; idx++)
      if (this.document.forms[idx].magicQuoteErase) document.forms[idx].magicQuoteErase();

  if (XJSV_ESCAPE_ON)
    for ( var idx =  0 ; idx < document.forms.length ; idx++)
      if (this.document.forms[idx].unEscape) document.forms[idx].unEscape();

  if (this.oldOnLoad) this.oldOnLoad();

/*
  for ( var idx = 0 ; idx < document.forms.length ; idx++)
    for(var jdx=0; jdx < document.forms[idx].elements.length ; jdx++){
        document.forms[idx].elements[jdx].value;
function em_clear_x()  {
  if ( !this.xObject.length ) return true;
  for(var idx=0; idx < this.xObject.length ; idx++)
    delete this.xObject[idx];
}

*/
}

/////////////////////////////////////////////////////////
// 이벤트명 : window.onunload()
// 파라메터 : e : 이벤트
// 내    용 : window의 onload 이벤트를 가로챈다.
// 작 성 자 : 신택규
//////////////////////////////////////////////////////////
function de_on_unload()
{
   
	try
	{
	  for ( var idx = 0 ; idx < document.forms.length ; idx++) {
	    for(var jdx=0; jdx < document.forms[idx].elements.length ; jdx++){
	        if ( document.forms[idx].elements[jdx].strippers.length > 0 ) {
	            for (var kdx =0; kdx < document.forms[idx].elements[jdx].strippers.length ; kdx++) {
	            delete document.forms[idx].elements[jdx].strippers[kdx];
	            }
	        }
	        if ( document.forms[idx].elements[jdx].assistants.length > 0 ) {
	            for (var kdx =0; kdx < document.forms[idx].elements[jdx].assistants.length ; kdx++) {
	            delete document.forms[idx].elements[jdx].assistants[kdx];
	            }
	        }
	        if ( document.forms[idx].elements[jdx].validators.length > 0 ) {
	            for (var kdx =0; kdx < document.forms[idx].elements[jdx].validators.length ; kdx++) {
	            delete document.forms[idx].elements[jdx].validators[kdx];
	            }
	        }
	        if ( document.forms[idx].elements[jdx].uich.length > 0 ) {
	            for (var kdx =0; kdx < document.forms[idx].elements[jdx].uich.length ; kdx++) {
	            delete document.forms[idx].elements[jdx].uich[kdx];
	            }
	        }
	        
	        
	    }
	  }
  }
 catch (e){
 }
}

/////////////////////////////////////////////////////////
// 이벤트명 : document.onmousemove()
// 파라메터 : e : 이벤트
// 내    용 : document의  onmousemove를 가로챈다.
// 작 성 자 : ??????
//////////////////////////////////////////////////////////
function de_get_mouse(e){
 try {
  var x = (xjs_is_nav) ? e.pageX : event.x+document.body.scrollLeft;xjs_balloon_dek.left=x+xjs_balloon_Xoffset;
  var y = (xjs_is_nav) ? e.pageY : event.y+document.body.scrollTop;xjs_balloon_dek.top=y+xjs_balloon_yyy;
  } catch(e) {
  }
}


/////////////////////////////////////////////////////////
// 메소드명 : isNum()
// 파라메터 : strnum : 검사할 숫자
// 리 턴 값 : boolean(true / false)
// 내    용 : strnum이 숫자인지 검사한다.
// 작 성 자 : 김성조
//////////////////////////////////////////////////////////
function isNum (strnum){
  return (strnum.toString() && !/\D/.test(strnum));
}

////////////////////////////////////////////////////////////////////////////////////////////////
///
///   xjsv 초기화 함수 호출.
///
////////////////////////////////////////////////////////////////////////////////////////////////

if (XJSV_ACTIVATE) initializeXjsv();

