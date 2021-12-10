package kr.co.ta9.pandora3.linkruit.dao;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.linkruit.dto.BaseApplicantDto;

@Repository
public class ApplicantDao extends BaseDao{

	
	public JSONObject selectApplicantGridList(ParameterMap parameterMap) throws Exception{
		return queryForGrid("Applicant.selectApplicantList", parameterMap);
	
	}
	

	
	
}
