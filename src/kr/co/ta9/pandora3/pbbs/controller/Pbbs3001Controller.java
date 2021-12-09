package kr.co.ta9.pandora3.pbbs.controller;

import java.util.ArrayList;
import java.util.List;

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
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.exception.AppException;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.landing.manager.BpcmCommPop001Mgr;
import kr.co.ta9.pandora3.pbbs.manager.Pbbs3001Mgr;
import kr.co.ta9.pandora3.pcommon.dto.usrdef.BpcmCommPopVO;

/**
* <pre>
* 1. 클래스명 : Pbbs3001Controller
* 2. 설명 : 점사은행사
* 3. 작성일 : 2020-02-21
* 4.작성자   :
* </pre>
*/
@Controller
public class Pbbs3001Controller extends CommonActionController {
	@Autowired
	private Pbbs3001Mgr pbbs3001Mgr;

	@Autowired
	private BpcmCommPop001Mgr bpcmCommPop001Mgr;

	/**
	 * 사은행사 목록 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getBpcm3001List", method=RequestMethod.POST)
	public void getBpcm3001List(HttpServletRequest request, HttpServletResponse response) throws Exception{
		/*
		 * // parameterMap 선언 ParameterMap parameterMap = getParameterGridMap(request,
		 * response); // result 선언 String result = Const.BOOLEAN_SUCCESS; // json 선언
		 * JSONObject json = new JSONObject(); try { String rgn_ldr_yn =
		 * parameterMap.getUserInfo().getRgn_ldr_yn(); //지역장 여부 String cstr_cd =
		 * parameterMap.getUserInfo().getCstr_cd(); //자점 코드 String shop_grde_cd =
		 * parameterMap.getUserInfo().getShop_grde_cd();// 매입 등급 코드 String grp_rol_id =
		 * parameterMap.getUserInfo().getGrp_rol_id();// 권한 등급 코드
		 * 
		 * ArrayList<String> cstrArr = new ArrayList<String>(); //지역장 여부.
		 * parameterMap.put("rgn_ldr_yn", rgn_ldr_yn);
		 * 
		 * if("Y".equals(rgn_ldr_yn)) { // 지역장일 경우 String[] cstr_cds =
		 * cstr_cd.split(","); for(String str : cstr_cds){ cstrArr.add(str); }
		 * parameterMap.put("cstr_cd", cstrArr); } else if ("0000".equals(cstr_cd) ||
		 * TextUtil.isEmpty(cstr_cd) ) { parameterMap.put("cstr_cd", ""); } else {// 점일
		 * 경우
		 * 
		 * if(TextUtil.isNotEmpty(shop_grde_cd) && (shop_grde_cd.indexOf('L') > -1 ||
		 * "9".equals(grp_rol_id))) { String[] cstr_cds = cstr_cd.split(","); for(String
		 * str : cstr_cds){ cstrArr.add(str); } parameterMap.put("cstr_cd", cstrArr);
		 * parameterMap.put("rgn_ldr_yn", "Y"); //for문을 위한 처리. } else {
		 * parameterMap.put("cstr_cd", cstr_cd); }
		 * 
		 * 
		 * }
		 * 
		 * json = pbbs3001Mgr.selecThkuEvntList(parameterMap); }catch (AppException e) {
		 * log.error(e.toString()); result = Const.BOOLEAN_FAIL; } catch (Exception e) {
		 * result = Const.BOOLEAN_FAIL; } // json에 결과 담기 json.put("RESULT", result);
		 * ResponseUtil.write(response, json.toJSONString());
		 */
	}

	/**
	 * 사은행사 목록 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/bpcm/getEvntDtl", method=RequestMethod.POST)
	public void getEvntDtl(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 메뉴권한 그리드 목록 조회
			json = pbbs3001Mgr.selecThkuEvntDtl(parameterMap);
		}catch (AppException e) {
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 사은행사 유형 selectbox 생성
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/bpcm/getComnCdList", method=RequestMethod.POST)
	public void getComnCdList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			// 메뉴권한 그리드 목록 조회
			json = pbbs3001Mgr.getComnCdList(parameterMap);
		}catch (AppException e) {
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
}
