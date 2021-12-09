package kr.co.ta9.pandora3.pwzn.manager;

import java.io.File;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mysql.jdbc.StringUtils;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.conf.Config;
import kr.co.ta9.pandora3.common.servlet.upload.UploadFile;
import kr.co.ta9.pandora3.common.util.BeanUtil;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspMnInf;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspMst;
import kr.co.ta9.pandora3.pwzn.dao.TbbsWbznDspMnInfDao;
import kr.co.ta9.pandora3.pwzn.dao.TbbsWbznDspMnInfDaoTrx;
import kr.co.ta9.pandora3.pwzn.dao.TbbsWbznDspMstDao;
import kr.co.ta9.pandora3.pwzn.dao.TbbsWbznDspMstDaoTrx;

/**
* <pre>
* 1. 클래스명 : Pwzn1002Mgr
* 2. 설명 : 웹진컨텐츠상세조회 서비스
* 3. 작성일 : 2018-03-29
* 4. 작성자 : TANINE
* </pre>
*/

@Service
public class Pwzn1002Mgr {
	
	@Autowired
	private TbbsWbznDspMnInfDao tbbsWbznDspMnInfDao; 
	@Autowired
	private TbbsWbznDspMnInfDaoTrx tbbsWbznDspMnInfDaoTrx; 
	@Autowired
	private TbbsWbznDspMstDao tbbsWbznDspMstDao;
	@Autowired
	private TbbsWbznDspMstDaoTrx tbbsWbznDspMstDaoTrx;
	@Autowired
	private PwznCommonMgr pwznCommonMgr;
	
