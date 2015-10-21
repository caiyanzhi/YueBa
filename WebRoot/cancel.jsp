<%@ page language="java" import="java.util.*" import="com.myhomework.*" pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String method = request.getMethod();
int modifyStatus = 0;   // 0: before 1: delete success -1: delete failed
User user = User.getUserBySessionId(session.getId());
String msg = "";

if (method.equalsIgnoreCase("post")) {
	String aid = request.getParameter("aid");
	if (aid != null) {
		Activity activity = new Activity();
		activity.setAid(aid);
		if (Activity.delectActivity(activity)) {
			modifyStatus = 1;
			response.sendRedirect("activity.jsp");
		} else {
			modifyStatus = -1;
			msg = "操作失败，请重新操作！";
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
String sql = "select * from Activity where uid = " + user.uid + " limit " + pgno*pgcnt + "," + pgcnt;
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
		    alert("请选择您要取消的活动！");
		    return false;
		  }
		}
	</script>
  </head>
  
  <body onLoad="onload()" class="bg">
    <div class="container">
	  <h2 class="form-signin-heading text-center"> 
        你就不能手下留情？
	  </h2>
	  
	  <form  class="form-signin" action="cancel.jsp?uid=<%user.uid%>" method="post" onSubmit="return check()">
	    <table align="center" style="margin-top:50px" border="1" cellpadding="1" cellspacing="1">
	      <tr align="center">
		    <td>活动名称</td> <td>活动信息</td> <td>开始时间</td> <td>选择取消</td>
		  </tr>
		
	      <% while(rs.next() )
	       {
	      %>
		
		  <tr align="center">
		      <td><%=rs.getString(2)%></td> <!--第2个字段是活动名称-->
		      <td><%=rs.getString(7)%></td> <!--第7个字段是活动信息-->
			  <td><%=rs.getString(4)%></td>
			  <td><input type="radio" id="aid" name="aid" value="<%=rs.getInt(3)%>" /></td>
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