function denglu(){
	var loginName = $("input[name='name']").val();
	var loginNpwd = $("input[name='pwd']").val();
	if(loginName==null || loginName==""){
        alert("用户名不能为空");
        return false;
    }
	if (loginNpwd ==""||loginNpwd==null) {
        alert("密码不能为空");
        return false;
    }
}

function error(){
	alert("账号或者密码错误！请检查您的账号或者密码从新登陆！!");
	self.location='Land.jsp'; 
}

function zhuce(){
	var loginName = $("input[name='name']").val();
	var loginNpwd = $("input[name='pwd']").val();
	var loginNpwd2 = $("input[name='pwd2']").val();
	if(loginName==null || loginName==""){
        alert("邮箱名不能为空");
        return false;
    }
	if (loginNpwd ==""||loginNpwd==null) {
        alert("密码不能为空");
        return false;
    }
	if (loginNpwd !=loginNpwd2) {
        alert("两次密码不同！");
        return false;
    }
	var str =/[a-zA-Z0-9]{6,9}/;
	if(str.test(loginName)){
		
	}else{
		alert("请规范邮箱账号！6-10的数字字母任意组合！");
        return false;
	}
}
