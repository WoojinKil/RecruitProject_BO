package kr.co.ta9.pandora3.psys.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.psys.dao.TbLgapAthrappHDao;

/**
* <pre>
* 1. 클래스명 : Psys1045Mgr
* 2. 설명 : 권한 신청 이력
* 3. 작성일 : 2019-11-04
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Psys1045Mgr {

	@Autowired
	private TbLgapAthrappHDao tbLgapAthrappHDao;
	/**
	 * 권한 관리 > 권한 신청 이력 
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTbLgapAthrappHList(ParameterMap parameterMap) throws Exception {
		return tbLgapAthrappHDao.selectTbLgapAthrappHList(parameterMap);
	}
	
	
}

