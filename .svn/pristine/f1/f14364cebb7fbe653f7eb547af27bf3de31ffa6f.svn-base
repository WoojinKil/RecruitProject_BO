package kr.co.ta9.pandora3.psys.controller;

import java.util.ArrayList;
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
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmMnu;
import kr.co.ta9.pandora3.psys.manager.Psys1002Mgr;

/**
* <pre>
* 1. 클래스명 : Psys1002Controller
* 2. 설명 : 메뉴 권한관리 컨트롤러
* 3. 작성일 : 2018-03-27
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class Psys1002Controller extends CommonActionController{

	@Autowired
	private Psys1002Mgr psys1002Mgr;


	/**
	 * 시스템메뉴관리 > 메뉴 그리드 목록 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getTsysAdmMnuGridTreeList")
	public void getTsysAdmMnuGridTreeList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {

			// 메뉴 그리드 목록 조회
			json = psys1002Mgr.selectTsysAdmMnuGridTreeList(parameterMap);
		}
		catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
			logger.error(e);
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}



	/**
	 * 메뉴 트리 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getPsys1002List01", method = RequestMethod.POST)
	public void getPdsp1004List01(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ParameterMap parameterMap = getParameterGridMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// 템플릿 전시 트리 조회
			json = psys1002Mgr.selectTsysAdmMnuGridTreeList(parameterMap);

		} catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
			logger.error(e);
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}


	/**
	 * 메뉴 (하위메뉴 조회)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/psys/getPsys1002List03", method=RequestMethod.POST)
	public void getPdsp1004List03(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = getParameterGridMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			json = psys1002Mgr.selectTsysAdmMnuDownGridList(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
			logger.error(e);
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}


	/**
	 * 메뉴 > 등록 및 수정 : 1건씩
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/savePsys100201", method = RequestMethod.POST)
	public void savePsys100201(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		// return값 변경될 menu_id
		int menu_id = 0;

		try {
			if("COPY".equals(parameterMap.getValue("copyFlag"))) {
				ObjectMapper objectMapper = new ObjectMapper();
				String jsonTop = request.getParameter("jsonTop");
				String jsonMid = request.getParameter("jsonMid");
				String jsonBtm = request.getParameter("jsonBtm");
				List<TsysAdmMnu> topMenuList = null;
				if(StringUtils.isNotEmpty(jsonTop)){
					topMenuList = objectMapper.readValue(jsonTop,objectMapper.getTypeFactory().constructCollectionType(List.class, TsysAdmMnu.class)) ;
				}
				
				List<TsysAdmMnu> midMenuList = null;
				if(StringUtils.isNotEmpty(jsonMid)){
					 midMenuList = objectMapper.readValue(jsonMid,objectMapper.getTypeFactory().constructCollectionType(List.class, TsysAdmMnu.class)) ;
				}
				
				List<TsysAdmMnu> btmMenuList = null;
				if(StringUtils.isNotEmpty(jsonBtm)){
					btmMenuList = objectMapper.readValue(jsonBtm,objectMapper.getTypeFactory().constructCollectionType(List.class, TsysAdmMnu.class));
				}
				
				psys1002Mgr.saveTsysAdmMnuCopyInfo(parameterMap, topMenuList, midMenuList, btmMenuList);
			} else {
				// 메뉴 등록 수정
				menu_id = psys1002Mgr.updateTsysAdmMnuInfo(parameterMap);
			}
		}
		catch (Exception e) {
			// Exception일 경우

			result = Const.BOOLEAN_FAIL;
			logger.error(e);
		}
		// json에 결과 담기
		json.put("RESULT", result);
		json.put("menu_id", menu_id);
		json.put("up_menu_id", parameterMap.getValue("up_menu_id"));
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 메뉴 (하위메뉴 수정/삭제)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/savePsys100203", method = RequestMethod.POST)
	public void savePdsp100403(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = getParameterMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			psys1002Mgr.savePsys100203(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
			logger.error(e);
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
}
