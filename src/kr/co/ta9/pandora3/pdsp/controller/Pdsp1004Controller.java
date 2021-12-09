package kr.co.ta9.pandora3.pdsp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.pcommon.dto.TdspTmplInf;
import kr.co.ta9.pandora3.pdsp.manager.Pdsp1004Mgr;
/**
* <pre>
* 1. 클래스명 : Pdsp1004Controller
* 2. 설명     : 메뉴전시관리
* 3. 작성일   : 2018-03-29
* 4. 작성자   : TANINE
* </pre>
*/

@Controller
public class Pdsp1004Controller extends CommonActionController{
	@Autowired
	private Pdsp1004Mgr pdsp1004Mgr;

	/**
	 * 템플릿 전시 트리 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pdsp/getPdsp1004List1", method = RequestMethod.POST)
	public void getPdsp1004List1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();

		ParameterMap parameterMap = getParameterMap(request, response);

		try {
			// 템플릿 전시 트리 조회
			json = pdsp1004Mgr.selectTdspTmplInfDispTreeList(parameterMap);

		} catch (Exception e) {
			e.printStackTrace();
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 전시메뉴 > 등록 및 수정 : 1건씩
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pdsp/savePdsp100401", method = RequestMethod.POST)
	public void savePdsp100401(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();

		int mnu_seq = 0;
		int tmp_seq = 0;

		try {
			if("COPY".equals(parameterMap.getValue("copyFlag"))) {
				ObjectMapper objectMapper = new ObjectMapper();
				String jsonTop = request.getParameter("jsonTop");
				String jsonMid = request.getParameter("jsonMid");
				String jsonBtm = request.getParameter("jsonBtm");
				List<TdspTmplInf> topTemList = StringUtils.isNotEmpty(jsonTop)? topTemList = objectMapper.readValue(jsonTop,objectMapper.getTypeFactory().constructCollectionType(List.class, TdspTmplInf.class)) : null;
				List<TdspTmplInf> midTemList = StringUtils.isNotEmpty(jsonMid)? midTemList = objectMapper.readValue(jsonMid,objectMapper.getTypeFactory().constructCollectionType(List.class, TdspTmplInf.class)) : null;
				List<TdspTmplInf> btmTemList = StringUtils.isNotEmpty(jsonBtm)? btmTemList = objectMapper.readValue(jsonBtm,objectMapper.getTypeFactory().constructCollectionType(List.class, TdspTmplInf.class)) : null;
				// 대.중.소 메뉴 등록
				tmp_seq = pdsp1004Mgr.saveTdspTmplInfInfo(parameterMap, topTemList, midTemList, btmTemList);
			} else {
				// 전시메뉴 등록 수정
				mnu_seq = pdsp1004Mgr.updateMenuDispInfo(parameterMap);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		json.put("mnu_seq", mnu_seq);
		json.put("tmp_seq", tmp_seq == 0 ? parameterMap.getValue("tmp_seq") : tmp_seq);
		json.put("upp_tmp_seq", parameterMap.getValue("upp_tmp_seq"));
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 템플릿 리스트 조회 (메뉴 매핑여부 포함)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pdsp/getPdsp1004List2", method = RequestMethod.POST)
	public void getPdsp1004List2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// 템플릿 리스트 조회 (메뉴 매핑여부 포함)
			json = pdsp1004Mgr.selectTdspTmplInfMpnList();

		} catch (Exception e) {
			e.printStackTrace();
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}



	/**
	 * BO : 전시메뉴 (하위메뉴 조회)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pdsp/getPdsp1004List3", method=RequestMethod.POST)
	public void getPdsp1004List3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = getParameterGridMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			json = pdsp1004Mgr.selectTdspTmplInfDwnDspMnuGridList(parameterMap);
		}
		catch (Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * BO : 전시메뉴 (하위메뉴 수정/삭제)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pdsp/savePdsp100403", method = RequestMethod.POST)
	public void savePdsp100403(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = getParameterMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			pdsp1004Mgr.saveTdspTmplInf(parameterMap);
		}
		catch (Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
}
