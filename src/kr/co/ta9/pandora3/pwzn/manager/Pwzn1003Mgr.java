package kr.co.ta9.pandora3.pwzn.manager;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.conf.Config;
import kr.co.ta9.pandora3.common.servlet.upload.UploadFile;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspMnInf;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspMst;
import kr.co.ta9.pandora3.pwzn.dao.TbbsWbznDspMnInfDaoTrx;
import kr.co.ta9.pandora3.pwzn.dao.TbbsWbznDspMstDaoTrx;

/**
* <pre>
* 1. 클래스명 : Pwzn1003Mgr
* 2. 설명 : 웹진컨텐츠등록 서비스
* 3. 작성일 : 2018-03-29
* 4. 작성자 : TANINE
* </pre>
*/

@Service
public class Pwzn1003Mgr {
	
	@Autowired
	private TbbsWbznDspMstDaoTrx tbbsWbznDspMstDaoTrx;
	@Autowired
	private TbbsWbznDspMnInfDaoTrx tbbsWbznDspMnInfDaoTrx;
	@Autowired
	private PwznCommonMgr pwznCommonMgr;
	
	/**
	 * 웹진관리 > 웹진등록 - 웹진ID 생성(BO)
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public int insertTbbsWbznMst(ParameterMap parameterMap) throws Exception {
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
		tbbsWbznDspMst.setTmp_seq(Integer.parseInt(parameterMap.getValue("tmp_seq")));
		tbbsWbznDspMst.setWbzn_nm(parameterMap.getValue("wbzn_nm"));
		tbbsWbznDspMst.setY_no(parameterMap.getValue("y_no"));
		tbbsWbznDspMst.setM_no(parameterMap.getValue("m_no"));
		tbbsWbznDspMst.setCrtr_id(parameterMap.getValue("crtr_id"));
		tbbsWbznDspMst.setUpdr_id(parameterMap.getValue("updr_id"));
		tbbsWbznDspMstDaoTrx.insert(tbbsWbznDspMst);
		int wbzn_seq = tbbsWbznDspMst.getWbzn_seq();
		return wbzn_seq;
	}

	/**
	 * 웹진관리 > 웹진등록(웹진 마스터 와 웹진메인 등록)
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public void saveTbbsWbznMstAndMn(ParameterMap parameterMap) throws Exception {
		// 웹진 마스터정보 Object
		TbbsWbznDspMst tbbsWbznDspMst = new TbbsWbznDspMst();
		// 이미지 파일명 생성 구분자
		final String nameSeparator = "_"; 
		// 이미지 상대경로 구분자
		final String pathSeparator = "/";
		// 이미지 저장 폴더명
		String webznMstFolderNm = "webzineMst";
		String webznMnFolderNm  = "webzineMain/";
		// 파라미터 Suffix
		String suffix = "_no";
		// 메인 전시 컨텐츠 갯수(카테고리 수)
		int dispCnt = parameterMap.getInt("category_cnt");
		
		// 이미지 파일 취득
		UploadFile[] uploadFiles = parameterMap.getUploadFiles("img_files_no0");
		// 변경된 파일명 배열
		String[] chgNameFileArr = new String[uploadFiles.length];
		
		// 파일 업로드
		if(uploadFiles[0].getFileItem().getSize() > 0) {
			chgNameFileArr = pwznCommonMgr.uploadImageFiles(uploadFiles, File.separator + webznMstFolderNm, nameSeparator, chgNameFileArr);
			tbbsWbznDspMst.setThumb_fpath("/pandora3/resources/pandora3Front"+Config.get("app.pandora3front.file.path") + webznMstFolderNm + pathSeparator + chgNameFileArr[0]);
		}
		tbbsWbznDspMst.setTmp_seq(Integer.parseInt(parameterMap.getValue("tmp_seq")));
		tbbsWbznDspMst.setWbzn_nm(parameterMap.getValue("wbzn_nm"));
		tbbsWbznDspMst.setY_no(parameterMap.getValue("y_no"));
		tbbsWbznDspMst.setM_no(parameterMap.getValue("m_no"));
		tbbsWbznDspMst.setCrtr_id(parameterMap.getValue("crtr_id"));
		tbbsWbznDspMst.setUpdr_id(parameterMap.getValue("updr_id"));
		
		// 웹진 마스터 등록
		tbbsWbznDspMstDaoTrx.insert(tbbsWbznDspMst);
		int wbzn_seq = tbbsWbznDspMst.getWbzn_seq();
		
		for(int i=1; i <= dispCnt; i++) {
			// 웹진 메인 정보 Object
			TbbsWbznDspMnInf tbbsWbznDspMnInf = new TbbsWbznDspMnInf();
			tbbsWbznDspMnInf.setWbzn_seq(wbzn_seq);
			tbbsWbznDspMnInf.setCtg_seq(i);

			//String chg_flag = parameterMap.getValue("chg_flag" + suffix + i);	// 등록:INSERT|수정:UPDATE|삭제:DELETE
			
			tbbsWbznDspMnInf.setCtg_nm(parameterMap.getValue("ctg_nm"+suffix+i));
			tbbsWbznDspMnInf.setCts_titl(TextUtil.removeXss(parameterMap.getValue("cts_titl"+suffix+i)));
			tbbsWbznDspMnInf.setCts_subtitl(TextUtil.removeXss(parameterMap.getValue("cts_subtitl"+suffix+i)));
			tbbsWbznDspMnInf.setCts_txt(TextUtil.removeXss(parameterMap.getValue("cts_txt"+suffix+i)));
			
			if(TextUtil.isNotEmpty(parameterMap.getValue("ctg_nm" + suffix + i))) {
				// 이미지 파일 취득
				uploadFiles = parameterMap.getUploadFiles("img_files"+suffix+i);
				// 변경된 파일명 배열
				chgNameFileArr = new String[uploadFiles.length];
				
				// 파일 업로드(파일이 올라간 경우)
				if(uploadFiles[0].getFileItem().getSize() > 0) {
					chgNameFileArr = pwznCommonMgr.uploadImageFiles(uploadFiles, File.separator + webznMnFolderNm, nameSeparator, chgNameFileArr);
					tbbsWbznDspMnInf.setThumb_nm(uploadFiles[0].getOriginalFilename());
					tbbsWbznDspMnInf.setThumb_fpath("/pandora3/resources/pandora3Front"+Config.get("app.pandora3front.file.path") + webznMnFolderNm + chgNameFileArr[0]);
				}
				
				tbbsWbznDspMnInf.setCrtr_id(parameterMap.getValue("crtr_id"));
				tbbsWbznDspMnInf.setUpdr_id(parameterMap.getValue("updr_id"));
				
				tbbsWbznDspMnInfDaoTrx.insert(tbbsWbznDspMnInf);
			}
		}
		
	}
	
}
