/**
 * Copyright (c) 2011-2016, Eason Pan(pylxyhome@vip.qq.com).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.jcbase.controller.sys;

import java.util.List;

import com.jcbase.core.auth.anno.RequiresPermissions;
import com.jcbase.core.controller.JCBaseController;
import com.jcbase.core.util.IWebUtils;
import com.jcbase.core.util.JqGridModelUtils;
import com.jcbase.core.view.InvokeResult;
import com.jcbase.model.SysRole;
import com.jcbase.model.SysUser;
import com.jcbase.model.SysUserRole;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.yanxin.common.model.OperationClass;

/**
 * 系统用户管理.
 * @author eason
 */
public class UserController extends JCBaseController {
	
	@RequiresPermissions(value={"/sys/user"}) 
	public void index() {
		render("user_index.jsp");
	}

	@RequiresPermissions(value={"/sys/user"})
	public void getListData() {
		String keyword=this.getPara("name");
		String username=this.getPara("username");
		Page<SysUser> pageInfo=SysUser.me.getSysUserPage(getPage(), this.getRows(),keyword,username,this.getOrderbyStr());
		this.renderJson(JqGridModelUtils.toJqGridView(pageInfo)); 
	}
	
	/*@RequiresPermissions(value={"/sys/user"})
	public void seachByName() {
		String keyword=this.getPara("username");
		String name=this.getPara("name");
//		System.out.println("admin".equals(keyword)+"this is key!");
		Page<SysUser> pageInfo=SysUser.me.seachSysUserPage(getPage(), this.getRows(),keyword,this.getOrderbyStr(),name);
		this.renderJson(JqGridModelUtils.toJqGridView(pageInfo)); 
	}
*/
	@RequiresPermissions(value={"/sys/user"})
	public void getUser(){
		String sqlString = "select id,name FROM sys_user WHERE id NOT IN(select DISTINCT op_manager FROM operation_class)";
		List<Record> userList = Db.find(sqlString);
		setAttr("userList", userList);
		if(userList != null && userList.size() > 0){
			setAttr("result", true);
		}else{
			setAttr("result", false);
		}
		renderJson();
	}
	
	@RequiresPermissions(value={"/sys/user"})
	public void setVisible(){
		Integer visible=this.getParaToInt("visible");
		String ids=this.getPara("ids");
		InvokeResult result=SysUser.me.setVisible(ids, visible);
		this.renderJson(result);
	}
	
	@RequiresPermissions(value={"/sys/user"})
	public void delUser(){
		String ids=this.getPara("ids");
		InvokeResult result=SysUser.me.delUserByIDs(ids);
		this.renderJson(result);
	}

	@RequiresPermissions(value={"/sys/user"})
	public void add() {
		/*SysUser sysUser=IWebUtils.getCurrentSysUser(this.getRequest());
		if(sysUser!=null){
			this.setAttr("item", sysUser);
		}
		List<SysRole> list=SysRole.me.getSysRoleNamelist();
		this.setAttr("roleList", list);
		this.setAttr("id", sysUser.getId());
		
		render("user_add.jsp");*/
		
		
		Integer id=this.getParaToInt("id");
		if(id!=null){
			SysUser user = SysUser.me.findById(id);
			this.setAttr("item", user);
		}
		List<SysRole> list=SysRole.me.getSysRoleNamelist();
		this.setAttr("roleList", list);
		this.setAttr("id", id);
		render("user_add.jsp");
	}
	
	@RequiresPermissions(value={"/sys/user"})
	public void save(){
		String name=this.getPara("name");
		String username=this.getPara("username");
		String password=this.getPara("password");
		String phone=this.getPara("phone");
		String email=this.getPara("email");
		Integer id=this.getParaToInt("id");
		String wa = this.getPara("work_area_id");
		String op = this.getPara("operation_class_id");
		Integer work_area = new Integer(0);
		Integer operation_class_id= new Integer(0);
		Integer userType = this.getParaToInt("user_type");
		
		if(wa!=null){
			work_area = this.getParaToInt("work_area_id");
			if(!username.equals("admin")){
				SysUser user = SysUser.me.getByName(username);
				if(userType==1){
					work_area = user.getWork_area_id();
				}
			}
		}
		
		if(op!=null){
			operation_class_id=this.getParaToInt("operation_class_id");
		}
		if(operation_class_id>0 && work_area==0){
			
			OperationClass opp = OperationClass.me.findById(operation_class_id);
			work_area = opp.getWorkAreaId();
		}
		
		
		/*if(operation_class_id==0) {
			operation_class_id=null;
		}*/
		/*Integer station_id=this.getParaToInt("station_id");
		if(station_id==0) {
			station_id=null;
		}*/
//		System.out.println(id+"this is id!");
		String des=this.getPara("des");
		InvokeResult result=SysUser.me.save(id, name, password, des,phone, email,work_area,userType,operation_class_id);
		/*if(!SysUserRole.dao.isOp(username)) {
			SysUserRole.dao.setRole(name);
		}*/
		this.renderJson(result); 
	}
	
	
	@RequiresPermissions(value={"/sys/user"})
	public void userRoleSetting() {
		Integer uid=this.getParaToInt("uid");
		String uname=this.getPara("uname");
		this.setAttr("item", SysUser.me.findById(uid));
		InvokeResult result=SysRole.me.getRoleZtreeViewList(uid,uname);
		this.setAttr("jsonTree", result);
		render("user_role_setting.jsp");
	}
	
	
	@RequiresPermissions(value={"/sys/user"})
	@Before(Tx.class)
	public void saveUserRoles(){
		Integer uid=this.getParaToInt("id");
		String roleIds=this.getPara("roleIds");
		InvokeResult result=SysUser.me.changeUserRoles(uid, roleIds);
		this.renderJson(result);
	}
	//判断是否为超级管理员或者工区领导角色
	
	public void getWord(){
		String username=this.getPara("name");
		String word=SysUserRole.dao.isGight(username);
		if(word.equals("yes")) {
			setAttr("word", true);
		}
		else {
			setAttr("word", false);
		}
		renderJson();
	}
	
	public void getWAWord(){
		String username=this.getPara("name");
		String word=SysUserRole.dao.isWAGight(username);
		if(word.equals("yes")) {
			setAttr("word", true);
		}
		else {
			setAttr("word", false);
		}
		renderJson();
	}
}





