	package kr.co.ta9.pandora3.pbbs.manager;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.ConfigurationException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.util.S3FileUtil;
import kr.co.ta9.pandora3.common.conf.Config;
import kr.co.ta9.pandora3.common.conf.Configuration;
import kr.co.ta9.pandora3.common.servlet.upload.UploadFile;
import kr.co.ta9.pandora3.common.util.DateUtil;
import kr.co.ta9.pandora3.common.util.FileUtil;
import kr.co.ta9.pandora3.pbbs.dao.TbbsDocInfDao;
import kr.co.ta9.pandora3.pbbs.dao.TbbsFlInfDao;
import kr.co.ta9.pandora3.pcommon.dto.TbbsDocInf;
import kr.co.ta9.pandora3.pcommon.dto.TbbsFlInf;

/**
* <pre>
* 1. 클래스명 : PbbsCommonMgr
* 2. 설명 : 통합게시글 공통 서비스
* 3. 작성일 : 2018-04-11
* 4.작성자   : TANINE
* </pre>
*/
@Service
public class PbbsCommonMgr {

	@Autowired
	private TbbsFlInfDao tbbsFlInfDao;
	
	@Autowired
	private TbbsDocInfDao tbbsDocInfDao;


//	Configuration configuration = Configuration.getInstance();
//	String s3Url = configuration.get("app.amazone.s3.url");
//	String bucketName = configuration.get("app.s3path.bdp.bucketName");
//	String accessKey  = configuration.get("app.s3path.bdp.accessKey");
//	String secretKey  = configuration.get("app.s3path.bdp.secretKey");
//	boolean successFlag = false;
//	String basePath = configuration.get("app.s3path.bdp.upload.path");
//	String target = configuration.get("properties.target");
	private Configuration configuration = Configuration.getInstance();
	private String s3Url = configuration.get("app.amazone.s3.url");
	private String bucketName = configuration.get("app.s3path.bdp.bucketName");
	private String accessKey  = configuration.get("app.s3path.bdp.accessKey");
	private String secretKey  = configuration.get("app.s3path.bdp.secretKey");
//	private boolean successFlag = false;
	private String basePath = configuration.get("app.s3path.bdp.upload.path");
	private String target = configuration.get("properties.target");

	//properties.target



	/**
	 * 공통 : 질문답변형 게시판 상세 조회(첨부파일)
	 * @param  parameterMap
	 * @return List<Map<String,Object>>
	 * @throws Exception
	 */
	public List<Map<String,Object>> selectTbbsFlInfListMap(ParameterMap parameterMap) throws Exception {
		List<TbbsFlInf> tbbsFlInfList = tbbsFlInfDao.selectTbbsFlInfList(parameterMap);
		List<Map<String,Object>> mapList = new ArrayList<Map<String,Object>>();
		for(TbbsFlInf tbbsFlInf : tbbsFlInfList) {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("FL_SEQ", tbbsFlInf.getFl_seq());
			map.put("ORI_FL_NM", tbbsFlInf.getSrc_fl_nm());
			map.put("UPL_FL_NM", tbbsFlInf.getUpl_fl_nm());
			map.put("FL_EXT", tbbsFlInf.getFl_ext());
			map.put("FL_SIZE", tbbsFlInf.getFl_size());
			map.put("THUMB_YN", tbbsFlInf.getThumb_yn());
			map.put("UPL_TRG_TP", tbbsFlInf.getUpl_trg_tp());
			mapList.add(map);
		}
		return mapList;
	}

	/**
	 * 게시판 임시 정보 저장
	 * @param  parameterMap
	 * @return
	 * @throws Exception
	 */
	public int insertTbbsTmpDocInf(ParameterMap parameterMap) throws Exception {
		TbbsDocInf tbbsDocInf = (TbbsDocInf)parameterMap.populate(TbbsDocInf.class);
		tbbsDocInfDao.insertTbbsTmpDocInf(tbbsDocInf);
		return tbbsDocInf.getDoc_seq();
	}

