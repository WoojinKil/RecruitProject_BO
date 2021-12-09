package kr.co.ta9.pandora3.app.util;

import java.awt.Color;
import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
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
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.fasoo.adk.packager.WorkPackager;

import kr.co.ta9.pandora3.common.conf.Configuration;
import kr.co.ta9.pandora3.common.util.TextUtil;

public class DrmFileUtil   {

	private static Configuration configuration = Configuration.getInstance();
	protected final static Log log = LogFactory.getLog(DrmFileUtil.class);
	/**
     * DRM FSD 사용 HOME 디렉토리 경로
     * system.fsd.server.id=0000000000012679
system.fsd.home.dir=c:/tmp/drm
     */
    public static final String DRM_FSD_HOME_PATH =configuration.get("fsd.home.dir");
    /**
     * DRM FSD 서버식별 ID
     */
    public static final String DRM_FSD_SERVER_ID =configuration.get("fsd.server.id");


    public static InputStream loadTargetStream(String fileInfo,String drmFileInfo) throws Exception {

        //암호화파일인지 확인.
        WorkPackager workPackager = new WorkPackager();
        int iBret = 0;
        iBret = workPackager.GetFileType(fileInfo );		// 파일 타입 체크
        String fileResultInfo="";
        int error_num = 0;
    	String error_str = "";
        if (iBret == 103) {
            // 복호화 파일 생성.
        	try{
        		workPackager.DoExtract(DRM_FSD_HOME_PATH,
                        DRM_FSD_SERVER_ID,
                        fileInfo,                     // 대상
                        drmFileInfo);                            // 생성후 파일
        		error_num = workPackager.getLastErrorNum();
				error_str = workPackager.getLastErrorStr();
				if (error_num!=0){
					log.info("error_num = ? " + error_num);
					log.info("error_str = ?[ " + error_str+" ]");
				}
			 	else
				{
			 		log.info("FSN 문서 복호화");
			 		log.info("DoExtract Success!!! ");

				}
        	}catch(Exception ex){
        		log.error(ex.toString());
        	}
        	fileResultInfo = drmFileInfo;
        }else{
        	fileResultInfo=fileInfo;
        }

        File file = new File(fileResultInfo);
        return new FileInputStream(file);
    }

    public static String saveImportStream( InputStream in,   String filepath) throws Exception {

        int nIdx = filepath.lastIndexOf('/');
        String sPath = filepath.substring(0, nIdx);

        File file = new File(sPath);
        if (file.exists() == false) {
            file.mkdirs();
        }

        //임시 파일명으로 변경하여 저장.
        String filepathEncryped = filepath + "_temp";
        OutputStream out = new FileOutputStream(filepathEncryped);

        byte[] buf = new byte[1024];
        int length = 0;
        while ((length = in.read(buf)) > 0) {
            out.write(buf, 0, length);
        }

        out.flush();
        out.close();
        in.close();

      //DRM 복호화 파일 작업진행.
      WorkPackager workPackager = new WorkPackager();
      //암호화파일인지 확인.
      boolean isEncryptedFile = workPackager.IsPackageFile(filepathEncryped);
      boolean isDecryptedFile = false;
      if (isEncryptedFile) {
          // 복호화 파일 생성.
          isDecryptedFile = workPackager.DoExtract(DRM_FSD_HOME_PATH,
                                                          DRM_FSD_SERVER_ID,
                                                          filepathEncryped,
                                                          filepath);
      } else {
          // 암호화 파일이 아닐경우 정상 파일명으로 교체.
         File originalFile = new File(filepathEncryped);
         File fileToRenamed = new File(filepath);
         originalFile.renameTo(fileToRenamed);
      }

      if (isDecryptedFile) {
          log.debug("복호화 성공");
      } else {
          // 오류 정보 출력
          log.debug(" [" + workPackager.getLastErrorNum() + "] " + workPackager.getLastErrorStr());
      }

      return null;
    }

