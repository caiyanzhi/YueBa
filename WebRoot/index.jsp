<%@ page language="java" import="java.util.*" import="com.myhomework.*" pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String method = request.getMethod();
String loginStatus = "0";
String loginMsg = null;
User user = User.getUserBySessionId(session.getId());
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
        	<font style="color:#999"><% if(user != null){%><%=user == null ? "":user.username %>，<%} %>欢迎来到约吧</font>
            <div class="text-center navbar-fixed-bottom" style="height:40px; padding-top:10px">
        	<font class="text-center" style="color:#999">team12348005 小组作业</font>
        	</div>
		</div>
    
  </body>
  <script src="script/home.js?1.0">
        </script>
</html>
