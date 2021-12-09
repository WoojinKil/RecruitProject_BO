package kr.co.ta9.pandora3.pwzn.manager;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.co.ta9.pandora3.app.servlet.ParameterMap;
import kr.co.ta9.pandora3.common.conf.Config;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.servlet.upload.UploadFile;
import kr.co.ta9.pandora3.common.util.DateUtil;
import kr.co.ta9.pandora3.common.util.FileUtil;
import kr.co.ta9.pandora3.common.util.TextUtil;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspDtl;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspMnInf;
import kr.co.ta9.pandora3.pcommon.dto.TbbsWbznDspMst;
import kr.co.ta9.pandora3.pcommon.dto.TmbrUsrInf;
import kr.co.ta9.pandora3.pmbr.dao.TmbrUsrInfDao;
import kr.co.ta9.pandora3.pwzn.dao.TbbsWbznDspDtlDaoTrx;
import kr.co.ta9.pandora3.pwzn.dao.TbbsWbznDspMnInfDao;
import kr.co.ta9.pandora3.pwzn.dao.TbbsWbznDspMnInfDaoTrx;
import kr.co.ta9.pandora3.pwzn.dao.TbbsWbznDspMstDao;
import kr.co.ta9.pandora3.pwzn.dao.TbbsWbznDspMstDaoTrx;

/**
* <pre>
* 1. 클래스명 : Pwzn1001Mgr
* 2. 설명 : 웹진통합조회 서비스
* 3. 작성일 : 2018-03-29
* 4. 작성자 : TANINE
* </pre>
*/
@Service
public class Pwzn1001Mgr {
	
	@Value("${smtp.host}")
	private String smtp_host;
	
	@Value("${smtp.port}")
	private String smtp_port;
	
	@Value("${smtp.username}")
	private String smtp_username;
	
	@Value("${smtp.password}")
	private String smtp_password;
	
	@Value("${smtp.sender}")
	private String smtp_sender;
	
	@Autowired
	private TbbsWbznDspMstDao tbbsWbznDspMstDao;
	@Autowired
	private TbbsWbznDspMstDaoTrx tbbsWbznDspMstDaoTrx;
	@Autowired
	private TbbsWbznDspMnInfDao tbbsWbznDspMnInfDao;
	@Autowired
	private TbbsWbznDspMnInfDaoTrx tbbsWbznDspMnInfDaoTrx;
	@Autowired
	private TbbsWbznDspDtlDaoTrx tbbsWbznDspDtlDaoTrx;
	
	@Autowired
	private TmbrUsrInfDao tmbrUsrInfDao;
	
