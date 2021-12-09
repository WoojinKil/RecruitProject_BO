package kr.co.ta9.pandora3.api.manager;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.api.dao.BoardDao;
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
public class BoardMgr {

	@Autowired
	private BoardDao boardDao;


	/**
	 * 공지사항목록 조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public List<Map<String,Object>> selectNoticeList(ParameterMap parameterMap) throws Exception {
		return  boardDao.selectNoticeList(parameterMap);
	}
	
	/**
	 * 팝업 공지 사항 조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public List<Map<String,Object>> selectPopNotice(ParameterMap parameterMap) throws Exception {
		return  boardDao.selectPopNotice(parameterMap);
	}

	/**
	 * 공지사항 상세
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public List<Map<String,Object>> selectNoticeView(ParameterMap parameterMap) throws Exception {
		return  boardDao.selectNoticeView(parameterMap);
	}

	/**
	 * 첨부파일정보
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public List<Map<String,Object>> selectUpFileInfo(ParameterMap parameterMap) throws Exception {
		List<Map<String,Object>>listFileMap =boardDao.selectTbbsFlInfList(parameterMap);

		List<Map<String,Object>>listFileInfo =new ArrayList<Map<String,Object>>();

		 for (Map<String,Object> map : listFileMap) {
				Map<String,Object> data = new HashMap<String,Object>();
				data.put("FL_SEQ"       ,   String.valueOf(map.get("FL_SEQ")));
				data.put("ORI_FL_NM"        ,   String.valueOf(map.get("ORI_FL_NM")));
				data.put("UPL_FL_NM"         ,   String.valueOf(map.get("UPL_FL_NM")));
				data.put("FL_EXT"         ,   String.valueOf(map.get("FL_EXT")));
				data.put("FL_SIZE"           ,   String.valueOf(map.get("FL_SIZE")));
				listFileInfo.add(data);
			}
		return  listFileInfo;
	}




}
