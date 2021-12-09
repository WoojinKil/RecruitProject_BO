package kr.co.ta9.pandora3.landing.bi.report;

import java.net.URI;
import java.nio.charset.Charset;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import kr.co.ta9.pandora3.common.conf.Configuration;

public final class BiReportUtil {
	
	
	private static final String PROJECT_HEADER_ID = "X-MSTR-ProjectID"; 
	private static final String PROJECT_AUTH_TOKEN = "X-MSTR-AuthToken";
	private static final String PROJECT_ID = "E63442B211E9C238C2CF0080EF35D46C";
	private static final String REPORT_ID = "4452FE304C497A99AD210EB2D02A5521";
//	private static final String REPORT_ID = "3B9C28F511EA43CC97080080EFC5E594"; // 모바일 오픈시 여기로 변경.
	public static final String SET_COOKIE = "Set-Cookie";
	
	private BiReportUtil() {}
	
	
	public static Map<String, String> getAuthTokenCookie(String log_in) throws Exception {
		String authToken = "";
		String setCookie ="";
		
		HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory(); 
		factory.setReadTimeout(5000);
		factory.setConnectTimeout(3000);

		RestTemplate restTemplate = new RestTemplate(factory);
		Configuration configuration = Configuration.getInstance();
		String ip = configuration.get("bi.report.ip");
		String baseUrl = ip + "/MicroStrategyLibrary/api/auth/login";
		URI uri = new URI(baseUrl);
		   
		HttpHeaders headers = new HttpHeaders(); 
		headers.set("SM_USER", log_in);
		headers.set("Accept", "application/json");
		   
		    
		HttpEntity<Object> request = new HttpEntity<>(headers);
		        
		ResponseEntity<String> entity = restTemplate.postForEntity(uri, request, String.class);
		authToken = entity.getHeaders().get(PROJECT_AUTH_TOKEN).get(0);
		setCookie = entity.getHeaders().get(SET_COOKIE).get(0);
		
		HashMap <String, String> AuthTokenCookie = new HashMap<String, String>();
		AuthTokenCookie.put("authToken", authToken);
		AuthTokenCookie.put("setCookie", setCookie);
		
		
		return AuthTokenCookie;

	}
	
	public static String cteateInstance(String authToken, String cookie) throws Exception {
		
		HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory(); 
		factory.setReadTimeout(5000);
		factory.setConnectTimeout(3000);

		RestTemplate restTemplate = new RestTemplate(factory);
		String instanceId = ""; 
	  	
		Configuration configuration = Configuration.getInstance();
		String ip = configuration.get("bi.report.ip");
		String baseUrl = ip + "/MicroStrategyLibrary/api/reports/" + REPORT_ID + "/instances?limit=1000";
		URI uri = new URI(baseUrl);
		   
		HttpHeaders headers = new HttpHeaders(); 
		headers.set(PROJECT_AUTH_TOKEN, authToken);
		headers.set(PROJECT_HEADER_ID, PROJECT_ID); 
		headers.set("Cookie", cookie);
		headers.set("Content-Type", "application/json");
		   
		HttpEntity<Object> request = new HttpEntity<>(headers);
		   	     
		ResponseEntity<Map> resultMap = restTemplate.postForEntity(uri, request, Map.class);
			
		instanceId = resultMap.getBody().get("instanceId").toString();
		   
		return instanceId;

	}
	
	public static List<Prompt> getPrombp(String authToken, String cookie, String instanceId) throws Exception {
		 
		HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory(); 
		factory.setReadTimeout(5000);
		factory.setConnectTimeout(3000);

		RestTemplate restTemplate = new RestTemplate(factory);
		List<Prompt> prompts = null;
		Configuration configuration = Configuration.getInstance();
		String ip = configuration.get("bi.report.ip");
		String baseUrl = ip + "/MicroStrategyLibrary/api/reports/" + REPORT_ID + "/instances/" + instanceId + "/prompts";
		URI uri = new URI(baseUrl);
		    
		HttpHeaders headers = new HttpHeaders(); 
	    headers.set(PROJECT_AUTH_TOKEN, authToken);
		headers.set(PROJECT_HEADER_ID, PROJECT_ID); 
		headers.set("Cookie", cookie);
		headers.set("Content-Type", "application/json");
		   
		HttpEntity<Object> request = new HttpEntity<>(headers);
		ResponseEntity<Prompt[]> response = restTemplate.exchange(uri, HttpMethod.GET, request, Prompt[].class);
		prompts = Arrays.asList(response.getBody());
		
		return prompts;
		 
	 }
	 
	public static void setPrombp(String authToken, String cookie, String instanceId, List<Prompt> prompts) throws Exception {
		 
		HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory(); 
		factory.setReadTimeout(5000);
		factory.setConnectTimeout(3000);

		RestTemplate restTemplate = new RestTemplate(factory);
		Configuration configuration = Configuration.getInstance();
		String ip = configuration.get("bi.report.ip");
		String baseUrl = ip + "/MicroStrategyLibrary/api/reports/" + REPORT_ID + "/instances/" + instanceId + "/prompts/answers";
		    
		HttpHeaders headers = new HttpHeaders(); 
		headers.set(PROJECT_AUTH_TOKEN, authToken);
		headers.set(PROJECT_HEADER_ID, PROJECT_ID); 
		headers.set("Cookie", cookie);
		headers.set("Content-Type", "application/json");
		   
		Report report = new Report();

		prompts.get(0).setAnswers("MM");
		report.setPrompts(prompts);
		HttpEntity<Report> request = new HttpEntity<>(report, headers);
		restTemplate.put(baseUrl, request);
	 }
		 
	 public static String getReport(String login, String cookie) throws Exception {
		// 인증 키 및 인증된 쿠키 가져오기
		Map<String, String> authTokenCookieMap = getAuthTokenCookie(login);
		String authToken = authTokenCookieMap.get("authToken");
		String setCookie = authTokenCookieMap.get("setCookie");
		//instance 가져오기
		String instance = cteateInstance(authToken,setCookie);
		
		List<Prompt> prompts = getPrombp(authToken, setCookie, instance);
		setPrombp(authToken, setCookie, instance, prompts);
		
		
		HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory(); 
		factory.setReadTimeout(5000);
		factory.setConnectTimeout(3000);

		RestTemplate restTemplate = new RestTemplate(factory);
		Configuration configuration = Configuration.getInstance();
		String ip = configuration.get("bi.report.ip");
		String baseUrl = ip + "/MicroStrategyLibrary/api/v2/reports/" + REPORT_ID + "/instances/" + instance + "?limit=1000";
		HttpHeaders headers = new HttpHeaders(); 
		Charset utf8 = Charset.forName("UTF-8");
	    MediaType mediaType = new MediaType("application", "json", utf8);
	    headers.setContentType(mediaType);
	    headers.set(PROJECT_AUTH_TOKEN, authToken);
		headers.set(PROJECT_HEADER_ID, PROJECT_ID); 
		headers.set("Cookie", setCookie);
//		headers.set("Content-Type", "application/json");
		   
		 
		restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(Charset.forName("UTF-8")));
		
		HttpEntity<Object> request = new HttpEntity<>(headers);
		   
		ResponseEntity<String> response = restTemplate.exchange(baseUrl, HttpMethod.GET, request, String.class);
		
		return response.getBody();
		
	 }
}
