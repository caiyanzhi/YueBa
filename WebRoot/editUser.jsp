<%@ page language="java" import="java.util.*" import="com.myhomework.*" pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String method = request.getMethod();
String modifyStatus = "0";//0：修改前，1：修改成功，-1：修改失败
String modifyType = request.getParameter("type");//1：编辑资料，2：修改密码
User user = User.getUserBySessionId(session.getId());

if(method.equalsIgnoreCase("post")){
	if(modifyType.equals("2")){
		String oldpwd = request.getParameter("oldpassword");
		String newpwd = request.getParameter("password");
		if(user != null && oldpwd != null && newpwd != null){
			if(user.modifyPwd(oldpwd,newpwd)) modifyStatus = "1";
			else
			modifyStatus = "-1";
		}
		else{
		 	modifyStatus = "-1";
		}
	}
	else if(modifyType.equals("1")){
		
		String describe = request.getParameter("describe");
		String username = request.getParameter("username");
		if(user != null && describe != null && username != null){
			if(user.modifyInfo(username,describe)) modifyStatus = "1";
			else
			modifyStatus = "-1";
		}
		else{
		 	modifyStatus = "-1";
		}
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
		if("<%=user%>" == "null"){
			document.location = "./login.jsp";
		}
	</script>
  </head>
  
  <body onload="onload()" class="bg" >
    	<div class="container">
			<div class="navbar-fixed-top" style="height:40px;">
        	<font style="color:#999"><% if(user != null){%><%=user.username %>，<%} %>欢迎来到约吧</font>
			<form class="form-signin" style="<%if(!"0".equals(modifyStatus)||(!"0".equals(modifyType) && "1".equals(modifyType))){ %> display:none<%} %>" 
				action="./editUser.jsp?type=<%=modifyType %>" method="post" onsubmit="return checkTwoPassword()">
				<h2 class="form-signin-heading text-center">
					修改密码
				</h2>
				<input type="text" id="oldpassword" class="form-control"
					name="oldpassword" placeholder="请输入旧密码">
				<input type="password" id="password" class="form-control"
					name="password" placeholder="请新密码">
				<input type="password" id="password2" class="form-control"
					name="password2" placeholder="请再一次输入新密码">
				
				<button class="btn btn-lg btn-primary btn-block" type="submit"
					 name="modifyPwd" id="modifyPwd">
					修改
				</button>
			</form>
			<form class="form-signin" style="<%if(!"0".equals(modifyStatus)||(!"0".equals(modifyType) && "2".equals(modifyType))){ %> display:none<%} %>" 
				action="./editUser.jsp?type=<%=modifyType %>" method="post" onsubmit="return checkNewInfo()">
				<h3 class="form-signin-heading text-center">
					修改用户名
				</h3>
				<input type="text" id="username" class="form-control"
					name="username" placeholder="请输入新用户名" value="<%=user == null ? "":user.username%>">
				<h3 class="form-signin-heading text-center">
					修改简介
				</h3>
				<textarea id="describe" name="describe" placeholder="请输入新简介" class="form-control"><%=user == null ? "":user.describe %></textarea>
				
				<button class="btn btn-lg btn-primary btn-block" type="submit" style="margin-top:20px"
					 name="modifyInfo" id="modifyInfo">
					修改
				</button>
			</form>
			<div class="text-center" ><% if( "1".equals(modifyStatus)){%><h3>修改成功</h3><% }%></div>
			<div class="text-center" ><% if( "-1".equals(modifyStatus)){%><a href="./editUser.jsp?type=<%=modifyStatus %>">修改失败，请重试</a><% }%></div>
			
			<div class="text-center" ><a href="./user.jsp?account=<%=user == null?"":user.account%>">返回</a></div>
            <div class="text-center navbar-fixed-bottom" style="height:40px; padding-top:10px">
        	<font class="text-center" style="color:#999">team12348005 小组作业</font>
        	</div>
		</div>
    
  </body>
  <script src="script/user.js?1.01">
        </script>
</html>
