package kr.co.ta9.pandora3.pwzn.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspDtl;
import kr.co.ta9.pandora3.pwzn.manager.Pwzn1004Mgr;
/**
* <pre>
* 1. 클래스명 : Pwzn1004Controller
* 2. 설명 : 웹진카테고리상세 컨트롤러
* 3. 작성일 : 2018-03-29
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class Pwzn1004Controller extends CommonActionController{
	
	@Autowired
	private Pwzn1004Mgr pwzn1004Mgr;
	
	/**
	 * 웹진 상세 정보 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pwzn/getPwzn1004List", method = RequestMethod.POST)
	public void getPwzn1004List(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// 웹진 상세 파일 목록 조회
			List<Map<String,Object>> fileMapList = new ArrayList<Map<String,Object>>();
			fileMapList = pwzn1004Mgr.selectWebzineDtlInfoListMap(parameterMap);
			json.put("fileMapList", fileMapList);
			
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
	 * 웹진 목록 조회(메인카테고리 - 상세컨텐츠 매핑여부 포함)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pwzn/getPwzn1004WbznInitList", method = RequestMethod.POST)
	public void getPwzn1004WbznInitList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// 웹진 목록 조회(메인카테고리 - 상세컨텐츠 매핑여부 포함)
			json = pwzn1004Mgr.selectTbbsWbznDspMnInfInitList(parameterMap, json);
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
	 * 웹진 상세카테고리 등록/수정
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pwzn/updatePwzn1004CtgList", method = RequestMethod.POST)
	public void updatePwzn1004CtgList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			String wbznDtlInf = request.getParameter("wbznDtlInf");
			// 웹진 상세컨텐츠 카테고리 정보 등록용 List
			List<TbbsWbznDspDtl> tbbsWbznDspDtlList = StringUtils.isNotEmpty(wbznDtlInf)? tbbsWbznDspDtlList = objectMapper.readValue(wbznDtlInf,objectMapper.getTypeFactory().constructCollectionType(List.class, TbbsWbznDspDtl.class)) : null;
			pwzn1004Mgr.updateWbznCtgList(parameterMap, tbbsWbznDspDtlList);
		}
		catch (Exception e) {
			e.printStackTrace();
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}		
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	/**
	 * 웹진 상세 파일 정보 삭제
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pwzn/deletePwzn1004FlInf")
	public void deletePwzn1004FlInf(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 변수 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		log.debug(parameterMap);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		try {
			int delCnt = pwzn1004Mgr.deleteTbbsWbznDspDtlFileInf(parameterMap);
			if(!(delCnt > 0)) {
				result = Const.BOOLEAN_FAIL;
			}
		}catch(Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}
		// JSON 결과값 셋팅
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	/**
	 * 웹진 상세컨텐츠 정보 저장
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pwzn/insertPwzn1004FlInf")
	public void insertPwzn1004FlInf(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 변수 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		log.debug(parameterMap);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		List<Map<String, Object>> fileChkList = new ArrayList<Map<String, Object>>();
		try {
			List<Map<String, Object>> sysFileInfo = pwzn1004Mgr.insertTbbsWbznDspDtlFileInf(parameterMap);
			String[] fileChkArr = parameterMap.getValue("fileChkArr").split(",");
			for(int i = 0; i < sysFileInfo.size(); i++) {
				Map<String, Object> fileChkMap = new HashMap<String, Object>();
				fileChkMap.put("file_id", fileChkArr[i].toString());
				fileChkMap.put("file_srl", sysFileInfo.get(i).get("file_srl"));
				fileChkMap.put("file_nm", sysFileInfo.get(i).get("file_nm"));
				fileChkMap.put("file_path", sysFileInfo.get(i).get("file_path"));
				fileChkList.add(fileChkMap);
			}
			json.put("fileChkList", fileChkList);
		}catch(Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}
		// JSON 결과값 셋팅
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
}
