package member.model;

public class PointVO {

	private int pointcode; // number not null -- 포인트 식별번호
	private int point; // number(8) not null -- 포인트
	private int fk_odrcode; //    number(8)  not null -- 주문 코드 
	private String fk_userid; // varchar2(20) not null -- 회원아이디
	private String pointdate; //  date default sysdate     -- 적립일자 
	private int status; // number(1) default 0 -- 0은 적립, 1은 사용
	
	private MemberVO mvo;
	
	
	
	public int getPointcode() {
		return pointcode;
	}
	public void setPointcode(int pointcode) {
		this.pointcode = pointcode;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getFk_odrcode() {
		return fk_odrcode;
	}
	public void setFk_odrcode(int fk_odrcode) {
		this.fk_odrcode = fk_odrcode;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public String getPointdate() {
		return pointdate;
	}
	public void setPointdate(String pointdate) {
		this.pointdate = pointdate;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public MemberVO getMvo() {
		return mvo;
	}
	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}
	
}
