<%@ page language="java" contentType="application/pdf; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="net.sf.jasperreports.engine.*" %>
<%@ page import="net.sf.jasperreports.engine.export.*" %>
<%@ page import="net.sf.jasperreports.engine.JasperReport" %>
<%@ page import="net.sf.jasperreports.view.*" %>
<%@ page import="net.sf.jasperreports.engine.data.JRXmlDataSource" %>
<%@ page import="net.sf.jasperreports.engine.JRParameter" %>
<%@ page import="net.sf.jasperreports.engine.JasperFillManager" %>
<%@ page import="net.sf.jasperreports.engine.query.JRXPathQueryExecuterFactory" %>
<%@ page import="net.sf.jasperreports.engine.util.JRLoader" %>
<%@ page import="net.sf.jasperreports.engine.util.JRXmlUtils" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.xml.sax.InputSource" %>
<%@ page import =" java.io.StringReader" %>
<%@ page import =" java.io.ByteArrayInputStream" %>
<%@ page import =" java.io.InputStream" %>
<%@ page import =" java.nio.charset.StandardCharsets" %>
<%@ page import ="net.sf.jasperreports.engine.query.JsonQueryExecuterFactory" %>
<%@ page import ="net.sf.jasperreports.engine.data.JsonDataSource" %>
<%@ page import ="com.fasterxml.jackson.core.JsonProcessingException" %>
<%@ page import ="com.fasterxml.jackson.databind.JsonNode" %> 
<%@ page import ="com.fasterxml.jackson.annotation.JsonAutoDetect" %>



 
<%
   request.setCharacterEncoding("UTF-8");
   response.setHeader("Content-Disposition",  "inline; filename=report.pdf ");
   StringBuffer sbString = new StringBuffer();
  // Logger.info("-------------0-------------");
   
   String data ="";
   String fileNm="";
   
   if(request.getParameter("data")!=null && !"".equals(request.getParameter("data").toString().trim())){
   	data = request.getParameter("data");
   }
     
   if(request.getParameter("filenm")!=null &&  !"".equals(request.getParameter("filenm").toString().trim())){
   	fileNm = request.getParameter("filenm").toString().trim();
   }
   
     Enumeration params2 = request.getParameterNames();
     System.out.println("----------------------------");
     while (params2.hasMoreElements()){
         String name = (String)params2.nextElement();
         System.out.println(name + " : " +request.getParameter(name));
     }
     System.out.println("----------------------------");
     
  

   if(data.length()>0 && fileNm.length()>0){
   	try{
    	String sUrl = getServletContext().getRealPath("/");
    	System.out.println(sUrl);

    	String fullFileNm = sUrl+fileNm;    //sUrl+"/resources/pandora3/ireport/pgm_info_report_xml.jasper";//sUrl+fileNm;
    	System.out.println(fullFileNm);
    	
    	DocumentBuilderFactory factory  =  DocumentBuilderFactory.newInstance();
    	DocumentBuilder builder    =  factory.newDocumentBuilder();
    	Document document     =  builder.parse(new InputSource(new StringReader(data)));
    	Map params = new HashMap();
    	//Logger.info("-------------3-------------");
    	params.put(JRXPathQueryExecuterFactory.PARAMETER_XML_DATA_DOCUMENT, document);
    	
    	//params.put(JRXPathQueryExecuterFactory.XML_LOCALE, Locale.forLanguageTag("ko-KR"));
    	//params.put(JRParameter.REPORT_LOCALE,Locale.forLanguageTag("ko-KR"));
    	//Logger.info("-------------4-------------");
    	JasperPrint print = JasperFillManager.fillReport(fullFileNm,params);
    	JasperExportManager.exportReportToPdfStream(print,response.getOutputStream());
    	 
    	 
   	}catch (JsonProcessingException er){
    }catch (Exception e) {
    }
  }

%>        
