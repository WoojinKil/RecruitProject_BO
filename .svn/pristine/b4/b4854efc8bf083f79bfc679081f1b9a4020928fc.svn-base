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
import kr.co.ta9.pandora3.psys.manager.Psys1021Mgr;

/**
 * <pre>
 * 1. 클래스명 : Psys1021Controller
 * 2. 설명 : 로그인이력 컨트롤러
 * 3. 작성일 : 2018-04-24
 * 4. 작성자 : TANINE
 * </pre>
 */
@Controller
public class Psys1021Controller extends CommonActionController{

	@Autowired
	private Psys1021Mgr psys1021Mgr;

	/**
	 * 접속기록관리 > 시스템 로그인 이력 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getPsys1021List", method = RequestMethod.POST)
	public void getPsys1021List(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// jsonObject json 선언
		JSONObject json = new JSONObject();

		try {
			// 진입통계 목록 조회(그리드형)
			// json = psys1021Mgr.selectTmbrUsrLgnInfList(parameterMap);
			// json = psys1021Mgr.selectTmbrUsrLgnInfArrayList(parameterMap);


		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
			logger.error(e);
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 접속기록관리 > 시스템 로그인 이력 엑셀다운로드
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1021XlsxDwld")
	public void getPsys1021XlsxDwld(HttpServletRequest request, HttpServletResponse response) throws Exception{

		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// json 선언
		JSONObject json = new JSONObject();

//		String result = Const.BOOLEAN_SUCCESS;

		try {
			// 권한 그리드 목록 조회
			json = psys1021Mgr.selectTmbrUsrLgnInfList(parameterMap);

			Map<String,String> header = parameterMap.parseGridHeader();
			List<Map<String, String>> list = (List)json.get("rows");
			String fileName = parameterMap.getValue("fileName");

			for(int i=0; i<list.size(); i++)
			{
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss", Locale.ENGLISH);
				String lgn_dttm = String.valueOf(list.get(i).get("LGN_DTTM"));

				if("null".equals(lgn_dttm))
					list.get(i).replace("LGN_DTTM", "");
				else
					list.get(i).replace("LGN_DTTM", dateFormat.format(new Timestamp(Long.parseLong(lgn_dttm))));
			}

			//kr.co.ta9.pandora3.app.util.FileDownLoad.exportExcelXslx(request,response, header, list, fileName);
			//DrmFileUtil.exportExcelXslx(request,response,header, list,fileName);
			FileDownLoad.exportExcelXslx(request,response,header, list,fileName);
		}
		catch (Exception e) {
//			result = Const.BOOLEAN_FAIL;
			log.debug(e);
		}
	}
}
