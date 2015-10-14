<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%
  //request.setCharacterEncoding("utf-8");
  //User user = User.getUserBySessionId(session.getId());
  String msg = "";
  
  if(request.getMethod().equalsIgnoreCase("post") ){
    String name = request.getParameter("name");
    String date = request.getParameter("date");
    String time = request.getParameter("time");
    String location = request.getParameter("location");
	
	/*
	  数据库操作...
	  if(操作成功)
	    response.sendRedirect("home.jsp");
	  else
	    msg="操作失败！";
	*/
  }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>创建活动</title>
	
	<script language="javascript">
	  function check()
	  {
	    var name = document.getElementById("name").value;
		var date = document.getElementById("date").value;
		var time = document.getElementById("time").value;
		var location = document.getElementById("location").value;
	    
		if(name == "" || date == "" || time == "" || location == "")
		{
		  alert("请将信息填写完整！");
		  return false;
		}
		
		return true;
	  }
	</script>
  </head>

  <body>
    <form action="create.jsp" method="post" onsubmit="return check()">
	  活动名称：<input type="text" id="name" />
	  <br>
	  活动日期：<input type="text" id="date" />（格式：2015/10/07）
	  <br>
	  活动时间：<input type="text" id="time" />（格式：16:00-18:00）
	  <br>
	  活动地点：<input type="text" id="location" />
	  <br><br>
	  <input type="submit" value="创建活动" />
	</form>
	
	<font color="#FF0000"><%=msg%></font>
  </body>
</html>
