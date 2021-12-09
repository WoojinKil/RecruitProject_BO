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
import kr.co.ta9.pandora3.app.util.DrmFileUtil;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.servlet.download.FileDownLoad;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.pdsp.manager.Pdsp1011Mgr;
/**
* <pre>
* 1. 클래스명 : Pdsp1011Controller
* 2. 설명: 사이트 조회
* 3. 작성일 : 2018-04-23
* 4. 작성자   : TANINE
* </pre>
*/

@Controller
public class Pdsp1011Controller extends CommonActionController{
	
	@Autowired
	private Pdsp1011Mgr pdsp1011Mgr;

	/**
	 * 사이트 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pdsp/getPdsp1011List", method=RequestMethod.POST)
	public void getPdsp1011List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = getParameterGridMap(request, response);

		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			json = pdsp1011Mgr.selectTdspSysInfList(parameterMap);
		}
		catch (Exception e) {
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}



	/**
	 * 사이트 저장
	 *
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pdsp/savePdsp1011", method = RequestMethod.POST)
	public void savePdsp1011(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 상위메뉴 저장
			pdsp1011Mgr.saveTdspSysInf(parameterMap);
		} catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
			// json에 MSG 담기
			json.put("MSG", parameterMap.getValue("MSG"));
			log.error(e.toString());
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 사이트 콤보 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pdsp/getPdsp1011ListSit", method=RequestMethod.POST)
	public void getPdsp1011ListSit(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = getParameterMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			json = pdsp1011Mgr.selectTdspSysInfComboList(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
			log.error(e.toString());
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 로그인 이력 적재 가능 사이트  조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pdsp/getPdsp1011ListLogSit", method=RequestMethod.POST)
	public void getPdsp1011ListLogSit(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = getParameterMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			json = pdsp1011Mgr.selectTdspSysInfLogComboList(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
			log.error(e.toString());
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 메뉴관리 > 사이트 목록 엑셀다운로드
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/pdsp/getPdsp1011XlsxDwld")
	public void getPdsp1011XlsxDwld(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 권한 그리드 목록 조회
			json = pdsp1011Mgr.selectTdspSysInfList(parameterMap);

			// gridHeader 선언
			Map<String,String> gridHeader = parameterMap.parseGridHeader();

			List<Map<String, String>> gridList = (List) json.get("rows");

			for(int i=0; i<gridList.size();i++){
				if("Y".equals(gridList.get(i).get("US_YN"))){
					gridList.get(i).replace("US_YN", "사용");
				}else if("N".equals(gridList.get(i).get("US_YN"))){
					gridList.get(i).replace("US_YN", "미사용");
				}
			}

			String fileNm = parameterMap.getValue("filename");
			FileDownLoad.exportExcelXslx(request,response, gridHeader, gridList,fileNm);
			//FileDownLoad.exportExcel(response, gridHeader, gridList);
			//DrmFileUtil.exportExcelXslx(request,response,gridHeader, gridList,fileNm);
		}
		catch (Exception e) {
			// Exception일 경우
			log.error(e.toString());
		}
	}

	/**
	 * 접근 가능한 사이트 정보 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pdsp/getAccessSitList", method=RequestMethod.POST)
	public void getAccessSitList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = getParameterMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			json = pdsp1011Mgr.getAccessSitList(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
			log.error(e.toString());
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

}
