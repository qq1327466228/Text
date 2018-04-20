<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>登录DouBi邮箱</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/Land.js"></script>
	<script type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/index.css">
   	<script type="text/javascript">
  	 	function land(){
	   		var name = $("#nameid").val();
	   		var password = $("#password").val();
	   		$.ajax({
				url: "dologin",
				dataType: 'text',
				data:{name:name,pwd:password},
				method: 'POST',
				success: function(data) {
				if(data=="Success"){
				     window.location='welcome';
				}
			}});}
   	</script>
  </head>
  
  <body>
    <div class="container">
    <div class="header"><!--标题div -->
        <img src="${pageContext.request.contextPath}/statics/img/icon.png">
        <a class="login" href="Land.jsp">DouBi邮箱</a>
    </div>
    <div class="content">
                <div class="login_picture" >
                    <p class="login_txt">DouBi邮箱，常联系！</p>
                    <p>没有什么能够阻挡</p>
                    <p>你对自由的向往</p>
                    <p>天马行空的生涯</p>
                    <p>你的心了无牵挂</p>
                    <p class="">摘自《蓝莲花》</p>
                </div>
        <div id="login"><!--登陆div -->
            <p class="zhanghao">账号密码登陆</p>
            <hr/>
            <div class="login_denglu">
                <form method="post" action="dologin" onsubmit="return denglu();">
                    <input id="nameid" type="text" name="name" placeholder="请输入邮箱账号" class="text"><br/>
                    <input  id="password" type="password" name="pwd" placeholder="请输入邮箱密码" class="text"><br/>
                    <input type="button" name="Submit" value="登陆" class="button" onclick="land()">
                    <input type="button" name="register" value="注册" class="button"  onclick="window.location='register'">
                </form>
            </div>
        </div>

    </div>
    <div class="footer"><!--脚部div -->
        <a href="#" target="_blank">关于DouBi</a>
        &nbsp;|&nbsp;
        <a href="#" target="_blank">服务条款</a>
        &nbsp;|&nbsp;
        <a href="#" target="_blank">客服中心</a>
        &nbsp;|&nbsp;
        <a href="#" target="_blank">联系我们</a>
        &nbsp;|&nbsp;
        <a href="http://www.baidu.com">帮助中心</a>
        &nbsp;|&nbsp;
        <span class="gray">&copy;1998 - 2017 Doubi Inc. All Rights Reserved.</span>
    </div>
</div>

  </body>
</html>
