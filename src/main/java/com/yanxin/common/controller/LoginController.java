
package com.yanxin.common.controller;

import java.util.Date;
import java.util.List;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.model.User;
import com.yanxin.iot.mqtt.CmdLineParser;

/**
 * @author Cheng Guozhen
 * 
 */
public class LoginController extends Controller {
	
	public void index() {

		/*if(getSessionAttr("user")!=null){
			removeSessionAttr("user");
		}*/
		
		render("login.jsp");
	}
	
	public void login(){
		User user = getBean(User.class, "user");
		
		List<Record> users = Db.find("select * from user where user_name=? and password=?", user.getUserName(),user.getPassword());
		
		if(null == users || users.isEmpty()){
			setAttr("loginInfo", "用户名或密码不正确！");
			
			render("login.jsp");
		}else{
			setSessionAttr("currentuser", users.get(0));
			users.get(0).set("last_login", new Date());
			Db.update("user", users.get(0));
			
			this.gallery();
		}
	}
	
	
	
	private void gallery() {
		// render("view/gallery.jsp");
		redirect("/gallery");
		System.out.println("---------------context path"+this.getRequest().getContextPath());
	}
	
	public void loginLog() {
		
	}
	

}
