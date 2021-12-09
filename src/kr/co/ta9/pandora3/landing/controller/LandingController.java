package kr.co.ta9.pandora3.landing.controller;

import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.landing.bi.report.BiReportUtil;
import kr.co.ta9.pandora3.landing.manager.Bpcm3001Mgr;
import kr.co.ta9.pandora3.landing.manager.BpcmCommPop001Mgr;
import kr.co.ta9.pandora3.landing.manager.LandingMgr;
import kr.co.ta9.pandora3.pbbs.manager.Pbbs1004Mgr;
/**
* <pre>
* 1. 클래스명 : LandingController
* 2. 설명 : 랜딩 컨트롤러
* 3. 작성일 : 2020-02-10
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class LandingController extends CommonActionController {

	
	@Autowired
	private BpcmCommPop001Mgr bpcmCommPop001Mgr;
	
	@Autowired
	private Bpcm3001Mgr bpcm3001Mgr;
	
	@Autowired
	private Pbbs1004Mgr pbbs1004Mgr;
	
	@Autowired
	private LandingMgr landingMgr;
	/**
	 * 사은행사 목록 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 * 사은 행사 본사 -> 전점 , 본점 -> 본점, 지역장 -> 해당 지역, 지역 관련 부서 -> 해당 지역 , 점 -> 점
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/bpcm/getBpcm3001List", method=RequestMethod.POST)
	public void getBpcm3001List(HttpServletRequest request, HttpServletResponse response) throws Exception{
		/*
		 * // parameterMap 선언 ParameterMap parameterMap = getParameterGridMap(request,
		 * response); // result 선언 String result = Const.BOOLEAN_SUCCESS; // json 선언
		 * JSONObject json = new JSONObject(); try {
		 * 
		 * String rgn_ldr_yn = parameterMap.getUserInfo().getRgn_ldr_yn(); //지역장 여부
		 * String cstr_cd = parameterMap.getUserInfo().getCstr_cd(); //자점 코드 String
		 * shop_grde_cd = parameterMap.getUserInfo().getShop_grde_cd();// 매입 등급 코드
		 * String grp_rol_id = parameterMap.getUserInfo().getGrp_rol_id();// 권한 등급 코드 //
		 * String blstr_cd = parameterMap.getUserInfo().getBlstr_cd(); // 소속점 코드
		 * 
		 * 
		 * 
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
		 * 
		 * json = bpcm3001Mgr.selecThkuEvntList(parameterMap); } catch (Exception e) {
		 * log.error(e.toString()); // Exception 일 경우 result = Const.BOOLEAN_FAIL; } //
		 * json에 결과 담기 json.put("RESULT", result); ResponseUtil.write(response,
		 * json.toJSONString());
		 */
	}
	
	
	/**
	 * 랜딩 빅데이터 포탈 공지사항 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/landing/getTbbsDocInfNoticeLandingList", method=RequestMethod.POST)
	public void getTbbsDocInfNoticeLandingList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// 일반컨텐츠 : 게시글 목록 조회(그리드형)
			parameterMap.put("dsply_stat", "게시중");
			parameterMap.put("front_notice_yn", "공지");
			
			json = pbbs1004Mgr.getTbbsDocInfNoticeLandingList(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
			ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 랜딩 빅데이터 포탈 팝업 공지사항 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/landing/getPopNotice", method=RequestMethod.POST)
	public void getPopNotice(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();
		
		try {
			// 일반컨텐츠 : 게시글 목록 조회(그리드형)
			parameterMap.put("dsply_stat", "게시중");
			parameterMap.put("front_notice_yn", "공지");
			
			json = pbbs1004Mgr.getPopNotice(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		
		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 날씨 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/landing/getWeather", method=RequestMethod.POST)
	public void getWeather(HttpServletRequest request, HttpServletResponse response) throws Exception{
		/*
		 * // ParameterMap 선언 ParameterMap parameterMap = getParameterMap(request,
		 * response); // Result 선언 String result = Const.BOOLEAN_SUCCESS; // JSONObject
		 * 선언 JSONObject json = new JSONObject();
		 * 
		 * try {
		 * 
		 * String rgn_ldr_yn = parameterMap.getUserInfo().getRgn_ldr_yn(); //지역장 여부
		 * String blstr_cd = parameterMap.getUserInfo().getBlstr_cd(); // 소속점 코드 String
		 * cstr_cd = parameterMap.getUserInfo().getCstr_cd(); //자점 코드 String
		 * shop_grde_cd = parameterMap.getUserInfo().getShop_grde_cd();// 매입 등급 코드
		 * String grp_rol_id = parameterMap.getUserInfo().getGrp_rol_id();// 권한 등급 코드
		 * 
		 * // 방문자 수 는 본사면 본점, 본점 -> 본점 , 직
		 * 
		 * //cstr_cd 가 비워있거나 본사이면 본점을 본다. if(TextUtil.isEmpty(cstr_cd) ||
		 * "0000".equals(cstr_cd)) { parameterMap.put("cstr_cd", "0001"); } else
		 * if("Y".equals(rgn_ldr_yn)) { //지역 여부가 Y일 경우 소속점을 본다.
		 * parameterMap.put("cstr_cd", blstr_cd); } else { //본사, 본점, 지역장 제외 모점코드
		 * 
		 * if(TextUtil.isNotEmpty(shop_grde_cd) && (shop_grde_cd.indexOf('L') > -1 ||
		 * "9".equals(grp_rol_id))) { parameterMap.put("cstr_cd", blstr_cd); } else {
		 * 
		 * parameterMap.put("cstr_cd", cstr_cd); }
		 * 
		 * }
		 * 
		 * json = landingMgr.getWeather(parameterMap);
		 * 
		 * 
		 * }catch(Exception e) { log.error(e.toString()); result = Const.BOOLEAN_FAIL; }
		 * 
		 * // JSONObject 결과값 반환 json.put("RESULT", result); ResponseUtil.write(response,
		 * json.toJSONString());
		 */
	}
	/**
	 * mkt 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/landing/getMktData", method=RequestMethod.POST)
	public void getMktData(HttpServletRequest request, HttpServletResponse response) throws Exception{
		/*
		 * // ParameterMap 선언 ParameterMap parameterMap = getParameterMap(request,
		 * response); // Result 선언 String result = Const.BOOLEAN_SUCCESS; // JSONObject
		 * 선언 JSONObject json = new JSONObject();
		 * 
		 * try {
		 * 
		 * String rgn_ldr_yn = parameterMap.getUserInfo().getRgn_ldr_yn(); //지역장 여부
		 * String cstr_cd = parameterMap.getUserInfo().getCstr_cd(); //자점 코드| // String
		 * blstr_cd = parameterMap.getUserInfo().getBlstr_cd(); // 소속점 코드 String
		 * shop_grde_cd = parameterMap.getUserInfo().getShop_grde_cd();// 매입 등급 코드
		 * String grp_rol_id = parameterMap.getUserInfo().getGrp_rol_id();// 권한 등급 코드
		 * String mkt_title = ""; //mkt 점 이름 ArrayList<String> cstrArr = new
		 * ArrayList<String>();
		 * 
		 * //본사는 전점. //본점은 본점 //지역장일땐 해당 지역 cstr_cd 들어옴 // 점은 점
		 * 
		 * //지역장 여부. parameterMap.put("rgn_ldr_yn", rgn_ldr_yn);
		 * 
		 * if("Y".equals(rgn_ldr_yn)) { // 지역장일 경우 String[] cstr_cds =
		 * cstr_cd.split(","); for(String str : cstr_cds){ cstrArr.add(str); }
		 * parameterMap.put("cstr_cd", cstrArr); mkt_title =
		 * parameterMap.getUserInfo().getBsle_hdofic_nm(); // 지역명이 들어갈 예쩡 } else if
		 * ("0000".equals(cstr_cd) || TextUtil.isEmpty(cstr_cd) ) { // 본사일 경우 전사
		 * parameterMap.put("cstr_cd", ""); mkt_title = "전사"; // 지역명이 들어갈 예쩡
		 * 
		 * } else {// 점일 경우 if(TextUtil.isNotEmpty(shop_grde_cd) &&
		 * (shop_grde_cd.indexOf('L') > -1 || "9".equals(grp_rol_id))) { String[]
		 * cstr_cds = cstr_cd.split(","); for(String str : cstr_cds){ cstrArr.add(str);
		 * } parameterMap.put("cstr_cd", cstrArr); parameterMap.put("rgn_ldr_yn", "Y");
		 * //for문을 위한 처리. mkt_title = parameterMap.getUserInfo().getBsle_hdofic_nm(); }
		 * else { parameterMap.put("cstr_cd", cstr_cd); mkt_title =
		 * parameterMap.getUserInfo().getCstr_nm(); // 자점 명 }
		 * 
		 * }
		 * 
		 * // mkt_title
		 * 
		 * 
		 * json = landingMgr.getMktData(parameterMap); json.put("MKT_TITLE", mkt_title);
		 * 
		 * 
		 * }catch(Exception e) { log.error(e.toString()); result = Const.BOOLEAN_FAIL; }
		 * 
		 * // JSONObject 결과값 반환 json.put("RESULT", result); ResponseUtil.write(response,
		 * json.toJSONString());
		 */
	}
	
	/**
	 * 랜딩 내점 고객 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/landing/getStyData", method=RequestMethod.POST)
	public void getStyData(HttpServletRequest request, HttpServletResponse response) throws Exception{
		/*
		 * // ParameterMap 선언 ParameterMap parameterMap = getParameterMap(request,
		 * response); // Result 선언 String result = Const.BOOLEAN_SUCCESS; // JSONObject
		 * 선언 JSONObject json = new JSONObject();
		 * 
		 * try {
		 * 
		 * //내점 고객은 본사 유무만 따지면 됨. 쿼리 확인. if(parameterMap.getUserInfo() != null) {
		 * 
		 * String rgn_ldr_yn = parameterMap.getUserInfo().getRgn_ldr_yn(); //지역장 여부
		 * String cstr_cd = parameterMap.getUserInfo().getCstr_cd(); //자점 코드
		 * ArrayList<String> cstrArr = new ArrayList<String>(); // String blstr_cd =
		 * parameterMap.getUserInfo().getBlstr_cd(); // 소속점 코드 String shop_grde_cd =
		 * parameterMap.getUserInfo().getShop_grde_cd();// 매입 등급 코드 String grp_rol_id =
		 * parameterMap.getUserInfo().getGrp_rol_id();// 권한 등급 코드 String sty_title = "";
		 * 
		 * //지역장 여부. parameterMap.put("rgn_ldr_yn", rgn_ldr_yn);
		 * 
		 * if("Y".equals(rgn_ldr_yn)) { // 지역장일 경우 String[] cstr_cds =
		 * cstr_cd.split(","); for(String str : cstr_cds){ cstrArr.add(str); }
		 * parameterMap.put("cstr_cd", cstrArr); //지역명이 들어 갈 예정 sty_title =
		 * parameterMap.getUserInfo().getBsle_hdofic_nm(); } else if
		 * ("0000".equals(cstr_cd) || TextUtil.isEmpty(cstr_cd) ) {
		 * parameterMap.put("cstr_cd", ""); sty_title = "전사"; } else {// 점일 경우
		 * 
		 * if(TextUtil.isNotEmpty(shop_grde_cd) && (shop_grde_cd.indexOf('L') > -1 ||
		 * "9".equals(grp_rol_id))) { String[] cstr_cds = cstr_cd.split(","); for(String
		 * str : cstr_cds){ cstrArr.add(str); } parameterMap.put("cstr_cd", cstrArr);
		 * parameterMap.put("rgn_ldr_yn", "Y"); //for문을 위한 처리. sty_title =
		 * parameterMap.getUserInfo().getBsle_hdofic_nm(); } else {
		 * 
		 * parameterMap.put("cstr_cd", cstr_cd); sty_title =
		 * parameterMap.getUserInfo().getCstr_nm(); //자점 명 }
		 * 
		 * 
		 * }
		 * 
		 * json = landingMgr.getStyData(parameterMap); json.put("STY_TITLE", sty_title);
		 * }
		 * 
		 * }catch(Exception e) { log.error(e.toString()); result = Const.BOOLEAN_FAIL; }
		 * 
		 * // JSONObject 결과값 반환 json.put("RESULT", result); ResponseUtil.write(response,
		 * json.toJSONString());
		 */
	}
	
	/**
	 * ams 방문자 수
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/landing/getDstrbzarvst", method=RequestMethod.POST)
	public void getDstrbzarvst(HttpServletRequest request, HttpServletResponse response) throws Exception{
		/*
		 * // ParameterMap 선언 ParameterMap parameterMap = getParameterMap(request,
		 * response); // Result 선언 String result = Const.BOOLEAN_SUCCESS; // JSONObject
		 * 선언 JSONObject json = new JSONObject();
		 * 
		 * try {
		 * 
		 * 
		 * String rgn_ldr_yn = parameterMap.getUserInfo().getRgn_ldr_yn(); //지역장 여부
		 * String blstr_cd = parameterMap.getUserInfo().getBlstr_cd(); // 소속점 코드 String
		 * mstr_cd = parameterMap.getUserInfo().getMstr_cd(); //모점 코드 String cstr_cd =
		 * parameterMap.getUserInfo().getCstr_cd(); //자점 코드 String shop_grde_cd =
		 * parameterMap.getUserInfo().getShop_grde_cd();// 매입 등급 코드 String grp_rol_id =
		 * parameterMap.getUserInfo().getGrp_rol_id();// 권한 등급 코드 String dstr_title =
		 * ""; //방문자 점명
		 * 
		 * // 방문자 수 는 본사면 본점, 본점 -> 본점 , 직
		 * 
		 * //cstr_cd 가 비워있거나 본사이면 본점을 본다. if(TextUtil.isEmpty(cstr_cd) ||
		 * "0000".equals(cstr_cd)) { parameterMap.put("mstr_cd", "0001"); dstr_title =
		 * "본점"; } else if("Y".equals(rgn_ldr_yn)) { //지역 여부가 Y일 경우 소속점을 본다.
		 * parameterMap.put("mstr_cd", blstr_cd); dstr_title =
		 * parameterMap.getUserInfo().getBlstr_nm(); } else { //본사, 본점, 지역장 제외 모점코드
		 * 
		 * if(TextUtil.isNotEmpty(shop_grde_cd) && (shop_grde_cd.indexOf('L') > -1 ||
		 * "9".equals(grp_rol_id))) { parameterMap.put("mstr_cd", blstr_cd); dstr_title
		 * = parameterMap.getUserInfo().getBlstr_nm(); } else {
		 * parameterMap.put("mstr_cd", mstr_cd); dstr_title =
		 * parameterMap.getUserInfo().getMstr_nm();//모점을 본다. }
		 * 
		 * }
		 * 
		 * json = landingMgr.getDstrbzarvstList(parameterMap);
		 * 
		 * json.put("DSTR_TITLE", dstr_title);
		 * 
		 * 
		 * }catch(Exception e) { log.error(e.toString()); result = Const.BOOLEAN_FAIL; }
		 * 
		 * // JSONObject 결과값 반환 json.put("RESULT", result); ResponseUtil.write(response,
		 * json.toJSONString());
		 */
	}
	
	/**
	 * 고객 접점 
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/landing/getTsttscuststy", method=RequestMethod.POST)
	public void getTsttscuststy(HttpServletRequest request, HttpServletResponse response) throws Exception{
		/*
		 * // ParameterMap 선언 ParameterMap parameterMap = getParameterMap(request,
		 * response); // Result 선언 String result = Const.BOOLEAN_SUCCESS; // JSONObject
		 * 선언 JSONObject json = new JSONObject();
		 * 
		 * try {
		 * 
		 * String rgn_ldr_yn = parameterMap.getUserInfo().getRgn_ldr_yn(); //지역장 여부
		 * String cstr_cd = parameterMap.getUserInfo().getCstr_cd(); //자점 코드
		 * ArrayList<String> cstrArr = new ArrayList<String>(); // String blstr_cd =
		 * parameterMap.getUserInfo().getBlstr_cd(); // 소속점 코드 String shop_grde_cd =
		 * parameterMap.getUserInfo().getShop_grde_cd();// 매입 등급 코드 String grp_rol_id =
		 * parameterMap.getUserInfo().getGrp_rol_id();// 권한 등급 코드
		 * 
		 * //지역장 여부. parameterMap.put("rgn_ldr_yn", rgn_ldr_yn);
		 * 
		 * if("Y".equals(rgn_ldr_yn)) { // 지역장일 경우 String[] cstr_cds =
		 * cstr_cd.split(","); for(String str : cstr_cds){ cstrArr.add(str); }
		 * parameterMap.put("cstr_cd", cstrArr); //지역명이 들어 갈 예정 } else if
		 * ("0000".equals(cstr_cd) || TextUtil.isEmpty(cstr_cd) ) {
		 * parameterMap.put("cstr_cd", ""); } else {// 점일 경우
		 * 
		 * if(TextUtil.isNotEmpty(shop_grde_cd) && (shop_grde_cd.indexOf('L') > -1 ||
		 * "9".equals(grp_rol_id))) { String[] cstr_cds = cstr_cd.split(","); for(String
		 * str : cstr_cds){ cstrArr.add(str); } parameterMap.put("cstr_cd", cstrArr);
		 * parameterMap.put("rgn_ldr_yn", "Y"); //for문을 위한 처리. } else {
		 * 
		 * parameterMap.put("cstr_cd", cstr_cd); }
		 * 
		 * 
		 * } json = landingMgr.getTsttscuststy(parameterMap);
		 * 
		 * 
		 * }catch(Exception e) { log.error(e.toString()); result = Const.BOOLEAN_FAIL; }
		 * 
		 * // JSONObject 결과값 반환 json.put("RESULT", result); ResponseUtil.write(response,
		 * json.toJSONString());
		 */
	}
	
	
	/**
	 * VOC
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/landing/getMmcustvocList", method=RequestMethod.POST)
	public void getMmcustvocList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		/*
		 * // ParameterMap 선언 ParameterMap parameterMap = getParameterMap(request,
		 * response); // Result 선언 String result = Const.BOOLEAN_SUCCESS; // JSONObject
		 * 선언 JSONObject json = new JSONObject();
		 * 
		 * try {
		 * 
		 * String rgn_ldr_yn = parameterMap.getUserInfo().getRgn_ldr_yn(); //지역장 여부
		 * String cstr_cd = parameterMap.getUserInfo().getCstr_cd(); //자점 코드
		 * ArrayList<String> cstrArr = new ArrayList<String>(); // String blstr_cd =
		 * parameterMap.getUserInfo().getBlstr_cd(); // 소속점 코드 String shop_grde_cd =
		 * parameterMap.getUserInfo().getShop_grde_cd();// 매입 등급 코드 String grp_rol_id =
		 * parameterMap.getUserInfo().getGrp_rol_id();// 권한 등급 코드 String voc_title = "";
		 * 
		 * //지역장 여부. parameterMap.put("rgn_ldr_yn", rgn_ldr_yn);
		 * 
		 * if("Y".equals(rgn_ldr_yn)) { // 지역장일 경우 String[] cstr_cds =
		 * cstr_cd.split(","); for(String str : cstr_cds){ cstrArr.add(str); }
		 * parameterMap.put("cstr_cd", cstrArr); //지역명이 들어갈 예정 voc_title =
		 * parameterMap.getUserInfo().getBsle_hdofic_nm();
		 * 
		 * } else if ("0000".equals(cstr_cd) || TextUtil.isEmpty(cstr_cd) ) {
		 * parameterMap.put("cstr_cd", ""); voc_title = "전사"; } else {// 점일 경우
		 * 
		 * if(TextUtil.isNotEmpty(shop_grde_cd) && (shop_grde_cd.indexOf('L') > -1 ||
		 * "9".equals(grp_rol_id))) { String[] cstr_cds = cstr_cd.split(","); for(String
		 * str : cstr_cds){ cstrArr.add(str); } parameterMap.put("cstr_cd", cstrArr);
		 * parameterMap.put("rgn_ldr_yn", "Y"); //for문을 위한 처리. voc_title =
		 * parameterMap.getUserInfo().getBsle_hdofic_nm();
		 * 
		 * } else { cstrArr.add(cstr_cd); parameterMap.put("cstr_cd", cstrArr);
		 * voc_title = parameterMap.getUserInfo().getCstr_nm();
		 * 
		 * }
		 * 
		 * }
		 * 
		 * json = landingMgr.getMmcustvocList(parameterMap); json.put("VOC_TITLE",
		 * voc_title);
		 * 
		 * }catch(Exception e) { log.error(e.toString()); result = Const.BOOLEAN_FAIL; }
		 * 
		 * // JSONObject 결과값 반환 json.put("RESULT", result); ResponseUtil.write(response,
		 * json.toJSONString());
		 */
	}
	
	/**
	 * 라운지 현황
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/landing/getLngeutlprco", method=RequestMethod.POST)
	public void getLngeutlprco(HttpServletRequest request, HttpServletResponse response) throws Exception{
		/*
		 * // ParameterMap 선언 ParameterMap parameterMap = getParameterMap(request,
		 * response); // Result 선언 String result = Const.BOOLEAN_SUCCESS; // JSONObject
		 * 선언 JSONObject json = new JSONObject();
		 * 
		 * try {
		 * 
		 * String rgn_ldr_yn = parameterMap.getUserInfo().getRgn_ldr_yn(); //지역장 여부
		 * String blstr_cd = parameterMap.getUserInfo().getBlstr_cd(); // 소속점 코드 String
		 * cstr_cd = parameterMap.getUserInfo().getCstr_cd(); //자점 코드 String
		 * shop_grde_cd = parameterMap.getUserInfo().getShop_grde_cd();// 매입 등급 코드
		 * String grp_rol_id = parameterMap.getUserInfo().getGrp_rol_id();// 권한 등급 코드
		 * 
		 * String lng_title = ""; //라운지 점명
		 * 
		 * // 방문자 수 는 본사면 본점, 본점 -> 본점 , 직
		 * 
		 * //cstr_cd 가 비워있거나 본사이면 본점을 본다. //수도권3지역의 소속점(0339)은 VIP가 없으므로 본점을 보도록한다.
		 * if(TextUtil.isEmpty(cstr_cd) || "0000".equals(cstr_cd)) {
		 * parameterMap.put("cstr_cd", "0001"); lng_title = "본점"; } else
		 * if("Y".equals(rgn_ldr_yn) && ! "0339".equals(blstr_cd)) { //지역 여부가 Y일 경우 소속점을
		 * 본다. parameterMap.put("cstr_cd", blstr_cd); lng_title =
		 * parameterMap.getUserInfo().getBlstr_nm(); } else { //본사, 본점, 지역장 제외 모점코드
		 * if(TextUtil.isNotEmpty(shop_grde_cd) && (shop_grde_cd.indexOf('L') > -1 ||
		 * "9".equals(grp_rol_id))) { if("0339".equals(blstr_cd)){
		 * parameterMap.put("cstr_cd", "0001"); lng_title = "본점"; }else {
		 * parameterMap.put("cstr_cd", blstr_cd); lng_title =
		 * parameterMap.getUserInfo().getBlstr_nm(); } } else {
		 * parameterMap.put("cstr_cd", cstr_cd); lng_title =
		 * parameterMap.getUserInfo().getCstr_nm();//자점 } }
		 * 
		 * json = landingMgr.getLngeutlprco(parameterMap); json.put("LNG_TITLE",
		 * lng_title);
		 * 
		 * }catch(Exception e) { log.error(e.toString()); result = Const.BOOLEAN_FAIL; }
		 * 
		 * // JSONObject 결과값 반환 json.put("RESULT", result); ResponseUtil.write(response,
		 * json.toJSONString());
		 */
	}
	
	/**
	 * 라운지 현황
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/landing/getDetailLngeutlprco", method=RequestMethod.POST)
	public void getDetailLngeutlprco(HttpServletRequest request, HttpServletResponse response) throws Exception{
		/*
		 * // ParameterMap 선언 ParameterMap parameterMap = getParameterMap(request,
		 * response); // Result 선언 String result = Const.BOOLEAN_SUCCESS; // JSONObject
		 * 선언 JSONObject json = new JSONObject();
		 * 
		 * try {
		 * 
		 * String rgn_ldr_yn = parameterMap.getUserInfo().getRgn_ldr_yn(); //지역장 여부
		 * String cstr_cd = parameterMap.getUserInfo().getCstr_cd(); //자점 코드 String
		 * blstr_cd = parameterMap.getUserInfo().getBlstr_cd(); // 소속점 코드 String
		 * shop_grde_cd = parameterMap.getUserInfo().getShop_grde_cd();// 매입 등급 코드
		 * String grp_rol_id = parameterMap.getUserInfo().getGrp_rol_id();// 권한 등급 코드 //
		 * ArrayList<String> cstrArr = new ArrayList<String>();
		 * 
		 * //지역장 여부. parameterMap.put("rgn_ldr_yn", rgn_ldr_yn);
		 * 
		 * //cstr_cd 가 비워있거나 본사이면 본점을 본다. if(TextUtil.isEmpty(cstr_cd) ||
		 * "0000".equals(cstr_cd)) { parameterMap.put("cstr_cd", "0001"); } else
		 * if("Y".equals(rgn_ldr_yn) && ! "0339".equals(blstr_cd)) { //지역 여부가 Y일 경우 소속점을
		 * 본다. parameterMap.put("cstr_cd", blstr_cd); } else { //본사, 본점, 지역장 제외 모점코드
		 * if(TextUtil.isNotEmpty(shop_grde_cd) && (shop_grde_cd.indexOf('L') > -1 ||
		 * "9".equals(grp_rol_id))) { if("0339".equals(blstr_cd)){
		 * parameterMap.put("cstr_cd", "0001"); }else { parameterMap.put("cstr_cd",
		 * blstr_cd); } } else { parameterMap.put("cstr_cd", cstr_cd); } }
		 * 
		 * json = landingMgr.getDetailLngeutlprco(parameterMap);
		 * 
		 * 
		 * }catch(Exception e) { log.error(e.toString()); result = Const.BOOLEAN_FAIL; }
		 * 
		 * // JSONObject 결과값 반환 json.put("RESULT", result); ResponseUtil.write(response,
		 * json.toJSONString());
		 */
	}
	
	/**
	 * BI 리포트
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/landing/getReport", method=RequestMethod.POST)
	public void reportApi(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		/*
		 * ParameterMap parameterMap = getParameterMap(request, response);
		 * 
		 * String rgn_ldr_yn = parameterMap.getUserInfo().getRgn_ldr_yn(); //지역장 여부
		 * String cstr_cd = parameterMap.getUserInfo().getCstr_cd(); //자점 코드
		 * ArrayList<String> cstrArr = new ArrayList<String>(); // String blstr_cd =
		 * parameterMap.getUserInfo().getBlstr_cd(); // 소속점 코드 String shop_grde_cd =
		 * parameterMap.getUserInfo().getShop_grde_cd();// 매입 등급 코드 String grp_rol_id =
		 * parameterMap.getUserInfo().getGrp_rol_id();// 권한 등급 코드 String
		 * report_cstr_title = ""; JSONObject jsonObj = new JSONObject();
		 * 
		 * Boolean total_str_flag = true; //지역장 여부. parameterMap.put("rgn_ldr_yn",
		 * rgn_ldr_yn);
		 * 
		 * if("Y".equals(rgn_ldr_yn)) { // 지역장일 경우 String[] cstr_cds =
		 * cstr_cd.split(","); for(String str : cstr_cds){ cstrArr.add(str); }
		 * parameterMap.put("cstr_cd", cstrArr); //지역명이 들어갈 예정 report_cstr_title =
		 * parameterMap.getUserInfo().getBsle_hdofic_nm(); } else if
		 * ("0000".equals(cstr_cd) || TextUtil.isEmpty(cstr_cd) ) {
		 * parameterMap.put("cstr_cd", ""); report_cstr_title = "전사"; total_str_flag =
		 * false; } else {// 점일 경우
		 * 
		 * if(TextUtil.isNotEmpty(shop_grde_cd) && (shop_grde_cd.indexOf('L') > -1 ||
		 * "9".equals(grp_rol_id))) { String[] cstr_cds = cstr_cd.split(","); for(String
		 * str : cstr_cds){ cstrArr.add(str); } parameterMap.put("cstr_cd", cstrArr);
		 * report_cstr_title = parameterMap.getUserInfo().getBsle_hdofic_nm();
		 * parameterMap.put("rgn_ldr_yn", "Y"); //for문을 위한 처리. } else {
		 * 
		 * parameterMap.put("cstr_cd", cstr_cd); report_cstr_title =
		 * parameterMap.getUserInfo().getCstr_nm(); }
		 * 
		 * }
		 * 
		 * try {
		 * 
		 * JSONParser parser = new JSONParser(); //오브젝트에 담음 Object obj =
		 * parser.parse(BiReportUtil.getReport(parameterMap.getUserInfo().
		 * getMstr_uspr_id(), "")); //Json 으로 변경 jsonObj = (JSONObject) obj;
		 * 
		 * //본사가 아닐경우 전사의 신장률, 달성률을 갖고 온다. if(total_str_flag) { Object obj2 =
		 * parser.parse(BiReportUtil.getReport("BIGDATA01", "")); // 전사 권한이 들어갈 예정
		 * //Json 으로 변경 JSONObject jsonObj2 = (JSONObject) obj2;
		 * 
		 * jsonObj.put("TOTAL_STR", ((JSONObject) ((JSONObject)
		 * jsonObj2.get("data")).get("metricValues")).get("formatted"));
		 * 
		 * }
		 * 
		 * } catch (Exception e) { jsonObj.put("RESULT", "FAIL");
		 * log.error(e.toString()); }
		 * 
		 * jsonObj.put("REPORT_CSTR_TITLE", report_cstr_title);
		 * 
		 * ResponseUtil.write(response, jsonObj.toJSONString());
		 */
	}
	


}
