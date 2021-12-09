package kr.co.ta9.pandora3.app.util;

import java.io.File;

import org.springframework.beans.factory.annotation.Value;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.auth.InstanceProfileCredentialsProvider;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.AccessControlList;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.CanonicalGrantee;
import com.amazonaws.services.s3.model.GroupGrantee;
import com.amazonaws.services.s3.model.Permission;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.PutObjectResult;
import com.amazonaws.services.securitytoken.AWSSecurityTokenService;
import com.amazonaws.services.securitytoken.AWSSecurityTokenServiceClientBuilder;
import com.amazonaws.auth.STSAssumeRoleSessionCredentialsProvider;

import kr.co.ta9.pandora3.common.conf.Config;
import kr.co.ta9.pandora3.common.conf.Configuration;
import kr.co.ta9.pandora3.common.servlet.upload.UploadFile;
import kr.co.ta9.pandora3.common.util.DateUtil;

public class S3FileUtil {

	private Configuration configuration = Configuration.getInstance();
	private String cloudAwsRegionStatic = configuration.get("cloud.aws.region.static");
	private String cloudAwsCredentialsAssumeRole = configuration.get("app.s3info.bdp.cloud.aws.credentials.assume.role");

	private String iamCanonicalId = configuration.get("iam.canonical.id");
	private String targetCanonicalId = configuration.get("target.canonical.id");
	//private String cicdCanonicalId = configuration.get("cicd.canonical.id");
	//private String sltnCanonicalId = configuration.get("sltn.canonical.id");
	/**
	 * 이미지 파일 등록(파일 서버 저장)
	 * @param uploadFiles
	 * @param targetUrl
	 * @throws Exception
	 * @throws ConfigurationException
	 */
	public String[] uploadImageFiles( String targetPath, String separator, String[] returnArr ,UploadFile... uploadFiles) throws Exception {

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
	 * S3 파일업로드
	 * @param String bucketName, String accessKey, String secretKey, String folderPath(S3저장할폴더경로), String filePath(S3전송할로컬파일경로), String fileName(파일명)
	 * @param String returnStr(S3전송할로컬파일경로)
	 */
	public boolean fileUploadS3(String bucketName, String accessKey, String secretKey, String folderPath, String filePath, String fileName) throws Exception {

		boolean flag = false;

		AWSCredentials awsCredentials = new BasicAWSCredentials(accessKey, secretKey);
		AmazonS3 amazonS3 = AmazonS3ClientBuilder.standard()
				.withCredentials(new AWSStaticCredentialsProvider(awsCredentials))
				.withRegion("ap-northeast-2")
				.build();
		String uploadPath = folderPath;
		try {
			File file = new File(filePath);
			PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName + uploadPath, fileName, file);
			putObjectRequest.setCannedAcl(CannedAccessControlList.PublicRead);
			amazonS3.putObject(putObjectRequest);
			flag = true;
		} catch (AmazonServiceException ase) {
			ase.printStackTrace();
		} finally {
			/*
			if(amazonS3 != null){
				//amazonS3.close
				amazonS3 = null;
			}
			*/

		}

		return flag;
	}

	/**
	 * S3 파일삭제
	 * @param String bucketName, String accessKey, String secretKey, String folderPath(S3삭제할폴더경로), String filePath(S3전송할로컬파일경로), String fileName(파일명)
	 * @param String returnStr(S3전송할로컬파일경로)
	 */
	public boolean fileDeleteS3(String bucketName, String accessKey, String secretKey, String folderPath, String fileName){

		boolean flag = false;

		AWSCredentials awsCredentials = new BasicAWSCredentials(accessKey, secretKey);
		AmazonS3 amazonS3 = AmazonS3ClientBuilder.standard()
				.withCredentials(new AWSStaticCredentialsProvider(awsCredentials))
				.withRegion("ap-northeast-2")
				.build();
		String uploadPath = folderPath;

		try {
			amazonS3.deleteObject(bucketName + uploadPath, fileName);
			flag = true;
		} catch (AmazonServiceException ase) {
			ase.printStackTrace();
		} finally {
			//amazonS3 = null;
		}

		return flag;
	}
	public void s3UploadRol(String bucketName, String folderPath, String filePath, String fileName) {
	      /*
	       * 권한
	       * Permission.FullControl: read, read ACL, write ACL
	       * Permission.Read: read
	       * Permission.ReadAcp: read ACL
	       * Permission.WriteAcp: write ACL
	       * owner는 cloud.aws.credentials.assume.role 설정한 계정
	       */

		AmazonS3 s3Client =  AmazonS3ClientBuilder.standard()
	        .withCredentials(awsCredentialsProviderForInstanceProfile())
	        .withRegion(cloudAwsRegionStatic)
	        .build();
	      AccessControlList acl = new AccessControlList();
	      CanonicalGrantee owner = new CanonicalGrantee(iamCanonicalId);
	      CanonicalGrantee devAccount = new CanonicalGrantee(targetCanonicalId);
	      acl.grantPermission(owner, Permission.FullControl);
	      acl.grantPermission(devAccount, Permission.Read);
	      acl.grantPermission(devAccount, Permission.ReadAcp);
	      acl.grantPermission(devAccount, Permission.WriteAcp);
	      /*
	      acl.grantPermission(prdAccount, Permission.Read);
	      acl.grantPermission(prdAccount, Permission.ReadAcp);
	      acl.grantPermission(prdAccount, Permission.WriteAcp);
	      */
	      // 아래 권한은 정적파일를 S3 올리고 웹호스팅 기능을 사용하는 경우만 추가
	      String objKey=folderPath+"/"+fileName;  //S3에 업로드될 파일 경로
	      File file = new File(filePath);
	      acl.grantPermission(GroupGrantee.AllUsers, Permission.Read);
	      s3Client
          .putObject(new PutObjectRequest(bucketName, objKey, file)
          .withAccessControlList(acl));
	      /*
	      PutObjectResult putObjectResult = s3Client
	          .putObject(new PutObjectRequest(bucketName, objKey, file)
	          .withAccessControlList(acl));
	          */

	    }

	 public AWSCredentialsProvider awsCredentialsProviderForInstanceProfile() {

	        AWSSecurityTokenService stsClient = AWSSecurityTokenServiceClientBuilder.standard()
	                .withRegion(cloudAwsRegionStatic)
	                // 인스턴스 프로파일 인증 방식일 경우
	                .withCredentials(new InstanceProfileCredentialsProvider(false))
	                .build();
	        return new STSAssumeRoleSessionCredentialsProvider
	            .Builder(cloudAwsCredentialsAssumeRole, "sample-s3-role")
	            .withStsClient(stsClient)
	            .build();
	    }

}