	/**
	 * 웹진 목록 조회(그리드형)
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public JSONObject selectTbbsWbznDspMstGridList(ParameterMap parameterMap) throws Exception {
		return tbbsWbznDspMstDao.selectTbbsWbznDspMstGridList(parameterMap);
	}

	/**
	 * 웹진 삭제(그리드형)
	 * 웹진마스터, 웹진메인, 웹진디테일 삭제
	 * @param parameterMap
	 * @throws Exception
	 */
	public void deleteTbbsWbznDspGridList(ParameterMap parameterMap) throws Exception {

		List<TbbsWbznDspMst> insertList = new ArrayList<TbbsWbznDspMst>();
		List<TbbsWbznDspMst> updateList = new ArrayList<TbbsWbznDspMst>();
		List<TbbsWbznDspMst> deleteList = new ArrayList<TbbsWbznDspMst>();
		
		// 삭제대상 추출
		parameterMap.populates(TbbsWbznDspMst.class, insertList, updateList, deleteList);	
		
		TbbsWbznDspMst[] deleteArr = deleteList.toArray(new TbbsWbznDspMst[deleteList.size()]);
		
		int result  = 0;
		int count   = 0;
		
		if (deleteList.size() > 0) {
			for(TbbsWbznDspMst deleteItem : deleteArr) {
				if(deleteItem != null) {
					// 웹진 MST정보 삭제
					result = tbbsWbznDspMstDaoTrx.delete(deleteItem);
					count = result;
					if(result > 0) {
						//  웹진 MAIN 정보 삭제
						TbbsWbznDspMnInf tbbsWbznDspMnInf = new TbbsWbznDspMnInf();
						tbbsWbznDspMnInf.setWbzn_seq(deleteItem.getWbzn_seq());
						result = tbbsWbznDspMnInfDaoTrx.delete(tbbsWbznDspMnInf);
						count += result;
						
						if(result > 0) {
							// 웹진 상세 정보 삭제
							TbbsWbznDspDtl tbbsWbznDspDtl = new TbbsWbznDspDtl();
							tbbsWbznDspDtl.setWbzn_seq(tbbsWbznDspMnInf.getWbzn_seq());
							result = tbbsWbznDspDtlDaoTrx.deleteTbbsWbznDspDtlAll(tbbsWbznDspDtl);
							count += result;
						}
					}
				}
			}
		}
		
		if(count >=0) {
			String save_path = Config.get("app.pandora3front.file.upload.path")+ File.separator + "webzine";
			String file_path = "";
			ArrayList<File> arFile = new ArrayList<File>();
			String realFileName ="";
			
			
			String realThumPath=Config.get("app.pandora3front.file.upload.path")+ File.separator + "webzineMst";
			for(int i=0;i<deleteList.size();i++){
				File file =null;
				TbbsWbznDspMst tmp = (TbbsWbznDspMst) deleteList.get(i);
				if ( (save_path.length() - 1) == save_path.lastIndexOf(File.separator)) {
					realFileName  = tmp.getPdf_fpath().substring(tmp.getPdf_fpath().lastIndexOf("/")+1);
					file_path = save_path + realFileName;
				} else {
					realFileName  = tmp.getPdf_fpath().substring(tmp.getPdf_fpath().lastIndexOf("/")+1);
					file_path = save_path + File.separator +realFileName;
				}
				
				file = new File(file_path);
				if(file.exists()){
					arFile.add(file);
				}
				
				if ( (realThumPath.length() - 1) == realThumPath.lastIndexOf(File.separator)) {
					realFileName  = tmp.getThumb_fpath().substring(tmp.getThumb_fpath().lastIndexOf("/")+1);
					file_path = realThumPath + realFileName;
				} else {
					realFileName  = tmp.getThumb_fpath().substring(tmp.getThumb_fpath().lastIndexOf("/")+1);
					file_path = realThumPath + File.separator +realFileName;
				}
				
				file = new File(file_path);
				if(file.exists()){
					arFile.add(file);
				}
			}
			FileUtil.deleteFile(arFile);
		}
	}
	
	
	
	/**
	 * 메일 허용 사용자 리스트(이메일수신여부 Y 목록 조회)
	 * @return
	 * @throws Exception
	 */
	public List<TmbrUsrInf> selectTmbrUsrInfEmlRcvYList() throws Exception {
		return tmbrUsrInfDao.selectTmbrUsrInfEmlRcvYList();
	}
	
