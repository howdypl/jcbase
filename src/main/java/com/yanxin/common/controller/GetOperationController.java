/**
 * 
 */
package com.yanxin.common.controller;

import java.util.ArrayList;
import java.util.List;

import com.jcbase.model.SysUser;
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
		
		//System.out.println(SysUserRole.dao.isOp(username)+"********************");
		int isOp = 1; // 默认不是管理员		
		
		if(SysUserRole.dao.isOp(username)) {
			
			sqlString = "select id, op_name from operation_class";
			isOp = 0; //管理员
		}
		else {
			sqlString = "select id,op_name from operation_class where id=(SELECT operation_class_id FROM sys_user WHERE name='"+username+"')";
			isOp = 1; //运维班管理员
		}
		
		List<Record> resultList = Db.find(sqlString);
		if(!resultList.isEmpty()){
			setAttr("result", true);
			
			setAttr("content", resultList);
		}else{
			setAttr("result", false);
		}
		setAttr("isOp", isOp);
		renderJson();
	}
	
	/**
	 * 根据用户和工区ID获取某工区运维班
	 */
	public void getOpc() {
		List<Record> resultList = new ArrayList<Record>();
		String sqlString;
		String username=this.getPara("username");
		String wa = this.getPara("workarea");
		//System.out.println("工区参数："+wa);
		SysUser user = SysUser.me.getByName(username);
		if(null==user){
			setAttr("result", false);
			renderJson();
			return;
		}
		int waID = 0;
		if(wa!=null){
			waID = this.getParaToInt("workarea");
		}else {
			if(!username.equals("admin")){
				
				waID = user.getWork_area_id();
			}
		}
		//System.out.println(SysUserRole.dao.isOp(username)+"********************");
		//int isOp = SysUserRole.dao.userOP(username); // 默认不是管理员
		
		if(waID>0){
			if(user.getUserType().intValue() == 0) {
				sqlString = "select id, op_name from operation_class where work_area_id=?";
				resultList = Db.find(sqlString,waID);
			}else if(user.getUserType().intValue() == 1){
				sqlString = "select id,op_name from operation_class where work_area_id=(SELECT work_area_id FROM sys_user WHERE name='"+username+"')";
				resultList = Db.find(sqlString);
			}else {
				sqlString = "select id,op_name from operation_class where id=(SELECT operation_class_id FROM sys_user WHERE name='"+username+"')";
				resultList = Db.find(sqlString);
			}
		}else{ // 工区ID传递0的话
		
			if(user.getUserType().intValue() == 0) {
				sqlString = "select id, op_name from operation_class";
			}else if(user.getUserType().intValue() == 1){
				sqlString = "select id,op_name from operation_class where work_area_id=(SELECT work_area_id FROM sys_user WHERE name='"+username+"')";
			}else {
				sqlString = "select id,op_name from operation_class where id=(SELECT operation_class_id FROM sys_user WHERE name='"+username+"')";
			}
			resultList = Db.find(sqlString);
		}
		
		if(!resultList.isEmpty()){
			setAttr("result", true);
			
			setAttr("content", resultList);
		}else{
			setAttr("result", false);
		}
		setAttr("isOp", user.getUserType().intValue()+1);
		renderJson();
	}
	
	
	/**
	 * 根据用户和工区ID获取某工区运维班
	 */
	public void getOP() {
		List<Record> resultList = new ArrayList<Record>();
		String sqlString;
		String username=this.getPara("username");
		String wa = this.getPara("workarea");
		
		int waID = 0;
		if(wa!=null){
			waID = this.getParaToInt("workarea");
		}else {
			if(!username.equals("admin")){
				SysUser user = SysUser.me.getByName(username);
				waID = user.getWork_area_id();
			}
		}
		//System.out.println(SysUserRole.dao.isOp(username)+"********************");
		int isOp = SysUserRole.dao.userOP(username); // 默认不是管理员
		if(waID>0){
			if(isOp == 1) {
				sqlString = "select id, op_name from operation_class where work_area_id=?";
				resultList = Db.find(sqlString,waID);
			}else if(isOp == 2){
				sqlString = "select id,op_name from operation_class where work_area_id=(SELECT work_area_id FROM sys_user WHERE name='"+username+"')";
				resultList = Db.find(sqlString);
			}else {
				sqlString = "select id,op_name from operation_class where id=(SELECT operation_class_id FROM sys_user WHERE name='"+username+"')";
				resultList = Db.find(sqlString);
			}
		}else{ // 工区ID传递0的话
		
			if(isOp == 1) {
				sqlString = "select id, op_name from operation_class";
			}else if(isOp == 2){
				sqlString = "select id,op_name from operation_class where work_area_id=(SELECT work_area_id FROM sys_user WHERE name='"+username+"')";
			}else {
				sqlString = "select id,op_name from operation_class where id=(SELECT operation_class_id FROM sys_user WHERE name='"+username+"')";
			}
			resultList = Db.find(sqlString);
		}
		
		if(!resultList.isEmpty()){
			setAttr("result", true);
			
			setAttr("content", resultList);
		}else{
			setAttr("result", false);
		}
		setAttr("isOp", isOp);
		renderJson();
	}
	
	public void opInSingleWorkArea() {
		String sqlString = null;
		String username=this.getPara("username");
		
		// System.out.println(SysUserRole.dao.isOp(username)+"********************");
		// SysUser user = SysUser.me.getByName(username);
		int isOp = SysUserRole.dao.userOP(username); // 默认不是管理员
		if(isOp == 1) {
			sqlString = "select id, op_name from operation_class";
			
		}else if(isOp == 2){
			sqlString = "select id,op_name from operation_class where id=(SELECT operation_class_id FROM sys_user WHERE name='"+username+"')";
			
		}
		
		List<Record> resultList = Db.find(sqlString);
		if(!resultList.isEmpty()){
			setAttr("result", true);
			
			setAttr("content", resultList);
		}else{
			setAttr("result", false);
		}
		setAttr("isOp", isOp);
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
