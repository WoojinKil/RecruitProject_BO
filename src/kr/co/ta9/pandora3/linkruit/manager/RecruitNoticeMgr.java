package kr.co.ta9.pandora3.linkruit.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.linkruit.dao.RecruitNoticeDao;

@Service
public class RecruitNoticeMgr {

	@Autowired
	private RecruitNoticeDao recruitNoticeDao;
	
	public JSONObject selectRecruitNoticeGridList(ParameterMap parameterMap) throws Exception{
		System.out.println("selectRecruitNoticeList Mgr 들어감");
		
		return recruitNoticeDao.selectRecruitNoticeGridList(parameterMap);
	}
}
