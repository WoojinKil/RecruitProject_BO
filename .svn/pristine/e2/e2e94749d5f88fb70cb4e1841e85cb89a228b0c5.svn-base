package kr.co.ta9.pandora3.psys.controller;

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
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.psys.manager.Psys1047Mgr;

/**
* <pre>
* 1. 클래스명 : Psys1037Controller
* 2. 설명 : 권한그룹관리 컨트롤러
* 3. 작성일 : 2018-10-28
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class Psys1047Controller extends CommonActionController{

	@Autowired
	private Psys1047Mgr psys1047Mgr;

	/**
	 * 사원 관리 > 외부 사용자 승인 관리
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getPsys1047List", method = RequestMethod.POST)
	public void getPsys1047List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			json = psys1047Mgr.selectExtnTmbrAdmLgnInfGridList(parameterMap);
		}
		catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
			log.error(e);
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 사원 관리 > 외부 사용자 승인 관리
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/savePsys1047List", method = RequestMethod.POST)
	public void savePsys1047List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			psys1047Mgr.updateExtnTmbrAdmLgnInf(parameterMap);

		} catch (Exception e) {

			result = Const.BOOLEAN_FAIL;
			log.error(e);
			e.printStackTrace();
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
     *  점별 이용가능 서비스 관리 > 서비스접점/제공서비스 정보 조회
     * 
     * @param request
     * @param response
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/psys/getSrvDptInfoList", method = RequestMethod.POST)
    public void getClubDptInfoList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // parameterMap 
        ParameterMap parameterMap = getParameterMap(request, response);
        log.info("------------------- parameterMap ------------------");
        log.info(parameterMap.toString());
        log.info("------------------- parameterMap ------------------");
        // result �꽑�뼵
        String result = Const.BOOLEAN_SUCCESS;
        // json �꽑�뼵
        JSONObject json = new JSONObject();
        
        try {
//            json.put("strCd",   psys1047Mgr.selectStrCdInfoList(parameterMap));
        } catch (Exception e) {
            result = Const.BOOLEAN_FAIL;
            log.error(e.toString());
            e.printStackTrace();
        }
        json.put("RESULT", result);
        ResponseUtil.write(response, json.toJSONString());
    }
	
}
