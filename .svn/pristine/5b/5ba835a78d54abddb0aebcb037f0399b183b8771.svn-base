package kr.co.ta9.pandora3.psys.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.psys.manager.Psys1051Mgr;

/**
* <pre>
* 1. 클래스명 : Psys1051Controller
* 2. 설명      : 조직별매장매입관리 컨트롤러
* 3. 작성일   : 2020-02-28
* 4. 작성자   : TANINE
* </pre>
*/
@Controller
public class Psys1051Controller extends CommonActionController{

	@Autowired
	private Psys1051Mgr psys1051Mgr;

    /**
     * 조직별매장매입관리 > 모/자점 조회  (매장조직)
     * @param  request
     * @param  response
     * @throws Exception
     */
    @RequestMapping(value = "/psys/getPsys1051StrList", method = RequestMethod.POST)
    public void getPsys1051StrList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ParameterMap parameterMap = getParameterGridMap(request, response);
        String result = Const.BOOLEAN_SUCCESS;
        JSONObject json = new JSONObject();
        try {
            json = psys1051Mgr.selectStrList(parameterMap);
        } catch (IllegalArgumentException e) {
            loged.error(e.toString());
            result = Const.BOOLEAN_FAIL;
            e.printStackTrace();
        } catch (Exception e) {
            loged.error(e.toString());
            result = Const.BOOLEAN_FAIL;
            e.printStackTrace();
        }

        json.put("RESULT", result);
        ResponseUtil.write(response, json.toJSONString());
    }

    /**
     * 조직별매장매입관리 > 부문목록 조회 (매입조직)
     * @param  request
     * @param  response
     * @throws Exception
     */
    @RequestMapping(value = "/psys/getPsys1051FldList", method = RequestMethod.POST)
    public void getPsys1051FldList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ParameterMap parameterMap = getParameterGridMap(request, response);
        String result = Const.BOOLEAN_SUCCESS;
        JSONObject json = new JSONObject();
        try {
            json = psys1051Mgr.selectBuyFldList(parameterMap);
        } catch (IllegalArgumentException e) {
            loged.error(e.toString());
            result = Const.BOOLEAN_FAIL;
            e.printStackTrace();
        } catch (Exception e) {
            loged.error(e.toString());
            result = Const.BOOLEAN_FAIL;
            e.printStackTrace();
        }

        json.put("RESULT", result);
        ResponseUtil.write(response, json.toJSONString());
    }


    /**
     * 조직별매장매입관리 > 선택 점에 대한 매장층 목록 조회
     * @param  request
     * @param  response
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/psys/getPsys1051floorList", method = RequestMethod.POST)
    public void getPsys1051floorList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // parameterMap 선언
        ParameterMap parameterMap = getParameterMap(request, response);

        String result   = Const.BOOLEAN_SUCCESS;
        JSONObject json = new JSONObject();
        List<Map<String, Object>> floorList = null;
        try {
            if("shop".equals(parameterMap.get("type"))){
                floorList = psys1051Mgr.selectShopFloorList(parameterMap); // 매장층 리스트 조회
            } else  if("buy".equals(parameterMap.get("type"))){
                floorList = psys1051Mgr.selectBuyFloorList(parameterMap);  // 매입팀 리스트 조회
            }
        } catch (IllegalArgumentException e) {
            loged.error(e.toString());
            e.printStackTrace();
            result = Const.BOOLEAN_FAIL;
        } catch (Exception e) {
            loged.error(e.toString());
            e.printStackTrace();
            result = Const.BOOLEAN_FAIL;
        }

        json.put("RESULT" , result);
        json.put("rows"   , floorList);
        json.put("records", 1);
        ResponseUtil.write(response, json.toJSONString());
    }

    /**
     * 조직별매장매입관리 > 선택 점/층에 대한 매장PC목록 조회
     * @param  request
     * @param  response
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/psys/getPsys1051PcList", method = RequestMethod.POST)
    public void getPsys1051PcList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // parameterMap 선언
        ParameterMap parameterMap = getParameterMap(request, response);

        String result   = Const.BOOLEAN_SUCCESS;
        JSONObject json = new JSONObject();
        List<Map<String, Object>> pcList = null;
        try {
            if("shop".equals(parameterMap.get("type"))){
                pcList = psys1051Mgr.selectShopPcList(parameterMap); // 매장PC 리스트 조회
            } else  if("buy".equals(parameterMap.get("type"))){
                pcList = psys1051Mgr.selectBuyPcList(parameterMap);  // 매입PC 리스트 조회
            }
        } catch (IllegalArgumentException e) {
            loged.error(e.toString());
            e.printStackTrace();
            result = Const.BOOLEAN_FAIL;
        } catch (Exception e) {
            loged.error(e.toString());
            e.printStackTrace();
            result = Const.BOOLEAN_FAIL;
        }

        json.put("RESULT" , result);
        json.put("rows"   , pcList);
        json.put("records", 1);
        ResponseUtil.write(response, json.toJSONString());
    }
    
    /**
     * 조직별매장매입관리 > 전체저장
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/psys/saveShopAll", method = RequestMethod.POST)
    public void saveShopAll(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // parameterMap 선언
        ParameterMap parameterMap = getParameterMap(request, response);
        log.info("------------------- parameterMap ------------------");
        log.info(parameterMap.toString());
        log.info("------------------- parameterMap ------------------");
        // result 선언
        String result = Const.BOOLEAN_SUCCESS;
        // json 선언
        JSONObject json = new JSONObject();
        try {
            // 점별 안내메시지 가변값 생성
        	psys1051Mgr.saveShopAll(parameterMap);
        } catch (IllegalArgumentException e) {
        	result = Const.BOOLEAN_FAIL;
        	e.printStackTrace();
        } catch (Exception e) {
            // e.printStackTrace();
            // Exception 일 경우
            result = Const.BOOLEAN_FAIL;
            e.printStackTrace();
            // json에 MSG 담기
            json.put("MSG", parameterMap.getValue("MSG"));
        }
        // json에 결과 담기
        json.put("RESULT", result);
        ResponseUtil.write(response, json.toJSONString());
    }
    

}
