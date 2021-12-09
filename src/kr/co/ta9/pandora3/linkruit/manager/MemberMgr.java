package kr.co.ta9.pandora3.linkruit.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.linkruit.dao.MemberDao;

@Service
public class MemberMgr {
	
	@Autowired
	private MemberDao memberDao;
	
	public JSONObject selectMemberList(ParameterMap parameterMap) throws Exception{
		System.out.println(parameterMap);
		System.out.println("mgr까지 진입");
		
		return memberDao.selectMemberGridList(parameterMap);

	
	}
}
