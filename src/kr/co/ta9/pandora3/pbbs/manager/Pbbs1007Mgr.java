package kr.co.ta9.pandora3.pbbs.manager;

import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pbbs.dao.TbbsDocInfDao;
import kr.co.ta9.pandora3.pbbs.dao.TbbsModlInfDao;
import kr.co.ta9.pandora3.pcommon.dto.TbbsDocInf;

/**
* <pre>
* 1. 클래스명 : Pbbs1007Mgr
* 2. 설명 : 통합게시글상세조회(동영상게시판) 서비스
* 3. 작성일 : 2018-04-11
* 4.작성자   : TANINE
* </pre>
*/
@Service
public class Pbbs1007Mgr {

	@Autowired
	private TbbsDocInfDao tbbsDocInfDao;
	
	@Autowired
	private TbbsModlInfDao tbbsModlInfDao;

	@Autowired
	private PbbsCommonMgr  pbbsCommonMgr;

	/**
	 * 동영상
	 * BOARD TYPE5 : 동영상 모듈 목록 조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTbbsModlInfMovieList(ParameterMap parameterMap) throws Exception {
		return tbbsModlInfDao.selectTbbsModlInfMovieList(parameterMap);
	}

	/**
	 * 홍보영상 상세 조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject selectTbbsDocInfPvContentInfo(ParameterMap parameterMap) throws Exception {
		// 변수 선언
		JSONObject json = new JSONObject();
		ObjectMapper mapper = new ObjectMapper();

		// 홍보영상 상세 조회
		TbbsDocInf tbbsDocInf = tbbsDocInfDao.selectTbbsDocInfPvContentInfo(parameterMap);

		// OBJECT TO MAP
		Map<String, Object> tbbsDocInfMap = mapper.readValue(mapper.writeValueAsString(tbbsDocInf), new TypeReference<Map<String,Object>>(){});

		// SET RETURN
		json.put("tbbsDocInfMap", tbbsDocInfMap);
		return json;
	}

	/**
	 * 홍보영상 등록
	 * @param  parameterMap
	 * @throws Exception
	 */
	public void savePvContentInfo(ParameterMap parameterMap) throws Exception {
		// 홍보영상 등록
		TbbsDocInf tbbsDocInf = (TbbsDocInf)parameterMap.populate(TbbsDocInf.class);
		tbbsDocInf.setCts(TextUtil.removeXss(tbbsDocInf.getCts()));
		tbbsDocInf.setTitl(TextUtil.removeXss(tbbsDocInf.getTitl()));
		tbbsDocInf.setUrl_inf(TextUtil.removeXss(tbbsDocInf.getUrl_inf()));
		String chg_flag = parameterMap.getValue("chg_flag");
		if		("INSERT".equals(chg_flag)) tbbsDocInfDao.insertTbbsDocInfInfo(tbbsDocInf);
		else if	("UPDATE".equals(chg_flag)) tbbsDocInfDao.updateTbbsDocInfInfo(tbbsDocInf);

		// 파일 등록
		pbbsCommonMgr.insertFlImgInf(parameterMap);
	}

}
