package kr.co.ta9.pandora3.pwzn.manager;

import org.springframework.stereotype.Service;

import com.mysql.jdbc.StringUtils;

import kr.co.ta9.pandora3.common.conf.Config;
import kr.co.ta9.pandora3.common.exception.ConfigurationException;
import kr.co.ta9.pandora3.common.servlet.upload.UploadFile;
import kr.co.ta9.pandora3.common.util.DateUtil;

/**
* <pre>
* 1. 클래스명 : PwznCommonMgr
* 2. 설명 : 웹진 공통 서비스
* 3. 작성일 : 2018-03-29
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class PwznCommonMgr {
	
	/**
	 * 이미지 파일 등록(파일 서버 저장)
	 * @param uploadFiles
	 * @param targetUrl
	 * @throws Exception 
	 * @throws ConfigurationException 
	 */
	public String[] uploadImageFiles(UploadFile[] uploadFiles, String targetPath, String separator, String[] returnArr) throws Exception {
		
		// 이미지 파일 확장자 유효성 검사용 프로터티 취득
		String[] validExt = Config.get("file.upload.img.valid.ext").split("\\|");
		// 체크할 이미지 확장자 배열 생성
		int[] types = new int[validExt.length];
		for(int i=0; i<validExt.length; i++) {
			if("jpg".equalsIgnoreCase(validExt[i])) types[i] = UploadFile.IMAGE_JPG;
			else if("jpeg".equalsIgnoreCase(validExt[i])) types[i] = UploadFile.IMAGE_JPEG;
			else if("gif".equalsIgnoreCase(validExt[i]))  types[i] = UploadFile.IMAGE_GIF;
			else if("png".equalsIgnoreCase(validExt[i]))  types[i] = UploadFile.IMAGE_PNG;
			else if("bmp".equalsIgnoreCase(validExt[i]))  types[i] = UploadFile.IMAGE_BMP;
		}
		
		for(int i = 0; i < uploadFiles.length; i++) {
			String org_img_name = uploadFiles[i].getOriginalFilename();
			if(!StringUtils.isNullOrEmpty(org_img_name)) {
				String chg_img_name = new StringBuilder().append(DateUtil.today("yyyyMMddHHmmssSSS")).append(separator).append(org_img_name).toString();
				// 파일 업로드
				uploadFiles[i].addTypes(types);
				uploadFiles[i].transferTo(Config.get("app.pandora3front.file.upload.path") + targetPath, chg_img_name);
				// 리턴용 배열 생성(저장 파일명)
				returnArr[i] = chg_img_name;
			} else {
				returnArr[i] = "";
			}
		}
		
		return returnArr;
	}
}
