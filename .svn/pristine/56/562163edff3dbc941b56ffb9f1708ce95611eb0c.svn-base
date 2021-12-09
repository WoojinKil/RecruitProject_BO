package kr.co.ta9.pandora3.pwzn.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.servlet.download.FileDownLoad;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspMst;
import kr.co.ta9.pandora3.pwzn.manager.Pwzn1001Mgr;
/**
* <pre>
* 1. 클래스명 : Pwzn1001Controller
* 2. 설명 : 웹진통합조회 컨트롤러
* 3. 작성일 : 2018-03-29
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class Pwzn1001Controller extends CommonActionController{
	
	@Autowired
	private Pwzn1001Mgr pwzn1001Mgr;
	
	/**
	 * 웹진 목록 조회(그리드형)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pwzn/getPwzn1001List", method = RequestMethod.POST)
	public void getPwzn1001List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// 웹진 그리드 리스트 조회
			json = pwzn1001Mgr.selectTbbsWbznDspMstGridList(parameterMap);
		} catch (Exception e) {
			e.printStackTrace();
			// Exception일 경우 
			result = Const.BOOLEAN_FAIL;
		}
		
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 웹진관리 > 웹진통합조회(BO) : 삭제 - 그리드형
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pwzn/deletePwzn1001List", method = RequestMethod.POST)
	public void deletePwzn1001List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = getParameterMap(request, response);		
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			pwzn1001Mgr.deleteTbbsWbznDspGridList(parameterMap);
		}
		catch (Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}		
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 웹진 웹 메일 발송
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pwzn/getPwzn1001sndWbznEml", method = RequestMethod.POST)
	public void getPwzn1001sndWbznEml(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		result=pwzn1001Mgr.sndWbznEml(parameterMap, request);
		// json에 결과 담기
		json.put("result", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 웹진관리 > 웹진- PDF 파일정보 취득
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pwzn/getPwzn1001P001")
	public void getPwzn1001P001(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = getParameterMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			// 웹진 MST 정보 수정
			TbbsWbznDspMst webMst = pwzn1001Mgr.selectTbbsWbznDspMstPdfNm(parameterMap);
			if(webMst != null) {
				json.put("pdf_nm"     , webMst.getPdf_nm());
				json.put("chg_pdf_nm" , webMst.getChg_pdf_nm());
				json.put("pdf_fpath", webMst.getPdf_fpath());
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 웹진 PDF 파일 정보 저장/삭제
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pwzn/savePwzn1001P001")
	public void savePwzn1001P001(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 변수 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		log.debug(parameterMap);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		List<Map<String, Object>> fileChkList = new ArrayList<Map<String, Object>>();
		try {
			List<Map<String, Object>> sysFileInfo = pwzn1001Mgr.updateWebzinePdfFileInfo(parameterMap);
			String[] pdfChkArr = parameterMap.getValue("pdfChkArr").split(",");
			for(int i = 0; i < sysFileInfo.size(); i++) {
				Map<String, Object> fileChkMap = new HashMap<String, Object>();
				fileChkMap.put("file_id", pdfChkArr[i].toString());
				fileChkMap.put("file_nm", sysFileInfo.get(i).get("file_nm"));
				fileChkMap.put("file_path", sysFileInfo.get(i).get("file_path"));
				fileChkList.add(fileChkMap);
			}
			json.put("fileChkList", fileChkList);
		}catch(Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}
		// JSON 결과값 셋팅
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 시스템사용자관리 > 시스템사용자 그리드 목록 엑셀다운로드 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/pwzn/getPwzn1001XlsxDwld")
	public void getPwzn1001XlsxDwld(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 권한 그리드 목록 조회
			json = pwzn1001Mgr.selectTbbsWbznDspMstGridList(parameterMap);
			// gridHeader 선언
			Map<String,String> gridHeader = parameterMap.parseGridHeader();
			List<Map<String, String>> gridList = (List) json.get("rows");
			String fileNm = parameterMap.getValue("filename");
			FileDownLoad.exportExcelXslx(request,response, gridHeader, gridList,fileNm);
			//FileDownLoad.exportExcel(response, gridHeader, gridList);
		}
		catch (Exception e) {
			e.printStackTrace();
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}
	}
}
