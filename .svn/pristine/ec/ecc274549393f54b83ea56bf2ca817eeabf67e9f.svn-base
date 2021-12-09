package kr.co.ta9.pandora3.psys.dao;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmRolRtnn;

/**
 * TsysAdmRolRtnnDao - DAO(Data Access Object) class for table [TSYS_ADM_ROL_RTNN].
 *
 * <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.psys.dao
* 2. 타입명 : class
* 3. 작성일 : 2018-02-18
* 4. 작성자 : TA9
* 5. 설명 : 권한 관리 DAO(조회 쿼리 호출)
 * </pre>
 *
 * @since 2019. 02. 16
 */
@Repository
public class TsysAdmRolRtnnDao extends BaseDao {

	/**
	 * 사용자 권한 목록
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmRolRtnnGridList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("TsysAdmRolRtnn.selectTsysAdmRolRtnnGridList", parameterMap);
	}

	/**
	 * 시스템관리 > 샘플 > 그리드 공통 팝업 호출에서 사용자 정보
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmRolRtnnInfo(ParameterMap parameterMap) throws Exception {
		return queryForGrid("TsysAdmRolRtnn.selectTsysAdmRolRtnnInfo", parameterMap);
	}

	/**
	 * 사용자에 대한 권한 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public List<TsysAdmRolRtnn> selectTsysAdmRolRtnnList(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectList("TsysAdmRolRtnn.selectTsysAdmRolRtnnList", parameterMap);
	}

	/**
	 * 사용자별 시스템 매핑 권한 조회
	 * @param tsysAdmRolRtnnMap
	 * @return
	 * @throws Exception
	 */
	public List<TsysAdmRolRtnn> selectSitTsysAdmRolRtnnList(Map<String, Object> tsysAdmRolRtnnMap) throws Exception {
		
		return getSqlSession().selectList("TsysAdmRolRtnn.selectSitTsysAdmRolRtnnList", tsysAdmRolRtnnMap);
	}
	
	/**
	 * 시스템 사용자 권한 할당 등록
	 * @param tsysAdmRolRtnn
	 * @return int
	 * @throws Exception
	 */
	public int insertTsysAdmRolRtnn(TsysAdmRolRtnn tsysAdmRolRtnn) throws Exception {
		return getSqlSession().insert("TsysAdmRolRtnn.insertTsysAdmRolRtnn", tsysAdmRolRtnn);
	}
	
	/**
	 * 시스템 사용자 권한 할당 삭제 (By USR_ID)
	 * @param usr_id
	 * @return int
	 * @throws Exception
	 */
	public int deleteTsysAdmRolRtnnByUsrId(String usr_id) throws Exception {
		return getSqlSession().delete("TsysAdmRolRtnn.deleteTsysAdmRolRtnnByUsrId", usr_id);
	}

	/**
	 * 사용자 권한 할등 등록  
	 * @param tsysAdmRolRtnn
	 * @throws Exception
	 */
	public int insertTsysAdmRolRtnnOne(TsysAdmRolRtnn tsysAdmRolRtnn) throws Exception {
		return getSqlSession().insert("TsysAdmRolRtnn.insertTsysAdmRolRtnnOne", tsysAdmRolRtnn);
	}

	/**
	 * 개별 권한 신청에 따른 사용자 권한 매핑
	 * @param tsysAdmRolRtnnMap
	 * @return
	 */
	public int insertTsysAdmRolRtnnMap(Map<String, Object> tsysAdmRolRtnnMap) {
		return getSqlSession().insert("TsysAdmRolRtnn.insertTsysAdmRolRtnnMap", tsysAdmRolRtnnMap);
	}
}