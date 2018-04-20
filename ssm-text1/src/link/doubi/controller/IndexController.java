package link.doubi.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import link.doubi.pojo.Mail;
import link.doubi.pojo.User;
import link.doubi.service.UserService;

@Controller
public class IndexController {
	@Autowired
	private UserService userService;
	
	
	public static Logger getLogger() {
		return logger;
	}
	public static void setLogger(Logger logger) {
		IndexController.logger = logger;
	}
	public static Logger logger = Logger.getLogger(IndexController.class);
	/**
	 * 访问登陆页面
	 * @return
	 */
	@RequestMapping("/land")
	public String land(){
		logger.info("访问了land");
		return "Land";
	}
	/**
	 * 访问welcome
	 * @return
	 */
	@RequestMapping("/welcome")
	public String welcome(HttpSession session){
		logger.info("访问了welcome");
		if(session.getAttribute("user")==null){
			logger.info("未登录跳回land");
			return "Land";
		}
		String loginName = ((User)session.getAttribute("user")).getAccountNumber();
		String passWord = ((User)session.getAttribute("user")).getPassword();
		int count = userService.land(loginName, passWord);
			User user = userService.selectUser(loginName, passWord);
			//user.setAddresseeMailList((List<Mail>)new PageInfo(userService.getAddresseeMail(user.getId())));
			//user.setSenderMailList((List<Mail>)new PageInfo(userService.getSenderMail(user.getId())));
			/*user.setAddresseePageInfo(new PageInfo<Mail>(userService.getAddresseeMail(user.getId())));
			user.setSenderPageInfo(new PageInfo<Mail>(userService.getSenderMail(user.getId())));*/
			user.setSenderMailList(userService.getSenderMail(user.getId()));
			user.setAddresseeMailList(userService.getAddresseeMail(user.getId()));
			session.setAttribute("user", user);
		return "Welcome";
	}
	
