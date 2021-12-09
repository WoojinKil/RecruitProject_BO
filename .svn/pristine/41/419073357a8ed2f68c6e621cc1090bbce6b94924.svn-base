package kr.co.ta9.pandora3.psys.controller;

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
import kr.co.ta9.pandora3.psys.manager.Psys1005Mgr;

/**
* <pre>
* 1. 클래스명 : Psys1005Controller
* 2. 설명 : 코드관리 컨트롤러
* 3. 작성일 : 2018-03-27
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class Psys1005Controller extends CommonActionController{

	@Autowired
	private Psys1005Mgr psys1005Mgr;

	/**
	 * 코드관리 > 마스터코드 그리드 목록 조회
	 *
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1005List1", method = RequestMethod.POST)
	public void getPsys1005List1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 마스터코드 그리드 목록 조회
			json = psys1005Mgr.selectTcmnCdMstGridList(parameterMap);
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
	@RequestMapping(value = "/psys/savePsys10051", method = RequestMethod.POST)
	public void savePsys10051(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 상위메뉴 저장
			psys1005Mgr.saveTcmnCdMst(parameterMap);
		} catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
			// json에 MSG 담기
			json.put("MSG", parameterMap.getValue("MSG"));
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
	@RequestMapping(value = "/psys/getPsys1005List2", method = RequestMethod.POST)
	public void getPsys1005List2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 코드상세 그리드 목록 조회
			json = psys1005Mgr.selectTcmnCdDtlGridList(parameterMap);
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
	@RequestMapping(value = "/psys/savePsys10052", method = RequestMethod.POST)
	public void savePsys10052(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 하위 메뉴 저장
			psys1005Mgr.saveTcmnCdDtl(parameterMap);
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
	@RequestMapping(value = "/psys/savePsys1005", method = RequestMethod.POST)
	public void savePsys1005(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 하위 메뉴 저장
			psys1005Mgr.saveTcmnAlll(parameterMap);
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
	@RequestMapping(value = "/psys/getPsys1005XlsxDwld1")
	public void getPsys1005XlsxDwld1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		//String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 권한 그리드 목록 조회
			json = psys1005Mgr.selectTcmnCdMstGridList(parameterMap);
			// gridHeader 선언
			Map<String,String> gridHeader = parameterMap.parseGridHeader();
			List<Map<String, String>> gridList = (List) json.get("rows");
			for(int i=0; i<gridList.size();i++){
				if("Y".equals(gridList.get(i).get("US_YN"))){
					gridList.get(i).replace("US_YN", "사용");
				}else if("N".equals(gridList.get(i).get("US_YN"))){
					gridList.get(i).replace("US_YN", "미사용");
				}
			}
			String fileNm = parameterMap.getValue("filename");
			FileDownLoad.exportExcelXslx(request,response, gridHeader, gridList,fileNm);
			//DrmFileUtil.exportExcelXslx(request,response,gridHeader, gridList,fileNm);
		}
		catch (Exception e) {
			// Exception일 경우
			//result = Const.BOOLEAN_FAIL;
		}
	}

	/**
	 * 코드관리 > 코드상세 목록 엑셀다운로드
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1005XlsxDwld2")
	public void getPsys1005XlsxDwld2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		//String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 권한 그리드 목록 조회
			json = psys1005Mgr.selectTcmnCdDtlGridList(parameterMap);
			// gridHeader 선언
			Map<String,String> gridHeader = parameterMap.parseGridHeader();
			List<Map<String, String>> gridList = (List) json.get("rows");
			for(int i=0; i<gridList.size();i++){
				if("Y".equals(gridList.get(i).get("US_YN"))){
					gridList.get(i).replace("US_YN", "사용");
				}else if("N".equals(gridList.get(i).get("US_YN"))){
					gridList.get(i).replace("US_YN", "미사용");
				}
			}
			String fileNm = parameterMap.getValue("filename");
			FileDownLoad.exportExcelXslx(request,response, gridHeader, gridList,fileNm);
			//DrmFileUtil.exportExcelXslx(request,response,gridHeader, gridList,fileNm);
		}
		catch (Exception e) {
			// Exception일 경우
			//result = Const.BOOLEAN_FAIL;
		}
	}
}
