package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.exception.UtilException;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pcommon.dto.TsysHcoInf;
import kr.co.ta9.pandora3.psys.dao.TsysHcoInfDao;
/**
* <pre>
* 1. 클래스명 : Psys1024Mgr
* 2. 설명: 도움말 서비스
* 3. 작성일 : 2018-04-25
* 4.작성자   : TANINE
* </pre>
*/
@Service
public class Psys1024Mgr {
	
	@Autowired
	private TsysHcoInfDao tsysHcoInfDao;
	
	/**
	 * 도움말 리스트 조회 (그리드형)
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */	
	public JSONObject getTsysHcoInfList(ParameterMap parameterMap) throws Exception{
		return tsysHcoInfDao.getTsysHcoInfList(parameterMap);
	}
	
	/**
	 * 메뉴 리스트 조회
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject getTsysAdmMnuList(ParameterMap parameterMap) throws Exception {
		return tsysHcoInfDao.getTsysAdmMnuList(parameterMap);
	}
	
	/**
	 * 도움말 등록/수정 (단건)
	 * @param parameterMap
	 * @throws Exception
	 */
	public void saveTsysHcoInf(ParameterMap parameterMap) throws Exception {
		TsysHcoInf tsysHcoInf = (TsysHcoInf)parameterMap.populate(TsysHcoInf.class);
		// 에디터로 등록한 경우
		if("Y".equals(parameterMap.getValue("editor_yn")))
			tsysHcoInf.setHco_cts(TextUtil.removeXss(tsysHcoInf.getHco_cts()));
		if("Y".equals(parameterMap.getValue("insert_yn"))) {
			int result = tsysHcoInfDao.selectTsysHcoInfCnt(parameterMap);
			
			if(result > 0){
				throw new UtilException("이미 등록된 데이터입니다.");
			} else {
				tsysHcoInfDao.insert(tsysHcoInf);
			}
			
		} else {
			tsysHcoInfDao.update(tsysHcoInf);
		}
	}
	
	/**
	 * 도움말 삭제
	 * @param parameterMap
	 * @throws Exception
	 */
	public void deleteTsysHcoInf(ParameterMap parameterMap) throws Exception {

		List<TsysHcoInf> insertList = new ArrayList<TsysHcoInf>();
		List<TsysHcoInf> updateList = new ArrayList<TsysHcoInf>();
		List<TsysHcoInf> deleteList = new ArrayList<TsysHcoInf>();
		parameterMap.populates(TsysHcoInf.class, insertList, updateList, deleteList);
		
		TsysHcoInf[] delete = deleteList.toArray(new TsysHcoInf[0]);
		
		tsysHcoInfDao.deleteMany(delete); 
	}
	
	/**
	 * 도움말 정보 조회 (그리드형)
	 * @param parameterMap
	 * @return JSONObject
	 * @throws Exception
	 */	
	public JSONObject getTsysHcoInfGrid(ParameterMap parameterMap) throws Exception{
		return tsysHcoInfDao.getTsysHcoInfGrid(parameterMap);
	}
}
