/**
* <pre>
* 1. 프로젝트명 : 판도라 패키징
* 2. 패키지명 : kr.co.ta9.pandora3.app.servlet
* 3. 파일명 : ParameterMap
* 4. 작성일 : 2017-10-27
* </pre>
*/
package kr.co.ta9.pandora3.app.servlet;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.PropertyUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import kr.co.ta9.pandora3.app.conf.AppConst;
import kr.co.ta9.pandora3.app.entry.EntryFactory;
import kr.co.ta9.pandora3.app.entry.SessionEntryFactory;
import kr.co.ta9.pandora3.app.entry.UserInfo;
import kr.co.ta9.pandora3.common.conf.Configuration;
import kr.co.ta9.pandora3.common.conf.Const;
import kr.co.ta9.pandora3.common.servlet.BaseParameterMap;
import kr.co.ta9.pandora3.common.util.BeanUtil;
import kr.co.ta9.pandora3.common.util.CryptUtil;
import kr.co.ta9.pandora3.common.util.TextUtil;
/**
* <pre>
* 1. 패키지명 : kr.co.ta9.pandora3.app.servlet
* 2. 타입명 : class
* 3. 작성일 : 2017-10-27
* 4. 설명 : ParameterMap 설정
* </pre>
*/
public class ParameterMap extends BaseParameterMap implements Serializable  {

	private static final long serialVersionUID = -6810969261172081295L;


	private UserInfo userInfo;
	private transient  Map<String,Object> userMap = new HashMap<String,Object>();	//populate시 추가적으로 셋팅하고자 하는 값 지정

	public ParameterMap() {
		super();
	}

	public ParameterMap(HttpServletRequest request) throws Exception {
		super(request);
		init(request);
	}

	@Override
	public boolean equals(Object other) {
	    boolean result = false;
	    if (other != null && other.getClass() == this.getClass()) {
	    	ParameterMap that = (ParameterMap) other;
	        result = (that.canEqual(this) && this.userInfo.equals(that.userInfo) && super.equals(that));
	    }
	    return result;
	}
	// that.canEqual(this) 호출을 통해서 상위클래스(Point)는 결코 ColoredPoint와 같을 수 없게 보장됨.
	public boolean canEqual(Object other) {
	    return (other instanceof ParameterMap);
	}

	/**
	 * 개요:sys_regr_id, sys_modr_id등 셋팅
	 */
	private void init(HttpServletRequest request) {
		Configuration configuration = Configuration.getInstance();
		String user_auth_type = configuration.get("user.auth.type");
		if("COOKIE".equals(user_auth_type)){
			String value = CryptUtil.decode(request, EntryFactory.COOKIE_FO_BO_SEPARATION);

			// FO/BO 분기처리
			if("FO".equals(value)) {
				userInfo = EntryFactory.getUserInfo(request, EntryFactory.COOKIE_FRONT_NAME);
			} else {
				userInfo = EntryFactory.getUserInfo(request, EntryFactory.COOKIE_NAME);
			}
		}else if("SESSION".equals(user_auth_type)){
			Object sessionVal = SessionEntryFactory.getAttribute(SessionEntryFactory.SESSION_FO_BO_SEPARATION);

			if(sessionVal != null) {

				// FO/BO 분기처리
				if("FO".equals(sessionVal.toString())) {
					userInfo = SessionEntryFactory.getLoginUserInfo(request, SessionEntryFactory.SESSION_FRONT_NAME) ;
				} else {
					userInfo = SessionEntryFactory.getLoginUserInfo(request, SessionEntryFactory.SESSION_NAME) ;
				}
			}
		}



		if(userInfo !=null && userInfo.isLogin()){
			String user_id ="";
			String mngr_tp_cd="";
			user_id = userInfo.getUser_id();
			mngr_tp_cd = userInfo.getMngr_tp_cd();
			put("user_id", user_id);
			put("mngr_tp_cd", mngr_tp_cd);
			put(Const.SYS_REG_USER, user_id);
			put(Const.SYS_MOD_USER, user_id);
			put(Const.SYS_CRT_ID, user_id);
			put(Const.SYS_UPDR_ID, user_id);
		}

	}

	public UserInfo getUserInfo() {
		return userInfo;
	}



	/*
	 * 크로스 사이트 스크립트 방지를 위한 처리를 한다.
	 * (non-Javadoc)
	 * @see com.pionnet.servlet.BaseParameterMap#get(java.lang.Object)
	 */
	@Override
	public Object get(Object key) {

		Object value =  super.get(key);

		if (value instanceof String) {
			value = TextUtil.xss((String)value);
		}

		//usr_id 는 넘어온 값이 있다면 셋팅하지 않는다. 대신 populate시 값이 셋팅되지는 않도록 한다. update시 usr_id가 수정될 수도 있기 때문에...
//		if ((value == null || "".equals(value)) && "usr_id".equals(key)) {
//			value = EntryFactory.getUserInfo(getRequest()).getUsr_id();
//		}

		return value;
	}

