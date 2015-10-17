package com.myhomework;

import java.util.HashMap;

//create by caiyanzhi
public class SessionIdAndUserHash {
	static private HashMap<String,User> hashMap = new HashMap<String,User>(); 
	private SessionIdAndUserHash(){};
	public static User getUser(String sessionId){
		return hashMap.get(sessionId);
	}
	
	public static void setUser(String id,User user){
		hashMap.put(id,user);
	}
	
	public static void removeSessionId(String id){
		hashMap.remove(id);
	}
}
