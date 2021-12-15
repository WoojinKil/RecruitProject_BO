package kr.co.ta9.pandora3.linkruit.dao;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

@Repository
public class CertificateDao extends BaseDao {
	
	public JSONObject selectCertificateGridLsit(ParameterMap parameterMap) throws Exception{
		
		return queryForGrid("Certificate.selectCertificateList", parameterMap);
		
	}
	

}
