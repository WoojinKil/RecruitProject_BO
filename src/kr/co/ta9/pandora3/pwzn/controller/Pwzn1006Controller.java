package kr.co.ta9.pandora3.pwzn.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspDtl;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspMnInf;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspMst;
import kr.co.ta9.pandora3.pwzn.manager.Pwzn1006Mgr;
/**
* <pre>
* 1. 클래스명 : Pwzn1006Controller
* 2. 설명 : 웹진프론트 컨트롤러
* 3. 작성일 : 2018-04-23
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class Pwzn1006Controller extends CommonActionController{
	
	@Autowired
	private Pwzn1006Mgr pwzn1006Mgr;
	
	/**
	* 전기산업과정책 > pandora3인사이트
	* 작성일 : 2017-12-12
	* @param request
	* @param response
	* @throws Exception
	*/
	@RequestMapping(value="/pwzn/pwzn1006Vw.do")
	public ModelAndView pwzn1006Vw(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ModelAndView 선언
		ModelAndView mav = new ModelAndView();
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		TbbsWbznDspMst webzineDispMst = new TbbsWbznDspMst();
		
		List<TbbsWbznDspMst> selectInfo = new ArrayList<TbbsWbznDspMst>();
		List<TbbsWbznDspMnInf> mainList = new ArrayList<TbbsWbznDspMnInf>();
		List<TbbsWbznDspDtl> dtlList = new ArrayList<TbbsWbznDspDtl>();
		
		String wbzn_seq = (null == request.getParameter("wbzn_seq") || "".equals(request.getParameter("wbzn_seq"))) ? "" : request.getParameter("wbzn_seq");
		try {
			if("".equals(wbzn_seq) || wbzn_seq == null){
				// 최근 웹진아이디 추출
				wbzn_seq = pwzn1006Mgr.selectTbbsWbznDspMstWbznSeq(parameterMap);
				// 최근 웹진아이디를 담는다
				parameterMap.put("wbzn_seq", wbzn_seq);
			}

			// 웹진 select 정보 조회
			selectInfo = pwzn1006Mgr.selectTbbsWbznDspMstComboInf(parameterMap);
			// 웹진 마스터정보 설정
			for(TbbsWbznDspMst webMst : selectInfo) {
				if(wbzn_seq.equals(webMst.getWbzn_seq())) {
					webzineDispMst = webMst;
					break;
				}
			}
			// 웹진 메인컨텐츠정보 조회
			mainList = pwzn1006Mgr.selectTbbsWbznDspMnInfList(parameterMap);
			// 웹진 상세컨텐츠정보 조회
			dtlList = pwzn1006Mgr.selectTbbsWbznDspDtlList(parameterMap);
			// 웹진 랜딩페이지 설정
			for(TbbsWbznDspMnInf webzineDispMain : mainList) {
				for(TbbsWbznDspDtl webzineDispDtl : dtlList) {
					if(webzineDispMain.getCtg_seq() == webzineDispDtl.getCtg_seq()) {
						if("Y".equals(webzineDispDtl.getLdg_yn())) {
							webzineDispMain.setLdg_pg_no(String.valueOf(webzineDispDtl.getId()));
							break;
						}
					}
				}
			}
			// 화면 설정
			mav.setViewName("/pandora3Front/pwzn/pwzn1006");
		}
		catch (Exception e) {
			e.printStackTrace();
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
		}
		mav.addObject("selectInfo", selectInfo);
		mav.addObject("RESULT", result);
		mav.addObject("webzineDispMst", webzineDispMst);
		mav.addObject("mainList", mainList);
		mav.addObject("dtlList", dtlList);
		
		// 결과값 반환
		return mav;
	}
	
}
