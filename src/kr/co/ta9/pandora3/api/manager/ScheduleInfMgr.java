package kr.co.ta9.pandora3.api.manager;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.api.dao.ScheduleInfDao;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;

/**
* <pre>
* 1. 클래스명 : Pbbs1001Mgr
* 2. 설명 : 통합게시글조회
* 3. 작성일 : 2018-04-06
* 4.작성자   : TANINE
* </pre>
*/
@Service
public class ScheduleInfMgr {
	@Autowired
	private ScheduleInfDao scheduleinfoDao;

	/**
	 * 일정정보
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,Object>> selectSchedulenfList(ParameterMap parameterMap) throws Exception {
		List<Map<String,Object>>listSchMap =scheduleinfoDao.selectSchedulenfList(parameterMap);
		List<Map<String,Object>> listSchInfo = new ArrayList<Map<String,Object>>();

		 for (Map<String,Object> map : listSchMap) {
				Map<String,Object> data = new HashMap<String,Object>();
				data.put("GBN"             ,   String.valueOf(map.get("GBN")));
				data.put("SCD_SEQ"        ,   String.valueOf(map.get("SCD_SEQ")));
				data.put("SCD_NM"        ,   String.valueOf(map.get("SCD_NM")));
				data.put("ST_DTTM"         ,   String.valueOf(map.get("F_ST_DTTM")));
				data.put("ED_DTTM"           ,   String.valueOf(map.get("F_ED_DTTM")));
				data.put("SCD_CL_CD"           ,   String.valueOf(map.get("SCD_CL_CD")));
				data.put("CSTR_CD"           ,   String.valueOf(map.get("CSTR_CD")));
				data.put("CD_NM"           ,   String.valueOf(map.get("CD_NM")));
				listSchInfo.add(data);
			}
		return  listSchInfo;
	}


}
