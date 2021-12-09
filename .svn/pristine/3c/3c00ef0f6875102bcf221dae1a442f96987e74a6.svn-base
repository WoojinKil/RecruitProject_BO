package kr.co.ta9.pandora3.psys.manager;

import java.lang.reflect.Field;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.BeanUtil;
import kr.co.ta9.pandora3.pcommon.dto.usrdef.TsysOrgTree;
import kr.co.ta9.pandora3.psys.dao.TsysOrgDao;

/**
* <pre>
* 1. 클래스명 : Psys1040Mgr
* 2. 설명 : 직무 관리 서비스
* 3. 작성일 : 2019-11-04
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Psys1043Mgr {

	@Autowired
	private TsysOrgDao tsysOrgDao;


	/**
	 * 코드 관리 > 조직 트리 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTsysOrgTree(ParameterMap parameterMap) throws Exception {

		List<TsysOrgTree> list = tsysOrgDao.selectTsysOrgTree(parameterMap);

		List<Map<String,Object>> results = new ArrayList<Map<String,Object>>();

		for (Object object : list) {

			Map<String,Object> result = new HashMap<String,Object>();
			List<Field> fields = BeanUtil.getAllDeclaredFields(object.getClass());
			for (Field field : fields) {
				field.setAccessible(true);
				if (field.get(object) instanceof Timestamp) {
					Timestamp time = (Timestamp)field.get(object);
					result.put(field.getName(), time.getTime());
				}
				else {
					result.put(field.getName(), field.get(object));
				}
			}
			results.add(result);

		}

		JSONObject json = new JSONObject();
		json.put("rows", results);

		return json;
	}



}

