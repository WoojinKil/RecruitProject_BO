package kr.co.ta9.pandora3.pbbs.controller;

import java.util.ArrayList;
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
import kr.co.ta9.pandora3.pbbs.manager.Pbbs1005Mgr;
import kr.co.ta9.pandora3.pbbs.manager.PbbsCommonMgr;
/**
* <pre>
* 1. 클래스명 : Pbbs1005Controller
* 2. 설명 : 통합게시글상세조회(일반게시판) 컨트롤러
* 3. 작성일 : 2018-04-11
* 4.작성자   : TANINE
* </pre>
*/
@Controller
public class Pbbs1005Controller extends CommonActionController {

	@Autowired
	private Pbbs1005Mgr pbbs1005Mgr;
	@Autowired
	private PbbsCommonMgr pbbsCommonMgr;

	/**
	 * 일반컨텐츠 : 게시글 상세
	 * 1. BOARD TYPE1/TYPE2 : 게시글 상세
	 * 2. 공통 : 질문답변형 게시판 상세 조회(첨부파일)
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getPbbs1005DocDtlList", method = RequestMethod.POST)
	public void getPbbs1005DocDtlList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// BOARD TYPE1/TYPE2 : 게시글 상세
			json = pbbs1005Mgr.getTbbsDocInfDtl(parameterMap);

			// 공통 : 질문답변형 게시판 상세 조회(첨부파일)
			List<Map<String,Object>> tbbsFlInfMapList = pbbsCommonMgr.selectTbbsFlInfListMap(parameterMap);
			json.put("tbbsFlInfMapList", tbbsFlInfMapList);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 일반컨텐츠 : 게시글 수정
	 * BOARD TYPE1/TYPE2 : 게시글 수정
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pbbs/updatePbbs1005DocInf")
	public void updatePbbs1005DocInf(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// BOARD TYPE1/TYPE2 : 게시글 수정
			pbbs1005Mgr.updateTbbsDocInf(parameterMap);
		}catch(Exception e) {
			log.debug(e);
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

}
