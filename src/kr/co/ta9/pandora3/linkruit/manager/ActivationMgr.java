package kr.co.ta9.pandora3.linkruit.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.linkruit.dao.ActivationDao;

@Service
public class ActivationMgr {

	@Autowired
	private ActivationDao activationdao;
	
	public JSONObject selectActivationGridList(ParameterMap parameterMap) throws Exception{
		return activationdao.selectActivationGridList(parameterMap);
	}
}
