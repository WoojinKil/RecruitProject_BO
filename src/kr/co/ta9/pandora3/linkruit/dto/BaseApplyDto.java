package kr.co.ta9.pandora3.linkruit.dto;

import java.sql.Timestamp;

import kr.co.ta9.pandora3.app.bean.CommonBean;
import kr.co.ta9.pandora3batch.app.util.DateTime;

public class BaseApplyDto extends CommonBean {

	private String applyno;
	private String recruitno;
	private String partno;
	private String objectno;
	private String workno;
	private String applycontent;
	private String applyupdatedate;
	
	
	
	public String getApplyupdatedate() {
		return applyupdatedate;
	}
	public void setApplyupdatedate(String applyupdatedate) {
		this.applyupdatedate = applyupdatedate;
	}
	public String getApplyno() {
		return applyno;
	}
	public void setApplyno(String applyno) {
		this.applyno = applyno;
	}
	public String getRecruitno() {
		return recruitno;
	}
	public void setRecruitno(String recruitno) {
		this.recruitno = recruitno;
	}
	public String getPartno() {
		return partno;
	}
	public void setPartno(String partno) {
		this.partno = partno;
	}
	public String getObjectno() {
		return objectno;
	}
	public void setObjectno(String objectno) {
		this.objectno = objectno;
	}
	public String getWorkno() {
		return workno;
	}
	public void setWorkno(String workno) {
		this.workno = workno;
	}
	public String getApplycontent() {
		return applycontent;
	}
	public void setApplycontent(String applycontent) {
		this.applycontent = applycontent;
	}
	
	
	
}
