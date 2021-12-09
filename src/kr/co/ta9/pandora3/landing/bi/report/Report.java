package kr.co.ta9.pandora3.landing.bi.report;

import java.io.Serializable;
import java.util.List;

public class Report implements Serializable {
	
	private String reportId;

	public List<Prompt> getPrompts() {
		return prompts;
	}

	public void setPrompts(List<Prompt> prompts) {
		this.prompts = prompts;
	}

	//public List<Prompt> prompts; 
	private List<Prompt> prompts;
	
	public String getReportId() {
		return reportId;
	}

	public void setReportId(String reportId) {
		this.reportId = reportId;
	}

}
