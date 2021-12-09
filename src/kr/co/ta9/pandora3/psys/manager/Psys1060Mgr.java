package kr.co.ta9.pandora3.psys.manager;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.mbsv.dao.MbsvStrSrvMgmDao;
import kr.co.ta9.pandora3.pcommon.dto.TbBcpcAthrApp;
import kr.co.ta9.pandora3.pcommon.dto.TmbrAdmLgnInf;
import kr.co.ta9.pandora3.pmbr.dao.TmbrAdmLgnInfDao;
import kr.co.ta9.pandora3.psys.dao.TbBcpcAthrAppDao;
import kr.co.ta9.pandora3.psys.dao.TbLgapAthrappHDao;

/**
* <pre>
* 1. 클래스명 : Psys1006Mgr
* 2. 설명 : 권한관리 서비스
* 3. 작성일 : 2018-03-28
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Psys1060Mgr {

	@Autowired
	private TbBcpcAthrAppDao tbBcpcAthrAppDao;

	@Autowired
	private TbLgapAthrappHDao tbLgapAthrappHDao;

	@Autowired
	private TmbrAdmLgnInfDao tmbrAdmLgnInfDao;

	@Autowired
	private MbsvStrSrvMgmDao mbsvStrSrvMgmDao;




	/**
	 * 사원관리 > 외부사원 승인 관리 목록
	 * @param parameterMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public JSONObject selectExtnTmbrAdmLgnInfPocGridList(ParameterMap parameterMap) throws Exception {

		/*
		 * String mstr_cd = parameterMap.getUserInfo().getMstr_cd();
		 * if(TextUtil.isEmpty(mstr_cd)) { mstr_cd = "0000"; }
		 * 
		 * parameterMap.put("mstr_cd", mstr_cd); List<String> vipCommonBlcoCds =
		 * mbsvStrSrvMgmDao.selectUtilComnCdDtlList(parameterMap);
		 * 
		 * parameterMap.put("blco_cds", vipCommonBlcoCds);
		 * 
		 * JSONObject jsonObj =
		 * tmbrAdmLgnInfDao.selectExtnTmbrAdmLgnInfPocGridList(parameterMap);
		 * 
		 * 
		 * if(jsonObj.get("rows") != null) { List<Map<String,Object>>
		 * tmbrAdmLgnInfListMap = (List<Map<String,Object>>) jsonObj.get("rows");
		 * 
		 * for(Map<String,Object> map : tmbrAdmLgnInfListMap) { ArrayList<String>
		 * poc_cds = new ArrayList<String>(); String poc_cd = (String)map.get("POC_CD");
		 * 
		 * if(!TextUtil.isEmpty(poc_cd)) { for(String poc : poc_cd.split(",")) {
		 * poc_cds.add(poc); } } parameterMap.put("poc_cds", poc_cds); String poc_nms =
		 * mbsvStrSrvMgmDao.selectPocCdInfoNms(parameterMap); map.put("POC_NM",
		 * poc_nms);
		 * 
		 * 
		 * String coCd = (String)map.get("BLCO_NM"); parameterMap.put("co_cd", coCd);
		 * String coNm = mbsvStrSrvMgmDao.selectCoNm(parameterMap); map.put("CO_NM",
		 * coNm); } }
		 * 
		 * 
		 * 
		 * return jsonObj;
		 */
		return null;
	}
	/**
	 * 권한신청 관리 > 개인 권한 신청
	 * @param parameterMap
	 * @throws Exception
	 */
	public void insertTbbcpcAthrApp(ParameterMap parameterMap) throws Exception {

		/*
		 * List<TbBcpcAthrApp> insertList = new ArrayList<TbBcpcAthrApp>();
		 * List<TbBcpcAthrApp> updateList = new ArrayList<TbBcpcAthrApp>();
		 * List<TbBcpcAthrApp> deleteList = new ArrayList<TbBcpcAthrApp>();
		 * 
		 * parameterMap.populates(TbBcpcAthrApp.class, insertList, updateList,
		 * deleteList);
		 * 
		 * TbBcpcAthrApp[] insert = updateList.toArray(new TbBcpcAthrApp[0]);
		 * for(TbBcpcAthrApp tbBcpcAthrApp : insert) {
		 * 
		 * if(!"".equals(tbBcpcAthrApp.getRol_ids())) {
		 * 
		 * tbBcpcAthrApp.setRol_id(tbBcpcAthrApp.getRol_ids());
		 * tbBcpcAthrApp.setApvl_yn("N"); tbBcpcAthrApp.setAppl_stat_cd("20");
		 * tbBcpcAthrApp.setHr_org_cd(parameterMap.getUserInfo().getHr_org_cd()); // 신청
		 * 테이블 insert tbBcpcAthrAppDao.insertTbBcpcAthrApp(tbBcpcAthrApp);
		 * 
		 * tbBcpcAthrApp.setAppl_stat_cd("20"); tbBcpcAthrApp.setAppl_stat_nm("미승인");
		 * 
		 * 
		 * tbLgapAthrappHDao.insertTbLgapAthrappH(tbBcpcAthrApp);
		 * 
		 * }
		 * 
		 * 
		 * }
		 */
		

	}
	public void updateExtnTmbrAdmLgnInfPocCds(ParameterMap parameterMap) throws Exception {

		List<TmbrAdmLgnInf> tmbrAdmLgnInfList = new ArrayList<TmbrAdmLgnInf>();

		parameterMap.populatesForForceUpdate(TmbrAdmLgnInf.class, tmbrAdmLgnInfList);

		TmbrAdmLgnInf[] tmbrAdmLgnInfUpdate = tmbrAdmLgnInfList.toArray(new TmbrAdmLgnInf[0]);

		for(TmbrAdmLgnInf tmbrAdmLgnInf : tmbrAdmLgnInfUpdate) {
			tmbrAdmLgnInfDao.updateExtnTmbrAdmLgnInfPocCds(tmbrAdmLgnInf);
		}

	}


    /**
     * 자점 코드 조회
     * @param parameterMap
     * @return List<Map>
     * @throws Exception
     */
	public Object selectStrCdInfoList(ParameterMap parameterMap) throws Exception {

		/*
		 * String mstr_cd = parameterMap.getUserInfo().getMstr_cd();
		 * if(TextUtil.isEmpty(mstr_cd)) { mstr_cd = "0000"; }
		 * 
		 * parameterMap.put("mstr_cd", mstr_cd);
		 * 
		 * return mbsvStrSrvMgmDao.selectStrCdInfoList(parameterMap);
		 */
		return null;
	}


    /**
     * 서비스접점 정보 조회
     * @param parameterMap
     * @return List<Map>
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    public List<Map> selectPocCdInfoList(ParameterMap parameterMap) throws Exception {
        return mbsvStrSrvMgmDao.selectPocCdInfoList(parameterMap);
    }

    /**
     * 소속회사정보 조회
     * @param parameterMap
     * @return List<Map>
     * @throws Exception
     */
    public List<Map> selectCoList(ParameterMap parameterMap) throws Exception {
    	return mbsvStrSrvMgmDao.selectCoList(parameterMap);
    }

}

