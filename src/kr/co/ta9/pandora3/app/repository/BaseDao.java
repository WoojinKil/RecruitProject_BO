/**
* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명 : kr.co.ta9.pandora3.app.repository
* 3. 파일명 : BaseDao
* 4. 작성일 : 2017-10-27
* </pre>
*/
package kr.co.ta9.pandora3.app.repository;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.BeanUtil;

/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.app.repository
* 2. 타입명 : class
* 3. 작성일 : 2016-08-22
* 4. 설명 : 데이터를 그리드 형태로 설정
* </pre>
*/
public class BaseDao extends SqlSessionDaoSupport {
	
    @Resource(name="sqlSessionFactoryCommon")
	public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory){
	    super.setSqlSessionFactory(sqlSessionFactory);
	}
    
    @Resource(name="sqlSessionTemplateCommon")
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate){
	    super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	/**
	 * 데이터를 그리드 형태로 설정해준다
	 * @param query
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject queryForGrid(String query, ParameterMap parameterMap) throws Exception {
		List<Object> dataList = getSqlSession().selectList(query, parameterMap);
		List<Map<String,Object>> mapList = BeanUtil.convertObjectToMapList(dataList);		
		long totalCount = 0;
		int totalPage = 0;
		if (!mapList.isEmpty()) {
			totalCount = mapList.get(0).get("TOTAL_COUNT") == null? 0 : Long.valueOf(String.valueOf(mapList.get(0).get("TOTAL_COUNT")));
			totalPage = mapList.get(0).get("TOTAL_PAGE") == null? 0 : Integer.valueOf(String.valueOf(mapList.get(0).get("TOTAL_PAGE")));
		}
		
		JSONObject json = new JSONObject();		
		json.put("records", totalCount);
		json.put("total", totalPage);
		json.put("page", parameterMap.getInt("page"));
		//json.put("rows", parameterMap.getValue("rows"));
		json.put("rows", mapList);
		return json;
	}
	
	

	/**
	 * 단건 검색
	 * @param <T>
	 * @param queryId
	 * @param map
	 * @return DTO
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public <T> T selectDTO(String queryId, Map map) throws Exception {
		return (T) getSqlSession().selectOne(queryId, map);
	}
	
	/**
	 * 단건 검색
	 * @param <T>
	 * @param Class
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public <T> T selectDTO(Class<?> clazz, Map map) throws Exception {
		return (T) getSqlSession().selectOne(clazz.getSimpleName() + ".select", map);
	}

	/**
	 * 단건 검색 
	 * @param queryId
	 * @param map
	 * @return Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map selectMap(String queryId, Map map) throws Exception {
		return (Map) getSqlSession().selectOne(queryId, map);
	}
	
	/**
	 * 단건 검색 
	 * @param Class
	 * @param map
	 * @return Map
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map selectMap(Class<?> clazz, Map map) throws Exception {
		return (Map) getSqlSession().selectOne(clazz.getSimpleName() + ".selectMap", map);
	}

	
	/**
	 * 단건 추가.
	 * @param <T>
	 * @param queryId
	 * @param t
	 * @return
	 * @throws Exception
	 */
	//1안.
	public <T> int insert(String queryId, T t) throws Exception {
		return getSqlSession().insert(queryId, t);
	}
	

	
	/**
	 * 다중 추가.
	 * @param <T>
	 * @param queryId
	 * @param t
	 * @return
	 * @throws Exception
	 */
	public <T> int insertMany(String queryId, T... t) throws Exception {
		int count = 0;
		if(t != null) {
			for(T o : t) {
				count += insert(queryId, o);
			}
		}
		return count;
	}
	
	//2안
	/**
	 * 단건 추가.
	 * @param <T>
	 * @param clazz
	 * @param t
	 * @return
	 * @throws Exception
	 */
	public <T> int insert(Class<?> clazz, T t) throws Exception {
		return getSqlSession().insert(clazz.getSimpleName()+".insert", t);
	}
	
	/**
	 * 단증 추가.
	 * @param <T>
	 * @param clazz
	 * @param t
	 * @return
	 * @throws Exception
	 */
	public <T> int insertMany(Class<?> clazz, T... t) throws Exception {
		int count = 0;
		if(t != null) {
			for(T o : t) {
				count += insert(clazz, o);
			}
		}
		return count;
	}
	
	public <T> int insertMany(T... t) throws Exception {
		int count = 0;
		if(t != null) {
			for (T o : t) {
				count  += insert(o);
			}
		}
		return count;
	}
	
	//
	/**
	 * 단건 추가.
	 * @param <T>
	 * @param t
	 * @return
	 * @throws Exception
	 */
	public <T> int insert(T t) throws Exception {
		return getSqlSession().insert(t.getClass().getSimpleName()+".insert", t);
	}
	
	/**
	 * 다중 추가.
	 * @param <T>
	 * @param t
	 * @return
	 * @throws Exception
	 */
	
	
	
	
	
	/**
	 * 단건 수정
	 * @param <T>
	 * @param queryId
	 * @param t
	 * @return
	 * @throws Exception
	 */
	public <T> int update(String queryId, T t) throws Exception {
		return getSqlSession().update(queryId, t);
	}

	/**
	 * 다중 수정
	 * @param <T>
	 * @param queryId
	 * @param t
	 * @return 업데이트 수
	 * @throws Exception
	 */
	public <T> int updateMany(String queryId, T... t) throws Exception {
		int count = 0;
		if ( t != null) {
			for (T o : t) {
				count += update(queryId, o);
			}
		}
		return count;		
	}
	
	/**
	 * 단건 검색
	 * @param <T>
	 * @param clazz
	 * @param t
	 * @return
	 * @throws Exception
	 */
	public <T> int update(Class<?> clazz, T t) throws Exception {
		return getSqlSession().update(clazz.getSimpleName()+".update", t);
	}
	
	/**
	 * 
	 * @param <T>
	 * @param clazz
	 * @param t
	 * @return
	 * @throws Exception
	 */
	public <T> int updateMany(Class<?> clazz, T... t) throws Exception {
		int count = 0;
		if (t != null) {
			for (T o : t) {
				count += update(clazz, o);
			}
		}
		return count;
	}
	
	/**
	 * 단건 삭제.
	 * @param <T>
	 * @param t
	 * @return
	 * @throws Exception
	 */
	public <T> int update(T t) throws Exception {
		return getSqlSession().update(t.getClass().getSimpleName()+".update", t);
	}
	
	/**
	 * 다중 삭제.
	 * @param <T>
	 * @param t
	 * @return
	 * @throws Exception
	 */
	public <T> int updateMany(T... t) throws Exception {
		int count = 0;
		if(t != null) {
			for (T o : t) {
				count  += update(o);
			}
		}
		return count;
	}
	
	/**
	 * 단건 삭제.
	 * @param <T>
	 * @param queryId
	 * @param t
	 * @return
	 * @throws Exception
	 */
	public <T> int delete(String queryId, T t)throws Exception {
		return getSqlSession().delete(queryId, t);
	}

	/**
	 * 다중 삭제.
	 * @param <T>
	 * @param queryId
	 * @param t
	 * @return
	 * @throws Exception
	 */
	public <T> int deleteMany(String queryId, T... t) throws Exception {
		int count = 0;
		if (t != null) {
			for (T o : t) {
				count += delete(queryId, o);
			}
		}
		return count;		
	}
	
	/**
	 * 단건 삭제.
	 * @param <T>
	 * @param clazz
	 * @param t
	 * @return
	 * @throws Exception
	 */
	public <T> int delete(Class<?> clazz, T t) throws Exception {
		return getSqlSession().delete(clazz.getSimpleName()+".delete", t);
	}
	

	/**
	 * 다중 삭제.
	 * @param <T>
	 * @param clazz
	 * @param t
	 * @return
	 * @throws Exception
	 */
	public <T> int deleteMany(Class<?> clazz, T... t) throws Exception {
		int count = 0;
		if (t != null) {
			for (T o : t) {
				count += delete(clazz, o);
			}
		}
		return count;
	}
	
	/**
	 * 단건 삭제.
	 * @param <T>
	 * @param t
	 * @return
	 * @throws Exception
	 */
	public <T> int delete(T t) throws Exception {
		return getSqlSession().delete(t.getClass().getSimpleName()+".delete", t);
	}
	
	/**
	 * 다중 삭제.
	 * @param <T>
	 * @param clazz
	 * @param t
	 * @return
	 * @throws Exception
	 */
	public <T> int deleteMany(T... t) throws Exception {
		int count = 0;
		if(t != null) {
			for (T o : t) {
				count  += delete(o);
			}
		}
		return count;
	}
	
	
}
