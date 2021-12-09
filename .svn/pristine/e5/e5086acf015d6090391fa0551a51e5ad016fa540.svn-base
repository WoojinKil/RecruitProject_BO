package kr.co.ta9.pandora3.pbbs.manager;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.conf.Config;
import kr.co.ta9.pandora3.common.util.FileUtil;
import kr.co.ta9.pandora3.pbbs.dao.TbbsDocInfDao;
import kr.co.ta9.pandora3.pbbs.dao.TbbsFlInfDao;
import kr.co.ta9.pandora3.pbbs.dao.TbbsModlInfDao;
import kr.co.ta9.pandora3.pcommon.dto.TbbsDocInf;
import kr.co.ta9.pandora3.pcommon.dto.TbbsFlInf;

/**
* <pre>
* 1. 클래스명 : Pbbs1004Mgr
* 2. 설명 : 통합게시글조회 서비스
* 3. 작성일 : 2018-04-09
* 4.작성자   : TANINE
* </pre>
*/
@Service
public class Pbbs1004Mgr {

	@Autowired
	private TbbsDocInfDao tbbsDocInfDao;
	
	@Autowired
	private TbbsFlInfDao tbbsFlInfDao;
	
	@Autowired
	private TbbsModlInfDao tbbsModlInfDao;

	/**
	 * 일반 컨텐츠
	 * BOARD : 게시글 목록 조회(그리드형)
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject getTbbsDocInfDocList(ParameterMap parameterMap) throws Exception {
		return tbbsDocInfDao.getTbbsDocInfList(parameterMap);
	}
	/**
	 * 빅데이터 포탈 공지 게시글 조회
	 * BOARD : 게시글 목록 조회(그리드형)
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject getTbbsDocInfNoticeLandingList(ParameterMap parameterMap) throws Exception {
		return tbbsDocInfDao.getTbbsDocInfNoticeLandingList(parameterMap);
	}
	
	/**
	 * 빅데이터 포탈 팝업 공지 게시글 조회
	 * BOARD : 게시글 목록 조회(그리드형)
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject getPopNotice(ParameterMap parameterMap) throws Exception {
		return tbbsDocInfDao.getPopNotice(parameterMap);
	}

	/**
	 * 일반 컨텐츠
	 * BOARD : 게시글 복원/공지전환/완전삭제(그리드형)
	 * @param  parameterMap
	 * @throws Exception
	 */
	public void saveTbbsDocInfList(ParameterMap parameterMap) throws Exception {
		List<TbbsDocInf> insertList = new ArrayList<TbbsDocInf>();
		List<TbbsDocInf> updateList = new ArrayList<TbbsDocInf>();
		List<TbbsDocInf> deleteList = new ArrayList<TbbsDocInf>();
		
		// 삭제대상 추출
		parameterMap.populates(TbbsDocInf.class, insertList, updateList, deleteList);
//		TbbsDocInf[] delete = deleteList.toArray(new TbbsDocInf[deleteList.size()]);
		TbbsDocInf[] delete = deleteList.toArray(new TbbsDocInf[0]);
		// 공지여부 및 공개설정 대상 추출
//		TbbsDocInf[] update = updateList.toArray(new TbbsDocInf[updateList.size()]);
		TbbsDocInf[] update = updateList.toArray(new TbbsDocInf[0]);
//		if(updateList.size() > 0) {
		if(!(updateList.isEmpty())) {
			tbbsDocInfDao.updateMany(update);
		}

//		if(deleteList.size() > 0) {
		if(!(deleteList.isEmpty())) {
			int result = tbbsDocInfDao.deleteMany(delete);
			if(result > 0) {
				String save_path = Config.get("app.pandora3front.file.upload.path")+ File.separator;
				String file_path = "";
				String realFileName = "";
				for(int i = 0; i < deleteList.size(); i++) {
					TbbsDocInf sd = (TbbsDocInf) deleteList.get(i);
					parameterMap.put("modl_seq", sd.getModl_seq());
					parameterMap.put("doc_seq", sd.getDoc_seq());
					List<TbbsFlInf> TbbsFlInfList = tbbsFlInfDao.selectTbbsFlInfList(parameterMap);
					for(int j = 0; j < TbbsFlInfList.size(); j++) {
						TbbsFlInf tmp = (TbbsFlInf)TbbsFlInfList.get(j);
						if(tmp.getUpl_fl_nm() != null) {
							realFileName = tmp.getUpl_fl_nm().substring(tmp.getUpl_fl_nm().lastIndexOf("/") + 1);
							file_path = save_path + File.separator +realFileName;
							FileUtil.deleteFile(file_path);
						}
					}
					tbbsDocInfDao.deleteTbbsFlInf(sd);
				}
			}
		}

	}

	/**
	 * 게시판 모듈 목록 조회
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTbbsModlInfTypeList(ParameterMap parameterMap) throws Exception {
		return tbbsModlInfDao.selectTbbsModlInfTypeList(parameterMap);
	}
	
}
