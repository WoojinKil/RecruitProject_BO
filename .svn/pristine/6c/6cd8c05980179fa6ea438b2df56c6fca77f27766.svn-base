package kr.co.ta9.pandora3.app.util;

import java.awt.Color;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.jcraft.jsch.Logger;

import kr.co.ta9.pandora3.common.util.TextUtil;

public final class FileDownLoad {
	
	private static final Log log = LogFactory.getLog(FileDownLoad.class);
	private FileDownLoad() {}
	
	public static void download(HttpServletResponse response, String file_path, String file_name) throws Exception {
		OutputStream out = null;
		InputStream inputStream = null;
		int bufferSize = 1024;
		
		try {
			inputStream = new FileInputStream(file_path);
			response.setContentType("binary/octet-stream");
			response.addHeader("Content-disposition", "attachment; filename=" + URLEncoder.encode(file_name, "UTF-8"));
			
			out = response.getOutputStream();
			byte[] bytes = new byte[bufferSize];
			int size = 0;
			while (-1 != (size = inputStream.read(bytes))) {
				out.write(bytes, 0, size);
            }
			out.flush();
			
		} finally {
			try { inputStream.close(); } catch (Exception e) {log.error(e);}
			try { out.close(); } catch (Exception e) {log.error(e);}
		}
	}
	
	/**
	 * @param response
	 * @param list
	 * @throws Exception
	 */
	public static void exportExcel(HttpServletResponse response, Map<String,String> header, List<Map<String,String>> list) throws Exception {		
		Workbook workbook = new HSSFWorkbook();
		Sheet sheet = workbook.createSheet("Excel");
		CreationHelper createHelper = workbook.getCreationHelper();
		OutputStream outputStream = null;
		try {
			int rowSize = 0;
			list.add(0, header);
			for (Map<String,String> data : list) {
				rowSize++;
				Row row = sheet.createRow(rowSize);
				
				Set set = header.keySet();
				Iterator iterator = set.iterator();
				
				int colSize = 0;
				while (iterator.hasNext()) {
					colSize++;
					Cell cell = row.createCell(colSize);
					cell.setCellValue(createHelper.createRichTextString(data.get((String)iterator.next())));
				}
			}
			
			outputStream = response.getOutputStream();
			response.setContentType("binary/octet-stream");
			response.addHeader("Content-disposition", "attachment; filename=" + URLEncoder.encode("Excel.xls", "UTF-8"));
			workbook.write(outputStream);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			if (outputStream != null) try { outputStream.close(); } catch (Exception e) {log.error(e);}
		}
	
	}
	
