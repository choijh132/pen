package member;
import java.sql.Timestamp;

public class PaymentDTO {
	private int paymentnum;
	private int basketnum;
	private int productnum;
	private String productname;
	private int productprice;
	private int packingprice;
	private int totalprice;
	private int inkblack;
	private int inkred;
	private int inkblue;
	private int inkgreen;
	private String id;
	private String address;
	private String phone;
	private Timestamp reg;
	public int getPaymentnum() {
		return paymentnum;
	}
	public void setPaymentnum(int paymentnum) {
		this.paymentnum = paymentnum;
	}
	public int getBasketnum() {
		return basketnum;
	}
	public void setBasketnum(int basketnum) {
		this.basketnum = basketnum;
	}
	public int getProductnum() {
		return productnum;
	}
	public void setProductnum(int productnum) {
		this.productnum = productnum;
	}
	public String getProductname() {
		return productname;
	}
	public void setProductname(String productname) {
		this.productname = productname;
	}
	public int getProductprice() {
		return productprice;
	}
	public void setProductprice(int productprice) {
		this.productprice = productprice;
	}
	public int getPackingprice() {
		return packingprice;
	}
	public void setPackingprice(int packingprice) {
		this.packingprice = packingprice;
	}
	public int getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}
	public int getInkblack() {
		return inkblack;
	}
	public void setInkblack(int inkblack) {
		this.inkblack = inkblack;
	}
	public int getInkred() {
		return inkred;
	}
	public void setInkred(int inkred) {
		this.inkred = inkred;
	}
	public int getInkblue() {
		return inkblue;
	}
	public void setInkblue(int inkblue) {
		this.inkblue = inkblue;
	}
	public int getInkgreen() {
		return inkgreen;
	}
	public void setInkgreen(int inkgreen) {
		this.inkgreen = inkgreen;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	
	
	
	
}
