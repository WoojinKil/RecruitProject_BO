package kr.co.ta9.pandora3.linkruit.dao;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import com.amazon.support.security.ISecurityContext;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.exception.PrimaryKeyNotSettedException;
import kr.co.ta9.pandora3.linkruit.dto.BaseRecruitNoticeDto;

@Repository
public class RecruitNoticeDao extends BaseDao {


	//채용공고 리스트 조회
	public JSONObject selectRecruitNoticeGridList(ParameterMap parameterMap) throws Exception{
		
		
		
		return queryForGrid("RecruitNotice.selectRecruitNoticeList", parameterMap);
		
	}
	
	//채용공고 리스트 개수 조회
	public int selectRecruitNoticeCnt(ParameterMap parameterMap) throws Exception{
		return getSqlSession().selectOne("RecruitNoitce.selectRecruitNoticeCnt",parameterMap);
		
	}
	
	

	
	
	
}
