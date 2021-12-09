package kr.co.ta9.pandora3.landing.manager;

import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.landing.dao.BpcmCommPop001Dao;
import kr.co.ta9.pandora3.pcommon.dto.usrdef.BpcmCommPopVO;

/**
* <pre>
* 1. 클래스명 : BpcmCommPop001Mgr
* 2. 설명 : 점 팝업
* 3. 작성일 : 2019-10-10
* 4.작성자   : KHE
* </pre>
*/
@Service
public class BpcmCommPop001Mgr {
	
	@Autowired
	private BpcmCommPop001Dao bpcmCommPop001Dao;

	/**
	 * 자점조회
	 * @param  parameterMap
	 * @return String
	 * @throws Exception
	 */
	public JSONObject selectCstrGridList(ParameterMap parameterMap) throws Exception{
		return bpcmCommPop001Dao.selectCstrGridList(parameterMap);
	}
	
	/**
	 * user 자점 조회 
	 * @param  parameterMap
	 * @return String
	 * @throws Exception
	 */
	public List<BpcmCommPopVO> selectUserCstrList(ParameterMap parameterMap) throws Exception{
		return bpcmCommPop001Dao.selectUserCstrList(parameterMap);
	}
	
}
