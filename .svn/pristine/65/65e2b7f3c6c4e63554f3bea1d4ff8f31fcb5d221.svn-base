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
import kr.co.ta9.pandora3.psys.manager.Psys1035Mgr;

/**
* <pre>
* 1. 클래스명 : Psys1035Controller
* 2. 설명 :개별 메뉴 컨트롤러
* 3. 작성일 : 2019-10-18
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class Psys1035Controller  extends CommonActionController {
	
	@Autowired
	private Psys1035Mgr psys1035Mgr;
	
	
	/**
	 * 사용자 권한 메뉴 신청 목록 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getPsys1035AdmMnuList", method = RequestMethod.POST)
	public void getPsys1035AdmMnuList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		
		// json 선언
		JSONObject json = new JSONObject();
		
		try {
			// 메뉴권한 그리드 목록 조회
			json = psys1035Mgr.selectTsysAdmMnuUsrRtnnGrdList(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());		
	}
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/psys/savePsys1035ApplMnuBtnList", method = RequestMethod.POST)
	public void savePsys1034ApplNoList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		
		// json 선언
		JSONObject json = new JSONObject();
		
		try {
			// 사용자 권한 저장
			psys1035Mgr.savePsys1035ApplMnuBtnList(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
		
	}
	
	
	
	
}
