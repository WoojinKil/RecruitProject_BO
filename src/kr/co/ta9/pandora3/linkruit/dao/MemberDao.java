package kr.co.ta9.pandora3.linkruit.dao;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.BeanUtil;

@Repository
public class MemberDao extends BaseDao{

	public JSONObject selectMemberList(ParameterMap parameterMap) throws Exception{
		System.out.println("dao까지 진입 성공");
		List<Object> dataList = getSqlSession().selectList("Member.selectMemberList");
		List<Map<String, Object>> mapList = BeanUtil.convertObjectToMapList(dataList);
		JSONObject json = new JSONObject();
		json.put("memberInfo", mapList);

//		return null;
		return json;
				
	}
	public JSONObject selectMemberGridList(ParameterMap parameterMap) throws Exception{
		return queryForGrid("Member.selectMemberList", parameterMap);
		
		
	}
}
