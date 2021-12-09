package kr.co.ta9.pandora3.pbbs.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.app.servlet.controller.CommonActionController;
import kr.co.ta9.pandora3.app.util.DrmFileUtil;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.servlet.download.FileDownLoad;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.pbbs.manager.Pbbs1004Mgr;
/**
* <pre>
* 1. 클래스명 : Pbbs1004Controller
* 2. 설명 : 통합게시글조회 컨트롤러
* 3. 작성일 : 2018-04-09
* 4.작성자   : TANINE
* </pre>
*/
@Controller
public class Pbbs1004Controller extends CommonActionController {

	@Autowired
	private Pbbs1004Mgr pbbs1004Mgr;

	/**
	 * 일반 컨텐츠
	 * BOARD : 게시글 목록 조회(그리드형)
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getPbbs1004DocList", method=RequestMethod.POST)
	public void getPbbs1004DocList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// 일반컨텐츠 : 게시글 목록 조회(그리드형)
			json = pbbs1004Mgr.getTbbsDocInfDocList(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 일반 컨텐츠
	 * BOARD : 게시글 복원/공지전환/완전삭제(그리드형)
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/savePbbs1004DocList", method=RequestMethod.POST)
	public void savePbbs1004DocList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// 일반 컨텐츠 : 게시글 복원/공지전환/완전삭제(그리드형)
			pbbs1004Mgr.saveTbbsDocInfList(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 엑셀다운로드
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getPbbs1004XlsxDwld")
	public void getPbbs1004XlsxDwld(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);

		// 일반 컨텐츠 : 게시글 목록 조회(그리드형)
		 JSONObject json = pbbs1004Mgr.getTbbsDocInfDocList(parameterMap);
		// 그리드 헤더 선언
		Map<String,String> gridHeader = parameterMap.parseGridHeader();
		List<Map<String, String>> gridList = (List<Map<String, String>>)json.get("rows");
		for(int i = 0; i < gridList.size(); i++) {
			if(Const.BOOLEAN_TRUE.equals(gridList.get(i).get("NOTC_YN"))) {
				gridList.get(i).replace("NOTC_YN", "공지");
			}else if(Const.BOOLEAN_FALSE.equals(gridList.get(i).get("NOTC_YN"))) {
				gridList.get(i).replace("NOTC_YN", "일반");
			}
			if("1".equals(gridList.get(i).get("TREATMENT_CD"))) {
				gridList.get(i).replace("TREATMENT_CD", "등록완료");
			}else if("2".equals(gridList.get(i).get("TREATMENT_CD"))) {
				gridList.get(i).replace("TREATMENT_CD", "답변준비중");
			}else if("3".equals(gridList.get(i).get("TREATMENT_CD"))) {
				gridList.get(i).replace("TREATMENT_CD", "답변완료");
			}
			if("PUBLIC".equals(gridList.get(i).get("OTP_STAT"))) {
				gridList.get(i).replace("STATUS", "공개");
			}else if("SECRET".equals(gridList.get(i).get("OTP_STAT"))) {
				gridList.get(i).replace("STATUS", "비공개");
			}
		}
		// 엑셀다운로드
		String fileNm = parameterMap.getValue("filename");
		//FileDownLoad.exportExcelXslx(request,response, gridHeader, gridList,fileNm);
		//DrmFileUtil.exportExcelXslx(request,response,gridHeader, gridList,fileNm);
		FileDownLoad.exportExcelXslx(request,response,gridHeader, gridList,fileNm);

	}

	/**
	 * 게시판 모듈 목록 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pbbs/getPbbs1004ModlTpList", method=RequestMethod.POST)
	public void getPbbs1004ModlTpList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ParameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// Result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// JSONObject 선언
		JSONObject json = new JSONObject();

		try {
			// 게시판 모듈 목록 조회
			json = pbbs1004Mgr.selectTbbsModlInfTypeList(parameterMap);
		}catch(Exception e) {
			result = Const.BOOLEAN_FAIL;
		}

		// JSONObject 결과값 반환
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

}
