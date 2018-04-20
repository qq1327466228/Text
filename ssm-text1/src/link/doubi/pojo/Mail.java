package link.doubi.pojo;
/**
 * 邮件实体类
 * @author Mr丶逗逼
 * @Time 上午8:12:07
 * @Mail 1327466228@qq.com
 */
public class Mail {
	private int id;
	private String sender;//发信人
	private String sendername;//发信人姓名
	private String addressee;//收信人
	private String addresseename;//收信人姓名
	private String theme;//主题
	private String content;//内容
	private int falg;//是否已读
	private String time;//shijian
	private int senderfalg;//发信人是否删除
	private int addresseefalg;//收信人是否删除
	
	
	public int getSenderfalg() {
		return senderfalg;
	}
	public void setSenderfalg(int senderfalg) {
		this.senderfalg = senderfalg;
	}
	public int getAddresseefalg() {
		return addresseefalg;
	}
	public void setAddresseefalg(int addresseefalg) {
		this.addresseefalg = addresseefalg;
	}
	public String getSendername() {
		return sendername;
	}
	public void setSendername(String sendername) {
		this.sendername = sendername;
	}
	public String getAddresseename() {
		return addresseename;
	}
	public void setAddresseename(String addresseename) {
		this.addresseename = addresseename;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getAddressee() {
		return addressee;
	}
	public void setAddressee(String addressee) {
		this.addressee = addressee;
	}
	public String getTheme() {
		return theme;
	}
	public void setTheme(String theme) {
		this.theme = theme;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getFalg() {
		return falg;
	}
	public void setFalg(int falg) {
		this.falg = falg;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	
}
