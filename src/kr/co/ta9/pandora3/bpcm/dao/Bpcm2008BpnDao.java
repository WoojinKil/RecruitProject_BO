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
public class Bpcm2008BpnDao extends BaseDao {
	
	/**
	 * 인사이트레포트-고객특성
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectCustSpec(ParameterMap parameterMap) throws Exception { 
		return queryForGrid("Bpcm2008Bpn.selectCustSpec", parameterMap);
	}
	
	/**
	 * 인사이트레포트-구매특성-요일별매출비중
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectPurchaseSpec(ParameterMap parameterMap) throws Exception { 
		return queryForGrid("Bpcm2008Bpn.selectPurchaseSpec", parameterMap);
	}
	
	/**
	 * 점팝업 조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectCstr(ParameterMap parameterMap) throws Exception { 
		return queryForGrid("Bpcm2008Bpn.selectCstr", parameterMap);
	}
	
	/**
	 * 브랜드팝업 조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectBrnd(ParameterMap parameterMap) throws Exception { 
		return queryForGrid("Bpcm2008Bpn.selectBrnd", parameterMap);
	}
	
}