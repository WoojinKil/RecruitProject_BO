package kr.co.ta9.pandora3.pbbs.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.common.conf.Config;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.pbbs.manager.PbbsCommonMgr;

/**
* <pre>
* 1. 클래스명 : PbbsCommonController
* 2. 설명: 통합게시글 공통 컨트롤러
* 3. 작성일 : 2018-04-11
* 4.작성자   : TANINE
* </pre>
*/
@Controller
public class PbbsCommonController extends CommonActionController{

	@Autowired
	private PbbsCommonMgr pbbsCommonMgr;

	/**
	 * 게시판 임시 정보 저장
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getPbbsDocSeq")
	public void getPbbsDocSeq(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			UserInfo userInfo = parameterMap.getUserInfo();
			if(userInfo != null){
				parameterMap.put("ip_addr", userInfo.getLast_access_ip_addr());
				// 게시판 정보 임시 저장
				int doc_seq = pbbsCommonMgr.insertTbbsTmpDocInf(parameterMap);
				if(doc_seq > 0) {
					json.put("doc_seq", doc_seq);
				}else {
					result = Const.BOOLEAN_FAIL;
				}
			}

		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
     * CKEDITER 이미지 업로드
     * @param request
     * @param response
     * @param upload
     */
    @RequestMapping(value = "/board/updateImageUpload", method = RequestMethod.POST)
    public void updateImageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) {
        // OutputStream 선언
        OutputStream out = null;
        // PrintWriter 선언
        PrintWriter printWriter = null;
        // utf-8로 인코딩
        response.setCharacterEncoding("utf-8");
        // 컨텐트 타입 text/html; charset=utf-8로 세팅
        response.setContentType("text/html;charset=utf-8");
        try {
            // fileName 선언
            String fileName = upload.getOriginalFilename();
            // file ext 취득
//          String ext = fileName.substring(fileName.lastIndexOf(".")+1,fileName.length());
            String ext = fileName.substring(fileName.lastIndexOf('.')+1,fileName.length());
            // 이미지 파일 확장자 유효성 검사용 프로터티 취득
            String[] validExt = Config.get("file.upload.img.valid.ext").split("\\|");
            // printWriter 선언
            printWriter = response.getWriter();

            // 유효성 검사용 플래그
            boolean validFlag = false;
            for(int i = 0; i < validExt.length; i++) {
                if(validExt[i].equalsIgnoreCase(ext)) {
                    validFlag = true;
                    break;
                }
            }
            // 검사 결과가 유효하면, 파일을 생성
            if(validFlag) {
                // bytes 선언
                byte[] bytes = upload.getBytes();
                // uploadPath 선언
                String uploadPath = Config.get("app.message.file.upload.ckediter.path") + File.separator + fileName;//저장경로
                // fileDir 선언
                File fileDir = new File(Config.get("app.message.file.upload.ckediter.path"));
                if(!fileDir.isDirectory()){
                    // 파일경로에 폴더 없을 경우 폴더 생성
                    fileDir.mkdirs();
                }

                // OutputStream에 fileOutputStream uploadPath로 생성
                out = new FileOutputStream(new File(uploadPath));
                // bytes 쓰기
                out.write(bytes);

                // callback 선언
                String callback = request.getParameter("CKEditorFuncNum");

                // fileUrl 선언
                String fileUrl = Config.get("app.message.file.ckediter.path") + fileName;//url경로
                //fileUrl`
                fileUrl = fileUrl.replace("/", "");
                fileUrl = fileUrl.replace("&", "");
                fileUrl = fileUrl.replace("\"", "");
                fileUrl = fileUrl.replace("\\", "");
                printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
                        + callback
                        + ",'"
                        + fileUrl
                        + "','이미지를 업로드 하였습니다.'"
                        + ")</script>");
                printWriter.flush();
            }else {
                printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
                        + "1"
                        + ",'"
                        + ""
                        + "','유효한 이미지 파일이 아닙니다.'"
                        + ")</script>");
                printWriter.flush();
            }

        }catch(Exception e) {
            // Exception 일 경우
        }finally {
            try {
                if(out != null) {
                    // out이 null이 아닐경우 out 닫기
                    out.close();
                }
                if(printWriter != null) {
                    // printWriter가 null이 아닐경우 printWriter 닫기
                    printWriter.close();
                }
            }catch (Exception e) {
                // Exception 일 경우
            }
        }
        return;
    }

    /**
	 * 게시판 파일 정보 저장
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/insertTbbsFlInf")
	public void insertBoardFileInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();
		// Return List 선언
		List<Map<String, Object>> fileChkList = new ArrayList<Map<String, Object>>();

		try {
			// 게시판 파일 정보 저장
			List<Map<String, Object>> sysFileInfo = pbbsCommonMgr.insertTbbsFlInf(parameterMap);
			String[] fileChkArr = parameterMap.getValue("fileChkArr").split(",");
			for(int i = 0; i < sysFileInfo.size(); i++) {
				Map<String, Object> fileChkMap = new HashMap<String, Object>();
//				fileChkMap.put("file_id", fileChkArr[i].toString());
				fileChkMap.put("file_id", fileChkArr[i]);
				fileChkMap.put("file_srl", sysFileInfo.get(i).get("file_srl"));
				fileChkMap.put("file_nm", sysFileInfo.get(i).get("file_nm"));
				fileChkMap.put("file_path", sysFileInfo.get(i).get("file_path"));
				fileChkMap.put("file_ext", sysFileInfo.get(i).get("file_ext"));
				fileChkList.add(fileChkMap);
			}
			json.put("fileChkList", fileChkList);
		}catch(Exception e) {
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 게시판 파일 정보 삭제
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/deleteTbbsFlInf")
	public void deleteBoardFileInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// 게시판 파일 정보 삭제
			int delCnt = pbbsCommonMgr.deleteTbbsFlInf(parameterMap);
			if(delCnt <= 0) {
				result = Const.BOOLEAN_FAIL;
			}
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

}