	/**
	 * @param  response
	 * @param  header
	 * @param  list
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes" })
	public static void exportErrExcelList(HttpServletRequest request, HttpServletResponse response, Map<String, String> header, List<Map<String, String>> list, String fileNm) throws Exception {		
		XSSFWorkbook  workbook = new XSSFWorkbook();
		XSSFSheet sheet = workbook.createSheet("Excel");
		CreationHelper createHelper = workbook.getCreationHelper();
		OutputStream outputStream = null;
		String excelTitle = fileNm;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS", Locale.ENGLISH);
		Calendar calendar = Calendar.getInstance();
		try {
			String userAgent = request.getHeader("User-Agent");
			if(userAgent.contains("MSIE") || userAgent.contains("Trident")) {
        		excelTitle = URLEncoder.encode(excelTitle,"UTF-8").replaceAll("\\+", "%20");
        	}else if (userAgent.contains("Firefox") || userAgent.contains("Opera") ) {
        		excelTitle = "\"" + new String(excelTitle.getBytes("UTF-8"), "8859_1") + "\"";
        	}else if (userAgent.contains("Chrome")) {
        		StringBuilder sb = new StringBuilder(); 
        		for(int i = 0; i < excelTitle.length(); i++) {
        			char c = excelTitle.charAt(i); 
        			if(c > '~') {
        				sb.append(URLEncoder.encode("" + c, "UTF-8"));
        			}else { 
        				sb.append(c); 
        			} 
        		} 
        		excelTitle = sb.toString();
        	}else { 
        		throw new RuntimeException("Not Supported Browser.."); 
        	}
			
			XSSFCellStyle headerErrCellStyle = workbook.createCellStyle();
			// �젙�젹
			headerErrCellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			headerErrCellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			headerErrCellStyle.setBorderTop(XSSFCellStyle.BORDER_MEDIUM);
			headerErrCellStyle.setBorderRight(XSSFCellStyle.BORDER_THIN);
			headerErrCellStyle.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			headerErrCellStyle.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			headerErrCellStyle.setTopBorderColor(new XSSFColor(new Color(201, 0, 0)));
			headerErrCellStyle.setRightBorderColor(new XSSFColor(new Color(219, 0, 0)));
			headerErrCellStyle.setBottomBorderColor(new XSSFColor(new Color(219, 0, 0)));
			headerErrCellStyle.setLeftBorderColor(new XSSFColor(new Color(219, 0, 0)));
			headerErrCellStyle.setFillForegroundColor(IndexedColors.RED.getIndex());
			headerErrCellStyle.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
			Font headerErrfont = workbook.createFont();
			headerErrfont.setColor(IndexedColors.WHITE.getIndex());
			headerErrfont.setBoldweight(Font.BOLDWEIGHT_BOLD);
			headerErrCellStyle.setFont(headerErrfont);
			
			XSSFCellStyle headerCellStyle = workbook.createCellStyle();
			headerCellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			headerCellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			headerCellStyle.setBorderTop(XSSFCellStyle.BORDER_MEDIUM);
			headerCellStyle.setBorderRight(XSSFCellStyle.BORDER_THIN);
			headerCellStyle.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			headerCellStyle.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			headerCellStyle.setTopBorderColor(new XSSFColor(new Color(102, 102, 102)));
			headerCellStyle.setRightBorderColor(new XSSFColor(new Color(204, 204, 204)));
			headerCellStyle.setBottomBorderColor(new XSSFColor(new Color(204, 204, 204)));
			headerCellStyle.setLeftBorderColor(new XSSFColor(new Color(204, 204, 204)));
			headerCellStyle.setFillForegroundColor(new XSSFColor(new Color(245, 245, 245)));
			headerCellStyle.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
			Font headerfont = workbook.createFont();
			headerfont.setColor(new XSSFColor(new Color(102, 102, 102)).getIndexed());
			headerfont.setBoldweight(Font.BOLDWEIGHT_BOLD);
			headerCellStyle.setFont(headerfont);
			
			XSSFCellStyle contentErrCellStyle = workbook.createCellStyle();
			contentErrCellStyle.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			contentErrCellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			Font contentErrfont = workbook.createFont();
			contentErrfont.setColor(IndexedColors.RED.getIndex());
			contentErrfont.setBoldweight(Font.BOLDWEIGHT_BOLD);
			contentErrCellStyle.setFont(contentErrfont);
			
			int rowSize = 0;
			int msgIdx = 0;
			String errMsg = list.get(0).get("ERR_MSG");
			list.add(0, header);
			for(Map<String,String> data : list) {
				if(msgIdx > 0) errMsg = list.get(msgIdx).get("ERR_MSG");
				rowSize++;
				Row row = sheet.createRow(rowSize);
				if(rowSize == 1) {
					Set set = header.keySet();
					Iterator iterator = set.iterator();
					int colSize = 0;
					colSize++;
					Cell cell = row.createCell(colSize);
					cell.setCellValue(createHelper.createRichTextString("�� �삤瑜섏궗�빆 -> �솗�씤 �썑 �궘�젣 �슂留�"));
					cell.setCellStyle(headerErrCellStyle);
					while (iterator.hasNext()) {
						colSize++;
						cell = row.createCell(colSize);
						cell.setCellValue(createHelper.createRichTextString(data.get((String)iterator.next())));
						cell.setCellStyle(headerCellStyle);
					}
					msgIdx++;
				}else {
					if(data.get("CELL_CNT") != null && !"".equals(data.get("CELL_CNT"))) {
						int cellCnt = Integer.parseInt(data.get("CELL_CNT"));
						int colSize = 0;
						colSize++;
						Cell cell = row.createCell(colSize);
						cell.setCellValue(createHelper.createRichTextString(errMsg));
						cell.setCellStyle(contentErrCellStyle);
						for(int i = 0; i < cellCnt; i++) {
							colSize++;
							cell = row.createCell(colSize);
							cell.setCellValue(createHelper.createRichTextString(data.get(String.valueOf(i))));
						}
						msgIdx++;
					}
				}
			}
			
			for(int i = 0; i < list.size(); i++) {
				sheet.autoSizeColumn(i);
				if(i == 0) sheet.setColumnWidth(i, (sheet.getColumnWidth(i)) + 2500); 
				else sheet.setColumnWidth(i, (sheet.getColumnWidth(i)) + 1000);
			}
			
			outputStream = response.getOutputStream();
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setCharacterEncoding("utf-8");
			response.setHeader("Content-Disposition", "attachment;filename="+ excelTitle + "_" + dateFormat.format(calendar.getTime()) + ".xlsx");
			workbook.write(outputStream);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(outputStream != null) try { outputStream.close(); } catch (Exception e) {log.error(e);}
		}
	}
	
	/**
	 */
	public static void downloadText(HttpServletResponse response, String content, String file_name) throws Exception {
		
		PrintWriter writer = null;		
		try {
			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");
			response.addHeader("Content-disposition", "attachment; filename=" + URLEncoder.encode(file_name, "UTF-8"));			
			writer = response.getWriter();			
			writer.print(content);
			
		} finally {
			try { writer.close(); } catch (Exception e) {log.error(e);}
		}
		
	}
	
