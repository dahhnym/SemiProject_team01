package cscenter.model;

public class FaqboardVO {
	//자식
	
	// 자주묻는 질문
	
	private int faqNo; //자.묻 번호
	private String faqtitle; //자.묻 제목
	private String faqcontent; //자.묻 내용
	private int fk_fcNo; //자.묻 카테고리번호
	
	//부모 클래스
	private FaqCategoryVO fcvo;
	
	public FaqCategoryVO getFcvo() {
		return fcvo;
	}

	public void setFcvo(FaqCategoryVO fcvo) {
		this.fcvo = fcvo;
	}

	public int getFaqNo() {
		return faqNo;
	}
	
	public void setFaqNo(int faqNo) {
		this.faqNo = faqNo;
	}
	
	public String getFaqtitle() {
		return faqtitle;
	}
	
	public void setFaqtitle(String faqtitle) {
		this.faqtitle = faqtitle;
	}
	
	public String getFaqcontent() {
		return faqcontent;
	}
	
	public void setFaqcontent(String faqcontent) {
		this.faqcontent = faqcontent;
	}
	
	public int getFk_fcNo() {
		return fk_fcNo;
	}
	
	public void setFk_fcNo(int fk_fcNo) {
		this.fk_fcNo = fk_fcNo;
	}
	
	
}
