package cscenter.model;

public class CsBoardBigCategoryVO {
	//대분류 카테고리
	
	private int bigcateno; //대분류카테고리번호
	private String bigcatename; //대분류카테고리명
	
	public int getBigcateno() {
		return bigcateno;
	}
	
	public void setBigcateno(int bigcateno) {
		this.bigcateno = bigcateno;
	}
	
	public String getBigcatename() {
		return bigcatename;
	}
	
	public void setBigcatename(String bigcatename) {
		this.bigcatename = bigcatename;
	}
	
}