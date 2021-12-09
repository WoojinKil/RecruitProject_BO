package kr.co.ta9.pandora3.pmbr.dao;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.BeanUtil;
import kr.co.ta9.pandora3.pcommon.dto.TmbrConnLog;

/**
 * TmbrConnLogDao - DAO(Data Access Object) class for table [TMBR_CONN_LOG].
 *
 * <pre>
 * 1. 패키지명 : kr.co.ta9.pandora3.pmbr.dao
 * 2. 타입명 : class
 * 3. 작성일 : 2018-02-18
 * 4. 작성자 : TA9
 * 5. 설명 : 사용자 접속 LOG DAO(조회 쿼리 호출)
 * </pre>
 */
@Repository
public class TmbrConnLogDao extends BaseDao {
	
	/**
	 * 당일 접속IP 중복 체크 
	 * @param parameterMap
	 * @return String
	 * @throws Exception
	 */
	public String selectTmbrConnLogIpOvlp(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectOne("TmbrConnLog.selectTmbrConnLogIpOvlp", parameterMap);
	}	
	
	/**
	 * 통계관리 > 진입통계목록(BO)
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTmbrConnSttsGridList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("TmbrConnLog.selectTmbrConnSttsGridList", parameterMap);
	}

	/**
	 * 통계관리 > 진입통계 초기값(BO:총 통계&당일 통계)
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public List<TmbrConnLog> selectTmbrConnSttsInitCnt(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectList("TmbrConnLog.selectTmbrConnSttsInitCnt", parameterMap);
	}
	
	/**
	 * 통계관리 > 대시보드 방문자수/화면접속수 조회
	 * @param 
	 * @return List<TmbrConnLog>
	 * @throws Exception
	 */
	public List<TmbrConnLog> selectTmbrConnSttsVisrAcsCntList() {
		return getSqlSession().selectList("TmbrConnLog.selectTmbrConnSttsVisrAcsCntList");
	}
	
	/**
	 * 메인관리 > 메인전시상세(BO)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public JSONObject selectTmbrConnSttsVisrAcsCntMapList() throws Exception{
		List<Object> dataList = getSqlSession().selectList("TmbrConnLog.selectTmbrConnSttsVisrAcsCntList");
		List<Map<String,Object>> mapList = BeanUtil.convertObjectToMapList(dataList);
		JSONObject json = new JSONObject();
		json.put("mapList", mapList);
		return json;
	}
	
	/**
	 * 방문자수/화면접속수 통계 갱신 (당일 첫 회 insert, 당일 첫 회 이후 update)
	 * @param parameterMap
	 * @return int
	 * @throws Exception
	 */
	public int insertTmbrConnStts(ParameterMap parameterMap) throws Exception {
		return getSqlSession().insert("TmbrConnLog.insertTmbrConnStts", parameterMap);
	}
	
	/**
	 * 전체 방문자수/화면접속수 통계 갱신(통합)
	 * @param parameterMap
	 * @return int
	 * @throws Exception
	 */
	public int updateTmbrConnSttsTotInfo(ParameterMap parameterMap) throws Exception {
		return getSqlSession().update("TmbrConnLog.updateTmbrConnSttsTotInfo", parameterMap);
	}
}