	/**
	 * @param response
	 * @param header
	 * @param list
	 * @throws Exception
	 */
	public static void exportExcelXslx_(HttpServletRequest request,HttpServletResponse response, Map<String,String> header, List<Map<String,String>> list, String fileNm) throws Exception {		
		  try {
			   // Excel Workbook
			  SXSSFWorkbook  wb = new SXSSFWorkbook();         
			   // Excel Sheet
			   Sheet sheet1 = wb.createSheet("sheet1");    
			   
				   
			   for (int i=0 ; i<10 ; i++) {
			    // Row
			    Row row = sheet1.createRow(i);    
			    row.setHeight((short)300); // Row Height
			    
			    for (int j=0 ; j<10 ; j++) {
			     // Column
			     Cell cell = row.createCell((short)j);
			     cell.setCellValue("Row : " + (i+1) + ", Col : " + (j+1));

			    }
			   }
			   
			   // Auto width setting 
			   for (int i=0 ; i<9 ; i++) {
			    sheet1.autoSizeColumn(i, true); 
			   }
			   
			   // Width setting
			   sheet1.setColumnWidth(9, 30*256); // Cell Width (Character count * 256)
			   
			   FileOutputStream fileOut = new FileOutputStream("c:\\test\\sample1.xlsx"); 
			   wb.write(fileOut);      
			   fileOut.close();
			  } catch (FileNotFoundException e) {
				  log.error(e);
			  } catch (IOException e) {
				  log.error(e);
			  }
	}
	
	/**
	 * @param response
	 * @param header
	 * @param list
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public static void exportExcelXslx(HttpServletRequest request,HttpServletResponse response, Map<String,String> header, List<Map<String,String>> list, String fileNm) throws Exception {		
		XSSFWorkbook  workbook = new XSSFWorkbook();
		XSSFSheet sheet = workbook.createSheet("sheet1");
		
		OutputStream outputStream = null;
		String excelTitle =fileNm;
		 SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS", Locale.ENGLISH); 
		  Calendar calendar = Calendar.getInstance();
		try {
			String userAgent = request.getHeader("User-Agent");
			if (userAgent.contains("MSIE") || userAgent.contains("Trident")) {
        		excelTitle = URLEncoder.encode(excelTitle,"UTF-8").replaceAll("\\+", "%20");
        		
        	} else if (userAgent.contains("Firefox") || userAgent.contains("Opera") ) { 
        		excelTitle = "\"" + new String(excelTitle.getBytes("UTF-8"), "8859_1") + "\""; 

        	} else if (userAgent.contains("Chrome")) { 
        		StringBuilder sb = new StringBuilder(); 
        		for (int i = 0; i < excelTitle.length(); i++) { 
        			char c = excelTitle.charAt(i); 
        			if (c > '~') { 
        				sb.append(URLEncoder.encode("" + c, "UTF-8")); } 
        			else { 
        				sb.append(c); 
        			} 
        		} 
        		excelTitle = sb.toString(); 
        		
        	} else { 
        		throw new RuntimeException("Not supported browser"); 
        	}
			
			XSSFCellStyle headerCellStyle = workbook.createCellStyle();
			headerCellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			headerCellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			headerCellStyle.setBorderTop(XSSFCellStyle.BORDER_MEDIUM);
			headerCellStyle.setBorderRight(XSSFCellStyle.BORDER_THIN);
			headerCellStyle.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			headerCellStyle.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			headerCellStyle.setTopBorderColor(new XSSFColor(new Color(102, 102, 102)));
			headerCellStyle.setRightBorderColor(new XSSFColor(new Color(204, 204, 204)));
			headerCellStyle.setBottomBorderColor(new XSSFColor(new Color(204, 204, 204)));
			headerCellStyle.setLeftBorderColor(new XSSFColor(new Color(204, 204, 204)));
			
			headerCellStyle.setFillForegroundColor(new XSSFColor(new Color(245, 245, 245)));
			headerCellStyle.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
			Font headerfont = workbook.createFont();
			headerfont.setColor(new XSSFColor(new Color(102, 102, 102)).getIndexed());
			headerfont.setBoldweight(Font.BOLDWEIGHT_BOLD);
			headerCellStyle.setFont(headerfont);
			
			int rowSize = 0;
			list.add(0, header);
			for (Map<String,String> data : list) {
				XSSFRow  row = sheet.createRow(rowSize);
				
				Set set = header.keySet();
				Iterator iterator = set.iterator();

				int colSize = 0;
				while (iterator.hasNext()) {
					XSSFCell  cell = row.createCell(colSize);
					String val = TextUtil.toEmptyDefaultString(String.valueOf(data.get((String)iterator.next())), "");
					cell.setCellValue(val);
					if(rowSize==0){
						// �뿤�뜑 �뒪���씪 �쟻�슜 : �씪諛�
						cell.setCellStyle(headerCellStyle);
					}
					colSize++;
				}
				rowSize++;
			}
			
//			for(int i = 0; i < list.size(); i++) {
//				sheet.autoSizeColumn(i);
//				sheet.setColumnWidth(i, (sheet.getColumnWidth(i)) + 1000);
//			}
			
			outputStream = response.getOutputStream();
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setCharacterEncoding("utf-8");
			response.setHeader("Content-Disposition", "attachment;filename="+ excelTitle + "_" + dateFormat.format(calendar.getTime()) + ".xlsx");
			workbook.write(outputStream);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			if (outputStream != null) try { outputStream.close(); } catch (Exception e) {log.error(e);}
		}
	}
	
}
