package kr.co.ta9.pandora3.linkruit.manager;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.linkruit.dao.MemberDao;
import kr.co.ta9.pandora3.linkruit.dto.BaseMemberDto;

@Service
public class MemberMgr {
	
	@Autowired
	private MemberDao memberDao;
	
	public JSONObject selectMemberList(ParameterMap parameterMap) throws Exception{
		
		return memberDao.selectMemberGridList(parameterMap);

	
	}

	public void saveMember(ParameterMap parameterMap) throws Exception {
		// TODO Auto-generated method stub
		
		List<BaseMemberDto> insertList = new ArrayList<BaseMemberDto>();
		List<BaseMemberDto> updateList = new ArrayList<BaseMemberDto>();
		List<BaseMemberDto> deleteList = new ArrayList<BaseMemberDto>();
		
		parameterMap.populates(BaseMemberDto.class, insertList, updateList, deleteList,"memberData");

		
		BaseMemberDto[] insert = insertList.toArray(new BaseMemberDto[0]);
		BaseMemberDto[] update = updateList.toArray(new BaseMemberDto[0]);
		BaseMemberDto[] delete = deleteList.toArray(new BaseMemberDto[0]);

		memberDao.insertMany("Member.insert", insert);
		memberDao.updateMany("Member.update", update);
		memberDao.deleteMany("Member.delete", delete);
	}
}
