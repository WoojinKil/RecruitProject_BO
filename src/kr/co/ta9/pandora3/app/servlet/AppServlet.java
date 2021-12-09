/**
* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명 : kr.co.ta9.pandora3.app.servlet
* 3. 파일명 : AppServlet
* 4. 작성일 : 2016-08-22
* 5. 작성자 : tmlee
* </pre>
*/
package kr.co.ta9.pandora3.app.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import kr.co.ta9.pandora3.common.conf.Configuration;
import kr.co.ta9.pandora3.common.conf.Const;
/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.app.servlet
* 2. 타입명 : class
* 3. 작성일 : 2016-08-22
* 4. 작성자 : tmlee
* 5. 설명 : 서블릿 설정
* </pre>
*/
public class AppServlet extends HttpServlet {

	private static final long serialVersionUID = -5979561599724087502L;

	private final Log log = LogFactory.getLog(Const.SYSTEM_INFO_LOGGER);

	@Override
	public void init() throws ServletException {

		Configuration.getInstance();


//		log.info(Config.get("app.id"));
		log.info(System.getProperty("app.id") + " started...");
	}
}