	 public int saveExportStream(
             ByteArrayOutputStream out,
             String filepath, String fileurl,
             HttpServletResponse response)  throws Exception {
			int nIdx = filepath.lastIndexOf('/');
			String sPath = filepath.substring(0, nIdx);

			File file = new File(sPath);
			if (file.exists() == false) {
			file.mkdirs();
			}
			FileOutputStream fout = new FileOutputStream(filepath);
			fout.write(out.toByteArray());

			fout.close();
			out.close();

			WorkPackager workPackager = new WorkPackager();
			// 접속한 유저가 영업통합시스템일 경우만 엑셀다운로드 파일에 암호화 적용.
			workPackager.setOverWriteFlag(true);
			boolean bret = workPackager.DoPackagingFsn2(DRM_FSD_HOME_PATH,
			                                  DRM_FSD_SERVER_ID,
			                                  filepath,            //암호화 대상 원본파일
			                                  filepath,            //암호화후 생성하고자하는 파일.
			                                  "tempFilename.xlsx", // 원본파일명
			                                  "admin",             //생성자 ID
			                                  "관리자",            //생성자 이름
			                                  "etc01",              //etc01
			                                  "etc02",            //etc02
			                                  "etc03",               //etc03
			                                  "etc04",              //etc04
			                                  "etc05",              //etc05
			                                  "etc06",            //etc06
			                                  "etc07",               //etc07
			                                  "etc08",              //etc08
			                                  "1");                // SecurityCode
			if (!bret) {
			log.debug("error");
			log.debug("[" + workPackager.getLastErrorNum() + "] " + workPackager.getLastErrorStr());

			} else {
			log.debug("success");
			log.debug("Packaged FileName : " + workPackager.getContainerFileName() + "");
			}

			return 0;
}

