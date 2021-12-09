package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.BeanUtil;
import kr.co.ta9.pandora3.pcommon.dto.TbBcpcLoginTot;
import kr.co.ta9.pandora3.psys.dao.TbBcpcLoginTotDao;
import kr.co.ta9.pandora3.psys.dao.TsysAdmGrpRolDao;

/**
 * <pre>
 * 1. 클래스명 : Psys1057Mgr
 * 2. 설명: 사용자 통계 > 시스템별 접속자 수
 * 3. 작성일 : 2020-04-06
 * 4.작성자   : TANINE
 * </pre>
 */

@Service
public class Psys1062Mgr {
	
	@Autowired
	private TbBcpcLoginTotDao tbBcpcLoginTotDao;
	

	/**
	 * 사용자 통계 > 각 시스템 점별 접속자 수
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTbBcpcLoginTotStrList(ParameterMap parameterMap) throws Exception {
		return tbBcpcLoginTotDao.selectTbBcpcLoginTotStrList(parameterMap);
	}

	/**
	 * 점목록 조회
	 * @param parameterMap
	 * @return
	 */
	public JSONObject selectStrList(ParameterMap parameterMap) throws Exception {
		return tbBcpcLoginTotDao.selectStrList(parameterMap);
	}
}
