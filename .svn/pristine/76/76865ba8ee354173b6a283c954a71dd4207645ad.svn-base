package kr.co.ta9.pandora3.psys.dao;

import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.TsysLogInf;

/**
 * TsysLogInfDao - DAO(Data Access Object) class for table [TSYS_LOG_INF].
 *
 * <pre>
 * 1. 패키지명 : kr.co.ta9.pandora3.psys.dao
 * 2. 타입명 : class
 * 3. 작성일 : 2018-02-18
 * 4. 작성자 : TA9
 * 5. 설명 : 로그인 이력 DAO(조회 쿼리 호출)
 * </pre>
 */
@Repository
public class TsysLogInfDao extends BaseDao {

	/**
	 * 로그인 이력  리스트
	 * @param parameterMap
	 * @return SysUserLogin
	 * @throws Exception
	 */
	public JSONObject selectTsysLogInfList(ParameterMap parameterMap) throws Exception{
		return queryForGrid("TsysLogInf.selectTsysLogInfList", parameterMap);
	}

	/**
	 * 로그인 이력  리스트
	 * @param parameterMap
	 * @return SysUserLogin
	 * @throws Exception
	 */
	public List<TsysLogInf> selectTsysLogInfArrayList(ParameterMap parameterMap) throws Exception{
		return getSqlSession().selectList("TsysLogInf.selectTsysLogInfList", parameterMap);
	}

	/**
	 * 프론트 로그인 이력 리스트
	 * @param parameterMap
	 * @return SysUserLogin
	 * @throws Exception
	 */
	public JSONObject selectTsysLogInfFrntList(ParameterMap parameterMap) throws Exception{
		return queryForGrid("TsysLogInf.selectTsysLogInfFrntList", parameterMap);
	}

	/**
	 * 프론트 메뉴별 접속 이력 리스트
	 * @param parameterMap
	 * @return SysUserLogin
	 * @throws Exception
	 */
	public JSONObject selectTsysLogInfFrntMnuList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("TsysLogInf.selectTsysLogInfFrntMnuList", parameterMap);
	}
}