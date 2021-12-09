package kr.co.ta9.pandora3.pbbs.manager;

import java.io.File;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.util.S3FileUtil;
import kr.co.ta9.pandora3.common.conf.Configuration;
import kr.co.ta9.pandora3.common.servlet.upload.UploadFile;
import kr.co.ta9.pandora3.common.util.BeanUtil;
import kr.co.ta9.pandora3.common.util.DateUtil;
import kr.co.ta9.pandora3.common.util.FileUtil;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pbbs.dao.TbbsWikiFlInfDao;
import kr.co.ta9.pandora3.pbbs.dao.TbbsWikiCtegryDao;
import kr.co.ta9.pandora3.pbbs.dao.TbbsWikiDocInfDao;
import kr.co.ta9.pandora3.pcommon.dto.Pbbs5001VO;

/**
* <pre>
* 1. 클래스명 : Pbbs5001Mgr
* 2. 설명 : 위키관리(*TODO_CHG_NM) 서비스
* 3. 작성일 : 2020-04-06
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Pbbs5001Mgr {

	//private final Log log = LogFactory.getLog(Pbbs5001Mgr.class);

	@Autowired
	private TbbsWikiCtegryDao tbbsWikiCtegryDao;       //위키카테고리정보
	
	@Autowired
	private TbbsWikiDocInfDao tbbsWikiDocInfDao;       //위키게시글정보
	
	@Autowired
	private TbbsWikiFlInfDao tbbsWikiFlInfDao; //위키첨부파일 정보

	/**
	 * 위키 트리조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject getPbbs5001List01(ParameterMap parameterMap) throws Exception {
		List<Map<String, Object>> mapList = tbbsWikiCtegryDao.getPbbs5001List01(parameterMap);
		JSONObject json = new JSONObject();
		json.put("mapList", mapList);
		return json;
	}

	/**
	 * 위키 카테고리 트리 삭제 (하위TREE 포함)
	 * @param parameterMap
	 * @throws Exception
	 */
	public void deletePbbs5001List01(ParameterMap parameterMap) throws Exception {
		//삭제 대상 확인
		List<Map<String, Object>> mapList = tbbsWikiCtegryDao.getPbbs5001List02(parameterMap);
		//삭제 대상이 있으면 삭제 시작
		if (!mapList.isEmpty()) {
			//삭제대상용 파라미터 생성
			List<Integer> wiki_ctegry_seq_list = new ArrayList<Integer>();
			for (Map<String, Object> map: mapList) {
				Object obj = map.get("wiki_ctegry_seq");
				if (obj != null) {
					wiki_ctegry_seq_list.add(Integer.valueOf(obj.toString()));
				}
			}
			parameterMap.put("wiki_ctegry_seq_list", wiki_ctegry_seq_list);
			//위키 카테고리 복수 삭제
			tbbsWikiCtegryDao.deletePbbs5001List01(parameterMap);
		}
	}

	/**
	 * 위키 트리 등록/수정
	 * @param parameterMap
	 * @return rtn_wiki_ctegry_seq : 등록/수정된 최상위 wiki_ctegry_seq
	 * @throws Exception
	 */
	public int savePbbs5001List01(ParameterMap parameterMap) throws Exception {
		//반환용 결과 Map 선언
		int rtn_wiki_ctegry_seq = -1;
		//파라미터로 받은 카테고리 CD
		String p_wiki_ctegry_seq = parameterMap.getValue("wiki_ctegry_seq");
		//파라미터로 받은 카테고리 CD가 없으면, 등록
		if (StringUtils.isEmpty(p_wiki_ctegry_seq)) {
			//신규 등록할 카테고리 CD 취득
			int wiki_ctegry_seq = tbbsWikiCtegryDao.getPbbs5001CtegryCd();
			//신규 카테고리CD 입력
			parameterMap.put("wiki_ctegry_seq", wiki_ctegry_seq);
			//신규 카테고리 등록
			tbbsWikiCtegryDao.insertPbbs5001One(parameterMap);
			//정상 저장 시 return 값 교체
			rtn_wiki_ctegry_seq = wiki_ctegry_seq;
		//파라미터가 있으면 수정
		} else {
			//카테고리 수정
			tbbsWikiCtegryDao.updatePbbs5001One(parameterMap);

			//카테고리 수정 가운데 카테고리 사용여부가 "N"인 경우 하위 카테고리까지 "N"으로 일괄 변경
			String us_yn = parameterMap.getValue("us_yn");
			if ("N".equals(us_yn)) {
				//하위 카테고리 수정대상 확인 (사용여부)
				parameterMap.put("id", p_wiki_ctegry_seq);
				List<Map<String, Object>> mapList = tbbsWikiCtegryDao.getPbbs5001List03(parameterMap);
				if (!mapList.isEmpty()) {
					//삭제대상용 파라미터 생성
					List<Integer> wiki_ctegry_seq_list = new ArrayList<Integer>();
					for (Map<String, Object> map: mapList) {
						Object obj = map.get("wiki_ctegry_seq");
						if (obj != null) {
							wiki_ctegry_seq_list.add(Integer.valueOf(obj.toString()));
						}
					}
					parameterMap.put("wiki_ctegry_seq_list", wiki_ctegry_seq_list);
					//위키 카테고리 복수 수정
					tbbsWikiCtegryDao.updatePbbs5001List01(parameterMap);
				}
			}

			//정상 저장 시 return 값 교체
			rtn_wiki_ctegry_seq = Integer.parseInt(p_wiki_ctegry_seq);
		}

		return rtn_wiki_ctegry_seq;
	}

	/**
	 * 위키 카테고리 별 게시글 목록 조회
	 * @param parameterMap
	 * @return
	 */
	public JSONObject getPbbs5001GridList01(ParameterMap parameterMap) throws Exception {
		return tbbsWikiDocInfDao.getPbbs5001GridList01(parameterMap);
	}

	/**
	 * 위키 메뉴얼 등록 /수정
	 * - 등록 : 메뉴얼 등록 + 첨부파일 매핑
	 * - 수정 : 메뉴얼 수정
	 * @param parameterMap
	 * @return 등록/수정된 게시글 Srno
	 * @throws Exception
	 */
	public int savePbbs5002WikiAll(ParameterMap parameterMap)throws Exception{
		//반환용 등록/수정된 게시글 Srno
		int rtnBbsSrno = -1;

		//1. 위키 게시글 레코드 등록
		String p_wiki_doc_seq = parameterMap.getValue("wiki_doc_seq");
		//파라미터로 받은 bbs_snro가 없으면, 등록
		if (StringUtils.isEmpty(p_wiki_doc_seq)) {
			//1-1. 위키 게시글 등록용 wiki_doc_seq 취득
			int wiki_doc_seq = tbbsWikiDocInfDao.getPbbs5002BbsSrno();
			//신규 bbs_snro 입력
			parameterMap.put("wiki_doc_seq", wiki_doc_seq);
			//1-2. 신규 wiki_doc_seq 등록
			int rtnCnt = tbbsWikiDocInfDao.insertPbbs5002One(parameterMap);

			//정상 등록 처리가 될 경우,
			if (rtnCnt > 0) {
				//등록할 게시글과 매핑될 첨부파일 목록(wiki_fl_seq_arr)
				String[] wiki_fl_seq_arr = parameterMap.getArray("wiki_fl_seq_arr[]");
				List<String> wiki_fl_seq_list = new ArrayList<String>();
				//첨부파일 파라미터 설정
				for (String wiki_fl_seq: wiki_fl_seq_arr) wiki_fl_seq_list.add(wiki_fl_seq);
				//첨부파일이 한개이상 있으면 매핑
				if (!wiki_fl_seq_list.isEmpty()) {
					parameterMap.put("wiki_fl_seq_list", wiki_fl_seq_list);
					//1-3. 첨부파일 매핑관계 확인 및 갱신
					tbbsWikiFlInfDao.updatePbbs5002FleMapping(parameterMap);
				}

				//파일 매핑까지 완료되면 반환값 설정
				rtnBbsSrno = wiki_doc_seq;
			}
		//2. 위키 게시글 레코드 수정
		} else {
			//위키 게시글 레코드 수정 처리 진행
			tbbsWikiDocInfDao.updatePbbs5002One(parameterMap);
			//수정처리가 진행되면, 반환값 설정
			rtnBbsSrno = Integer.parseInt(p_wiki_doc_seq);
		}

		return rtnBbsSrno;
	}

	//[2020.04.09] 첨부파일 업로드용 변수 선언
	private Configuration configuration = Configuration.getInstance();
	private String s3Url = configuration.get("app.amazone.s3.url");
	private String bucketName = configuration.get("app.s3path.bdp.bucketName");
	private String accessKey  = configuration.get("app.s3path.bdp.accessKey");
	private String secretKey  = configuration.get("app.s3path.bdp.secretKey");
	private String basePath = configuration.get("app.s3path.bdp.upload.path");
	private String target = configuration.get("properties.target");

	/**
	 * 위키 메뉴얼 첨부 파일등록
	 * @param  parameterMap
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	public List<Map<String, Object>> insertPbbs5002Wikibbsfle(ParameterMap parameterMap) throws Exception {
		//파일 첨부 결과 return용 리스트 선언
		List<Map<String, Object>> retTbbsFlInfList = new ArrayList<Map<String, Object>>();

		//첨부파일 매핑 대상 메뉴얼 확인
		int wiki_doc_seq = parameterMap.getInt("wiki_doc_seq");
		UserInfo userInfo = parameterMap.getUserInfo();

		if(userInfo != null){
			//업로드 대상 파일 취득
			UploadFile[] uploadFiles = parameterMap.getUploadFiles("files");
			if (uploadFiles != null) {
				//파일명 구분자
				String separator = "_";
				//Insert용 파라미터 맵
				ParameterMap sqlParameterMap = new ParameterMap();
				sqlParameterMap.put("crtr_id", parameterMap.getValue("crtr_id"));
				sqlParameterMap.put("updr_id", parameterMap.getValue("updr_id"));

				//위키 메뉴얼 화면용 추가정보(엘리먼트 체크용 아이디 )
				String[] fileChkArr = parameterMap.getValue("fileChkArr").split(",");

				//대상 파일 확인
				for (int i = 0; i < uploadFiles.length; i++) {
					//원본 파일명
					String orgn_fl_nm = uploadFiles[i].getOriginalFilename();
					orgn_fl_nm = orgn_fl_nm.substring(orgn_fl_nm.lastIndexOf("\\")+1);
					//업로드용 파일명 (파일명 중복 방지)
					String chg_source_filename = new StringBuilder().append(DateUtil.today("yyyyMMddHHmmssSSS")).append(separator).append(orgn_fl_nm).toString();
					//파일 사이즈
					String fl_size = String.valueOf((int)uploadFiles[i].getSize());
					//파일 확장자
					String file_ext = uploadFiles[i].getExtension();
					//S3 업로드용 경로 생성
					String s3FileNm ="";
					if ("local".equals(target)) {
						s3FileNm = s3Url +bucketName+basePath+"/"+ chg_source_filename;
					} else {
						basePath =configuration.get("app.s3info.bdp.upload.path");
						bucketName = configuration.get("app.s3info.bdp.bucketName");
						s3FileNm = s3Url +bucketName+"/"+basePath+"/"+ chg_source_filename;
					}
					//Insert용 Key 취득
					int wiki_fl_seq = tbbsWikiFlInfDao.getPbbs5002BbsAtchFleSrno();
					//Insert 파라미터 설정
					sqlParameterMap.put("wiki_fl_seq", wiki_fl_seq);
					sqlParameterMap.put("wiki_doc_seq"         , wiki_doc_seq);
					sqlParameterMap.put("orgn_fl_nm"      , orgn_fl_nm);
					sqlParameterMap.put("atch_fl_pth_nm" , s3FileNm);
					sqlParameterMap.put("fl_size"     , fl_size);
					sqlParameterMap.put("atch_fl_tp_cd"   , null);
					//위키 첨부파일 Insert
					int result = tbbsWikiFlInfDao.insert(sqlParameterMap);

					//Insert 성공시  파일 업로드
					if(result > 0) {
						//리턴용 리스트 요소 작성
						Map<String, Object> fileSrlMap = new HashMap<String, Object>();
						fileSrlMap.put("file_srl" , wiki_fl_seq);
						fileSrlMap.put("file_nm"  , orgn_fl_nm);
						fileSrlMap.put("file_path", s3FileNm);
						fileSrlMap.put("file_ext" , file_ext);
						fileSrlMap.put("file_id"  , fileChkArr[i]);
						retTbbsFlInfList.add(fileSrlMap);

						//파일 업로드
						int[] types = {UploadFile.NONE};
						uploadFiles[i].addTypes(types);
						uploadFiles[i].transferTo(configuration.get("app.pandora3front.file.upload.path"), chg_source_filename);
						String img_path =configuration.get("app.pandora3front.file.upload.path")+"/"+ chg_source_filename;
						S3FileUtil fileUtil = new S3FileUtil();
						File s3UploadFile = new File(img_path);
						if(s3UploadFile.exists() && !s3UploadFile.isDirectory()){
							if("local".equals(target)){  //target이 로컬이면 key방식
								fileUtil.fileUploadS3(bucketName, accessKey, secretKey, basePath, img_path, chg_source_filename);
							}else{ //그렇지 않으면 롤방식
								fileUtil.s3UploadRol(bucketName, basePath, img_path, chg_source_filename);
							}
							FileUtil.deleteFile(img_path);
						}
					}
				}
			}
		}
		return retTbbsFlInfList;
	}

	/**
	 * 위키 메뉴얼 첨부 파일 삭제
	 * @param  parameterMap
	 * @return int
	 * @throws Exception
	 */
	public int deletePbbs5002Wikibbsfle(ParameterMap parameterMap) throws Exception {
		return tbbsWikiFlInfDao.delete(parameterMap);
	}

	/**
	 * 위키트리  카테고리/명 조회
	 * @param parameterMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public JSONObject getPbbs5002List01(ParameterMap parameterMap) throws Exception {
		List<Map<String, Object>> mapList = tbbsWikiCtegryDao.getPbbs5002List01(parameterMap);
		JSONObject json = new JSONObject();
		json.put("mapList", mapList);
		return json;
	}

	/**
	 * 위키 메뉴얼 상세 정보 조회 (첨부파일 포함)
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject getWikibbsAndFleInfo(ParameterMap parameterMap) throws Exception {
		//Return용 Json 선언
		JSONObject json = new JSONObject();

		//메뉴얼 게시글 정보 조회
		Map<String, Object> bbsInfo = tbbsWikiDocInfDao.getPbbs5003BbsOne(parameterMap);
		if (bbsInfo != null) {
			// XSS 변환 처리 : 제목
			if (bbsInfo.get("wiki_titl_nm") != null) {
				bbsInfo.put("wiki_titl_nm", TextUtil.removeXss(String.valueOf(bbsInfo.get("wiki_titl_nm"))));
			}
			// XSS 변환 처리 : 내용
			if (bbsInfo.get("wiki_cts") != null) {
				bbsInfo.put("wiki_cts", TextUtil.removeXss(String.valueOf(bbsInfo.get("wiki_cts"))));
			}
			json.put("bbsInfo", bbsInfo);
		}

		//위키 wiki_doc_seq 기준 첨부파일이 있는지 확인
		List<Map<String, Object>> files = tbbsWikiFlInfDao.getPbbs5003Bbsfiles(parameterMap);
		//첨부파일 정보가 있으면 설정
		if (!files.isEmpty()) {
			//메뉴얼 첨부파일 정보
			json.put("files", files);
		}

		return json;
	}

	/**
	 * 위키 메뉴얼 상세 정보 조회 (첨부파일 포함)
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject getWikibbsFrontDtl(ParameterMap parameterMap) throws Exception {
		//Return용 Json 선언
		JSONObject json = new JSONObject();

		//검색 keyword
		String keyword = parameterMap.getValue("keyword");
		//키워드가 있는 경우
		if (!StringUtils.isEmpty(keyword)) {
			List<String> keyword_list = new ArrayList<String>();
			//키워드 " " 기준으로 분할
			String[] keyword_arr = keyword.split(" ", -1);
			for (String word : keyword_arr) {
				//키워드가 완전 공백이 아니면서, 중복되지 않은 경우만 검색어로 추가
				if (!StringUtils.isEmpty(word) && !keyword_list.contains(word)) {
					keyword_list.add(word);
				}
			}
			if (!keyword_list.isEmpty()) {
				parameterMap.put("keyword_list", keyword_list);
				//분할된 키워드 목록 설정
				json.put("keyword_list", keyword_list);
			}
		}

		//메뉴얼 게시글 정보 조회
		Pbbs5001VO bbsInfo = tbbsWikiDocInfDao.getPbbs5004BbsOneFront(parameterMap);
		//게시글이 있는지 확인
		if (bbsInfo != null) {
			// XSS 변환 처리 : 제목
			bbsInfo.setWiki_titl_nm(TextUtil.removeScript(TextUtil.removeXss(bbsInfo.getWiki_titl_nm())));
			// XSS 변환 처리 : 내용
			bbsInfo.setBbs_cont(TextUtil.removeScript(TextUtil.removeXss(bbsInfo.getBbs_cont())));
			json.put("bbsInfo", convertObjectToMap(bbsInfo));

			//위키 wiki_doc_seq 기준 첨부파일이 있는지 확인
			List<Map<String, Object>> files = tbbsWikiFlInfDao.getPbbs5003Bbsfiles(parameterMap);
			//첨부파일 정보가 있으면 설정
			if (!files.isEmpty()) {
				//메뉴얼 첨부파일 정보
				json.put("files", files);
			}

			//이전글 다음글 정보 취득용 ID (목록과 동일한 조회조건 기준)
			long nowId = 0;
			if (bbsInfo.getId() > 0L) {
				//현재 선택된 게시글 아이디 확인
				nowId = bbsInfo.getId();

				if (nowId > 0) {
					//이전글 조회용 아이디
					long prev_id = nowId + 1L;
					//다음글 조회용 아이디
					long next_id = nowId - 1L;
					//파라미터 설정
					parameterMap.put("prev_id", prev_id);
					parameterMap.put("next_id", next_id);

					//이전글 다음글 정보 조회
					List<Pbbs5001VO> prvNxtList = tbbsWikiDocInfDao.getPbbs5004BbsFrontPrvNxt(parameterMap);

					//리턴용 리스트
					List<Map<String, Object>> rtnPrvNxtList = new ArrayList<Map<String, Object>>();

					//현재글이 공지글인 경우 (일반글1, 공지글 2)
					String wiki_doc_cls_cd = bbsInfo.getWiki_doc_cls_cd();
					//조회된 결과에서 이전글, 다음글 구분값 추가
					for (Pbbs5001VO prvNxt : prvNxtList) {
						Map<String, Object> map = new HashMap<String, Object>();
						//유형이 같은 경우만 반환용 리스트에 등록
						if (wiki_doc_cls_cd.equals(prvNxt.getWiki_doc_cls_cd())) {
							long id = prvNxt.getId();

							//아이디가 이전글이랑 같은경우
							if (prev_id == id) {
								map.put("wiki_type", "prev");
							//아이디가 다음글이랑 같은경우
							} else if (next_id == id) {
								map.put("wiki_type", "next");
							}

							map.put("wiki_titl_nm", prvNxt.getWiki_titl_nm());
							map.put("wiki_doc_seq"  , prvNxt.getWiki_doc_seq());

							//리스트에 추가
							rtnPrvNxtList.add(map);
						}
					}

					json.put("rtnPrvNxtList", rtnPrvNxtList);
				}
			}

		}

		return json;
	}

	/**
	 * 위키 메뉴얼 첨부파일 단건 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getWikibbsfleOne(ParameterMap parameterMap) throws Exception {
		return tbbsWikiFlInfDao.selectMap("TbbsWikiFlInf.selectMap", parameterMap);
	}

	/**
	 * 위키 메뉴얼 조회수 증가
	 * @param parameterMap
	 * @throws Exception
	 */
	public void updatePbbsInqCnt(ParameterMap parameterMap) throws Exception {
		tbbsWikiDocInfDao.updatePbbsInqCnt(parameterMap);
	}

	/**
	 * 위키 메뉴얼 기본 목록 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject getPbbs5004BbsDefault(ParameterMap parameterMap) throws Exception {
		//Return용 Json 선언
		JSONObject json = new JSONObject();

		//검색 keyword
		String keyword = parameterMap.getValue("keyword");
		//키워드가 있는 경우
		if (!StringUtils.isEmpty(keyword)) {
			List<String> keyword_list = new ArrayList<String>();
			//키워드 " " 기준으로 분할
			String[] keyword_arr = keyword.split(" ", -1);
			for (String word : keyword_arr) {
				//키워드가 완전 공백이 아니면서, 중복되지 않은 경우만 검색어로 추가
				if (!StringUtils.isEmpty(word) && !keyword_list.contains(word)) {
					keyword_list.add(word);
				}
			}
			if (!keyword_list.isEmpty()) {
				parameterMap.put("keyword_list", keyword_list);
				//분할된 키워드 목록 설정
				json.put("keyword_list", keyword_list);
			}
		}

		List<Map<String, Object>> mapList = tbbsWikiDocInfDao.getPbbs5004BbsDefault(parameterMap);
		json.put("mapList", mapList);
		return json;
	}

	/**
	 * List to List Map
	 * @param list
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public List<Map<String,Object>> convertObjectToMapList(List list) throws Exception {
		List<Map<String,Object>> results = new ArrayList<Map<String,Object>>();
		if (list == null) {
			return results;
		}
		for (Object object : list) {
			results.add(convertObjectToMap(object));
		}
		return results;
	}

	/**
	 * Object to Map
	 * @param object
	 * @return
	 * @throws Exception
	 */
	private Map<String,Object> convertObjectToMap(Object object) throws Exception {
		Map<String,Object> result = new HashMap<String,Object>();
		List<Field> fields = BeanUtil.getAllDeclaredFields(object.getClass());
		for (Field field : fields) {
			field.setAccessible(true);
			result.put(field.getName(), field.get(object));
		}
		return result;
	}

}
