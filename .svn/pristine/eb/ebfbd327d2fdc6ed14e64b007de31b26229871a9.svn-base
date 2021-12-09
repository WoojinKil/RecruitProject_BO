package kr.co.ta9.pandora3.pdsp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.dto.DataMap;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.pdsp.manager.Pdsp1006Mgr;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
/**
* <pre>
* 1. 클래스명 : Pdsp1006Controller
* 2. 설명: 메인팝업상세보기
* 3. 작성일 : 2018-03-29
* 4.작성자   : TANINE
* </pre>
*/

@Controller
public class Pdsp1006Controller extends CommonActionController{
	@Autowired
	private Pdsp1006Mgr pdsp1006Mgr;
	
	/**
	 * 메인 팝업 조회 (단건)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pdsp/getPdsp1006", method = RequestMethod.POST)
	public void getPdsp1006(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// 메인 팝업 정보 조회(단건)
			DataMap mainPopMap = pdsp1006Mgr.selectTdspMnPopInfo(parameterMap);
			json.put("mainPopMap", mainPopMap);
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
	 * 팝업관리 > 메인팝업등록(BO)
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pdsp/savePdsp1006", method = RequestMethod.POST)
	public void savePdsp1006(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = getParameterMap(request, response);
		log.debug(parameterMap);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			pdsp1006Mgr.saveTdspMnPopInfo(parameterMap);
		}catch(Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
			json.put("errorMsg", e.getMessage());
		}
		json.put("result", result);
		ResponseUtil.write(response, json.toJSONString());
	}
}
