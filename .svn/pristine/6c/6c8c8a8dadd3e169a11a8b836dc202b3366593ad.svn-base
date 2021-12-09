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
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.servlet.download.FileDownLoad;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.psys.manager.Psys1062Mgr;

/**
 * <pre>
 * 1. 클래스명 : Psys1022Controller
 * 2. 설명 : VIP 접속 이력
 * 3. 작성일 : 2018-04-24
 * 4. 작성자 : TANINE
 * </pre>
 */
@Controller
public class Psys1062Controller extends CommonActionController{

	@Autowired
	private Psys1062Mgr psys1062Mgr;

	/**
	 * 사용자 통계 > 시스템별 접속자 수
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/selectPsys1062List", method = RequestMethod.POST)
	public void selectPsys1062List(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// jsonObject json 선언
		JSONObject json = new JSONObject();

		try {
			json = psys1062Mgr.selectTbBcpcLoginTotStrList(parameterMap);
		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 사용자 통계 > 시스템별 접속자 수 엑셀 다운로드
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1062XlsxDwld")
	public void getPsys1062XlsxDwld(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// json 선언
		JSONObject json = new JSONObject();

		try {
			
			json = psys1062Mgr.selectTbBcpcLoginTotStrList(parameterMap);
			
			Map<String,String> header = parameterMap.parseGridHeader();
			List<Map<String, String>> list = (List)json.get("rows");
			String fileName = parameterMap.getValue("fileName");

			//DrmFileUtil.exportExcelXslx(request,response,header, list,fileName);
			FileDownLoad.exportExcelXslx(request,response,header, list,fileName);
		}
		catch (Exception e) {
			log.debug(e);
		}
	}
	
	
	@RequestMapping(value="/psys/selectPsys1062StrList")
	public void selectStrList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// jsonObject json 선언
		JSONObject json = new JSONObject();

		try {
			json = psys1062Mgr.selectStrList(parameterMap);
		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
}
