package kr.co.ta9.pandora3.bpcm.dao;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
 * DW DB
 *
 * <pre>
 * 1. 패키지명 : kr.co.ta9.pandora3.bpcm.dao
 * 2. 타입명   : class
 * 3. 작성일   : 2020-01-21
 * 4. 설명     : 캠페인DB DAO
 * </pre>
 *
 * @since 2020. 01. 21
 */
@Repository
public class Bpcm2008Dao extends BaseDao {
	
	/**
	 * 인사이트레포트-기준년월조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectStdYm(ParameterMap parameterMap) throws Exception { 
		return queryForGrid("Bpcm2008.selectStdYm", parameterMap);
	}
	
	/**
	 * 인사이트레포트-그래프 하이라이트 1. 매출요약 그래프조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectHighlightSalesSummary(ParameterMap parameterMap) throws Exception { 
		return queryForGrid("Bpcm2008.selectHighlightSalesSummary", parameterMap);
	}

	/**
	 * 인사이트레포트-그래프 하이라이트-2. 총매출실적/오프라인(조회기준) 매출실적
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectHighlightAllSalesOff(ParameterMap parameterMap) throws Exception { 
		return queryForGrid("Bpcm2008.selectHighlightAllSalesOff", parameterMap);
	}

	/**
	 * 인사이트레포트-하이라이트-3. 회원/비회원
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectHighlightCust1(ParameterMap parameterMap) throws Exception { 
		return queryForGrid("Bpcm2008.selectHighlightCust1", parameterMap);
	}

}