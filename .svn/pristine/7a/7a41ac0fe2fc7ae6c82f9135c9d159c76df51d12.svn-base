package kr.co.ta9.pandora3.psys.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.psys.dao.TbLgapRolHDao;

/**
* <pre>
* 1. 클래스명 : Psys1044Mgr
* 2. 설명 : 권한 변경 이력 조회 관련
* 3. 작성일 : 2019-11-04
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Psys1044Mgr {
	
	@Autowired
	private TbLgapRolHDao tbLgapRolHDao;
	
	/**
	 * 이력 조회 > 권한 변경 이력 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTbLgapRolH(ParameterMap parameterMap) throws Exception {
		
		return tbLgapRolHDao.selectTbLgapRolH(parameterMap);
	}


	
}

