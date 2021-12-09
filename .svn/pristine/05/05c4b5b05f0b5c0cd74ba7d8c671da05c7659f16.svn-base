package kr.co.ta9.pandora3.pbbs.manager;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pbbs.dao.TbbsDocInfDao;
import kr.co.ta9.pandora3.pbbs.dao.TbbsFlInfDao;
import kr.co.ta9.pandora3.pbbs.dao.TbbsQaCmtInfDao;
import kr.co.ta9.pandora3.pbbs.dao.TbbsQaCmtInfDaoTrx;
import kr.co.ta9.pandora3.pcommon.dto.TbbsDocInf;
import kr.co.ta9.pandora3.pcommon.dto.TbbsQaCmtInf;

/**
* <pre>
* 1. 클래스명 : Pbbs1006Mgr
* 2. 설명 : 통합게시글상세조회(QA게시판) 서비스
* 3. 작성일 : 2018-04-11
* 4.작성자   : TANINE
* </pre>
*/
@Service
public class Pbbs1006Mgr {

	@Autowired
	private TbbsDocInfDao tbbsDocInfDao;
	@Autowired
	private TbbsQaCmtInfDao tbbsQaCmtInfDao;
	@Autowired
	private TbbsQaCmtInfDaoTrx tbbsQaCmtInfDaoTrx;

	@Autowired
	private TbbsFlInfDao tbbsFlInfDao;



	/**
	 * BOARD TYPE3 : 질문답변형 게시판 상세 조회(질문)
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject selectTbbsDocInfType3View(ParameterMap parameterMap) throws Exception {
		// 변수 선언
		JSONObject json = new JSONObject();
		ObjectMapper mapper = new ObjectMapper();

		// 게시판 상세글 정보 조회
		TbbsDocInf tbbsDocInf = tbbsDocInfDao.selectTbbsDocInfType3View(parameterMap);

		// OBJECT TO MAP
		Map<String, Object> tbbsDocInfMap = mapper.readValue(mapper.writeValueAsString(tbbsDocInf), new TypeReference<Map<String,Object>>(){});

		// REMOVE XSS
		String titl = String.valueOf(tbbsDocInfMap.get("titl"));
		String removeXssTitle = TextUtil.removeXss(titl);
		tbbsDocInfMap.put("titl", removeXssTitle);

		String cts = String.valueOf(tbbsDocInfMap.get("cts"));
		String removeXssCts  = TextUtil.removeXss(cts);
		removeXssCts  = TextUtil.removeScript(removeXssCts);
		tbbsDocInfMap.put("cts", removeXssCts);

		// SET RETURN
		json.put("tbbsDocInfMap", tbbsDocInfMap);

		return json;
	}

	/**
	 * BOARD TYPE3 : 질문답변형 게시판 상세 조회(답변 목록)
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject selectTbbsQaCmtInfGridList(ParameterMap parameterMap) throws Exception {
		return tbbsQaCmtInfDao.selectTbbsQaCmtInfGridList(parameterMap);
	}

	/**
	 * BOARD TYPE3 : 질문답변형 게시판 답변 삭제(B/O)
	 * @param  parameterMap
	 * @return int
	 * @throws Exception
	 */
	public int deleteTbbsQaCmtInfGridList(ParameterMap parameterMap) throws Exception {
		List<TbbsQaCmtInf> insertList = new ArrayList<TbbsQaCmtInf>();
		List<TbbsQaCmtInf> updateList = new ArrayList<TbbsQaCmtInf>();
		List<TbbsQaCmtInf> deleteList = new ArrayList<TbbsQaCmtInf>();

		parameterMap.populates(TbbsQaCmtInf.class, insertList, updateList, deleteList);
//		TbbsQaCmtInf[] delete = deleteList.toArray(new TbbsQaCmtInf[deleteList.size()]);
		TbbsQaCmtInf[] delete = deleteList.toArray(new TbbsQaCmtInf[0]);

		return tbbsQaCmtInfDaoTrx.deleteMany(delete);
	}

