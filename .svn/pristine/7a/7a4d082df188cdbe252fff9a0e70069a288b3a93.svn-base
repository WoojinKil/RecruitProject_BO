package kr.co.ta9.pandora3.lplog.manager;

import java.util.Iterator;
import java.util.Locale;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.pcommon.dto.TbLgapVmsprinfschH;
import kr.co.ta9.pandora3.pcommon.dto.TsysAdmMnu;
import kr.co.ta9.pandora3.psys.dao.TbLgapVmsprinfschHDaoTrx;
import kr.co.ta9.pandora3.psys.dao.TsysAdmMnuDao;
@Service
public class LpLogMgr{

	@Autowired
	private TsysAdmMnuDao tsysAdmMnuDao;

	@Autowired
	private TbLgapVmsprinfschHDaoTrx tbLgapVmsprinfschHDaoTrx;



   /**
    * VIP 개인정보 이력 저장
    * @param parameterMap
    * @throws Exception
    */
	public void  insertTbLgapVmsprinfschH(ParameterMap parameterMap) throws Exception{

		TbLgapVmsprinfschH tbLgapVmsprinfschH = new  TbLgapVmsprinfschH();
		int nExistCnt = 0;
		nExistCnt =tsysAdmMnuDao.selectExistTsysAdmMnu(parameterMap);

		if(nExistCnt > 0){
			Set set = parameterMap.keySet();
			Iterator iterator = set.iterator();
			StringBuilder buffer = new StringBuilder();
			while(iterator.hasNext()){
				  String key = (String)iterator.next();
				  buffer.append("["+key+" : "+parameterMap.get(key)+"]");
			}
			String url =parameterMap.getValue("url",false);
			String execClCd ="";
			String execClNm="";
			if((url.toLowerCase(Locale.ENGLISH).indexOf("select")>=0 || url.toLowerCase(Locale.ENGLISH).indexOf("get")>=0) && url.toLowerCase(Locale.ENGLISH).indexOf("excel")<0){
				execClCd ="10";
				execClNm ="조회";
			}else if((url.toLowerCase(Locale.ENGLISH).indexOf("save")>=0 || url.toLowerCase(Locale.ENGLISH).indexOf("insert")>=0)){
				execClCd ="20";
				execClNm ="저장";
			}else if((url.toLowerCase(Locale.ENGLISH).indexOf("update")>=0)){
				execClCd ="30";
				execClNm ="수정";
			}else if((url.toLowerCase(Locale.ENGLISH).indexOf("delete")>=0)){
				execClCd ="40";
				execClNm ="삭제";
			}
			tbLgapVmsprinfschH.setUsr_id(parameterMap.getValue("user_id"));
			tbLgapVmsprinfschH.setRqst_url(url);
			tbLgapVmsprinfschH.setIp_addr(parameterMap.getValue("ip_addr",false));
			tbLgapVmsprinfschH.setRqst_para(buffer.toString());

			parameterMap.put("mnu_seq", parameterMap.getValue("_mnu_seq",false));
    		TsysAdmMnu tsysAdmMnu = tsysAdmMnuDao.selectDTO(TsysAdmMnu.class, parameterMap);
    		int nSrchCnt = 0;
    		if(parameterMap.getValue("records")!=""){
    			nSrchCnt = parameterMap.getInt("records");
    		}

    		tbLgapVmsprinfschH.setMnu_seq(tsysAdmMnu.getMnu_seq());
    		tbLgapVmsprinfschH.setMnu_nm(tsysAdmMnu.getMnu_nm());
    		tbLgapVmsprinfschH.setSch_cnt(nSrchCnt);
    		tbLgapVmsprinfschH.setExec_cl_cd(execClCd);
    		tbLgapVmsprinfschH.setExec_cl_nm(execClNm);
    		tbLgapVmsprinfschH.setCrtr_id(parameterMap.getValue("user_id"));
    		tbLgapVmsprinfschH.setUpdr_id(parameterMap.getValue("user_id"));
    		tbLgapVmsprinfschH.setSys_cd("2");
    		tbLgapVmsprinfschH.setSys_nm("VIP");

    		tbLgapVmsprinfschHDaoTrx.insert(tbLgapVmsprinfschH);
		}

	}
	/**
	 * 개인정보화면 조회 여부
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public int  selectExistTsysAdmMnu(ParameterMap parameterMap) throws Exception {
		return tsysAdmMnuDao.selectExistTsysAdmMnu(parameterMap);
	}


}
