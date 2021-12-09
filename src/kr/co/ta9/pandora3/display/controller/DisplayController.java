/**
* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명 : kr.co.ta9.pandora3.display.controller
* 3. 파일명 : DisplayController
* 4. 작성일 : 2017-11-27
* </pre>
*/
package kr.co.ta9.pandora3.display.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.display.manager.DisplayMgr;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspMst;
import kr.co.ta9.pandora3.pwzn.manager.Pwzn1001Mgr;
import kr.co.ta9.pandora3.pwzn.manager.Pwzn1002Mgr;
import kr.co.ta9.pandora3.pwzn.manager.Pwzn1003Mgr;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.common.util.TextUtil;

import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.display.controller
* 2. 타입명 : class
* 3. 작성일 : 2017-11-27
* 4. 설명 : 전시관리 컨트롤러
* </pre>
*/
@Controller
public class DisplayController extends CommonActionController {
	@Value("${smtp.host}")
	private String smtp_host;
	
	@Value("${smtp.port}")
	private String smtp_port;
	
	@Value("${smtp.username}")
	private String smtp_username;
	
	@Value("${smtp.password}")
	private String smtp_password;
	
	@Value("${smtp.sender}")
	private String smtp_sender;
	
	@Autowired
	private DisplayMgr displayMgr;
	
	@Autowired
	private Pwzn1002Mgr pwzn1002Mgr;
	@Autowired
	private Pwzn1001Mgr pwzn1001Mgr;
	@Autowired
	private Pwzn1003Mgr pwzn1003Mgr;
	


	/**
	 * Front 전시메뉴 리스트 조회(1&2Depth)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/display/selectDispFrontMenuList")
	public void selectDispFrontMenuList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// Front 전시메뉴 리스트 조회(1&2Depth)
			json = displayMgr.selectDispFrontMenuList();
			
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
	 * Front 전시메뉴 리스트 조회(3Depth)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/display/selectDispFrontMenu3DptList")
	public void selectDispFrontMenu3DptList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			String tmp_id = StringUtils.isNotEmpty(request.getParameter("tmp_id")) ? request.getParameter("tmp_id") : "";
			// Front 전시메뉴 리스트 조회(3Depth)
			json = displayMgr.selectDispFrontMenu3DptList(Integer.parseInt(tmp_id));
			
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
	 * 웹진관리 > 웹진등록 - 웹진ID 생성(BO)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/display/insertWebzineMstInfo")
	public void insertWebzineMstInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = getParameterMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			// 웹진등록 - 웹진ID 생성
			int webzine_id = pwzn1003Mgr.insertTbbsWbznMst(parameterMap);
			if(webzine_id > 0) {
				json.put("webzine_id", webzine_id);
			} else {
				result = Const.BOOLEAN_FAIL;
			}
		}catch(Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 웹진관리 > 웹진- MST정보 수정(BO)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/display/updateWebzineMstInfo")
	public void updateWebzineMstInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = getParameterMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			// 웹진 MST 정보 수정
			pwzn1002Mgr.updateWbznMstInf(parameterMap);
			
		}catch(Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 웹진관리 > 웹진 메인 컨텐츠 등록/수정(BO)
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/display/changeWebzineMainInfo", method = RequestMethod.POST)
	public void changeWebzineMainInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = getParameterMap(request, response);
		log.debug(parameterMap);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			displayMgr.changeWebzineMainInfo(parameterMap);
		}catch(Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
			json.put("errorMsg", e.getMessage());
		}
		json.put("result", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	
	
	
	/**
	 * 웹진 상세 정보 조회(마스터/메인)
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/display/selectWebzDtlInfo")
	public void selectWebzDtlInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 변수 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		log.debug(parameterMap);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		Map<String, Object> webzDispMstInfo = new HashMap<String, Object>();
		List<Map<String, Object>> webzDispMainList = new ArrayList<Map<String, Object>>();
		try {
			// 1. 웹진 마스터 정보 조회
			webzDispMstInfo = pwzn1002Mgr.selectTbbsWbznDspMstInf(parameterMap);
			
			// 2. 웹진 메인 정보 조회
			webzDispMainList = pwzn1002Mgr.selectTbbsWbznDspMnInfList(parameterMap);
		}catch(Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}
		// JSON 결과값 셋팅
		json.put("webzDispMstInfo", webzDispMstInfo);
		json.put("webzDispMainList", webzDispMainList);
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	
	
	
	
	

	/**
	 * 웹진 메일발송 시 문자수 제한
	 * @param targetStr
	 * @return
	 */
	private String characterLimit(String targetStr, String tmp_id, String category_id, String type) {
		// 문자수 제한 기준변수 선언
		int titleLimit = 0;
		int subTitleLimit = 0;
		int textLimit = 0;
		
		// 웹진 타입별 문자수 기준 설정(BYTE)
		if("1".equals(tmp_id)) {
			if("1".equals(category_id)) {
				titleLimit = 40;
				textLimit = 70;
			}
			else if("2".equals(category_id)) {
				titleLimit = 36;
				textLimit = 90;
			}
			else if("3".equals(category_id)) {
				titleLimit = 40;
				subTitleLimit = 70;
				textLimit = 145;
			}
			else {
				titleLimit = 40;
			}
		} 
		else if ("2".equals(tmp_id)){
			if("1".equals(category_id)) {
				titleLimit = 32;
				textLimit = 62;
			}
			else if("2".equals(category_id)) {
				titleLimit = 28;
				textLimit = 150;
			}
			else if("3".equals(category_id)) {
				titleLimit = 14;
				subTitleLimit = 24;
				textLimit = 60;
			}
			else if("4".equals(category_id) || "5".equals(category_id)) {
				titleLimit = 24;
				textLimit = 34;
			}
			else {
				titleLimit = 24;
			}
		}
		
		// 문자수 제한
		int indexEnd = 0;
		if("TITLE".equals(type)) indexEnd = titleLimit;
		else if("SUB_TITLE".equals(type)) indexEnd = subTitleLimit;
		else if("TEXT".equals(type))  indexEnd = textLimit;
		String rtnText = "";
		long len = TextUtil.getLength(targetStr, TextUtil.CHARSET_NON_UTF8);
		if(len > 0 && (int)len > indexEnd) {
			rtnText = TextUtil.substring(targetStr, (long)indexEnd) + "...";
		}
		else {
			rtnText = targetStr;
		}
		
		return rtnText;
	}
	
	
	
	
	/**
	 * 웹진 PDF 파일 정보 저장/삭제
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/display/updateWebzinePdfFileInfo")
	public void updateWebzinePdfFileInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
	 * 웹진관리 > 웹진- PDF 파일정보 취득
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/display/selectWebzDispMstPdfName")
	public void selectWebzDispMstPdfName(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = getParameterMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			// 웹진 MST 정보 수정
			TbbsWbznDspMst wbznDspMst = pwzn1001Mgr.selectTbbsWbznDspMstPdfNm(parameterMap);
			if(wbznDspMst != null) {
				json.put("pdf_name", wbznDspMst.getPdf_nm());
				json.put("chg_pdf_name", wbznDspMst.getChg_pdf_nm());
				json.put("pdf_full_path", wbznDspMst.getPdf_fpath());
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
}



