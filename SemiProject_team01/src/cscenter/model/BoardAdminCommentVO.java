package cscenter.model;

public class BoardAdminCommentVO {
	
	private int bcommentno;
	private String bcontent;
	private int fk_boardno;
	private String commDate;
	
	public String getCommDate() {
		return commDate;
	}

	public void setCommDate(String commDate) {
		this.commDate = commDate;
	}

	private CsBoardVO cvo;
	
	public CsBoardVO getCvo() {
		return cvo;
	}

	public void setCvo(CsBoardVO cvo) {
		this.cvo = cvo;
	}

	public int getBcommentno() {
		return bcommentno;
	}
	
	public void setBcommentno(int bcommentno) {
		this.bcommentno = bcommentno;
	}
	
	public String getBcontent() {
		return bcontent;
	}
	
	public void setBcontent(String bcontent) {
		this.bcontent = bcontent;
	}
	
	public int getFk_boardno() {
		return fk_boardno;
	}
	
	public void setFk_boardno(int fk_boardno) {
		this.fk_boardno = fk_boardno;
	}
	
	
	
}
