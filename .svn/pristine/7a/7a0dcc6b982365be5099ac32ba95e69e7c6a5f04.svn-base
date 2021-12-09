package kr.co.ta9.pandora3.app.util;

import java.lang.reflect.Field;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import kr.co.ta9.pandora3.common.conf.Configuration;
import kr.co.ta9.pandora3.common.util.BeanUtil;

public final class CommonUtil {

	protected static final Log loged = LogFactory.getLog(CommonUtil.class);
	private CommonUtil() {

	}
	/**
 	 * IP Address 취득
 	 * @param request
 	 * @return
 	 */
 	public static String getRemoteIpAddr (HttpServletRequest request) {
 		//Log loged = LogFactory.getLog(());
 		String ip = request.getHeader("X-Forwarded-For");
 		loged.info("X-Forwarded-For==>" + ip);

 		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
 			ip = request.getHeader("Proxy-Client-IP");
 			loged.info("Proxy-Client-IP==>" + ip);
 		}
 		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
 			ip = request.getHeader("WL-Proxy-Client-IP");
 			loged.info("WL-Proxy-Client-IP==>" + ip);
 		}
 		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
 			ip = request.getHeader("HTTP_CLIENT_IP");
 			loged.info("HTTP_CLIENT_IP==>" + ip);
 		}
 		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
 			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
 			loged.info("HTTP_X_FORWARDED_FOR==>" + ip);
 		}
 		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
 			ip = request.getHeader("X-Real-IP");
 			loged.info("X-Real-IP==>" + ip);
 		}
 		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
 			ip = request.getHeader("X-RealIP");
 			loged.info("X-RealIP==>" + ip);
 		}
 		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
 			ip = request.getRemoteAddr();
 			loged.info("getRemoteAddr==>" + ip);
 		}
 		return ip;
 	}

	/**
	 * Object -> Map으로 변환
	 * @param object
	 * @return
	 * @throws Exception
	 */
	public static Map<String,Object> convertObjectToMap(Object object) throws Exception {

		Map<String,Object> result = new HashMap<String,Object>();
		List<Field> fields = BeanUtil.getAllDeclaredFields(object.getClass());
		for (Field field : fields) {
			field.setAccessible(true);
			if (field.get(object) instanceof Timestamp) {
				Timestamp time = (Timestamp)field.get(object);
				//String timestamp = String.valueOf(field.get(object));
				//result.put(field.getName().toUpperCase(), (timestamp == null? null:timestamp.substring(0, 16)));
				result.put(field.getName().toUpperCase(Locale.ENGLISH), time.getTime());
			}
			else {
				result.put(field.getName(), field.get(object));
			}
		}
		return result;
	}

	public static String getIpMasking(String str) throws Exception{
		StringBuilder  sb = new StringBuilder();
		String[] arStr = str.split(",");
		for(int i=0; i < arStr.length; i++){
			String[] tmpArIp = arStr[i].split("\\.");
			if(tmpArIp.length==4){
				sb.append(tmpArIp[0]);
				sb.append(".");
				sb.append(tmpArIp[1]);
				sb.append(".***");
				sb.append(".");
				sb.append(tmpArIp[3]);
			}
			if((i+1) < arStr.length){
				sb.append(",");
			}
		}
		return sb.toString();
	}

	/**
	 * VDI 허용 여부
	 * @param IP
	 * @return
	 */
	public static String getVdi(String IP){
		String existVDI ="N";
		try{
			Configuration configuration = Configuration.getInstance();
			String vdiIP =configuration.get("app.vdi.ip");
			
			System.out.println("app.vdi.ip: "+vdiIP);    //추가한 부분:	2020.05.19		
			String[] arVdiIP = vdiIP.split(",");

			for(int i=0; i< arVdiIP.length; i++){
				System.out.println(IP.indexOf(arVdiIP[0]));    //추가한 부분:	2020.05.19	
				if(IP.indexOf(arVdiIP[i])>=0){
					existVDI ="Y";
					break;
				}
			}
		}catch(Exception ex){
			existVDI="N";
		}
		return existVDI;
	}


}
