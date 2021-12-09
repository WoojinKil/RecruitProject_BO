/**
* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명   : kr.co.ta9.pandora3.content.controller
* 3. 파일명     : SysContentController
* 4. 작성일     : 2017-11-22
* 5. 설명       : 컨텐츠 컨트롤러
* </pre>
*/
package kr.co.ta9.pandora3.front.content.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.common.conf.Config;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.front.content.manager.SysContentMgr;
import kr.co.ta9.pandora3.pcommon.dto.TbbsDocInf;
import kr.co.ta9.pandora3.pcommon.dto.TbbsModlInf;
import kr.co.ta9.pandora3.pcommon.dto.TcmnCdDtl;
/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.content.controller
* 2. 타입명   : class
* 3. 작성일   : 2017-11-22
* 4. 설명     : 컨텐츠 컨트롤러
* </pre>
*/ 
@Controller
public class SysContentController extends CommonActionController {
	
	@Value("${smtp.host}")
	private String host;
	
	@Value("${smtp.port}")
	private String port;
	
	@Value("${smtp.username}")
	private String username;
	
	@Value("${smtp.password}")
	private String password;
	
	@Value("${smtp.sender}")
	private String sender;
	
	@Autowired
	private SysContentMgr sysContentMgr;
	
	private String _uiPath = Config.get("app.template.ui.path");
	
