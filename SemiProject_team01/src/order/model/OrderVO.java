package order.model;

import member.model.MemberVO;
import product.model.ProductDetailVO;
import product.model.ProductVO;

public class OrderVO {
	
	private int odrcode; //주문코드
	private	String fk_userid ; //회원아이디
	private int	totalcost; // 주문총액
	private	String orderdate; //주문일자 
	private String odrstatus; //주문처리상태
	private String odrprgrss; //주문진행상태
	private	String invoicenum; //송장번호
	private	String delidate ;//-배송완료일자
	//------------- 주문자------------
	private String odrname;// 주문자명
	private	String odrmobile;//연락처
	private	String odremail;//이메일
	private	String odrpostcode;//우편번호
	private	String odraddress;//주소
	private	String odrdtaddress;//상세주소
	private	String odrextddress ;//참고항목
	//-----------------------------------------
	private	String payment;//결제수단번호
	//----------------배송지 -------------------
	private	String deliname  ;//받는사람
	private	String delimobile;//연락처
	private	String delipostcode;//우편번호
	private	String deliaddress;//주소
	private	String delidtaddress;//상세주소
	private	String deliextddress;// 참고항목
	private String	delimsg;// 배송메세지
	

	private MemberVO mvo;
	private ProductVO pvo;
	
	public String getOdrstatus() {
		return odrstatus;
	}

	public void setOdrstatus(String odrstatus) {
		this.odrstatus = odrstatus;
	}

	public String getOdrprgrss() {
		return odrprgrss;
	}

	public void setOdrprgrss(String odrprgrss) {
		this.odrprgrss = odrprgrss;
	}
	
	private int totalPrice; // 판매당시의 제품 판매가*주문량

	public int getOdrcode() {
		return odrcode;
	}

	public void setOdrcode(int odrcode) {
		this.odrcode = odrcode;
	}

	public String getFk_userid() {
		return fk_userid;
	}

	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}

	public int getTotalcost() {
		return totalcost;
	}

	public void setTotalcost(int totalcost) {
		this.totalcost = totalcost;
	}

	public String getOrderdate() {
		return orderdate;
	}

	public void setOrderdate(String orderdate) {
		this.orderdate = orderdate;
	}

	public String getInvoicenum() {
		return invoicenum;
	}

	public void setInvoicenum(String invoicenum) {
		this.invoicenum = invoicenum;
	}

	public String getDelidate() {
		return delidate;
	}

	public void setDelidate(String delidate) {
		this.delidate = delidate;
	}

	public String getOdrname() {
		return odrname;
	}

	public void setOdrname(String odrname) {
		this.odrname = odrname;
	}

	public String getOdrmobile() {
		return odrmobile;
	}

	public void setOdrmobile(String odrmobile) {
		this.odrmobile = odrmobile;
	}

	public String getOdremail() {
		return odremail;
	}

	public void setOdremail(String odremail) {
		this.odremail = odremail;
	}

	public String getOdrpostcode() {
		return odrpostcode;
	}

	public void setOdrpostcode(String odrpostcode) {
		this.odrpostcode = odrpostcode;
	}

	public String getOdraddress() {
		return odraddress;
	}

	public void setOdraddress(String odraddress) {
		this.odraddress = odraddress;
	}

	public String getOdrdtaddress() {
		return odrdtaddress;
	}

	public void setOdrdtaddress(String odrdtaddress) {
		this.odrdtaddress = odrdtaddress;
	}

	public String getOdrextddress() {
		return odrextddress;
	}

	public void setOdrextddress(String odrextddress) {
		this.odrextddress = odrextddress;
	}

	public String getPayment() {
		return payment;
	}

	public void setPayment(String payment) {
		this.payment = payment;
	}

	public String getDeliname() {
		return deliname;
	}

	public void setDeliname(String deliname) {
		this.deliname = deliname;
	}

	public String getDelimobile() {
		return delimobile;
	}

	public void setDelimobile(String delimobile) {
		this.delimobile = delimobile;
	}

	public String getDelipostcode() {
		return delipostcode;
	}

	public void setDelipostcode(String delipostcode) {
		this.delipostcode = delipostcode;
	}

	public String getDeliaddress() {
		return deliaddress;
	}

	public void setDeliaddress(String deliaddress) {
		this.deliaddress = deliaddress;
	}

	public String getDelidtaddress() {
		return delidtaddress;
	}

	public void setDelidtaddress(String delidtaddress) {
		this.delidtaddress = delidtaddress;
	}

	public String getDeliextddress() {
		return deliextddress;
	}

	public void setDeliextddress(String deliextddress) {
		this.deliextddress = deliextddress;
	}

	public String getDelimsg() {
		return delimsg;
	}

	public void setDelimsg(String delimsg) {
		this.delimsg = delimsg;
	}

}