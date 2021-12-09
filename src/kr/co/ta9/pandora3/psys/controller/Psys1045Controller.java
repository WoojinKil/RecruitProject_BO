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
import kr.co.ta9.pandora3.psys.manager.Psys1045Mgr;

/**
* <pre>
* 1. 클래스명 : Psys1045Controller
* 2. 설명 : 권한 신청이력
* 3. 작성일 : 2019-11-01
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class Psys1045Controller extends CommonActionController {

	@Autowired
	private Psys1045Mgr psys1045Mgr;

	/**
	 * 권한 관리 > 권한 신청 이력
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getPsys1045List", method = RequestMethod.POST)
	public void getPsys1045List(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ParameterMap parameterMap = getParameterGridMap(request, response);

		JSONObject json = new JSONObject();

		String result = Const.BOOLEAN_SUCCESS;

		try {

			json = psys1045Mgr.selectTbLgapAthrappHList(parameterMap);


		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());

	}

	/**
	 * 권한승인이력 > 시스템 로그인 이력 엑셀다운로드
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1045XlsxDwld")
	public void getPsys1021XlsxDwld(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// json 선언
		JSONObject json = new JSONObject();

		try {
			// 권한 그리드 목록 조회
			json = psys1045Mgr.selectTbLgapAthrappHList(parameterMap);

			Map<String,String> header = parameterMap.parseGridHeader();
			List<Map<String, String>> list = (List)json.get("rows");
			String fileName = parameterMap.getValue("fileName");

			kr.co.ta9.pandora3.app.util.FileDownLoad.exportExcelXslx(request,response, header, list, fileName);
			//DrmFileUtil.exportExcelXslx(request,response,header, list,fileName);
		}
		catch (Exception e) {
			log.debug(e);
		}
	}
}
