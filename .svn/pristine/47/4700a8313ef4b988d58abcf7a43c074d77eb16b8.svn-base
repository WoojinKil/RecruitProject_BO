package kr.co.ta9.pandora3.pbbs.manager;

import java.util.List;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.conf.AppConst;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pbbs.dao.TbbsCtegryDtlDao;
import kr.co.ta9.pandora3.pbbs.dao.TbbsDocInfDao;
import kr.co.ta9.pandora3.pcommon.dto.TbbsDocInf;

/**
* <pre>
* 1. 클래스명 : Pbbs1005Mgr
* 2. 설명 : 통합게시글상세조회(일반게시판) 서비스
* 3. 작성일 : 2018-04-11
* 4.작성자   : TANINE
* </pre>
*/
@Service
public class Pbbs1005Mgr {

	@Autowired
	private TbbsDocInfDao tbbsDocInfDao;
	@Autowired
	private PbbsCommonMgr pbbsCommonMgr;
	@Autowired
	private TbbsCtegryDtlDao tbbsCtegryDtlDao;

	/**
	 * 일반 컨텐츠
	 * BOARD TYPE1/TYPE2 : 게시글 상세
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject getTbbsDocInfDtl(ParameterMap parameterMap) throws Exception {
		// 변수 선언
		TbbsDocInf tbbsDocInf = new TbbsDocInf();
		JSONObject json = new JSONObject();
		ObjectMapper mapper = new ObjectMapper();

		parameterMap.put("sys_cd", AppConst.SYS_CD);

		if		("B_TYPE1".equals(parameterMap.getValue("modl_tp"))) tbbsDocInf = tbbsDocInfDao.selectTbbsDocInfType1View(parameterMap);
		else if	("B_TYPE2".equals(parameterMap.getValue("modl_tp")) ||
				 "B_TYPE4".equals(parameterMap.getValue("modl_tp")) ||
				 "B_TYPE6".equals(parameterMap.getValue("modl_tp"))) tbbsDocInf = tbbsDocInfDao.selectTbbsDocInfType2View(parameterMap);

		// OBJECT TO MAP
		tbbsDocInf.setTitl(TextUtil.removeXss(tbbsDocInf.getTitl()));
		tbbsDocInf.setCts(TextUtil.removeXss(tbbsDocInf.getCts()));
		Map<String, Object> tbbsDocInfMap = mapper.readValue(mapper.writeValueAsString(tbbsDocInf), new TypeReference<Map<String,Object>>(){});
		// SET RETURN
		json.put("tbbsDocInfMap", tbbsDocInfMap);

		return json;
	}

	/**
	 * 일반 컨텐츠
	 * BOARD TYPE1/TYPE2 : 게시글 수정
	 * @param  parameterMap
	 * @throws Exception
	 */
	public void updateTbbsDocInf(ParameterMap parameterMap) throws Exception {
		// 등록할 게시글과 매핑될 외부컬럼 목록(exVals)
		String[] exVals = parameterMap.getValue("exVals").split(",");
		parameterMap.remove("exVals[]");

		TbbsDocInf tbbsDocInf = (TbbsDocInf)parameterMap.populate(TbbsDocInf.class);
		tbbsDocInf.setCts(TextUtil.xss(tbbsDocInf.getCts()));
		tbbsDocInf.setTitl(TextUtil.xss(tbbsDocInf.getTitl()));
		tbbsDocInf.setDoc_seq(Integer.parseInt(parameterMap.getValue("doc_seq")));

		// 게시판 정보 수정(공통)
		tbbsDocInfDao.updateTbbsDocInfInfo(tbbsDocInf);

		// 게시판 정보 수정(추가 컬럼)
		// 추가 컬럼 정보(추가 컬럼 정보 4개가 전부 들어왔을 때 추가)
		if("B_TYPE1".equals(parameterMap.getValue("modl_tp")) && exVals.length == 4) {
			for(int i = 0; i < exVals.length; i++) {
				tbbsDocInf.setDoc_itm_val(exVals[i]);
				tbbsDocInf.setLang_cd("ko");

				// 개별 Parameter
				if(i == 0) 	    tbbsDocInf.setEid("author");
				else if(i == 1) tbbsDocInf.setEid("total_page_num");
				else if(i == 2) tbbsDocInf.setEid("pbl_date");
				else if(i == 3) tbbsDocInf.setEid("contents_table");

				tbbsDocInfDao.updateTbbsDocAddItmInfInfo(tbbsDocInf);
			}
		}

		// 파일 변경 플래그
//		boolean newFileFlag = Boolean.parseBoolean(parameterMap.getValue("newFileFlag"));
//		if(newFileFlag) {
//			// 기존 썸네일 삭제
//			tbbsDocInfDaoTrx.deleteTbbsFlInfThumbnailFile(tbbsDocInf);
//
//			// 썸네일 저장
//			pbbsCommonMgr.insertFlImgInf(parameterMap);
//		}
	}

	public List<Map> selectTbbsCtegryDtlList(ParameterMap parameterMap) throws Exception {
		return tbbsCtegryDtlDao.selectTbbsCtegryDtlList(parameterMap);
	}

}
