package product.model;

import common.controller.AbstractController;

public class CategoryVO {

	private int cnum; 	// 카테고리 대분류 번호
	private String code; // 카테고리 코드
	private String canme; // 카테고리명
	
	public int getCnum() {
		return cnum;
	}
	public void setCnum(int cnum) {
		this.cnum = cnum;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCanme() {
		return canme;
	}
	public void setCanme(String canme) {
		this.canme = canme;
	}
}
