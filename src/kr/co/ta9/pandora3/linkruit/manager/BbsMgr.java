package kr.co.ta9.pandora3.linkruit.manager;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.linkruit.dao.BbsDao;
import kr.co.ta9.pandora3.linkruit.dto.ApplyDto;
import kr.co.ta9.pandora3.linkruit.dto.BaseBbsDto;

@Service
public class BbsMgr {

	@Autowired
	private BbsDao bbsDao;
	
	public JSONObject selectBbsGridList(ParameterMap parameterMap) throws Exception{
		return bbsDao.selectBbs(parameterMap);
	}
	
	public void saveBbs(ParameterMap parameterMap) throws Exception {
		
		List<BaseBbsDto> insertList = new ArrayList<BaseBbsDto>();
		List<BaseBbsDto> updateList = new ArrayList<BaseBbsDto>();
		List<BaseBbsDto> deleteList = new ArrayList<BaseBbsDto>();
		parameterMap.populates(BaseBbsDto.class, insertList, updateList, deleteList, "bbsData");
		System.out.println("parameterMap : "+parameterMap);
		
		BaseBbsDto[] insert = insertList.toArray(new BaseBbsDto[0]);
		BaseBbsDto[] update = updateList.toArray(new BaseBbsDto[0]);
		BaseBbsDto[] delete = deleteList.toArray(new BaseBbsDto[0]);
		
		System.out.println("insert시도");
		bbsDao.insertMany("Bbs.insert",insert);
		System.out.println("update시도");
		bbsDao.updateMany("Bbs.update",update);
		
		bbsDao.deleteMany("Bbs.delete",delete);
		
				
		
	}
}
