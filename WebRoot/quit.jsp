<%@ page language="java" import="java.util.*" import="com.myhomework.*" pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String method = request.getMethod();
int modifyStatus = 0;   // 0: before 1: quit success 2: already quit/never join -1: quit failed
User user = User.getUserBySessionId(session.getId());

if (method.equalsIgnoreCase("post")) {
	String uid = request.getParameter("uid");
	String aid = request.getParameter("aid");
	
	if (user != null && uid != null && aid != null) {
		Activity activity = new Activity();
		activity.setAid(aid);
		ArrayList<User> join_list = Activity.getJoinerOfActivity(activity);
		boolean found = false;
		for (User u : join_list) {
			if (u.uid == uid) {
				found = true;
			}
		}
		if (found) {
			if (Activity.quitActivity(User.getUserByUid(session.getId(), uid), activity)) {
				modifyStatus = 1;
			} else {
				modifyStatus = -1;
			}
		} else {
			modifyStatus = 2;
		}
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