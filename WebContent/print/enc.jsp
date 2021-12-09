<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>

<%@ page import="java.security.spec.AlgorithmParameterSpec"%>
<%@ page import="javax.crypto.Cipher"%>
<%@ page import="javax.crypto.spec.IvParameterSpec"%>
<%@ page import="javax.crypto.spec.SecretKeySpec"%>
<%@ page import="org.apache.commons.codec.binary.Base64"%>
<%@ page import=" java.net.URLDecoder"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="kr.co.ta9.pandora3.app.util.SeedUtil"%>
<%@ page import="kr.co.ta9.pandora3.app.util.KmsUtil" %>


<%
   //request.setCharacterEncoding("UTF-8");
String encStr ="";
String enc_string ="";
String decStr ="";
String encString  ="";
try{
	String str ="";

	if(request.getParameter("V")!=null && request.getParameter("V").toString().trim()!=""){
	        str = request.getParameter("V").toString();
	}


	String plainText = "{id:aaaa,dept:2222}";

	plainText =" Elwlxkfbdpmt!@34";
	/*************************************
	* 암호화
	*************************************/
	byte[] encryptData = SeedUtil.encrypt(plainText);

	encStr =new String(encryptData, "utf-8");
	encStr = URLEncoder.encode(encStr, "UTF-8");
	System.out.println("encrypt:" +encStr);


	if(request.getParameter("enc_str")!=null && request.getParameter("enc_str").toString().trim()!=""){
		enc_string = request.getParameter("enc_str").toString();
	}


	System.out.println(enc_string);
	if(enc_string !=null && enc_string.length()>0){
		String str1 = enc_string;
		encString = KmsUtil.KmsEncrypt(str1);
		decStr = KmsUtil.KmsDecrypt(encString);
	}
}catch(Exception ex){
   System.out.println(ex.toString());
}


%>
<script>
function checkForm(){
   document.getElementById("form1").submit();
}

</script>


<form id="form1" name="form1" method ="post">
암호화 대상 : <input type="text" name="enc_str" value="<%=enc_string%>"> <br/>
암호화 결과 : <input type="text" name="dec_str" value="<%=encString%>"> <br/>
<br/>
<input type="button" value="enc"  onclick="javascript: checkForm()"/>

</form>
