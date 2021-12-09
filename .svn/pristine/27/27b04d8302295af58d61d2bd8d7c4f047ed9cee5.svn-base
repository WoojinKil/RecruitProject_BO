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
import kr.co.ta9.pandora3.common.dto.DataMap;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.psys.manager.Psys1032Mgr;

/**
* <pre>
* 1. 클래스명 : Psys1032Controller
* 2. 설명 : 배치 로그 모니터링 컨트롤러
* 3. 작성일 : 2019-05-27
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class Psys1032Controller  extends CommonActionController {
	
	@Autowired
	private Psys1032Mgr psys1032Mgr;
	
	
	
	/**
	 * 시스템 관리 > 모니터링 > 배치 모니터링
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1032List", method = RequestMethod.POST)
	public void getPsys1032List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		
		// json 선언
		JSONObject json = new JSONObject();
		
		try {
			// 배치 그리드 목록 조회
			json = psys1032Mgr.selectTsysBatchGridList(parameterMap);
			
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
		
	}
	/**
	 * 시스템 관리 > 모니터링 > 배치 모니터링
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1032p001", method = RequestMethod.POST)
	public void getPsys1032p001(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		
		// json 선언
		JSONObject json = new JSONObject();
		
		try {
			
			//배치 로그 상세 조회
			DataMap batchMap = psys1032Mgr.selectTsysBatchDetail(parameterMap);
			
			json.put("batchMap", batchMap); 
			
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	
}
