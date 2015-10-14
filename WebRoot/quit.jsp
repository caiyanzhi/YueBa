<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%
  String msg = "";
  if(request.getMethod().equalsIgnoreCase("post") ) {
    /*
	数据库删除操作... 所有复选框name都是quit 用数组获取后判断第几个复选框选中然后在joinActivity中删除相应的参与者
	if(操作成功)
	  response.sendRedirect("home.jsp");//返回主页
	else
	  msg = "操作失败！请重新操作";
	*/  
  }
  
  /*
    连接数据库取出所有活动信息...
	Class.forName("org.gjt.mm.mysql.Driver");
	String url="jdbc:mysql://localhost:3306/....";
	String username = "...";
	String password = "...";
	conn=DriverManager.getConnection(url,username,password);
	
	Statement stmt=con.createStatement();
	String sql=String.format("select * from Activity limit %d,%d",
	                           pgno*pgcnt, pgcnt"); //分页取出所有活动的名称
	ResultSet rs=stmt.executeQuery(sql);
  */
  
  /*----------------分页显示---------------------*/
    Integer pgno = 0;   		//当前页号
	Integer pgcnt = 5; 	  	    //每页行数
	
	String param = request.getParameter("pgno");
	if(param != null && !param.isEmpty() ){ 
	   pgno = Integer.parseInt(param);
	}
	
	param = request.getParameter("pgcnt");
	if(param != null&&!param.isEmpty() ){
	   pgcnt = Integer.parseInt(param);
	}
	
	int pgprev = (pgno > 0) ? pgno-1 : 0;
	int pgnext =  pgno + 1;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>退出活动</title>
	
	<script language="javascript">
	  function check()
	  {
	    var flag = false;
	    var option = document.getElementById("quit");
		for(var i = 0; i < option.length; i++)
		{
		  if(option[i].checked)
		  {
		    flag = true;
			break;
		  }
		}
		
		if(flag)
		  return true;
		else
		{
		  alert("请最少选择一项！");
		  return false;
		}
	  }
	</script>
  </head>

  <body>
    <form method="post" action="cancel.jsp" onsubmit="return check()">
	  <table border=1>
        <tr align="center">
          <td>活动名称</td>
          <td>活动日期</td>
          <td>活动时间</td>
          <td>活动地点</td>
		  <td>退出活动</td>
        </tr>
		
		<%
          //while循环输出记录
          while(rs.next() ) {
        %>
	    
	    <tr align="center">
          <td><%=rs.getString("name") %></td>
          <td><%=rs.getString("date")%></td>
          <td><%=rs.getString("time")%></td>
          <td><%=rs.getString("location")%></td>
		  <td><input type="checkbox" id="quit" name="quit" /></td>
        </tr>

        <%
          }
        %>
		
	    <tr align="right">
		  <td colspan="5">
	      <a href="quit.jsp?pgno=<%=pgprev%>&pgcnt=<%=pgcnt%>">
	                      上一页</a>            
	      <a href="quit.jsp?pgno=<%=pgnext%>&pgcnt=<%=pgcnt%>">
	                     下一页</a>
		  </td>
	    </tr>
	  </table>
	  
	  <br><br>
	  
	  <input type="submit" value="退出活动" />
	</form>
	
	<font color="#FF0000"><%=msg%></font>
  </body>
</html>
