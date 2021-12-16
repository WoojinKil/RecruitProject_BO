package kr.co.ta9.pandora3.linkruit.manager;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.linkruit.dao.ApplicantDao;
import kr.co.ta9.pandora3.linkruit.dao.ApplyDao;
import kr.co.ta9.pandora3.linkruit.dao.RecruitNoticeDao;
import kr.co.ta9.pandora3.linkruit.dto.BaseApplicantDto;
import kr.co.ta9.pandora3.linkruit.dto.BaseApplyDto;
import kr.co.ta9.pandora3.linkruit.dto.BaseRecruitNoticeDto;

@Service
public class RecruitNoticeMgr {

	@Autowired
	private RecruitNoticeDao recruitNoticeDao;
	@Autowired
	private ApplyDao applyDao;
	
	
	public JSONObject selectRecruitNoticeGridList(ParameterMap parameterMap) throws Exception{
		System.out.println("selectRecruitNoticeList Mgr 들어감");
		
		return recruitNoticeDao.selectRecruitNoticeGridList(parameterMap);
	}
	
	public void saveRecruitNotice(ParameterMap parameterMap) throws Exception{
		System.out.println("saveRecruitNotice MGR");
		int cnt =0;
		List<BaseRecruitNoticeDto> insertList = new ArrayList<BaseRecruitNoticeDto>();
		List<BaseRecruitNoticeDto> updateList = new ArrayList<BaseRecruitNoticeDto>();
		List<BaseRecruitNoticeDto> deleteList = new ArrayList<BaseRecruitNoticeDto>();
		parameterMap.populates(BaseRecruitNoticeDto.class, insertList, updateList, deleteList,"recruitNoticeData");
		
		BaseRecruitNoticeDto[] insert= insertList.toArray(new BaseRecruitNoticeDto[0]);
		BaseRecruitNoticeDto[] update= insertList.toArray(new BaseRecruitNoticeDto[0]);
		BaseRecruitNoticeDto[] delete= insertList.toArray(new BaseRecruitNoticeDto[0]);
		
		
		if(!insertList.isEmpty()) {
			for(BaseRecruitNoticeDto baseRecruitNoticeDto : insertList) {
				parameterMap.put("RECRUITNO",baseRecruitNoticeDto.getRecruitno());
				cnt= recruitNoticeDao.selectRecruitNoticeCnt(parameterMap);
				
			}
		}
		if(cnt != 0) {
			System.out.println("saveRecruitNotice MGR insert");
			recruitNoticeDao.insertMany(insert);
			System.out.println("saveRecruitNotice MGR update");
			recruitNoticeDao.updateMany("RecruitNotice.update",update);
			System.out.println("saveRecruitNotice MGR delete");
			recruitNoticeDao.deleteMany("RecruitNotice.delete",delete);
			recruitNoticeDao.deleteApplicant(delete);
		}
		
		

		
		
	}
	//지원자 입력/수정/삭제
	public void saveAll(ParameterMap parameterMap) throws Exception{
		
		System.out.println("saveRecruitNotice MGR");
		
		
		List<BaseRecruitNoticeDto> insertList = new ArrayList<BaseRecruitNoticeDto> ();
		List<BaseRecruitNoticeDto> updateList = new ArrayList<BaseRecruitNoticeDto>();
		List<BaseRecruitNoticeDto> deleteList = new ArrayList<BaseRecruitNoticeDto>();
		parameterMap.populates(BaseRecruitNoticeDto.class, insertList, updateList, deleteList,"recruitNoticeData");
		System.out.println("saveRecruitNotice MGR에서 parameterMap"+ parameterMap);
		
		System.out.println("insertList " + insertList.toString());
		System.out.println("updateList " + updateList.toString());
		System.out.println("deleteList " + deleteList.toString());
		
		
		BaseRecruitNoticeDto[] insert = insertList.toArray(new BaseRecruitNoticeDto[0]);
		BaseRecruitNoticeDto[] update = updateList.toArray(new BaseRecruitNoticeDto[0]);
		BaseRecruitNoticeDto[] delete = deleteList.toArray(new BaseRecruitNoticeDto[0]);
		for(int i=0;i<insert.length; i++) {

			System.out.println("insert 값은="+insert[i].toString());
				
		}
		
		System.out.println("saveRecruitNotice MGR에서 insert시도");
		
		recruitNoticeDao.insertMany("RecruitNotice.insert",insert);
		System.out.println("saveRecruitNotice MGR에서 update시도");
		recruitNoticeDao.updateMany("RecruitNotice.update",update);
		System.out.println("saveRecruitNotice MGR에서 delete시도");
		
		recruitNoticeDao.deleteMany("RecruitNotice.delete",delete);
		recruitNoticeDao.deleteApplicant(delete);
		
	
		List<BaseApplyDto> insertApplyList = new ArrayList<BaseApplyDto>();
		List<BaseApplyDto> updateApplyList = new ArrayList<BaseApplyDto>();
		List<BaseApplyDto> deleteApplyList = new ArrayList<BaseApplyDto>();
		
		parameterMap.populates(BaseApplicantDto.class, insertList, updateList, deleteList, "applyData");
		
		BaseApplyDto[] Applyinsert = insertApplyList.toArray(new BaseApplyDto[0]);
		BaseApplyDto[] Applyupdate = updateApplyList.toArray(new BaseApplyDto[0]);
		BaseApplyDto[] Applydelete = deleteApplyList.toArray(new BaseApplyDto[0]);
	
		applyDao.insertMany("Apply.insert",Applyinsert);
		applyDao.insertMany("Apply.update",Applyupdate);
		applyDao.insertMany("Apply.delete",Applydelete);
		
		
		
		
		
	}
	
	
	
}
