package kr.co.ta9.pandora3.pbbs.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mysql.jdbc.StringUtils;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.pbbs.manager.Pbbs1016Mgr;

/**
* <pre>
* 1. 클래스명 : Pbbs1016Controller
* 2. 설명 : 스케쥴
* 3. 작성일 : 2018-04-11
* 4.작성자   : TANINE
* </pre>
*/
@Controller
public class Pbbs1016Controller extends CommonActionController {

	@Autowired 
	private Pbbs1016Mgr pbbs1016Mgr;

	/**
	 * 스캐줄 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getPbbs1016ScdList", method=RequestMethod.POST)
	public void getPbbs1016ScdList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// 스캐줄 조회
			json = pbbs1016Mgr.selectTbbsScdInfList(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 스캐줄 등록
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/insertPbbs1016ScdInf")
	public void insertPbbs1016ScdInf(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// 스캐줄 등록
			pbbs1016Mgr.insertTbbsScdInf(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 스캐줄 등록
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/updatePbbs1016ScdInf")
	public void updatePbbs1016ScdInf(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// 스캐줄 수정
			pbbs1016Mgr.updateTbbsScdInf(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 스캐줄 등록/수정/삭제
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/savePbbs1016ScdInf")
	public void savePbbs1016ScdInf(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			if(!StringUtils.isNullOrEmpty(parameterMap.getValue("chg_flag"))) {
				// 스캐줄 등록/수정/삭제
				pbbs1016Mgr.saveTbbsScdInf(parameterMap);
			}else {
				result = Const.BOOLEAN_FAIL;
			}
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

}
