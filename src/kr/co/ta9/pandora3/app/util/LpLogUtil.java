/**
* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명 : kr.co.ta9.pandora3.app.repository
* 3. 파일명 : CodeRepository
* 4. 작성일 : 2016-08-22
* 5. 작성자 : tmlee
* </pre>
*/
package kr.co.ta9.pandora3.app.util;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.lplog.manager.LpLogMgr;

/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.app.repository
* 2. 타입명 : class
* 3. 작성일 : 2016-08-22
* 4. 작성자 : tmlee
* 5. 설명 : 코드 리스트 출력
* </pre>
*/

public class LpLogUtil implements  InitializingBean {

	@Override
    public void afterPropertiesSet() throws Exception {
		// Do nothing because of X and Y.
    }

   /*
	@Autowired
	public static final LpLogMgr lpLogMgr ;

	public static void setLpLogMgr(LpLogMgr lpLogMgr) {
		lpLogMgr = lpLogMgr;
	}

	public static  void  insertTbLgapVmsprinfschH(ParameterMap parameterMap) throws Exception{
		lpLogMgr.insertTbLgapVmsprinfschH(parameterMap);

	}
	*/
}
