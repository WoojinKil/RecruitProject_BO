/**
* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명   : kr.co.ta9.pandora3.content.manager
* 3. 파일명     : SysContentMgr
* 4. 작성일     : 2017-11-27
* </pre>
*/
package kr.co.ta9.pandora3.front.content.manager;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.display.manager.DisplayMgr;
import kr.co.ta9.pandora3.pbbs.dao.TbbsAtlcCnsInfDao;
import kr.co.ta9.pandora3.pbbs.dao.TbbsDocInfDao;
import kr.co.ta9.pandora3.pbbs.dao.TbbsModlInfDao;
import kr.co.ta9.pandora3.pcmn.dao.TcmnCdDtlDao;
import kr.co.ta9.pandora3.pcommon.dto.TbbsAtlcCnsInf;
import kr.co.ta9.pandora3.pcommon.dto.TbbsDocInf;
import kr.co.ta9.pandora3.pcommon.dto.TbbsModlInf;
import kr.co.ta9.pandora3.pcommon.dto.TcmnCdDtl;

/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.display.manager
* 2. 타입명   : class
* 3. 작성일   : 2017-11-27
* 4. 설명     : 컨텐츠 매니저
* </pre>
*/
@Service
public class SysContentMgr {
	
	private final Log logger = LogFactory.getLog(DisplayMgr.class);
	
	@Autowired
	private TbbsModlInfDao tbbsModlInfDao;
	
	@Autowired
	private TbbsDocInfDao tbbsDocInfDao;
	
	@Autowired
	private TbbsAtlcCnsInfDao tbbsAtlcCnsInfDao;
	
	@Autowired
	private TcmnCdDtlDao tcmnCdDtlDao;
	
	
	
	/**
	 * 공지사항 탭 목록 조회
	 * @param  parameterMap
	 * @return List<TbbsModlInf>
	 * @throws Exception
	 */
	public List<TbbsModlInf> selectNotiTabList(ParameterMap parameterMap) throws Exception {
		return tbbsModlInfDao.selectNotiTabList(parameterMap);
	}
	
	/**
	 * 공지사항 게시판 목록 조회
	 * @param  parameterMap
	 * @return List<TbbsDocInf>
	 * @throws Exception
	 */
	public List<TbbsDocInf> selectTbbsDocNotiList(ParameterMap parameterMap) throws Exception {
		List<TbbsDocInf> notiList = tbbsDocInfDao.selectTbbsDocNotiList(parameterMap);
		for(TbbsDocInf tbbsDocInf : notiList) {
			tbbsDocInf.setCts(TextUtil.removeXss(TextUtil.removeTag(tbbsDocInf.getCts())));
		}
		return notiList;
	}
	
	/**
	 * 일반 게시판 목록 조회
	 * @param  parameterMap
	 * @return List<TbbsDocInf>
	 * @throws Exception
	 */
	public List<TbbsDocInf> selectTbbsDocGnrList(ParameterMap parameterMap) throws Exception {
		List<TbbsDocInf> gnrList = tbbsDocInfDao.selectTbbsDocGnrList(parameterMap);
		for(TbbsDocInf tbbsDocInf : gnrList) {
			tbbsDocInf.setCts(StringEscapeUtils.unescapeHtml(tbbsDocInf.getCts()));
		}
		return gnrList;
	}
	
	/**
	 * 게시판 상세 정보 조회
	 * @param  parameterMap
	 * @return TbbsDocInf
	 * @throws Exception
	 */
	public TbbsDocInf selectTbbsDocInf(ParameterMap parameterMap) throws Exception {
		TbbsDocInf sysDocDtlInfo = tbbsDocInfDao.selectTbbsDocInf(parameterMap);
		if(sysDocDtlInfo != null) sysDocDtlInfo.setCts(StringEscapeUtils.unescapeHtml(sysDocDtlInfo.getCts()));
		return sysDocDtlInfo;
	}
	
	/**
	 * 게시판 상세 이전/다음글 정보 조회
	 * @param  parameterMap
	 * @return List<TbbsDocInf>
	 * @throws Exception
	 */
	public List<TbbsDocInf> selectTbbsDocBnAList(ParameterMap parameterMap) throws Exception {
		return tbbsDocInfDao.selectTbbsDocBnAList(parameterMap);
	}
	
