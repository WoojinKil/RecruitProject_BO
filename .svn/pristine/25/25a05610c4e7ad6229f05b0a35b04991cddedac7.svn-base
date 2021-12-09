package kr.co.ta9.pandora3.bpcm.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.bpcm.manager.Bpcm2008Mgr;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.exception.AppException;
import kr.co.ta9.pandora3.common.util.ResponseUtil;

/**
* <pre>
* 1. 클래스명 : Bpcm2008Controller
* 2. 설명 : 인사이트레포트-이달의레포트
* 3. 작성일 : 2020-01-21
* 4. 작성자   : TANINE
* </pre>
*/
@Controller
public class Bpcm2008Controller extends CommonActionController {
	
	@Autowired
	private Bpcm2008Mgr bpcm2008Mgr;
	
	
	/**
	 * 인사이트레포트-기준일참조
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/bpcm/bpcm2008getStdYm", method=RequestMethod.POST)
	public void bpcm2008getStdYm(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();
		
		try {
			json = bpcm2008Mgr.getStdYm(parameterMap);
		} catch (AppException e) {
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		} 
		
		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 인사이트레포트-1. 매출요약 그래프조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/bpcm/bpcm2008getHighlightSalesSummary", method=RequestMethod.POST)
	public void bpcm2008getHighlightSalesSummary(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject(); 
				
		try {
			json = bpcm2008Mgr.getHighlightSalesSummary(parameterMap);
		} catch (AppException e) {
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		} 
		
		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 인사이트레포트-그래프 하이라이트-2. 총매출실적/오프라인(조회기준) 매출실적
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/bpcm/bpcm2008getHighlightAllSalesOff", method=RequestMethod.POST)
	public void bpcm2008getHighlightAllSalesOff(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject(); 
		
		try {
			json = bpcm2008Mgr.getHighlightAllSalesOff(parameterMap);
		} catch (AppException e) {
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		} 
		
		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());		
	}
	
	
	/**
	 * 인사이트레포트-하이라이트-3. 회원/비회원
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/bpcm/bpcm2008getHighlightCust1", method=RequestMethod.POST)
	public void bpcm2008getHighlightCust1(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject(); 
		
		try {
			json = bpcm2008Mgr.getHighlightCust1(parameterMap);
		} catch (AppException e) {
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		} 
		
		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());		
	}
	
	/**
	 * 인사이트레포트-고객특성
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/bpcm/bpcm2008getCustSpec", method=RequestMethod.POST)
	public void bpcm2008getCustSpec(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject(); 
		
		try {
			json = bpcm2008Mgr.getCustSpec(parameterMap);
		} catch (AppException e) {
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		} 
		
		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());		
	}
	
	/**
	 * 인사이트레포트-구매특성
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/bpcm/bpcm2008getPurchaseSpec", method=RequestMethod.POST)
	public void bpcm2008getPurchaseSpec(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject(); 
		
		try {
			json = bpcm2008Mgr.getPurchaseSpec(parameterMap);
		} catch (AppException e) {
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		} 
		
		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());		
	}
	
	/**
	 * 점팝업 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/bpcm/getBpcm2008Cstr", method=RequestMethod.POST)
	public void getBpcm2008Cstr(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject(); 
		
		try {
			json = bpcm2008Mgr.getCstr(parameterMap);
		} catch (AppException e) {
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		} 
		
		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());		
	}
	
	/**
	 * 브랜드팝업 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/bpcm/getBpcm2008Brnd", method=RequestMethod.POST)
	public void getBpcm2008Brnd(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject(); 
		
		try {
			json = bpcm2008Mgr.getBrnd(parameterMap);
		} catch (AppException e) {
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		} 
		
		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());		
	}
	
}
