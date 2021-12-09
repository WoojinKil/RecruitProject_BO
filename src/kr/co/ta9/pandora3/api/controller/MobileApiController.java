package kr.co.ta9.pandora3.api.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import kr.co.ta9.pandora3.api.manager.BoardMgr;
import kr.co.ta9.pandora3.api.manager.ScheduleInfMgr;
import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.app.util.CommonUtil;
import kr.co.ta9.pandora3.common.conf.Configuration;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.exception.AppException;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.main.manager.MainMgr;
import kr.co.ta9.pandora3.pcommon.dto.TdspSysInf;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmMnu;
import kr.co.ta9.pandora3.pdsp.manager.Pdsp1011Mgr;
import kr.co.ta9.pandora3.psys.manager.PsysCommonMgr;

@Controller
@RequestMapping(value="/api/**")
public class MobileApiController extends CommonActionController{

	@Autowired
	private MainMgr mainMgr;

	@Autowired
	private PsysCommonMgr psysCommonMgr;

	@Autowired
	private BoardMgr boardMgr;

	@Autowired
	private ScheduleInfMgr scheduleInfMgr;

	@Autowired
	private Pdsp1011Mgr pdsp1011Mgr;


	/**
	 * 공통 > mobile
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/mobileLogin", method = RequestMethod.POST)
	public void mobileLogin(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// parameterMap에 ip_addr 담기
		// json 선언
		JSONObject json = new JSONObject();

		// userInfo 선언
		UserInfo userInfo = new UserInfo();

		//로그인 결과 타입
		HttpSession session = request.getSession();
		session.setAttribute("_pre_url", request.getParameter("_pre_url"));
		session.setAttribute("lgnId", request.getParameter("lgnId"));
		session.setAttribute("usrNm", request.getParameter("usrNm"));
		session.setAttribute("usrEmlAdr", request.getParameter("usrEmlAdr"));
		session.setAttribute("usrSsCd", request.getParameter("usrSsCd"));
		session.setAttribute("actvYn", request.getParameter("actvYn"));

		String shop_grde_cd ="";
		String ip_addr = request.getHeader("X-FORWARDED-FOR");
		if (ip_addr == null) ip_addr = request.getRemoteAddr();
		parameterMap.put("ip_addr", ip_addr);
		// result 선언
		String result =  Const.BOOLEAN_SUCCESS;
		ArrayList<Map<String,Object>> listdata = new ArrayList<Map<String,Object>>();

		try {
			// 사용자 로그인  user id가 있으면 userId로 로그인 아니면 lgn_id, lgn_pwd로 로그인 시도
			parameterMap.put("mobile_yn", "Y");
			parameterMap.put("sys_cd", "11");
			userInfo = mainMgr.registAdminLogin(parameterMap);
			//실제 로그인 및 사이트 접속 가능한 상태일 경우 마지막 로그인 정보 처리
			if(userInfo.isLogin() && (!("".equals(userInfo.getApvl_yn()) || "N".equals(userInfo.getApvl_yn()) || userInfo.getApvl_yn() == null))) {
				userInfo.setSys_cd(parameterMap.getValue("sys_cd"));
				mainMgr.lastLgnInfCheck(userInfo);
				JSONObject jsonAccessSite = new JSONObject();
				jsonAccessSite = pdsp1011Mgr.getAccessSitList(parameterMap);
				shop_grde_cd =mainMgr.selectShopGrdeCdOne(parameterMap);

				ObjectMapper mapper = new ObjectMapper();
				String jsonStirng = mapper.writeValueAsString(jsonAccessSite.get("rows"));
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonStirng);
				JSONArray jsonArray = (JSONArray)obj;
				Configuration configuration = Configuration.getInstance();
				String target = configuration.get("properties.target");
				if (jsonArray != null && !jsonArray.isEmpty()) {
					  for (int i=0;i<jsonArray.size();   i++){
						  JSONObject tmpJson =(JSONObject) jsonArray.get(i);
						  HashMap<String,Object> tmpMap = new HashMap<String,Object>();
						  String strUrl  = String.valueOf(tmpJson.get("SYS_URL"));
						  if(!"#".equals(strUrl)){
							  if(tmpJson.get("SYS_CD")!=null){
								  tmpMap.put("SYS_CD",String.valueOf(tmpJson.get("SYS_CD")));
							  }
							  if(tmpJson.get("SYS_NM")!=null){
								  tmpMap.put("SYS_NM",String.valueOf(tmpJson.get("SYS_NM")));
							  }
							  if(tmpJson.get("SYS_PTH")!=null){
								  tmpMap.put("SYS_PTH",String.valueOf(tmpJson.get("SYS_PTH")).replace("/", ""));
							  }
							  listdata.add(tmpMap);
							  /*
							  //디봇 모바일의 경우 운영기는 우선 제외
							  if("prd".equals(target) && tmpJson.get("SYS_CD")!=null && "15".equals(String.valueOf(tmpJson.get("SYS_CD"))) ) {

							  }else{

							  }
							  */

						  }
					}
				}
			}
		}catch (AppException e) {
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		}
		catch (Exception e) {
			// Exception일 경우
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		// json에 login 담기
		json.put("LOGIN", userInfo.getLogin_result());
		// json에 apvl_yn 담기
		json.put("APVL_YN", userInfo.getApvl_yn());
		json.put("DBOT_SHOP_GRDE_CD", shop_grde_cd);
		json.put("SYS_CD", "11");

		json.put("userInfo", CommonUtil.convertObjectToMap(userInfo));
		json.put("SITE_ACCESS_INFO",listdata);
		// json에 login_pw_remain 담기
		json.put("LOGIN_PW_REMAIN", userInfo.getLogin_pw_remain());
		// json에 last_access_dy 담기
		json.put("LAST_ACCESS_DY", userInfo.getLast_access_dy());
		// json에 last_access_ip_addr 담기
		json.put("LAST_ACCESS_IP_ADDR", userInfo.getLast_access_ip_addr());

		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 공통 > 로그인 후 BO 초기화면 로딩 시 사용자 메뉴 및 바로가기 메뉴 조회 :: 2017
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getMobileTsysAdmMnuList", method = RequestMethod.POST)
	public void getTsysAdmMnuList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// menuList 선언
		List<Map<String,Object>> menuList = new ArrayList<Map<String,Object>>();

		List<Map<String,Object>> shortCutList = new ArrayList<Map<String,Object>>();

		parameterMap.put("user_id", parameterMap.getValue("usr_id"));
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		try {

			List<TsysAdmMnu> tsysAdmMnuList = null;
			// rol_app 가 있을 경우 권한 신청 페이지 별도 표츌
			if(TextUtil.isEmpty(parameterMap.getValue("rol_app"))) {
				tsysAdmMnuList = psysCommonMgr.selectTsysAdmMnuListByMnuList(parameterMap);
			} else {
				tsysAdmMnuList = psysCommonMgr.getTsysAdmRolAppMnu(parameterMap);
			}
			// 사용자 메뉴 리스트 : convert object to map for json
			menuList = new ArrayList<Map<String,Object>>();

			if(tsysAdmMnuList != null && (!tsysAdmMnuList.isEmpty())){
				for (TsysAdmMnu tsysAdmMnu : tsysAdmMnuList) {
					Map<String,Object> data = new HashMap<String,Object>();
					data.put("TOP_MNU_SEQ"   , tsysAdmMnu.getTop_mnu_seq());	// 상위메뉴순번
					data.put("TOP_MNU_NM"    , tsysAdmMnu.getTop_mnu_nm());		// 상위메뉴명
					data.put("TOP_SRT_SEQ"   , tsysAdmMnu.getTop_srt_seq());	// 상위전시순위
					data.put("MIDD_MNU_SEQ"  , tsysAdmMnu.getMidd_mnu_seq());	// 중위메뉴순번
					data.put("MIDD_MNU_NM"   , tsysAdmMnu.getMidd_mnu_nm());	// 중위메뉴명
					data.put("MIDD_SRT_SEQ"  , tsysAdmMnu.getMidd_srt_seq());	// 중위전시순위
					data.put("MNU_SEQ"       , tsysAdmMnu.getMnu_seq());		// 하단메뉴순번
					data.put("MNU_NM"        , tsysAdmMnu.getMnu_nm());			// 하단메뉴명
					data.put("SRT_SEQ"       , tsysAdmMnu.getSrt_sqn());		// 하단전시순위
					data.put("URL"           , tsysAdmMnu.getUrl());			// URL
					data.put("MNU_TP_CD"     , tsysAdmMnu.getMnu_tp_cd());		// 메뉴타입코드
					data.put("BTN_INFO"      , tsysAdmMnu.getBtn_info());		// 버튼정보[배열]
					data.put("CURR_URL"      , request.getServletPath());		// 서블릿경로
					data.put("DETP_FULL_NM"  , tsysAdmMnu.getDepth_fullname());	// 메뉴네비 풀경로
					menuList.add(data);
				}
			}

		} catch (AppException e) {
			result = Const.BOOLEAN_FAIL;
			log.error(e.toString());
		}catch (Exception e) {
			// Exceptin 일 경우
			result = Const.BOOLEAN_FAIL;
			log.error(e.toString());
		}
		// json 선언
		JSONObject json = new JSONObject();
		// json에 결과 담기
		json.put("RESULT", result);
		// json에 menu_list 담기
		json.put("MENU_LIST", menuList);
		// json에 shcut_list 담기
		json.put("SHCUT_LIST", shortCutList);
		ResponseUtil.write(response, json.toJSONString());
	}


	/**
	 * 공통 > mobile
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/noticeList", method = RequestMethod.POST)
	public void noticeList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// parameterMap에 ip_addr 담기
		// json 선언
		JSONObject json = new JSONObject();
		List<Map<String,Object>>listMap =boardMgr.selectNoticeList(parameterMap);

		 ArrayList<Map<String,Object>> listNoiceInfo = new ArrayList<Map<String,Object>>();
		 int page =  parameterMap.getInt("page");
		 String result = Const.BOOLEAN_SUCCESS;
		 long totalCount = 0;
		 long totalPage = 0;
		try {
			 for (Map<String,Object> map : listMap) {
					Map<String,Object> data = new HashMap<String,Object>();
					String notcYn = String.valueOf(map.get("NOTC_YN"));
					if(page > 1 && "Y".equals(notcYn) ){   //처음 페이지가 아니고 공지 일경우 공지데이터 제외
						continue;
					}
					data.put("TOTAL_PAGE"     ,   String.valueOf(map.get("TOTAL_PAGE")));
					data.put("TOTAL_COUNT"     ,   String.valueOf(map.get("TOTAL_COUNT")));
					data.put("MODL_SEQ"       ,   String.valueOf(map.get("MODL_SEQ")));
					data.put("DOC_SEQ"        ,   String.valueOf(map.get("DOC_SEQ")));
					data.put("LGN_ID"         ,   String.valueOf(map.get("LGN_ID")));
					data.put("USR_NM"         ,   String.valueOf(map.get("USR_NM")));
					data.put("TITL"           ,   String.valueOf(map.get("TITL")));
					data.put("NOTC_YN"        ,   String.valueOf(map.get("NOTC_YN")));
					data.put("CTEGRY_MST_CD"  ,   String.valueOf(map.get("CTEGRY_MST_CD")));
					data.put("CTEGRY_DTL_CD"  ,   String.valueOf(map.get("CTEGRY_DTL_CD")));
					data.put("CTEGRY_MST_NM"  ,   String.valueOf(map.get("CTEGRY_MST_NM")));
					data.put("CTEGRY_DTL_NM"  ,   String.valueOf(map.get("CTEGRY_DTL_NM")));
					data.put("DSPLY_STAT"     ,   String.valueOf(map.get("DSPLY_STAT")));
					data.put("MODL_NM"        ,   String.valueOf(map.get("MODL_NM")));
					data.put("CRT_DTTM"       ,   String.valueOf(map.get("CRT_DTTM")));
					data.put("UPD_DTTM"       ,   String.valueOf(map.get("UPD_DTTM")));
					data.put("FL_CNT"         ,   String.valueOf(map.get("FL_CNT")));
					data.put("SYS_NM"         ,   String.valueOf(map.get("SYS_NM")));
					data.put("SYS_CD"        ,   String.valueOf(map.get("SYS_CD")));

					listNoiceInfo.add(data);
				}
			   int index = 0;
			   if(listNoiceInfo != null && !listNoiceInfo.isEmpty()){
				   if("Y".equals(listNoiceInfo.get(0).get("NOTC_YN")) && page == 1){
						index ++;
					}
					if(listNoiceInfo.size()>= index){
						totalCount = listNoiceInfo.get(index).get("TOTAL_COUNT") == null? 0 : Long.valueOf(String.valueOf(listNoiceInfo.get(index).get("TOTAL_COUNT")));
						totalPage = listNoiceInfo.get(index).get("TOTAL_PAGE") == null? 0 : Long.valueOf(String.valueOf(listNoiceInfo.get(index).get("TOTAL_PAGE")));
					}
			   }



		} catch (AppException e) {
			result = Const.BOOLEAN_FAIL;
			log.error(e.toString());
		}catch (Exception e) {
			result = Const.BOOLEAN_FAIL;

			log.error(e.toString());
		}
		json.put("RESULT", result);
		json.put("records", totalCount);
		json.put("total", totalPage);
		json.put("page", page);
		json.put("rows", listNoiceInfo);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 공통 > mobile > 팝업 공지사항 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/popNotice", method = RequestMethod.POST)
	public void selectPopNotice(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// parameterMap에 ip_addr 담기
		// json 선언
		parameterMap.put("dsply_stat", "게시중");
		parameterMap.put("front_notice_yn", "공지");
		JSONObject json = new JSONObject();
		List<Map<String,Object>>listMap =boardMgr.selectPopNotice(parameterMap);
		
		ArrayList<Map<String,Object>> listNoiceInfo = new ArrayList<Map<String,Object>>();
		String result = Const.BOOLEAN_SUCCESS;
		try {
			for (Map<String,Object> map : listMap) {
				Map<String,Object> data = new HashMap<String,Object>();
				data.put("MODL_SEQ"       ,   String.valueOf(map.get("MODL_SEQ")));
				data.put("DOC_SEQ"        ,   String.valueOf(map.get("DOC_SEQ")));
				data.put("LGN_ID"         ,   String.valueOf(map.get("LGN_ID")));
				data.put("USR_NM"         ,   String.valueOf(map.get("USR_NM")));
				data.put("TITL"           ,   String.valueOf(map.get("TITL")));
				data.put("CTS"           ,   String.valueOf(map.get("CTS")));
				data.put("NOTC_YN"        ,   String.valueOf(map.get("NOTC_YN")));
				data.put("CTEGRY_MST_CD"  ,   String.valueOf(map.get("CTEGRY_MST_CD")));
				data.put("CTEGRY_DTL_CD"  ,   String.valueOf(map.get("CTEGRY_DTL_CD")));
				data.put("CTEGRY_MST_NM"  ,   String.valueOf(map.get("CTEGRY_MST_NM")));
				data.put("CTEGRY_DTL_NM"  ,   String.valueOf(map.get("CTEGRY_DTL_NM")));
				data.put("DSPLY_STAT"     ,   String.valueOf(map.get("DSPLY_STAT")));
				data.put("MODL_NM"        ,   String.valueOf(map.get("MODL_NM")));
				data.put("CRT_DTTM"       ,   String.valueOf(map.get("CRT_DTTM")));
				data.put("UPD_DTTM"       ,   String.valueOf(map.get("UPD_DTTM")));
				data.put("FL_CNT"         ,   String.valueOf(map.get("FL_CNT")));
				data.put("SYS_NM"         ,   String.valueOf(map.get("SYS_NM")));
				data.put("SYS_CD"        ,   String.valueOf(map.get("SYS_CD")));
				
				listNoiceInfo.add(data);
			}
			
			
		} catch (AppException e) {
			result = Const.BOOLEAN_FAIL;
			log.error(e.toString());
		}catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
			
			log.error(e.toString());
		}
		json.put("RESULT", result);
		json.put("rows", listNoiceInfo);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 공통 > mobile
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/noticeView", method = RequestMethod.POST)
	public void noticeView(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// parameterMap에 ip_addr 담기
		// json 선언
		JSONObject json = new JSONObject();
		List<Map<String,Object>>listMap =boardMgr.selectNoticeView(parameterMap);
		 ArrayList<Map<String,Object>> listNoiceInfo = new ArrayList<Map<String,Object>>();
		 List<Map<String,Object>>listFileMap  = new ArrayList<Map<String,Object>>();
		 String result = Const.BOOLEAN_SUCCESS;
		try {

			 for (Map<String,Object> map : listMap) {
					Map<String,Object> data = new HashMap<String,Object>();
					data.put("MODL_SEQ"       ,   String.valueOf(map.get("MODL_SEQ")));
					data.put("DOC_SEQ"        ,   String.valueOf(map.get("DOC_SEQ")));
					data.put("USR_NM"         ,   String.valueOf(map.get("USR_NM")));
					data.put("TITL"           ,   String.valueOf(map.get("TITL")));
					data.put("CTS"           ,   String.valueOf(map.get("CTS")));
					data.put("NOTC_YN"        ,   String.valueOf(map.get("NOTC_YN")));
					data.put("CTEGRY_MST_CD"  ,   String.valueOf(map.get("CTEGRY_MST_CD")));
					data.put("CTEGRY_DTL_CD"  ,   String.valueOf(map.get("CTEGRY_DTL_CD")));
					data.put("CTEGRY_MST_NM"  ,   String.valueOf(map.get("CTEGRY_MST_NM")));
					data.put("CTEGRY_DTL_NM"  ,   String.valueOf(map.get("CTEGRY_DTL_NM")));
					data.put("DSPLY_STAT"     ,   String.valueOf(map.get("DSPLY_STAT")));
					data.put("MODL_NM"        ,   String.valueOf(map.get("MODL_NM")));
					data.put("CRT_DTTM"       ,   String.valueOf(map.get("CRT_DTTM")));
					data.put("UPD_DTTM"       ,   String.valueOf(map.get("UPD_DTTM")));
					data.put("FL_CNT"         ,   String.valueOf(map.get("FL_CNT")));
					data.put("SYS_NM"         ,   String.valueOf(map.get("SYS_NM")));
					data.put("SYS_CD"        ,   String.valueOf(map.get("SYS_CD")));

					listNoiceInfo.add(data);
				}
			 listFileMap =boardMgr.selectUpFileInfo(parameterMap);

		}catch (AppException e) {
			result = Const.BOOLEAN_FAIL;
			log.error(e.toString());
		} catch (Exception e) {
			log.error(e.toString());
			e.printStackTrace();
			result =  Const.BOOLEAN_FAIL;
		}
		json.put("RESULT", result);
		json.put("noticeInfoMap", listNoiceInfo);
		json.put("noticeFileInfoList", listFileMap);

		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 공통 > mobile
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/schduleInfo", method = RequestMethod.POST)
	public void schduleInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// parameterMap에 ip_addr 담기
		// json 선언
		JSONObject json = new JSONObject();
		String result = Const.BOOLEAN_SUCCESS;
		List<Map<String,Object>>listMap = new ArrayList<Map<String,Object>>();
		try {
			listMap = scheduleInfMgr.selectSchedulenfList(parameterMap);
		} catch (AppException e) {
			result = Const.BOOLEAN_FAIL;
			log.error(e.toString());
		}catch (Exception e) {
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		}

		json.put("RESULT", result);
		json.put("scheDuleList", listMap);
		ResponseUtil.write(response, json.toJSONString());
	}
}
