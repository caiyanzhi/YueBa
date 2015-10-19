<%@ page language="java" import="java.util.*" import="com.myhomework.*" pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String method = request.getMethod();
int modifyStatus = 0;   // 0: before 1: success -1: failed
User user = User.getUserBySessionId(session.getId());

if (method.equalsIgnoreCase("post")) {
	String uid = request.getParameter("uid");
	String create_time = request.getParameter("create_time");
	String start_time = request.getParameter("start_time");
	String vote_stop_time = request.getParameter("vote_stop_time");
	String activity_name = request.getParameter("activity_name");
	String describe_info = request.getParameter("describe_info");
	
	if (user != null && uid != null && user.uid == uid && create_time != null &&
		start_time != null && vote_stop_time != null && activity_name != null && 
		describe_info != null) {
		Activity activity = new Activity(user.uid, activity_name, "1", 
			start_time, create_time, vote_stop_time, describe_info);
		if (Activity.insertActivity(activity)) {
			modifyStatus = 1;
		} else {
			modifyStatus = -1;
		}
	} else {
		modifyStatus = -1;
	}
}
%>

<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Create Activity</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="Create Activity">
	
	<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css?v=1.0">
	<script type="text/javascript">
		if("<%=user%>" == "null"){
			document.location = "./login.jsp";
		}
	</script>
  </head>
  
  <body onload="onload()" class="bg">
  </body>