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
import kr.co.ta9.pandora3.common.exception.UtilException;
import kr.co.ta9.pandora3.common.servlet.download.FileDownLoad;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.psys.manager.Psys1024Mgr;
/**
* <pre>
* 1. 클래스명 : Psys1024Controller
* 2. 설명: 도움말 컨트롤러
* 3. 작성일 : 2018-04-25
* 4.작성자   : TANINE
* </pre>
*/
@Controller
public class Psys1024Controller extends CommonActionController{

	@Autowired
	private Psys1024Mgr psys1024Mgr;

	/**
	 * 도움말관리 > 도움말 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1024List", method = RequestMethod.POST)
	public void getPsys1024List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 사용자 권한 그리드 목록 조회
			json= psys1024Mgr.getTsysHcoInfList(parameterMap);
		}
		catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 도움말관리 > 메뉴 목록 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1024P001List")
	public void getPsys1024P001List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 권한 그리드 목록 조회
			json = psys1024Mgr.getTsysAdmMnuList(parameterMap);
		}
		catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 도움말 등록 및 수정
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/savePsys1024", method = RequestMethod.POST)
	public void savePsys1024(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 상세 코드 저장
			psys1024Mgr.saveTsysHcoInf(parameterMap);
		} catch(UtilException e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
			// json에 MSG 담기
			json.put("MSG", e.getMessage());
		} catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 도움말 삭제
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/deletePsys1024", method = RequestMethod.POST)
	public void deletePsys1024(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 하위 메뉴 저장
			psys1024Mgr.deleteTsysHcoInf(parameterMap);
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
	 * 시스템사용자관리 > 시스템사용자 그리드 목록 엑셀다운로드
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1024XlsxDwld")
	public void getPsys1024XlsxDwld(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
//		String result = Const.BOOLEAN_SUCCESS;
		// 권한 그리드 목록 조회
		 JSONObject json = psys1024Mgr.getTsysHcoInfList(parameterMap);
		// gridHeader 선언
		Map<String,String> gridHeader = parameterMap.parseGridHeader();
		gridHeader.remove("PREVIEW");
		List<Map<String, String>> gridList = (List) json.get("rows");
		for(int i=0; i<gridList.size();i++){
			if("Y".equals(gridList.get(i).get("FRNT_YN"))){
				gridList.get(i).replace("FRNT_YN", "FO");
			}else if("N".equals(gridList.get(i).get("FRNT_YN"))){
				gridList.get(i).replace("FRNT_YN", "BO");
			}
		}
		String fileNm = parameterMap.getValue("filename");
		FileDownLoad.exportExcelXslx(request,response, gridHeader, gridList,fileNm);
		//FileDownLoad.exportExcel(response, gridHeader, gridList);
		//DrmFileUtil.exportExcelXslx(request,response,gridHeader, gridList,fileNm);
	}

	/**
	 * 도움말관리 > 도움말 정보
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1024Inf", method = RequestMethod.POST)
	public void getPsys1024Inf(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 사용자 권한 그리드 목록 조회
			json= psys1024Mgr.getTsysHcoInfGrid(parameterMap);
		}
		catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
}
