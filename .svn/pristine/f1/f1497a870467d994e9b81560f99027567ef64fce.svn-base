package kr.co.ta9.pandora3.landing.manager;

import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.BeanUtil;
import kr.co.ta9.pandora3.landing.dao.LandingDao;
import kr.co.ta9.pandora3.landing.dao.TbAmaiDstrbzarvstDDao;
import kr.co.ta9.pandora3.landing.dao.TbDicmsTsttscuststyFDao;
import kr.co.ta9.pandora3.landing.dao.TbDmcmMktgrcmcgrpsmryFDao;
import kr.co.ta9.pandora3.landing.dao.TbDmcuMmcustvocFDao;
import kr.co.ta9.pandora3.landing.dao.TbVmcsLngeutlprcoSDao;
import kr.co.ta9.pandora3.pcommon.dto.TbDicmsTsttscuststyF;
import kr.co.ta9.pandora3.pcommon.dto.TbDmcmMktgrcmcgrpsmryF;
import kr.co.ta9.pandora3.pcommon.dto.TbVmcsLngeutlprcoS;

/**
* <pre>
* 1. 클래스명 : Bpcm3001Mgr
* 2. 설명 : 사은행사
* 3. 작성일 : 2019-10-10
* 4.작성자   : KHE
* </pre>
*/
@Service
public class LandingMgr {

	@Autowired
	private LandingDao ladningDao;
	
	@Autowired
	private TbDmcmMktgrcmcgrpsmryFDao tbDmcmMktgrcmcgrpsmryFDao;
	
	@Autowired
	private TbDicmsTsttscuststyFDao tbDicmsTsttscuststyFDao;
	
	@Autowired
	private TbAmaiDstrbzarvstDDao tbAmaiDstrbzarvstDDao;
	
	@Autowired
	private TbDmcuMmcustvocFDao tbDmcuMmcustvocFDao;
	
	@Autowired
	private TbVmcsLngeutlprcoSDao TbVmcsLngeutlprcoSDao;
	
	/**
	 * 랜딩 페이지 날씨 가져오기
	 * @param parameterMap
	 * @return
	 */
	public JSONObject getWeather(ParameterMap parameterMap) throws Exception {
		return ladningDao.getWeather(parameterMap);
	}

	/**
	 * mkt data 조회
	 * @param parameterMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public JSONObject getMktData(ParameterMap parameterMap) throws Exception {
		
		JSONObject json = new JSONObject();
		TbDmcmMktgrcmcgrpsmryF tbDmcmMktgrcmcgrpsmryF = tbDmcmMktgrcmcgrpsmryFDao.getMktData(parameterMap);
		if ( tbDmcmMktgrcmcgrpsmryF != null ) {
			
			Map<String, Object> resMap = BeanUtil.convertObjectToMap(tbDmcmMktgrcmcgrpsmryF);
			
			json.put("mktData", resMap);
		}
		
		return json;
	}

	/**
	 * 내점 고객 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject getStyData(ParameterMap parameterMap) throws Exception {
		JSONObject json = new JSONObject();
		
		TbDicmsTsttscuststyF tbDicmsTsttscuststyF = tbDicmsTsttscuststyFDao.getStyData(parameterMap);
		if ( tbDicmsTsttscuststyF != null ) {
			
			Map<String, Object> resMap = BeanUtil.convertObjectToMap(tbDicmsTsttscuststyF);
			
			json.put("styData", resMap);
		}
		
		
		return json;
	}
	
	/**
	 * 고객접점 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject getTsttscuststy(ParameterMap parameterMap) throws Exception {
		
		JSONObject json = tbDicmsTsttscuststyFDao.getTsttscuststy(parameterMap);
		
		return json;
	}
	
	
	/**
	 * 방문수 추이 조회
	 * @param parameterMap
	 * @return
	 */
	public JSONObject getDstrbzarvstList(ParameterMap parameterMap) throws Exception {
		
		return tbAmaiDstrbzarvstDDao.getDstrbzarvstList(parameterMap);
	}
	
	/**
	 * voc TbDmcuMmcustvocF 
	 * @param parameterMap
	 * @return
	 */
	public JSONObject getMmcustvocList(ParameterMap parameterMap) throws Exception {
		
		return tbDmcuMmcustvocFDao.getMmcustvocList(parameterMap);
	}
	
	/**
	 * 라운지 TbVmcsLngeutlprcoS
	 * @param parameterMap
	 * @return
	 */
	public JSONObject getLngeutlprco(ParameterMap parameterMap) throws Exception {
		
		return TbVmcsLngeutlprcoSDao.getLngeutlprco(parameterMap);
	}

	/**
	 *  라운지 getDetailLngeutlprco
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject getDetailLngeutlprco(ParameterMap parameterMap) throws Exception {
		
		JSONObject json = new JSONObject();
		
		TbVmcsLngeutlprcoS TbVmcsLngeutlprcoS = TbVmcsLngeutlprcoSDao.getDetailLngeutlprco(parameterMap);
		
		if ( TbVmcsLngeutlprcoS != null ) {
			
			Map<String, Object> resMap = BeanUtil.convertObjectToMap(TbVmcsLngeutlprcoS);
			
			json.put("detailLngeutlprcoData", resMap);
		}
		
		return json;
	}
	
	
	
}
