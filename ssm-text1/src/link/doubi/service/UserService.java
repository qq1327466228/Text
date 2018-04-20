package link.doubi.service;

import java.util.List;


import link.doubi.pojo.Mail;
import link.doubi.pojo.User;

public interface UserService {
	public List<User> getAll();
	public int land( String accountNumber, String password);
	public User selectUser( String accountNumber, String password);
	public List<Mail> getSenderMail(int id);
	public List<Mail> getAddresseeMail(int id);
	public int register(User user);
	public int inspect(String accountNumber);
	public int sendout(Mail mail);
	public Mail selectid(int id);
	public int updateRead(int id);
	public int deleteSenderMail(int id);
	public int deleteAddresseeMail(int id);
	public int welcome(User user);
	public User judge(String accountNumber);
}
