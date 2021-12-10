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

	//기본키 값 체크
	public boolean isPrimaryKeyValid(BaseRecruitNoticeDto baseRecruitNoticeDto) {
		boolean result = true;
		if(baseRecruitNoticeDto != null && baseRecruitNoticeDto.getRecruitNo() != null) {
			result = true;
		}else {
			result = false;
		}
		return result;
		
	}
	//채용공고 리스트 조회
	public JSONObject selectRecruitNoticeGridList(ParameterMap parameterMap) throws Exception{
		
		System.out.println("selectRecruitNoticeList 진입");
		
		return queryForGrid("RecruitNotice.selectRecruitNoticeList", parameterMap);
		
	}
	
	//채용공고 리스트 개수 조회
	public int selectRecruitNoticeCnt(ParameterMap parameterMap) throws Exception{
		return getSqlSession().selectOne("RecruitNoitce.selectRecruitNoticeCnt",parameterMap);
		
	}
	
	
	//채용공고가 삭제되면 지원한 지원자들도 삭제
	public int deleteApplicant(BaseRecruitNoticeDto...baseRecruitNoticeDtos) throws Exception{
		int count =0;
		if(baseRecruitNoticeDtos != null) {
			for(BaseRecruitNoticeDto baseRecruitNoticeDto : baseRecruitNoticeDtos) {
				if(!isPrimaryKeyValid(baseRecruitNoticeDto)) {
					throw new PrimaryKeyNotSettedException("instance of BaseRecruitNoticeDto can not be null or primary key is not set");
					
					
				}
				count += getSqlSession().delete("RecruitNotice.deleteApplicant",baseRecruitNoticeDto);
				
			}
		}
		return count;
	}
	
	
	
}
