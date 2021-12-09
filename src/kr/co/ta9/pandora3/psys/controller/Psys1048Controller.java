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
import kr.co.ta9.pandora3.psys.manager.Psys1048Mgr;

/**
* <pre>
* 1. 클래스명 : Psys1037Controller
* 2. 설명 : 권한그룹관리 컨트롤러
* 3. 작성일 : 2018-10-28
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class Psys1048Controller extends CommonActionController{
	
	@Autowired
	private Psys1048Mgr psys1048Mgr;
	
	/**
	 * 권한관리 > 권한 승인 관리
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getPsys1048List", method = RequestMethod.POST)
	public void getPsys1048List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 그룹 권한 그리드 목록 조회
			json = psys1048Mgr.selectTbBcpcAtharAppVIP(parameterMap);
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
	 * 권한관리 > 승인 관리
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/savePsys1048List", method = RequestMethod.POST)
	public void savePsys1048List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			psys1048Mgr.saveTbBcpcAthrApp(parameterMap);
			
		} catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
		}		
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
}
