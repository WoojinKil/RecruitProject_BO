package kr.co.ta9.pandora3.pdsp.controller;

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
import kr.co.ta9.pandora3.pdsp.manager.Pdsp1001Mgr;

/**
* <pre>
* 1. 클래스명 : Pdsp1001Controller
* 2. 설명: 템플릿통합조회
* 3. 작성일 : 2018-03-28
* 4.작성자   : TANINE
* </pre>
*/
@Controller
public class Pdsp1001Controller extends CommonActionController {
	
	@Autowired
	private Pdsp1001Mgr pdsp1001Mgr;
	
	/**
	 * 템플릿 목록 조회(그리드형)
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pdsp/getPdsp1001TmplList", method = RequestMethod.POST)
	public void getPdsp1001TmplList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();
		
		try {
			// 템플릿 목록 조회(그리드형)
			json = pdsp1001Mgr.selectTdspTmplInfGridList(parameterMap);
		}catch(Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}
		
		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 템플릿 등록/수정/삭제 (복수)
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pdsp/savePdsp1001TmplList", method = RequestMethod.POST)
	public void savePdsp1001TmplList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();
		
		try {
			// 템플릿 등록/수정/삭제 (복수)
			pdsp1001Mgr.saveTdspTmplInf(parameterMap);
		}catch(Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());		
	}
	
	/**
	 * 엑셀다운로드 
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pdsp/getPdsp1001XlsxDwld")
	public void getPdsp1001XlsxDwld(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// JSONObject 선언
		JSONObject json = new JSONObject();
		
		try {
			// 템플릿 목록 조회(그리드형)
			json = pdsp1001Mgr.selectTdspTmplInfGridList(parameterMap);
			// 그리드 헤더 선언
			Map<String,String> gridHeader = parameterMap.parseGridHeader();
			List<Map<String, String>> gridList = (List<Map<String, String>>)json.get("rows");
			for(int i = 0; i < gridList.size(); i++) {
				if(Const.BOOLEAN_TRUE.equals(gridList.get(i).get("US_YN"))) {
					gridList.get(i).replace("US_YN", "사용");
				}else if(Const.BOOLEAN_FALSE.equals(gridList.get(i).get("US_YN"))) {
					gridList.get(i).replace("US_YN", "미사용");
				}
			}
			// 엑셀다운로드
			String fileNm = parameterMap.getValue("filename");
			FileDownLoad.exportExcelXslx(request,response, gridHeader, gridList,fileNm);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}