	/*
	 * 크로스 사이트 스크립트 방지를 위한 처리를 한다.
	 */
	@Override
	public String[] getArray(String key) {
		String[] values = super.getArray(key);

		for (int i = 0 ; values != null && i < values.length ; i++) {
			values[i] = TextUtil.xss(values[i]);
		}
		return values;
	}

	@Override
	protected void setProperty(Object bean, String name, Object value) throws Exception {
		if (PropertyUtils.getPropertyType(bean, name) == Timestamp.class) {
			if (value instanceof String) {
				String mask = "0000-00-00 00:00:00";
				String datetime = (String)value;
				if (!"".equals(datetime)) {
					value = datetime + mask.substring(mask.length() - (mask.length() - (datetime.length() > mask.length() ? mask.length():datetime.length())));
					super.setProperty(bean, name, value);
				}
			} else if (value instanceof Timestamp) {
				super.setProperty(bean, name, value);
			}
		} else {
			super.setProperty(bean, name, value);
		}
	}

	/**
	 * 개요:populate 시 추가로 추가할 속성이 지정할 수 있다.
	 */
	public void addProperty(String name, Object value) {
		userMap.put(name, value);
	}

	/**
	 * 개요: populate bean의 reg_id에 cookie 에서 가져온 사용자 정보 설정
	 */
	protected void setSysUser(Object bean) throws Exception {
		String crt_id = Const.SYS_CRT_ID;
		String updr_id = Const.SYS_UPDR_ID;
		BeanUtils.setProperty(bean, crt_id, get(crt_id));
		BeanUtils.setProperty(bean, updr_id, get(updr_id));

		Iterator<String> names = userMap.keySet().iterator();
		while (names.hasNext()) {
			String name = names.next();
			if (name == null) {
				continue;
			}
			Object value = userMap.get(name);
			BeanUtils.setProperty(bean, name, value);
		}
	}

	/**
	 * 개요:사용자 정보 셋팅
	 */
	protected void setUser(Object... beans) throws Exception {
		if (beans != null) {
			for (Object bean : beans) {
				setSysUser(bean);
			}
		}
	}

	@Override
	public Object populate(Object bean) throws Exception {
		setSysUser(bean);
		return super.populate(bean);
	}

	@Override
	public Object populates(Object[] beans) throws Exception {
		setUser(beans);
		return super.populates(beans);
	}

	// 그리드 헤더정보
	public Map<String,String> parseGridHeader() throws Exception {
		Map<String,String> header = new HashMap<String,String>();
		String headerString = getValue(AppConst.GRID_HEADER, false);
		if (headerString == null) {
			return header;
		}
		header = BeanUtil.convertJsonToMap(headerString);

		return header;
	}

	// 그리드 데이터 Map으로 변환
	public List<Map<String,String>> parseGridData() throws Exception {
		List<Map<String,String>> resultList = new ArrayList<Map<String,String>>();

		int row_count = getInt(AppConst.GRID_SIZE);
		String jsonString = getValue(AppConst.GRID_DATA, false);
		if (row_count == 0 || jsonString == null) {
			return resultList;
		}

		JSONParser jsonParser = new JSONParser();
		Object jsonObject = jsonParser.parse(jsonString);
		JSONArray jsonArray = (JSONArray)jsonObject;
		for (int i = 0; i < jsonArray.size(); i++) {
			Map<String,String> result = new HashMap<String,String>();
			JSONObject json = (JSONObject)jsonArray.get(i);
			Set set = json.keySet();
			Iterator iterator = set.iterator();
			String keyAttribute = null;
			while (iterator.hasNext()) {
				keyAttribute = (String) iterator.next();
	            result.put(keyAttribute, (String)json.get(keyAttribute));
			}
			resultList.add(result);
		}
		return resultList;
	}

	// 그리드 데이터 Map으로 변환
		public Map<String,String> parseFormData(String formNm) throws Exception {
			Map<String,String> resultMap = new HashMap<String,String>();

			String jsonString = getValue(formNm, false);
			JSONParser jsonParser = new JSONParser();
			Object jsonObject = jsonParser.parse(jsonString);
			JSONArray jsonArray = (JSONArray)jsonObject;
			int row_count = jsonArray.size();
			if (row_count == 0 || jsonString == null) {
				return resultMap;
			}

			for (int i = 0; i < jsonArray.size(); i++) {
				Map<String,String> result = new HashMap<String,String>();
				JSONObject json = (JSONObject)jsonArray.get(i);
				Set set = json.keySet();
				Iterator iterator = set.iterator();
				String keyAttribute = null;
				while (iterator.hasNext()) {
					keyAttribute = (String) iterator.next();
		            result.put(keyAttribute, (String)json.get(keyAttribute));
				}
			}
			return resultMap;
		}


