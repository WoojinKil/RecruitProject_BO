package kr.co.ta9.pandora3.psys.dao;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * TsysHcoInfDao - DAO(Data Access Object) class for table [TSYS_HCO_INF].
 *
 * <pre>
 * 1. 패키지명 : kr.co.ta9.pandora3.psys.dao
 * 2. 타입명 : class
 * 3. 작성일 : 2018-02-18
 * 4. 작성자 : TA9
 * 5. 설명 : 도움말 DAO(조회 쿼리 호출)
 * </pre>
 */
@Repository
public class TsysHcoInfDao extends BaseDao {
	
	/**
	 * 도움말 리스트 조회 (그리드형)
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */	
	public JSONObject getTsysHcoInfList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("TsysHcoInf.getTsysHcoInfList", parameterMap);
	}
	
	/**
	 * 메뉴 리스트 조회
	 * @param parameterMap
	 * @return List<SysPgmInfo>
	 * @throws Exception
	 */
	public JSONObject getTsysAdmMnuList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("TsysHcoInf.getTsysAdmMnuList", parameterMap);
	}
	
	/**
	 * 도움말 정보 조회 (그리드형)
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */	
	public JSONObject getTsysHcoInfGrid(ParameterMap parameterMap) throws Exception {
		return queryForGrid("TsysHcoInf.select", parameterMap);
	}
	
	/**
	 * 도움말 등록시, 중복 체크
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */	
	public int selectTsysHcoInfCnt(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectOne("TsysHcoInf.selectTsysHcoInfCnt", parameterMap);
	}

}