package kr.co.ta9.pandora3.psys.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;
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
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.exception.AuthorityException;
import kr.co.ta9.pandora3.common.servlet.download.FileDownLoad;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.psys.manager.Psys1015Mgr;

/**
 * <pre>
 * 1. 클래스명 : Psys1015Controller
 * 2. 설명: BO가입약관 관리 Controller
 * 3. 작성일 : 2018-04-16
 * 4.작성자   : TANINE
 * </pre>
 */
@Controller
public class Psys1015Controller extends CommonActionController{

	@Autowired
	private Psys1015Mgr psys1015Mgr;


	/**
	 * 사용자 약관 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1015List", method = RequestMethod.POST)
	public void getPsys1015List(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// json 선언
		JSONObject json = new JSONObject();

		try {
			// 사용자 권한 그리드 목록 조회
			json= psys1015Mgr.getTmbrCluList(parameterMap);
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
	 * 약관 관리 등록 및 수정
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/savePsys1015", method = RequestMethod.POST)
	public void savepsys1015(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// json 선언
		JSONObject json = new JSONObject();

		try {
			// 상세 코드 저장
			psys1015Mgr.saveTmbrClu(parameterMap);
		}
		catch(AuthorityException ex) {
			result = Const.BOOLEAN_FAIL;
			// json에 MSG 담기
			json.put("MSG", ex.getMessage());
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
			// json에 MSG 담기
			json.put("MSG", parameterMap.getValue("MSG"));
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 사용자 약관  엑셀다운로드
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1015XlsxDwld")
	public void getPsys1015XlsxDwld(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// result 선언
		//String result = Const.BOOLEAN_SUCCESS;

		// json 선언
		JSONObject json = new JSONObject();

		try {
			// 사용자 약관 조회
			json = psys1015Mgr.getTmbrCluList(parameterMap);

			Map<String,String> header = parameterMap.parseGridHeader();
			List<Map<String, String>> list = (List)json.get("rows");
			String fileName = parameterMap.getValue("fileName");

			for(int i=0; i<list.size(); i++)
			{
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss", Locale.ENGLISH);

				String temp = String.valueOf(list.get(i).get("CRT_DTTM"));

				if("null".equals(temp))
					list.get(i).replace("CRT_DTTM", "");
				else
					list.get(i).replace("CRT_DTTM", dateFormat.format(new Timestamp(Long.parseLong(temp))));

				if("Y".equals(list.get(i).get("US_YN")))
					list.get(i).replace("US_YN", "사용");
				else if("N".equals(list.get(i).get("US_YN")))
					list.get(i).replace("US_YN", "미사용");
			}

			FileDownLoad.exportExcelXslx(request,response, header, list, fileName);

		}
		catch (Exception e) {
			//result = Const.BOOLEAN_FAIL;
		}
	}
}
