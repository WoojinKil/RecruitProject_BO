/**
* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명 : kr.co.ta9.pandora3.display.manager
* 3. 파일명 : DisplayMgr
* 4. 작성일 : 2017-11-27
* </pre>
*/
package kr.co.ta9.pandora3.display.manager;

import java.io.File;
import java.lang.reflect.Field;
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
import kr.co.ta9.pandora3.common.util.BeanUtil;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspMnInf;
import kr.co.ta9.pandora3.pcommon.dto.TdspTmplInf;
import kr.co.ta9.pandora3.pdsp.dao.TdspTmplInfDao;
import kr.co.ta9.pandora3.pwzn.dao.TbbsWbznDspMnInfDaoTrx;
import kr.co.ta9.pandora3.pwzn.manager.PwznCommonMgr;

/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.display.manager
* 2. 타입명 : class
* 3. 작성일 : 2017-11-27
* 4. 설명 : 템플릿 매니저
* </pre>
*/
@Service
public class DisplayMgr {
	
	
	@Autowired
	private TdspTmplInfDao tdspTmplInfDao;
	@Autowired
	private TbbsWbznDspMnInfDaoTrx tbbsWbznDspMnInfDaoTrx;
	@Autowired
	private PwznCommonMgr pwznCommonMgr;

	
	/**
	 * 템플릿 조회(단건)
	 * @param parameterMap
	 * @return
	 * @throws Exception 
	 */
	public TdspTmplInf selectTemplate(ParameterMap parameterMap) throws Exception {
		return tdspTmplInfDao.selectDTO(TdspTmplInf.class, parameterMap);
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
	 * 템플릿 Front 전시 메뉴 조회
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject selectDispFrontMenuList() throws Exception {
		List<TdspTmplInf> dataList = tdspTmplInfDao.selectTdspTmplInfDspFrntMnuList();
		List<Map<String,Object>> mapList = convertObjectToMapList(dataList);		
		JSONObject json = new JSONObject();		
		json.put("mapList", mapList);
		return json;
	}

	/**
	 * 템플릿 Front 전시 메뉴 조회(3Depth)
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public JSONObject selectDispFrontMenu3DptList(int tmp_id) throws Exception {
		List<TdspTmplInf> dataList = tdspTmplInfDao.selectTdspTmplInfDspFrntMnu3DptList(tmp_id);
		List<Map<String,Object>> mapList = convertObjectToMapList(dataList);		
		JSONObject json = new JSONObject();		
		json.put("mapList", mapList);
		return json;
	}
	
	/**
	 * 템플릿 정보 조회(템플릿 외부에서 접근시)
	 * @param parameterMap
	 * @return
	 */
	public TdspTmplInf selectTdspTmplInfDocLoc(ParameterMap parameterMap) throws Exception {
		return tdspTmplInfDao.selectTdspTmplInfDocLoc(parameterMap);
	}

	/**
	 * 웹진관리 > 웹진등록 - 웹진메인정보 생성/수정(BO)
	 * @param parameterMap
	 * @throws Exception
	 */
	public void changeWebzineMainInfo(ParameterMap parameterMap) throws Exception {
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

			String chg_flag = parameterMap.getValue("chg_flag"+suffix+i);	// 등록:INSERT|수정:UPDATE|삭제:DELETE
			// 카테고리 명이 등록되어있지 않은 경우 SKIP
			if(StringUtils.isNullOrEmpty(parameterMap.getValue("category_nm"+suffix+i))) {
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
				
				if("INSERT".equals(chg_flag)) {
					tbbsWbznDspMnInf.setCrtr_id(parameterMap.getValue("reg_id"));
					tbbsWbznDspMnInfDaoTrx.delete(tbbsWbznDspMnInf);
				} 
				else if("UPDATE".equals(chg_flag)) {
					tbbsWbznDspMnInf.setUpdr_id(parameterMap.getValue("mod_id"));
					if("Y".equals(parameterMap.getValue("imgDelYn"+i))) {
						tbbsWbznDspMnInfDaoTrx.update(tbbsWbznDspMnInf);
					} else {
						tbbsWbznDspMnInfDaoTrx.update(tbbsWbznDspMnInf);
					}
					
				}
			}
		}
	}
	
}


