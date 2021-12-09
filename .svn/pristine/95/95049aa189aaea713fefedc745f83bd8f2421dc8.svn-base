package kr.co.ta9.pandora3.system.manager;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.pmbr.dao.TmbrConnLogDao;

@Service
public class SysCounterLogMgr {

//	private final Log log = LogFactory.getLog(SysCounterLogMgr.class);
	
	@Autowired
	private TmbrConnLogDao tmbrConnLogDao;
	
	
	/**
	 * 방문자수/페이지뷰수 조회 : 대시보드
	 * @param  
	 * @return 
	 * @throws Exception
	 */
	public  JSONObject selectVisitorPageviewCountList() throws Exception {
		return tmbrConnLogDao.selectTmbrConnSttsVisrAcsCntMapList();
	}
}
