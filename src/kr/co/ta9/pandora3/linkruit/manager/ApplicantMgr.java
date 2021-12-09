package kr.co.ta9.pandora3.linkruit.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.linkruit.dao.ApplicantDao;

@Service
public class ApplicantMgr {

	@Autowired
	ApplicantDao applicantDao;
	public JSONObject selectApplicantGridList(ParameterMap parameterMap) throws Exception{
		return applicantDao.selectApplicantGridList(parameterMap);
	}
}
