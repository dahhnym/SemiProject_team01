package product.model;

public class ProductDetailVO {

	private int pdetailnum;     //제품상세번호
	private int fk_pnum;        //제품번호
	private String optionname;  //옵션명
	private int pqty;           //제품 재고량
	private int saleqty;        //누적판매량
	private String pinputdate;  //제품입고일자
	
	private ProductVO pdvo;
	
	public ProductVO getPdvo() {
		return pdvo;
	}
	public void setPdvo(ProductVO pdvo) {
		this.pdvo = pdvo;
	}
	public int getPdetailnum() {
		return pdetailnum;
	}
	public void setPdetailnum(int pdetailnum) {
		this.pdetailnum = pdetailnum;
	}
	public int getFk_pnum() {
		return fk_pnum;
	}
	public void setFk_pnum(int fk_pnum) {
		this.fk_pnum = fk_pnum;
	}
	public String getOptionname() {
		return optionname;
	}
	public void setOptionname(String optionname) {
		this.optionname = optionname;
	}
	public int getPqty() {
		return pqty;
	}
	public void setPqty(int pqty) {
		this.pqty = pqty;
	}
	public int getSaleqty() {
		return saleqty;
	}
	public void setSaleqty(int saleqty) {
		this.saleqty = saleqty;
	}
	public String getPinputdate() {
		return pinputdate;
	}
	public void setPinputdate(String pinputdate) {
		this.pinputdate = pinputdate;
	}
	
	
}
