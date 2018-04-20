package link.doubi.pojo;

import java.util.List;

import com.github.pagehelper.PageInfo;

public class User {
	private int id;
	private String accountNumber;
	private String password;
	private String name;

	private List<Mail> senderMailList;//发信箱邮件
	private List<Mail> addresseeMailList;//收信箱邮件
	private PageInfo<Mail> senderPageInfo;//发信箱邮件
	private PageInfo<Mail> addresseePageInfo;//收信箱邮件
	private List<Blacklist> blacklist;//黑名单列表
	private List<Maillist> maillist;//好友列表
	
	
	public List<Mail> getSenderMailList() {
		return senderMailList;
	}
	public void setSenderMailList(List<Mail> senderMailList) {
		this.senderMailList = senderMailList;
	}
	public List<Mail> getAddresseeMailList() {
		return addresseeMailList;
	}
	public void setAddresseeMailList(List<Mail> addresseeMailList) {
		this.addresseeMailList = addresseeMailList;
	}
	public List<Blacklist> getBlacklist() {
		return blacklist;
	}
	public void setBlacklist(List<Blacklist> blacklist) {
		this.blacklist = blacklist;
	}
	public List<Maillist> getMaillist() {
		return maillist;
	}
	public void setMaillist(List<Maillist> maillist) {
		this.maillist = maillist;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getAccountNumber() {
		return accountNumber;
	}
	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