	/**
	 * 웹진관리 > 웹진 MST 정보 수정(BO)
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public void updateWbznMstInf(ParameterMap parameterMap) throws Exception {
		// 웹진 마스터정보 Object
		TbbsWbznDspMst tbbsWbznDspMst = new TbbsWbznDspMst();
		// 이미지 파일명 생성 구분자
		final String nameSeparator = "_"; 
		// 이미지 상대경로 구분자
		final String pathSeparator = "/";
		// 이미지 저장 폴더명
		String folderName = "webzineMst";
		// 이미지 파일 취득
		UploadFile[] uploadFiles = parameterMap.getUploadFiles("img_files_no0");
		// 변경된 파일명 배열
		String[] chgNameFileArr = new String[uploadFiles.length];
		
		// 파일 업로드
		if(uploadFiles[0].getFileItem().getSize() > 0) {
			chgNameFileArr = pwznCommonMgr.uploadImageFiles(uploadFiles, File.separator + folderName, nameSeparator, chgNameFileArr);
			tbbsWbznDspMst.setThumb_fpath("/pandora3/resources/pandora3Front"+Config.get("app.pandora3front.file.path") + folderName + pathSeparator + chgNameFileArr[0]);
		}
		tbbsWbznDspMst.setWbzn_seq(Integer.parseInt(parameterMap.getValue("wbzn_seq")));
		tbbsWbznDspMst.setTmp_seq(Integer.parseInt(parameterMap.getValue("tmp_seq")));
		tbbsWbznDspMst.setWbzn_nm(parameterMap.getValue("wbzn_nm"));
		tbbsWbznDspMst.setY_no(parameterMap.getValue("y_no"));
		tbbsWbznDspMst.setM_no(parameterMap.getValue("m_no"));
		tbbsWbznDspMst.setUpdr_id(parameterMap.getValue("updr_id"));
		tbbsWbznDspMstDaoTrx.update(tbbsWbznDspMst);
	}
	
	
	
	/**
	 * 웹진관리 > 웹진등록 - 웹진메인정보 생성/수정(BO)
	 * @param parameterMap
	 * @throws Exception tbbsWbznDspMnInfDao
	 */
	public void saveTbbsWbznDspMnInf(ParameterMap parameterMap) throws Exception {
		// 이미지 파일명 생성 구분자
		final String nameSeparator = "_"; 
		// 이미지 저장 폴더명
		String folderName = "webzineMain/";
		// 파라미터 Suffix
		String suffix = "_no";
		// 메인 전시 컨텐츠 갯수(카테고리 수)
		int dispCnt = 7;
		for(int i=1; i <= dispCnt; i++) {
			// 웹진 메인 정보 Object
			TbbsWbznDspMnInf tbbsWbznDspMnInf = new TbbsWbznDspMnInf();
			tbbsWbznDspMnInf.setWbzn_seq(Integer.parseInt(parameterMap.getValue("wbzn_seq")));
			tbbsWbznDspMnInf.setCtg_seq(i);

			String chg_flag = parameterMap.getValue("chg_flag" + suffix + i);	// 등록:INSERT|수정:UPDATE|삭제:DELETE
			
			// 카테고리 명이 등록되어있지 않은 경우 SKIP
			if(StringUtils.isNullOrEmpty(parameterMap.getValue("ctg_nm" + suffix + i))) {
				if("DELETE".equals(chg_flag)) {
					tbbsWbznDspMnInfDaoTrx.delete(tbbsWbznDspMnInf);
				}
				continue;
			}
			else {
				tbbsWbznDspMnInf.setCtg_nm(parameterMap.getValue("ctg_nm"+suffix+i));
				tbbsWbznDspMnInf.setCts_titl(TextUtil.removeXss(parameterMap.getValue("cts_titl"+suffix+i)));
				tbbsWbznDspMnInf.setCts_subtitl(TextUtil.removeXss(parameterMap.getValue("cts_subtitl"+suffix+i)));
				tbbsWbznDspMnInf.setCts_txt(TextUtil.removeXss(parameterMap.getValue("cts_txt"+suffix+i)));
				
				// 이미지 파일 취득
				UploadFile[] uploadFiles = parameterMap.getUploadFiles("img_files"+suffix+i);
				// 변경된 파일명 배열
				String[] chgNameFileArr = new String[uploadFiles.length];
				
				// 파일 업로드(파일이 올라간 경우)
				if(uploadFiles[0].getFileItem().getSize() > 0) {
					chgNameFileArr = pwznCommonMgr.uploadImageFiles(uploadFiles, File.separator + folderName, nameSeparator, chgNameFileArr);
					tbbsWbznDspMnInf.setThumb_nm(uploadFiles[0].getOriginalFilename());
					tbbsWbznDspMnInf.setThumb_fpath("/pandora3/resources/pandora3Front"+Config.get("app.pandora3front.file.path") + folderName + chgNameFileArr[0]);
				}
				
				tbbsWbznDspMnInf.setCrtr_id(parameterMap.getValue("crtr_id"));
				tbbsWbznDspMnInf.setUpdr_id(parameterMap.getValue("updr_id"));
				
				if("INSERT".equals(chg_flag)) {
					tbbsWbznDspMnInfDaoTrx.insert(tbbsWbznDspMnInf);
				} else if("UPDATE".equals(chg_flag)) {
					tbbsWbznDspMnInfDaoTrx.update(tbbsWbznDspMnInf);
				}
			}
		}
	}
	
	/**
	 * 웹진 마스터 정보 조회 BY WBZN_SEQ
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception 
	 */
	public Map<String, Object> selectTbbsWbznDspMstInf(ParameterMap parameterMap) throws Exception {
		ObjectMapper mapper = new ObjectMapper();
		TbbsWbznDspMst tbbsWbznDspMst = tbbsWbznDspMstDao.selectTbbsWbznDspMstInf(parameterMap);
		Map<String, Object> tbbsWbznDspMstMap = mapper.readValue(mapper.writeValueAsString(tbbsWbznDspMst), new TypeReference<Map<String,Object>>(){});
		return tbbsWbznDspMstMap;
	}
	
	/**
	 * 웹진 메인 정보 조회 BY WBZN_SEQ
	 * @param  parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTbbsWbznDspMnInfList(ParameterMap parameterMap) throws Exception {
		List<TbbsWbznDspMnInf> tbbsWbznDspMnInf = tbbsWbznDspMnInfDao.selectTbbsWbznDspMnInfList(parameterMap);
		List<Map<String, Object>> tbbsWbznDspMnInfList = convertObjectToMapList(tbbsWbznDspMnInf);		
		return tbbsWbznDspMnInfList;
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
