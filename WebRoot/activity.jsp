<%@ page language="java" import "java.util.*" import="com.myhomework.*" pageEncoding="utf-8"%>
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
		 	if ("<%=user%>"=="null") {
		  		document.location = "./login.jsp";
		  	} else {
		  		var loginStatus = <%=loginStatus%>;
		 		if (loginStatus == "1") {
		 			document.location = "./home.jsp";	
		 		}
		  	}
		  	
		  	function relocation(action) {
		  	    if (action.id == "createAct") {
		  	        document.location = "./create.jsp";
		  	    } else if (action.id == "joinAct") {
		  	    } else if (action.id == "cancelAct") {
		  	    } else if (action.id == "quitAct") {
		  	    }
		  	}
		</script>
	</head>
	
	  <body>
    <div align="center">
      <input type="button" id="createAct" value="创建活动" onclick="relocation(this)" />
	  &nbsp;
	  <input type="button" id="joinAct" value="参与活动" onclick="relocation(this)" />
	  &nbsp;
	  <input type="button" id="cancelAct" value="取消活动" onclick="relocation(this)" />
	  &nbsp;
	  <input type="button" id="quitAct" value="退出活动" onclick="relocation(this)" />
    </div>
  </body>
</html>
