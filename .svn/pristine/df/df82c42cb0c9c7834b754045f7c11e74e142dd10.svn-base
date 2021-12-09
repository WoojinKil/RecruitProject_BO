package kr.co.ta9.pandora3.psys.controller;

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
import kr.co.ta9.pandora3.app.util.DrmFileUtil;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.servlet.download.FileDownLoad;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.psys.manager.Psys1001Mgr;

/**
* <pre>
* 1. 클래스명 : Psys1003Controller
* 2. 설명 : 메뉴 권한관리 컨트롤러
* 3. 작성일 : 2018-03-27
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class Psys1001Controller extends CommonActionController{

	@Autowired
	private Psys1001Mgr psys1001Mgr;

	/**
	 * 프로그램관리 > 프로그램 그리드 목록 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1001List")
	public void getPsys1001List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 권한 그리드 목록 조회
			json = psys1001Mgr.getTsysPgmInfList(parameterMap);
		}
		catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 프로그램관리 > 프로그램 그리드 목록 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1001ExcelDownload")
	public void getPsys1001ExcelDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		//String result = Const.BOOLEAN_SUCCESS;
		// json 선언 aaaaaa
		JSONObject json = new JSONObject();
		
		try {
			// 권한 그리드 목록 조회
			json = psys1001Mgr.getTsysPgmInfList(parameterMap);
			// gridHeader 선언
			Map<String,String> gridHeader = parameterMap.parseGridHeader();
			List<Map<String, String>> gridList = (List) json.get("rows");
			String fileNm = parameterMap.getValue("filename");
			FileDownLoad.exportExcelXslx(request,response, gridHeader, gridList,fileNm);
			//FileDownLoad.exportExcel(response, gridHeader, gridList);
			//DrmFileUtil.exportExcelXslx(request,response,gridHeader, gridList,fileNm);
		}
		catch (Exception e) {
			// Exception일 경우
			//result = Const.BOOLEAN_FAIL;
		}

	}


	/**
	 * 프로그램관리 > 프로그램 버튼목록 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getTsysPgmInfBtnList")
	public void getPgmBtnList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 권한 그리드 목록 조회
			json = psys1001Mgr.getTsysPgmInfBtnList(parameterMap);
		}
		catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 메뉴관리 > 메뉴권한 저장
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/savePsys1001List", method = RequestMethod.POST)
	public void savePsys1001List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 메뉴 권한 저장
			psys1001Mgr.saveTsysPgmInfList(parameterMap);
		}
		catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/savePsys1001", method = RequestMethod.POST)
	public void savePsys1001(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 메뉴 권한 저장
			json.put("MSG", psys1001Mgr.saveTsysPgmInf(parameterMap));
		}
		catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
		    
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
}
