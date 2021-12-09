package kr.co.ta9.pandora3.pbbs.controller;

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
import kr.co.ta9.pandora3.app.util.DrmFileUtil;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.servlet.download.FileDownLoad;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.pbbs.manager.Pbbs1010Mgr;

/**
* <pre>
* 1. 클래스명 : Pbbs1010Controller
* 2. 설명: Work관리 컨트롤러
* 3. 작성일 : 2018-04-24
* 4.작성자   : TANINE
* </pre>
*/
@Controller
public class Pbbs1010Controller extends CommonActionController{

	@Autowired
	private Pbbs1010Mgr pbbs1010Mgr;

	/**
	 * WORK 목록 조회(그리드형)
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getPbbs1010PtnrList", method=RequestMethod.POST)
	public void getPbbs1010PtnrList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// WORK 목록 조회(그리드형)
			json = pbbs1010Mgr.selectTmbrPtnrInfGridList(parameterMap);
		}catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * WORK 등록/수정
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/savePbbs1010PtnrInf")
	public void savePbbs1010PtnrInf(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			if(!StringUtils.isNullOrEmpty(parameterMap.getValue("chg_flag"))) {
				// WORK 등록/수정
				pbbs1010Mgr.saveTmbrPtnrInf(parameterMap);
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

	/**
	 * WORK 삭제(그리드형)
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/deletePbbs1010PtnrList", method=RequestMethod.POST)
	public void deletePbbs1010PtnrList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// WORK 삭제(그리드형)
			pbbs1010Mgr.deleteTmbrPtnrInfList(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * WORK 상세 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getPbbs1010PtnrInf", method=RequestMethod.POST)
	public void getPbbs1010PtnrInf(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// WORK 상세 조회
			json = pbbs1010Mgr.selectTmbrPtnrInf(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 게시글관리 > WORK 그리드 목록 엑셀다운로드
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getPbbs1010XlsxDwld")
	public void getPbbs1010XlsxDwld(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// JSONObject 선언
		// 권한 그리드 목록 조회
		JSONObject json = pbbs1010Mgr.selectTmbrPtnrInfGridList(parameterMap);
		// 그리드 헤더 선언
		Map<String,String> gridHeader = parameterMap.parseGridHeader();
		List<Map<String, String>> gridList = (List<Map<String, String>>)json.get("rows");
		// 엑셀다운로드
		String fileNm = parameterMap.getValue("filename");
		//FileDownLoad.exportExcelXslx(request,response, gridHeader, gridList,fileNm);
		//DrmFileUtil.exportExcelXslx(request,response,gridHeader, gridList,fileNm);
		FileDownLoad.exportExcelXslx(request,response,gridHeader, gridList,fileNm);
	}

}
