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
import kr.co.ta9.pandora3.pbbs.manager.Pbbs1019Mgr;

/**
* <pre>
* 1. 클래스명 : Pbbs1019Controller
* 2. 설명 : 코드관리 컨트롤러
* 3. 작성일 : 2019-12-17
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class Pbbs1019Controller extends CommonActionController{

	@Autowired
	private Pbbs1019Mgr pbbs1019Mgr;

	/**
	 * 코드관리 > 마스터코드 그리드 목록 조회
	 *
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/pbbs/getPbbs1019List1", method = RequestMethod.POST)
	public void getPbbs1019List1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 마스터코드 그리드 목록 조회
			json = pbbs1019Mgr.selectTbbsCtegryMstGridList(parameterMap);
		} catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 코드관리 > 상위메뉴 저장
	 *
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/pbbs/savePbbs10191", method = RequestMethod.POST)
	public void savePbbs10191(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 상위메뉴 저장
			pbbs1019Mgr.saveTbbsCtegryMst(parameterMap);
		} catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
			// json에 MSG 담기
			json.put("MSG", parameterMap.getValue("MSG"));
			logger.error(e);
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 시스템공통 > 상세 코드 그리드 목록 조회
	 * 사용화면 : 가입약관 관리 / 로그인설정
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pbbs/getPbbs1019List2", method = RequestMethod.POST)
	public void getPbbs1019List2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 코드상세 그리드 목록 조회
			json = pbbs1019Mgr.selectTbbsCtegryDtlGridList(parameterMap);
		} catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 코드관리 > 하위메뉴 저장
	 *
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/pbbs/savePbbs10192", method = RequestMethod.POST)
	public void savePbbs10192(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 하위 메뉴 저장
			pbbs1019Mgr.saveTbbsCtegryDtl(parameterMap);
		} catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
			// json에 MSG 담기
			json.put("MSG", parameterMap.getValue("MSG"));
			logger.error(e);
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}


	/**
	 * 코드관리 > 하위메뉴 저장
	 *
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/pbbs/savePbbs1019", method = RequestMethod.POST)
	public void savePbbs1019(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 하위 메뉴 저장
			pbbs1019Mgr.saveTcmnAlll(parameterMap);
		} catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
			// json에 MSG 담기
			json.put("MSG", parameterMap.getValue("MSG"));
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 코드관리 > 코드마스터 목록 엑셀다운로드
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/pbbs/getPbbs1019XlsxDwld1")
	public void getPbbs1019XlsxDwld1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
//		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
//		try {
			// 권한 그리드 목록 조회
//		 JSONObject json = pbbs1019Mgr.selectTbbsCtegryMstGridList(parameterMap);
		 JSONObject json = pbbs1019Mgr.excelTbbsCtegryMstGridList(parameterMap);
			// gridHeader 선언
			Map<String,String> gridHeader = parameterMap.parseGridHeader();
			gridHeader.remove("SYS_CD");
			gridHeader.remove("F_UPD_DTTM");
			gridHeader.put("SYS_NM","시스템 명");
			gridHeader.put("F_UPD_DTTM","변경일자");
			List<Map<String, String>> gridList = (List) json.get("rows");
			for(int i=0; i<gridList.size();i++){
//				if(gridList.get(i).get("US_YN").equals("Y")){
				if("Y".equals(gridList.get(i).get("US_YN"))){
					gridList.get(i).replace("US_YN", "활성화");
//				}else if(gridList.get(i).get("US_YN").equals("N")){
				}else if("N".equals(gridList.get(i).get("US_YN"))){
					gridList.get(i).replace("US_YN", "비활성화");
				}
			}
			String fileNm = parameterMap.getValue("filename");
			FileDownLoad.exportExcelXslx(request,response, gridHeader, gridList,fileNm);
			//DrmFileUtil.exportExcelXslx(request,response,gridHeader, gridList,fileNm);
			//FileDownLoad.exportExcel(response, gridHeader, gridList);
//		} catch (Exception e) {
			// Exception일 경우
//			result = Const.BOOLEAN_FAIL;
//		}

	}

	/**
	 * 코드관리 > 코드상세 목록 엑셀다운로드
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/pbbs/getPbbs1019XlsxDwld2")
	public void getPbbs1019XlsxDwld2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
//		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
//		try {
			// 권한 그리드 목록 조회
		JSONObject json = pbbs1019Mgr.selectTbbsCtegryDtlGridList(parameterMap);
			// gridHeader 선언
			Map<String,String> gridHeader = parameterMap.parseGridHeader();
			List<Map<String, String>> gridList = (List) json.get("rows");
			for(int i=0; i<gridList.size();i++){
//				if(gridList.get(i).get("US_YN").equals("Y")){
				if("Y".equals(gridList.get(i).get("US_YN"))){
					gridList.get(i).replace("US_YN", "사용");
//				}else if(gridList.get(i).get("US_YN").equals("N")){
				}else if("N".equals(gridList.get(i).get("US_YN"))){
					gridList.get(i).replace("US_YN", "미사용");
				}
			}
			String fileNm = parameterMap.getValue("filename");
			FileDownLoad.exportExcelXslx(request,response, gridHeader, gridList,fileNm);
			//DrmFileUtil.exportExcelXslx(request,response,gridHeader, gridList,fileNm);
			//FileDownLoad.exportExcel(response, gridHeader, gridList);
//		} catch (Exception e) {
			// Exception일 경우
//			result = Const.BOOLEAN_FAIL;
//		}
	}
}
