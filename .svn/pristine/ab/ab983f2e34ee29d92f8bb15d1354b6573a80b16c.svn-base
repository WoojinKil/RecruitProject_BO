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

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.app.util.DrmFileUtil;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.servlet.download.FileDownLoad;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.pbbs.manager.Pbbs1001Mgr;
import kr.co.ta9.pandora3.pbbs.manager.Pbbs1019Mgr;

/**
* <pre>
* 1. 클래스명 : Pbbs1001Controller
* 2. 설명 : 통합게시글조회
* 3. 작성일 : 2018-04-06
* 4.작성자   : TANINE
* </pre>
*/
@Controller
public class Pbbs1001Controller extends CommonActionController {

	@Autowired
	private Pbbs1001Mgr pbbs1001Mgr;
	
	@Autowired
	private Pbbs1019Mgr pbbs1019Mgr;
	
	/**
	 * 메뉴 맵핑여부 판단여부 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getPbbs1001p01ModlMpnYn", method=RequestMethod.POST)
	public void getPbbs1001p01ModlMpnYn(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		String modl_mpn_yn = "";
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// 메뉴 맵핑여부 판단여부 조회
			modl_mpn_yn = pbbs1001Mgr.getTbbsModlInfId(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		json.put("modl_mpn_yn", modl_mpn_yn);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 모듈리스트 조회 (모듈관리)
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getPbbs1001MdlList", method=RequestMethod.POST)
	public void getPbbs1001MdlList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// 모듈리스트 조회 (모듈관리)
			json = pbbs1001Mgr.selectTbbsModlInfList(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 템플릿 매핑 정보 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getPbbs1001p01ModlMpnList", method=RequestMethod.POST)
	public void getPbbs1001p01ModlMpnList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// 템플릿 매핑 정보 조회
			json = pbbs1001Mgr.getTbbsModlInfMappingList(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}


	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getPbbs1001SitSeq", method=RequestMethod.POST)
	public void getPbbs1001SitSeq(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();
		try {
			// 템플릿 매핑 정보 조회
			json = pbbs1001Mgr.getPbbs1001SitSeq(parameterMap);

		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 모듈리스트 삭제
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/deletePbbs1001ModlList", method=RequestMethod.POST)
	public void deletePbbs1001ModlList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// 모듈리스트 삭제
			int saveCnt = pbbs1001Mgr.deleteTbbsModlInfList(parameterMap);
			if(0 == saveCnt) result = Const.BOOLEAN_FAIL;
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 모듈정보 저장
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/savePbbs1001ModlInf")
	public void savePbbs1001ModlInf(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// 모듈정보 저장
			pbbs1001Mgr.saveTbbsModlInfInfo(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 모듈정보 등록/수정
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/savePbbs1001ModlInfByFlag")
	public void savePbbs1001ModlInfByFlag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// 모듈정보 등록/수정
			pbbs1001Mgr.savePbbs1001ModlInfByFlag(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 엑셀다운로드
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pbbs/getPbbs1001XlsxDwld")
	public void getPbbs1001XlsxDwld(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// 그리드 헤더 선언
		Map<String,String> gridHeader = parameterMap.parseGridHeader();
		gridHeader.remove("SYS_CD");
		gridHeader.remove("CTEGRY_MST_CD");
		gridHeader.remove("US_YN");
		gridHeader.put("SYS_CD2","시스템 명");
		gridHeader.put("CTEGRY_MST_CD","카데고리마스터명");
		gridHeader.put("US_YN","사용여부");
		// 모듈리스트 조회 (모듈관리)
		JSONObject json = pbbs1001Mgr.excelTbbsModlInfList(parameterMap);
		List<Map<String, String>> gridList = (List<Map<String, String>>)json.get("rows");
		for(int i = 0; i < gridList.size(); i++) {
			if(Const.BOOLEAN_TRUE.equals(gridList.get(i).get("US_YN"))) {
				gridList.get(i).replace("US_YN", "사용");
			}else if("N".equals(gridList.get(i).get("US_YN"))) {
				gridList.get(i).replace("US_YN", "미사용");
			}
		}
		// 엑셀 다운로드
		String fileNm = parameterMap.getValue("filename");
		//FileDownLoad.exportExcelXslx(request,response, gridHeader, gridList,fileNm);
		//DrmFileUtil.exportExcelXslx(request,response,gridHeader, gridList,fileNm);
		FileDownLoad.exportExcelXslx(request,response,gridHeader, gridList,fileNm);

	}

	/**
	 * 코드관리 > 마스터코드 목록 조회
	 *
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/pbbs/getCtegryMstList", method = RequestMethod.POST)
	public void getPbbs1019List1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = getParameterMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			json = pbbs1019Mgr.selectTbbsCtegryMstList(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
}
