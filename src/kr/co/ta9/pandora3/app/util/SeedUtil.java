package kr.co.ta9.pandora3.app.util;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.xmlbeans.impl.util.Base64;

import kr.co.ta9.pandora3.app.repository.CodeRepository;
public final class SeedUtil {
	
	private static String CHARSET = "utf-8";
	private static final String PBUserKey = "LDPSSLO%$#@!@#$!"; //16Byte로 설정
	private static final String DEFAULT_IV = "1234567890123456"; //16Byte로 설정
	private static byte pbUserReallyKey[] = PBUserKey.getBytes();
	private static byte bszIV[] = DEFAULT_IV.getBytes();
	
	private static final Log log = LogFactory.getLog(SeedUtil.class);

	/***************************************
	* Main 함수 - 예제개발: 황철연
	* @param args
	**************************************/
	private SeedUtil() {}

	public static byte[] encrypt(String str) throws Exception {
	 byte[] enc = null;
	  //암호화 함수 호출 - CBC, ECB 중 선택
	  enc = com.ldps.slo.KISA_SEED_CBC.SEED_CBC_Encrypt(pbUserReallyKey, bszIV, str.getBytes(CHARSET), 0,str.getBytes(CHARSET).length);
	  //enc = KISA_SEED_ECB.SEED_ECB_Encrypt(pbUserKey, str.getBytes(CHARSET), 0,str.getBytes(CHARSET).length);
	 /**JDK1.8 일 때 사용
	 Encoder encoder = Base64.getEncoder();
	 byte[] encArray = encoder.encode(enc);
	 */
	 byte[] encArray = Base64.encode(enc);
	 return encArray;
	}
	public static String decrypt(byte[] str) throws Exception {
	 /**JDK1.8 일 때 사용
	 Decoder decoder = Base64.getDecoder();
	 byte[] enc = decoder.decode(str);
	 */
	 byte[] enc = Base64.decode(str);
	 String result = "";
	 byte[] dec = null;

	  //복호화 함수 호출 - CBC, ECB 중 선택
	  dec = com.ldps.slo.KISA_SEED_CBC.SEED_CBC_Decrypt(pbUserReallyKey, bszIV, enc, 0, enc.length);
	  //dec = KISA_SEED_ECB.SEED_ECB_Decrypt(pbUserKey, enc, 0, enc.length);
	  result = new String(dec, CHARSET);
	 return result;
	}
	//전체 파일 내용 읽어오기
	public static String fileRead(String filePath) throws Exception {
		String line = "", fullLine = "";
		StringBuilder bld = new StringBuilder();
		FileReader fr = null;
		BufferedReader reader = null;
		try {
			fr = new FileReader(filePath);
			reader = new BufferedReader( fr );
			while( ( line = reader.readLine()) != null ){
						bld.append(line);
						bld.append("\n");
			}
			fullLine = bld.toString();
			
		} catch (Exception e) {
			log.error(e.toString());
		} finally {
			fr.close();
			reader.close();
		}
	
		return fullLine;
	
	}


}
