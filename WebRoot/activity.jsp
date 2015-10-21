<%@ page language="java" import="java.util.*" import="com.myhomework.*" pageEncoding="utf-8" %>
<%
request.setCharacterEncoding("utf-8");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String method = request.getMethod();
String loginStatus = "0";
User user = User.getUserBySessionId(session.getId());
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Activity</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="description" content="Activity page">

		<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrp/3.3.4/css/bootstrap.min.css?v=1.0">
		<script type="text/javascript">
		 	/*if ("<%=user%>"=="null") {
		  		document.location = "./login.jsp";
		  	} else {
		  		var loginStatus = <%=loginStatus%>;
		 		if (loginStatus == "1") {
		 			document.location = "./home.jsp";	
		 		}
		  	}
		  	*/
		  	/*function relocation(action) {
		  	    if (action.id == "createAct") {
		  	        document.location = "./create.jsp";
		  	    } else if (action.id == "joinAct") {
				    document.location = "./join.jsp";
		  	    } else if (action.id == "cancelAct") {
				    document.location = "./cancel.jsp";
		  	    } else if (action.id == "quitAct") {
				    document.location = "./quit.jsp";
		  	    }
		  	}*/
		</script>
	</head>
	
	<body onLoad="onload()" class="bg">
    <div class="container" align="center" style="margin-top:60px">
	  <h2 class="form-signin-heading text-center"> 你还在等什么？赶快行动吧！ </h2>
	  
	  <form class="form-signin" action="create.jsp">
	  <button class="btn btn-lg btn-primary btn-block" type="submit" id="create">
	    创建活动
	  </button>
	  </form>
	  
	  <br>
	  
	  <form class="form-signin" action="join.jsp">
	  <button class="btn btn-lg btn-primary btn-block" type="submit" id="join">
	    参加活动
	  </button>
	  </form>
	  
	  <br>
	  
	  <form class="form-signin" action="cancel.jsp">
	  <button class="btn btn-lg btn-primary btn-block" type="submit" id="cancel">
	    取消活动
	  </button>
	  </form>
	  
	  <br>
	  
	  <form class="form-signin" action="quit.jsp">
	  <button class="btn btn-lg btn-primary btn-block" type="submit" id="quit">
	    退出活动
	  </button>
	  </form>
    </div>
  </body>
</html>
