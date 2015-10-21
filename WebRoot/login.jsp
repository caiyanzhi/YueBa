<%@ page language="java" import="java.util.*" import="com.myhomework.*" pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String method = request.getMethod();
String loginStatus = "0";
String loginMsg = null;
if(method.equalsIgnoreCase("post")){
	String account = request.getParameter("account");
	String pwd = request.getParameter("password");
	User user = User.login(session.getId(),account,pwd);
	if(user != null){
		loginStatus = "1";
	}
	else{
		loginStatus = "-1";
		loginMsg = "账号密码错误";
	}
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>约吧</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="style/login.css">
	<link rel="stylesheet" type="text/css" href="style/styles.css?1.0">
	<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css?v=1.0">
	<script type="text/javascript">
		var loginStatus = <%=loginStatus%>;
		if(loginStatus == "1"){
			document.location = "./home.jsp";
		}
	</script>
  </head>
  
  <body onLoad="onload()" class="bg">
    		<div class="container">
    		<div class="navbar-fixed-top" style="height:40px;">
        	<font style="color:#999">欢迎来到约吧</font>
          
			<form class="form-signin" action="./login.jsp" method="post" onSubmit="return loginOnSubmit()">
				<h2 class="form-signin-heading text-center">
					登录到约吧，一起参加活动！
				</h2>
				<label for="inputEmail" class="sr-only">
					账号
				</label>
				<input type="text" id="account" class="form-control"
					name="account" placeholder="请输入账号">
				<label for="inputPassword" class="sr-only">
					密码
				</label>
				<input type="password" id="password" class="form-control"
					name="password" placeholder="请输入密码">
					
				<%
					if (loginMsg == null) {
				%>
						
				<%
					}
					else {
				 %>
				 		<p id="login_msg_toast" style="color:red;margin:3px auto;"><%=loginMsg %></p>
				 <% } 
				 %>
				<button class="btn btn-lg btn-primary btn-block" type="submit"
					 name="loginButton" id="loginButton">
					登录
				</button>
			</form>
			<form class="form-signin" action="register.jsp">
				<button class="btn btn-lg btn-block btn btn-danger" type="submit"
					id="register_btn">
					注册
				</button>
			</form>
            <div class="text-center navbar-fixed-bottom" style="height:40px;padding-top:10px">
        	<font class="text-center" style="color:#999">team12348005 小组作业</font>
        </div>
		</div>
    
  </body>
  <script src="script/login.js?v=1.1211">
        </script>
</html>
