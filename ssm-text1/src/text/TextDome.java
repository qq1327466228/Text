package text;


import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import link.doubi.controller.IndexController;
import link.doubi.pojo.User;
import link.doubi.service.UserService;

public class TextDome {
	public static Logger logger = Logger.getLogger(IndexController.class);
	@Autowired
	private UserService userService;
	@Test
	public void test() {
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		
		UserService us = (UserService) context.getBean("userService");
		User user = new User();
		user.setAccountNumber("Textnumber");
		user.setName("Textname");
		user.setPassword("Textpwd");
		int count = us.register(user);
		logger.info("count:"+count);
	}

}
