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
import kr.co.ta9.pandora3.app.util.DrmFileUtil;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.servlet.download.FileDownLoad;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.psys.manager.Psys1046Mgr;

/**
 * <pre>
 * 1. 클래스명 : Psys1022Controller
 * 2. 설명 : VIP 접속 이력
 * 3. 작성일 : 2018-04-24
 * 4. 작성자 : TANINE
 * </pre>
 */
@Controller
public class Psys1046Controller extends CommonActionController{

	@Autowired
	private Psys1046Mgr psys1046Mgr;

	/**
	 * 이력관려 > VIP 메뉴 접속 이력
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getPsys1046List", method = RequestMethod.POST)
	public void getPsys1046List(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// jsonObject json 선언
		JSONObject json = new JSONObject();

		try {
			// 메뉴 접속 이력 조회
//			json = psys1046Mgr.selectTbLgapVmsprinfschHList(parameterMap);
		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
			logger.error(e);
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 이력관려 > VIP 메뉴 접속 이력 엑셀 다운로드
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1046XlsxDwld")
	public void getPsys1046XlsxDwld(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// json 선언
		JSONObject json = new JSONObject();

		try {
			// 메뉴 접속 이력 조회
			json = psys1046Mgr.selectTbLgapVmsprinfschHList(parameterMap);

			Map<String,String> header = parameterMap.parseGridHeader();
			List<Map<String, String>> list = (List)json.get("rows");
			String fileName = parameterMap.getValue("fileName");

			for(int i=0; i<list.size(); i++)
			{
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss", Locale.ENGLISH);
				String crt_dttm = String.valueOf(list.get(i).get("CRT_DTTM"));

				if("null".equals(crt_dttm))
					list.get(i).replace("CRT_DTTM", "");
				else
					list.get(i).replace("CRT_DTTM", dateFormat.format(new Timestamp(Long.parseLong(crt_dttm))));
			}

			FileDownLoad.exportExcelXslx(request,response, header, list, fileName);
			//DrmFileUtil.exportExcelXslx(request,response,header, list,fileName);
		}
		catch (Exception e) {
			log.debug(e);
		}
	}
}
