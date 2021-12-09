package kr.co.ta9.pandora3.pbbs.manager;

import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pbbs.dao.Pbbs4001Dao;
import kr.co.ta9.pandora3.pcommon.dto.TbbsDocInf;

/**
* <pre>
* 1. 클래스명 : Bpcm4001Mgr
* 2. 설명 : 공지사항 
* 3. 작성일 : 2019-12-10
* 4.작성자   : KHE
* </pre>
*/
@Service
public class Pbbs4001Mgr {
	
	@Autowired
	private Pbbs4001Dao pbbs4001Dao;

	
	/**
	 * 공지사항 목록
	 * @param  parameterMap
	 * @return String
	 * @throws Exception
	 */
	public JSONObject selectNoticeList(ParameterMap parameterMap) throws Exception{

		return pbbs4001Dao.selectNoticeList(parameterMap);
	}
	
	/**
	 * 공지사항 상세
	 * @param  parameterMap
	 * @return String
	 * @throws Exception
	 */
	public JSONObject selectNoticeDtl(ParameterMap parameterMap) throws Exception{

//		return pbbs4001Dao.selectNoticeDtl(parameterMap);
		JSONObject json = new JSONObject();
		ObjectMapper mapper = new ObjectMapper();

		// 寃뚯떆�뙋 �긽�꽭湲� �젙蹂� 議고쉶
		TbbsDocInf tbbsDocInf = pbbs4001Dao.selectNoticeDtl(parameterMap);

		// OBJECT TO MAP
		Map<String, Object> bpcm4001Map = mapper.readValue(mapper.writeValueAsString(tbbsDocInf), new TypeReference<Map<String,Object>>(){});

		// REMOVE XSS
		String titl2 = String.valueOf(bpcm4001Map.get("titl2"));
		String removeXssTitle = TextUtil.removeXss(titl2);
		bpcm4001Map.put("titl2", removeXssTitle);

		String cts = String.valueOf(bpcm4001Map.get("cts"));
		String removeXssCts  = TextUtil.removeXss(cts);
		removeXssCts  = TextUtil.removeScript(removeXssCts);
		bpcm4001Map.put("cts", removeXssCts);

		// SET RETURN
		json.put("rows", bpcm4001Map);

		return json;
	}
	
	/**
	 * 카테고리 목록
	 * @param  parameterMap
	 * @return String
	 * @throws Exception
	 */
	public JSONObject selectBoardCtgList2(ParameterMap parameterMap) throws Exception{

		return pbbs4001Dao.selectBoardCtgList2(parameterMap);
	}
	
	/**
	 * 게시판 명 검색조건 조회
	 * @param  parameterMap
	 * @return String
	 * @throws Exception
	 */
	public JSONObject getModlNm(ParameterMap parameterMap) throws Exception{

		return pbbs4001Dao.getModlNm(parameterMap);
	}
	
	/**
	 * 공지사항 제목,내용 조회
	 * @param  parameterMap
	 * @return String
	 * @throws Exception
	 */
	public JSONObject getDocInfo(ParameterMap parameterMap) throws Exception{

		return pbbs4001Dao.getDocInfo(parameterMap);
	}

}
