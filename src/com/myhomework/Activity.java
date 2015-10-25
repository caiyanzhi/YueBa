package com.myhomework;

import java.sql.ResultSet;
import java.util.ArrayList;

//create by caiyanzhi
public class Activity {
	public String aid = "";
	public String uid = "";
	public String activity_statue = ""; // 1 代表正在报名中 2表示已经截止报名 3表示活动已经举办完毕 4表示活动已经被取消
	public String start_time = "";
	public String create_time = "";
	public String vote_stop_time = "";
	public String describe_info = "";
	public String activity_name = "";
	
	public Activity(String uid,String activityname,String activity_statue,String start_time, String create_time, String vote_stop_time,
			String describe_info) {
		super();
		this.uid = uid;
		this.activity_name = activityname;
		this.activity_statue = activity_statue;
		this.start_time = start_time;
		this.create_time = create_time;
		this.vote_stop_time = vote_stop_time;
		this.describe_info = describe_info;
	}
	
	public static boolean isJoinActivity(String uid,String aid){
		DatabaseHelper db = new DatabaseHelper();
		String sql ="select * from join_activity where uid = '"+uid+"' and aid = '"+aid+"'";
		System.out.println(sql);
		ResultSet resultset = db.executeQuery(sql);
		try{
			if(resultset != null && resultset.next()){
				return true;
			}
			else{
				return false;
			}
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		finally{
			db.close();
		}
		
	}
	//创建活动
	public static boolean insertActivity(Activity activity){
		DatabaseHelper db = new DatabaseHelper();
		String sql ="insert into activity(uid,activity_name,activity_statue,start_time,create_time,vote_stop_time,describe_info) values ('"+activity.uid+"','"+activity.activity_name+"','"+activity.activity_statue+"','"+activity.start_time+"','"+activity.create_time+"','"+activity.vote_stop_time+"','"+activity.describe_info+"')";
		System.out.println(sql);
		try{
			db.prepareStatement(sql);
			int resultCode = db.executeUpdate();
			if(resultCode > 0)
				return true;
			
			else return false;
		}
		catch(Exception e){
			e.printStackTrace();
			return false;
		}
		finally{
			db.close();
		}
	}
	
	//修改activity的描述，必须是修改从数据库中拿到的activity，因为必须有aid
	public boolean modifyActivityInfo(String new_describe_info){
		DatabaseHelper db = new DatabaseHelper();
		String sql = "update activity set describe_info = '"+new_describe_info+"' where aid = '"+aid+"'";
		System.out.println(sql);
		try{
			db.prepareStatement(sql);
			int resultCode = db.executeUpdate();
			if(resultCode > 0) {
				this.describe_info = new_describe_info;
				return true;
			}
			else return false;
		}
		catch(Exception e){
			e.printStackTrace();
			return false;
		}
		finally{
			db.close();
		}
	}
	
	//查询活动活动
	public static Activity getActivityByAid(String aid){
		DatabaseHelper db = new DatabaseHelper();
		String sql = "select DISTINCT * from activity where aid = '"+aid+"'";
		System.out.println(sql);
		ResultSet resultset = db.executeQuery(sql);
		try{
			while(resultset != null && resultset.next()){
				Activity activity = new Activity();
				activity.uid = resultset.getString("uid");
				activity.aid = resultset.getString("aid");
				activity.activity_statue = resultset.getString("activity_statue");
				activity.start_time = resultset.getString("start_time");
				activity.create_time = resultset.getString("create_time");
				activity.vote_stop_time = resultset.getString("vote_stop_time");
				activity.describe_info = resultset.getString("describe_info");
				activity.activity_name = resultset.getString("activity_name");
				resultset.close();
				return activity;
			}

			resultset.close();
			return null;
		}
		catch(Exception e){
			e.printStackTrace();
			return null;
		}
		finally{
			if(resultset != null) 
			db.close();
		}
	}
	
	//查询所有参加活动的用户
	public static ArrayList<User> getJoinerOfActivity(Activity activity){
		ArrayList<User> userList = new ArrayList<User>();
		DatabaseHelper db = new DatabaseHelper();
		String sql = "select DISTINCT * from user natural join join_activity where aid = '"+activity.aid+"'";
		System.out.println(sql);
		ResultSet resultset = db.executeQuery(sql);
		try{
			while(resultset != null && resultset.next()){
				User user = new User();
				user.uid = resultset.getString("uid");
				user.account = resultset.getString("account");
				user.username = resultset.getString("username");
				user.describe = resultset.getString("describe_info");
				userList.add(user);
			}
			if(resultset!=null)
			resultset.close();
			return userList;
		}
		catch(Exception e){
			e.printStackTrace();
			return userList;
		}
		finally{
			db.close();
		}
	}
	
	//获取所有活动
	public static ArrayList<Activity> getAllActivity(int pgno,int pgcnt){
		ArrayList<Activity> activityList = new ArrayList<Activity>();
		DatabaseHelper db = new DatabaseHelper();
		String sql = "select * from activity order by create_time desc limit " + pgno*pgcnt + "," + pgcnt;;
		System.out.println(sql);
		ResultSet resultset = db.executeQuery(sql);
		try{
			while(resultset != null && resultset.next()){
				Activity activity = new Activity();
				activity.uid = resultset.getString("uid");
				activity.aid = resultset.getString("aid");
				activity.activity_statue = resultset.getString("activity_statue");
				activity.start_time = resultset.getString("start_time");
				activity.create_time = resultset.getString("create_time");
				activity.vote_stop_time = resultset.getString("vote_stop_time");
				activity.describe_info = resultset.getString("describe_info");
				activity.activity_name = resultset.getString("activity_name");
				activityList.add(activity);
			}
			if(resultset != null)
				resultset.close();
			return activityList;
		}
		catch(Exception e){
			e.printStackTrace();
			return activityList;
		}
		finally{
			db.close();
		}
	}
	
	//获取用户参与的所有活动
	public static ArrayList<Activity> getActivityOfUser(User user){
		ArrayList<Activity> userList = new ArrayList<Activity>();
		DatabaseHelper db = new DatabaseHelper();
		String sql = "select DISTINCT * from (user natural join join_activity) natural join activity where uid = '"+user.uid+"'";
		System.out.println(sql);
		ResultSet resultset = db.executeQuery(sql);
		try{
			while(resultset != null && resultset.next()){
				Activity activity = new Activity();
				activity.uid = resultset.getString("uid");
				activity.aid = resultset.getString("aid");
				activity.activity_statue = resultset.getString("activity_statue");
				activity.start_time = resultset.getString("start_time");
				activity.create_time = resultset.getString("create_time");
				activity.vote_stop_time = resultset.getString("vote_stop_time");
				activity.describe_info = resultset.getString("describe_info");
				activity.activity_name = resultset.getString("activity_name");
				userList.add(activity);
			}

			if(resultset != null)
				resultset.close();
			return userList;
		}
		catch(Exception e){
			e.printStackTrace();
			return userList;
		}
		finally{
			db.close();
		}
	}
	
	//参加活动
	public static boolean joinActivity(User user,Activity activity){
		DatabaseHelper db = new DatabaseHelper();
		String sql ="insert into join_activity(uid,aid) values ('"+user.uid+"','"+activity.aid+"')";
		System.out.println(sql);
		try{
			db.prepareStatement(sql);
			int resultCode = db.executeUpdate();
			if(resultCode > 0)
				return true;
			
			else return false;
		}
		catch(Exception e){
			e.printStackTrace();
			return false;
		}
		finally{
			db.close();
		}
	}

	// 退出活动
	public static boolean quitActivity(User user, Activity activity) {
		DatabaseHelper db = new DatabaseHelper();
		String sql = "delete from join_activity where uid = '"+user.uid+"'"	+ "and aid= '" + activity.aid +"'";
		System.out.println(sql);
		try {
			db.prepareStatement(sql);
			int resultCode = db.executeUpdate();
			if (resultCode > 0) return true;
			else return false;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			db.close();
		}
	}
	
	//取消该活动
	public static boolean delectActivity(User user,Activity activity){
		DatabaseHelper db = new DatabaseHelper();
		String sql = "update activity set activity_status = '4' where aid = '"+activity.uid+"' and uid = '"+user.uid+"'";
		
		try{
			db.prepareStatement(sql);
			int resultCode = db.executeUpdate();
			if(resultCode > 0)
				return true;
			
			else return false;
		}
		catch(Exception e){
			e.printStackTrace();
			return false;
		}
		finally{
			db.close();
		}
	}
	
	public Activity(){}
	
	public String getAid() {
		return aid;
	}

	public void setAid(String aid) {
		this.aid = aid;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getActivity_statue() {
		return activity_statue;
	}

	public void setActivity_statue(String activity_statue) {
		this.activity_statue = activity_statue;
	}

	public String getStart_time() {
		return start_time;
	}

	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public String getCreate_time() {
		return create_time;
	}

	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}

	public String getVote_stop_time() {
		return vote_stop_time;
	}

	public void setVote_stop_time(String vote_stop_time) {
		this.vote_stop_time = vote_stop_time;
	}

	public String getDescribe_info() {
		return describe_info;
	}

	public void setDescribe_info(String describe_info) {
		this.describe_info = describe_info;
	}

	public String getActivity_name() {
		return activity_name;
	}

	public void setActivity_name(String activity_name) {
		this.activity_name = activity_name;
	}

//	
//	public boolean modifyInfo(String u,String d){
//
//		DatabaseHelper db = new DatabaseHelper();
//		String sql = "update user set username = '"+u+"',describe_info ='"+d+"' where account = '"+account+"'";
//		System.out.println(sql);
//		try{
//			db.prepareStatement(sql);
//			int resultCode = db.executeUpdate();
//			if(resultCode > 0) {
//				this.username = u;
//				this.describe = d;
//				return true;
//			}
//			else return false;
//		}
//		catch(Exception e){
//			e.printStackTrace();
//			return false;
//		}
//		finally{
//			db.close();
//		}
//	}
//	
//	public boolean modifyPwd(String oldPwd,String newPwd){
//
//		DatabaseHelper db = new DatabaseHelper();
//		String sql = "update user set password = '"+newPwd+"' where account = '"+account+"' and password = '"+oldPwd+"'";
//		System.out.println(sql);
//
//		try{
//			db.prepareStatement(sql);
//			int resultCode = db.executeUpdate();
//			if(resultCode > 0) {
//				return true;
//			}
//			else return false;
//		}
//		catch(Exception e){
//			e.printStackTrace();
//			return false;
//		}
//		finally{
//			db.close();
//		}
//	}
//	public static User getUserByAccout(String sessionId,String account){
//		if(SessionIdAndUserHash.getUser(sessionId) == null){
//			return null;
//		}
//		
//		DatabaseHelper db = new DatabaseHelper();
//		String sql = "select * from user where account = '"+account+"'";
//		ResultSet resultset = db.executeQuery(sql);
//		try{
//			if(resultset != null && resultset.next()){
//				User user = new User();
//				user.uid = resultset.getString("uid");
//				user.account = resultset.getString("account");
//				user.username = resultset.getString("username");
//				user.describe = resultset.getString("describe_info");
//				resultset.close();
//				return user;
//			}
//			else{
//				return null;
//			}
//		}
//		catch(Exception e){
//			e.printStackTrace();
//			return null;
//		}
//		finally{
//			db.close();
//		}
//	}
//	public boolean register(String sessionId){
//		DatabaseHelper db = new DatabaseHelper();
//		String sql ="insert into user(account,username,password,describe_info) values ('"+account+"','"+username+"','"+password+"','"+describe+"')";
//
//		try{
//			db.prepareStatement(sql);
//			int resultCode = db.executeUpdate();
//			SessionIdAndUserHash.setUser(sessionId,this);
//			if(resultCode > 0)
//				return true;
//			
//			else return false;
//		}
//		catch(Exception e){
//			e.printStackTrace();
//			return false;
//		}
//		finally{
//			db.close();
//		}
//	}
//	
//	static public User getUserBySessionId(String id){
//		return SessionIdAndUserHash.getUser(id);
//	}
//	
//	static public void loginout(String sessionId){
//		SessionIdAndUserHash.removeSessionId(sessionId);
//	}
//	static public User login(String sessionId,String account,String password){
//		
//		DatabaseHelper db = new DatabaseHelper();
//		String sql = "select * from user where account = '"+account+"' and password = '"+password+"'";
//		ResultSet resultset = db.executeQuery(sql);
//		try{
//
//			if(resultset != null && resultset.next()){
//				User user = new User();
//				user.uid = resultset.getString("uid");
//				user.account = resultset.getString("account");
//				user.username = resultset.getString("username");
//				user.describe = resultset.getString("describe_info");
//
//				SessionIdAndUserHash.setUser(sessionId,user);
//				resultset.close();
//				return user;
//			}
//			else{
//				return null;
//			}
//		}
//		catch(Exception e){
//			e.printStackTrace();
//			return null;
//		}
//		finally{
//			db.close();
//		}
//	}
}
