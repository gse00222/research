package gagebu;

public class GagebuVo {
	private int idx;
	private String wdate;
	private String gcode;
	private int price;
	private String content;
	private int balance;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	public String getGcode() {
		return gcode;
	}
	public void setGcode(String gcode) {
		this.gcode = gcode;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getBalance() {
		return balance;
	}
	public void setBalance(int balance) {
		this.balance = balance;
	}
	@Override
	public String toString() {
		return "GagebuVo [idx=" + idx + ", wdate=" + wdate + ", gcode=" + gcode + ", price=" + price + ", content="
				+ content + ", balance=" + balance + "]";
	}
	
	
}
