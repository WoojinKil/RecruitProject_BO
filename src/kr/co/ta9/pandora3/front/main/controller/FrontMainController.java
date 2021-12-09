package kr.co.ta9.pandora3.front.main.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.app.util.CommonUtil;
import kr.co.ta9.pandora3.common.conf.Config;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.front.main.manager.FrontMainMgr;
import kr.co.ta9.pandora3.pcommon.dto.TdspMnPop;
import kr.co.ta9.pandora3.pcommon.dto.usrdef.Main;
import kr.co.ta9.pandora3.system.manager.SystemMgr;

/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.kr.front.main.controller
* 2. 타입명 : class
* 3. 작성일 : 2019-03-25
* 4. 설명 : 메인 컨트롤러
* </pre>
*/
@Controller
public class FrontMainController extends CommonActionController {
	
	@Autowired
	private SystemMgr systemMgr;
	
	@Autowired
	private FrontMainMgr frontMainMgr;
	
	private String _uiPath = Config.get("app.template.ui.path");
	//private String _mUiPath =Config.get("app.template.m.ui.path");
	
	/**
	 * 메인화면
	 * @param  request
	 * @param  response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/")
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ModelAndView 선언
		ModelAndView mav = new ModelAndView();
		String result = Const.BOOLEAN_SUCCESS;
		List<TdspMnPop> mnPopList = new ArrayList<TdspMnPop>();
		List<Main> mnIntroList = new ArrayList<Main>();
		List<Main> mnBnnrList = new ArrayList<Main>();
		List<Main> mnNotiList = new ArrayList<Main>();
		Main notiEtcInf = null;
		
		try {
			// 1. 진입수 갱신
			ParameterMap parameterMap = getParameterMap(request, response);
			parameterMap.put("ip_addr", CommonUtil.getRemoteIpAddr(request));
			parameterMap.put("userAgent", request.getHeader("User-Agent"));
			//systemMgr.saveCounterLog(parameterMap); 
			
			// 2. 메인팝업 목록 조회
			mnPopList = frontMainMgr.selectMnPopList();
			
			// 3. 메인전시목록 조회 : 수강소개
			List<HashMap<String , Object>> modl_tp_cd_list = new ArrayList<HashMap<String , Object>>();
			HashMap<String , Object> map = new HashMap<String, Object>();
			map.put("modl_tp_cd", "INTRO");
			modl_tp_cd_list.add(map);
			parameterMap.put("modl_tp_cd_list", modl_tp_cd_list);
			mnIntroList = frontMainMgr.selectMnDispDocList(parameterMap);
			
			// 4. 메인전시목록 조회 : 메인이벤트배너
			modl_tp_cd_list = new ArrayList<HashMap<String , Object>>();
			map = new HashMap<String, Object>();
			map.put("modl_tp_cd", "MBNNR");
			modl_tp_cd_list.add(map);
			parameterMap.put("modl_tp_cd_list", modl_tp_cd_list);
			mnBnnrList = frontMainMgr.selectMnDispDocList(parameterMap);
			
			// 5. 공지사항 기타 정보 조회 : 공지사항 목록 URL, 공지사항 최대 노출개수
			//notiEtcInf = frontMainMgr.selectNotiEtcInf();
			
			// 6. 메인전시목록 조회 : 공지사항(공지, 이벤트)
			modl_tp_cd_list = new ArrayList<HashMap<String , Object>>();
			map = new HashMap<String, Object>();
			map.put("modl_tp_cd", "NOTI");
			modl_tp_cd_list.add(map);
			map = new HashMap<String, Object>();
			map.put("modl_tp_cd", "EVT");
			modl_tp_cd_list.add(map);
			parameterMap.put("modl_tp_cd_list", modl_tp_cd_list);
//			parameterMap.put("noti_max_cnt", notiEtcInf.getNoti_max_cnt());
			parameterMap.put("noti_max_cnt", 2);
			mnNotiList = frontMainMgr.selectMnDispDocList(parameterMap);
		}catch(Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}
		
		// 리턴 값 / View 셋팅
		mav.addObject("result", result);
		mav.addObject("mnPopList", mnPopList);
		mav.addObject("mnPopListSize", mnPopList.size());
		mav.addObject("mnIntroList", mnIntroList);
		mav.addObject("mnIntroListSize", mnIntroList.size());
		mav.addObject("mnBnnrList", mnBnnrList);
		mav.addObject("mnBnnrListSize", mnBnnrList.size());
		mav.addObject("mnNotiList", mnNotiList);
		mav.addObject("mnNotiListSize", mnNotiList.size());
		mav.addObject("notiEtcInf", notiEtcInf);
		mav.setViewName(_uiPath + "/main");
		
		
		return mav;
	}
	/**
	 * 메인화면
	 * @param  request
	 * @param  response
	 * @return ModelAndView
	 * @throws Exception
	 */
	/*
	 * @RequestMapping(value="/m") public ModelAndView mIndex(HttpServletRequest
	 * request, HttpServletResponse response) throws Exception { // ModelAndView 선언
	 * ModelAndView mav = new ModelAndView(); try {
	 * 
	 * }catch(Exception e) { e.printStackTrace(); }
	 * 
	 * // 리턴 값 / View 셋팅 mav.setViewName(_mUiPath + "/index"); return mav; }
	 */
	
	/**
	 * 메인화면 Redirect
	 * @return String
	 */
	@RequestMapping(value="/main")
	public String main() {
		return "redirect:/";
	}
	
}