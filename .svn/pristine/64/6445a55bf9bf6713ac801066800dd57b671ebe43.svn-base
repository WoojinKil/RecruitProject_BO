package kr.co.ta9.pandora3.pbbs.manager;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pbbs.dao.TmbrPtnrInfDao;
import kr.co.ta9.pandora3.pbbs.dao.TmbrPtnrInfDaoTrx;
import kr.co.ta9.pandora3.pcommon.dto.TmbrPtnrInf;

/**
* <pre>
* 1. 클래스명 : Pbbs1010Mgr
* 2. 설명 : WORK 관리 서비스
* 3. 작성일 : 2018-04-24
* 4.작성자   : TANINE
* </pre>
*/
@Service
public class Pbbs1010Mgr {

	@Autowired
	private TmbrPtnrInfDao tmbrPtnrInfDao;
	@Autowired
	private TmbrPtnrInfDaoTrx tmbrPtnrInfDaoTrx;
	@Autowired
	private Pbbs1007Mgr pbbs1007Mgr;

	@Autowired
	private PbbsCommonMgr pbbsCommonMgr;

	/**
	 * WORK 목록 조회(그리드형)
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTmbrPtnrInfGridList(ParameterMap parameterMap) throws Exception {
		return tmbrPtnrInfDao.selectTmbrPtnrInfGridList(parameterMap);
	}

	/**
	 * WORK 등록/수정
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTmbrPtnrInf(ParameterMap parameterMap) throws Exception {
		UserInfo userInfo = parameterMap.getUserInfo();
		String user_id = userInfo.getUser_id();

		// WORK 등록
		TmbrPtnrInf tmbrPtnrInf = (TmbrPtnrInf)parameterMap.populate(TmbrPtnrInf.class);
		tmbrPtnrInf.setCorp_nm(TextUtil.removeXss(tmbrPtnrInf.getCorp_nm()));
		tmbrPtnrInf.setProj_nm(TextUtil.removeXss(tmbrPtnrInf.getProj_nm()));
		tmbrPtnrInf.setSt_ym(TextUtil.removeXss(tmbrPtnrInf.getSt_ym()));
		tmbrPtnrInf.setEd_ym(TextUtil.removeXss(tmbrPtnrInf.getEd_ym()));
		tmbrPtnrInf.setPtnr_img_url(parameterMap.getValue("doc_seq"));
		tmbrPtnrInf.setCrtr_id(user_id);
		tmbrPtnrInf.setUpdr_id(user_id);

		String chg_flag = parameterMap.getValue("chg_flag");

		String hdn_del_yn = parameterMap.getValue("hdn_del_yn");
		if("Y".equals(hdn_del_yn)) {  //이미지 수정이 발생할 경우 기존 DB, 물리 파일 삭제
			pbbsCommonMgr.deleteTbbsFlInfAll(parameterMap);
		}


		if		("INSERT".equals(chg_flag)) tmbrPtnrInfDaoTrx.insertTmbrPtnrInf(tmbrPtnrInf);
		else if	("UPDATE".equals(chg_flag)) tmbrPtnrInfDaoTrx.updateTmbrPtnrInf(tmbrPtnrInf);

		// 파일 저장
		pbbsCommonMgr.insertFlImgInf(parameterMap);
	}

	/**
	 * WORK 삭제(그리드형)
	 * @param parameterMap
	 * @throws Exception
	 */
	public void deleteTmbrPtnrInfList(ParameterMap parameterMap) throws Exception {
		List<TmbrPtnrInf> deleteList = new ArrayList<TmbrPtnrInf>();

		// 삭제대상 추출
		parameterMap.populates(TmbrPtnrInf.class, null, null, deleteList);
//		TmbrPtnrInf[] delete = deleteList.toArray(new TmbrPtnrInf[deleteList.size()]);
		TmbrPtnrInf[] delete = deleteList.toArray(new TmbrPtnrInf[0]);

//		if(deleteList.size() > 0) tmbrPtnrInfDaoTrx.deleteTmbrPtnrInfMany(delete);
		if(!(deleteList.isEmpty())) tmbrPtnrInfDaoTrx.deleteTmbrPtnrInfMany(delete);
	}

	/**
	 * WORK 상세 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject selectTmbrPtnrInf(ParameterMap parameterMap) throws Exception {
		// 변수 선언
		JSONObject json = new JSONObject();
		ObjectMapper mapper = new ObjectMapper();

		// WORK 상세 조회
		TmbrPtnrInf tmbrPtnrInf = tmbrPtnrInfDao.selectTmbrPtnrInf(parameterMap);

		// OBJECT TO MAP
		Map<String, Object> tmbrPtnrInfMap = mapper.readValue(mapper.writeValueAsString(tmbrPtnrInf), new TypeReference<Map<String,Object>>(){});

		// SET RETURN
		json.put("tmbrPtnrInfMap", tmbrPtnrInfMap);

		return json;
	}

}
