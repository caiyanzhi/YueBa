<%@ page language="java" import="java.util.*" import="com.myhomework.*" pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String method = request.getMethod();
/*------------------------分页设置----------------------*/
Integer pgno = 0;       //当前页号
Integer pgcnt = 10; 	  	//每页行数

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
String loginStatus = "0";
String loginMsg = null;
User user = User.getUserBySessionId(session.getId());
if(request.getParameter("loginout") != null){
	user = null;
	User.loginout(session.getId());
}
ArrayList<Activity> allActivity = Activity.getAllActivity(pgno,pgcnt);
int cnt = allActivity.size();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>约吧</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="style/login.css">
	<link rel="stylesheet" type="text/css" href="style/styles.css?1.0">
	<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css?v=1.0">
	<script type="text/javascript">
	if("<%=user%>" == "null"){
			document.location = "./login.jsp";
			document.getElementByTags(body);
			body.innerHTML="退出登录..";
		}
	</script>
  </head>
  
  <body onLoad="onload()" class="bg">
    	<div class="container">
			<div class="navbar-fixed-top" style="height:40px;">
        	<font style="color:#999"><% if(user != null){%><%=user.username %>，<%} %>欢迎来到约吧</font>
        	 <font style="color:#999;float:right;margin-right:20px;<% if(user == null){%>display:none<%} %>" ><a href="./home.jsp?loginout=1">退出登录</a></font>
            <font style="color:#999;float:right;margin-right:20px;<% if(user == null){%>display:none<%} %>" ><p onclick=goUserPage("<%=user == null ? "":user.account %>")>个人页面</p></font>
            <font style="color:#999;float:right;margin-right:20px;<% if(user == null){%>display:none<%} %>" ><p onclick="createActivity()">创建活动</p></font>
            <div class="row">
				<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
					<ul id="myTab" class="nav nav-tabs">
					   <li class="active">
					   		<a href="#home" data-toggle="tab">所有活动</a>
					    </li>
					</ul>	
					
					<div class="table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>
										活动名称
									</th>
									<th>
										活动信息
									</th>
									<th>
										活动开始时间
									</th>
									<th>
										报名截止时间
									</th>
								</tr>
							</thead>
							<tbody>
							    <% for(Activity activity: allActivity){
							    %>
								<tr onclick=viewActivity("<%=activity.aid %>") >
								<td><%=activity.activity_name%>
								</td><td><%=activity.describe_info.substring(0,activity.describe_info.length() > 10?10:(activity.describe_info.length()))%><%if(activity.describe_info.length() > 10){ %>...<% }%>
								</td><td><%=activity.start_time%>
								</td><td><%=activity.vote_stop_time%></td></tr>
								<%
								   }
							    %>
								
								<tr align="right">
								  <td colspan="5">
								    <a href="home.jsp?pgno=<%=pgprev%>&pgcnt=<%=pgcnt%>">上一页</a>
									&nbsp;	            
							        <a href="home.jsp?pgno=<%=pgnext%>&pgcnt=<%=pgcnt%>">下一页</a>
								  </td>
								</tr>
							<tbody>
						</table>
					</div>
				</div>
			</div>
			
            <font style="color:#999;float:right;margin-right:20px;<% if(user == null || !user.account.equals("admin")){%>display:none<%} %>" ><p onclick=goManagerUser()>管理页面</p></font>
            <div class="text-center navbar-fixed-bottom" style="height:40px;padding-top:10px">
        	<font class="text-center" style="color:#999">team12348005 小组作业</font>
        	</div>
		</div>
    
  </body>
  <script src="script/home.js?1.03">
        </script>
  <script src="script/user.js?1.03">
        </script>
</html>
