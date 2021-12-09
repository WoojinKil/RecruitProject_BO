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
import kr.co.ta9.pandora3.pbbs.manager.Pbbs1006Mgr;
import kr.co.ta9.pandora3.pbbs.manager.PbbsCommonMgr;
/**
* <pre>
* 1. 클래스명 : Pbbs1006Controller
* 2. 설명: 통합게시글상세조회(QA게시판) 컨트롤러
* 3. 작성일 : 2018-04-11
* 4.작성자   : TANINE
* </pre>
*/
@Controller
public class Pbbs1006Controller extends CommonActionController {

	@Autowired
	private Pbbs1006Mgr pbbs1006Mgr;
	@Autowired
	private PbbsCommonMgr pbbsCommonMgr;

	/**
	 * 일반컨텐츠 : 게시글 상세
	 * 1. BOARD TYPE3 : 질문답변형 게시판 상세 조회(질문)
	 * 2. 공통 : 질문답변형 게시판 상세 조회(첨부파일)
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getPbbs1006DocDtlList", method=RequestMethod.POST)
	public void getPbbs1006DocDtlList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// BOARD TYPE3 : 질문답변형 게시판 상세 조회(질문)
			json = pbbs1006Mgr.selectTbbsDocInfType3View(parameterMap);
			Map<String, Object>replyMap   = pbbs1006Mgr.selectTbbsQaCmtInfInfoMap(parameterMap);
			json.put("tbbsCmtMap", replyMap);

			// 공통 : 질문답변형 게시판 상세 조회(첨부파일)
			List<Map<String,Object>> tbbsFlInfMapList = pbbsCommonMgr.selectTbbsFlInfListMap(parameterMap);
			json.put("tbbsFlInfMapList", tbbsFlInfMapList);
			
		}catch(Exception e) {
			log.info(e.toString());
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * BOARD TYPE3 : 질문답변형 게시판 상세 조회(답변 목록)
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pbbs/getPbbs1006QaCmtList", method=RequestMethod.POST)
	public void getPbbs1006QaCmtList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// BOARD TYPE3 : 질문답변형 게시판 상세 조회(답변 목록)
			json = pbbs1006Mgr.selectTbbsQaCmtInfGridList(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * BOARD TYPE3 : 질문답변형 게시판 답변 삭제(B/O)
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pbbs/deletePbbs1006QaCmtList", method=RequestMethod.POST)
	public void deletePbbs1006QaCmtList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// BOARD TYPE3 : 질문답변형 게시판 답변 삭제(B/O)
			int insCnt = pbbs1006Mgr.deleteTbbsQaCmtInfGridList(parameterMap);
			if(insCnt <= 0) result = Const.BOOLEAN_FAIL;
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * BOARD TYPE3 : 질문답변형 게시판 상세 조회(답변 - 단건)
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getPbbs1006QaCmtInf", method=RequestMethod.POST)
	public void getPbbs1006QaCmtInf(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// BOARD TYPE3 : 질문답변형 게시판 상세 조회(답변 - 단건)
			json = pbbs1006Mgr.selectTbbsQaCmtInfInfo(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * BOARD TYPE3 : 질문답변형 게시판 답변등록/수정(B/O)
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pbbs/insertPbbs1006QaCmtInf")
	public void insertPbbs1006QaCmtInf(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// BOARD TYPE3 : 질문답변형 게시판 답변등록/수정(B/O)
			int insCnt = pbbs1006Mgr.insertTbbsQaCmtInf(parameterMap);
			if(insCnt <= 0) result = Const.BOOLEAN_FAIL;
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

}
