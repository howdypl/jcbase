/**
 * 
 */
package com.yanxin.common.controller;

import java.util.Date;
import java.util.List;

import com.jcbase.model.SysUser;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.model.OperationClass;

/**
 * @author Cheng Guozhen
 * 
 */
public class OpClassController extends Controller {
	
	public void index(){
		String sqlString = "select operation_class.*, sys_user.name FROM operation_class left join sys_user on op_manager=sys_user.id";
//				+ "UNION ALL "
//				+ "select operation_class.*,NULL user_name FROM operation_class WHERE op_manager = 0";
		List<Record> opClassList = Db.find(sqlString);
		
		setAttr("opClassList", opClassList);
		render("opclasslist.jsp");
	}
	
	public void deleteItem(){
		int id = getParaToInt("opClassId");
//		String op_manager=getPara("op_manager");
		boolean result = Db.deleteById("operation_class", id);
//		int a=Db.update("update sys_user set grade=? where id=?", 4, op_manager);
//		System.out.println(a+"十大股东分红");
		setAttr("result", result);
		
		renderJson();
	}
	
	public void isExisting() {
		String opNameString = getPara("opName");
		String sqlString = "select * from operation_class where op_name=?";
		
		List<Record> sensorType = Db.find(sqlString,opNameString);
		if(!sensorType.isEmpty()){
			setAttr("hasExisting", 1);
		}else{
			setAttr("hasExisting", 0);
		}
		renderJson();
	}
	
	public void addItem() {
		OperationClass oClass = new OperationClass();
		
		oClass.setOpName(getPara("op_name"));
		oClass.setOpAddr(getPara("op_addr"));
		oClass.setOpDesc(getPara("op_desc"));
		oClass.setCreateTime(new Date());
		oClass.setOpManager(getParaToInt("op_Manager"));
		
//		SysUser.me.setNum(2);//设置用户等级
		boolean result = Db.save("operation_class", oClass.toRecord());
		int b=Db.update("update sys_user set operation_class_id=(select id from operation_class where op_manager=?) where id=?",getParaToInt("op_Manager"),getParaToInt("op_Manager"));
		setAttr("result", result);
//		int a=Db.update("update sys_user set grade=? where id=?", 3, getParaToInt("op_Manager"));
		renderJson();
	}

}
