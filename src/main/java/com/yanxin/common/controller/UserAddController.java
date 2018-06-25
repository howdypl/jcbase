/**
 * 
 */
package com.yanxin.common.controller;

import java.util.Date;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.yanxin.common.model.User;

/**
 * @author Cheng Guozhen
 * 
 */
public class UserAddController extends Controller {
	
	public void index() {
		
		render("adduser.jsp");
	}
	public void addUser(){
		//String usernameString = getPara("username"); 
		//User newUser = getBean(User.class, "user");
		User newUser = new User();
		newUser.setUserName(getPara("user.user_name"));
		newUser.setPassword(getPara("user.password"));
		newUser.setActor(getParaToInt("user.actor"));
		newUser.setPhone(getPara("user.phone"));
		newUser.setOperationClassId(getParaToLong("user.operation_class_id"));
		newUser.setValid(0);
		
		// SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		newUser.setCreateTime(new Date());
		
		boolean result = Db.save("user", newUser.toRecord());
		
		// boolean result = newUser.dao().save();
		
		setAttr("result", result);
		this.redirect("/useradd",false);

	}

}
