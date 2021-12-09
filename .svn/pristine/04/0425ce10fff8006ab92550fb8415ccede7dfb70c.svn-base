package kr.co.ta9.pandora3.pdsp.manager;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.TdspMnPop;
import kr.co.ta9.pandora3.pdsp.dao.TdspMnPopDao;
/**
* <pre>
* 1. 클래스명 : Pdsp1005Mgr
* 2. 설명: 메인팝업관리
* 3. 작성일 : 2018-03-29
* 4.작성자   : TANINE
* </pre>
*/

@Service
public class Pdsp1005Mgr {
	
	@Autowired
	private TdspMnPopDao tdspMnPopDao;	
	
	/**
	 * 메인팝업목록(그리드형)
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTdspMnPopGridList(ParameterMap parameterMap) throws Exception {
		parameterMap.put("frnt_yn", "Y");
		return tdspMnPopDao.selectTdspMnPopGridList(parameterMap);
	}
	
	/**
	 * 팝업관리 > 메인팝업관리 (삭제 | 전시&비전시 처리 - 그리드형)
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTdspMnPopGridList(ParameterMap parameterMap) throws Exception {

		List<TdspMnPop> insertList = new ArrayList<TdspMnPop>();
		List<TdspMnPop> updateList = new ArrayList<TdspMnPop>();
		List<TdspMnPop> deleteList = new ArrayList<TdspMnPop>();
		
		// 변경 대상 추출
		String[] seq_no_arr = parameterMap.getArray("seq_no_arr[]");
		String chgFlag = parameterMap.getValue("chgFlag");
		TdspMnPop[] update = new TdspMnPop[seq_no_arr.length];
		String user_id = parameterMap.getUserInfo().getUser_id();
		for(int i=0; i<seq_no_arr.length; i++) {
			TdspMnPop mainPop = new TdspMnPop();
			mainPop.setMn_pop_seq(Integer.valueOf(seq_no_arr[i]));
			mainPop.setDsply_yn(chgFlag);
			mainPop.setUpdr_id(user_id);
			update[i] = mainPop;
		}
		
		// 삭제대상 추출
		parameterMap.populates(TdspMnPop.class, insertList, updateList, deleteList);	
		TdspMnPop[] delete = deleteList.toArray(new TdspMnPop[deleteList.size()]);
		
		if (seq_no_arr.length > 0) tdspMnPopDao.updateMany(update);
		if (!deleteList.isEmpty()) tdspMnPopDao.deleteMany(delete);
		
	}
}
