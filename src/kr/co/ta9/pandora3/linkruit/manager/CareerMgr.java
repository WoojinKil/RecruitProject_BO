package kr.co.ta9.pandora3.linkruit.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.linkruit.dao.CareerDao;

@Service
public class CareerMgr {

	@Autowired
	private CareerDao careerDao;
	
	public JSONObject selectCareerGridList(ParameterMap parameterMap) throws Exception{
		return careerDao.selectCareerGridList(parameterMap);
		
	}
}
