<%@ page language="java" import="java.util.*" import="com.myhomework.*" pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String method = request.getMethod();
String loginStatus = "0";
String loginMsg = null;
User user = User.getUserBySessionId(session.getId());
String aid = request.getParameter("aid");
Activity activity = Activity.getActivityByAid(aid);
String activity_status = "1";
boolean isJoin = false;
int cnt = 0;
ArrayList<User> userList = null;
if(user != null && activity != null){
	isJoin = Activity.isJoinActivity(user.uid,activity.aid);
	userList = Activity.getJoinerOfActivity(activity);
	cnt = userList == null ? 0:userList.size();
}
if(method.equalsIgnoreCase("post")){
	String join = request.getParameter("joinactivity");
	String quit = request.getParameter("quitactivity");
	if(join != null && !isJoin){
		//参加
		if(user != null && activity != null){
			boolean ret = Activity.joinActivity(user,activity);
			if(ret) isJoin = true;
		}
	}
	else if(quit != null && isJoin){
		//退出
		if(user != null && activity != null){
			boolean ret = Activity.quitActivity(user,activity);
			if(ret) isJoin = false;
		}
	}
}

if(user != null && activity != null){
	userList = Activity.getJoinerOfActivity(activity);
	cnt = userList == null ? 0:userList.size();
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
        	<font style="color:#999"><% if(user != null){%><%=user == null ? "":user.username %>，<%} %>欢迎来到约吧查看活动</font>
        	<font style="color:#999;float:right;margin-right:20px"><p onclick=backHome()>首页</p></font>
            <%if(activity != null){ %>
            <div>
        		<h1 class="text-center" sytle="color:blue"><% if(activity != null && activity.activity_name != null){%><%=activity.activity_name %><%} %></h1>
        	</div>
        	<br>
        	<div>
        		<h5 class="text-center" style="color:#999">活动开始时间:<% if(activity != null && activity.start_time != null){%><%=activity.start_time%><%} %> <h5 class="text-center" style="color:#999">参加截止时间:<% if(activity != null && activity.vote_stop_time != null){%><%=activity.vote_stop_time %><%} %> </h5>
        	</h5>
        	</div>
        	<br>
        	<div>
        		<h3 class="text-center" style="color:blue"> <% if(activity != null && activity.describe_info != null){%><%=activity.describe_info %><%} %></h3>
        	</div>
        	
            <form class="form-signin" action="./activity.jsp?aid=<%=activity.aid%>" method="post">
            <% if(!isJoin){ %>
				<button class="btn btn-lg btn-primary btn-block" type="submit" style="margin-top:20px"
					 name="joinactivity" id="joinactivity">
					参加这个活动
				</button>
			<%}else{ %>
				<button class="btn btn-lg btn-primary btn-block" type="submit" style="margin-top:20px"
					 name="quitactivity" id="quitactivity">
					退出这个活动
				</button>
			<%}%>
			<div>
        		<h5 class="text-center" style="color:#999"> 已参加人数：<%=String.valueOf(cnt)%></h5>
        	</h5>
        	 <%if(cnt!=0){ %>参加人员：<%} %>
        	<%
        	if(cnt != 0){ 
        		for(int i = 0; i < cnt; i++){%>
        			<a href="user.jsp?account=<%=userList.get(i).account %>"><%= userList.get(i).username%></a>
        	<%  }
        	 } 
        	%>
			<%}else {%>
			</form>
			<div>
        		<h3 class="text-center" style="color:blue"> 找不到活动，请返回首页</h3>
        	</div>
			<%} %>
            <div class="text-center navbar-fixed-bottom" style="height:40px; padding-top:10px">
        	<font class="text-center" style="color:#999">team12348005 小组作业</font>
        	</div>
		</div>
  </body>
  <script src="script/home.js?1.0">
        </script>
        
  <script src="script/user.js?1.01">
        </script>
</html>
