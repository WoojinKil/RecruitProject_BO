package kr.co.ta9.pandora3.sample;

import kr.co.ta9.pandora3.app.bean.CommonBean;

//샘플 팀별 실적 현황 VO
public class Sample1012 extends CommonBean {
	
	
	private String team;                   // 매입팀
	private int col1;                       // 금년 고객 수
	private int col2;                       // 전년 고객 수
	private int col3;                       // 구매 고객 신장률
	private int col4;                       // 금년 구매 금액
	private int col5;                       // 전년 구매 금액
	private int col6;                       // 구매 금액 신장률
	public String getTeam() {
		return team;
	}
	public void setTeam(String team) {
		this.team = team;
	}
	public int getCol1() {
		return col1;
	}
	public void setCol1(int col1) {
		this.col1 = col1;
	}
	public int getCol2() {
		return col2;
	}
	public void setCol2(int col2) {
		this.col2 = col2;
	}
	public int getCol3() {
		return col3;
	}
	public void setCol3(int col3) {
		this.col3 = col3;
	}
	public int getCol4() {
		return col4;
	}
	public void setCol4(int col4) {
		this.col4 = col4;
	}
	public int getCol5() {
		return col5;
	}
	public void setCol5(int col5) {
		this.col5 = col5;
	}
	public int getCol6() {
		return col6;
	}
	public void setCol6(int col6) {
		this.col6 = col6;
	}
	
	
	

}
