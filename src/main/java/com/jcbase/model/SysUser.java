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
package com.jcbase.model;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.common.collect.Lists;
import com.jcbase.core.cache.CacheClearUtils;
import com.jcbase.core.model.Condition;
import com.jcbase.core.model.Operators;
import com.jcbase.core.util.CommonUtils;
import com.jcbase.core.util.IWebUtils;
import com.jcbase.core.util.MyDigestUtils;
import com.jcbase.core.view.InvokeResult;
import com.jcbase.model.base.BaseSysUser;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;

/**
 * @author eason
 * 系统用户
 */
public class SysUser extends BaseSysUser<SysUser>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -1982696969221258167L;
	public static SysUser me = new SysUser();
	
	
	
	/**
	 * 权限集
	 */
	public Set<String> getPermissionSets() {
		return SysRes.me.getSysUserAllResUrl(this.getId());
	} 
	/**
	 * 是否有管理员权限
	 */
	public boolean isAdmin(){
		long count=Db.queryLong("select count(*) from sys_user_role where role_id=? and user_id=?", 1,this.getId());
		return  count>0?true:false;
	}
	
	public SysUser getUserOP(String username){
		
		SysUser user = me.findFirst("SELECT * FROM sys_user WHERE sys_user.`name`=?",username);
		return user;
	}
	
	/**
	 * 用户登陆
	 * @author eason	
	 * @param username
	 * @param pwd
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	public InvokeResult login(String username, String pwd,HttpServletResponse response,HttpSession session,String url) {
		Set<Condition> conditions=new HashSet<Condition>();
		conditions.add(new Condition("name",Operators.EQ,username));
		conditions.add(new Condition("pwd",Operators.EQ,MyDigestUtils.shaDigestForPasswrod(pwd)));
		SysUser sysUser=this.get(conditions);
		if(sysUser==null){
			return InvokeResult.failure("用户名或密码不对");
		}
		if(sysUser.getInt("status")==2){
			return InvokeResult.failure("用户被冻结，请联系管理员");
		}
		//IWebUtils.setCurrentLoginSysUser(response,session,sysUser);
		Map<String,Object> data=new HashMap<String,Object>();
		data.put("url",url);
		return InvokeResult.success(data);
	}
	/**
	 * 获取用户拥有的角色列表，最多查20个
	 * @author eason	
	 * @param uid
	 * @return
	 */
	public List<SysUser> getSysUserList(int uid){
		
		return this.paginate(1, 20, "select *", "from sys_user ",uid).getList();
	}
	
	public List<SysUser> getSysUserIdList(int uid){
		return this.paginate(1, 20, "select id", "from sys_user ",uid).getList();
	}
	
	public InvokeResult setVisible(String bids, Integer visible) {
//		List<Integer> i=CommonUtils.getIntegerListByStrs(bids);
//		if(i.contains(1)){
//			return InvokeResult.failure(-2,"超级管理员不能被修改");
//		}
		List<Integer> ids=new ArrayList<Integer>();
		if(bids.contains(",")){
			
			for(String aid : bids.split(",")){
				if(StrKit.notBlank(aid)){
					ids.add(Integer.valueOf(aid));
				}
			}
		}else{
			if(StrKit.notBlank(bids)){
				ids.add(Integer.valueOf(bids));
			}
		}
		if(bids.length()>0){
			bids=bids.subSequence(0, bids.length()-1).toString();
		}
		Set<Condition> conditions=new HashSet<Condition>();
		conditions.add(new Condition("id",Operators.IN,ids));
		Map<String,Object> newValues=new HashMap<String,Object>();
		newValues.put("status", visible);
		this.update(conditions, newValues);
		return InvokeResult.success();
	} 
	
	public InvokeResult delUserByIDs(String bids) {
//		List<Integer> i=CommonUtils.getIntegerListByStrs(bids);
//		if(i.contains(1)){
//			return InvokeResult.failure(-2,"超级管理员不能被修改");
//		}
		List<Integer> ids=new ArrayList<Integer>();
		if(bids.contains(",")){
			
			for(String aid : bids.split(",")){
				if(StrKit.notBlank(aid)){
					ids.add(Integer.valueOf(aid));
				}
			}
		}else{
			if(StrKit.notBlank(bids)){
				ids.add(Integer.valueOf(bids));
			}
		}
		if(bids.length()>0){
			bids=bids.subSequence(0, bids.length()-1).toString();
		}
		Set<Condition> conditions=new HashSet<Condition>();
		conditions.add(new Condition("id",Operators.IN,ids));		
		this.delete(conditions);
		return InvokeResult.success();
	} 
	
	/**
	 * 用户名是否已存在
	 * @param name
	 * @return
	 */
	public boolean hasExist(String name){
		Set<Condition> conditions=new HashSet<Condition>();
		conditions.add(new Condition("name",Operators.EQ,name));
		long num=this.getCount(conditions);
		return num>0?true:false;
	}
	public SysUser getByName(String name){
		Set<Condition> conditions=new HashSet<Condition>();
		conditions.add(new Condition("name",Operators.EQ,name));
		return this.get(conditions);
	}
	public SysUser getByPhone(String phone){
		Set<Condition> conditions=new HashSet<Condition>();
		conditions.add(new Condition("phone",Operators.EQ,phone));
		return this.get(conditions);
	}
	public InvokeResult save(Integer id,String username,String password,String des,String phone,String email,Integer work_area,Integer userType,Integer operation_class_id){
		if(null!=id){
			SysUser sysUser=this.findById(id);
			sysUser.set("des", des).set("phone", phone).set("email", email).set("work_area_id",work_area).set("user_type",userType).set("operation_class_id", operation_class_id).update();
		}else {
			if(this.hasExist(username)){
				return InvokeResult.failure("用户名已存在");
			}else {
				if(StrKit.isBlank(password))password="123456";
				SysUser sysUser=new SysUser();
				sysUser.set("name", username).set("pwd", MyDigestUtils.shaDigestForPasswrod(password)).set("createdate", new Date()).set("des", des).set("phone", phone).set("email", email).set("work_area_id",work_area).set("user_type",userType).set("operation_class_id", operation_class_id).save();
			}
		}
		return InvokeResult.success();
	}
	/**
	 * 修改用户角色
	 * @param uid
	 * @param roleIds
	 * @return
	 */
	public InvokeResult changeUserRoles(Integer uid,String roleIds){
		Db.update("delete from sys_user_role where user_id = ?", uid);
		List<String> sqlList=Lists.newArrayList();
		for(String roleId : roleIds.split(",")){
			if(CommonUtils.isNotEmpty(roleId)){
				sqlList.add("insert into sys_user_role (user_id,role_id) values ("+uid+","+Integer.valueOf(roleId)+")");
			}
		}
		Db.batch(sqlList, 5);
		CacheClearUtils.clearUserMenuCache();
		return InvokeResult.success();
	};
	/**
	 * 密码修改
	 * @param uid
	 * @param newPwd
	 * @return
	 */
	public InvokeResult savePwdUpdate(Integer uid, String newPwd) {
		// TODO Auto-generated method stub
		SysUser sysUser=SysUser.me.findById(uid);
		if(sysUser!=null){
			sysUser.set("pwd", newPwd).update();
			return InvokeResult.success();
		}else{
			return InvokeResult.failure(-2, "修改失败");
		}
		
	}
	public Page<SysUser> getSysUserPage(int page, int rows, String keyword,String username,
			String orderbyStr) {
		Set<Condition> conditions=new HashSet<Condition>();
		List<Object> outConditionValues=new ArrayList<Object>();
		StringBuffer sqlExceptSelect=new StringBuffer();
		
		int userType = SysUserRole.dao.userOP(username);
		
		if(CommonUtils.isNotEmpty(keyword)){
			conditions.add(new Condition("name",Operators.LIKE,keyword));
		}
		if(userType == 2){
			SysUser user = SysUser.me.getByName(username);
			//Integer areaID = user.getWork_area_id();
			conditions.add(new Condition("work_area_id",Operators.LIKE,user.getWork_area_id()));
		}
		
		if(SysUserRole.dao.isOp(username)) {			
			sqlExceptSelect.append("from sys_user su"+super.getWhereSql(conditions, outConditionValues)+" ORDER BY su.createdate DESC");			
		}else {
			sqlExceptSelect.append("from sys_user su WHERE operation_class_id=(SELECT operation_class_id FROM sys_user WHERE `name`='"+username+"')"+super.getWhereSql(conditions, outConditionValues)+" ORDER BY su.createdate DESC");
			if(sqlExceptSelect.indexOf("where")!=-1) {
				int s=sqlExceptSelect.indexOf("where");
				sqlExceptSelect.replace(s, s+5, "AND");
			}
		}
		
		// String select="select su.*, (select group_concat(name) as roleNames from sys_role where id in(select role_id from sys_user_role where user_id=su.id)) as roleNames,(SELECT op_name FROM operation_class where su.operation_class_id=operation_class.id) AS op_name,(SELECT station_name FROM station WHERE station.id=su.station_id) AS station_name";
		String select="select su.*, (select group_concat(name) as roleNames from sys_role where id in(select role_id from sys_user_role where user_id=su.id)) as roleNames,(SELECT area FROM work_area where su.work_area_id=work_area.id) AS area,(SELECT op_name FROM operation_class where su.operation_class_id=operation_class.id) AS op_name";
		return this.paginate(page, rows, select, sqlExceptSelect.toString());
	}
	//根据用户名模糊查找
	/*public Page<SysUser> seachSysUserPage(int page, int rows, String keyword,
			String orderbyStr,String name) {
		StringBuffer sqlExceptSelect = null;
		String select="select su.*, (select group_concat(name) as roleNames from sys_role where id in(select role_id from sys_user_role where user_id=su.id)) as roleNames,(SELECT op_name FROM operation_class where su.operation_class_id=operation_class.id) AS op_name,(SELECT station_name FROM station WHERE station.id=su.station_id) AS station_name";
		if(SysUserRole.dao.isOp(keyword)) {
			sqlExceptSelect=new StringBuffer("from sys_user su where name like '%"+name+"%'");
		}
		else {
			sqlExceptSelect=new StringBuffer("from sys_user su WHERE operation_class_id=(SELECT operation_class_id FROM sys_user WHERE `name`="+keyword+") and `name` like '%"+name+"%'");
		}
		return this.paginate(page, rows, select, sqlExceptSelect.toString());
	}*/
	
	//通过用户名查找用户id
	public int getId(String name) {
		List<SysUser> sRecords = this.find("select id from sys_user where name='"+name+"'");
		int id=sRecords.get(0).getId();
		System.out.println(id+"This is ID!!!!!!!!!!!");
		return id;
	}
	//判断用户是否属于该运维班
	public SysUser getByOp(String name,int op_class){
		Set<Condition> conditions=new HashSet<Condition>();
		conditions.add(new Condition("name",Operators.EQ,name));
		conditions.add(new Condition("operation_class_id",Operators.EQ,op_class));
		return this.get(conditions);
	}
	
}
