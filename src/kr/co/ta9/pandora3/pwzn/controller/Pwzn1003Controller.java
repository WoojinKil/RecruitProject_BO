package kr.co.ta9.pandora3.pwzn.controller;

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
import kr.co.ta9.pandora3.pwzn.manager.Pwzn1003Mgr;
/**
* <pre>
* 1. 클래스명 : Pwzn1003Controller
* 2. 설명 : 웹진컨텐츠등록 컨트롤러
* 3. 작성일 : 2018-03-29
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class Pwzn1003Controller extends CommonActionController{
	
	@Autowired
	private Pwzn1003Mgr pwzn1003Mgr;
	
	/**
	 * 웹진관리 > 웹진등록 - 웹진ID 생성(BO)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pwzn/savePwzn1003")
	public void savePwzn1003(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = getParameterMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			pwzn1003Mgr.saveTbbsWbznMstAndMn(parameterMap);
		}catch(Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
}