	/**
	 * 일반 상세 페이지 이동
	 * @param  request
	 * @param  response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/module/board/norTypeDtlInfo.do")
	public ModelAndView norTypeDtlInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 변수 선언
		ModelAndView mav = new ModelAndView();
		ParameterMap parameterMap = getParameterMap(request, response);
		String bbs_tp_cd = StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("bbs_tp_cd"))) ? String.valueOf(parameterMap.getValue("bbs_tp_cd")) : "";
		String viewName = _uiPath;
		// 리턴 View
		// 1. 학원소개
		if("AINTR".equals(bbs_tp_cd)) viewName += "/about/aintrDtl";
		// 2. 교육시설
		else if("AFCL".equals(bbs_tp_cd)) viewName += "/about/afclDtl";
		// 3. 공간대여안내
		else if("ALNDG".equals(bbs_tp_cd)) viewName += "/about/alndgDtl";
		// 4. 오시는길
		else if("ACOA".equals(bbs_tp_cd)) viewName += "/contact/acoaDtl";
		// 5. 강사채용
		else if("RCRT".equals(bbs_tp_cd)) viewName += "/about/rcrtDtl";
		// 6. 개인정보취급방침
		else if("PLCY".equals(bbs_tp_cd)) viewName += "/about/plcyDtl";
		// 7. 환불규정
		else if("RFNM".equals(bbs_tp_cd)) viewName += "/about/rfnmDtl";
		
		// 리턴 값 / View 셋팅
		mav.addObject("bbs_tp_cd", bbs_tp_cd);
		// 학원소개, 교육시설, 공간대여, 오시는길 : 네비게이션 영역 존재 > TMPL_SEQ 필요
		if("AINTR".equals(bbs_tp_cd) || "AFCL".equals(bbs_tp_cd) || "ALNDG".equals(bbs_tp_cd) || "ACOA".equals(bbs_tp_cd)) mav.addObject("curr_tmpl_seq", StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("tmpl_seq"))) ? String.valueOf(parameterMap.getValue("tmpl_seq")) : "");
		mav.setViewName(viewName);	
		return mav;
	}
	
	/**
	 * 공통 : 게시판 목록 조회
	 * @param  request
	 * @param  response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/module/board/boardTypeList.do")
	public ModelAndView boardTypeList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 변수 선언
		ModelAndView mav = new ModelAndView();
		ParameterMap parameterMap = getParameterTableMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		TbbsModlInf sysModule = new TbbsModlInf();
		List<TbbsDocInf> sysDocList = new ArrayList<TbbsDocInf>(); 
		Map<String, Integer> pagingInfo = null;
		String viewName = "/pandora3Front/academy";
		int notiCnt = 0;
		
		// 파라미터 셋팅
		String bbs_tp_cd = StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("bbs_tp_cd"))) ? String.valueOf(parameterMap.getValue("bbs_tp_cd")) : "";
		String tmpl_seq = StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("tmpl_seq"))) ? String.valueOf(parameterMap.getValue("tmpl_seq")) : "";
		String modl_seqs = StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("modl_seqs"))) ? String.valueOf(parameterMap.getValue("modl_seqs")) : "";
		String modl_seq = StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("modl_seq"))) ? String.valueOf(parameterMap.getValue("modl_seq")) : "";
		String sch_type = StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("sch_type"))) ? String.valueOf(parameterMap.getValue("sch_type")) : "";
		String sch_type_txt = StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("sch_type_txt"))) ? String.valueOf(parameterMap.getValue("sch_type_txt")) : "";
		try {
			// 모듈번호 리스트 파라미터 생성
			String[] modl_seq_arr = ("".equals(modl_seqs)) ? new String[0] : parameterMap.getValue("modl_seqs").split("\\.");
			List<HashMap<String , Object>> modl_seq_list = new ArrayList<HashMap<String , Object>>();
			for(int i = 0; i < modl_seq_arr.length; i++) {
				HashMap<String , Object> map = new HashMap<String, Object>();
				map.put("modl_seq", Integer.parseInt(modl_seq_arr[i]));
				modl_seq_list.add(map);
			}
			parameterMap.put("modl_seq_list", modl_seq_list);
			
			// 공지사항 게시판
			if("NOTI".equals(bbs_tp_cd)) {
				// 공지사항 탭 목록 조회
				parameterMap.put("sys_cd", 0);
				List<TbbsModlInf> notiTabList = sysContentMgr.selectNotiTabList(parameterMap);
				mav.addObject("notiTabList", notiTabList);
				
				// 탭 목록 존재 시
				if(notiTabList.size() > 0) {
					// 공지사항 게시판 목록 조회
					sysDocList = sysContentMgr.selectTbbsDocNotiList(parameterMap);
					for(TbbsDocInf sysDoc : sysDocList) {
						if("Y".equals(sysDoc.getNotc_yn())) {
							notiCnt++;
						}
					}
					
					// 페이징 정보
					pagingInfo = sysContentMgr.getPagingInfo(sysDocList, parameterMap);
				}
				// 리턴 View
				viewName += "/community/notiList";
			}
			// 자주묻는 질문 게시판
			else if("FAQ".equals(bbs_tp_cd)) {
				// 일반 게시판 목록 조회
				sysDocList = sysContentMgr.selectTbbsDocGnrList(parameterMap);
				
				// 페이징 정보
				pagingInfo = sysContentMgr.getPagingInfo(sysDocList, parameterMap);
				
				// 리턴 View
				viewName += "/community/faqList";
			}
		}catch(Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}
		
		// 리턴 값 / View 셋팅
		mav.addObject("result", result);
		mav.addObject("bbs_tp_cd", bbs_tp_cd);
		mav.addObject("curr_tmpl_seq", tmpl_seq);
		mav.addObject("sysModule", sysModule);
		mav.addObject("sysDocList", sysDocList);
		mav.addObject("notiCnt", notiCnt);
		mav.addObject("pagingInfo", pagingInfo);
		mav.addObject("pagingParam", parameterMap.getArray("pagingParam"));
		mav.addObject("modl_seqs", modl_seqs);
		mav.addObject("modl_seq", modl_seq);
		mav.addObject("sch_type", sch_type);
		mav.addObject("sch_type_txt", sch_type_txt);
		mav.setViewName(viewName);
		
		return mav;
	}
	
	/**
	 * 공통 : 게시판 상세 정보 조회
	 * @param  request
	 * @param  response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/module/board/boardTypeDtlInfo.do")
	public ModelAndView boardTypeDtlInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 변수 선언
		ModelAndView mav = new ModelAndView();
		ParameterMap parameterMap = getParameterTableMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		TbbsDocInf tbbsDocInf = new TbbsDocInf();
		List<TbbsDocInf> tbbsDocBnAList = new ArrayList<TbbsDocInf>();
		String viewName = "/pandora3Front/academy";
		
		// 파라미터 셋팅
		String bbs_tp_cd = StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("bbs_tp_cd"))) ? String.valueOf(parameterMap.getValue("bbs_tp_cd")) : "";
		String tmpl_seq = StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("tmpl_seq"))) ? String.valueOf(parameterMap.getValue("tmpl_seq")) : "";
		String modl_seqs = StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("modl_seqs"))) ? String.valueOf(parameterMap.getValue("modl_seqs")) : "";
		String modl_seq = StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("modl_seq"))) ? String.valueOf(parameterMap.getValue("modl_seq")) : "";
		String lst_modl_seq = StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("lst_modl_seq"))) ? String.valueOf(parameterMap.getValue("lst_modl_seq")) : "";
		String page = StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("page"))) ? String.valueOf(parameterMap.getValue("page")) : "";
		String sch_type = StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("sch_type"))) ? String.valueOf(parameterMap.getValue("sch_type")) : "";
		String sch_type_txt = StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("sch_type_txt"))) ? String.valueOf(parameterMap.getValue("sch_type_txt")) : "";
		try {
			// 게시판 상세 정보 조회
			tbbsDocInf = sysContentMgr.selectTbbsDocInf(parameterMap);
			if(tbbsDocInf != null) {
				// 게시판 상세 조회수 갱신
				sysContentMgr.updateTbbsDocInfInqCnt(parameterMap);
				
				// 게시판 상세 이전/다음글 정보 조회 : 공지여부가 'N'인 경우만 조회
				if(Const.BOOLEAN_FALSE.equals(tbbsDocInf.getNotc_yn()) && "NOTI".equals(bbs_tp_cd)) {
					// 모듈번호 리스트 파라미터 생성
					String[] modl_seq_arr = ("".equals(modl_seqs)) ? new String[0] : parameterMap.getValue("modl_seqs").split("\\.");
					List<HashMap<String , Object>> modl_seq_list = new ArrayList<HashMap<String , Object>>();
					for(int i = 0; i < modl_seq_arr.length; i++) {
						HashMap<String , Object> map = new HashMap<String, Object>();
						map.put("modl_seq", Integer.parseInt(modl_seq_arr[i]));
						modl_seq_list.add(map);
					}
					parameterMap.put("modl_seq_list", modl_seq_list);
					parameterMap.put("modl_seq", tbbsDocInf.getModl_seq());
					parameterMap.put("crt_dttm", tbbsDocInf.getF_crt_dttm_2());
					tbbsDocBnAList = sysContentMgr.selectTbbsDocBnAList(parameterMap);
				}
				
				// 공지사항 게시판 상세
				if("NOTI".equals(bbs_tp_cd)) {
					// 리턴 View
					viewName += "/community/notiDtl";
				}
				// 수강소개 상세
				else if("INTRO".equals(bbs_tp_cd)) {
					// 리턴 View
					viewName += "/consulting/introDtl";
				}
			}else {
				// 공지사항 게시판 상세 : 상세 정보가 없는 경우
				if("NOTI".equals(bbs_tp_cd)) {
					// 리턴 View
					viewName += "/community/notiNoneDtl";
				}
				// 수강소개 상세 : 상세 정보가 없는 경우
				else if("INTRO".equals(bbs_tp_cd)) {
					// 리턴 View
					viewName += "/consulting/introNoneDtl";
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}
		
		// 결과값 반환
		mav.addObject("result", result);
		mav.addObject("tbbsDocInf", tbbsDocInf);
		mav.addObject("tbbsDocBnAList", tbbsDocBnAList);
		mav.addObject("bbs_tp_cd", bbs_tp_cd);
		mav.addObject("curr_tmpl_seq", tmpl_seq);
		mav.addObject("modl_seqs", modl_seqs);
		mav.addObject("modl_seq", modl_seq);
		mav.addObject("lst_modl_seq", lst_modl_seq);
		mav.addObject("page", page);
		mav.addObject("sch_type", sch_type);
		mav.addObject("sch_type_txt", sch_type_txt);
		mav.setViewName(viewName);
		
		return mav;
	}
	
	/**
	 * 수강상담 신청 입력폼 이동
	 * @param  request
	 * @param  response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/module/board/cnsForm.do")
	public ModelAndView cnsForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 변수 선언
		ModelAndView mav = new ModelAndView();
		ParameterMap parameterMap = getParameterMap(request, response);
		
		// 리턴 값 / View 셋팅
		mav.addObject("bbs_tp_cd", StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("bbs_tp_cd"))) ? String.valueOf(parameterMap.getValue("bbs_tp_cd")) : "");
		mav.addObject("curr_tmpl_seq", StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("tmpl_seq"))) ? String.valueOf(parameterMap.getValue("tmpl_seq")) : "");
		mav.setViewName(_uiPath + "/consulting/cnsForm");	
		return mav;
	}
	
	/**
	 * 수강상담 신청
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/module/board/registAtlcCnsInf", method = RequestMethod.POST)
	public void registAtlcCnsInf(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 변수 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		
		try {
			// 수강상담 신청
			int insCnt = sysContentMgr.insertTbbsAtlcCnsInf(parameterMap);
			if(!(insCnt > 0)) result = Const.BOOLEAN_FAIL;
		}catch(Exception e) {
			e.printStackTrace();
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}
		
		// JSON 결과 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 수강상담 신청 이메일 전송 : 신청자, 관리자 메일 전송
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/module/board/sendEmailAtlcCnsInf", method = RequestMethod.POST)
	public void sendEmailAtlcCnsInf(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 변수 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		
		try {
			// 파라미터
			String atlc_usr_nm = StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("atlc_usr_nm"))) ? String.valueOf(parameterMap.getValue("atlc_usr_nm")) : "";
			String atlcUsrEmlAdr = StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("atlc_usr_eml_adr"))) ? String.valueOf(parameterMap.getValue("atlc_usr_eml_adr")) : "";
			
			// 이메일 전송 프로퍼티 셋팅
			Properties props = new Properties();
			props.put("mail.smtp.host", host);
			props.put("mail.smtp.port", port);
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.ssl.enable", "true");
			
			// 이메일 전송 폼 셋팅
			Session ses = Session.getDefaultInstance(props);
			MimeMessage msg = new MimeMessage(ses);
			
			// 관리자 이메일 주소 조회
			parameterMap.put("mst_cd_arr", "ADM_RCV_EML");
			List<TcmnCdDtl> admEmailList = sysContentMgr.selectMultiTcmnCdDtlList(parameterMap);
			int toAddrIdx = 0;
			// 정상
			if(!"".equals(atlcUsrEmlAdr)) {
				// 수강상담 신청자 및 관리자 이메일 전송
				msg.setSubject("[BUSINESS IT ACADEMY] " + atlc_usr_nm + "님의 수강상담 신청 메일 입니다.", "UTF-8"); // 제목	
				msg.setFrom(new InternetAddress(sender)); // 보낸사람
				InternetAddress[] toAddr = new InternetAddress[(admEmailList.size() + 1)];
				toAddr[toAddrIdx++] = new InternetAddress(atlcUsrEmlAdr);
				for(TcmnCdDtl admEmail : admEmailList) {
					toAddr[toAddrIdx++] = new InternetAddress(admEmail.getRef_1().toString()); 
				}
				msg.addRecipients(Message.RecipientType.TO, toAddr); // 받는사람
				msg.setContent(sysContentMgr.writeSendEmailHtml(parameterMap), "text/html;charset=UTF-8"); // 컨텐츠
				
				// 이메일 전송
				Transport trprt = ses.getTransport("smtps");
				trprt.connect(host, username, password);
				trprt.sendMessage(msg, msg.getAllRecipients());
				trprt.close();
			}
			// 에러
			else {
				result = Const.BOOLEAN_FAIL;
			}
		}catch(Exception e) {
			e.printStackTrace();
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}
		
		// JSON 결과 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 수강상담 신청 완료폼 이동
	 * @param  request
	 * @param  response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/module/board/cmplCnsForm.do")
	public ModelAndView cmplCnsForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 변수 선언
		ModelAndView mav = new ModelAndView();
		ParameterMap parameterMap = getParameterMap(request, response);
		
		// 리턴 값 / View 셋팅
		mav.addObject("bbs_tp_cd", StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("bbs_tp_cd"))) ? String.valueOf(parameterMap.getValue("bbs_tp_cd")) : "");
		mav.addObject("curr_tmpl_seq", StringUtils.isNotEmpty(String.valueOf(parameterMap.getValue("tmpl_seq"))) ? String.valueOf(parameterMap.getValue("tmpl_seq")) : "");
		mav.setViewName(_uiPath + "/consulting/cmplCnsForm");	
		return mav;
	}
	
}
