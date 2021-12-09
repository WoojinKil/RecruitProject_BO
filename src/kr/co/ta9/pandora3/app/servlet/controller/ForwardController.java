/**
* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명 : kr.co.ta9.pandora3.app.servlet.controller
* 3. 파일명 : ForwardController
* 4. 작성일 : 2017-10-27
* </pre>
*/
package kr.co.ta9.pandora3.app.servlet.controller;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView;

import kr.co.ta9.pandora3.app.conf.AppConst;
import kr.co.ta9.pandora3.common.exception.InvalidUriException;
import kr.co.ta9.pandora3.common.util.TextUtil;

@Controller
public class ForwardController extends CommonActionController {

	private final String frontExt = "do";
	private final String adminExt = "adm";
	
	
	@Override 
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String requestUri = (String)request.getAttribute("javax.servlet.include.requestUri");
		if ( requestUri == null ) {
			requestUri = request.getRequestURI();
		}
		// context 가 설정되어있을경우 context명은 뺀다
		String contextPath = request.getContextPath();
		if (contextPath != null && requestUri.indexOf(contextPath) == 0) {
			requestUri = requestUri.substring(contextPath.length());
		}
		
		// Session Check :: BO/FRONT 분기를 위한 구분 
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpSession session = httpRequest.getSession();
		String checkAdmin = (String) session.getAttribute("checkAdmin");

		String forwardExt = "";
		String contextUrl = "";
		if(AppConst.ADMIN_GB.equals(checkAdmin)) {
			forwardExt = adminExt;
			contextUrl = AppConst.ADMIN_URL;
		} else {
			forwardExt = frontExt;
			contextUrl = AppConst.FRONT_URL;
		}
		
		Pattern pattern = Pattern.compile("(.*/)(forward\\.(.*)\\." + forwardExt + ")");
		Matcher matcher = pattern.matcher(requestUri);
		
		String dispatch_uri = "";
		if ( matcher.find() ) {
			dispatch_uri = TextUtil.replaceString(requestUri, matcher.group(2), matcher.group(3) );
		} else {
			throw new InvalidUriException("invalid uri");
		}
		
		return new ModelAndView(contextUrl + dispatch_uri);
	}
}
