/**
* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명 : kr.co.ta9.pandora3.main.controller
* 3. 파일명 : SystemController
* 4. 작성일 : 2019-07-29
* </pre>
*/
package kr.co.ta9.pandora3.main.controller;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.app.util.DrmFileUtil;
import kr.co.ta9.pandora3.common.conf.Configuration;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.exception.UtilException;
import kr.co.ta9.pandora3.common.servlet.download.FileDownLoad;
import kr.co.ta9.pandora3.common.servlet.upload.UploadFile;
import kr.co.ta9.pandora3.common.util.DateUtil;
import kr.co.ta9.pandora3.common.util.FileUtil;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.main.manager.MainMgr;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmMnu;
/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.system.controller
* 2. 타입명 : class
* 3. 작성일 : 2017-10-27
* 4. 설명 : 시스템 컨트롤러
* </pre>
*/
@Controller
public class MainController extends CommonActionController {

	@Autowired
	private MainMgr mainMgr;


	/**
	 * 메인화면 > 메인
	 * @return ModelAndView
	 */
	@RequestMapping(value={"/bo"})
	public ModelAndView bo(HttpServletRequest request, HttpServletResponse response){
		ModelAndView mav = new ModelAndView();

		String strEnc = "";
		if (request.getParameter("v") != null) {
			strEnc = request.getParameter("v");
		}
		mav.setViewName("/pandora3/login/login");
		mav.addObject("v", strEnc);
		return mav;
	}


