package kr.co.ta9.pandora3.psys.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.psys.dao.TbBcpcMenuacsTotDao;

/**
 * <pre>
 * 1. 클래스명 : Psys1057Mgr
 * 2. 설명: 사용자 통계 > 시스템별 접속자 수
 * 3. 작성일 : 2020-04-06
 * 4.작성자   : TANINE
 * </pre>
 */

@Service
public class Psys1058Mgr {
	
	
	@Autowired
	private TbBcpcMenuacsTotDao tbBcpcMenuacsTotDao;
	
	/**
	 * 시스템 통계 메뉴별 클릭 수
	 * @param parameterMap
	 * @throws Exception
	 */
	public JSONObject selectTbBcpcMenuacsTotList(ParameterMap parameterMap) throws Exception {
		return tbBcpcMenuacsTotDao.selectTbBcpcMenuacsTotList(parameterMap);
	}


}
