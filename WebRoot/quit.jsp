<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%
  String msg = "";
  if(request.getMethod().equalsIgnoreCase("post") ) {
    /*
	���ݿ�ɾ������... ���и�ѡ��name����quit �������ȡ���жϵڼ�����ѡ��ѡ��Ȼ����joinActivity��ɾ����Ӧ�Ĳ�����
	if(�����ɹ�)
	  response.sendRedirect("home.jsp");//������ҳ
	else
	  msg = "����ʧ�ܣ������²���";
	*/  
  }
  
  /*
    �������ݿ�ȡ�����л��Ϣ...
	Class.forName("org.gjt.mm.mysql.Driver");
	String url="jdbc:mysql://localhost:3306/....";
	String username = "...";
	String password = "...";
	conn=DriverManager.getConnection(url,username,password);
	
	Statement stmt=con.createStatement();
	String sql=String.format("select * from Activity limit %d,%d",
	                           pgno*pgcnt, pgcnt"); //��ҳȡ�����л������
	ResultSet rs=stmt.executeQuery(sql);
  */
  
  /*----------------��ҳ��ʾ---------------------*/
    Integer pgno = 0;   		//��ǰҳ��
	Integer pgcnt = 5; 	  	    //ÿҳ����
	
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
    <title>�˳��</title>
	
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
		  alert("������ѡ��һ�");
		  return false;
		}
	  }
	</script>
  </head>

  <body>
    <form method="post" action="cancel.jsp" onsubmit="return check()">
	  <table border=1>
        <tr align="center">
          <td>�����</td>
          <td>�����</td>
          <td>�ʱ��</td>
          <td>��ص�</td>
		  <td>�˳��</td>
        </tr>
		
		<%
          //whileѭ�������¼
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
	                      ��һҳ</a>            
	      <a href="quit.jsp?pgno=<%=pgnext%>&pgcnt=<%=pgcnt%>">
	                     ��һҳ</a>
		  </td>
	    </tr>
	  </table>
	  
	  <br><br>
	  
	  <input type="submit" value="�˳��" />
	</form>
	
	<font color="#FF0000"><%=msg%></font>
  </body>
</html>
