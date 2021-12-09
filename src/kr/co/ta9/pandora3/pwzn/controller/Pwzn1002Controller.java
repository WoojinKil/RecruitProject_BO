package kr.co.ta9.pandora3.pwzn.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import kr.co.ta9.pandora3.pwzn.manager.Pwzn1002Mgr;
/**
* <pre>
* 1. 클래스명 : Pwzn1002Controller
* 2. 설명 : 웹진컨텐츠상세조회 컨트롤러
* 3. 작성일 : 2018-03-29
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class Pwzn1002Controller extends CommonActionController{
	
	@Autowired
	private Pwzn1002Mgr pwzn1002Mgr;
	
	/**
	 * 웹진관리 > 웹진- MST정보 수정(BO)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pwzn/updatePwzn1002")
	public void updatePwzn1002(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = getParameterMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			// 웹진 MST 정보 수정
			pwzn1002Mgr.updateWbznMstInf(parameterMap);
			
		}catch(Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 웹진관리 > 웹진 메인 컨텐츠 등록/수정(BO)
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pwzn/savePwzn1002", method = RequestMethod.POST)
	public void savePwzn1002(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = getParameterMap(request, response);
		//log.debug(parameterMap);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			pwzn1002Mgr.saveTbbsWbznDspMnInf(parameterMap);
		} catch(Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
			json.put("errorMsg", e.getMessage());
		}
		json.put("result", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 웹진 상세 정보 조회(마스터/메인)
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pwzn/getPwzn1002")
	public void getPwzn1002(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 변수 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		//log.debug(parameterMap);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		Map<String, Object> wbznDspMstInf = new HashMap<String, Object>();
		List<Map<String, Object>> wbzDspMnList = new ArrayList<Map<String, Object>>();
		try {
			// 1. 웹진 마스터 정보 조회
			wbznDspMstInf = pwzn1002Mgr.selectTbbsWbznDspMstInf(parameterMap);
			
			// 2. 웹진 메인 정보 조회
			wbzDspMnList = pwzn1002Mgr.selectTbbsWbznDspMnInfList(parameterMap);
		}catch(Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}
		// JSON 결과값 셋팅
		json.put("wbznDspMstInf" , wbznDspMstInf);
		json.put("wbzDspMnList"  , wbzDspMnList);
		json.put("RESULT"        , result);
		
		ResponseUtil.write(response, json.toJSONString());
	}
}
