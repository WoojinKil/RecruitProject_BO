package kr.co.ta9.pandora3.pbbs.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pbbs.dao.Pbbs3001Dao;

/**
* <pre>
* 1. 클래스명 : Bpcm3001Mgr
* 2. 설명 : 사은행사
* 3. 작성일 : 2019-10-10
* 4.작성자   : KHE
* </pre>
*/
@Service
public class Pbbs3001Mgr {
	
	@Autowired
	private Pbbs3001Dao pbbs3001Dao;

	/**
	 * 사은행사 목록
	 * @param  parameterMap
	 * @return String
	 * @throws Exception
	 */
	public JSONObject selecThkuEvntList(ParameterMap parameterMap) throws Exception{

		return pbbs3001Dao.selecThkuEvntList(parameterMap);
	}
	
	/**
	 * 사은행사 상세
	 * @param  parameterMap
	 * @return String
	 * @throws Exception
	 */
	public JSONObject selecThkuEvntDtl(ParameterMap parameterMap) throws Exception{

		return pbbs3001Dao.selectThkuEvtDtl(parameterMap);
	}
	
	/**
	 * 사은행사 유형 selectbox 생성
	 * @param  parameterMap
	 * @return String
	 * @throws Exception
	 */
	public JSONObject getComnCdList(ParameterMap parameterMap) throws Exception{

		return pbbs3001Dao.getComnCdList(parameterMap);
	}
}