	/**
	 * 수강상담 신청
	 * @param  parameterMap
	 * @throws Exception
	 */
	public int insertTbbsAtlcCnsInf(ParameterMap parameterMap) throws Exception{
		TbbsAtlcCnsInf tbbsAtlcCnsInf = (TbbsAtlcCnsInf)parameterMap.populate(TbbsAtlcCnsInf.class);
		tbbsAtlcCnsInf.setUpdr_id(null);
		int insCnt = tbbsAtlcCnsInfDao.insert(tbbsAtlcCnsInf);
		return insCnt;
	}
	
	/**
	 * (복수) 공통코드 목록 조회
	 * @param  parameterMap
	 * @return List<TcmnCdDtl>
	 * @throws Exception
	 */
	public List<TcmnCdDtl> selectMultiTcmnCdDtlList(ParameterMap parameterMap) throws Exception {
		String[] mst_cd_arr = parameterMap.getValue("mst_cd_arr").split(",");
		List<HashMap<String, Object>> mst_cd_list =  new ArrayList<HashMap<String, Object>>();
		for(int i = 0; i < mst_cd_arr.length; i++) {
			HashMap<String , Object> map = new HashMap<String, Object>();
			map.put("MST_CD", mst_cd_arr[i]);
			mst_cd_list.add(map);
		}
		parameterMap.put("mst_cd_list", mst_cd_list);
		return tcmnCdDtlDao.selectTcmnCdDtlMultiList(parameterMap);
	}
	
