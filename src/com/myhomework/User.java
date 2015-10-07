package com.myhomework;

import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
public class User {
	public String uid = "";
	public String account = "";
	public String describe = "";
	public String username = "";
	public String password = "";
	
	public User(String account, String describe, String username,
			String password) {
		super();
		this.account = account;
		this.describe = describe;
		this.username = username;
		this.password = password;
	}
	public User(){}
	
	public boolean modifyInfo(String u,String d){

		DatabaseHelper db = new DatabaseHelper();
		String sql = "update user set username = '"+u+"',describe_info ='"+d+"' where account = '"+account+"'";
		System.out.println(sql);
		try{
			db.prepareStatement(sql);
			int resultCode = db.executeUpdate();
			if(resultCode > 0) {
				this.username = u;
				this.describe = d;
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
	public boolean modifyPwd(String oldPwd,String newPwd){

		DatabaseHelper db = new DatabaseHelper();
		String sql = "update user set password = '"+newPwd+"' where account = '"+account+"' and password = '"+oldPwd+"'";
		System.out.println(sql);

		try{
			db.prepareStatement(sql);
			int resultCode = db.executeUpdate();
			if(resultCode > 0) {
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
	public static User getUserByAccout(String sessionId,String account){
		if(SessionIdAndUserHash.getUser(sessionId) == null){
			return null;
		}
		
		DatabaseHelper db = new DatabaseHelper();
		String sql = "select * from user where account = '"+account+"'";
		ResultSet resultset = db.executeQuery(sql);
		try{
			if(resultset != null && resultset.next()){
				User user = new User();
				user.uid = resultset.getString("uid");
				user.account = resultset.getString("account");
				user.username = resultset.getString("username");
				user.describe = resultset.getString("describe_info");
				resultset.close();
				return user;
			}
			else{
				return null;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			return null;
		}
		finally{
			db.close();
		}
	}
	public boolean register(String sessionId){
		DatabaseHelper db = new DatabaseHelper();
		String sql ="insert into user(account,username,password,describe_info) values ('"+account+"','"+username+"','"+password+"','"+describe+"')";

		try{
			db.prepareStatement(sql);
			int resultCode = db.executeUpdate();
			SessionIdAndUserHash.setUser(sessionId,this);
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
	
	static public User getUserBySessionId(String id){
		return SessionIdAndUserHash.getUser(id);
	}
	
	static public void loginout(String sessionId){
		SessionIdAndUserHash.removeSessionId(sessionId);
	}
	static public User login(String sessionId,String account,String password){
		
		DatabaseHelper db = new DatabaseHelper();
		String sql = "select * from user where account = '"+account+"' and password = '"+password+"'";
		ResultSet resultset = db.executeQuery(sql);
		try{

			if(resultset != null && resultset.next()){
				User user = new User();
				user.uid = resultset.getString("uid");
				user.account = resultset.getString("account");
				user.username = resultset.getString("username");
				user.describe = resultset.getString("describe_info");

				SessionIdAndUserHash.setUser(sessionId,user);
				resultset.close();
				return user;
			}
			else{
				return null;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			return null;
		}
		finally{
			db.close();
		}
	}
}
