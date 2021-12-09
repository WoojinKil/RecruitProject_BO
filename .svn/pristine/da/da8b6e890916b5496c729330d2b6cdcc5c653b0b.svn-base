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
import kr.co.ta9.pandora3.psys.manager.Psys1029Mgr;

/**
* <pre>
* 1. 클래스명 : Psys1029Controller
* 2. 설명 : 시스템회원 메뉴 권한관리 컨트롤러
* 3. 작성일 : 2019-03-18
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class Psys1029Controller extends CommonActionController {

	@Autowired
	private Psys1029Mgr psys1029Mgr;

	/**
	 * 관리자메뉴할당 그리드 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getPsys1029AdmMnuList", method = RequestMethod.POST)
	public void getPsys1029AdmMnuList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// PARAMETERMAP 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// RESULT 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSON 선언
		JSONObject json = new JSONObject();
		try {
			// 관리자메뉴할당 그리드 조회
			json = psys1029Mgr.getTsysAdmMnuRtnnGrdList(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		
		// JSON 결과 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	
	
	/**
	 * 관리자메뉴할당 정보 저장
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/savePsys1029AdmMnuList", method = RequestMethod.POST)
	public void savePsys1029AdmMnuList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// PARAMETERMAP 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// RESULT 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSON 선언
		JSONObject json = new JSONObject();
		// 할당여부 선언 
		
		try {
			// 관리자메뉴할당 여부 조회
			psys1029Mgr.savePsys1029AdmMnuList(parameterMap);
			
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		
		// JSON 결과 반환
		json.put("RESULT", result);
		//json.put("rtnnYn", rtnnYn);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 권리자메뉴버튼할당 정보 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getPsys1029AdmMnuBtnInf", method = RequestMethod.POST)
	public void getPsys1029AdmMnuBtnInf(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// PARAMETERMAP 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// RESULT 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSON 선언
		JSONObject json = new JSONObject();
		try {
			// 권리자메뉴버튼할당 정보 조회
			json = psys1029Mgr.getTsysAdmMnuBtnRtnnInf(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		
		// JSON 결과 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 권리자메뉴버튼할당 정보 삭제 후 저장
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/savePsys1029AdmMnuBtnList", method = RequestMethod.POST)
	public void savePsys1029AdmMnuBtnList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// PARAMETERMAP 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// RESULT 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSON 선언
		JSONObject json = new JSONObject();
		try {
			// 권리자메뉴버튼할당 정보 삭제 후 저장
			psys1029Mgr.saveTsysAdmMnuBtnRtnnList(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		
		// JSON 결과 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
}
