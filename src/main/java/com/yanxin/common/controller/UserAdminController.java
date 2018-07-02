/**
 * 
 */
package com.yanxin.common.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.model.User;

/**
 * @author Cheng Guozhen
 * 
 */
public class UserAdminController extends Controller {
	
	public void index() {
		String sqlString = "SELECT `user`.id, user_name, `password`,phone, actor, last_login,`user`.create_time, valid,op_name FROM `user`,operation_class WHERE `user`.actor = 2 AND `user`.operation_class_id = operation_class.id "
				+ " UNION ALL "
				+ "SELECT `user`.id, user_name, `password`,phone,actor, last_login,`user`.create_time,valid,NULL op_name FROM `user` WHERE `user`.actor <> 2";
		
		List<Record> userInfoList = new ArrayList<Record>();
		userInfoList = Db.find(sqlString);
		//List<Record> sensorDataList = Db.paginate(1, 10, select, sqlExcepionString).getList();
		setAttr("userInfoList", userInfoList);
		render("userdata.jsp");
	}
	
	public void update() {
		User user = getBean(User.class, "user");
		
		if(null != user){
			
			Record targetUser = Db.findById("user", user.getId());
			
			if(null != targetUser){
				
				targetUser.set("user_name", user.getUserName());
				targetUser.set("phone", user.getPhone());
				Db.save("user", targetUser);
			}
		}

	}
	public void updateWithAjax() {
		boolean result = true;
		int id = getParaToInt("userId");
		String userName = getPara("userName");
		String phoneString = getPara("phone");
		result = User.dao.findById(id).set("user_name", userName).set("phone", phoneString).update();
		//System.out.println("result="+result);
		setAttr("result", result);
		
		renderJson();
		
	}
	public void deleteUser(){
		boolean result;
		int id = getParaToInt("userid");
		System.out.println("userid="+id);
		result = Db.deleteById("user", id);
		
		setAttr("result", result);
		renderJson();
	}
	public void checkUser(){
		String usernameString = getPara("username"); 
		
		System.out.println("usernameString="+usernameString);
		if(null != usernameString){
			Record tempRecord = Db.findFirst("select * from user where user_name=?", usernameString);
			if (null != tempRecord) {
				setAttr("hasExisting",1);
			}else {
				setAttr("hasExisting",0);
			}
			renderJson();
		}
	}


}
