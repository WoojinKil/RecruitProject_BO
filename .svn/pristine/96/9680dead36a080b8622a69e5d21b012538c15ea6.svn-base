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
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.psys.manager.Psys1050Mgr;

/**
* <pre>
* 1. 클래스명 : Psys1050Controller
* 2. 설명      : 조직별직책권한관리 컨트롤러
* 3. 작성일   : 2020-02-28
* 4. 작성자   : TANINE
* </pre>
*/
@Controller
public class Psys1050Controller extends CommonActionController{

	@Autowired
	private Psys1050Mgr psys1050Mgr;

	/**
	 * 조직별직책권한관리 > 폼 통합권한그룹 및 자점 리스트 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@RequestMapping(value = "/psys/getPsys1050SelList", method = RequestMethod.POST)
	public void getPsys1050SelList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // parameterMap 선언
        ParameterMap parameterMap = getParameterMap(request, response);

	    String result   = Const.BOOLEAN_SUCCESS;
        JSONObject json = new JSONObject();
        List<Map<String, Object>> grpRolList = null;
        List<Map<String, Object>> cstrList = null;
        try {
            grpRolList = psys1050Mgr.selectGrpRolList(parameterMap); // 통합권한그룹 리스트 조회
            cstrList   = psys1050Mgr.selectCstrList(parameterMap);   // 자점 리스트 조회
        } catch (IllegalArgumentException e) {
            loged.error(e.toString());
            result = Const.BOOLEAN_FAIL;
        } catch (Exception e) {
            loged.error(e.toString());
            result = Const.BOOLEAN_FAIL;
        }

        json.put("RESULT"     , result);
        json.put("grpRolList" , grpRolList);
        json.put("cstrList"   , cstrList);
        ResponseUtil.write(response, json.toJSONString());
	}

    /**
     * 조직별직책권한관리 > 조직별 직책 권한 리스트 조회
     * @param  request
     * @param  response
     * @throws Exception
     */
    @RequestMapping(value = "/psys/getPsys1050OrgAthrList", method = RequestMethod.POST)
    public void getPsys1050OrgAthrList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ParameterMap parameterMap = getParameterGridMap(request, response);
        String result = Const.BOOLEAN_SUCCESS;
        JSONObject json = new JSONObject();
        try {
            json = psys1050Mgr.selectOrgAthrList(parameterMap);
        } catch (IllegalArgumentException e) {
            loged.error(e.toString());
            result = Const.BOOLEAN_FAIL;
        } catch (Exception e) {
            loged.error(e.toString());
            result = Const.BOOLEAN_FAIL;
        }

        json.put("RESULT", result);
        ResponseUtil.write(response, json.toJSONString());
    }

    /**
     * 조직별권한관리 > 조직별 직책 권한 저장
     * @param  request
     * @param  response
     * @throws Exception
     */
    @RequestMapping(value = "/psys/savePsys1050OrgAthr", method = RequestMethod.POST)
    public void savePsys1050OrgAthr(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ParameterMap parameterMap = getParameterMap(request, response);
        String result = Const.BOOLEAN_SUCCESS;
        JSONObject json = new JSONObject();

        try {
            psys1050Mgr.saveOrgAthr(parameterMap);
        } catch (IllegalArgumentException e) {
            loged.error(e.toString());
            result = Const.BOOLEAN_FAIL;
        } catch (Exception e) {
            loged.error(e.toString());
            result = Const.BOOLEAN_FAIL;
        }

        if(!"".equals(parameterMap.getValue("MSG") )){
            result = Const.BOOLEAN_FAIL;
            json.put("MSG", parameterMap.getValue("MSG"));
        }

        json.put("RESULT", result);
        ResponseUtil.write(response, json.toJSONString());
    }

    /**
     * 조직별직책권한관리 > 팝업 > BI라이센스 계정 목록 조회
     * @param  request
     * @param  response
     * @throws Exception
     */
    @RequestMapping(value = "/psys/getPsys1050p001bIList", method = RequestMethod.POST)
    public void getPsys1050p001bIList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ParameterMap parameterMap = getParameterGridMap(request, response);
        String result = Const.BOOLEAN_SUCCESS;
        JSONObject json = new JSONObject();
        try {
            json = psys1050Mgr.selectBiList(parameterMap);
        } catch (IllegalArgumentException e) {
            loged.error(e.toString());
            result = Const.BOOLEAN_FAIL;
        } catch (Exception e) {
            loged.error(e.toString());
            result = Const.BOOLEAN_FAIL;
        }

        json.put("RESULT", result);
        ResponseUtil.write(response, json.toJSONString());
    }

}
