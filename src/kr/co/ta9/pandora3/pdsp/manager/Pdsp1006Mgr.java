package kr.co.ta9.pandora3.pdsp.manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.dto.DataMap;
import kr.co.ta9.pandora3.pcommon.dto.TdspMnPop;
import kr.co.ta9.pandora3.pdsp.dao.TdspMnPopDao;
/**
* <pre>
* 1. 클래스명 : Pdsp1006Mgr
* 2. 설명: 메인팝업상세보기
* 3. 작성일 : 2018-03-29
* 4.작성자   : TANINE
* </pre>
*/
@Service
public class Pdsp1006Mgr {
	
	@Autowired
	private TdspMnPopDao tdspMnPopDao;	
	
	/**
	 * 메인 팝업 조회 (단건)
	 * @param parameterMap
	 * @throws Exception
	 */
	public DataMap selectTdspMnPopInfo(ParameterMap parameterMap) throws Exception {
		return tdspMnPopDao.selectTdspMnPopInfo(parameterMap);
	}
	
	/**
	 * 메인팝업등록/수정(BO)
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTdspMnPopInfo(ParameterMap parameterMap) throws Exception {
		// 이미지 파일명 생성 구분자
//		final String nameSeparator = "_"; 
		// 이미지 상대경로 구분자
//		final String pathSeparator = "/";
		// 이미지 저장 폴더명
//		String folderName = "popup";
		// 이미지 파일 취득
//		UploadFile[] uploadFiles = parameterMap.getUploadFiles("img_files");
		// 변경된 파일명 배열
//		String[] chgNameFileArr = new String[uploadFiles.length];
//		boolean newFileFlag = Boolean.parseBoolean(parameterMap.getValue("newFileFlag"));
		
		// 파일 업로드
		String ognl_img_nm = "";
//		String chg_img_name = "";
		String img_pth = "";
		
		// 파일 신규등록일때만 파일정보 갱신
//		if(newFileFlag) {
//			chgNameFileArr = uploadImageFiles(uploadFiles, File.separator + folderName, nameSeparator, chgNameFileArr);
//			org_img_name = uploadFiles[0].getOriginalFilename();
//			chg_img_name = chgNameFileArr[0];
//			img_path = Config.get("app.pandora3front.file.path") + folderName + pathSeparator + chg_img_name;
//		}
		
		// 팝업 Object 생성
		TdspMnPop tdspMnPop = new TdspMnPop();
		// 팝업 Object 정보 설정
		tdspMnPop.setPop_nm(parameterMap.getValue("pop_nm"));
		tdspMnPop.setPop_tp_cd(parameterMap.getValue("pop_tp_cd"));
		tdspMnPop.setBkg_tp_cd(parameterMap.getValue("bkg_tp_cd"));
		tdspMnPop.setPop_cts(parameterMap.getValue("pop_cts"));
		tdspMnPop.setDsply_yn(parameterMap.getValue("dsply_yn"));
		tdspMnPop.setSt_dttm(parameterMap.getValue("st_dttm"));
		tdspMnPop.setEd_dttm(parameterMap.getValue("ed_dttm"));
		tdspMnPop.setCrtr_id(parameterMap.getValue("crtr_id"));
		tdspMnPop.setUpdr_id(parameterMap.getValue("updr_id"));
		//tdspMnPop.setSrt_sqn(Integer.valueOf(parameterMap.getValue("srt_sqn")));
		tdspMnPop.setTop_txt(parameterMap.getValue("top_txt"));
		tdspMnPop.setMid_txt(parameterMap.getValue("mid_txt"));
		tdspMnPop.setBtm_txt(parameterMap.getValue("btm_txt"));
		tdspMnPop.setOgnl_img_nm(ognl_img_nm);
		tdspMnPop.setImg_pth(img_pth);
		tdspMnPop.setPop_kd_cd(parameterMap.getValue("pop_kd_cd"));
		tdspMnPop.setPop_url(parameterMap.getValue("pop_url"));
	
		// 팝업 정보 저장
		if("Y".equals(parameterMap.getValue("updateFlag"))) {
			tdspMnPop.setMn_pop_seq(Integer.valueOf(parameterMap.getValue("mn_pop_seq")));
			tdspMnPopDao.update(tdspMnPop);
		} else {
			tdspMnPopDao.insert(tdspMnPop);
		}
		
	}
}
