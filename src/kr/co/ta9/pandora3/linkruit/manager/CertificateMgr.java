package kr.co.ta9.pandora3.linkruit.manager;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.linkruit.dao.CertificateDao;
import kr.co.ta9.pandora3.linkruit.dto.BaseApplicantDto;
import kr.co.ta9.pandora3.linkruit.dto.CertificateDto;

@Service
public class CertificateMgr {

	@Autowired
	CertificateDao certificateDao;
	
	public JSONObject selectCertificateGridList(ParameterMap parameterMap) throws Exception{
		
		return certificateDao.selectCertificateGridLsit(parameterMap);
	}

	public void saveCertificate3(ParameterMap parameterMap) throws Exception {
		// TODO Auto-generated method stub
		List<CertificateDto> insertList = new ArrayList<CertificateDto>();
		List<CertificateDto> updateList = new ArrayList<CertificateDto>();
		List<CertificateDto> deleteList = new ArrayList<CertificateDto>();

		parameterMap.populates(CertificateDto.class, insertList, updateList, deleteList);
		
		CertificateDto[] insert = insertList.toArray(new CertificateDto[0]);
		CertificateDto[] update = updateList.toArray(new CertificateDto[0]);
		CertificateDto[] delete = deleteList.toArray(new CertificateDto[0]);
		
		
		certificateDao.insertMany(CertificateDto.class,insert);
		
		certificateDao.updateMany("Certificate.update",update);
		certificateDao.deleteMany("Certificate.delete",delete);
		
		
	}
}
