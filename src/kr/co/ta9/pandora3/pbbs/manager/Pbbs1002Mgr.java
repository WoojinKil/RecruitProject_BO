package kr.co.ta9.pandora3.pbbs.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pdsp.dao.TdspTmplInfDao;

/**
* <pre>
* 1. 클래스명 : Pbbs1001Mgr
* 2. 설명 : 통합게시글상세
* 3. 작성일 : 2018-04-06
* 4.작성자   : TANINE
* </pre>
*/
@Service
public class Pbbs1002Mgr {
	
	@Autowired
	private TdspTmplInfDao tdspTmplInfDao;
	
	/**
	 * 모듈이 매핑가능한 템플릿 목록 조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTdspTmplInfMpnModlList(ParameterMap parameterMap) throws Exception {
		return tdspTmplInfDao.selectTdspTmplInfMpnModlList(parameterMap);
	}

}
