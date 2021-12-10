package kr.co.ta9.pandora3.linkruit.controller;

import java.util.ArrayList;
import java.util.List;

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
import kr.co.ta9.pandora3.common.servlet.Parameter;
import kr.co.ta9.pandora3.common.util.ResponseUtil;
import kr.co.ta9.pandora3.linkruit.dto.BaseApplicantDto;
import kr.co.ta9.pandora3.linkruit.manager.ApplicantMgr;

@Controller
public class ApplicantController extends CommonActionController {

	@Autowired
	ApplicantMgr applicantMgr;
	
	
	//더블클릭한 공고의 지원자를 보기 위한 리스트
	@RequestMapping(value = "/linkruit/getApplicantList", method = RequestMethod.POST)
	public void getApplicantList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ParameterMap parameterMap = getParameterGridMap(request, response);
		System.out.println("파라미터값"+parameterMap);
		String result = Const.BOOLEAN_SUCCESS;
		
		JSONObject json = new JSONObject();
			
		try {
			json = applicantMgr.selectApplicantGridList(parameterMap);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
			
		}
		
		json.put("RESULT",result);
		ResponseUtil.write(response, json.toJSONString());
		
		
	}
	
	@RequestMapping(value = "/linkruit/saveApplicant2", method = RequestMethod.POST)
	public void saveApplicant2(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		ParameterMap parameterMap = getParameterMap(request, response);
		// result 선언
		String result = Const.BOOLEAN_SUCCESS;
		// json 선언
		JSONObject json = new JSONObject();
		try {
			applicantMgr.saveApplicant2(parameterMap);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			json.put("MSG", parameterMap.getValue("MSG"));
			
		}
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
	}
	

}
