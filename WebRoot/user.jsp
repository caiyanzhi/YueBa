<%@ page language="java" import="java.util.*" import="com.myhomework.*" pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String method = request.getMethod();
String loginStatus = "0";
String loginMsg = null;
User user = User.getUserBySessionId(session.getId());
String status = "0";
//0表示访客状态，1表示查看自己
String account = request.getParameter("account");
User visituser = User.getUserByAccout(session.getId(),account);
if(user != null && visituser != null && visituser.uid.equals(user.uid)){
	status = "1";
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
	<link rel="stylesheet" type="text/css" href="style/user.css">	
	<link rel="stylesheet" type="text/css" href="style/styles.css?1.0">
	
	<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css?v=1.0">
	<script type="text/javascript">
	
		if("<%=user%>" == "null"){
			document.location = "./login.jsp";
		}
		else{
			var loginStatus = <%=loginStatus%>;
			if(loginStatus == "1"){
				document.location = "./home.jsp";
			}
		}
	</script>
  </head>
  
  <body onload="onload()" class="bg">
      	<div class="container">
			<div class="navbar-fixed-top" style="height:40px;">
        	<font style="color:#999"><% if(user != null){%><%=user.username %>，<%} %>欢迎来到约吧</font>
        	<font style="color:#999;float:right;margin-right:20px;<% if("0".equals(status) || user == null){%>display:none<%} %>" ><p onclick=editUser("1")>编辑资料</p></font>
        	<font style="color:#999;float:right;margin-right:20px;<% if("0".equals(status) || user == null){%>display:none<%} %>"><p onclick=editUser("2")>修改密码</p></font> 	
 			<font style="color:#999;float:right;margin-right:20px"><p onclick=backHome()>首页</p></font>
        	</div>
 			<div>
        		<h1 class="text-center" sytle="color:blue"><% if(visituser != null){%><%=visituser.username %><%} %></h1>
        	</div>
        	<br>
        	<div>
        		<h5 class="text-center" style="color:#999">简介</h5>
        	</div>
        	<br>
        	<div>
        		<h3 class="text-center" style="color:blue"> <% if(visituser != null && visituser.describe != null){%><%=visituser.describe %><%} %></h3>
        	</div>
            <div class="text-center navbar-fixed-bottom" style="height:40px; padding-top:10px">
        	<font class="text-center" style="color:#999">team12348005 小组作业</font>
        	</div>
		</div>
  </body>
  <script src="script/user.js?1.01">
  </script>
</html>