	/**
	 * 게시판 파일 정보 저장
	 * @param  parameterMap
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	public List<Map<String, Object>> insertTbbsFlInf(ParameterMap parameterMap) throws Exception {
		List<Map<String, Object>> retTbbsFlInfList = new ArrayList<Map<String, Object>>();
		int modl_seq = parameterMap.getInt("modl_seq");
		int doc_seq = parameterMap.getInt("doc_seq");
		String uplTrgTp = parameterMap.getValue("upl_trg_tp");
		UserInfo userInfo = parameterMap.getUserInfo();

		if(userInfo != null){
			String user_id = userInfo.getUser_id();
			String ip_addr = userInfo.getLast_access_ip_addr();
			UploadFile[] uploadFiles = parameterMap.getUploadFiles("files");
			if(uploadFiles != null) {
				String separator = "_";
				for(int i = 0; i < uploadFiles.length; i++) {
					String ori_fl_nm = uploadFiles[i].getOriginalFilename();
					ori_fl_nm = ori_fl_nm.substring(ori_fl_nm.lastIndexOf("\\")+1);
					String chg_source_filename = new StringBuilder().append(DateUtil.today("yyyyMMddHHmmssSSS")).append(separator).append(ori_fl_nm).toString();
//					String upl_fl_nm = new StringBuilder().append(configuration.get("app.pandora3front.file.path")).append(chg_source_filename).toString();
					String file_ext = uploadFiles[i].getExtension();
					int file_size = (int)uploadFiles[i].getSize();
					String s3FileNm ="";
					if("local".equals(target)){
						s3FileNm = s3Url +bucketName+basePath+"/"+ chg_source_filename;
					}else{
						basePath =configuration.get("app.s3info.bdp.upload.path");
						bucketName = configuration.get("app.s3info.bdp.bucketName");
						s3FileNm = s3Url +bucketName+"/"+basePath+"/"+ chg_source_filename;
					}


					TbbsDocInf tbbsDocInf = new TbbsDocInf();
					tbbsDocInf.setDoc_seq(doc_seq);
					tbbsDocInf.setModl_seq(modl_seq);
					tbbsDocInf.setUsr_id(user_id);
					tbbsDocInf.setSrc_fl_nm(ori_fl_nm);
					tbbsDocInf.setUpl_fl_nm(s3FileNm);
					tbbsDocInf.setFl_ext(file_ext);
					tbbsDocInf.setFl_size(file_size);
					tbbsDocInf.setIp_addr(ip_addr);
					tbbsDocInf.setCrtr_id(user_id);
					tbbsDocInf.setUpdr_id(user_id);
					int result = tbbsDocInfDao.insertTbbsFlInfInfo(tbbsDocInf);
					// 파일 업로드
					if(result > 0) {
						Map<String, Object> fileSrlMap = new HashMap<String, Object>();
						int[] types = {UploadFile.NONE};
						uploadFiles[i].addTypes(types);
						fileSrlMap.put("file_srl", tbbsDocInf.getFl_seq());
						fileSrlMap.put("file_nm", tbbsDocInf.getSrc_fl_nm());
						fileSrlMap.put("file_path", tbbsDocInf.getUpl_fl_nm());
						fileSrlMap.put("file_ext", tbbsDocInf.getFl_ext());
						retTbbsFlInfList.add(fileSrlMap);
						uploadFiles[i].transferTo(configuration.get("app.pandora3front.file.upload.path"), chg_source_filename);
						String img_path =configuration.get("app.pandora3front.file.upload.path")+"/"+ chg_source_filename;
						S3FileUtil fileUtil = new S3FileUtil();
						File s3UploadFile = new File(img_path);
						if(s3UploadFile.exists() && !s3UploadFile.isDirectory()){
							if("local".equals(target)){  //target이 로컬이면 key방식
								fileUtil.fileUploadS3(bucketName, accessKey, secretKey, basePath,img_path,chg_source_filename);
							}else{ //그렇지 않으면 롤방식
								fileUtil.s3UploadRol(bucketName,  basePath, img_path, chg_source_filename);
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
	 * 게시판 파일 정보 삭제
	 * @param  parameterMap
	 * @return int
	 * @throws Exception

	 */
	public int deleteTbbsFlInf(ParameterMap parameterMap) throws Exception {
		TbbsDocInf tbbsDocInf = new TbbsDocInf();
		String fl_seq = parameterMap.getValue("fl_seq");
		TbbsFlInf tmp = tbbsFlInfDao.selectTbbsFlInfInfo(fl_seq);
		tbbsDocInf.setFl_seq(Integer.parseInt(fl_seq));
		int result = tbbsDocInfDao.deleteTbbsFlInfInfo(tbbsDocInf);
		// 첨부파일 삭제
		if(result>0){
			String save_path = Config.get("app.pandora3front.file.upload.path") + File.separator;
			String file_path = "";
			String realFileName ="";

			if(tmp.getUpl_fl_nm()!=null){
				realFileName = tmp.getUpl_fl_nm().substring(tmp.getUpl_fl_nm().lastIndexOf("/")+1);
				file_path = save_path + File.separator +realFileName;
				FileUtil.deleteFile(file_path);
			}
		}
		return result;
	}

	/**
	 * 게시판 파일 정보 삭제
	 * @param  parameterMap
	 * @return int
	 * @throws Exception
	 *
	 */
	public int deleteTbbsFlInfAll(ParameterMap parameterMap) throws Exception {
		TbbsDocInf tbbsDocInf = new TbbsDocInf();
		List<TbbsFlInf> tbbsFlInfList= tbbsFlInfDao.selectTbbsFlInfList(parameterMap);
		String doc_seq = parameterMap.getValue("doc_seq");
		tbbsDocInf.setDoc_seq(Integer.parseInt(doc_seq));
		int result = tbbsDocInfDao.deleteTbbsFlInf(tbbsDocInf);
		// 첨부파일 삭제
		if(result>0){
			for(int i =0; i <tbbsFlInfList.size(); i++ ){
				String save_path = Config.get("app.file.download.path") + File.separator;
				String file_path = "";
				String realFileName ="";
				TbbsFlInf tbbsFlInf = tbbsFlInfList.get(i);
				if(tbbsFlInf.getUpl_fl_nm()!=null){
					realFileName = tbbsFlInf.getUpl_fl_nm();
					file_path = save_path + File.separator +realFileName;
					FileUtil.deleteFile(file_path);
				}
			}
		}
		return result;
	}


