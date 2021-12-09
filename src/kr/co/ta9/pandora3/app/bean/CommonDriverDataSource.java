package kr.co.ta9.pandora3.app.bean;

import org.apache.commons.dbcp.BasicDataSource;

//class="org.apache.commons.dbcp.BasicDataSource"

import kr.co.ta9.pandora3.app.util.KmsUtil;
import kr.co.ta9.pandora3.common.conf.Configuration;

public class CommonDriverDataSource extends BasicDataSource {
		@Override
		 public void setPassword(String password) {
			  String temp ="";
			  Configuration configuration = Configuration.getInstance();
			  String target = configuration.get("properties.target");


			  if("local".equals(target.trim())){
				 temp = password;
			  }
			  else{
				  temp = KmsUtil.KmsDecrypt(password);
			  }
			  super.setPassword( temp) ;
		  }

}
