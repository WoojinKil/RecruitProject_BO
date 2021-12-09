package kr.co.ta9.pandora3.psys.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pmbr.dao.TmbrCluHstDao;

/**
 * <pre>
 * 1. 클래스명 : Psys1023Mgr
 * 2. 설명 : 약관이력 서비스
 * 3. 작성일 : 2018-04-26
 * 4. 작성자  : TANINE
 * </pre>
 */

@Service
public class Psys1023Mgr {
	@Autowired
	private TmbrCluHstDao tmbrCluHstDao;
	
	/**
	 * 약관이력 그리드리스트
	 * @param parameterMap
	 * @throws Exception
	 */
	public JSONObject getTmbrCluHstList(ParameterMap parameterMap) throws Exception{
		return tmbrCluHstDao.getTmbrCluHstList(parameterMap);
	}
}
