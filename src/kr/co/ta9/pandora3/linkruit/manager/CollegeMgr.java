package kr.co.ta9.pandora3.linkruit.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.linkruit.dao.CollegeDao;

@Service
public class CollegeMgr {

	@Autowired
	CollegeDao collegeDao;
	
	public JSONObject selectCollegeGridList(ParameterMap parameterMap) throws Exception{
		return collegeDao.selectCollegeGridList(parameterMap);
		
	}

}
