<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%
  //request.setCharacterEncoding("utf-8");
  //User user = User.getUserBySessionId(session.getId());
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>Activity</title>
	
	<script language="javascript">
	  function relocation(obj)
	  {
	    if(obj.id == "createAct")
		  window.location.href="create.jsp";
		else if(obj.id == "joinAct")
		  window.location.href="join.jsp";
		else if(obj.id == "cancelAct")
		  window.location.href="cancel.jsp";
		else
		  window.location.href="quit.jsp";
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
