package cscenter.model;

public class CsBoardSmallCatetoryVO {
	//소분류 카테고리
	
	private int smallcateno;
	private String smallcatename;
	private int fk_bigcateno;
	
	private CsBoardBigCatetoryVO cbbcvo;
	
	public CsBoardBigCatetoryVO getCbbcvo() {
		return cbbcvo;
	}

	public void setCbbcvo(CsBoardBigCatetoryVO cbbcvo) {
		this.cbbcvo = cbbcvo;
	}

	public int getSmallcateno() {
		return smallcateno;
	}
	
	public void setSmallcateno(int smallcateno) {
		this.smallcateno = smallcateno;
	}
	
	public String getSmallcatename() {
		return smallcatename;
	}
	
	public void setSmallcatename(String smallcatename) {
		this.smallcatename = smallcatename;
	}
	
	public int getFk_bigcateno() {
		return fk_bigcateno;
	}
	
	public void setFk_bigcateno(int fk_bigcateno) {
		this.fk_bigcateno = fk_bigcateno;
	}
	
}
