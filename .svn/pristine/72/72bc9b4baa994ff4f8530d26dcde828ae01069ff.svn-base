package kr.co.ta9.pandora3.pbbs.manager;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pbbs.dao.TbbsDocInfDao;
import kr.co.ta9.pandora3.pbbs.dao.TbbsFlInfDao;
import kr.co.ta9.pandora3.pbbs.dao.TbbsModlInfDao;
import kr.co.ta9.pandora3.pcommon.dto.TbbsDocInf;

/**
* <pre>
* 1. 클래스명 : Pbbs1008Mgr
* 2. 설명 : 일반게시글등록 서비스
* 3. 작성일 : 2018-04-11
* 4.작성자   : TANINE
* </pre>
*/
@Service
public class Pbbs1008Mgr {

	@Autowired
	private TbbsDocInfDao tbbsDocInfDao;
	
	@Autowired
	private TbbsFlInfDao tbbsFlInfDao;
	
	@Autowired
	private Pbbs1007Mgr pbbs1007Mgr;

	@Autowired
	private TbbsModlInfDao tbbsMoldInfDao;

	@Autowired
	private PbbsCommonMgr pbbsCommonMgr;

	/**
	 * 일반 컨텐츠
	 * BOARD TYPE1/TYPE2 : 게시글 등록
	 * @param parameterMap
	 * @throws Exception
	 */
	public int insertTbbsDocInf(ParameterMap parameterMap) throws Exception {
		int result = 0;
		// 등록할 게시글과 매핑될 첨부파일 목록(fl_seqs)
		String[] fl_seqs = parameterMap.getValue("fl_seqs") == "" ? new String[0] : parameterMap.getValue("fl_seqs").split(",");
		parameterMap.remove("fl_seqs");

		// 등록할 게시글과 매핑될 외부컬럼 목록(exVals)
		String[] exVals = parameterMap.getValue("exVals") == "" ? new String[0] : parameterMap.getValue("exVals").split(",");
		parameterMap.remove("exVals");

		// 게시글 등록
		TbbsDocInf tbbsDocInf = (TbbsDocInf)parameterMap.populate(TbbsDocInf.class);
		tbbsDocInf.setCts(TextUtil.xss(tbbsDocInf.getCts()));
		tbbsDocInf.setTitl(TextUtil.xss(tbbsDocInf.getTitl()));
		result = tbbsDocInfDao.insertTbbsDocInfInfo(tbbsDocInf);

		// 게시글 추가정보 등록
		// 추가 컬럼 정보(추가 컬럼 정보 4개가 전부 들어왔을 때 추가)
		if("B_TYPE1".equals(parameterMap.getValue("modl_tp")) && exVals.length == 4) {
			for(int i = 0; i < exVals.length; i++) {
				tbbsDocInf.setDoc_itm_val(exVals[i]);
				tbbsDocInf.setLang_cd("ko");

				// 개별 Parameter
				if(i==0) 	  tbbsDocInf.setEid("author");
				else if(i==1) tbbsDocInf.setEid("total_page_num");
				else if(i==2) tbbsDocInf.setEid("pbl_date");
				else if(i==3) tbbsDocInf.setEid("contents_table");
				result += tbbsDocInfDao.insertTbbsDocAddItmInfInfo(tbbsDocInf);
			}
		}

		// 파일 정보 매핑
		List<HashMap<String , Object>> fl_seq_list = new ArrayList<HashMap<String , Object>>();
		for(int i=0; i < fl_seqs.length; i++) {
			HashMap<String , Object> map = new HashMap<String, Object>();
			map.put("FL_SEQ", Integer.parseInt(fl_seqs[i]));
			fl_seq_list.add(map);
		}
		parameterMap.put("fl_seq_list", fl_seq_list);

		if(fl_seqs.length > 0) tbbsFlInfDao.updateTbbsFlInfList(parameterMap);

		// 파일 저장
		//pbbsCommonMgr.insertFlImgInf(parameterMap);

		return result;
	}

	/**
	 * 게시판 정보 저장 : 등록/수정
	 * @param  parameterMap
	 * @return int
	 * @throws Exception
	 */
	public int saveTbbsDocInf(ParameterMap parameterMap) throws Exception {
		TbbsDocInf tbbsDocInf = (TbbsDocInf)parameterMap.populate(TbbsDocInf.class);
		tbbsDocInf.setCts(TextUtil.xss(tbbsDocInf.getCts()));
		tbbsDocInf.setTitl(TextUtil.xss(tbbsDocInf.getTitl()));
		int result = 0;

		String sysDocExistYn = tbbsDocInfDao.selectTbbsDocInfExistYn(parameterMap);
		// 신규
		if(Const.BOOLEAN_FALSE.equals(sysDocExistYn)) {
			// 1. 게시판 추가 컬럼 정보 저장
			String notiYn = parameterMap.getValue("notc_yn");
			if("Y".equals(notiYn)) {
				tbbsDocInf.setCd("0");
				tbbsDocInf.setDoc_itm_val("-");
			}else {
				tbbsDocInf.setCd("1");
				tbbsDocInf.setDoc_itm_val("등록완료");
			}
			tbbsDocInf.setLang_cd("ko");
			result = tbbsDocInfDao.insertTbbsDocAddItmInfInfo(tbbsDocInf);

			// 2. 게시판 정보 저장
			result += tbbsDocInfDao.insertTbbsDocInfInfo(tbbsDocInf);
		}
		// 수정
		else {
			// 1. 게시판 정보 갱신
			result += tbbsDocInfDao.updateTbbsDocInfInfo(tbbsDocInf);
		}

		return result;
	}

	//getCtgInfo


	/**
	 * 모듈별카테고리 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject getCtgInfo(ParameterMap parameterMap) throws Exception {
		return tbbsDocInfDao.getCtgInfo(parameterMap);
	}


	/**
	 * 시스템별게시판 목록 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTbbsModlInfCommonList(ParameterMap parameterMap) throws Exception {
		return tbbsMoldInfDao.selectTbbsModlInfCommonList(parameterMap);
	}

}
