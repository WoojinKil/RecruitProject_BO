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
import kr.co.ta9.pandora3.linkruit.manager.CareerMgr;

@Controller
public class CareerController extends CommonActionController {

	@Autowired
	private CareerMgr careerMgr;
	
	@RequestMapping(value = "/linkruit/getCareerList", method = RequestMethod.POST)
	public void getCareerList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ParameterMap parameterMap = getParameterGridMap(request, response);
		JSONObject json = new JSONObject();
		String result = Const.BOOLEAN_SUCCESS;
		
		
		try {
			json = careerMgr.selectCareerGridList(parameterMap);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = Const.BOOLEAN_FAIL;
			
		}
		
		json.put("RESULT", result);
		ResponseUtil.write(response, json.toJSONString());
		
	}

}
