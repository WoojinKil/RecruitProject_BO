package kr.co.ta9.pandora3.pbbs.manager;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pbbs.dao.TbbsCtegryMstDao;
import kr.co.ta9.pandora3.pbbs.dao.TbbsModlInfDao;
import kr.co.ta9.pandora3.pcommon.dto.TbbsModlInf;
import kr.co.ta9.pandora3.pcommon.dto.TdspTmplInf;

/**
* <pre>
* 1. 클래스명 : Pbbs1001Mgr
* 2. 설명 : 통합게시글조회
* 3. 작성일 : 2018-04-06
* 4.작성자   : TANINE
* </pre>
*/
@Service
public class Pbbs1001Mgr {

	@Autowired
	private TbbsModlInfDao tbbsModlInfDao;
	
	@Autowired
	private TbbsCtegryMstDao tbbsCtegryMstDao;

	/**
	 * 메뉴 맵핑여부 판단여부 조회
	 * @param  parameterMap
	 * @return String
	 * @throws Exception
	 */
	public String getTbbsModlInfId(ParameterMap parameterMap) throws Exception{
		return tbbsModlInfDao.getTbbsModlInfId(parameterMap);
	}

	/**
	 * 모듈리스트 조회 (모듈관리)
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTbbsModlInfList(ParameterMap parameterMap) throws Exception {
		return tbbsModlInfDao.selectTbbsModlInfList(parameterMap);
	}

	/**
	 * 엑셀다운로드
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject excelTbbsModlInfList(ParameterMap parameterMap) throws Exception {
		return tbbsModlInfDao.excelTbbsModlInfList(parameterMap);
	}

	/**
	 * 모듈리스트 삭제
	 * @param  parameterMap
	 * @return int
	 * @throws Exception
	 */
	public int deleteTbbsModlInfList(ParameterMap parameterMap) throws Exception {
		int result = 0;
		List<TbbsModlInf> deleteList = new ArrayList< TbbsModlInf>();
		parameterMap.populates(TbbsModlInf.class, null, null, deleteList);
//		TbbsModlInf[] delete = deleteList.toArray(new TbbsModlInf[deleteList.size()]);
		TbbsModlInf[] delete = deleteList.toArray(new TbbsModlInf[0]);

		// 모듈 매핑 템플릿 초기화
//		if(deleteList.size() > 0)  {
		if(!(deleteList.isEmpty()))  {
			List<TdspTmplInf> updateList =  new ArrayList<TdspTmplInf>();
			for(int i = 0; i < deleteList.size(); i++) {
				TdspTmplInf template = new TdspTmplInf();
				if(String.valueOf(delete[i].getTmp_seq()) != null) {
					template.setTmpl_seq(delete[i].getTmp_seq());
					template.setDel_modl_yn("Y");
					updateList.add(template);
				}
			}
//			if(updateList.size() > 0) {
			if(!(updateList.isEmpty())) {
				TdspTmplInf[] update = new TdspTmplInf[updateList.size()];
				for(int i = 0; i < updateList.size(); i++) update[i] = updateList.get(i);
				result = tbbsModlInfDao.updateMany(update);
			}
			result = result + tbbsModlInfDao.deleteMany(delete);
		}
		return result;
	}

	/**
	 * 모듈정보 등록/수정/삭제
	 * @param  parameterMap
	 * @return int
	 * @throws Exception
	 */
	public void saveTbbsModlInfInfo(ParameterMap parameterMap) throws Exception {
		List<TbbsModlInf> insertList = new ArrayList<TbbsModlInf>();
		List<TbbsModlInf> updateList = new ArrayList<TbbsModlInf>();
		List<TbbsModlInf> deleteList = new ArrayList<TbbsModlInf>();
		parameterMap.populates(TbbsModlInf.class, insertList, updateList, deleteList);

//		TbbsModlInf[] insert = insertList.toArray(new TbbsModlInf[insertList.size()]);
//		TbbsModlInf[] update = updateList.toArray(new TbbsModlInf[updateList.size()]);
//		TbbsModlInf[] delete = deleteList.toArray(new TbbsModlInf[deleteList.size()]);
		TbbsModlInf[] insert = insertList.toArray(new TbbsModlInf[0]);
		TbbsModlInf[] update = updateList.toArray(new TbbsModlInf[0]);
		TbbsModlInf[] delete = deleteList.toArray(new TbbsModlInf[0]);

		TbbsModlInf tbbsModlInf = (TbbsModlInf)parameterMap.populate(TbbsModlInf.class);
		tbbsModlInf.setModl_nm(TextUtil.removeXss(tbbsModlInf.getModl_nm()));

		tbbsModlInfDao.insertMany(insert);
		tbbsModlInfDao.updateMany(update);
		tbbsModlInfDao.deleteMany(delete);
	}

	/**
	 * 모듈정보 등록/수정
	 * @param  parameterMap
	 * @throws Exception
	 */
	public void savePbbs1001ModlInfByFlag(ParameterMap parameterMap) throws Exception {
		TbbsModlInf tbbsModlInf = (TbbsModlInf)parameterMap.populate(TbbsModlInf.class);
		tbbsModlInf.setModl_nm(TextUtil.removeXss(tbbsModlInf.getModl_nm()));

		String save_flag = parameterMap.getValue("save_flag");
		// 등록
		if("I".equals(save_flag)) {
			// 모듈정보 등록
			tbbsModlInfDao.insert(tbbsModlInf);
		}
		// 수정
		else if("U".equals(save_flag)) {
			// 모듈정보 수정
			tbbsModlInfDao.update(tbbsModlInf);
		}
	}

	/**
	 * 템플릿 매핑 정보 조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject getTbbsModlInfMappingList(ParameterMap parameterMap) throws Exception{
		return tbbsModlInfDao.selectTbbsModlInfMappingList(parameterMap);
	}

	/**
	 *
	 * @param parameterMap
	 * @return
	 */
	public JSONObject getPbbs1001SitSeq(ParameterMap parameterMap) throws Exception {
		return tbbsModlInfDao.getPbbs1001SitSeq(parameterMap);
	}


}
