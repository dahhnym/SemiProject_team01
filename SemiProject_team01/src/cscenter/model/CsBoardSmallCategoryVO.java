package cscenter.model;

public class CsBoardSmallCategoryVO {
	//소분류 카테고리
	
	private int smallcateno; //소분류카테고리번호
	private String smallcatename; //소분류카테고리명
	private int fk_bigcateno; //대분류카테고리번호
	
	private CsBoardBigCategoryVO cbbcvo; //대분류카테고리VO
	
	public CsBoardBigCategoryVO getCbbcvo() {
		return cbbcvo;
	}

	public void setCbbcvo(CsBoardBigCategoryVO cbbcvo) {
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
