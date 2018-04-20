<%@ page language="java" import="java.util.*,link.doubi.pojo.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/statics/css/welcome.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/statics/bootstrap-3.3.7-dist/css/bootstrap-theme.min.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/statics/bootstrap-3.3.7-dist/css/bootstrap.min.css" />
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script>
		var myName = "";
		function myfun(){ 　　 
					if('${sessionScope.selectmail.theme}'!=''){
							$("#Check_shouxinren").val('${sessionScope.selectmail.addressee}');
							$("#Check_theme").val('${sessionScope.selectmail.theme}');
							$("#Check_content").val('${sessionScope.selectmail.content}'); 
							$("#The_receiver").slideUp();
							$("#Check_mailbox").slideDown();
							$("#Letter").slideUp();
							$("#Write_letters").slideUp();
							$.ajax({
							    url: "clear",
							    data:{ce:""},
							    dataType: 'text',
							    method: 'POST',
							    success: function(data) {
								    if(data=="Success"){
							    }}});
					} 
		} 　　/*用window.onload调用myfun()*/　　
		window.onload = myfun;
			function changeArea(odj){//收信箱更新已读
 				var count = $(odj).parent().find('td').last().find('span').text();
 				$.ajax({
				    url: "selectid",
				    dataType: 'text',
				    data:{sender:count,count:0,falg:1},
				    method: 'POST',
				    success: function(data) {
					    if(data=="Success"){
					    	//隐藏btn btn-warning
					    	$(odj).find('td').eq(-2).hide();
					    	window.location.href='${pageContext.request.contextPath}/welcome';
				    }}});
			}
			function change(odj){//发信箱不更新已读
 				var count = $(odj).parent().find('td').last().find('span').text();
 				$.ajax({
				    url: "selectid",
				    dataType: 'text',
				    data:{sender:count,count:1,falg:1},
				    method: 'POST',
				    success: function(data) {
					    if(data=="Success"){
					   		 var id='<%=request.getAttribute("selectmail")%>';  
					    	window.location.href='${pageContext.request.contextPath}/welcome';
				    }}});
			}
			function yiduan(obj){//直接进行已读
 				var count = $(obj).parent().parent().find('td').last().find('span').text();
 				$.ajax({
				    url: "selectid",
				    dataType: 'text',
				    data:{sender:count,count:0,falg:0},
				    method: 'POST',
				    success: function(data) {
					    if(data=="Success"){
					    	//隐藏btn btn-warning
					    	$(obj).hide();
					    	//window.location.href='${pageContext.request.contextPath}/welcome';
				    }}}); 
			}
			function deleteAddresseeMail(obj){//如果是删除收信箱
				if(confirm('确定要删除吗？')){
				  	var count = $(obj).parent().parent().find('td').last().find('span').text();
	 				$.ajax({
					    url: "delete",
					    dataType: 'text',
					    data:{mailid:count,count:1},
					    method: 'POST',
					    success: function(data) {
						    if(data=="Success"){
						    	$(obj).parent().parent().hide();
						    	//window.location.href='${pageContext.request.contextPath}/welcome';
					    }}}); 
				}
			}
			function deleteSenderMail(obj){//如果是删除收信箱
			if(confirm('确定要删除吗？')){
 				var count = $(obj).parent().parent().find('td').last().find('span').text();
 				$.ajax({
				    url: "delete",
				    dataType: 'text',
				    data:{mailid:count,count:1},
				    method: 'POST',
				    success: function(data) {
					    if(data=="Success"){
					    	$(obj).parent().parent().hide();
					    	//window.location.href='${pageContext.request.contextPath}/welcome';
				    }}}); 
				    }
			}
			
        $(document).ready(function () {
        	$("#jinggao").hide();
            $("#xiexin").click(function () {
                $("#The_receiver").slideUp();
                $("#Check_mailbox").slideUp();
                $("#Letter").slideUp();
                $("#Write_letters").slideDown();
            })
            $("#shouxin").click(function () {
                $("#Letter").slideUp();
                $("#Check_mailbox").slideUp();
                $("#Write_letters").slideUp();
                $("#The_receiver").slideDown();
                //$(".meilSender").html("收信人");
            })
            $("#faxin").click(function () {
                $("#The_receiver").slideUp();
                $("#Write_letters").slideUp();
                $("#Check_mailbox").slideUp();
                $("#Letter").slideDown();
                //$(".meilSender").html("发信人");
            })
            $(".tou").click(function () {
                $("#The_receiver").hide();
                $("#Write_letters").hide();
                $("#Check_mailbox").hide();
                $("#Letter").hide();
            })
			$("#zhuti").click(jiancha);
			$("#neirong").click(jiancha);
			$("#zhuti").blur(jiancha);
			$("#neirong").blur(jiancha);
			function jiancha(){
				var inputValue = $("#shouxinren").val();
				var ziji = "${sessionScope.user.accountNumber}";
				if(inputValue==ziji){
					$("#jinggao").show();
			        $("#jinggao").text("没事不要给自己发邮件。");
			        return;
				}else{
					$("#jinggao").hide();
			        $("#jinggao").text("");
				}
				//检查邮箱格式
				
				//验证是否存在
						$.ajax({
			                  url: "yanzheng",
			                  dataType: 'text',
			                  data:{email:inputValue},
			                  method: 'POST',
			                  success: function(data) {
			                 	 myName = data;
			                    if(data=="Success"){
			                    	$("#jinggao").hide();
			                    	$("#jinggao").text("");
			                    }else{
			                    	$("#jinggao").show();
			                    	$("#jinggao").text("目标邮箱地址不存在！");
			                    }
			                 }});
			}
			
			$("#fasong").click(fasong);
			function fasong(){//发送邮件ajax
				var sender = "${sessionScope.user.id}";
				var theme = $("#theme").val();
				var content = $("#content").val();
				var addresseename = $("#shouxinren").val();
						$.ajax({
			                  url: "sendout",
			                  dataType: 'text',
			                  data:{sender:sender,theme:theme,content:content,addresseename:addresseename},
			                  method: 'POST',
			                  success: function(data) {
			                    $('#myModal').modal('show');
			             }});
			}
        })
       
    </script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/welcome.js" ></script>
        <title>JSP Page</title>
    </head>
    <body>
    	<table class="table">
			<tr id="header">
				<td id="h2_mail">
					<h2 id="h2_mail">MailProject</h2></td>
				<td id="p_huanying">
					<p class="lead">${sessionScope.user.name}欢迎！</p>
				</td>
			</tr>
			<tr>
				<td id="left">
					<table class="table table-hover">
						<tr class="tou">
							<td>
								<a href="#">DouBiMail <span class="ui-li-count"></span></td>
						</tr>
						<tr id="xiexin">
							<td>
								<a href="#">写信</a>
							</td>
						</tr>
						<tr id="shouxin">
							<td>
								<a href="#">收信箱<span class="badge">${sessionScope.user.senderMailList.size()}</span></a>
							</td>
						</tr>
						<tr id="faxin">
							<td>
								<a href="#">发信箱</a>
							</td>
						</tr>
					</table>

				</td>
				<td id="right">
					<div id="email-primary" style="background-image: url(${pageContext.request.contextPath}/statics/images/new.png) ;background-size:100% 100%;background-repeat:no-repeat;width: 100% ;height: 100%">
						
						<!--写信页面 默认隐藏-->
						<div id="Write_letters" style="margin:0px  0px 0px 203px ; padding:57px 0px 200px 0px ; background-color:#FFF; display: none;">
						      <form action="" method="post">
						      <div class="form-group has-warning has-feedback">
								  <label class="control-label" for="inputWarning2">收信人</label>
								  <input id="shouxinren" type="text" class="form-control" id="inputWarning2" aria-describedby="inputWarning2Status">
								  
								  <span id="inputWarning2Status" class="sr-only">(warning)</span>
								</div>
							<div id="jinggao" class="alert alert-danger" role="alert">Text</div>
						    <div id="zhuti" class="form-group has-success">
							  <label class="control-label" for="inputSuccess1">主题</label>
							  <input id="theme" type="text" class="form-control" id="inputSuccess1" aria-describedby="helpBlock2">
							</div>
						    <span>内容：</span>
						    <div id="neirong">
						    	<textarea id="content"  style="height:200px; width: 97%"></textarea>
						    </div>
						    <button id="fasong" type="button" class="btn btn-primary">发送</button>
						    <input type="reset" value="重写" class="btn btn-info"/>
						  </form>
						  <!-- 模态框（Modal） -->
							<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							    <div class="modal-dialog">
							        <div class="modal-content">
							            <div class="modal-header">
							                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
							                <h4 class="modal-title" id="myModalLabel">邮件发送成功！</h4>
							            </div>
							            <div class="modal-body">邮件已经发到对方邮箱啦！</div>
							            <div class="modal-footer">
							                <button id="close" type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
							            </div>
							        </div><!-- /.modal-content -->
							    </div><!-- /.modal-dialog -->
							</div>
						</div>
						<!--收信页面 默认隐藏-->
						<div id="The_receiver" style="display: none;">
						 	<table class="table table-hover">
							 	<tr>
							 		<td id="fuxuan">
							 			<input type="checkbox" value="">
							 		</td>
							 		<td id="tubiao">
							 			<img src="${pageContext.request.contextPath}/statics/images/mailweidu.png"/>
							 		</td>
							 		<td id="faxinren">
							 			发信人
							 		</td>
							 		<td id="shouxinren">
							 			主题		
							 		</td>
							 		<td id="time">
							 			时间↓
							 		</td>
							 		<td id="caozuo">
							 			操作	
							 		</td>
							 	</tr>
							 	<!-- 收信箱 -->
							 	<c:forEach items="${sessionScope.user.senderMailList}" var="a" varStatus="b">
							 		<tr class="tr" style="cursor:pointer;"  >
								 		<td id="fuxuan">
								 			<input type="checkbox" value="">
								 		</td>
								 		<td id="tubiao" onclick="changeArea(this)">
								 			<c:if test="${a.falg==0}">
								 				<img src="${pageContext.request.contextPath}/statics/images/mailweidu.png"/>
								 			</c:if>
								 			<c:if test="${a.falg==1}">
								 				<img src="${pageContext.request.contextPath}/statics/images/mailyidu.png"/>
								 			</c:if>
								 		</td>
								 		<td id="faxinren" onclick="changeArea(this)">
								 			<span>${a.addressee }</span>
								 		</td>
								 		<td id="shouxinren" onclick="changeArea(this)">
								 			<span>${a.theme }</span>
								 		</td>
								 		<td id="time" onclick="changeArea(this)">
								 			<span>${a.time }</span>
								 		</td>
								 		<td>
								 			<c:if test="${a.falg==0}">
								 				<button id="yidubtn" type="button" class="btn btn-warning" onclick="yiduan(this)">
												  <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> 设为已读
												</button>
								 			</c:if>
								 			
											<button type="button" class="btn btn-danger" onclick="deleteAddresseeMail(this)">
												<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
											</button>
								 		</td>
								 		
								 		<td style="visibility:hidden;" class="mailid"> 
								 			<span>${a.id}</span>
								 		</td>
								 	</tr>
							 	</c:forEach>
							</table>
						</div>
						 <!--发信页面 默认隐藏-->
						<div id="Letter" style="display: none;">
						 	<table class="table table-hover">
							 	<tr>
							 		<td id="fuxuan">
							 			<input type="checkbox" value="">
							 		</td>
							 		<td id="tubiao">
							 			<img src="${pageContext.request.contextPath}/statics/images/mailweidu.png"/>
							 		</td>
							 		<td id="faxinren">
							 			收信人
							 		</td>
							 		<td id="shouxinren">
							 			主题		
							 		</td>
							 		<td id="time">
							 			时间↓
							 		</td>
							 		<td id="caocuo">
							 			操作
							 		</td>
							 	</tr>
							 	<c:forEach items="${sessionScope.user.addresseeMailList}" var="a">
							 		<tr  style="cursor:pointer;"  class="tr"   >
								 		<td id="fuxuan">
								 			<input type="checkbox" value="">
								 		</td>
								 		<td id="tubiao" onclick="change(this)">
								 				<img src="${pageContext.request.contextPath}/statics/images/mailweidu.png"/>
								 		</td>
								 		<td id="faxinren" onclick="change(this)">
								 			${a.addressee }
								 		</td>
								 		<td id="shouxinren" onclick="change(this)">
								 			${a.theme }
								 		</td>
								 		<td id="time" onclick="change(this)">
								 			${a.time }
								 		</td>
								 		<td id="caozuo">
								 			<button type="button" class="btn btn-danger">
												<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
											</button>
								 		</td>
								 		<td style="visibility:hidden;" class="mailid"> 
								 			<span>${a.id}</span>
								 		</td>
								 	</tr>
							 	</c:forEach>
							</table>
						</div>
						<!--查看邮箱具体内容 默认隐藏-->
						<div id="Check_mailbox" style="margin:0px  0px 0px 203px ; padding:57px 0px 200px 0px ; background-color:#FFF; display: none;">
						      <div class="form-group has-warning has-feedback">
								  <label class="control-label" for="inputWarning2">发信人</label>
								  <input id="Check_shouxinren" readonly="readonly" type="text" class="form-control" id="inputWarning2" aria-describedby="inputWarning2Status">
								  <span id="inputWarning2Status" class="sr-only">(warning)</span>
								</div>
						    <div id="Check_zhuti" class="form-group has-success">
							  <label class="control-label" for="inputSuccess1">主题</label>
							  <input id="Check_theme" readonly="readonly" type="text" class="form-control" id="inputSuccess1" aria-describedby="helpBlock2">
							</div>
						    <span>内容：</span>
						    <div id="Check_neirong">
						    	<textarea id="Check_content" readonly="readonly" style="height:200px; width: 97%"></textarea>
						    </div>
						    <button type="button" class="btn btn-danger">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
							</button>
						  
						  <!-- 模态框（Modal） -->
							<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							    <div class="modal-dialog">
							        <div class="modal-content">
							            <div class="modal-header">
							                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
							                <h4 class="modal-title" id="myModalLabel">邮件删除成功</h4>
							            </div>
							            <div class="modal-body">邮件删除成功</div>
							            <div class="modal-footer">
							                <button id="close" type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
							            </div>
							        </div><!-- /.modal-content -->
							    </div><!-- /.modal-dialog -->
							</div>
							<!-- 模态框（Modal） -->
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2" id="foot">
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
				</td>
			</tr>
		</table>
 	</body>
</html>
