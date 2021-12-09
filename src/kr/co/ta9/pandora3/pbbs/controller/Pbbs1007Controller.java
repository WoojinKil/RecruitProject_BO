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

import com.mysql.jdbc.StringUtils;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.pbbs.manager.Pbbs1007Mgr;
import kr.co.ta9.pandora3.pbbs.manager.PbbsCommonMgr;
/**
* <pre>
* 1. 클래스명 : Pbbs1007Controller
* 2. 설명: 통합게시글상세조회(동영상게시판) 컨트롤러
* 3. 작성일 : 2018-04-11
* 4.작성자   : TANINE
* </pre>
*/
@Controller
public class Pbbs1007Controller extends CommonActionController{

	@Autowired
	private Pbbs1007Mgr pbbs1007Mgr;
	@Autowired
	private PbbsCommonMgr pbbsCommonMgr;

	/**
	 * 동영상 모듈 조회
	 * BOARD TYPE5 : 동영상 모듈 목록 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getPbbs1007MpiList", method=RequestMethod.POST)
	public void getPbbs1007MpiList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// BOARD TYPE5 : 동영상 모듈 목록 조회
			json = pbbs1007Mgr.selectTbbsModlInfMovieList(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 홍보영상 상세 조회
	 * 1. 홍보영상 상세 조회
	 * 2. 공통 : 질문답변형 게시판 상세 조회(첨부파일)
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getPbbs1007PviList", method=RequestMethod.POST)
	public void getPbbs1007PviList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// 홍보영상 상세 조회
			json = pbbs1007Mgr.selectTbbsDocInfPvContentInfo(parameterMap);

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
	 * 홍보영상 등록/수정
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/savePbbs1007PvInf")
	public void savePbbs1007PvInf(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			if(!StringUtils.isNullOrEmpty(parameterMap.getValue("chg_flag"))) {
				// 홍보영상 등록
				pbbs1007Mgr.savePvContentInfo(parameterMap);
			}else {
				result = Const.BOOLEAN_FAIL;
			}
		}catch(Exception e) {
			json.put("ERROR_MSG", e.getMessage());
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

}
