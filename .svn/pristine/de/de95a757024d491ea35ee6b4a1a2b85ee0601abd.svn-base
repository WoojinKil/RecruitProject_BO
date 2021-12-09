package kr.co.ta9.pandora3.psys.dao;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmMnuRtnn;

/**
 * TsysAdmMnuRtnnDao - DAO(Data Access Object) class for table [TSYS_ADM_MNU_RTNN].
 *
 * <pre>
 * 1. 클래스명 : TsysAdmMnuRtnnDao
 * 2. 설명 : 권리자메뉴할당 DAO(SELECT)
 * 3. 작성일 : 2019-03-12
 * 4. 작성자 : TANINE
 * </pre>
 *
 * @since 2019. 03. 12
 */
@Repository
public class TsysAdmMnuRtnnDao extends BaseDao {
	
	/**
	 * 관리자메뉴할당 그리드 조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject getTsysAdmMnuRtnnGrdList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("TsysAdmMnuRtnn.selectTsysAdmMnuRtnnGrdList", parameterMap);
	}
	
	/**
	 * 사용자 권한 메뉴 신청 목록 조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTsysAdmMnuUsrRtnnGrdList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("TsysAdmMnuRtnn.selectTsysAdmMnuUsrRtnnGrdList", parameterMap);
	}
	
	/**
	 * 사용자 권한 메뉴 신청
	 */
	public int insertApplMnu(TsysAdmMnuRtnn tsysAdmMnuRtnn) throws Exception {
		return getSqlSession().insert("TsysAdmMnuRtnn.insertApplMnu", tsysAdmMnuRtnn);
	}
	
	
}