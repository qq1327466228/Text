package link.doubi.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import link.doubi.dao.UserDao;
import link.doubi.pojo.Mail;
import link.doubi.pojo.User;
import link.doubi.service.UserService;
@Service("userService")
public class UserServiceImpl implements UserService{
	@Autowired
	private UserDao userDao;
	
	
	@Override
	public List<User> getAll() {
		// TODO Auto-generated method stub
		return userDao.getAll();
	}

	@Override
	public int land(String accountNumber, String password) {
		// TODO Auto-generated method stubuserDao
		return userDao.land(accountNumber, password);
	}

	@Override
	public User selectUser(String accountNumber, String password) {
		// TODO Auto-generated method stub
		return userDao.selectUser(accountNumber, password);
	}

	@Override
	public List<Mail> getSenderMail(int id) {
		// TODO Auto-generated method stub
		return userDao.getSenderMail(id);
	}

	@Override
	public List<Mail> getAddresseeMail(int id) {
		// TODO Auto-generated method stub
		return userDao.getAddresseeMail(id);
	}

	@Override
	public int register(User user) {
		// TODO Auto-generated method stub
		return userDao.register(user);
	}

	@Override
	public int inspect(String accountNumber) {
		// TODO Auto-generated method stub
		return userDao.inspect(accountNumber);
	}

	@Override
	public int sendout(Mail mail) {
		// TODO Auto-generated method stub
		return userDao.sendout(mail);
	}

	@Override
	public Mail selectid(int id) {
		// TODO Auto-generated method stub
		return userDao.selectid(id);
	}

	@Override
	public int updateRead(int id) {
		// TODO Auto-generated method stub
		return userDao.updateRead(id);
	}

	@Override
	public int deleteSenderMail(int id) {
		// TODO Auto-generated method stub
		return userDao.deleteSenderMail(id);
	}

	@Override
	public int deleteAddresseeMail(int id) {
		// TODO Auto-generated method stub
		return userDao.deleteAddresseeMail(id);
	}

	@Override
	public int welcome(User user) {
		// TODO Auto-generated method stub
		return userDao.welcome(user);
	}

	@Override
	public User judge(String accountNumber) {
		// TODO Auto-generated method stub
		return userDao.judge(accountNumber);
	}

}
