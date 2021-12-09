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
import kr.co.ta9.pandora3.psys.manager.Psys1025Mgr;
/**
* <pre>
* 1. 클래스명 : Psys1025Controller
* 2. 설명: 프론트메뉴접속이력 컨트롤러
* 3. 작성일 : 2018-07-27
* 4.작성자   : TANINE
* </pre>
*/
@Controller
public class Psys1025Controller extends CommonActionController{
	@Autowired
	private Psys1025Mgr psys1025Mgr;
	
	/**
	 * 시스템관리 > 공통팝업관리 > 공통팝업관리 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getPsys1025List", method = RequestMethod.POST)
	public void getPsys1025List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// 진입통계 목록 조회(그리드형)
			json = psys1025Mgr.selectTcmnPopupInfList(parameterMap);
		} catch (Exception e) {
			// Exception일 경우 
			result = Const.BOOLEAN_FAIL;
		}
		
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 시스템관리 > 공통팝업관리 > 공통팝업관리 등록/수정/삭제
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/savePsys1025", method = RequestMethod.POST)
	public void savePsys1025(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 메뉴 권한 저장
			psys1025Mgr.saveTcmnPopupInf(parameterMap);
		}
		catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
			json.put("MSG", parameterMap.getValue("MSG"));
		}		
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
}
