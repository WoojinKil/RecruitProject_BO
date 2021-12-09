/**
* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명 : kr.co.ta9.pandora3.system.dao
* 3. 파일명 : SysCdMstDao
* 4. 작성일 : 2016-08-22
* 5. 작성자 : tmlee
* </pre>
*/
package kr.co.ta9.pandora3.psys.dao;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import kr.co.ta9.pandora3.app.repository.BaseDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.system.dao
* 2. 타입명 : class
* 3. 작성일 : 2016-08-22
* 4. 작성자 : tmlee
* 5. 설명 : Sample 마스터 dao(조회 쿼리 호출)
* </pre>
*/
@Repository
public class SysSampleDao extends BaseDao {

	/**
	 * Sample 리스트 조회 (그리드형)
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */	
	public JSONObject selectSampleGridList(ParameterMap parameterMap, JSONObject json) throws Exception {
		if		("TYPE1".equals(parameterMap.getValue("sch_type")) || "TYPE2".equals(parameterMap.getValue("sch_type"))) json = queryForGrid("SysCdMst.selectSysCdMstGridList", parameterMap);
		return json;
	}
	
}