	// 그리드 데이터 object로 변환
	public Object populates(Class clss, List insertList, List updateList, List deleteList) throws Exception {
		int row_count = getInt(AppConst.GRID_SIZE);
		Object[] beans = (Object[])BeanUtil.array(clss, row_count);
		String jsonString = getValue(AppConst.GRID_DATA, false);
		if (jsonString == null || beans == null || beans.length == 0) {
			return beans;
		}

		JSONParser jsonParser = new JSONParser();
		Object jsonObject = jsonParser.parse(jsonString);
		JSONArray jsonArray = (JSONArray)jsonObject;
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject json = (JSONObject)jsonArray.get(i);
			Set set = json.keySet();
			Iterator iterator = set.iterator();
			String keyAttribute = null;
	        String lowerAttribute = null;

	        boolean isInsert = false;
	        boolean isUpdate = false;
	        boolean isDelete = false;
			while (iterator.hasNext()) {
				keyAttribute = (String) iterator.next();
	            lowerAttribute = keyAttribute.toLowerCase(Locale.ENGLISH);

	            if (AppConst.GRID_CRUD.equals(keyAttribute)) {
                	if (AppConst.GRID_INSERT.equals(json.get(keyAttribute))) {
                		isInsert = true;
                	}
                	else if (AppConst.GRID_UPDATE.equals(json.get(keyAttribute))) {
                		isUpdate = true;
                	}
                	else if (AppConst.GRID_DELETE.equals(json.get(keyAttribute))) {
                		isDelete = true;
                	}
                }
	            if(json.get(keyAttribute) instanceof String){
	            	setProperty(beans[i], lowerAttribute, TextUtil.xss(json.get(keyAttribute).toString()));
	            }else{
	            	setProperty(beans[i], lowerAttribute, json.get(keyAttribute));
	            }
			}
			setSysUser(beans[i]);
			if (isInsert) {
				insertList.add(beans[i]);
			}
			else if (isUpdate) {
				updateList.add(beans[i]);
			}
			else if (isDelete) {
				deleteList.add(beans[i]);
			}
		}
		return beans;
	}

	// 그리드 데이터 object로 변환
		public Object populates(Class clss, List insertList, List updateList, List deleteList,String strDataSetNm) throws Exception {
//			int row_count = getInt(AppConst.GRID_SIZE);
			String jsonString = getValue(strDataSetNm, false);
			JSONParser jsonParser = new JSONParser();
			Object jsonObject = jsonParser.parse(jsonString);
			JSONArray jsonArray = (JSONArray)jsonObject;
			Object[] beans = (Object[])BeanUtil.array(clss, jsonArray.size());
			if (jsonString == null || beans == null || beans.length == 0) {
				return beans;
			}
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject json = (JSONObject)jsonArray.get(i);
				Set set = json.keySet();
				Iterator iterator = set.iterator();
				String keyAttribute = null;
		        String lowerAttribute = null;

		        boolean isInsert = false;
		        boolean isUpdate = false;
		        boolean isDelete = false;
				while (iterator.hasNext()) {
					keyAttribute = (String) iterator.next();
		            lowerAttribute = keyAttribute.toLowerCase(Locale.ENGLISH);

		            if (AppConst.GRID_CRUD.equals(keyAttribute)) {
	                	if (AppConst.GRID_INSERT.equals(json.get(keyAttribute))) {
	                		isInsert = true;
	                	}
	                	else if (AppConst.GRID_UPDATE.equals(json.get(keyAttribute))) {
	                		isUpdate = true;
	                	}
	                	else if (AppConst.GRID_DELETE.equals(json.get(keyAttribute))) {
	                		isDelete = true;
	                	}
	                }
		            setProperty(beans[i], lowerAttribute, json.get(keyAttribute));
				}
				setSysUser(beans[i]);
				if (isInsert) {
					insertList.add(beans[i]);
				}
				else if (isUpdate) {
					updateList.add(beans[i]);
				}
				else if (isDelete) {
					deleteList.add(beans[i]);
				}
			}
			return beans;
		}

	// 그리드 데이터 object로 변환
	public Object populatesForForceUpdate(Class clss, List updateList) throws Exception {
		int row_count = getInt(AppConst.GRID_SIZE);
		Object[] beans = (Object[])BeanUtil.array(clss, row_count);
		String jsonString = getValue(AppConst.GRID_DATA, false);
		if (jsonString == null || beans == null || beans.length == 0) {
			return beans;
		}

		JSONParser jsonParser = new JSONParser();
		Object jsonObject = jsonParser.parse(jsonString);
		JSONArray jsonArray = (JSONArray)jsonObject;
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject json = (JSONObject)jsonArray.get(i);
			Set set = json.keySet();
			Iterator iterator = set.iterator();
			String keyAttribute = null;
	        String lowerAttribute = null;

			while (iterator.hasNext()) {
				keyAttribute = (String) iterator.next();
	            lowerAttribute = keyAttribute.toLowerCase(Locale.ENGLISH);

	            setProperty(beans[i], lowerAttribute, json.get(keyAttribute));
			}
			setSysUser(beans[i]);
			updateList.add(beans[i]);
		}
		return beans;
	}

	// Json Object로 변환
	public Map<String,String> parseJsonObj(String key) throws Exception {
		Map<String,String> keyMap = new HashMap<String,String>();
		String keyStr = getValue(key, false);
		if (keyStr == null) {
			return keyMap;
		}
		keyMap = BeanUtil.convertJsonToMap(keyStr);
		return keyMap;
	}

}
