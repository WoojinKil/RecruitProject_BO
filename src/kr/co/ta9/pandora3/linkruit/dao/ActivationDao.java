package kr.co.ta9.pandora3.linkruit.dao;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
@Repository
public class ActivationDao extends BaseDao {

	
	public JSONObject selectActivationGridList(ParameterMap parameterMap) throws Exception{
		return queryForGrid("Activation.selectActivationList", parameterMap);
				
				
	}
}
