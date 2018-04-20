<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>注册DouBi邮箱</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/index.css">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">


	<script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/Land.js"></script>
	
    	<!-- <script type="text/javascript" src="http://libs.baidu.com/jquery/1.10.2/jquery.min.js"> -->
    	<script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/jquery-3.2.1.min.js"></script>
    	<script type="text/javascript">
    		var myName = "";
    		$(document).ready(function() {
		    		$("#email").mouseout(function(){
				    	var inputValue = $("#email").val();
				    	var pwd = $("#password").val();
				    	var nicheng = $("#nicheng").val();
				    	if (inputValue == "") {
				    	    $("#demo").html("<font color='red'>请输入邮箱</font>");
				    	} else {
					    	$.ajax({
			                  url: "doInspect",
			                  dataType: 'text',
			                  data:{email:inputValue},
			                  method: 'POST',
			                  success: function(data) {
			                 	 myName = data;
			                    if(data=="Success"){
			                    	$("#demo").html("<font color='red'>邮箱可用</font>");
			                    }else{
			                    	$("#demo").html("<font color='red'>邮箱已被注册</font>");
			                    	
			                    }
			                 }});
				    	}
			   		});
		    		$("#register").click(function(){
				    	var inputValue = $("#email").val();
				    	var pwd = $("#password").val();
				    	var nicheng = $("#nicheng").val();
				    	if(myName=="Success"){//邮箱地址可用
				    	    	$.ajax({
				    	    	  type: "POST",
				                  url: "doRegister",
				                  data:{email:inputValue,name:nicheng,pwd:pwd},
				                  dataType: 'text',
				                  success: function(data) {
				                  		alert(data);
					              		window.location.href=data;
					              		myName="errer";
				                 }});
				    	}else{
				    		
				    	}
				    });
		    	})
    	</script>

  </head>
  
  <body>
    <div class="container">
    <div class="header"><!--标题div -->
        <img src="${pageContext.request.contextPath}/statics/img/icon.png">
        <a class="login" href="#">DouBi邮箱</a>
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
            <p class="zhanghao">账号密码注册</p>
            <hr/>
            <div class="login_denglu">
                <form method="post" action="doRegister" onsubmit="<!-- return zhuce(); -->">
                    <input type="text" name="email" id="email" placeholder="请输入邮箱账号" class="text" value="@doubi.com" ><br/>
                    <input type="text" name="nicheng" id="nicheng" placeholder="请输入昵称" class="text" value="" ><br/>
                    <input type="password" name="password" id="password" placeholder="请输入邮箱密码" class="text" value=""><br/>
                    <input type="password" name="password2" id="password2" placeholder="请再次输入邮箱密码" class="text" value=""><br/>
                    <input type="button" name="register" id="register" value="注册" class="button" >
                    <input type="button" name="fanhui" value="返回" class="button"  onclick="window.location='land'">
                </form>
            </div>
        </div>

    </div>
    <div id="demo" style="height:30px;"></div>
	
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
        <span class="gray">&copy;1998 - 2017 Tencent Inc. All Rights Reserved.</span>
    </div>
</div>

  </body>
</html>
