/**
* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명 : kr.co.ta9.pandora3.kr.front.main.controller
* 3. 파일명 : PasswordChangeController
* 4. 작성일 : 2017-12-05
* </pre>
*/
package kr.co.ta9.pandora3.system.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.pmbr.dao.TmbrAdmLgnInfDao;

/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.front.mypage.controller
* 2. 타입명 : class
* 3. 작성일 : 2017-11-17
* 4. 설명 : 비밀번호변경 컨트롤러
* </pre>
*/
@Controller
public class SysPasswordChangeController extends CommonActionController {
	@Autowired
	private TmbrAdmLgnInfDao sysAdminDao;
	
//	private final Log logs = LogFactory.getLog(SysPasswordChangeController.class);
	
	/**
	* 회원 인증
	* 작성일 : 2017-12-05
	* @param request
	* @param response
	* @throws Exception
	*/
	@RequestMapping(value="/login/AdminCertProcess")
	public ModelAndView adminCertProcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ModelAndView 선언
		ModelAndView mav = new ModelAndView();
  
		// parameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
//		String result = Const.BOOLEAN_SUCCESS;
		
		try {
			mav.addObject("CERTKEY", parameterMap.getValue("certKey"));
			mav.setViewName("/pandora3/login/AdminCertProcess");
		}
		catch (Exception e) {
			// Exception 일 경우
//			result = Const.BOOLEAN_FAIL;
			log.error(e.toString());
		}
		// 결과값 반환
		return mav;
	}
	
}
