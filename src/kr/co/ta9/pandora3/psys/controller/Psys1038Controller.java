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
import kr.co.ta9.pandora3.psys.manager.Psys1038Mgr;

/**
* <pre>
* 1. 클래스명 : Psys1037Controller
* 2. 설명 : 권한그룹관리 컨트롤러
* 3. 작성일 : 2018-10-28
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class Psys1038Controller extends CommonActionController{

	@Autowired
	private Psys1038Mgr psys1038Mgr;

	/**
	 * 권한관리 > 그룹 권한 그리드 목록 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getPsys1038List", method = RequestMethod.POST)
	public void getPsys1006List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 그룹 권한 그리드 목록 조회
			json = psys1038Mgr.selectTsysAdmGrpRolRtnnGridList(parameterMap);
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
	 * 권한관리 > 권한 저장
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/savePsys1038List", method = RequestMethod.POST)
	public void savePsys1038List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 권한 저장
			psys1038Mgr.saveTsysAdmGrpRolRtnnList(parameterMap);

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
	 * 시스템사용자관리 > 시스템사용자 그리드 목록 엑셀다운로드
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getPsys1038XlsxDwld")
	public void getPsys1006XlsxDwld(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		//String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 권한 그리드 목록 조회
			json = psys1038Mgr.selectTsysAdmGrpRolRtnnGridList(parameterMap);
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
			//FileDownLoad.exportExcel(response, gridHeader, gridList);
			//DrmFileUtil.exportExcelXslx(request,response,gridHeader, gridList,fileNm);
		}
		catch (Exception e) {
			// Exception일 경우
			//result = Const.BOOLEAN_FAIL;
		}
	}

	/**
	 * 시스템권한목록 전체조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/selectRolListAll", method = RequestMethod.POST)
	public void selectRolList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// BOARD TYPE1/TYPE2 : 게시판 모듈 목록 조회
			json = psys1038Mgr.selectRolListAll(parameterMap);
		} catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * *통합그룹 시스템 그룹 매핑 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getPsys103801List", method = RequestMethod.POST)
	public void selectTsysAdmGrpRolList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			json = psys1038Mgr.selectTsysAdmGrpRolList(parameterMap);
		} catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
}
