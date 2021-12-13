package kr.co.ta9.pandora3.linkruit.manager;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.linkruit.dao.ApplyDao;
import kr.co.ta9.pandora3.linkruit.dto.BaseApplicantDto;
import kr.co.ta9.pandora3.linkruit.dto.BaseApplyDto;
import kr.co.ta9.pandora3.linkruit.dto.ApplyDto;
@Service
public class ApplyMgr {

	@Autowired
	ApplyDao applyDao;
	
	public JSONObject selectApplicatnGridList(ParameterMap parameterMap) throws Exception {
		// TODO Auto-generated method stub
		return applyDao.selectApplyGridList(parameterMap);
		
	}
	
	public void saveApply2(ParameterMap parameterMap) throws Exception {
		List<ApplyDto> insertList = new ArrayList<ApplyDto>();
		List<ApplyDto> updateList = new ArrayList<ApplyDto>();
		List<ApplyDto> deleteList = new ArrayList<ApplyDto>();
		parameterMap.populates(ApplyDto.class, insertList, updateList, deleteList);
		
		ApplyDto[] insert = insertList.toArray(new ApplyDto[0]);
		ApplyDto[] update = updateList.toArray(new ApplyDto[0]);
		ApplyDto[] delete = deleteList.toArray(new ApplyDto[0]);
		
		
		applyDao.insertMany(ApplyDto.class,insert);
		applyDao.updateMany("Apply.update",update);
		applyDao.deleteMany("Apply.delete",delete);
		
				
		
	}

}
