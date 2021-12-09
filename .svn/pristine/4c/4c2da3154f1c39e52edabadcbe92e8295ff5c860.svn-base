package kr.co.ta9.pandora3.pwzn.manager;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mysql.jdbc.StringUtils;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.conf.Config;
import kr.co.ta9.pandora3.common.servlet.upload.UploadFile;
import kr.co.ta9.pandora3.common.util.DateUtil;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspDtl;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspMnInf;
import kr.co.ta9.pandora3.pwzn.dao.TbbsWbznDspDtlDao;
import kr.co.ta9.pandora3.pwzn.dao.TbbsWbznDspDtlDaoTrx;
import kr.co.ta9.pandora3.pwzn.dao.TbbsWbznDspMnInfDao;
import kr.co.ta9.pandora3.pwzn.dao.TbbsWbznDspMnInfDaoTrx;
import kr.co.ta9.pandora3.pwzn.dao.TbbsWbznDspMstDao;
import kr.co.ta9.pandora3.pwzn.dao.TbbsWbznDspMstDaoTrx;


/**
* <pre>
* 1. 클래스명 : Pwzn1004Mgr
* 2. 설명 : 웹진카테고리상세 서비스
* 3. 작성일 : 2018-03-29
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Pwzn1004Mgr {
	
	@Autowired
	private TbbsWbznDspDtlDao tbbsWbznDspDtlDao;
	@Autowired
	private TbbsWbznDspDtlDaoTrx tbbsWbznDspDtlDaoTrx;
	@Autowired
	private TbbsWbznDspMnInfDao tbbsWbznDspMnInfDao;
	@Autowired
	private TbbsWbznDspMnInfDaoTrx tbbsWbznDspMnInfDaoTrx;
	
	/**
	 * 웹진 상세 컨텐츠 등록
	 * @param parameterMap
	 * @throws Exception
	 */
	public List<Map<String, Object>> insertTbbsWbznDspDtlFileInf(ParameterMap parameterMap) throws Exception {
		List<Map<String, Object>> retSysFileList = new ArrayList<Map<String, Object>>();
		UploadFile[] uploadFiles = parameterMap.getUploadFiles("files");
		
		int wbzn_seq    = parameterMap.getInt("wbzn_seq");
		// 2019-02-19 primary key auto_increment로 생성 주석처리
		// int ctg_seq  = parameterMap.getInt("ctg_seq");
		String crtr_id  = parameterMap.getValue("crtr_id");
		
		if(uploadFiles != null) {
			final String separator = "_"; 
			
			for(int i = 0; i < uploadFiles.length; i++) {
				String img_nm     = uploadFiles[i].getOriginalFilename();
				String chg_img_nm = new StringBuilder().append(wbzn_seq).append(separator).append(DateUtil.today("yyyyMMddHHmmssSSS")).append(separator).append(img_nm).toString();
				//2019-02-19 ctg_seq 주석처리 String chg_img_nm = new StringBuilder().append(wbzn_seq).append(separator).append(ctg_seq).append(separator).append(DateUtil.today("yyyyMMddHHmmssSSS")).append(separator).append(img_nm).toString();
				String img_path   = new StringBuilder().append("/pandora3/resources/pandora3Front"+Config.get("app.pandora3front.file.path")).append("webzineDtl/").append(chg_img_nm).toString();
				int result        = 0;
				TbbsWbznDspDtl tbbsWbznDspDtl = new TbbsWbznDspDtl();
				
				if(wbzn_seq > 0) {
					tbbsWbznDspDtl.setWbzn_seq(wbzn_seq);
					tbbsWbznDspDtl.setImg_path(img_path);
					tbbsWbznDspDtl.setImg_nm(img_nm);
					tbbsWbznDspDtl.setPg_no(0);
					tbbsWbznDspDtl.setCrtr_id(crtr_id);
					tbbsWbznDspDtl.setUpdr_id(crtr_id);
					
					// 웹진 상세파일정보 등록
					result = tbbsWbznDspDtlDaoTrx.insert(tbbsWbznDspDtl);
					
					// 파일 업로드
					if(result > 0) {
						Map<String, Object> fileSrlMap = new HashMap<String, Object>();
						int[] types = {UploadFile.IMAGE_BMP,UploadFile.IMAGE_GIF,UploadFile.IMAGE_JPEG,UploadFile.IMAGE_JPG,UploadFile.IMAGE_PNG};
						uploadFiles[i].addTypes(types);
						
						fileSrlMap.put("file_srl" , tbbsWbznDspDtl.getCtg_dtl_seq());
						fileSrlMap.put("file_nm"  , tbbsWbznDspDtl.getImg_nm());
						fileSrlMap.put("file_path", tbbsWbznDspDtl.getImg_path());
						
						retSysFileList.add(fileSrlMap);
						uploadFiles[i].transferTo(Config.get("app.pandora3front.file.upload.path")+ File.separator + "webzineDtl", chg_img_nm);
					}
				}
			}
		}
		return retSysFileList;
	}
	/**
	 * 웹진 상세 컨텐츠 삭제
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public int deleteTbbsWbznDspDtlFileInf(ParameterMap parameterMap) throws Exception {
		TbbsWbznDspDtl tbbsWbznDspDtl = new TbbsWbznDspDtl();
		int ctg_dtl_seq = parameterMap.getInt("ctg_dtl_seq");
		int result = 0;
		if(ctg_dtl_seq > 0) {
			tbbsWbznDspDtl.setCtg_dtl_seq(ctg_dtl_seq);
			
			result = tbbsWbznDspDtlDaoTrx.delete(tbbsWbznDspDtl);
		}
		
		return result;
	}
	/**
	 * 웹진 상세 컨텐츠 매핑
	 * @param parameterMap
	 * @param webzineDtlInfoList
	 * @throws Exception
	 */
	public void updateWbznCtgList(ParameterMap parameterMap, List<TbbsWbznDspDtl> tbbsWbznDspDtlList) throws Exception {
		if(tbbsWbznDspDtlList != null && tbbsWbznDspDtlList.size() > 0) {
			for(TbbsWbznDspDtl tbbsWbznDspDtl : tbbsWbznDspDtlList) {
				tbbsWbznDspDtl.setUpdr_id(parameterMap.getValue("updr_id"));
				tbbsWbznDspDtlDaoTrx.update(tbbsWbznDspDtl);
				// 랜딩페이지 정보 매핑
				if("Y".equals(tbbsWbznDspDtl.getLdg_yn())) {
					TbbsWbznDspMnInf tbbsWbznDspMnInf = new TbbsWbznDspMnInf();
					tbbsWbznDspMnInf.setUpdr_id(parameterMap.getValue("updr_id"));
					tbbsWbznDspMnInf.setCtg_seq(tbbsWbznDspDtl.getCtg_seq());
					tbbsWbznDspMnInf.setWbzn_seq(tbbsWbznDspDtl.getWbzn_seq());
					tbbsWbznDspMnInf.setLdg_pg_no(String.valueOf(tbbsWbznDspDtl.getCtg_dtl_seq()));
					tbbsWbznDspMnInfDaoTrx.update(tbbsWbznDspMnInf);
				}
			}
		}
	}
	/**
	 * 웹진 목록 조회(메인카테고리 - 상세컨텐츠 매핑여부 포함)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject selectTbbsWbznDspMnInfInitList(ParameterMap parameterMap, JSONObject json) throws Exception {
		List<TbbsWbznDspMnInf> list = tbbsWbznDspMnInfDao.selectTbbsWbznDspMnInfInitList(parameterMap);
		List<Map<String, Object>> webzineInfoList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> webzineDtlInfoList = new ArrayList<Map<String, Object>>();
		
		if(list != null && list.size() > 0) {
			for(TbbsWbznDspMnInf tbbsWbznDspMnInf : list) {
				Map<String, Object> webzineInfoMap = new HashMap<String, Object>();
				Map<String, Object> webzineDtlInfoMap = new HashMap<String, Object>();
				if(tbbsWbznDspMnInf.getWbzn_seq() > 0) {
					
					webzineInfoMap.put("wbzn_seq", tbbsWbznDspMnInf.getWbzn_seq());
					webzineInfoMap.put("wbzn_nm" , tbbsWbznDspMnInf.getWbzn_nm());
					webzineInfoList.add(webzineInfoMap);
					
					webzineDtlInfoMap.put("wbzn_seq",tbbsWbznDspMnInf.getWbzn_seq());
					webzineDtlInfoMap.put("wbzn_nm" ,tbbsWbznDspMnInf.getWbzn_nm());
					webzineDtlInfoMap.put("ctg_seq" ,tbbsWbznDspMnInf.getCtg_seq());
					webzineDtlInfoMap.put("ctg_nm"  ,tbbsWbznDspMnInf.getCtg_nm());
					webzineDtlInfoList.add(webzineDtlInfoMap);
				}
			}
		}
		json.put("webzineInfoList", webzineInfoList);
		json.put("webzineDtlInfoList", webzineDtlInfoList);
		
		return json;
	}
	/**
	 * 웹진 상세 파일 목록 조회
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectWebzineDtlInfoListMap(ParameterMap parameterMap) throws Exception {
		List<TbbsWbznDspDtl> dtlFileList = tbbsWbznDspDtlDao.selectTbbsWbznDspDtlList(parameterMap);
		List<Map<String,Object>> mapList = new ArrayList<Map<String,Object>>();
		for(TbbsWbznDspDtl tbbsWbznDspDtl : dtlFileList) {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("ctg_dtl_seq", tbbsWbznDspDtl.getCtg_dtl_seq());
			map.put("ctg_seq"    , tbbsWbznDspDtl.getCtg_seq());
			map.put("img_nm"     , tbbsWbznDspDtl.getImg_nm());
			map.put("img_path"   , tbbsWbznDspDtl.getImg_path());
			map.put("pg_no"      , tbbsWbznDspDtl.getPg_no());
			map.put("ldg_yn"     , tbbsWbznDspDtl.getLdg_yn());
			mapList.add(map);
		}
		return mapList;
	}
}
