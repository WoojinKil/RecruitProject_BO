package kr.co.ta9.pandora3.psys.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.psys.dao.TbLgapVmsprinfschHDao;

/**
 * <pre>
 * 1. 클래스명 : Psys1022Mgr
 * 2. 설명: vip 메뉴 접속 이력
 * 3. 작성일 : 2018-04-24
 * 4.작성자   : TANINE
 * </pre>
 */

@Service
public class Psys1046Mgr {
	
	@Autowired
	private TbLgapVmsprinfschHDao tbLgapVmsprinfschHDao;
	
	/**
	 * 이력관리 > vip 메뉴 조회이력
	 * @param parameterMap
	 * @throws Exception
	 */
	public JSONObject selectTbLgapVmsprinfschHList(ParameterMap parameterMap) throws Exception {
		return tbLgapVmsprinfschHDao.selectTbLgapVmsprinfschHList(parameterMap);
	}
}