	/**
	 * 웹진 웹 메일 발송
	 * @return
	 * @throws Exception
	 */
	public String sndWbznEml(ParameterMap parameterMap, HttpServletRequest request) throws Exception{
		
		String result="";
		try {
			// 메일 발송 대상 조회(메일 수신 허용한 사람에 한해)
			List<TmbrUsrInf> sendOkUserList = selectTmbrUsrInfEmlRcvYList();
				
			// 필요정보 조회(Parameter)
			String wbzn_seq = request.getParameter("wbzn_seq");
			String wbzn_nm  = request.getParameter("wbzn_nm");
			if(StringUtils.isEmpty(wbzn_seq)) throw new Exception("NOT_FOUND_WEBZINE");
			TbbsWbznDspMst tbbsWbznDspMst = tbbsWbznDspMstDao.selectTbbsWbznDspMstInf(parameterMap);
			List<TbbsWbznDspMnInf> tbbsWbznDspMnInfList = tbbsWbznDspMnInfDao.selectTbbsWbznDspMnInfList(parameterMap);
			
			if(tbbsWbznDspMnInfList != null && tbbsWbznDspMnInfList.size() > 0) {
				
				if(tbbsWbznDspMnInfList.size() != 7) throw new Exception("INVALID_SIZE");
				
				// 메일 내용 작성용 Object
				StringBuffer buffer = new StringBuffer();
				String domain = "http://pandora3";
				
				// 인사이트(웹진) URL
				String insiteUrl = domain+"/pandora3/page/IndustryPolicy/policyInsite.do?up_tmp_id=&tmp_id=30&up_tmp_type=&tmp_type=3&wbzn_seq=" + wbzn_seq;
				// Top Area HTML
				buffer.append("<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"width:800px;height:110px;font-family:\'Malgun Gothic\',\'Sans-serif\',\'Dotum\',\'돋움\';box-sizing:border-box;border-collapse:collapse;border-spacing:0;vertical-align:bottom\">");
				buffer.append("<colgroup>");
				buffer.append("<col width=\"2.5%\" />");
				buffer.append("<col width=\"27.5%\" />");
				buffer.append("<col width=\"51.25%\" />");
				buffer.append("<col width=\"18.75%\" />");
				buffer.append("</colgroup>");
				buffer.append("<tr>");
				buffer.append("<td rowspan=\"3\" style=\"height:110px\">&nbsp;</td>");
				buffer.append("<td colspan=\"2\" style=\"height:50px\">&nbsp;</td>");
				buffer.append("<td rowspan=\"3\" style=\"height:110px;vertical-align:bottom\">"
							+ "<img src=\""+ domain + tbbsWbznDspMst.getThumb_fpath() + "\" style=\"width:auto;max-width:100%;height:100px;vertical-align:bottom\" ></td>");
				buffer.append("</tr>");
				buffer.append("<tr>");
				buffer.append("<td style=\"height:50px;vertical-align:bottom\">"
							+ "<img src=\"" + domain + "/pandora3/resources/pandora3Front/images/pandora3-f/pandora3-in-logo.png\" style=\"width:100%;height:auto;vertical-align:bottom\"></td>");
				buffer.append("<td style=\"height:50px;line-height:1.0em;font-weight:300;text-align:right;vertical-align:bottom\">"
							+ "<font style=\"font-size:23px\">" + tbbsWbznDspMst.getY_no() + " " + tbbsWbznDspMst.getWbzn_nm() + " " + "</font>"
									+ "<font style=\"font-size:32px\"> " + tbbsWbznDspMst.getM_no() + "</font>"
									+ "</td>");
				buffer.append("</tr>");
				buffer.append("<tr>");
				buffer.append("<td colspan=\"2\" style=\"height:10px\">&nbsp;</td>");
				buffer.append("</tr>");
				buffer.append("</table>");
				
				// Tab Area
				buffer.append("<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"width:800px;height:60px;font-family:\'Malgun Gothic\',\'Sans-serif\',\'Dotum\',\'돋움\';font-weight:300;text-align:center;padding:0;box-sizing:border-box;border-collapse:collapse;border-spacing:0;vertical-align:middle\">");
				buffer.append("<tr style=\"width:800px;background:#666\">");
				for(int i=0; i<tbbsWbznDspMnInfList.size(); i++) {
					// 인사이트(웹진) 카테고리별 상세 URL
					String url = insiteUrl + "&fromMailYn=Y&ctg_seq="+tbbsWbznDspMnInfList.get(i).getCtg_seq();
					if(i < tbbsWbznDspMnInfList.size()-1) {
						buffer.append("<td style=\"width:14.28%;height:60px;border-right:1px solid #999;font-size:17px;line-height:30px;vertical-align:middle\">");
					} else {
						buffer.append("<td style=\"width:14.28%;height:60px;font-size:17px;line-height:30px;vertical-align:middle\">");
					}
					buffer.append("<a href=\""+ url +"\" style=\"display:inline-block;width:100%;color:#fefefe;text-decoration:none\">" + tbbsWbznDspMnInfList.get(i).getCtg_nm() + "</a>");
					buffer.append("</td>");
				}
				buffer.append("</tr>");
				buffer.append("</table>");
				
				// Contents Area
				String dot_blue = "<img src=\""+ domain + "/pandora3/resources/pandora3Front/images/bul_dot_blue.png\" style=\"display:inline-block;width:10px;height:10px;\"> ";
				String dot_white = "<img src=\""+ domain + "/pandora3/resources/pandora3Front/images/bul_dot_white.png\" style=\"display:inline-block;width:10px;height:10px;\"> ";
				
				buffer.append("<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"width:800px;background:#f6f6f6;border-spacing:0;vertical-align:middle\">");
				buffer.append("<tr>");
				buffer.append("<td colspan=\"3\" style=\"width:800px;height:20px\"></td>");
				buffer.append("</tr>");
				buffer.append("<tr>");
				buffer.append("<td style=\"width:20px\"></td>");
				buffer.append("<!-- box wrap -->");
				buffer.append("<td style=\"width:760px\">");
				buffer.append("<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"border-collapse:collapse;font-family:\'Malgun Gothic\',\'Sans-serif\',\'Dotum\',\'돋움\'\">");
				buffer.append("<tr>");
				buffer.append("<!-- box1 -->");
				buffer.append("<td style=\"width:485px;border:1px solid #ededed;box-sizing:border-box;background:#fff\">");
				buffer.append("<a href=\"#\" style=\"display:block;text-decoration:none\">");
				buffer.append("<table style=\"font-family:\'Malgun Gothic\',\'Sans-serif\',\'Dotum\',\'돋움\';border-collapse:collapse;vertical-align:middle\">");
				buffer.append("<tr style=\"height:25px\"></tr>");
				buffer.append("<tr>");
				buffer.append("<td rowspan=\"3\" style=\"width:25px\"></td>");
				buffer.append("<td style=\"height:20px;font-size:14px;line-height:16px;color:#666\">");
				buffer.append(dot_blue + tbbsWbznDspMnInfList.get(0).getCtg_nm());
				buffer.append("</td>");
				buffer.append("<td rowspan=\"3\" style=\"width:10px\"></td>");
				buffer.append("<td rowspan=\"3\" style=\"width:190px\"><img src=\""+ domain + tbbsWbznDspMnInfList.get(0).getThumb_fpath() + "\" style=\"display:block;width:190px;height:auto\"></td>");
				buffer.append("<td rowspan=\"3\" style=\"width:25px\"></td>");
				buffer.append("</tr>");
				buffer.append("<tr>");
				buffer.append("<td style=\"height:62px;font-size:21px;line-height:27px;word-break:break-all;color:#004ba1\">");
				buffer.append("<span style=\"display:block;width:100%;height:56px\">"+charLimit(tbbsWbznDspMnInfList.get(0).getCts_txt(), tbbsWbznDspMst.getTmp_seq(), tbbsWbznDspMnInfList.get(0).getCtg_seq(), "TITLE")+"</span>");
				buffer.append("</td>");
				buffer.append("</tr>");
				buffer.append("<tr>");
				buffer.append("<td style=\"height:80px;font-size:15px;line-height:26px;font-weight:300;word-break:break-all;color:#333\">");
				buffer.append("<span style=\"display:block;width:100%;height:80px\">"+charLimit(tbbsWbznDspMnInfList.get(0).getCts_txt(), tbbsWbznDspMst.getTmp_seq(), tbbsWbznDspMnInfList.get(0).getCtg_seq(), "TEXT")+"</span>");
				buffer.append("</td>");
				buffer.append("</tr>");
				buffer.append("<tr style=\"height:25px\"></tr>");
				buffer.append("</table>");
				buffer.append("</a>");
				buffer.append("</td>");
				buffer.append("<!--// box1 -->");
				buffer.append("<td style=\"width:20px\"></td>");
				buffer.append("<!-- box2 -->");
				buffer.append("<td style=\"width:255px;background:#3160ac\">");
				buffer.append("<a href=\"#\" style=\"display:block;text-decoration:none\">");
				buffer.append("<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"font-family:\'Malgun Gothic\',\'Sans-serif\',\'Dotum\',\'돋움\';border-collapse:collapse;vertical-align:top\">");
				buffer.append("<tr style=\"height:25px\"></tr>");
				buffer.append("<tr>");
				buffer.append("<td rowspan=\"3\" style=\"width:25px\"></td>");
				buffer.append("<td style=\"width:205px;height:20px;font-size:14px;line-height:16px;color:#fff;\">");
				buffer.append(dot_white + tbbsWbznDspMnInfList.get(1).getCtg_nm());
				buffer.append("</td>");
				buffer.append("<td rowspan=\"3\" style=\"width:25px\"></td>");
				buffer.append("</tr>");
				buffer.append("<tr>");
				buffer.append("<td style=\"width:205px;height:62px;word-break:break-all;\">");
				buffer.append("<span style=\"display:block;width:205px;height:56px;font-size:21px;line-height:27px;color:#fff\">"+charLimit(tbbsWbznDspMnInfList.get(1).getCts_titl(), tbbsWbznDspMst.getTmp_seq(), tbbsWbznDspMnInfList.get(1).getCtg_seq(), "TITLE")+"</span>");
				buffer.append("</td>");
				buffer.append("</tr>");
				buffer.append("<tr>");
				buffer.append("<td style=\"width:205px;height:92px;word-break:break-all;\">");
				buffer.append("<span style=\"display:block;width:205px;height:92px;font-size:15px;line-height:24px;font-weight:300;overflow:hidden;color:#fff\">"+charLimit(tbbsWbznDspMnInfList.get(1).getCts_txt(), tbbsWbznDspMst.getTmp_seq(), tbbsWbznDspMnInfList.get(1).getCtg_seq(), "TEXT")+"</span>");
				buffer.append("</td>");
				buffer.append("</tr>");
				buffer.append("<tr style=\"height:25px\"></tr>");
				buffer.append("</table>");
				buffer.append("</a>");
				buffer.append("</td>");
				buffer.append("<!--// box2 -->");
				buffer.append("</tr>");
				buffer.append("</table>");
				buffer.append("</td>");
				buffer.append("<!--// box wrap -->");
				buffer.append("<td style=\"width:20px\"></td>");
				buffer.append("</tr>");
				buffer.append("</table>");
				buffer.append("<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"width:800px;font-family:\'Malgun Gothic\',\'Sans-serif\',\'Dotum\',\'돋움\';border-collapse:collapse;border-spacing:0;vertical-align:middle;background:#f6f6f6\">");
				buffer.append("<tr>");
				buffer.append("<td style=\"width:800px;height:20px\" colspan=\"3\"></td>");
				buffer.append("</tr>");
				buffer.append("<tr>");
				buffer.append("<td style=\"width:20px\"></td>");
				buffer.append("<!-- box wrap -->");
				buffer.append("<td style=\"width:760px\">");
				buffer.append("<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"font-family:\'Malgun Gothic\',\'Sans-serif\',\'Dotum\',\'돋움\'\">");
				buffer.append("<tr>");
				buffer.append("<!-- box3 -->");
				buffer.append("<td style=\"width:800px;background:#fff;border:1px solid #ededed;box-sizing:border-box;\">");
				buffer.append("<a href=\"#\" style=\"display:block;text-decoration:none\">");
				buffer.append("<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"font-family:\'Malgun Gothic\',\'Sans-serif\',\'Dotum\',\'돋움\';vertical-align:middle\">");
				buffer.append("<tr style=\"height:25px\"></tr>");
				buffer.append("<tr>");
				buffer.append("<td rowspan=\"4\" style=\"width:25px\"></td>");
				buffer.append("<td style=\"width:445px;height:20px;font-size:14px;line-height:16px;color:#666;vertical-align:top\">");
				buffer.append(dot_blue + tbbsWbznDspMnInfList.get(2).getCtg_nm());
				buffer.append("</td>");
				buffer.append("<td rowspan=\"4\" style=\"width:25px\"></td>");
				buffer.append("<td rowspan=\"4\" style=\"width:240px\"><img src=\""+ domain + tbbsWbznDspMnInfList.get(2).getThumb_fpath()+"\" style=\"width:240px;height:auto\"></td>");
				buffer.append("<td rowspan=\"4\" style=\"width:25px\"></td>");
				buffer.append("</tr>");
				buffer.append("<tr>");
				buffer.append("<td style=\"width:445px;height:25px;vertical-align:top;font-size:21px;line-height:27px;color:#004ba1;word-break:break-all\">");
				buffer.append("<span style=\"display:block;width:100%;height:27px;\">"+charLimit(tbbsWbznDspMnInfList.get(2).getCts_titl(), tbbsWbznDspMst.getTmp_seq(), tbbsWbznDspMnInfList.get(2).getCtg_seq(), "TITLE")+"</span>");
				buffer.append("</td>");
				buffer.append("</tr>");
				buffer.append("<tr>");
				buffer.append("<td style=\"width:445px;height:26px;vertical-align:top;font-size:12px;line-height:16px;font-weight:300;color:#999;word-break:break-all\">");
				buffer.append("<span style=\"display:block;width:100%;height:16px;\">"+charLimit(tbbsWbznDspMnInfList.get(2).getCts_subtitl(), tbbsWbznDspMst.getTmp_seq(), tbbsWbznDspMnInfList.get(2).getCtg_seq(), "SUB_TITLE")+"</span>");
				buffer.append("</td>");
				buffer.append("</tr>");
				buffer.append("<tr>");
				buffer.append("<td style=\"width:445px;height:80px;vertical-align:top;font-size:15px;line-height:26px;font-weight:300;color:#333;word-break:break-all\">");
				buffer.append("<span style=\"display:block;width:100%;height:80px;\">"+charLimit(tbbsWbznDspMnInfList.get(2).getCts_subtitl(), tbbsWbznDspMst.getTmp_seq(), tbbsWbznDspMnInfList.get(2).getCtg_seq(), "TEXT")+"</span>");
				buffer.append("</td>");
				buffer.append("</tr>");
				buffer.append("<tr style=\"height:25px\"></tr>");
				buffer.append("</table>");
				buffer.append("</a>");
				buffer.append("</td>");
				buffer.append("<!--// box3 -->");
				buffer.append("</tr>");
				buffer.append("</table>");
				buffer.append("</td>");
				buffer.append("<!--// box wrap -->");
				buffer.append("<td style=\"width:20px\"></td>");
				buffer.append("</tr>");
				buffer.append("</table>");
				
				try {
					// 메일 전송용 정보
					String host = smtp_host;	
					String port = smtp_port;
					String username = smtp_username;
					String password = smtp_password;
					String sender = smtp_sender;
					
					// 메일 프로퍼티 설정
					Properties props = new Properties();	
					props.put("mail.smtp.host", host); 
					props.put("mail.smtp.port", port); 
					props.put("mail.smtp.auth", "true");
					
					// 메일 세션
					Session session = Session.getDefaultInstance(props);
					
					// 메일 커넥션 연결
					Transport transport = session.getTransport("smtps");
					transport.connect(host, username, password);
					if(sendOkUserList != null && sendOkUserList.size() > 0) {
						for(TmbrUsrInf tmbrUsrInf : sendOkUserList) {
							// 메일 내용 설정
							MimeMessage msg = new MimeMessage(session);
							msg.setSubject("판도라  "+ wbzn_nm, "UTF-8");
							msg.setFrom(new InternetAddress(sender)); // 보낸 사람 
							msg.setContent(buffer.toString(), "text/html; charset=UTF-8");
							// 수신자 설정
							msg.addRecipient(Message.RecipientType.TO, new InternetAddress(tmbrUsrInf.getUsr_eml_adr())); 
							// 메일 전송
							transport.sendMessage(msg, msg.getAllRecipients());
						}
					}
					transport.close();
				
				} catch (MessagingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			// Exception 일 경우
			result = Const.BOOLEAN_FAIL;
			
		}
		return result;
	}
	
	/**
	 * 웹진 메일발송 시 문자수 제한
	 * @param targetStr
	 * @return
	 */
	private String charLimit(String trgStr, int tmp_seq, int ctg_seq, String type) {
		// 문자수 제한 기준변수 선언
		int titleLimit = 0;
		int subTitleLimit = 0;
		int textLimit = 0;
		
		// 웹진 타입별 문자수 기준 설정(BYTE)
		if(tmp_seq == 1) {
			if(ctg_seq == 1) {
				titleLimit = 40;
				textLimit = 70;
			}
			else if(ctg_seq == 2) {
				titleLimit = 36;
				textLimit = 90;
			}
			else if(ctg_seq == 3) {
				titleLimit = 40;
				subTitleLimit = 70;
				textLimit = 145;
			}
			else {
				titleLimit = 40;
			}
		} 
		else if (tmp_seq == 2){
			if(ctg_seq == 1) {
				titleLimit = 32;
				textLimit = 62;
			}
			else if(ctg_seq == 2) {
				titleLimit = 28;
				textLimit = 150;
			}
			else if(ctg_seq == 3) {
				titleLimit = 14;
				subTitleLimit = 24;
				textLimit = 60;
			}
			else if(ctg_seq == 4 || ctg_seq == 5) {
				titleLimit = 24;
				textLimit = 34;
			}
			else {
				titleLimit = 24;
			}
		}
		
		// 문자수 제한
		int indexEnd = 0;
		if("TITLE".equals(type)) indexEnd = titleLimit;
		else if("SUB_TITLE".equals(type)) indexEnd = subTitleLimit;
		else if("TEXT".equals(type))  indexEnd = textLimit;
		String rtnText = "";
		long len = TextUtil.getLength(trgStr, TextUtil.CHARSET_NON_UTF8);
		if(len > 0 && (int)len > indexEnd) {
			rtnText = TextUtil.substring(trgStr, (long)indexEnd) + "...";
		}
		else {
			rtnText = trgStr;
		}
		
		return rtnText;
	}
	
	/**
	 * 웹진 마스터 PDF파일정보
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public TbbsWbznDspMst selectTbbsWbznDspMstPdfNm(ParameterMap parameterMap) throws Exception {
		return tbbsWbznDspMstDao.selectTbbsWbznDspMstInf(parameterMap);
	}
	
	/**
	 * 웹진 PDF 컨텐츠 등록
	 * @param parameterMap
	 * @throws Exception
	 */
	public List<Map<String, Object>> updateWebzinePdfFileInfo(ParameterMap parameterMap) throws Exception {
		List<Map<String, Object>> retSysFileList = new ArrayList<Map<String, Object>>();
		UploadFile[] uploadFiles = parameterMap.getUploadFiles("files");
		
		int wbzn_seq    = parameterMap.getInt("wbzn_seq");
		String updr_id  = parameterMap.getValue("updr_id");
		String chg_flag = parameterMap.getValue("chg_flag");
		
		if(uploadFiles != null) {
			final String separator = "_"; 
			for(int i = 0; i < uploadFiles.length; i++) {
				String pdf_nm     = uploadFiles[i].getOriginalFilename();
				String chg_pdf_nm = new StringBuilder().append(wbzn_seq).append(separator).append(DateUtil.today("yyyyMMddHHmmssSSS")).append(separator).append(pdf_nm).toString();
				String pdf_path   = new StringBuilder().append("/pandora3/resources/pandora3Front"+Config.get("app.pandora3front.file.path")).append("webzine/").append(chg_pdf_nm).toString();
				
				TbbsWbznDspMst tbbsWbznDspMst = new TbbsWbznDspMst();
				tbbsWbznDspMst.setWbzn_seq(wbzn_seq);
				tbbsWbznDspMst.setPdf_fpath(pdf_path);
				tbbsWbznDspMst.setPdf_nm(pdf_nm);
				tbbsWbznDspMst.setUpdr_id(updr_id);
				
				// 웹진 PDF 정보 갱신
				int result = tbbsWbznDspMstDaoTrx.update(tbbsWbznDspMst);
				// 파일 업로드
				if(result > 0) {
					Map<String, Object> fileSrlMap = new HashMap<String, Object>();
					int[] types = {UploadFile.PDF};
					uploadFiles[i].addTypes(types);
					fileSrlMap.put("file_nm", pdf_nm);
					fileSrlMap.put("file_path", pdf_path);
					retSysFileList.add(fileSrlMap);
					uploadFiles[i].transferTo(Config.get("app.pandora3front.file.upload.path")+ File.separator + "webzine", chg_pdf_nm);
				}
			}
		} else {
			if("DELETE".equals(chg_flag)) {
				// 파일 삭제
				TbbsWbznDspMst tgtWbzn = tbbsWbznDspMstDao.selectTbbsWbznDspMstInf(parameterMap);
				String tgt_file_name = tgtWbzn.getChg_pdf_nm();
				tgtWbzn.setPdf_nm(null);
				tgtWbzn.setPdf_fpath(null);
				tgtWbzn.setUpdr_id(updr_id);
				tgtWbzn.setWbzn_seq(wbzn_seq);
				
				// 웹진 PDF 정보 갱신
				int result = tbbsWbznDspMstDaoTrx.update(tgtWbzn);
				
				if(result > 0) {
					String save_path = Config.get("app.pandora3front.file.upload.path")+ File.separator + "webzine";
					String file_path = ""; 
					if ( (save_path.length() - 1) == save_path.lastIndexOf(File.separator)) {
						file_path = save_path + tgt_file_name;
					} else {
						file_path = save_path + File.separator + tgt_file_name;
					}
					File f = new File(file_path);
					if(f.exists()) f.delete();
				}
			}
		}
		return retSysFileList;
	}
}