	/**
	 * 이메일 내용 생성 : HTML
	 * @param  parameterMap
	 * @return String
	 */
	public String writeSendEmailHtml(ParameterMap parameterMap) {
		String sendEmailHtml = "";
		StringBuffer buffer = new StringBuffer();
		String strCnsDt  ="";       //상담가능시간
		String strCnsTm ="";       //상담가능시간
		
		String strCnsStHour  ="";       //상담가능시간
		String strCnsStMin  ="";       //상담가능시간
		String strCnsEdHour  ="";       //상담가능시간
		String strCnsEdMin  ="";       //상담가능시간
		String strCnsTel   ="";        //연락처
		String strCnsCts ="";   //상담내용
		String strCnsStDttm ="";   //상담시작시간
		String strCnsEdDttm ="";   //상당 종료시간
		strCnsStDttm = parameterMap.getValue("cns_st_dttm") ;
		strCnsEdDttm = parameterMap.getValue("cns_ed_dttm") ;
		strCnsDt = strCnsStDttm.substring(0,8);
		strCnsStHour = strCnsStDttm.substring(8,10);
		strCnsStMin = strCnsStDttm.substring(10);
		strCnsEdHour = strCnsEdDttm.substring(8,10);
		strCnsEdMin = strCnsEdDttm.substring(10);
		
		strCnsTm =strCnsStHour +" 시" + strCnsStMin +" 분 ~ "+strCnsEdHour  +" 시" + strCnsEdMin +" 분 ";
		
		//strCnsTm =  parameterMap.getValue("cns_st_dttm") +"~" +  parameterMap.getValue("cns_ed_dttm") ;
		strCnsTel = parameterMap.getValue("atlc_usr_mbl_no_1")+ "-" + parameterMap.getValue("atlc_usr_mbl_no_2") +"-" +  parameterMap.getValue("atlc_usr_mbl_no_3") ;
		strCnsCts =  parameterMap.getValue("cns_cts");
		strCnsCts =  strCnsCts.replace("\n","<br/>");
		
		
		// 이메일 HTML 생성
        buffer.append("<!DOCTYPE html>\n");
        buffer.append("<html lang=\"ko\">\n");
        buffer.append("<head>\n");
        buffer.append(" <meta charset=\"UTF-8\">\n");
        buffer.append(" <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\" />\n");
        buffer.append(" <meta name=\"author\" content=\"\" />\n");
        buffer.append(" <meta name=\"Description\" content=\"\" />\n");
        buffer.append(" <meta name=\"Keywords\" content=\"\" />\n");
        buffer.append(" <title>비즈니스 IT</title>\n");
        buffer.append("</head>\n");
        buffer.append("<body>\n");
        buffer.append(" <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\" style=\"width: 802px; border-spacing:0; margin: 0 auto; border: 0 none;  border-top: 1px solid #dedede; border-left: 1px solid #dedede; border-right: 1px solid #dedede;\">\n");
        buffer.append("     <tbody>\n");
        buffer.append("         <tr>\n");
        buffer.append("             <td colspan=\"4\" style=\"padding-top:40px; text-align: center;\">\n");
        buffer.append("                 <img src=\"http://kimc159.cafe24.com/test/bg_logo.png\" alt=\"\">\n");
        buffer.append("             </td>\n");
        buffer.append("         </tr>\n");
        buffer.append("         <tr>\n");
        buffer.append("             <td colspan=\"4\" style=\"padding: 30px 0; font-size: 40px; font-weight: Bold; line-height:61px; color: #34c1d3; text-align: center;\">\n");
        buffer.append("                 수강상담 신청 내용\n");
        buffer.append("             </td>\n");
        buffer.append("         </tr>\n");
        buffer.append("         <tr>\n");
        buffer.append("             <td style=\"width:40px; height:40px;\"></td>\n");
        buffer.append("             <td style=\"border-top: 2px solid #666; padding: 20px; font-size: 15px; font-weight: 300; letter-spacing: 0; color: #333;\">상담유형</td>\n");
        buffer.append("             <td style=\"border-top: 2px solid #666; padding: 20px; font-size: 15px; font-weight: 400; letter-spacing: 0; color: #333;\">"+parameterMap.getValue("cns_tp_nm", "")+"</td>\n");
        buffer.append("             <td style=\"width:40px; height:40px;\"></td>\n");
        buffer.append("         </tr>\n");
        buffer.append("         <tr>\n");
        buffer.append("             <td style=\"width:40px; height:40px;\"></td>\n");
        buffer.append("             <td style=\"border-top: 1px solid #ddd; padding: 20px; font-size: 15px; font-weight: 300; letter-spacing: 0; color: #333;\">\n");
        buffer.append("                 <span>\n");
        buffer.append("                     상담가능시간\n");
        buffer.append("                 </span>\n");
        buffer.append("                 <span style=\"position:relative;\">\n");
        buffer.append("                     <img src=\"http://kimc159.cafe24.com/test/bg_input_must.png\" alt=\"\" />\n");
        buffer.append("                 </span>\n");
        buffer.append("             </td>\n");
        buffer.append("             <td style=\"border-top: 1px solid #ddd; padding: 20px; font-size: 15px; font-weight: 400; letter-spacing: 0; color: #333;\">\n");
        buffer.append("                 <span>"+strCnsDt+"</span>\n");
        buffer.append("                 <span style=\"margin-left: 20px;\">"+strCnsTm+"</span>\n");
        buffer.append("             </td>\n");
        buffer.append("             <td style=\"width:40px; height:40px;\"></td>\n");
        buffer.append("         </tr>\n");
        buffer.append("         <tr>\n");
        buffer.append("             <td style=\"width:40px; height:40px;\"></td>\n");
        buffer.append("             <td style=\"border-top: 1px solid #ddd; padding: 20px; font-size: 15px; font-weight: 300; letter-spacing: 0; color: #333;\">\n");
        buffer.append("                 <span>\n");
        buffer.append("                     이름\n");
        buffer.append("                 </span>\n");
        buffer.append("                 <span style=\"position:relative;\">\n");
        buffer.append("                     <img src=\"http://kimc159.cafe24.com/test/bg_input_must.png\" alt=\"\" />\n");
        buffer.append("                 </span>\n");
        buffer.append("             </td>\n");
        buffer.append("             <td style=\"border-top: 1px solid #ddd; padding: 20px; font-size: 15px; font-weight: 400; letter-spacing: 0; color: #333;\">"+ parameterMap.getValue("atlc_usr_nm")+"</td>\n");
        buffer.append("             <td style=\"width:40px; height:40px;\"></td>\n");
        buffer.append("         </tr>\n");
        buffer.append("         <tr>\n");
        buffer.append("             <td style=\"width:40px; height:40px;\"></td>\n");
        buffer.append("             <td style=\"border-top: 1px solid #ddd; padding: 20px; font-size: 15px; font-weight: 300; letter-spacing: 0; color: #333;\">\n");
        buffer.append("                 <span>\n");
        buffer.append("                     연락처\n");
        buffer.append("                 </span>\n");
        buffer.append("                 <span style=\"position:relative;\">\n");
        buffer.append("                     <img src=\"http://kimc159.cafe24.com/test/bg_input_must.png\" alt=\"\" />\n");
        buffer.append("                 </span>\n");
        buffer.append("             </td>\n");
        buffer.append("             <td style=\"border-top: 1px solid #ddd; padding: 20px; font-size: 15px; font-weight: 400; letter-spacing: 0; color: #333;\">"+strCnsTel+"</td>\n");
        buffer.append("             <td style=\"width:40px; height:40px;\"></td>\n");
        buffer.append("         </tr>\n");
        buffer.append("         <tr>\n");
        buffer.append("             <td style=\"width:40px; height:40px;\"></td>\n");
        buffer.append("             <td style=\"border-top: 1px solid #ddd; padding: 20px; font-size: 15px; font-weight: 300; letter-spacing: 0; color: #333;\">\n");
        buffer.append("                 <span>\n");
        buffer.append("                     이메일\n");
        buffer.append("                 </span>\n");
        buffer.append("                 <span style=\"position:relative;\">\n");
        buffer.append("                     <img src=\"http://kimc159.cafe24.com/test/bg_input_must.png\" alt=\"\" />\n");
        buffer.append("                 </span>\n");
        buffer.append("             </td>\n");
        buffer.append("             <td style=\"border-top: 1px solid #ddd; padding: 20px; font-size: 15px; font-weight: 400; letter-spacing: 0; color: #333;\">"+ parameterMap.getValue("atlc_usr_eml_adr")+"</td>\n");
        buffer.append("             <td style=\"width:40px; height:40px;\"></td>\n");
        buffer.append("         </tr>\n");
        buffer.append("         <tr>\n");
        buffer.append("             <td style=\"width:40px; height:40px;\"></td>\n");
        buffer.append("             <td style=\"border-top: 1px solid #ddd; padding: 20px; font-size: 15px; font-weight: 300; letter-spacing: 0; color: #333;\">\n");
        buffer.append("                 <span>\n");
        buffer.append("                     희망교육과정\n");
        buffer.append("                 </span>\n");
        buffer.append("                 <span style=\"position:relative;\">\n");
        buffer.append("                     <img src=\"http://kimc159.cafe24.com/test/bg_input_must.png\" alt=\"\" />\n");
        buffer.append("                 </span>\n");
        buffer.append("             </td>\n");
        buffer.append("             <td style=\"border-top: 1px solid #ddd; padding: 20px; font-size: 15px; font-weight: 400; letter-spacing: 0; color: #333;\">"+ parameterMap.getValue("hop_edc_crs")+"</td>\n");
        buffer.append("             <td style=\"width:40px; height:40px;\"></td>\n");
        buffer.append("         </tr>\n");
        buffer.append("         <tr>\n");
        buffer.append("             <td style=\"width:40px; height:40px;\"></td>\n");
        buffer.append("             <td style=\"border-top: 1px solid #ddd; border-bottom: 1px solid #aaa; padding: 20px; font-size: 15px; font-weight: 300; letter-spacing: 0; color: #333;\">내용</td>\n");
        buffer.append("             <td style=\"border-top: 1px solid #ddd; border-bottom: 1px solid #aaa; padding: 20px; font-size: 15px; font-weight: 400; letter-spacing: 0; color: #333;\">"+strCnsCts+" </td>\n");
        buffer.append("             <td style=\"width:40px; height:40px;\"></td>\n");
        buffer.append("         </tr>\n");
        buffer.append("         <tr>\n");
        buffer.append("             <td colspan=\"4\" style=\"height:60px;\"></td>\n");
        buffer.append("         </tr>\n");
        buffer.append("         <tr style=\"background: #eee;\">\n");
        buffer.append("             <td colspan=\"4\" style=\"width: 802px; border-top: 1px solid #ddd; padding: 15px 0; font-size: 13px; font-weight: 300; letter-spacing: 0; color: #bbb; text-align: center; background: #fff; margin-bottom:0;\">\n");
        buffer.append("                 * 본 메일은 발신전용입니다. 문의사항이 있으시면 0000-0000 으로 문의해주시기 바랍니다.\n");
        buffer.append("             </td>\n");
        buffer.append("         </tr>\n");
        buffer.append("         <tr style=\"background: #eee; padding: 0; line-height: 0;font-size: 0;\">\n");
        buffer.append("             <td colspan=\"4\" style=\"padding-top: 27px; font-size: 13px; line-height: 19px; font-weight: 300; letter-spacing: 0; color: #999; text-align: center; margin-bottom:0;\">BUSINESS IT ACADEMY | 주소:서울시 강남구 삼성로85길 19, 202호 | 대표이사:정철우</td>\n");
        buffer.append("         </tr>\n");
        buffer.append("         <tr style=\"background: #eee; padding: 0; line-height: 0;font-size: 0;\">\n");
        buffer.append("             <td colspan=\"4\" style=\"font-size: 13px; line-height: 19px; font-weight: 300; letter-spacing: 0; color: #999; text-align: center; margin-bottom:0;\">학원등록번호:12345호 | 사업자등록번호:123-45678-789</td>\n");
        buffer.append("         </tr>\n");
        buffer.append("         <tr style=\"background: #eee; padding: 0; line-height: 0;font-size: 0;\">\n");
        buffer.append("             <td colspan=\"4\" style=\"font-size: 13px; line-height: 19px; font-weight: 300; letter-spacing: 0; color: #999; text-align: center; margin-bottom:0;\">대표전화:0000-0000</td>\n");
        buffer.append("         </tr>\n");
        buffer.append("         <tr style=\"background: #eee; padding: 0; line-height: 0;font-size: 0;\">\n");
        buffer.append("             <td colspan=\"4\" style=\"border-bottom: 1px solid #ddd; padding-bottom:30px; font-size: 13px; line-height: 19px; font-weight: 300; letter-spacing: 0; color: #999; text-align: center; margin-bottom:0;\">Copyright ⓒ BUSINESS IT ACADEMY. All rights reserved.</td>\n");
        buffer.append("         </tr>\n");
        buffer.append("     </tbody>\n");
        buffer.append(" </table>\n");
        buffer.append("</body>\n");
        buffer.append("</html>\n");
        
		
		// 리턴값 설정
		sendEmailHtml = buffer.toString();
		return sendEmailHtml;
	}
	
