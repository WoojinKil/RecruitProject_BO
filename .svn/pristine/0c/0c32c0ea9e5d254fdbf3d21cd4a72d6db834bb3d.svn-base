package kr.co.ta9.pandora3.psys.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.Serializable;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.GetObjectRequest;
import com.amazonaws.services.s3.model.S3Object;
import com.mysql.jdbc.StringUtils;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.app.util.CodeUtil;
import kr.co.ta9.pandora3.common.conf.Config;
import kr.co.ta9.pandora3.common.conf.Configuration;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.servlet.download.FileDownLoad;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pcommon.dto.TbbsFlInf;
import kr.co.ta9.pandora3.pcommon.dto.TcmnCdDtl;
import kr.co.ta9.pandora3.pcommon.dto.TmbrAdmLgnInf;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmMnu;
import kr.co.ta9.pandora3.pcommon.dto.usrdef.CommonInfo;
import kr.co.ta9.pandora3.psys.manager.PsysCommonMgr;
/**
* <pre>
* 1. 클래스명 : PsysCommonController
* 2. 설명 : Psys 공통 컨트롤러
* 3. 작성일 : 2018-03-27
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class PsysCommonController extends CommonActionController{

	@Autowired
	private PsysCommonMgr psysCommonMgr;

	/**
	 * 코드 상세 조회(복수)
	 * 작성일 : 2018-03-27
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getPsysCommon", method = RequestMethod.POST)
	public void getPsysCommon(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		List<Map<String,Object>> selectData = new ArrayList<Map<String,Object>>();
		try {
			// 코드 상세 조회
			List<TcmnCdDtl> multiTcmnCdDtl = psysCommonMgr.selectTcmnCdDtlMultiList(parameterMap);
			String[] mst_cd_arr = parameterMap.getValue("mst_cd_arr").split(",");

			if("ERIKIN_BOARD".equals(mst_cd_arr[0])) {
				int size = multiTcmnCdDtl.size();
				if(size > 0) {
					List<HashMap<String , Object>> module_srl_list =  new ArrayList<HashMap<String , Object>>();
					for(int i=0; i<multiTcmnCdDtl.size(); i++) {
						HashMap<String , Object> map = new HashMap<String, Object>();
						map.put("module_srl", multiTcmnCdDtl.get(i).getCd());
						module_srl_list.add(map);
					}
					parameterMap.put("module_srl_list", module_srl_list);
				}
			}

			for(TcmnCdDtl SysCd : multiTcmnCdDtl){
				Map<String,Object> data = new HashMap<String,Object>();
				data.put("MST_CD"   , SysCd.getMst_cd());
				data.put("MST_CD_NM", SysCd.getMst_cd_nm());
				data.put("CD"       , SysCd.getCd());
				data.put("CD_NM"    , SysCd.getCd_nm());
         		data.put("REF_1"    , SysCd.getRef_1());
				data.put("REF_2"    , SysCd.getRef_2());
				data.put("REF_3"    , SysCd.getRef_3());
				data.put("SRT_SEQ"  , SysCd.getSrt_sqn());
				data.put("CD_DESC"  , SysCd.getCd_desc());
				selectData.add(data);
			}
		}
		catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 SYSCDDTL 담기
		json.put("selectData",selectData);
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * select box 데이터 조회
	 * 작성일 : 2019-08-06
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getPsysCommonInfoList", method = RequestMethod.POST)
	public void getPsysCommonInfoList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		List<Map<String,Object>> selectCommData = new ArrayList<Map<String,Object>>();
		try {
			// select box 데이터 조회
			List<CommonInfo> CommonInfo = psysCommonMgr.getPsysCommonInfoList(parameterMap);

			for(CommonInfo comCd : CommonInfo){

				Map<String,Object> data = new HashMap<String,Object>();

				data.put("CODE_CD"   , comCd.getCode_cd());		// 코드
				data.put("CODE_NM"   , comCd.getCode_nm());		// 명
				data.put("CODE_ETC"  , comCd.getCode_etc());		// 기타

				data.put("CODE_CD_1" , comCd.getCode_cd1());
				data.put("CODE_CD_2" , comCd.getCode_cd2());
				data.put("CODE_CD_3" , comCd.getCode_cd3());
				data.put("CODE_CD_4" , comCd.getCode_cd4());
				data.put("CODE_CD_5" , comCd.getCode_cd5());
				data.put("CODE_CD_6" , comCd.getCode_cd6());
				data.put("CODE_CD_7" , comCd.getCode_cd7());
				data.put("CODE_CD_8" , comCd.getCode_cd8());
				data.put("CODE_CD_9" , comCd.getCode_cd9());

				data.put("CODE_NM_1" , comCd.getCode_nm1());
				data.put("CODE_NM_2" , comCd.getCode_nm2());
				data.put("CODE_NM_3" , comCd.getCode_nm3());
				data.put("CODE_NM_4" , comCd.getCode_nm4());
				data.put("CODE_NM_5" , comCd.getCode_nm5());
				data.put("CODE_NM_6" , comCd.getCode_nm6());
				data.put("CODE_NM_7" , comCd.getCode_nm7());
				data.put("CODE_NM_8" , comCd.getCode_nm8());
				data.put("CODE_NM_9" , comCd.getCode_nm9());

				data.put("CODE_ETC_1" , comCd.getCode_etc1());
				data.put("CODE_ETC_2" , comCd.getCode_etc2());
				data.put("CODE_ETC_3" , comCd.getCode_etc3());
				data.put("CODE_ETC_4" , comCd.getCode_etc4());
				data.put("CODE_ETC_5" , comCd.getCode_etc5());
				data.put("CODE_ETC_6" , comCd.getCode_etc6());
				data.put("CODE_ETC_7" , comCd.getCode_etc7());
				data.put("CODE_ETC_8" , comCd.getCode_etc8());
				data.put("CODE_ETC_9" , comCd.getCode_etc9());

				selectCommData.add(data);
			}
		}
		catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 SYSCDDTL 담기
		json.put("selectCommData",selectCommData);
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	* 메인 > 회원가입 - 이메일 전송
	* 작성일 : 2017-12-05
	* @param request
	* @param response
	* @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/psys/sndCertEml", method = RequestMethod.POST)
	public void sndCertEml(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		try {
			result = psysCommonMgr.sndCertEml(parameterMap, request, response);
		}
		catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json 선언
		JSONObject json = new JSONObject();
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}


	/**
	 * 회원가입완료 > 이메일 인증 화면 호출
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/psys/JnEml.do")
	public ModelAndView JnEml(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ModelAndView 선언
		ModelAndView mav = new ModelAndView();
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// parameter 선언
		// String login_id = (null == request.getParameter("login_id") || "".equals(request.getParameter("login_id"))) ? "" : request.getParameter("login_id");
		String jn_ctf_key = (null == request.getParameter("jn_ctf_key") || "".equals(request.getParameter("jn_ctf_key"))) ? "" : request.getParameter("jn_ctf_key");
		// result 선언
		String result = "";
		try {

			parameterMap.put("jn_ctf_key", jn_ctf_key);
			mav.addObject("JN_CTF_KEY", jn_ctf_key);
			// 인증키 유효기간

			List<TmbrAdmLgnInf> tmbrAdmLgnInfList = psysCommonMgr.selectTmbrAdmLgnInfList(parameterMap);

			if(tmbrAdmLgnInfList != null && (!tmbrAdmLgnInfList.isEmpty())) {
				TcmnCdDtl cert_term = CodeUtil.getTcmnCdDtl("LOGIN_PROP", "JOIN_TERM");
//				int join_key_cert_term = Integer.parseInt(cert_term.getRef_1())*1000*60*60*24;

				TmbrAdmLgnInf tmbrAdmLgnInf = tmbrAdmLgnInfList.get(0);

				if("1".equals(tmbrAdmLgnInf.getUsr_stat_cd())) {
					mav.addObject("CERT_KEY_STATUS", "ALREADY_CERT_KEY");
				} else {
					// 인증키 유효기간 (공통코드 : Day단위)
					Long join_term = Long.parseLong(cert_term.getRef_1())*1000*60*60*24;
					// 인증키 발급일 Long
					// 2019-02-20 주석처리  Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(tmbrAdmLgnInf.getJn_ctf_dttm());
					long l_join_key_date = tmbrAdmLgnInf.getJn_ctf_dttm().getTime();
					// 현재시간 long
					long currentTime = System.currentTimeMillis();
					// 인증키 발급일 + 인증키 유효기간이 현재시간보다 작으면 : 인증키 유효
					if(join_term + l_join_key_date > currentTime || join_term == 0) {
//					if(sysUser.getJoin_cert_key_term() < join_key_cert_term) {
						// 인증키 상태 구분
						if(join_term == 0) {
							mav.addObject("CERT_KEY_STATUS", "PASSOK_CERT_KEY");
						} else {
							mav.addObject("CERT_KEY_STATUS", "VALID_CERT_KEY");
							// 가입 허용 기간
							String key_date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH).format(tmbrAdmLgnInf.getJn_ctf_dttm());
							//String key_date = tmbrAdmLgnInf.getJn_ctf_dttm().toString();
							//String join_max_term = DateUtil.format(Integer.parseInt(cert_term.getRef_1()), "yyyy-MM-dd hh:mm:ss", key_date);
							mav.addObject("JOIN_MAX_TERM", key_date);
						}
						mav.addObject("LGN_ID"       , tmbrAdmLgnInf.getLgn_id());
						mav.addObject("USR_EML_ADDR"  , tmbrAdmLgnInf.getUsr_eml_addr());
						mav.addObject("USER_SS_CD"   , tmbrAdmLgnInf.getUsr_stat_cd());
					} else {
						mav.addObject("CERT_KEY_STATUS", "EXPIRED_CERT_KEY");
					}
				}
			} else { // 해당 회원이 존재하지 않는 경우 (기존의 인증키를 사용하지 않은채로 재전송을 클릭한 경우)
				mav.addObject("CERT_KEY_STATUS", "EXPIRED_CERT_KEY");
			}
		} catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// 결과값 반환
		mav.setViewName("/pandora3/psys/psys1017signToEmail");
		mav.addObject("RESULT", result);
		return mav;
	}
	/**
	 * 회원가입완료 > 이메일 인증 화면 호출
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/psys/saveUsrCertInf")
	public void saveUsrCertInf (HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// parameter 선언
//		String login_id = (null == request.getParameter("lgn_id") || "".equals(request.getParameter("lgn_id"))) ? "" : request.getParameter("lgn_id");
		String jn_ctf_key = (null == request.getParameter("jn_ctf_key") || "".equals(request.getParameter("jn_ctf_key"))) ? "" : request.getParameter("jn_ctf_key");
		// result 선언
		String result = Const.BOOLEAN_FAIL;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			parameterMap.put("jn_ctf_key", jn_ctf_key);
			// 회원정보 취득
			List<TmbrAdmLgnInf> tmbrAdmLgnInfList = psysCommonMgr.selectTmbrAdmLgnInfList(parameterMap);

			if (tmbrAdmLgnInfList != null && (!tmbrAdmLgnInfList.isEmpty())) {

				TmbrAdmLgnInf tmbrAdmLgnInf = tmbrAdmLgnInfList.get(0);
				TmbrAdmLgnInf admin = new TmbrAdmLgnInf();

				// 인증키 정보 취득
				TcmnCdDtl cert_term = CodeUtil.getTcmnCdDtl("LOGIN_PROP", "JOIN_TERM");
				// 인증키 유효기간 (공통코드 : Day단위)
				Long join_term = Long.parseLong(cert_term.getRef_1())*1000*60*60*24;
				// 인증키 발급일 Long
				// 2019-02-20 주석처리 Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(tmbrAdmLgnInf.getJn_ctf_dttm());
				long l_join_key_date = tmbrAdmLgnInf.getJn_ctf_dttm().getTime();
				// 현재시간 long
				long currentTime = System.currentTimeMillis();
				// 인증키 발급일 + 인증키 유효기간이 현재시간보다 작으면 : 인증키 유효
				if(join_term + l_join_key_date > currentTime || join_term == 0) {
					// 회원상태가 미인증일 때만 업데이트 (미인증 -> 인증)
					if("3".equals(tmbrAdmLgnInf.getUsr_stat_cd())) {
						admin.setUpdr_id(tmbrAdmLgnInf.getUsr_id());
						admin.setUsr_id(tmbrAdmLgnInf.getUsr_id());
						admin.setUsr_stat_cd("1");

						psysCommonMgr.updateTmbrAdmLgnInf(admin);

						result = Const.BOOLEAN_SUCCESS;
					} else {
						// 인증 완료된 회원
						result = "ALREADY_CERT_KEY";
					}
				} else { // 인증키가 유효기간이 끝나면
					result = "EXPIRED_CERT_KEY";
				}
			}
		} catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 공통 > 로그인 후 BO 초기화면 로딩 시 사용자 메뉴 및 바로가기 메뉴 조회 :: 2017
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getTsysAdmMnuList", method = RequestMethod.POST)
	public void getTsysAdmMnuList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// menuList 선언
		List<Map<String,Object>> menuList = new ArrayList<Map<String,Object>>();

		List<Map<String,Object>> shortCutList = new ArrayList<Map<String,Object>>();

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
					data.put("VDI_SCRN_YN"  , tsysAdmMnu.getVdi_scrn_yn());		// VDI 여부
					data.put("PRN_INF_SCRN_YN"  , tsysAdmMnu.getPrn_inf_scrn_yn());	// 
					menuList.add(data);
				}
			}

		} catch (Exception e) {
			// Exceptin 일 경우
			result = Const.BOOLEAN_FAIL;
			logger.error(e);
		}


		JSONObject menuJson= new JSONObject();
		menuJson.put("SESSION_MENU_LIST", menuList);
		HttpSession session = request.getSession();
		session.setAttribute("MENU_LIST", menuJson.toJSONString());



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
	 * 공통 > breadCrumb(홈 > 시스템관리 > 코드관리 > 코드관리) 메뉴 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getTsysAdmMnuBreadCrumb", method = RequestMethod.POST)
	public void getTsysAdmMnuBreadCrumb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		// json 선언
		JSONObject json = new JSONObject();

		try {

			json = psysCommonMgr.selectTsysAdmMnuBreadCrumb(parameterMap);

		} catch (Exception e) {
			// Exceptin 일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT" , result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 그리드 엑셀 다운로드 공통
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/common/dwldXlsx")
	public void dwldXlsx(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// gridHeader 선언
		Map<String,String> gridHeader = parameterMap.parseGridHeader();
		// gridList 선언
		List<Map<String,String>> gridList = parameterMap.parseGridData();
		// fileDownLoad
		FileDownLoad.exportExcel(response, gridHeader, gridList);
	}

	/**
	*즐겨찾기 추가
	* 작성일 : 2017-12-05
	* @param request
	* @param response
	* @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/psys/insertTsysAdmFvrt", method = RequestMethod.POST)
	public void insertTsysAdmFvrt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		try {
			 psysCommonMgr.insertTsysAdmFvrt(parameterMap);
		}
		catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json 선언
		JSONObject json = new JSONObject();
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	*즐겨찾기 존재유무조회
	* 작성일 : 2017-12-05
	* @param request
	* @param response
	* @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/psys/selectExistTsysAdmFvrt", method = RequestMethod.POST)
	public void getTsysAdmFvrt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		String existYn ="";

		try {
			existYn = psysCommonMgr.selectExistTsysAdmFvrt(parameterMap);
		}
		catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json 선언
		JSONObject json = new JSONObject();
		// json에 결과 담기
		json.put("RESULT", result);
		json.put("EXIST_YN", existYn);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 즐겨찾기 목록 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/psys/getTsysAdmFvrtList", method = RequestMethod.POST)
	public void getTsysAdmFvrtList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);

		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {

			json = psysCommonMgr.getTsysAdmFvrtList(parameterMap);

		} catch (Exception e) {
			// Exceptin 일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT" , result);
		ResponseUtil.write(response, json.toJSONString());
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value="/psys/deleteTsysAdmFvrt", method = RequestMethod.POST)
	public void deleteTsysAdmFvrt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		try {
			 psysCommonMgr.deleteTsysAdmFvrt(parameterMap);
		}
		catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json 선언
		JSONObject json = new JSONObject();
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value="/psys/deleteUpMnuTsysAdmFvrt", method = RequestMethod.POST)
	public void deleteUpMnuTsysAdmFvrt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;

		try {
			 psysCommonMgr.deleteUpMnuTsysAdmFvrt(parameterMap);
		}
		catch (Exception e) {
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json 선언
		JSONObject json = new JSONObject();
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}


	/**
	 * 파일 다운로드
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@RequestMapping(value="/content/filedownload")
	public void getFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 변수 선언
		String fl_seq = (null == request.getParameter("fl_seq") || "".equals(request.getParameter("fl_seq"))) ? "" : request.getParameter("fl_seq");
//		String wbzn_seq = (null == request.getParameter("wbzn_seq") || "".equals(request.getParameter("wbzn_seq"))) ? "" : request.getParameter("wbzn_seq");
		OutputStream out = null;
		InputStream inputStream = null;
		int bufferSize = 1024;
		String FullPath = "";

		// 브라우저 체크용 userAgent
		String header = request.getHeader("User-Agent");
		if (header.indexOf("Chrome") > -1) header = "Chrome";

		// PrintWriter 선언
		PrintWriter printWriter = null;
		try {
			TbbsFlInf sysFile = null;
			String db_file_full_path = "";
			String db_file_org_name = "";
			if(!StringUtils.isNullOrEmpty(fl_seq)) {
				sysFile = psysCommonMgr.selectTbbsFlInfInfo(fl_seq);
				if(sysFile != null) {
					db_file_full_path = sysFile.getUpl_fl_nm();
					db_file_full_path = db_file_full_path.replace("/", "");
					db_file_full_path = db_file_full_path.replace("&", "");
					db_file_full_path = db_file_full_path.replace("\"", "");
					db_file_full_path = db_file_full_path.replace("\\", "");
					db_file_org_name = sysFile.getSrc_fl_nm();
				}
			}
			if(!StringUtils.isNullOrEmpty(db_file_full_path) && !StringUtils.isNullOrEmpty(db_file_org_name)) {
				FullPath = Config.get("app.file.download.path") + File.separator + db_file_full_path;
				// 파일명 공백 및 Chrome 브라우저 특수문자 처리
				String fileName = "";
				if(!"Chrome".equalsIgnoreCase(header)) {
					fileName = URLEncoder.encode(db_file_org_name, "UTF-8").replaceAll("\\+", "%20");
				}
				else {
					StringBuilder sb = new StringBuilder();
					for (int i = 0; i < db_file_org_name.length(); i++) {
						char c = db_file_org_name.charAt(i);
						if (c > '~') {
							sb.append(URLEncoder.encode("" + c, "UTF-8"));
						}
						else {
							sb.append(c);
						}
					}
					fileName = sb.toString();
				}
				inputStream = new FileInputStream(FullPath);
				response.setContentType("binary/octet-stream");
				response.addHeader("Content-disposition", "attachment; filename=" + fileName);
				out = response.getOutputStream();

				byte[] bytes = new byte[bufferSize];
				int size = 0;
				while (-1 != (size = inputStream.read(bytes))) {
					out.write(bytes, 0, size);
				}
				out.flush();
				if(sysFile != null) {
					psysCommonMgr.updateTbbsFlInfDwldCnt(fl_seq);
				}
			} else {
				throw new IllegalArgumentException("file not found");
			}
		} catch(FileNotFoundException e){
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			printWriter = response.getWriter();
			printWriter.println("<script type='text/javascript'>alert('해당 파일이 존재하지 않습니다.'); window.onload=window.close();</script>");
			printWriter.flush();
		} finally {
			try { inputStream.close(); } catch (Exception e) {log.debug(e);}
			try { out.close(); } catch (Exception e) {log.debug(e);}
		}
	}

	/**
	 * 파일 다운로드
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@RequestMapping(value="/content/filedownloads3")
	public void getS3File(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 변수 선언
		String fl_seq = (null == request.getParameter("fl_seq") || "".equals(request.getParameter("fl_seq"))) ? "" : request.getParameter("fl_seq");
		OutputStream out = null;
		InputStream inputStream = null;
		BufferedReader reader = null;
		int bufferSize = 1024;
		String FullPath = "";

		// 브라우저 체크용 userAgent
		String header = request.getHeader("User-Agent");
		if (header.indexOf("Chrome") > -1 ||  header.indexOf("Trident") > -1  ) header = "Chrome";

		// PrintWriter 선언
		PrintWriter printWriter = null;
		try {
			TbbsFlInf sysFile = null;
			String db_file_full_path = "";
			String db_file_org_name = "";
			if(!StringUtils.isNullOrEmpty(fl_seq)) {
				sysFile = psysCommonMgr.selectTbbsFlInfInfo(fl_seq);
				if(sysFile != null) {
					db_file_full_path = sysFile.getUpl_fl_nm();
					db_file_org_name = sysFile.getSrc_fl_nm();
				}
			}
			if(!StringUtils.isNullOrEmpty(db_file_full_path) && !StringUtils.isNullOrEmpty(db_file_org_name)) {
				FullPath =db_file_full_path; //Config.get("app.file.download.path") + File.separator + db_file_full_path;
				// 파일명 공백 및 Chrome 브라우저 특수문자 처리
				String fileName = "";
				String s3FileName = "";
				String lastIndexStr = "/";
				s3FileName = FullPath.substring(FullPath.lastIndexOf(lastIndexStr)+1);
				if(!"Chrome".equalsIgnoreCase(header)) {
					fileName = URLEncoder.encode(db_file_org_name, "UTF-8").replaceAll("\\+", "%20");
					s3FileName = URLEncoder.encode(s3FileName, "UTF-8").replaceAll("\\+", "%20");
				}
				else {
					StringBuilder sb = new StringBuilder();
					for (int i = 0; i < db_file_org_name.length(); i++) {
						char c = db_file_org_name.charAt(i);
						if (c > '~') {
							sb.append(URLEncoder.encode("" + c, "UTF-8"));
						}
						else {
							sb.append(c);
						}
					}
					fileName = sb.toString();
				}
				Configuration configuration = Configuration.getInstance();
//				String s3Url = configuration.get("app.amazone.s3.url");
				String bucketName = configuration.get("app.s3path.bdp.bucketName");
				String accessKey  = configuration.get("app.s3path.bdp.accessKey");
				String secretKey  = configuration.get("app.s3path.bdp.secretKey");
				String basePath = configuration.get("app.s3path.bdp.upload.path");
				// 파일 다운로드 다운로드 경로와 파일이름 동시 필요.
				AWSCredentials awsCredentials = new BasicAWSCredentials(accessKey, secretKey);
				AmazonS3 amazonS3 = AmazonS3ClientBuilder.standard()
						.withCredentials(new AWSStaticCredentialsProvider(awsCredentials))
						.withRegion("ap-northeast-2")
						.build();
				response.setContentType("binary/octet-stream");
				response.addHeader("Content-disposition", "attachment; filename=" + fileName);

				S3Object object = amazonS3.getObject(new GetObjectRequest(bucketName+basePath, s3FileName));
	            inputStream = object.getObjectContent();
	            out = response.getOutputStream();
				byte[] bytes = new byte[bufferSize];
				int size = 0;
				while (-1 != (size = inputStream.read(bytes))) {
					out.write(bytes, 0, size);
				}
				out.flush();
				if(sysFile != null) {
					psysCommonMgr.updateTbbsFlInfDwldCnt(fl_seq);
				}
			} else {
				throw new IllegalArgumentException("file not found");
			}
		} catch(FileNotFoundException e){
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			printWriter = response.getWriter();
			printWriter.println("<script type='text/javascript'>alert('해당 파일이 존재하지 않습니다.'); window.onload=window.close();</script>");
			printWriter.flush();
		} finally {
			try {
				inputStream.close();
				if(reader != null)
					 reader.close();
			  } catch (Exception e) {log.debug(e);}
			try { out.close(); } catch (Exception e) {log.debug(e);}
		}
	}



}
