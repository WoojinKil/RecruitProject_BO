/**
* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명 : kr.co.ta9.pandora3.app.dao
* 3. 파일명 : CommonDao
* 4. 작성일 : 2016-08-22
* 5. 작성자 : tmlee
* </pre>
*/
package kr.co.ta9.pandora3.app.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.app.dao
* 2. 타입명 : class
* 3. 작성일 : 2016-08-22
* 4. 작성자 : tmlee
* 5. 설명 : 기본으로 호출하는 Dao(날짜, 로그인, 페이징, seq...)
* </pre>
*/
@Repository
public class CommonDao extends BaseDao {
	
	/**
	 * 다음 시퀀스
	 * @param parameterMap
	 * @return long
	 * @throws Exception
	 */	
	public long nextval(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectOne("Common.nextval", parameterMap);
	}
	
	/**
	 * 다음 시퀀스 다건
	 * @param parameterMap
	 * @return List<Long>
	 * @throws Exception
	 */	
	public List<Long> nextvalMany(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectList("Common.nextvalMany", parameterMap);
	}
	
	/**
	 * 오늘날짜
	 * @return Object
	 * @throws Exception
	 */	
	public Object getSysdate() throws Exception {
		return getSqlSession().selectOne("Common.getSysdate");
	}
	
	/**
	 * 오늘날짜 yyyymmdd
	 * @return String
	 * @throws Exception
	 */	
	public String getSimpleSysdate() throws Exception {
		ParameterMap parameterMap = new ParameterMap();
		parameterMap.put("format", "yyyymmdd");
		return getSimpleSysdate(parameterMap);
	}
	
	/**
	 * 단순 오늘날짜 
	 * @param parameterMap
	 * @return String
	 * @throws Exception
	 */	
	public String getSimpleSysdate(ParameterMap parameterMap) throws Exception {
		return getSqlSession().selectOne("Common.getSimpleSysdate", parameterMap);
	}
	
	/*
	 * For postgresql 
	 */
	public void updateSequence(ParameterMap parameterMap) throws Exception {
		getSqlSession().update("Common.updateSequence", parameterMap);
	}
	/*
	 * SELECT LAST_INSERT_ID()
	 */
	public long nextSeq(ParameterMap parameterMap) throws Exception{
		return getSqlSession().selectOne("Common.nextSeq", parameterMap);
	}	
	
}
