package kr.co.ta9.pandora3.pdsp.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.servlet.download.FileDownLoad;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.pdsp.manager.Pdsp1005Mgr;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


/**
* <pre>
* 1. 클래스명 : Pdsp1005Controller
* 2. 설명: 메인팝업관리
* 3. 작성일 : 2018-03-29
* 4.작성자   : TANINE
* </pre>
*/
@Controller
public class Pdsp1005Controller extends CommonActionController{
	@Autowired
	private Pdsp1005Mgr pdsp1005Mgr;
	
	/**
	 * 팝업관리 > 메인팝업관리(BO)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pdsp/getPdsp1005List", method = RequestMethod.POST)
	public void getPdsp1005List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// 메인팝업 목록 조회(그리드형)
			json = pdsp1005Mgr.selectTdspMnPopGridList(parameterMap);
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
	 * 팝업관리 > 메인팝업관리(BO) : 삭제 | 전시&비전시 처리 - 그리드형
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pdsp/savePdsp1005", method = RequestMethod.POST)
	public void savePdsp1005(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = getParameterMap(request, response);		
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			pdsp1005Mgr.saveTdspMnPopGridList(parameterMap);
		}
		catch (Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}		
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 팝업관리 > 메인팝업 그리드 목록 엑셀다운로드 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/pdsp/getPdsp1005XlsxDwld")
	public void getPdsp1005XlsxDwld(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 권한 그리드 목록 조회
			json = pdsp1005Mgr.selectTdspMnPopGridList(parameterMap);
			// gridHeader 선언
			Map<String,String> gridHeader = parameterMap.parseGridHeader();
			gridHeader.remove("PREVIEW");
			List<Map<String, String>> gridList = (List) json.get("rows");
			for(int i=0; i<gridList.size();i++){
				if(gridList.get(i).get("DSPLY_YN").equals("Y")){
					gridList.get(i).replace("DSPLY_YN", "전시");
				}else if(gridList.get(i).get("DSPLY_YN").equals("N")){
					gridList.get(i).replace("DSPLY_YN", "비전시");
				}
				if(gridList.get(i).get("POP_TP_CD").equals("01")){
					gridList.get(i).replace("POP_TP_CD", "팝업크기(대)");
				}else if(gridList.get(i).get("POP_TP_CD").equals("02")){
					gridList.get(i).replace("POP_TP_CD", "팝업크기(소)");
				}
			}
			String fileNm = parameterMap.getValue("filename");
			FileDownLoad.exportExcelXslx(request,response, gridHeader, gridList,fileNm);
			//FileDownLoad.exportExcel(response, gridHeader, gridList);
		}
		catch (Exception e) {
			e.printStackTrace();
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}
	}
}
