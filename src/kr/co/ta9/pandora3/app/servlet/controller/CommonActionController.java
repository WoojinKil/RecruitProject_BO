/**
* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명   : kr.co.ta9.pandora3.app.servlet.controller
* 3. 파일명     : CodeRepository
* 4. 작성일     : 2016-08-22
* </pre>
*/
package kr.co.ta9.pandora3.app.servlet.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.conf.Config;
import kr.co.ta9.pandora3.common.servlet.controller.BaseActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;

/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.app.servlet.controller
* 2. 타입명   : class
* 3. 작성일   : 2016-08-22
* 4. 설명     : 그리드 파라미터 세팅
* </pre>
*/
@Controller
public class CommonActionController extends BaseActionController {
	protected final Log loged = LogFactory.getLog(getClass());
	
	protected ParameterMap getParameterMap(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ParameterMap(request);
	}
	
	/**
	 * 그리드 파라미터 세팅
	 * @param request
	 * @param response
	 * @return ParameterMap
	 * @throws Exception
	 */
	protected ParameterMap getParameterGridMap(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = new ParameterMap(request);
		int page = parameterMap.getInt("page");
		int rows = parameterMap.getInt("rows");
		parameterMap.put("page", Integer.valueOf(page == 0 ? 1 : page));
		parameterMap.put("rows", Integer.valueOf(rows == 0 ? Config.getArray("grid.rows.list")[0] : parameterMap.getValue("rows")));
		return parameterMap;
	}
	
	/**
	 * 테이블 파라미터 세팅
	 * @param request
	 * @param response
	 * @return ParameterMap
	 * @throws Exception
	 */
	protected ParameterMap getParameterTableMap(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ParameterMap parameterMap = new ParameterMap(request);
		int page = parameterMap.getInt("page");
		int rows = parameterMap.getInt("rows");
		String[] pagingParam = Config.getArray("tbid.rows.list");
		parameterMap.put("page", Integer.valueOf(page == 0 ? 1 : page));
		parameterMap.put("rows", Integer.valueOf(rows == 0 ? pagingParam[0] : parameterMap.getValue("rows")));
		parameterMap.put("pagingParam", pagingParam);
		return parameterMap;
	}
	
	protected boolean checkLoginAjax(HttpServletRequest request, HttpServletResponse response) throws Exception {
		boolean isLogin = true;
		ParameterMap parameterMap = getParameterMap(request, response);
		UserInfo userInfo = parameterMap.getUserInfo();
		if (userInfo == null || !userInfo.isLogin()) {
			isLogin = false;
		}
		return isLogin;
	}
	
}
