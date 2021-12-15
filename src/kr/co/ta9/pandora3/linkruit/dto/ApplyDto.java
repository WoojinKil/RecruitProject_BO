package kr.co.ta9.pandora3.linkruit.dto;

public class ApplyDto extends BaseApplyDto {

	private String recruitname;
	private String objectname;
	private String workname;
	private String partname;
	public String getRecruitname() {
		return recruitname;
	}
	public void setRecruitname(String recruitname) {
		this.recruitname = recruitname;
	}
	public String getObjectname() {
		return objectname;
	}
	public void setObjectname(String objectname) {
		this.objectname = objectname;
	}
	public String getWorkname() {
		return workname;
	}
	public void setWorkname(String workname) {
		this.workname = workname;
	}
	public String getPartname() {
		return partname;
	}
	public void setPartname(String partname) {
		this.partname = partname;
	}
	public ApplyDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ApplyDto(String recruitname, String objectname, String workname, String partname) {
		super();
		this.recruitname = recruitname;
		this.objectname = objectname;
		this.workname = workname;
		this.partname = partname;
	}
	
	
	
	
}