	/**
	 * 이미지 파일 등록(파일 서버 저장)
	 * @param uploadFiles
	 * @param targetUrl
	 * @throws Exception
	 * @throws ConfigurationException
	 */
	public String[] uploadImageFiles(UploadFile[] uploadFiles, String targetPath, String separator, String... returnArr) throws Exception {

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
			org_img_name = org_img_name.substring(org_img_name.lastIndexOf("\\")+1);
			if(!("".equals(org_img_name))) {
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

	/**
	 * 파일 등록
	 * @param  parameterMap
	 * @throws Exception
	 */
	public void insertFlImgInf(ParameterMap parameterMap) throws Exception {
		String nameSeparator = "_";												  // 이미지 파일명 생성 구분자
		String pathSeparator = "/";												  // 이미지 상대경로 구분자
		String folderName = "pvThumb";													  // 이미지 저장 폴더명
		boolean newFileFlag = Boolean.parseBoolean(parameterMap.getValue("newFileFlag")); // 파일 변경 플래그
		UploadFile[] uploadFiles = parameterMap.getUploadFiles("img_files");			  // 취득한 이미지 파일


		// 파일 업로드용 변수 선언
		String org_img_name = "";
		String chg_img_name = "";
		String img_path = "";
		String fl_ext = "";
		int fl_size = 0;
		String[] chgNameFileArr = new String[uploadFiles.length];

		//String s3Path = configuration.get("app.amazone.s3.path");
		bucketName = configuration.get("app.s3path.bdp.bucketName");
		accessKey  = configuration.get("app.s3path.bdp.accessKey");
		secretKey  = configuration.get("app.s3path.bdp.secretKey");



		// 신규파일 등록시 파일정보 갱신
		if(newFileFlag) {
			for(int i=0; i<uploadFiles.length; i++) {
				S3FileUtil s3FileUtil = new S3FileUtil();
				chgNameFileArr = s3FileUtil.uploadImageFiles( File.separator + folderName, nameSeparator, chgNameFileArr,uploadFiles);
				org_img_name = uploadFiles[i].getOriginalFilename();
				org_img_name = org_img_name.substring(org_img_name.lastIndexOf("\\")+1);

				chg_img_name = chgNameFileArr[i];
				img_path = Config.get("app.pandora3front.file.path") + folderName + pathSeparator + chg_img_name;
				fl_ext = uploadFiles[i].getExtension();
				fl_size = (int)uploadFiles[i].getSize();
				String uploadPath ="";
				uploadPath = basePath;
//				File s3UploadFile = new File(img_path);

				String s3FileNm ="";
				if("local".equals(target)){
					s3FileNm = s3Url +bucketName+basePath+"/"+ chg_img_name;
				}else{
					basePath =configuration.get("app.s3info.bdp.upload.path");
					bucketName = configuration.get("app.s3info.bdp.bucketName");
					s3FileNm = s3Url +bucketName+"/"+basePath+"/"+ chg_img_name;
				}

				FileUtil.deleteFile(img_path);

				s3FileUtil.s3UploadRol(bucketName,  uploadPath, img_path, chg_img_name);
				if("local".equals(target)){  //target이 로컬이면 key방식
					s3FileUtil.fileUploadS3(bucketName, accessKey, secretKey, basePath,img_path,chg_img_name);

				}else{ //그렇지 않으면 롤방식
					s3FileUtil.s3UploadRol(bucketName,  basePath, img_path, chg_img_name);
				}

				//String s3FileUrl ="";
				//s3FileUrl = s3Path +chg_img_name ;

				TbbsDocInf tbbsDocInf = new TbbsDocInf();
				tbbsDocInf.setDoc_seq(Integer.parseInt(parameterMap.getValue("doc_seq")));
				tbbsDocInf.setModl_seq(Integer.parseInt(parameterMap.getValue("modl_seq")));
				tbbsDocInf.setUsr_id(parameterMap.getUserInfo().getUser_id());
				tbbsDocInf.setCrtr_id(parameterMap.getUserInfo().getUser_id());
				tbbsDocInf.setUpdr_id(parameterMap.getUserInfo().getUser_id());
				tbbsDocInf.setSrc_fl_nm(org_img_name);
				tbbsDocInf.setUpl_fl_nm(s3FileNm);
				tbbsDocInf.setFl_ext(fl_ext);
				tbbsDocInf.setFl_size(fl_size);
				tbbsDocInf.setIp_addr(parameterMap.getUserInfo().getLast_access_ip_addr());
				tbbsDocInf.setThumb_yn(parameterMap.getValue("thumb_yn"));
				tbbsDocInfDao.insertTbbsFlInfInfo(tbbsDocInf);
			}
		}
	}

}
