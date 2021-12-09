package kr.co.ta9.pandora3.landing.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.landing.dao.Bpcm3001Dao;

/**
* <pre>
* 1. 클래스명 : Bpcm3001Mgr
* 2. 설명 : 사은행사
* 3. 작성일 : 2019-10-10
* 4.작성자   : KHE
* </pre>
*/
@Service
public class Bpcm3001Mgr {
	
	@Autowired
	private Bpcm3001Dao bpcm3001Dao;

	/**
	 * 사은행사 목록
	 * @param  parameterMap
	 * @return String
	 * @throws Exception
	 */
	public JSONObject selecThkuEvntList(ParameterMap parameterMap) throws Exception{

		return bpcm3001Dao.selecThkuEvntList(parameterMap);
	}
	
	/**
	 * 사은행사 상세
	 * @param  parameterMap
	 * @return String
	 * @throws Exception
	 */
	public JSONObject selecThkuEvntDtl(ParameterMap parameterMap) throws Exception{

		return bpcm3001Dao.selectThkuEvtDtl(parameterMap);
	}
}