	/**
	 * BOARD TYPE3 : 질문답변형 게시판 상세 조회(답변 - 단건)
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject selectTbbsQaCmtInfInfo(ParameterMap parameterMap) throws Exception {
		// 변수 선언
		JSONObject json = new JSONObject();
		ObjectMapper mapper = new ObjectMapper();

		// 게시판 상세글(TYPE3 - 답변) 정보 조회
		TbbsQaCmtInf tbbsQaCmtInf = tbbsQaCmtInfDao.selectTbbsQaCmtInfInfo(parameterMap);

		// OBJECT TO MAP
		Map<String, Object> tbbsQaCmtInfMap = mapper.readValue(mapper.writeValueAsString(tbbsQaCmtInf), new TypeReference<Map<String,Object>>(){});

		// REMOVE XSS
		String cts = String.valueOf(tbbsQaCmtInfMap.get("cts"));
		String removeXssTitle = TextUtil.removeXss(cts);
		tbbsQaCmtInfMap.put("cts", removeXssTitle);

		// SET RETURN
		json.put("tbbsQaCmtInfMap", tbbsQaCmtInfMap);

		return json;
	}


	/**
	 * BOARD TYPE3 : 질문답변형 게시판 상세 조회(답변 - 단건)
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object>  selectTbbsQaCmtInfInfoMap(ParameterMap parameterMap) throws Exception {
		// 변수 선언
		//JSONObject json = new JSONObject();
		ObjectMapper mapper = new ObjectMapper();

		// 게시판 상세글(TYPE3 - 답변) 정보 조회
		TbbsQaCmtInf tbbsQaCmtInf = tbbsQaCmtInfDao.selectTbbsQaCmtInfInfo(parameterMap);

		// OBJECT TO MAP
		Map<String, Object> tbbsQaCmtInfMap = mapper.readValue(mapper.writeValueAsString(tbbsQaCmtInf), new TypeReference<Map<String,Object>>(){});

		if(tbbsQaCmtInfMap != null && !tbbsQaCmtInfMap.isEmpty()){
			// REMOVE XSS
			String cts = String.valueOf(tbbsQaCmtInfMap.get("cts"));
			String removeXssTitle = TextUtil.removeXss(cts);
			tbbsQaCmtInfMap.put("cts", removeXssTitle);
		}

		return tbbsQaCmtInfMap;
	}

	/**
	 * BOARD TYPE3 : 질문답변형 게시판 답변등록/수정(B/O)
	 * @param  parameterMap
	 * @return int
	 * @throws Exception
	 */
	public int insertTbbsQaCmtInf(ParameterMap parameterMap) throws Exception {
		String[] fl_seqs = parameterMap.getValue("fl_seqs") == "" ? new String[0] : parameterMap.getValue("fl_seqs").split(",");
		parameterMap.remove("fl_seqs");

		TbbsQaCmtInf tbbsQaCmtInf = (TbbsQaCmtInf)parameterMap.populate(TbbsQaCmtInf.class);
		tbbsQaCmtInf.setCts(TextUtil.xss(tbbsQaCmtInf.getCts()));


		int result = 0;

		// 로그인 유저 IP 설정
		UserInfo userInfo = parameterMap.getUserInfo();
		String user_id = userInfo.getUser_id();
		if(userInfo!=null && !"".equals(user_id)) {
			String ip_addr = userInfo.getLast_access_ip_addr();
			String lgn_id = userInfo.getLogin_id();
			tbbsQaCmtInf.setIp_addr(ip_addr);
			tbbsQaCmtInf.setLgn_id(lgn_id);
		}

		// 게시글 존재여부 : Y일때만 답글 갱신
		String sysDocExistYn = tbbsDocInfDao.selectTbbsDocInfExistYn(parameterMap);
		if("Y".equals(sysDocExistYn)) {
			// 1. 게시판 추가 컬럼 정보 갱신(BoardType3 : proc_cd)
			String proc_cd = parameterMap.getValue("proc_cd");
			if(StringUtils.isNotEmpty(proc_cd)) {
				TbbsDocInf tbbsDocInf = new TbbsDocInf();
				String treatment = "";
				if("1".equals(proc_cd))		 treatment = "등록완료";
				else if("2".equals(proc_cd)) treatment = "답변준비중";
				else if("3".equals(proc_cd)) treatment = "답변완료";
				tbbsDocInf.setCd(proc_cd);
				tbbsDocInf.setDoc_itm_val(treatment);
				if(StringUtils.isNotEmpty(parameterMap.getValue("doc_seq"))) tbbsDocInf.setDoc_seq(Integer.parseInt(parameterMap.getValue("doc_seq")));
				if(StringUtils.isNotEmpty(parameterMap.getValue("modl_seq"))) tbbsDocInf.setModl_seq(Integer.parseInt(parameterMap.getValue("modl_seq")));
				result += tbbsDocInfDao.updateTbbsDocAddItmInfInfo(tbbsDocInf);
			}
			if(StringUtils.isNotEmpty(tbbsQaCmtInf.getCts())) {
				// 2. 게시물 정보(답변 글) 저장
				String cmt_seq = parameterMap.getValue("cmt_seq");
				int tmp_cmt_seq=0;
				if(StringUtils.isNotEmpty(cmt_seq)) {
					result += tbbsQaCmtInfDaoTrx.update(tbbsQaCmtInf);
				}else {
					result += tbbsQaCmtInfDaoTrx.insertQaCmtInf(tbbsQaCmtInf);
					tmp_cmt_seq =tbbsQaCmtInf.getCmt_seq();
					cmt_seq = String.valueOf(tmp_cmt_seq);
				}

				// 파일 정보 매핑
				List<HashMap<String , Object>> fl_seq_list = new ArrayList<HashMap<String , Object>>();
				for(int i=0; i < fl_seqs.length; i++) {
					HashMap<String , Object> map = new HashMap<String, Object>();
					map.put("FL_SEQ", Integer.parseInt(fl_seqs[i]));
					fl_seq_list.add(map);
				}
				String modlSeq ="";
				String docSeq ="";
				if(StringUtils.isNotEmpty(parameterMap.getValue("doc_seq"))) docSeq =parameterMap.getValue("doc_seq");
				if(StringUtils.isNotEmpty(parameterMap.getValue("modl_seq"))) modlSeq = parameterMap.getValue("modl_seq");
				parameterMap.put("fl_seq_list", fl_seq_list);
				parameterMap.put("modl_seq", modlSeq);
				parameterMap.put("doc_seq", docSeq);
				parameterMap.put("cmt_seq", cmt_seq);

				if(fl_seqs.length > 0) tbbsFlInfDao.updateTbbsFlInfQaCmtList(parameterMap);
			}
		}

		return result;
	}

}
