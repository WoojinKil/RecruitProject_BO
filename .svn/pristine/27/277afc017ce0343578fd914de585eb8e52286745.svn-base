package kr.co.ta9.pandora3.bpcm.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.bpcm.dao.Bpcm2008BpnDao;
import kr.co.ta9.pandora3.bpcm.dao.Bpcm2008Dao;

/**
* <pre>
* 1. 클래스명 : Bpcm2001Mgr
* 2. 설명 : 인사이트레포트-이달의레포트
* 3. 작성일 : 2020-01-21
* 4. 작성자   : 
* </pre>
*/
@Service
public class Bpcm2008Mgr {
	
	@Autowired
	private Bpcm2008Dao bpcm2008Dao;
	
	@Autowired
	private Bpcm2008BpnDao bpcm2008BpnDao;

	/**
	 * 인사이트레포트-기준년월조회
	 * @param  parameterMap
	 * @return String
	 * @throws Exception
	 */
	public JSONObject getStdYm(ParameterMap parameterMap) throws Exception{
		return bpcm2008Dao.selectStdYm(parameterMap);
	}
	
	/**
	 * 인사이트레포트-1. 매출요약 그래프조회
	 * @param  parameterMap
	 * @return String
	 * @throws Exception
	 */
	public JSONObject getHighlightSalesSummary(ParameterMap parameterMap) throws Exception{
		return bpcm2008Dao.selectHighlightSalesSummary(parameterMap);
	}

	/**
	 * 인사이트레포트-그래프 하이라이트-2. 총매출실적/오프라인(조회기준) 매출실적
	 * @param  parameterMap
	 * @return String
	 * @throws Exception
	 */
	public JSONObject getHighlightAllSalesOff(ParameterMap parameterMap) throws Exception{
		return bpcm2008Dao.selectHighlightAllSalesOff(parameterMap);
	}
	
	/**
	 * 인사이트레포트-하이라이트-3. 회원/비회원
	 * @param  parameterMap
	 * @return String
	 * @throws Exception
	 */
	public JSONObject getHighlightCust1(ParameterMap parameterMap) throws Exception{
		return bpcm2008Dao.selectHighlightCust1(parameterMap);
	}
	
	/**
	 * 인사이트레포트-고객특성
	 * @param  parameterMap
	 * @return String
	 * @throws Exception
	 */
	public JSONObject getCustSpec(ParameterMap parameterMap) throws Exception{
		return bpcm2008BpnDao.selectCustSpec(parameterMap);
	}
	
	/**
	 * 인사이트레포트-구매특성-요일별매출비중
	 * @param  parameterMap
	 * @return String
	 * @throws Exception
	 */
	public JSONObject getPurchaseSpec(ParameterMap parameterMap) throws Exception{
		return bpcm2008BpnDao.selectPurchaseSpec(parameterMap);
	}
	
	/**
	 * 점팝업 조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject getCstr(ParameterMap parameterMap) throws Exception{
		return bpcm2008BpnDao.selectCstr(parameterMap);
	}
	
	/**
	 * 브랜드팝업 조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject getBrnd(ParameterMap parameterMap) throws Exception{
		return bpcm2008BpnDao.selectBrnd(parameterMap);
	}
	
}
