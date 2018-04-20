package link.doubi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import link.doubi.pojo.Mail;
import link.doubi.pojo.User;

public interface UserDao {
	@Select("select * from user")
	List<User> getAll();
	@Select("select count(*) from User where accountNumber = #{accountNumber} and password = #{password}")
	int land(@Param("accountNumber") String loginName, @Param("password") String passWord);
	@Select("select * from User where accountNumber = #{accountNumber} and password = #{password}")
	User selectUser(@Param("accountNumber") String loginName, @Param("password") String passWord);
	//3.	查询发送箱的邮件
	@Select("SELECT m.id,u1.name as sendername,u1.accountNumber as sender,u2.name as addresseename,u2.accountNumber as addressee,theme,content,falg,time,senderfalg from mail m ,user u1, user u2  WHERE u2.id = m.addressee and u1.id = m.sender and u1.id=#{0} and senderfalg = 0;;")
	List<Mail> getAddresseeMail(int id);
	
	//4.	查询收信箱的邮件
	@Select("SELECT m.id,u1.name as sendername,u1.accountNumber as sender,u2.name as addresseename,u2.accountNumber as addressee,theme,content,falg,time,addresseefalg from mail m ,user u1, user u2  WHERE u2.id = m.addressee and u1.id = m.sender and u2.id=#{0} and addresseefalg = 0;")
	List<Mail> getSenderMail(int id);
	//5.	发送邮件
	@Insert("insert into `mail` (sender,addressee,theme,content,falg,senderfalg,addresseefalg) values (#{sender},(SELECT id from user WHERE accountNumber = #{addresseename}),#{theme},#{content},0,0,0);")
	int sendout(Mail mail);
	//6.	群发邮件
	boolean sendouts(List<Mail> maillist);
	//7.	删除发信箱邮件
	@Update("UPDATE `mail` SET `senderfalg`='1' WHERE (`id`=#{id})")
	int deleteSenderMail(int id);
	//7.	删除收信箱邮件
	@Update("UPDATE `mail` SET `addresseefalg`='1' WHERE (`id`=#{id})")
	int deleteAddresseeMail(int id);
	//8.	屏蔽用户  （黑名单功能）
	boolean shield(@Param("id")int id,@Param("userid")int userid);
	//9.	更新已读邮箱
	@Update("update mail set falg=1 where id=#{id};")
	int updateRead(int id);
	//10.	查看具体邮件
	@Select("SELECT m.id,u1.name as sendername,u1.accountNumber as sender,u2.name as addresseename,u2.accountNumber as addressee,theme,content,falg,time,senderfalg,addresseefalg from mail m ,user u1, user u2 WHERE u2.id = m.addressee and u1.id = m.sender and m.id=#{id}")
	Mail selectid(int id);
	//11.	查询邮件收信人/发信人是否为本人
	boolean select(@Param("id")int id,@Param("userid")int userid);
	//12.	记录对方账号 * (通讯录功能)
	boolean record(int id);
	//13.	通过邮箱名查询用户id
	@Select("SELECT * from user WHERE accountNumber = #{accountNumber};")
	User judge(String accountNumber);
	//14.	发信时，判断收信人是否存在
	@Select("SELECT count(id) from user WHERE accountNumber = #{accountNumber};")
	int chaxun(String accountNumber);
	//注册操作
	//1）	检查邮箱地址是否重名
	@Select("SELECT COUNT(*) from `user` WHERE accountNumber = #{0}")
	int inspect(String accountNumber);
	//2）	注册账号	
	@Insert("insert into `user`(accountNumber,password,name)  values (#{accountNumber},#{password},#{name})")
	int register(User user);
	//3）	自动发送一条欢迎邮件
	@Insert("INSERT INTO `mail` (`sender`, `addressee`, `theme`, `content`, `senderfalg`, `addresseefalg`) VALUES ('9', #{id}, '欢迎来到逗比邮箱！', '欢迎您来到逗比邮箱！  ', '0', '0')")
	int welcome(User user);
}
