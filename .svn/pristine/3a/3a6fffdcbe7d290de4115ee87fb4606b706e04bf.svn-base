package kr.co.ta9.pandora3.pmbr.dao.base;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.pcommon.dto.TmbrConnStts;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * BaseTmbrConnSttsDao - BASE DAO(Base Data Access Object) class for table [TMBR_CONN_STTS].
 *
 * <pre>
 * 1. 패키지명 : kr.co.ta9.pandora3.pmbr.dao
 * 2. 타입명 : class
 * 3. 작성일 : 2018-02-18
 * 4. 작성자 : TA9
 * 5. 설명 : 사용자 접속 상태 기본 DAO(조회 쿼리 호출)
 * </pre>
 */
@Repository
public class BaseTmbrConnSttsDao extends BaseDao {
	
	/**
	 * @param  parameterMap
	 * @return TmbrConnStts
	 * @throws Exception
	 */
	public TmbrConnStts getTmbrConnStts(ParameterMap parameterMap) throws Exception {
		return (TmbrConnStts) getSqlSession().selectOne("TmbrConnStts.select", parameterMap);
	}
	
	/**
	 * @param  parameterMap
	 * @return java.util.Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map getTmbrConnSttsMap(ParameterMap parameterMap) throws Exception {
		return (Map) getSqlSession().selectOne("TmbrConnStts.selectMap", parameterMap);
	}	

}