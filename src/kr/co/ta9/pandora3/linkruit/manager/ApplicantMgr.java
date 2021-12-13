package kr.co.ta9.pandora3.linkruit.manager;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.linkruit.dao.ApplicantDao;
import kr.co.ta9.pandora3.linkruit.dto.BaseApplicantDto;

@Service
public class ApplicantMgr {

	@Autowired
	ApplicantDao applicantDao;
	
	
	public JSONObject selectApplicantGridList(ParameterMap parameterMap) throws Exception{
		return applicantDao.selectApplicantGridList(parameterMap);
	}
	
	//지원자 공고 저장
	public void saveApplicant2(ParameterMap parameterMap) throws Exception{
		List<BaseApplicantDto> insertList = new ArrayList<BaseApplicantDto>();
		List<BaseApplicantDto> updateList = new ArrayList<BaseApplicantDto>();
		List<BaseApplicantDto> deleteList = new ArrayList<BaseApplicantDto>();

		parameterMap.populates(BaseApplicantDto.class, insertList, updateList, deleteList);
		
		BaseApplicantDto[] insert = insertList.toArray(new BaseApplicantDto[0]);
		BaseApplicantDto[] update = updateList.toArray(new BaseApplicantDto[0]);
		BaseApplicantDto[] delete = deleteList.toArray(new BaseApplicantDto[0]);
		
		
		applicantDao.insertMany(BaseApplicantDto.class,insert);
		applicantDao.updateMany("Applicant.update",update);
		applicantDao.deleteMany("Applicant.delete",delete);
		
		

		
		
	}
	
	
}
