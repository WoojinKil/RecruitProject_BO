package kr.co.ta9.pandora3.pbbs.controller;

import java.util.ArrayList;
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
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.exception.AppException;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.pbbs.manager.Pbbs4001Mgr;
import kr.co.ta9.pandora3.pbbs.manager.PbbsCommonMgr;

/**
* <pre>
* 1. 클래스명 : Bpcm4001Controller
* 2. 설명 : 공지사항
* 3. 작성일 : 2019-12-10
* 4.작성자   : KHE
* </pre>
*/
@Controller
public class Pbbs4001Controller extends CommonActionController {

	@Autowired
	private Pbbs4001Mgr pbbs4001Mgr;

	@Autowired
	private PbbsCommonMgr pbbsCommonMgr;

	/**
	 * 공지사항 목록 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/bpcm/getBpcm4001List", method=RequestMethod.POST)
	public void getBpcm4001List(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			parameterMap.put("dsply_stat", "게시중");
			parameterMap.put("front_notice_yn", "공지");
			json = pbbs4001Mgr.selectNoticeList(parameterMap);
		}catch (AppException e) {
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 공지 상세 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/bpcm/getBpcm4001Dtl", method=RequestMethod.POST)
	public void getBpcm4001Dtl(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();

		// 공통 : 질문답변형 게시판 상세 조회(첨부파일)
		List<Map<String,Object>> tbbsFlInfMapList = new ArrayList<Map<String,Object>>();
		try {

			json = pbbs4001Mgr.selectNoticeDtl(parameterMap);

			tbbsFlInfMapList = pbbsCommonMgr.selectTbbsFlInfListMap(parameterMap);

			json.put("tbbsFlInfMapList", tbbsFlInfMapList);
		}catch (AppException e) {
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

	/**
	 * 카테고리 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/bpcm/getBoardCtgList", method=RequestMethod.POST)
	public void getBoardCtgList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {

			json = pbbs4001Mgr.selectBoardCtgList2(parameterMap);
		}catch (AppException e) {
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 게시판 명 검색조건 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/bpcm/getModlNm", method=RequestMethod.POST)
	public void getModlNm(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {

			json = pbbs4001Mgr.getModlNm(parameterMap);
		}catch (AppException e) {
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	
	/**
	 * 공지사항 제목,내용 조회
	 * @param  request
	 * @param  response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/bpcm/getDocInfo", method=RequestMethod.POST)
	public void getDocInfo(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// parameterMap 선언
		ParameterMap parameterMap = getParameterGridMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {

			json = pbbs4001Mgr.getDocInfo(parameterMap);
		}catch (AppException e) {
			log.error(e.toString());
			result = Const.BOOLEAN_FAIL;
		} catch (Exception e) {
			result = Const.BOOLEAN_FAIL;
		}
		// json에 결과 담기
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}

}
