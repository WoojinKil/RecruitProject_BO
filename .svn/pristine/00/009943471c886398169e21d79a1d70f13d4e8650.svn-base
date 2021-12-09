package kr.co.ta9.pandora3.psys.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.psys.dao.TsysJobInfDao;

/**
* <pre>
* 1. 클래스명 : Psys1040Mgr
* 2. 설명 : 직무 관리 서비스
* 3. 작성일 : 2019-11-04
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Psys1041Mgr {
	
	@Autowired
	private TsysJobInfDao tBchrJbfnIDao;  
	

	/**
	 * 코드 관리 > 직무 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTsysJobInfGridList(ParameterMap parameterMap) throws Exception {
		return tBchrJbfnIDao.selectTsysJobInfGridList(parameterMap);
	}


	
}

