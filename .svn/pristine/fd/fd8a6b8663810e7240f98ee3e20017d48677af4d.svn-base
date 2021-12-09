package kr.co.ta9.pandora3.pbbs.controller;

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
import kr.co.ta9.pandora3.pbbs.manager.Pbbs1008Mgr;

/**
* <pre>
* 1. 클래스명 : Pbbs1008Controller
* 2. 설명 : 일반게시글등록 컨트롤러
* 3. 작성일 : 2018-04-11
* 4.작성자   : TANINE
* </pre>
*/
@Controller
public class Pbbs1008Controller extends CommonActionController{

	@Autowired
	private Pbbs1008Mgr pbbs1008Mgr;

	/**
	 * 일반 컨텐츠
	 * BOARD TYPE1/TYPE2/TYPE3 : 게시글 등록
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pbbs/savePbbs1008DocInf")
	public void savePbbs1008DocInf(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			int saveCnt = 0;
			if("B_TYPE3".equals(parameterMap.getValue("modl_tp"))){
				parameterMap.put("eid", "treatment");
				saveCnt = pbbs1008Mgr.saveTbbsDocInf(parameterMap);
			}else{
				saveCnt = pbbs1008Mgr.insertTbbsDocInf(parameterMap);
			}
			if(0 == saveCnt) result = Const.BOOLEAN_FAIL;
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
			logger.error(e.toString());
			e.printStackTrace();
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getCtgInfo", method=RequestMethod.POST)
	public void getPbbs1001SitSeq(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();
		try {
			// 템플릿 매핑 정보 조회
			json = pbbs1008Mgr.getCtgInfo(parameterMap);

		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
			logger.error(e.toString());
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/selectTbbsModlInfCommonList", method=RequestMethod.POST)
	public void selectTbbsModlInfCommonList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();
		try {
			// 템플릿 매핑 정보 조회
			json = pbbs1008Mgr.selectTbbsModlInfCommonList(parameterMap);

		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
			logger.error(e.toString());
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}



}