	/**
	 * 페이징 정보 취득 : 공통
	 * @param  docList
	 * @param  param
	 * @return Map<String, Integer>
	 * @throws Exception
	 */
	public Map<String, Integer> getPagingInfo(List<TbbsDocInf> docList, ParameterMap param) throws Exception {
		Integer tot_page = 1;
		Integer tot_count = 0;
		int index = 0;
		if(docList.size() > 0) {
			for(TbbsDocInf sDoc : docList) {
				if("Y".equals(sDoc.getNotc_yn())) index++;
				else break;
			}
			if(index < docList.size()) {
				tot_page = docList.get(index).getTotal_page();
				tot_count = Integer.parseInt(String.valueOf(docList.get(index).getTotal_count()));
			}
		} 
		int page = Integer.parseInt(param.get("page").toString());
		int group_no = page / 5 + (page % 5 > 0 ? 1 : 0);
		int page_eno = group_no * 5;	
		int page_sno = page_eno - (5 - 1);
		if(page_eno > tot_page) page_eno = tot_page;

		Map<String, Integer> pagingInfo = new HashMap<String,Integer>();
		pagingInfo.put("tot_page", tot_page);
		pagingInfo.put("tot_count", tot_count);
		pagingInfo.put("page", page);
		pagingInfo.put("page_sno", page_sno);
		pagingInfo.put("page_eno", page_eno);
		pagingInfo.put("rows", Integer.parseInt(param.get("rows").toString()));
		
		logger.debug("■ 페이징 정보 취득, 파라미터(tot_page) : " + tot_page);
		logger.debug("■ 페이징 정보 취득, 파라미터(tot_count) : " + tot_count);
		logger.debug("■ 페이징 정보 취득, 파라미터(page) : " + page);
		logger.debug("■ 페이징 정보 취득, 파라미터(group_no) : " + group_no);
		logger.debug("■ 페이징 정보 취득, 파라미터(page_sno) : " + page_sno);
		logger.debug("■ 페이징 정보 취득, 파라미터(page_eno) : " + page_eno);
		logger.debug("■ 페이징 정보 취득, 파라미터(rows) : " + param.get("rows").toString());
		
		return pagingInfo;
	}
	
	/**
	 * 게시판 상세 조회수 갱신
	 * @param  parameterMap
	 * @return int
	 * @throws Exception
	 */
	public int updateTbbsDocInfInqCnt(ParameterMap parameterMap) throws Exception {
		return tbbsDocInfDao.updateTbbsDocInfInqCnt(parameterMap);
	}
	
}
