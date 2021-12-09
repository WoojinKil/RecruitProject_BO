package kr.co.ta9.pandora3.linkruit.dao;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

@Repository
public class RecruitNoticeDao extends BaseDao {

	public JSONObject selectRecruitNoticeGridList(ParameterMap parameterMap) throws Exception{
		
		System.out.println("selectRecruitNoticeList 진입");
		
		return queryForGrid("RecuitNotice.selectRecruitNoticeList", parameterMap);
		
	}
}
