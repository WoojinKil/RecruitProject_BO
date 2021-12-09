package kr.co.ta9.pandora3.front.display.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.front.display.manager.DspMgr;

/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.front.display.controller
* 2. 타입명 : class
* 3. 작성일 : 2019-03-25
* 4. 설명 : 전시 컨트롤러
* </pre>
*/
@Controller
public class DspController extends CommonActionController {
	
	@Autowired
	private DspMgr dspMgr;

	/**
	 * 프론트 메뉴 목록 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/display/selectFrntMnuList")
	public void selectFrntMnuList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);	
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSON 선언
		JSONObject json = new JSONObject();
		try {
			// 프론트 메뉴 목록 조회
			json = dspMgr.selectFrntMnuList(parameterMap);
		}catch(Exception e) {
			e.printStackTrace();
			// Exception 
			result = Const.BOOLEAN_FAIL;
		}
		
		// JSON 결과 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 1뎁스 메뉴 정보 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/display/select1DepthMnuInf")
	public void select1DepthMnuInf(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);	
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSON 선언
		JSONObject json = new JSONObject();
		try {
			// 1뎁스 메뉴 정보 조회
			json = dspMgr.select1DepthMnuInf(parameterMap);
		}catch(Exception e) {
			e.printStackTrace();
			// Exception 
			result = Const.BOOLEAN_FAIL;
		}
		
		// JSON 결과 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 2뎁스 메뉴 목록 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/display/select2DepthMnuList")
	public void select2DepthMnuList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);	
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSON 선언
		JSONObject json = new JSONObject();
		try {
			// 프론트 메뉴 목록 조회
			json = dspMgr.selectFrntMnuList(parameterMap);
		}catch(Exception e) {
			e.printStackTrace();
			// Exception 
			result = Const.BOOLEAN_FAIL;
		}
		
		// JSON 결과 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
}