<%@ page language="java" import="java.util.*" import="com.myhomework.*" pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String method = request.getMethod();
int modifyStatus = 0;   // 0: before 1: quit success 2: already quit/never join -1: quit failed
User user = User.getUserBySessionId(session.getId());

String msg = "";

if (method.equalsIgnoreCase("post")) {
	String uid = user.uid;//request.getParameter("uid");
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
				response.sendRedirect("activity.jsp");
			} else {
				modifyStatus = -1;
				msg = "操作失败，请重新操作！";
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
		
		function check()
		{
		  var option = document.getElementByNmae("aid");
		  var ck = false;
		  for(var i = 0; i < option.length; i++)
		  {
		    if(option[i].checked)
			{
			  ck = true;
			  break;
			}
		  }
		  
		  if(ck)
		    return true;
		  else
		  {
		    alert("请选择您要退出的活动！");
		    return false;
		  }
		}
	</script>
  </head>
  
  <body onLoad="onload()" class="bg">
    <div class="container">
	  <h2 class="form-signin-heading text-center"> 
        想清楚了吗？难道你就不会感到留恋？
	  </h2>
	  
	  <form  class="form-signin" action="quit.jsp?uid=<%=user.uid%>" method="post" onSubmit="return check()">
	    <table align="center" style="margin-top:50px" border="1" cellpadding="1" cellspacing="1">
	      <tr align="center">
		    <td>活动名称</td> <td>活动信息</td> <td>开始时间</td> <td>选择退出</td>
		  </tr>
		
	      <% 
		    ArrayList<Activity> list = Activity.getActivityOfUser(user);
            for(Activity ac:list)
			{
	      %>
		
		  <tr align="center">
		      <td><%=ac.activity_name%></td>
			  <td><%=ac.describe_info%></td>
		      <td><%=ac.start_time%></td>
			  <td><input type="radio" id="aid" name="aid" value="<%=ac.aid%>" /></td>
	      </tr>
		  <%
		     }
	      %>
		</table>
	  
	    <button class="btn btn-lg btn-primary btn-block" type="submit"
					 name="finish" id="finish" style="margin-top:30px">
	      提交
	    </button>
	  </form>
	  
	  <font class="text-center" style="color:red"><%=msg%></font>
	</div>
  </body>