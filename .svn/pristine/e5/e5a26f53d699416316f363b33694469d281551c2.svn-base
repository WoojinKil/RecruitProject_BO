package kr.co.ta9.pandora3.pbbs.dao;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.TbbsAtlcCnsInf;

/**
 * <pre>
 * 1. 클래스명 : TbbsAtlcCnsInfDao
 * 2. 테이블 : TBBS_ATLC_CNS_INF(SELECT)
 * 3. 설명 : 
 * 4. 작성일 : 2019. 03. 28
 * 5. 작성자 : 
 * 6. 변경사항 : 2019. 03. 28, 최초작성
 * </pre>
 */
@Repository
public class TbbsAtlcCnsInfDao extends BaseDao {

	/**
	 * 수강상담신청조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTbbsAtlcCnsInfList(ParameterMap parameterMap) throws Exception {
		return queryForGrid("TbbsAtlcCnsInf.selectTbbsAtlcCnsInfList", parameterMap);
	}

	/**
	 * 수강상담신청상세조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public TbbsAtlcCnsInf selectTbbsAtlcCnsInf(ParameterMap parameterMap) throws Exception {
		return (TbbsAtlcCnsInf) getSqlSession().selectOne("TbbsAtlcCnsInf.selectTbbsAtlcCnsInf", parameterMap);
	}
	

	/**
	 * 수강 신청 상담 상세 저장
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public int saveTbbsAtlcCnsInf(ParameterMap parameterMap) throws Exception {
		return getSqlSession().update("TbbsAtlcCnsInf.updateTbbsAtlcCnsInf", parameterMap);
	}
}