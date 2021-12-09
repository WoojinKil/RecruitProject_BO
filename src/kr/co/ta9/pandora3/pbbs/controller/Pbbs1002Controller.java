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
import kr.co.ta9.pandora3.pbbs.manager.Pbbs1002Mgr;
/**
* <pre>
* 1. 클래스명 : Pbbs1002Controller
* 2. 설명 : 통합게시글상세
* 3. 작성일 : 2018-04-06
* 4.작성자   : TANINE
* </pre>
*/
@Controller
public class Pbbs1002Controller extends CommonActionController {

	@Autowired
	private Pbbs1002Mgr pbbs1002Mgr;

	/**
	 * 모듈이 매핑가능한 템플릿 목록 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getPbbs1002TmplList", method=RequestMethod.POST)
	public void getPbbs1002TmplList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// 모듈이 매핑가능한 템플릿 목록 조회
			json = pbbs1002Mgr.selectTdspTmplInfMpnModlList(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

}