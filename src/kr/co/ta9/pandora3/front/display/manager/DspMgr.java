package kr.co.ta9.pandora3.front.display.manager;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.BeanUtil;
import kr.co.ta9.pandora3.pcommon.dto.TdspTmplInf;
import kr.co.ta9.pandora3.pdsp.dao.TdspTmplInfDao;

/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.front.display.manager
* 2. 타입명 : class
* 3. 작성일 : 2019-03-25
* 4. 설명 : 전시 MGR
* </pre>
*/
@Service
public class DspMgr {
	
	@Autowired
	private TdspTmplInfDao tdspTmplInfDao;
	
	/**
	 * Object to Map
	 * @param  object
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	private Map<String, Object> convertObjectToMap(Object object) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Field> fields = BeanUtil.getAllDeclaredFields(object.getClass());
		for(Field field : fields) {
			field.setAccessible(true);
			result.put(field.getName(), field.get(object));
		}		
		return result;
	}
	
	/**
	 * List to List Map
	 * @param  list
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public List<Map<String, Object>> convertObjectToMapList(List list) throws Exception {
		List<Map<String, Object>> results = new ArrayList<Map<String, Object>>();
		if(list == null) return results;
		for (Object object : list) {
			results.add(convertObjectToMap(object));
		}
		return results;
	}
	
	/**
	 * 프론트 메뉴 목록 조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject selectFrntMnuList(ParameterMap parameterMap) throws Exception {
		List<TdspTmplInf> dataList = tdspTmplInfDao.selectFrntMnuList(parameterMap);
		List<Map<String, Object>> mapList = convertObjectToMapList(dataList);		
		JSONObject json = new JSONObject();		
		json.put("mapList", mapList);
		return json;
	}
	
	/**
	 * 1뎁스 메뉴 정보 조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject select1DepthMnuInf(ParameterMap parameterMap) throws Exception {
		TdspTmplInf dataInf = tdspTmplInfDao.select1DepthMnuInf(parameterMap);
		Map<String, Object> mapInf = convertObjectToMap(dataInf);		
		JSONObject json = new JSONObject();		
		json.put("mapInf", mapInf);
		return json;
	}
	
}