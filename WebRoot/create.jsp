<%@ page language="java" import="java.util.*" import="java.text.*" import="com.myhomework.*" pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date currentTime = new Date();
String time = formatter.format(currentTime).toString();

String method = request.getMethod();
int modifyStatus = 0;   // 0: before 1: success -1: failed
User user = User.getUserBySessionId(session.getId());

String msg = "";

if (method.equalsIgnoreCase("post") && user != null) {
	String uid = user.uid;
	String create_time = time;
	String start_time = request.getParameter("start_time");
	String vote_stop_time = request.getParameter("vote_stop_time");
	String activity_name = request.getParameter("activity_name");
	String describe_info = request.getParameter("describe_info");
	System.out.println(create_time);
	if (uid != null && !"".equals(start_time) && 
		!"".equals(vote_stop_time) && !"".equals(activity_name)&&
		!"".equals(describe_info)) {
		Activity activity = new Activity(user.uid, activity_name, "1", 
			start_time, create_time, vote_stop_time, describe_info);
		if (Activity.insertActivity(activity)) {
			modifyStatus = 1;
			response.sendRedirect("activity.jsp");
		} else {
			modifyStatus = -1;
			msg = "创建失败，请重新尝试！";
		}
	} else {
		modifyStatus = -1;
		msg = "创建失败，请重新尝试！";
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
	
	<link rel="stylesheet" type="text/css" href="style/styles.css?1.0">
	<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css?v=1.0">
	<script type="text/javascript">
		if("<%=user%>" == "null"){
			document.location = "./login.jsp";
		}
		
		function check()
		{
		  var name = document.getElementById("activity_name").value;
		  var info = document.getElementById("describe_info").value;
		  var start = document.getElementById("start_time").value;
		  var end = document.getElementById("vote_stop_time").value;
		  
		  if(name == "" || info == "" || start == "" || end == "")
		  {
		    alert("请将信息填写完整！");
		    return false;
		  }
		  
		  return true;
		}
	</script>
  </head>
  
  <body onLoad="onload()" class="bg">
    <form class="form-signin" action="create.jsp" method="post" onSubmit="return check()">
	  <h2 class="form-signin-heading text-center"> 
        创建约吧活动，让大家和你一起享受约起来！
	  </h2>
	  
	  <label for="inputEmail" class="sr-only">
	    名称
	  </label>
	  <input type="text" id="activity_name" class="form-control" style="margin-top:10px"
					name="activity_name" placeholder="活动名称">
	  
	  <label for="inputEmail" class="sr-only">
	    活动信息
	  </label>
	  <textarea type="text" id="describe_info" class="form-control" style="margin-top:10px"
					name="describe_info" placeholder="活动介绍"></textarea>
	  
	  <label for="inputEmail" class="sr-only">
	    开始时间
	  </label>
	  <input type="text" id="start_time" class="form-control" style="margin-top:10px"
					name="start_time" placeholder="开始时间">
					
	  <label for="inputEmail" class="sr-only">
	    报名结束时间
	  </label>
	  <input type="text" id="vote_stop_time" class="form-control" style="margin-top:10px"
					name="vote_stop_time" placeholder="报名结束时间">			
	  <button class="btn btn-lg btn-primary btn-block" type="submit" style="margin-top:10px"
					 name="finish" id="finish">
	    完成
	  </button>
	</form>
	
	<font class="text-center" style="color:red"><%=msg%></font>
  </body>