package kr.co.ta9.pandora3.psys.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcmn.dao.TcmnCdMstDao;

/**
* <pre>
* 1. 클래스명 : Psys1000Mgr
* 2. 설명 : 샘플코드 서비스
* 3. 작성일 : 2018-03-27
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Psys1000Mgr {
	
	@Autowired
	private TcmnCdMstDao tcmnCdMstDao;
	
	/**
	 * 샘플코드 리스트 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectSampleGridList(ParameterMap parameterMap, JSONObject json) throws Exception {
		return tcmnCdMstDao.selectSampleGridList(parameterMap, json);
	}

}
