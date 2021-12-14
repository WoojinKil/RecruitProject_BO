package kr.co.ta9.pandora3.linkruit.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.linkruit.dao.PartDao;

@Service
public class PartMgr {

	@Autowired
	private PartDao partDao;
	
	public JSONObject selectPart(ParameterMap parameterMap) throws Exception{
	
		return partDao.selectPart(parameterMap);
		
	}
}
