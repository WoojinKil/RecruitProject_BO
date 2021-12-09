package kr.co.ta9.pandora3.pdsp.controller;

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
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.pdsp.manager.Pdsp1002Mgr;
/**
* <pre>
* 1. 클래스명 : Pdsp1002Controller
* 2. 설명: 템플릿상세조회
* 3. 작성일 : 2018-03-28
* 4.작성자   : TANINE
* </pre>
*/
@Controller
public class Pdsp1002Controller extends CommonActionController {
	
	@Autowired
	private Pdsp1002Mgr pdsp1002Mgr;

	/**
	 * 템플릿 조회(단건)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pdsp/getPdsp1002List", method = RequestMethod.POST)
	public void getPdsp1002List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// 템플릿 단건 조회
			Map templateMap = pdsp1002Mgr.getTdspTmplInfMap(parameterMap);
			json.put("templateMap", templateMap);
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
	 * 템플릿 > 등록 및 수정 : 1건씩
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pdsp/updatePdsp1002", method = RequestMethod.POST)
	public void updatePdsp1002(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 템플릿 등록 수정
			pdsp1002Mgr.update(parameterMap);
		}
		catch (Exception e) {
			e.printStackTrace();
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
}
