package kr.co.ta9.pandora3.psys.dao;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.TsysPgmInf;

/**
 * TsysPgmBtnInfDao - DAO(Data Access Object) class for table [TSYS_PGM_BTN_INF].
 *
 * <pre>
 * 1. 패키지명 : kr.co.ta9.pandora3.psys.dao
 * 2. 타입명    : class
 * 3. 작성일    : 2018-04-03
 * 5. 설명       : 프로그램 목록조회
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class TsysPgmBtnInfDao extends BaseDao {
	
	/**
	 * 프로그램 리스트 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject getTsysPgmBtnInfList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("TsysPgmBtnInf.getTsysPgmBtnInfList", parameterMap);
	}
	
	/**
	 * BO 프로그램버튼 삭제
	 * @param tsysPgmInf
	 * @return int
	 * @throws Exception
	 */
	public int deleteTsysPgmBtnInf(TsysPgmInf tsysPgmInf) throws Exception {
		return getSqlSession().delete("TsysPgmBtnInf.deleteTsysPgmBtnInf", tsysPgmInf);
	}
}