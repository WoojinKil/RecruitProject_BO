package kr.co.ta9.pandora3.linkruit.controller;

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
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.linkruit.manager.RecruitNoticeMgr;

@Controller
public class RecruitNoticeController extends CommonActionController{

	@Autowired
	private RecruitNoticeMgr recruitNoticeMgr;
	
	
	//채용공고 조회
	@RequestMapping(value="/linkruit/getRecruitNoticeList", method=  RequestMethod.POST)
	public void getRecruitNoticeList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		System.out.println("getRecruitNoticeList controller 진입");
		ParameterMap parameterMap = getParameterGridMap(request, response);
		
		String result = Const.BOOLEAN_SUCCESS;
		JSONObject json = new JSONObject();
		
		try {
			System.out.println("mgr 진입시도");
			json = recruitNoticeMgr.selectRecruitNoticeGridList(parameterMap);
			System.out.println("진입성공");
		} catch (Exception e) {
			// TODO: handle exception
			result = Const.BOOLEAN_FAIL;
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
		
	}
	
	
	//채용공고 저장
	@RequestMapping(value="/linkruit/saveRecruitNotice1", method = RequestMethod.POST)
	public void saveRecruitNotice1(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ParameterMap parameterMap = getParameterMap(request, response);
		
		String result = Const.BOOLEAN_SUCCESS;
		
		JSONObject json = new JSONObject();
		System.out.println("/linkruit/saveRecruitNotice1 Controller 진입");
		
		try {
			
			recruitNoticeMgr.saveRecruitNotice(parameterMap);
			
		} catch (Exception e) {
			// TODO: handle exception
			result = Const.BOOLEAN_FAIL;
			
			json.put("MSG",parameterMap.getValue("MSG"));
			
			
		}
		
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
		System.out.println("/linkruit/saveRecruitNotice1 Controller 처리완료");
	}
	
	@RequestMapping(value="/linkruit/saveRecruitNotice", method= RequestMethod.POST)
	public void saveRecruitNotice(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("/linkruit/saveRecruitNotice Controller 진입");
		ParameterMap parameterMap = getParameterMap(request, response);
		
		String result= Const.BOOLEAN_SUCCESS;
		
		JSONObject json = new JSONObject();
		

		try {
			
			recruitNoticeMgr.saveAll(parameterMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
			json.put("MSG", parameterMap.getValue("MSG"));
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());

		System.out.println("/linkruit/saveRecruitNotice Controller 처리완료");
	}
	
}
