package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.TbBcPcHRrshopbuy;
import kr.co.ta9.pandora3.psys.dao.TbBcPcHRrshopbuyDao;
import kr.co.ta9.pandora3.psys.dao.TbBcPcHRrshopbuyDaoTrx;

/**
* <pre>
* 1. 클래스명 : Psys1031Mgr
* 2. 설명 : 조직별권한관리
* 3. 작성일 : 2019-03-12
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Psys1051Mgr {

	@Autowired
	private TbBcPcHRrshopbuyDao tbBcPcHRrshopbuyDao;

	@Autowired
	private TbBcPcHRrshopbuyDaoTrx tbBcPcHRrshopbuyDaoTrx;

    /**
     * 조직별매장매입관리 > 모/자점목록 조회  (매장조직)
     * @param parameterMap
     * @return
     * @throws Exception
     */
    public JSONObject selectStrList(ParameterMap parameterMap) throws Exception {
        return tbBcPcHRrshopbuyDao.selectStrList(parameterMap);
    }

    /**
     * 조직별매장매입관리 > 모/자점목록 조회  (매입조직)
     * @param parameterMap
     * @return
     * @throws Exception
     */
    public JSONObject selectBuyFldList(ParameterMap parameterMap) throws Exception {
        return tbBcPcHRrshopbuyDao.selectBuyFldList(parameterMap);
    }

    /**
     * 조직별매장매입관리 > 선택 점에 대한 매장층 목록 조회  (매장조직)
     * @param parameterMap
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectBuyFloorList(ParameterMap parameterMap) throws Exception {
        return tbBcPcHRrshopbuyDao.selectBuyFloorList(parameterMap);
    }


    /**
     * 조직별매장매입관리 > 선택 점에 대한 매입팀 목록 조회  (매입조직)
     * @param parameterMap
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectShopFloorList(ParameterMap parameterMap) throws Exception {
        return tbBcPcHRrshopbuyDao.selectShopFloorList(parameterMap);
    }

    /**
     * 조직별매장매입관리 > 선택 점/층에 대한 매장PC목록 조회  (매장조직)
     * @param parameterMap
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectShopPcList(ParameterMap parameterMap) throws Exception {
        return tbBcPcHRrshopbuyDao.selectShopPcList(parameterMap);
    }

    /**
     * 조직별매장매입관리 > 선택 점/층에 대한 매입PC목록 조회  (매입조직)
     * @param parameterMap
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectBuyPcList(ParameterMap parameterMap) throws Exception {
        return tbBcPcHRrshopbuyDao.selectBuyPcList(parameterMap);
    }

    /**
     * 조직별매장매입관리 > 전체저장
     * @param parameterMap
     * @throws Exception
     */
	public void saveShopAll(ParameterMap parameterMap) throws Exception {
		ArrayList<TbBcPcHRrshopbuy> insertList = new ArrayList<TbBcPcHRrshopbuy>();
		ArrayList<TbBcPcHRrshopbuy> updateList = new ArrayList<TbBcPcHRrshopbuy>();
		ArrayList<TbBcPcHRrshopbuy> deleteList = new ArrayList<TbBcPcHRrshopbuy>();
		parameterMap.populates(TbBcPcHRrshopbuy.class, insertList, updateList, deleteList, "strdate");
		
		//데이터 타입 shop or buy
		String dataType = parameterMap.getValue("dataType");
		
		//shop  매장 //삭제 후 insert를 위해
		if("shop".equals(dataType)) {
			tbBcPcHRrshopbuyDaoTrx.deleteTbBcPcHRrshop(parameterMap);
		} else { // buy 매입
			tbBcPcHRrshopbuyDaoTrx.deleteTbBcPcHRrbuy(parameterMap);
		}
			
		int srno = 0;
		for(TbBcPcHRrshopbuy tbBcPcHRrshopbuy : updateList) {
			++srno;
			tbBcPcHRrshopbuy.setSrno(srno + "");
			tbBcPcHRrshopbuy.setCrtr_id(parameterMap.getUserInfo().getUser_id());
			tbBcPcHRrshopbuy.setUpdr_id(parameterMap.getUserInfo().getUser_id());
			tbBcPcHRrshopbuyDaoTrx.insertTbBcPcHRrshopbuy(tbBcPcHRrshopbuy);
		}
		
	}

}