    public static boolean saveExportStream( String oriFileInfo, String fileUrl,  HttpServletResponse response,HttpServletRequest request,String fileNm,String drmFileInfo)  throws Exception {
			WorkPackager workPackager = new WorkPackager();
			// 접속한 유저가 영업통합시스템일 경우만 엑셀다운로드 파일에 암호화 적용.
			workPackager.setOverWriteFlag(true);
			String target = configuration.get("properties.target");
			String strFileinfo ="";
			String SecurityCode = "2015122115592100009";
			boolean bret  = false;
			if("local".equals(target)){
				bret = true;
				strFileinfo = oriFileInfo;
			}else{
				/*
				bret = workPackager.DoPackagingFsn2(
						DRM_FSD_HOME_PATH,					//fsdinit 폴더 FullPath 설정
						DRM_FSD_SERVER_ID,			//고객사 Key(default)
						oriFileInfo,		//암호화 대상 문서 FullPath + FileName
						drmFileInfo,		//암호화 된 문서 FullPath + FileName
						fileNm,					//파일 명
						  "admin",						//작성자 ID
						  "관리자",						//작성자 명
						  "test", "test", "001","팀_1",				//시스템 ID
						  "test", "test", "001","팀_1",				//ACL ID (권한 확인을 위한 ID로 SystemID와 동일 적용)
						  "1"
						  );
				*/
				bret = workPackager.DoPackagingFsn2(DRM_FSD_HOME_PATH,
                        DRM_FSD_SERVER_ID,
                        oriFileInfo,            //암호화 대상 원본파일
                        drmFileInfo,            //암호화후 생성하고자하는 파일.
                        "tempFilename.xlsx", // 원본파일명
                        "admin",             //생성자 ID
                        "관리자",            //생성자 이름
                        "etc01",              //etc01
                        "etc02",            //etc02
                        "etc03",               //etc03
                        "etc04",              //etc04
                        "etc05",              //etc05
                        "etc06",            //etc06
                        "etc07",               //etc07
                        "etc08",              //etc08
                        SecurityCode);                // SecurityCode
			}
			if (!bret) {
				log.debug("error");
				log.debug("[" + workPackager.getLastErrorNum() + "] " + workPackager.getLastErrorStr());
			} else {
				log.debug("success");
				log.debug("Packaged FileName : " + workPackager.getContainerFileName() + "");
				String userAgent = request.getHeader("User-Agent");
				if (userAgent.contains("MSIE") || userAgent.contains("Trident")) {
	        		fileNm = URLEncoder.encode(fileNm,"UTF-8").replaceAll("\\+", "%20");

	        	} else if (userAgent.contains("Firefox") || userAgent.contains("Opera") ) {
	        		fileNm = "\"" + new String(fileNm.getBytes("UTF-8"), "8859_1") + "\"";

	        	} else if (userAgent.contains("Chrome")) {
	        		StringBuilder sb = new StringBuilder();
	        		for (int i = 0; i < fileNm.length(); i++) {
	        			char c = fileNm.charAt(i);
	        			if (c > '~') {
	        				sb.append(URLEncoder.encode("" + c, "UTF-8")); }
	        			else {
	        				sb.append(c);
	        			}
	        		}
	        		fileNm = sb.toString();

	        	} else {
	        		throw new RuntimeException("Not supported browser");
	        	}

				strFileinfo = drmFileInfo;


				/*
				 * int read;
				strFileinfo = drmFileInfo;
				byte readByte[] = new byte[1024];
				BufferedInputStream fin = new BufferedInputStream(new FileInputStream(strFileinfo));
				OutputStream outs = response.getOutputStream();
				while ((read = fin.read(readByte, 0, 1024)) != -1) {
					outs.write(readByte, 0, read);
				}
				response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
				response.setCharacterEncoding("utf-8");
				response.setHeader("Content-Disposition", "attachment;filename="+fileNm+".xlsx");
				outs.flush();
				outs.close()
				fin.close();
				*
				*/
				OutputStream out = null;
				InputStream inputStream = null;
				int bufferSize = 1024;
				try {
					inputStream = new FileInputStream(strFileinfo);
					response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
					response.addHeader("Content-disposition", "attachment;filename="+fileNm+".xlsx");

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

			return bret;
	}

	/**
	 * @param response
	 * @param header
	 * @param list
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public static void  exportExcelXslx(HttpServletRequest request,HttpServletResponse response, Map<String,String> header, List<Map<String,String>> list, String fileNm) throws Exception {
		XSSFWorkbook  workbook = new XSSFWorkbook();
		XSSFSheet sheet = workbook.createSheet("sheet1");

		OutputStream outputStream = null;
		String excelTitle =fileNm;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS", Locale.ENGLISH);
		Calendar calendar = Calendar.getInstance();
		String fileName =excelTitle+"_" + dateFormat.format(calendar.getTime())+".xlsx";
		String saveFilePath  = configuration.get("app.pandora3front.file.upload.path");
		try {
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
						cell.setCellStyle(headerCellStyle);
					}
					colSize++;
				}
				rowSize++;
			}

			// 실제로 저장될 파일 풀 경로

			File file = new File(saveFilePath +"/", fileName);

			//엑셀 파일을 만듬
			FileOutputStream fileOutput = new FileOutputStream(file);
			workbook.write(fileOutput);
			fileOutput.close();

		}
		catch (Exception e) {
			log.error(e);
		}
		finally {
			if (outputStream != null) try { outputStream.close(); } catch (Exception e) {log.error(e);}
		}
		String drmFileInfo =saveFilePath +"/"+  excelTitle+"_" + dateFormat.format(calendar.getTime())+".xlsx";
		String filePath =saveFilePath +"/"+ fileName;
		if( saveExportStream(filePath ,  filePath,   response,request, fileNm, drmFileInfo)){

		}else{
			throw new RuntimeException("fail download");
		}

	}

	/**
	 * @param response
	 * @param header
	 * @param list
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public static void  exportExcelXslx(HttpServletRequest request,HttpServletResponse response,XSSFWorkbook workbook, String fileNm) throws Exception {

		OutputStream outputStream = null;
		String excelTitle =fileNm;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS", Locale.ENGLISH);
		Calendar calendar = Calendar.getInstance();
		String fileName =excelTitle+"_" + dateFormat.format(calendar.getTime())+".xlsx";
		String saveFilePath  = configuration.get("app.pandora3front.file.upload.path");
		try {
			// 실제로 저장될 파일 풀 경로

			File file = new File(saveFilePath +"/", fileName);

			//엑셀 파일을 만듬
			FileOutputStream fileOutput = new FileOutputStream(file);
			workbook.write(fileOutput);
			fileOutput.close();

		}
		catch (Exception e) {
			log.error(e);
		}
		finally {
			if (outputStream != null) try { outputStream.close(); } catch (Exception e) {log.error(e);}
		}
		String drmFileInfo =saveFilePath +"/"+  excelTitle+"_" + dateFormat.format(calendar.getTime())+".xlsx";
		String filePath =saveFilePath +"/"+ fileName;
		if( saveExportStream(filePath ,  filePath,   response,request, fileNm, drmFileInfo)){

		}else{
			throw new RuntimeException("fail download");
		}

	}

}
