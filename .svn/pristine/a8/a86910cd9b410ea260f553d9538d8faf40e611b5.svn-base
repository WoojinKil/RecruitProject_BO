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

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.app.util.DrmFileUtil;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.servlet.download.FileDownLoad;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.psys.manager.Psys1023Mgr;

/**
 * <pre>
 * 1. 클래스명 : Psys1023Controller
 * 2. 설명 : 약관이력 컨트롤러
 * 3. 작성일 : 2018-04-24
 * 4. 작성자 : TANINE
 * </pre>
 */
@Controller
public class Psys1023Controller extends CommonActionController{

	@Autowired
	private Psys1023Mgr psys1023Mgr;

	/**
	 * 약관 이력 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/psys/getPsys1023List")
	public void getPsys1023List(HttpServletRequest request, HttpServletResponse response) throws Exception{
		//parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);

		//jsonObject 선언
		JSONObject json = new JSONObject();

		String result = Const.BOOLEAN_SUCCESS;

		try{
			json = psys1023Mgr.getTmbrCluHstList(parameterMap);
		}catch(Exception e){
			result = Const.BOOLEAN_FAIL;
		}

		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 약관 이력 조회 엑셀다운로드
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1023XlsxDwld")
	public void getPsys1023XlsxDwld(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// 약관 이력 조회 목록 조회
		 JSONObject json = psys1023Mgr.getTmbrCluHstList(parameterMap);

		Map<String,String> header = parameterMap.parseGridHeader();
		List<Map<String, String>> list = (List)json.get("rows");
		String fileName = parameterMap.getValue("fileName");

		for(int i=0; i<list.size(); i++)
		{
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss", Locale.ENGLISH);
			String crd_dttm = String.valueOf(list.get(i).get("CRT_DTTM"));

			if("null".equals(crd_dttm))
				list.get(i).replace("CRT_DTTM", "");
			else
				list.get(i).replace("CRT_DTTM", dateFormat.format(new Timestamp(Long.parseLong(crd_dttm))));

			String upd_dttm = String.valueOf(list.get(i).get("UPD_DTTM"));

			if("null".equals(upd_dttm))
				list.get(i).replace("UPD_DTTM", "");
			else
				list.get(i).replace("UPD_DTTM", dateFormat.format(new Timestamp(Long.parseLong(upd_dttm))));
		}

		FileDownLoad.exportExcelXslx(request, response, header, list, fileName);
		//DrmFileUtil.exportExcelXslx(request,response,header, list,fileName);
	}

}