	/**
	 * 用户登录
	 * @param loginName 登录名
	 * @param passWord 登录密码
	 */
	@RequestMapping("dologin")
	@ResponseBody
	public String login(ModelMap map,
			@RequestParam(required = false, value = "name") String loginName,
			@RequestParam(required = false, value = "pwd") String passWord,
			HttpSession session) {
		
		// 如果登录名或密码未填写，直接返回登录页面
		if (StringUtils.isEmpty(loginName) || StringUtils.isEmpty(passWord)) {
			return "Land";
		}
		
		// 校验用户名、密码是否正确
		logger.info("loginName:"+loginName+"       passWord"+passWord);
		int count = userService.land(loginName, passWord);
		if (count==1) {//如果正确
			PageHelper.startPage(1, 10);
			User user = userService.selectUser(loginName, passWord);
			//user.setAddresseeMailList((List<Mail>)new PageInfo(userService.getAddresseeMail(user.getId())));
			//user.setSenderMailList((List<Mail>)new PageInfo(userService.getSenderMail(user.getId())));
			/*user.setAddresseePageInfo(new PageInfo<Mail>(userService.getAddresseeMail(user.getId())));
			user.setSenderPageInfo(new PageInfo<Mail>(userService.getSenderMail(user.getId())));*/
			//user.setAddresseeMailList(new PageInfo<Mail>(userService.getAddresseeMail(user.getId())).getList());
			//user.setSenderMailList(new PageInfo<Mail>(userService.getSenderMail(user.getId())).getList());
			user.setSenderMailList(userService.getSenderMail(user.getId()));
			user.setAddresseeMailList(userService.getAddresseeMail(user.getId()));
			session.setAttribute("user", user);
			return "Success";
		}else{
			// 
			return "Land";
		}
	}
	/**
	 * 访问注册页面
	 * @return
	 */
	@RequestMapping("/register")
	public String register(){
		logger.info("访问了register");
		return "Register";
	}
	public static boolean falg = false;
	/**
	 * 注册操作
	 */
	@RequestMapping(value="/doRegister",method=RequestMethod.POST)
	@ResponseBody
	public String doRegister(ModelMap map,
			@RequestParam(required = false, value = "email") String loginName,
			@RequestParam(required = false, value = "pwd") String passWord,
			@RequestParam(required = false, value = "name") String nicheng,
			HttpSession session
			){
		logger.info("loginName:"+loginName+",passWord:"+passWord+",nicheng:"+nicheng);
		// 如果登录名或密码未填写，直接返回注册
		if (StringUtils.isEmpty(loginName) || StringUtils.isEmpty(passWord)) {
			return "Register";
		}
		
		if(!falg){
			map.addAttribute("re", "邮箱地址被占用！");
			return "Register";
		}else {
			// 校验用户名、密码是否正确
			logger.info("loginName:"+loginName+"       passWord"+passWord+"    name:"+nicheng);
			User user = new User();
			user.setName(nicheng);
			user.setPassword(passWord);
			user.setAccountNumber(loginName);
			int count = userService.register(user);
			
			if (count==1) {//如果注册成功
				user = userService.judge(loginName);
				userService.welcome(user);//一条欢迎的邮件
				user.setAddresseeMailList(userService.getAddresseeMail(user.getId()));
				user.setSenderMailList(userService.getSenderMail(user.getId()));
				map.addAttribute("name", loginName);
				map.addAttribute("user", user);
				session.setAttribute("user", user);
				logger.info("注册成功了");
				return "welcome";
			}else{
				// 
				return "Land";
			}
		}
	}
	/**
	 * 验证邮箱是否重复
	 */
	@RequestMapping(value="/doInspect",method=RequestMethod.POST)
	@ResponseBody
	public String inspect(Model map,
			@RequestParam(required = false, value = "email") String loginName
			){
			logger.info("访问了:doInspect");
			logger.info("loginName:"+loginName);
			int count = userService.inspect(loginName);
			logger.info("count："+count);
			if (StringUtils.isEmpty(loginName)){
				return "index";
			}
			if (count==1) {//如果被占用
				falg = false;
				logger.info("占用");
				return "error";
			}else{
				falg = true;
				logger.info("未占用");
				return "Success";
			}
		
	}
	/**
	 * 验证邮箱是否重复
	 */
	@RequestMapping(value="/yanzheng",method=RequestMethod.POST)
	@ResponseBody
	public String yanzheng(Model map,
			@RequestParam(required = false, value = "email") String loginName
			){
			logger.info("访问了:yanzheng");
			logger.info("loginName:"+loginName);
			int count = userService.inspect(loginName);//查询是否存在目标邮箱
			logger.info("count："+count);
			if (count==1) {
				logger.info("存在目标邮箱");
				return "Success";
			}else{
				logger.info("不存在目标邮箱");
				return "error";
			}
	}
	/**
	 * 发送邮箱
	 */
	@RequestMapping(value="/sendout",method=RequestMethod.POST)
	@ResponseBody
	public String sendout(Model map,
			@RequestParam(required = false, value = "sender") String sender,//自己的用户id
			@RequestParam(required = false, value = "theme") String theme,
			@RequestParam(required = false, value = "content") String content,
			@RequestParam(required = false, value = "addresseename") String addresseename//目标用户的邮箱
			){
			logger.info("访问了:sendout");
			logger.info("sender:"+sender+"theme:"+theme+"content:"+content+"addressee:"+addresseename);
			Mail mail = new Mail();
			mail.setSender(sender);
			mail.setContent(content);
			mail.setTheme(theme);
			mail.setAddresseename(addresseename);
			int count = userService.sendout(mail);
			logger.info("count："+count);
			if (count==1) {
				logger.info("发送邮件成功");
				return "Success";
			}else{
				logger.info("发送邮件失败");
				return "error";
			}
	}
	/**
	 * 查询邮箱具体内容
	 */
	@RequestMapping(value="/selectid",method=RequestMethod.POST)
	@ResponseBody
	public String selectid(Model map,
			@RequestParam(required = false, value = "sender") int id,//邮件id
			@RequestParam(required = false, value = "count") int count,//对收信箱和发信箱的判断
			@RequestParam(required = false, value = "falg") int falg,//是点击了 还是真正查看了
			HttpSession session
			){
			logger.info("访问了:sendout");
			logger.info("sender:"+id);
			Mail mail = userService.selectid(id);
			if(count==0){//收信箱查看时  更新已读
				userService.updateRead(id);
			}
			logger.info("count："+mail.getSender());
			if (mail!=null) {
				logger.info("查询邮件成功");
				if(falg==1){//如果为1 是真正查看
					session.setAttribute("selectmail", mail);
				}
				
				return "Success";
			}else{
				logger.info("查询邮件失败");
				return "error";
			}
	}
	/**
	 * 清空session 
	 */
	@RequestMapping(value="/clear")
	@ResponseBody
	public String clear(HttpSession session){
			logger.info("访问了:clear");
			session.removeAttribute("selectmail");
			return "Success";
	}
	/**
	 * 查询邮箱具体内容
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public String delete(@RequestParam(required = false, value = "mailid") int id,//邮件id
			@RequestParam(required = false, value = "count") int count,//对收信箱和发信箱的判断
			HttpSession session){
			logger.info("访问了:delete");
			logger.info("delete:"+id);
			if(count==1){//如果是删除收信箱
				userService.deleteAddresseeMail(id);
			}else{//如果是删除的发信箱
				userService.deleteSenderMail(id);
			}
			return "Success";
	}
}