	/**
	 * BO : URL 매핑 메뉴
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/main/selectTsysAdmMnuTgt", method = RequestMethod.POST)
	public void selectTsysAdmMnuTgt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		// mapper 선언
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> menuInfoMap = new HashMap<String, Object>();
		try {
			// 메뉴 그리드 목록 조회
			TsysAdmMnu menuInfo = mainMgr.selectTsysAdmMnuTgt(parameterMap);
			// java Object convert to JSON map
			menuInfoMap = mapper.readValue(mapper.writeValueAsString(menuInfo), new TypeReference<Map<String,Object>>(){});
		}
		catch (Exception e) {
			// Exception 일 경우
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		json.put("menuInfoMap", menuInfoMap);
		ResponseUtil.write(response, json.toJSONString());
	}



	/**
	 * (NEW) 엑셀 업로드 후 그리드 출력
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/main/newUploadExcel", method = RequestMethod.POST)
	public void newUploadExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 파마미터 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// JSON 선언
		JSONObject json = new JSONObject();
		// RESULT 선언
		String result = Const.BOOLEAN_SUCCESS;
		// 유효한 FILE인지 여부 선언
		String validFileYn = Const.BOOLEAN_SUCCESS;
		// 전역변수 선언
		List<Map<String, String>> rowMapList = new ArrayList<Map<String, String>>(); // 정상 : 각각의 ROW 정보를 리스트에 담기 위한 변수
        List<Map<String, String>> rowErrMapList = new ArrayList<Map<String, String>>(); // 오류 : 각각의 ROW 정보를 리스트에 담기 위한 변수
        int errCnt_01 = 0; // 오류건수 : 업로드할 컬럼수 초과 오류
        int errCnt_02 = 0; // 오류건수 : 필수값 오류
        int errCnt_03 = 0; // 오류건수 : 중복 오류
        int errCnt_04 = 0; // 오류건수 : 데이터 미입력 오류
		try {
			Configuration configuration = Configuration.getInstance();
			UploadFile uploadFile = parameterMap.getUploadFile("file");
			InputStream is = null;
			if(uploadFile != null) {
				String target = configuration.get("properties.target");
				if( "local".equals(target)){
					is = uploadFile.getFileItem().getInputStream(); // inputStream 선언
				}else{
					String separator = "_";
					String ori_fl_nm = uploadFile.getOriginalFilename();
					ori_fl_nm = ori_fl_nm.substring(ori_fl_nm.lastIndexOf("\\")+1);
					String chg_source_filename = new StringBuilder().append(DateUtil.today("yyyyMMddHHmmssSSS")).append(separator).append(ori_fl_nm).toString();
					String drmSourceFileName=new StringBuilder().append(DateUtil.today("yyyyMMddHHmmssSSS")).append(separator).append("drm_").append(ori_fl_nm).toString();
					String saveFilePath  = configuration.get("app.pandora3front.file.upload.path");
					uploadFile.addType(0);
					uploadFile.transferTo(saveFilePath, chg_source_filename);
					String saveFileInfo =saveFilePath+"/"+ chg_source_filename;
					String saveDrmFileInfo =saveFilePath+"/"+ drmSourceFileName;
					is = DrmFileUtil.loadTargetStream(saveFileInfo,saveDrmFileInfo); // uploadFile.getFileItem().getInputStream(); // inputStream 선언

					//uploadFile.
					FileUtil.deleteFile(saveFileInfo);
					FileUtil.deleteFile(saveDrmFileInfo);
				}

				Workbook wb = null; // Workbook 선언
				Sheet sheet = null; // Sheet 선언
				int numOfRows = 0; // ROW 수
		        int numOfCells = 0; // CELL 수
		        Row checkRow = null; // ROW 객체
		        Row row = null; // ROW 객체
		        Cell cell = null; // CELL 객체
		        Map<String, String> rowMap = null; // ROW 별 값 저장할 MAP 객체 : 정상
		        Map<String, String> errRowMap = null; // ROW 별 값 저장할 MAP 객체 : 오류
		        Map<String, String> gridHeader = parameterMap.parseGridHeader(); // 그리드 헤더 선언
				Set<String> set = gridHeader.keySet(); // set 선언
				int colSize = set.size(); // 컬럼 사이즈 선언
				String[] keys = new String[colSize]; // keys 선언
				Iterator iterator = set.iterator(); // iterator 선언
				int idx = 0;
				while(iterator.hasNext()) {
					keys[idx] = (String)iterator.next();
					idx++;
				}
				Map<String, String> uploadHeader = parameterMap.parseJsonObj("UPLOADHEADER");
				Set<String> set2 = uploadHeader.keySet(); // set 선언
				int colSize2 = set2.size(); // 컬럼 사이즈 선언
				String[] keys2 = new String[colSize2]; // keys 선언
				Iterator iterator2 = set2.iterator(); // iterator 선언
				idx = 0;
				while(iterator2.hasNext()) {
					keys2[idx] = (String)iterator2.next();
					idx++;
				}

				// 엑셀만 가능
				int[] types = {UploadFile.MS_EXCEL};
		        uploadFile.addTypes(types);

		        // 엑셀 확장자 구분에 따른 분기
		        // 1. XLS  → HSSFWorkbook
		        // 2. XLSX → XSSFWorkbook
		        String ext = uploadFile.getExtension().toUpperCase(Locale.ENGLISH); // 확장자 추출

		        if("XLS".equals(ext)) {
		        	wb = new HSSFWorkbook(is);
		        }else if("XLSX".equals(ext)) {
		            wb = new XSSFWorkbook(is);
		        }

		        if(wb != null) {
		        	// 유효성 체크 관련 파라미터 셋팅
    				Map<String, String> requiredMap = parameterMap.parseJsonObj("REQUIRED");

		        	// 엑셀 파일에서 첫번째 시트 추출
		        	sheet = wb.getSheetAt(0);

		        	// 시트에서 유효한 ROW 수 추출
		        	numOfRows = sheet.getPhysicalNumberOfRows();

		        	// 빈 ROW 수 포함
		        	for(int i = 1; i < numOfRows; i++) {
		        		// 시트에서 ROW 데이터 추출
		        		checkRow = sheet.getRow(i);
		        		if(checkRow == null) {
		        			numOfRows++;
		        		}
		        	}

		        	// 추출된 ROW 수만큼 반복
		        	// 각각의 ROW 정보 MAP에 담고 해당 MAP 데이터를 리스트에 담는다.
		        	List<String> rowValList = new ArrayList<String>();
		        	for(int i = 1; i < numOfRows; i++) {
		        		// 시트에서 ROW 데이터 추출
		        		row = sheet.getRow(i);
		        		if(row != null) {
		        			rowMap = new HashMap<String, String>();
		        			// 추출된 ROW의 CELL 수 추출
		        			numOfCells = row.getLastCellNum();
		        			// 그리드 헤더 갯수 초과 시 에러 데이터 셋팅
		        			if(colSize2 > colSize || numOfCells > colSize2) {
		        				for(int j = 0; j < numOfCells; j++) {
		        					errRowMap = new HashMap<String, String>();
		        					// CELL 데이터 추출
		        					cell = row.getCell(j);
		        					errRowMap.put("err_row", String.valueOf(i));
		        					errRowMap.put("err_val", uploadFile.getExclCellValue(wb, cell));
		        					errRowMap.put("err_msg", "[" + String.valueOf((i+1)) + "행] 업로드할 컬럼수 초과 오류");
		        					rowErrMapList.add(errRowMap);
		        				}
		        				errCnt_01++;
		        			}
		        			// 이외 정상 케이스
		        			else {
		        				String requiredValidFail = "";
		        				StringBuilder rowVal = new StringBuilder();
		        				for(int j = 0; j < colSize; j++) {
		        					String cellVal = "";
		        					for(int k = 0; k < colSize2; k++) {
		        						if(keys[j].equals(keys2[k])) {
		        							// CELL 데이터 추출
				        					cell = row.getCell(k);
				        					cellVal = uploadFile.getExclCellValue(wb, cell);
				        					break;
		        						}
		        					}
		        					// 유효성 체크
		        					// 필수값
		        					if(Const.BOOLEAN_TRUE.equals(requiredMap.get(keys[j])) && "".equals(cellVal) && "".equals(requiredValidFail)) {
		        						requiredValidFail = Const.BOOLEAN_TRUE;
        							}
		        					// 중복 체크를 위한 값 저장
		        					if(!"".equals(cellVal)) {
		        						if(j > 0) {
			        						rowVal.append("|").append(cellVal);
			        					}else {
			        						rowVal.append(cellVal);
			        					}
		        					}
		        					rowMap.put(keys[j], cellVal);
		        				}
		        				// 엑셀 업로드 실패
		        				// 필수값 미입력 시
		        				if(Const.BOOLEAN_TRUE.equals(requiredValidFail)) {
		        					for(int j = 0; j < numOfCells; j++) {
			        					errRowMap = new HashMap<String, String>();
			        					cell = row.getCell(j);
			        					errRowMap.put("err_row", String.valueOf(i));
			        					errRowMap.put("err_val", uploadFile.getExclCellValue(wb, cell));
			        					errRowMap.put("err_msg", "[" + String.valueOf((i+1)) + "행] 필수값 오류");
			        					rowErrMapList.add(errRowMap);
			        				}
		        					errCnt_02++;
		        				}
		        				// 정상
		        				else {
		        					// 중복 체크
		        					String overLapFlag = Const.BOOLEAN_FALSE;
		        					for(int j = 0; j < rowValList.size(); j++) {
		        						if(rowVal.toString().equals(rowValList.get(j))) {
		        							overLapFlag = Const.BOOLEAN_TRUE;
		        							break;
		        						}
		        					}
		        					rowValList.add(rowVal.toString());
		        					if(Const.BOOLEAN_TRUE.equals(overLapFlag)) {
		        						for(int j = 0; j < numOfCells; j++) {
				        					errRowMap = new HashMap<String, String>();
				        					cell = row.getCell(j);
				        					errRowMap.put("err_row", String.valueOf(i));
				        					errRowMap.put("err_val", uploadFile.getExclCellValue(wb, cell));
				        					errRowMap.put("err_msg", "[" + String.valueOf((i+1)) + "행] 중복값 오류");
				        					rowErrMapList.add(errRowMap);
				        				}
		        						errCnt_03++;
		        					}else {
		        						rowMapList.add(rowMap);
		        					}
		        				}
		        			}
		        		}else {
		        			errRowMap = new HashMap<String, String>();
		        			errRowMap.put("err_row", String.valueOf(i));
        					errRowMap.put("err_val", "");
        					errRowMap.put("err_msg", "[" + String.valueOf((i+1)) + "행] 데이터 미입력 오류");
        					rowErrMapList.add(errRowMap);
        					errCnt_04++;
		        		}
		        	}
		        }else {
		        	// 엑셀 이외 파일 업로드한 경우 오류 처리
		        	validFileYn = Const.BOOLEAN_FAIL;
		        }
			}
		}catch (Exception e) {
			log.error(e.toString());
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// JSON 데이터 셋팅
		// 1. 정상 데이터
		json.put("records", rowMapList.size());
        json.put("total", 1);
        json.put("page", 1);
        json.put("rows", rowMapList);
        // 2. 오류 데이터
		json.put("errRows", rowErrMapList);
		json.put("errRowsCnt", errCnt_01+errCnt_02+errCnt_03+errCnt_04);
		json.put("errCnt_01", errCnt_01);
		json.put("errCnt_02", errCnt_02);
		json.put("errCnt_03", errCnt_03);
		json.put("errCnt_04", errCnt_04);
		// 3. 파일 유효성 여부 데이터
		json.put("VALID_FILE_YN", validFileYn);
		// 4. 결과 데이터
		json.put("RESULT", result);

		ResponseUtil.write(response, json.toJSONString());
	}
	/**
	 * 엑셀 업로드 후 오류 내역 다운로드
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@RequestMapping(value = "/main/downloadErrExcelList", method = RequestMethod.POST)
	public void downloadErrExcelList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 파라미터 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// 그리드 헤더 선언
		Map<String,String> gridHeader = parameterMap.parseGridHeader();
		// 오류 내역을 LIST로 변환
		String[] errRowArr = parameterMap.getValue("errRowArr").split(",");
		String[] errMsgArr = parameterMap.getValue("errMsgArr").split(",");
		String[] errValArr = parameterMap.getValue("errValArr").split(",", errRowArr.length);

		Map<String, String> rowMap = null;
        List<Map<String, String>> rowMapList = new ArrayList<Map<String, String>>();
        int key = 0;
        String compRow = "";
		for(int i = 0; i < errRowArr.length; i++) {
			if(i == 0) {
				rowMap = new HashMap<String, String>();
				compRow = errRowArr[i];
				rowMap.put("ERR_MSG", errMsgArr[i]);
				rowMap.put(String.valueOf(key), errValArr[i]);
			}else {
				if(!compRow.equals(errRowArr[i])) {
					rowMap.put("CELL_CNT", String.valueOf(key));
					rowMapList.add(rowMap);
					rowMap = new HashMap<String, String>();
					key = 0;
				}
				rowMap.put("ERR_MSG", errMsgArr[i]);
				rowMap.put(String.valueOf(key), errValArr[i]);
				compRow = errRowArr[i];
			}
			if(i == (errRowArr.length - 1)) {
				rowMap.put("CELL_CNT", String.valueOf(key+1));
				rowMap.put("ERR_MSG", errMsgArr[i]);
				rowMapList.add(rowMap);
			}
			key++;
		}

		// 엑셀 다운로드
		String fileNm = parameterMap.getValue("filename");
		FileDownLoad.exportErrExcelList(request, response, gridHeader, rowMapList, fileNm);
	}

	/**
	 * 엑셀 양식 다운로드
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@RequestMapping(value = "/main/downloadExcelForm", method = RequestMethod.POST)
	public void downloadExcelForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 파라미터 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// 그리드 헤더 선언
		Map<String,String> gridHeader = parameterMap.parseGridHeader();
		// 엑셀 다운로드
		FileDownLoad.exportExcelXslx(request, response, gridHeader, new ArrayList<Map<String, String>>(), parameterMap.getValue("filename"));
	}



	/**
	 * 통계관리 > 진입통계목록(BO)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/main/selectStaticsGridList", method = RequestMethod.POST)
	public void selectStaticsGridList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// 진입통계 목록 조회(그리드형)
			json = mainMgr.selectStaticsGridList(parameterMap);
		} catch (Exception e) {
			// Exception일 경우
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 통계관리 > 진입통계 초기값(BO:총 통계&당일 통계)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/main/selectStaticsCntList", method = RequestMethod.POST)
	public void selectStaticsCnt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// 진입통계 초기값 조회
			json = mainMgr.selectTmbrConnSttsInitCnt(parameterMap, json);
		} catch (Exception e) {
			// Exception일 경우
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}


	/**
	 * 공통 팝업 grid 설정 값 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/main/selectCommonPopupGrid", method = RequestMethod.POST)
	public void selectCommonPopupGrid(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// 공통 팝업 설정 값 조회
			json = mainMgr.selectCommonPopupGrid(parameterMap);
		} catch (UtilException e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
			json.put("MSG", e.getMessage());
			log.error(e.toString());
		} catch (Exception e) {
			log.error(e.toString());
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 공통 팝업 grid 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/main/selectCommonPopupList", method = RequestMethod.POST)
	public void selectCommonPopupList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// 진입통계 초기값 조회
			json = mainMgr.selectCommonPopupList(parameterMap);
		} catch (UtilException e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
			json.put("MSG", e.getMessage());
			log.error(e.toString());
		} catch (Exception e) {
			log.error(e.toString());
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

}



