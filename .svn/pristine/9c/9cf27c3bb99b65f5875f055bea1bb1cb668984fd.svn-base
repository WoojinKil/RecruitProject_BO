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

import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.app.util.DrmFileUtil;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.servlet.download.FileDownLoad;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.psys.manager.Psys1039Mgr;

/**
* <pre>
* 1. 클래스명 : Psys1037Controller
* 2. 설명 : 권한그룹관리 컨트롤러
* 3. 작성일 : 2018-10-28
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class Psys1039Controller extends CommonActionController{

	@Autowired
	private Psys1039Mgr psys1039Mgr;

	/**
	 * 권한신청관리 > 개별 권한 신청 목록
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getPsys1039List", method = RequestMethod.POST)
	public void getPsys1006List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			UserInfo userInfo =  parameterMap.getUserInfo();
			if(userInfo != null){
				parameterMap.put("org_cd", userInfo.getOrg_cd());
				// 그룹 권한 그리드 목록 조회
				json = psys1039Mgr.selectTsysUsrRolRtnnAppGridList(parameterMap);
			}

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
	 * 권한신청관리 > 개별 권한 신청
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/savePsys1039List", method = RequestMethod.POST)
	public void savePsys1039List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 권한 저장
			psys1039Mgr.insertTbbcpcAthrApp(parameterMap);

		} catch (Exception e) {

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
	@RequestMapping(value = "/psys/getPsys1039XlsxDwld")
	public void getPsys1006XlsxDwld(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		//String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 권한 그리드 목록 조회
			json = psys1039Mgr.selectTsysUsrRolRtnnAppGridList(parameterMap);
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
}
