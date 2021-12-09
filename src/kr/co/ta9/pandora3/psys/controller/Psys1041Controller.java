package kr.co.ta9.pandora3.psys.controller;

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
import kr.co.ta9.pandora3.psys.manager.Psys1041Mgr;

/**
* <pre>
* 1. 클래스명 : Psys1040Controller
* 2. 설명 : 직급관리 컨트롤러
* 3. 작성일 : 2019-11-01
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class Psys1041Controller extends CommonActionController {
	
	@Autowired
	private Psys1041Mgr psys1041Mgr;
	
	/**
	 * 코드 관리 > 직무 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getPsys1041List", method = RequestMethod.POST)
	public void getPsys1041List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ParameterMap parameterMap = getParameterGridMap(request, response);
		
		JSONObject json = new JSONObject();
		
		String result = Const.BOOLEAN_SUCCESS;
		
		try {
			
			json = psys1041Mgr.selectTsysJobInfGridList(parameterMap);
			
			
		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
		
	}
}
