<%@ page language="java" import="java.util.*" import="com.myhomework.*" import="java.sql.*" pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String method = request.getMethod();
int modifyStatus = 0;   // 0: before 1: join success 2: already join -1: join failed
User user = User.getUserBySessionId(session.getId());

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
		
		if (!found) {
			if (Activity.joinActivity(User.getUserByUid(session.getId(), uid), activity)) {
				modifyStatus = 1;
				response.sendRedirect("activity.jsp");
			} else {
				modifyStatus = -1;
			}
		} else {
			modifyStatus = 2;
		}
	}
}

/*------------------------分页设置----------------------*/
Integer pgno = 0;       //当前页号
Integer pgcnt = 5; 	  	//每页行数

String param = request.getParameter("pgno");
if(param != null && !param.isEmpty() ){ 
	 pgno = Integer.parseInt(param);
}
	
param = request.getParameter("pgcnt");
if(param != null && !param.isEmpty() ){
	 pgcnt = Integer.parseInt(param);
}

int pgprev = (pgno>0)?pgno-1:0;
int pgnext = pgno+1;

/*-----------------------------------------------------*/

String url = "";      //数据库连接路径
String userName = ""; //数据库用户
String passwrod = ""; //用户密码
String sql = "select * from Activity limit " + pgno*pgcnt + "," + pgcnt;
Statement stat;
ResultSet rs = null;

try {
  Class.forName("com.mysql.jdbc.Driver");
  Connection conn = DriverManager.getConnection(url, userName, passwrod);
        
  try {
    stat = conn.createStatement(); //获取执行sql语句的对象
    rs = stat.executeQuery(sql);   //执行sql查询，返回结果集
   } catch (Exception e) {
        System.out.println(e.getMessage() );
     }
 } catch (Exception e) {
     e.printStackTrace();
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
        心动不如行动，赶快来参加活动吧！
	  </h2>
	  
	  <form  class="form-signin" action="join.jsp?uid=<%user.uid%>" method="post" onSubmit="return check()">
	  <table align="center" style="margin-top:50px" border="1" cellpadding="1" cellspacing="1">
	    <tr align="center">
		  <td>活动名称</td> <td>活动信息</td> <td>活动开始时间</td> <td>报名截止时间</td> <td>选择参加</td>
		</tr>
		
	    <% while(rs.next() )
	       {
	    %>
		
		<tr align="center">
		      <td><%=rs.getString(2)%></td> <!--第2个字段是活动名称-->
		      <td><%=rs.getString(7)%></td> <!--第7个字段是活动信息-->
			  <td><%=rs.getString(4)%></td>
			  <td><%=rs.getString(6)%></td>
			  <td><input type="radio" id="aid" name="aid" value="<%=rs.getInt(3)%>" /></td>
	    </tr>
		<%
		   }
	    %>
		
		<tr align="right">
		  <td colspan="5">
		    <a href="join.jsp?pgno=<%=pgprev%>&pgcnt=<%=pgcnt%>">上一页</a>
			&nbsp;	            
	        <a href="join.jsp?pgno=<%=pgnext%>&pgcnt=<%=pgcnt%>">下一页</a>
		  </td>
		</tr>
	  </table>
	  
	  <button class="btn btn-lg btn-primary btn-block" type="submit"
					 name="finish" id="finish" style="margin-top:30px">
	    完成
	  </button>
	  </form>
	</div>
  </body>