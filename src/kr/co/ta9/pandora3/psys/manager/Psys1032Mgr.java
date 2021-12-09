package kr.co.ta9.pandora3.psys.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.dto.DataMap;
import kr.co.ta9.pandora3.psys.dao.TsysBatchLogDao;


/**
* <pre>
* 1. 클래스명 : Psys1032Mgr
* 2. 설명 : 배치 로그 모니터링
* 3. 작성일 : 2019-05-28
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Psys1032Mgr {


	@Autowired
	private TsysBatchLogDao tsysBatchLogDao;
	
	/**
	 * 시스템 관리 > 모니터링 > 배치 모니터링
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTsysBatchGridList(ParameterMap parameterMap) throws Exception {
		return tsysBatchLogDao.selectTsysBatchGridList(parameterMap);
	}

	/**
	 * 시스템 관리 > 모니터링 > 배치 모니터링 상세
	 * @param parameterMap
	 * @return DataMap
	 * @throws Exception
	 */
	public DataMap selectTsysBatchDetail(ParameterMap parameterMap) throws Exception {
		return tsysBatchLogDao.selectTsysBatchDetail(parameterMap);
	}

}
