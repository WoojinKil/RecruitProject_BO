<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>

<%@ page import="java.security.spec.AlgorithmParameterSpec"%>
<%@ page import="javax.crypto.Cipher"%>
<%@ page import="javax.crypto.spec.IvParameterSpec"%>
<%@ page import="javax.crypto.spec.SecretKeySpec"%>
<%@ page import="org.apache.commons.codec.binary.Base64"%>
<%@ page import=" java.net.URLDecoder"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="kr.co.ta9.pandora3.app.util.SeedUtil"%>

<%
   //request.setCharacterEncoding("UTF-8");
String str ="";

if(request.getParameter("V")!=null && request.getParameter("V").toString().trim()!=""){
	str = request.getParameter("V").toString();
}
String decStr ="";
//decStr = URLDecoder.decode(str);
//System.out.println("decStr:" + decStr);
String plainText = SeedUtil.decrypt(str.getBytes("UTF-8"));
System.out.println("decrypt:" + plainText);
out.println("===============복호화결과====================<br/>");
out.println("decrypt:" + plainText +"<br/>");
out.println("===========================================<br/>");
/*

System.out.println("decStr:" + decStr);
String plainText = SeedUtil.decrypt(decStr.getBytes("UTF-8"));
System.out.println("decrypt:" + plainText);
*/

%>
