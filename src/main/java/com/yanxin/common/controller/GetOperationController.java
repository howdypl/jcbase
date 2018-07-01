/**
 * 
 */
package com.yanxin.common.controller;

import java.util.List;

import com.jcbase.model.SysUserRole;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

/**
 * @author Cheng Guozhen
 * 
 */
public class GetOperationController extends Controller {
	
	public void index() {
		String sqlString;
		String username=this.getPara("username");
		System.out.println(SysUserRole.dao.isOp(username)+"********************");
		if(SysUserRole.dao.isOp(username)) {
			sqlString = "select id, op_name from operation_class";
		}
		else {
			sqlString = "select id,op_name from operation_class where id=(SELECT operation_class_id FROM sys_user WHERE name='"+username+"')";
		}
		
		System.out.println(sqlString+"****************************");
		List<Record> resultList = Db.find(sqlString);
		if(!resultList.isEmpty()){
			setAttr("notempty", true);
			setAttr("oplist", resultList);
		}else{
			setAttr("notempty", false);
		}
		renderJson();
	}
	
	public void getOpAll() {
		String sqlString = "select id, op_name from operation_class";
		System.out.println(sqlString+"****************************");
		List<Record> resultList = Db.find(sqlString);
		if(!resultList.isEmpty()){
			setAttr("notempty", true);
			setAttr("oplist", resultList);
		}else{
			setAttr("notempty", false);
		}
		renderJson();
	}

}
