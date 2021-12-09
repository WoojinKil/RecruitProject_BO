package kr.co.ta9.pandora3.pbbs.controller;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.GetObjectRequest;
import com.amazonaws.services.s3.model.S3Object;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.common.conf.Configuration;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.pbbs.manager.Pbbs5001Mgr;

/**
* <pre>
* 1. 클래스명 : Pbbs5001Controller
* 2. 설명 : 위키관리(*TODO_CHG_NM) 컨트롤러
* 3. 작성일 : 2020-04-06
* 4. 작성자 : TANINE
* </pre>
*/
@Controller
public class Pbbs5001Controller extends CommonActionController{

	@Autowired
	private Pbbs5001Mgr pbbs5001Mgr;

	/**
	 * 위키 트리 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pbbs/getPbbs5001List01", method = RequestMethod.POST)
	public void getPbbs5001List01(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 파라미터 취득
		ParameterMap parameterMap = getParameterMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// 위키카테고리 트리 조회
			json = pbbs5001Mgr.getPbbs5001List01(parameterMap);
		} catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 위키 트리 삭제 (하위TREE 포함)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pbbs/deletePbbs5001List01", method = RequestMethod.POST)
	public void deletePbbs5001List01(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 파라미터 취득
		ParameterMap parameterMap = getParameterMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			//삭제 대상(필수 파라미터) 확인 (id) : 값이 있고, 숫자형태인지 확인
			if (!StringUtils.isEmpty(parameterMap.getValue("id")) && StringUtils.isNumeric(parameterMap.getValue("id"))) {
				// 위키 카테고리 트리 수정/삭제 (하위TREE 포함)
				pbbs5001Mgr.deletePbbs5001List01(parameterMap);
			} else {
				json.put("ERR_CODE", Const.ACCIDENT_CASE);
			}
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 위키 트리 등록/수정
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pbbs/savePbbs5001List01", method = RequestMethod.POST)
	public void savePbbs5001List01(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 파라미터 취득
		ParameterMap parameterMap = getParameterMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();

		try {
			//위키 트리 등록/수정
			int rtn_wiki_ctegry_seq = pbbs5001Mgr.savePbbs5001List01(parameterMap);
			//정상 처리된 결과면 json에 트리 아이디 값 담기
			if (rtn_wiki_ctegry_seq > -1) {
				json.put("rtn_wiki_ctegry_seq", rtn_wiki_ctegry_seq);
			}
		}
		catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}
		// json에 전체 처리결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 위키 카테고리 별 게시글 목록 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getPbbs5001List03", method=RequestMethod.POST)
	public void getPdsp1004List03(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 파라미터 취득
		ParameterMap parameterMap = getParameterMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();

		try {
			//위키 카테고리 별 게시글 목록 조회
			json = pbbs5001Mgr.getPbbs5001GridList01(parameterMap);
		}
		catch (Exception e) {
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 ** 위키 메뉴얼 등록 /수정
	 * - 등록 : 메뉴얼 등록 + 첨부파일 매핑
	 * - 수정 : 메뉴얼 수정
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/savePbbs5002WikiAll")
	public void savePbbs5002WikiAll(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			//위키 메뉴얼 등록 /수정
			int rtn_wiki_doc_seq = pbbs5001Mgr.savePbbs5002WikiAll(parameterMap);
			//정상처리 시 처리된 wiki_doc_seq 반환
			if (rtn_wiki_doc_seq > -1) {
				json.put("rtn_wiki_doc_seq", rtn_wiki_doc_seq);
			}
		} catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 위키 메뉴얼 첨부 파일 등록
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/insertPbbs5002Wikibbsfle")
	public void insertPbbs5002Wikibbsfle(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			//위키 메뉴얼 첨부 파일 정보 저장 (화면용 리턴값 취득)
			List<Map<String, Object>> fileChkList = pbbs5001Mgr.insertPbbs5002Wikibbsfle(parameterMap);
			json.put("fileChkList", fileChkList);

		} catch(Exception e) {
			log.error(e.toString());
			
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 위키 메뉴얼 첨부 파일 삭제
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/deletePbbs5002Wikibbsfle")
	public void deletePbbs5002Wikibbsfle(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// 게시판 파일 정보 삭제
			int delCnt = pbbs5001Mgr.deletePbbs5002Wikibbsfle(parameterMap);
			if (delCnt <= 0) {
				result = Const.BOOLEAN_FAIL;
			}
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 위키트리  카테고리/명 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getPbbs5002List01", method=RequestMethod.POST)
	public void getPbbs5002List01(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			json = pbbs5001Mgr.getPbbs5002List01(parameterMap);
		}
		catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
			log.error(e.toString());
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 위키 메뉴얼 상세 정보 조회 (첨부파일 포함)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pbbs/getWikibbsAndFleInfo", method = RequestMethod.POST)
	public void getWikibbsAndFleInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 파라미터 취득
		ParameterMap parameterMap = getParameterMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// 위키 메뉴얼 상세 정보 조회 (첨부파일 포함)
			json = pbbs5001Mgr.getWikibbsAndFleInfo(parameterMap);
		} catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 위키 메뉴얼 상세 정보 조회 (프론트용)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pbbs/getWikibbsFrontDtl", method = RequestMethod.POST)
	public void getWikibbsFrontDtl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 파라미터 취득
		ParameterMap parameterMap = getParameterMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// 위키 메뉴얼 상세 정보 조회 (프론트용)
			json = pbbs5001Mgr.getWikibbsFrontDtl(parameterMap);
			// 정상적으로 조회가 되었는지 확인
			if (json.containsKey("bbsInfo")) {
				//게시글이 있으면 조회수 증가
				pbbs5001Mgr.updatePbbsInqCnt(parameterMap);
			}
		} catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
			e.printStackTrace();
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 파일 다운로드 (위키 메뉴얼)
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@RequestMapping(value="/pbbs/filedownloads3")
	public void getS3File(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//변수 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		OutputStream out = null;
		InputStream inputStream = null;
		BufferedReader reader = null;
		int bufferSize = 1024;
		String FullPath = "";

		//브라우저 체크용 userAgent
		String header = request.getHeader("User-Agent");
		if (header.indexOf("Chrome") > -1 ||  header.indexOf("Trident") > -1  ) header = "Chrome";

		//PrintWriter 선언
		PrintWriter printWriter = null;
		try {
			String db_file_full_path = "";
			String db_file_org_name = "";
			Map<String,Object> fileMap = pbbs5001Mgr.getWikibbsfleOne(parameterMap);
			if (fileMap != null) {
				if (fileMap.get("ATCH_FL_PTH_NM") != null && fileMap.get("ATCH_FL_PTH_NM") instanceof String) {
					db_file_full_path = String.valueOf(fileMap.get("ATCH_FL_PTH_NM"));
				}
				if (fileMap.get("ORGN_FL_NM") != null && fileMap.get("ORGN_FL_NM") instanceof String) {
					db_file_org_name = String.valueOf(fileMap.get("ORGN_FL_NM"));
				}
			}
			if(!StringUtils.isEmpty(db_file_full_path) && !StringUtils.isEmpty(db_file_org_name)) {
				FullPath =db_file_full_path; //Config.get("app.file.download.path") + File.separator + db_file_full_path;
				// 파일명 공백 및 Chrome 브라우저 특수문자 처리
				String fileName = "";
				String s3FileName = "";
				String lastIndexStr = "/";
				s3FileName = FullPath.substring(FullPath.lastIndexOf(lastIndexStr)+1);
				if(!"Chrome".equalsIgnoreCase(header)) {
					fileName = URLEncoder.encode(db_file_org_name, "UTF-8").replaceAll("\\+", "%20");
					s3FileName = URLEncoder.encode(s3FileName, "UTF-8").replaceAll("\\+", "%20");
				}
				else {
					StringBuilder sb = new StringBuilder();
					for (int i = 0; i < db_file_org_name.length(); i++) {
						char c = db_file_org_name.charAt(i);
						if (c > '~') {
							sb.append(URLEncoder.encode("" + c, "UTF-8"));
						}
						else {
							sb.append(c);
						}
					}
					fileName = sb.toString();
				}
				Configuration configuration = Configuration.getInstance();
				//String s3Url = configuration.get("app.amazone.s3.url");
				String bucketName = configuration.get("app.s3path.bdp.bucketName");
				String accessKey  = configuration.get("app.s3path.bdp.accessKey");
				String secretKey  = configuration.get("app.s3path.bdp.secretKey");
				String basePath = configuration.get("app.s3path.bdp.upload.path");
				//파일 다운로드 다운로드 경로와 파일이름 동시 필요.
				AWSCredentials awsCredentials = new BasicAWSCredentials(accessKey, secretKey);
				AmazonS3 amazonS3 = AmazonS3ClientBuilder.standard()
						.withCredentials(new AWSStaticCredentialsProvider(awsCredentials))
						.withRegion("ap-northeast-2")
						.build();
				response.setContentType("binary/octet-stream");
				response.addHeader("Content-disposition", "attachment; filename=" + fileName);

				S3Object object = amazonS3.getObject(new GetObjectRequest(bucketName+basePath, s3FileName));
				inputStream = object.getObjectContent();
				out = response.getOutputStream();
				byte[] bytes = new byte[bufferSize];
				int size = 0;
				while (-1 != (size = inputStream.read(bytes))) {
					out.write(bytes, 0, size);
				}
				out.flush();

			} else {
				throw new IllegalArgumentException("file not found");
			}
		} catch(FileNotFoundException e){
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			printWriter = response.getWriter();
			printWriter.println("<script type='text/javascript'>alert('해당 파일이 존재하지 않습니다.'); window.onload=window.close();</script>");
			printWriter.flush();
		} finally {
			try {
				inputStream.close();
				if(reader != null)
					 reader.close();
			  } catch (Exception e) {log.debug(e);}
			try { out.close(); } catch (Exception e) {log.debug(e);}
		}
	}

	/**
	 * 위키 메뉴얼 기본 목록 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pbbs/getPbbs5004BbsList", method = RequestMethod.POST)
	public void getPbbs5004BbsList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 파라미터 취득
		ParameterMap parameterMap = getParameterMap(request, response);
		// 결과 담는 result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// jsonObject json 선언
		JSONObject json = new JSONObject();
		try {
			// 위키 메뉴얼 기본 목록 조회
			json = pbbs5001Mgr.getPbbs5004BbsDefault(parameterMap);
		} catch (Exception e) {
			// Exception일 경우
			result = Const.BOOLEAN_FAIL;
		}

		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
}
