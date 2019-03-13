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
package com.jcbase.controller;

import java.util.List;

import com.jcbase.core.auth.anno.RequiresPermissions;
import com.jcbase.core.auth.interceptor.AuthorityInterceptor;
import com.jcbase.core.auth.interceptor.SysLogInterceptor;
import com.jcbase.core.util.IWebUtils;
import com.jcbase.core.util.MyDigestUtils;
import com.jcbase.core.view.InvokeResult;
import com.jcbase.model.SysLoginRecord;
import com.jcbase.model.SysUser;
import com.jcbase.model.SysUserRole;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.model.OperationClass;
import com.yanxin.common.model.WorkArea;

/**
 * 首页、登陆、登出
 * @author eason
 */
@Clear(SysLogInterceptor.class)
@RequiresPermissions(value={"/"})
public class IndexController extends Controller {
	
	public void index() {
		render("index.jsp");
	}
	
	public void home() {
		render("home.jsp");
	}
	
	//检测温度进行预警,从告警表里获取
	public void getTemp2() {
		String sqlString=null;
		String userName=this.getPara("username");
		
		// SysUser user = SysUser.me.getUserOP(userName);
		if(SysUserRole.dao.isOp(userName)){
			sqlString = "select platform_point.*,warn.id warnID,warn.create_time,warn.max_temp,operation_class.op_name,station.station_name,building.building_name,sensor.`name` from platform_point,warn,station,operation_class,building,sensor where operation_class.id=station.op_id AND station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND warn.point_type=platform_point.point_type AND warn.sensor_code=platform_point.pp_sensor_code AND warn.status = 0 order by warn.create_time desc";
		}else{
			sqlString = "select platform_point.*,warn.id warnID,warn.create_time,warn.max_temp,operation_class.op_name,station.station_name,building.building_name,sensor.`name` from platform_point,warn,station,operation_class,building,sensor where operation_class.id=station.op_id AND station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND warn.point_type=platform_point.point_type AND warn.sensor_code=platform_point.pp_sensor_code AND warn.status = 0 AND operation_class.id=(SELECT operation_class_id FROM sys_user WHERE sys_user.`name`='"+userName+"') order by warn.create_time desc";
		}
		//System.out.println(sqlString+"****************************");
		List<Record> resultList = Db.find(sqlString);
		if(!resultList.isEmpty()){
			setAttr("notempty", true);
			setAttr("resultList", resultList);
		}else{
			setAttr("notempty", false);
		}
		renderJson();
	}
	
	//检测温度进行预警
	public void getTemp() {
		String sqlString=null;
		String userName=this.getPara("username");
		if(SysUserRole.dao.isOp(userName)){
			sqlString = "select platform_point.*,temp.max_temp,operation_class.op_name,station.station_name,building.building_name,sensor.`name` from platform_point,temp,station,operation_class,building,sensor where operation_class.id=station.op_id AND station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND temp.point_type=platform_point.point_type AND temp.temp_sensor_code=platform_point.pp_sensor_code AND temp.max_temp>platform_point.warn_temp AND temp.status = 0 order by temp.create_time desc";
		}else{
			sqlString = "select platform_point.*,temp.max_temp,operation_class.op_name,station.station_name,building.building_name,sensor.`name` from platform_point,temp,station,operation_class,building,sensor where operation_class.id=station.op_id AND station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND temp.point_type=platform_point.point_type AND temp.temp_sensor_code=platform_point.pp_sensor_code AND temp.max_temp>platform_point.warn_temp AND temp.status = 0 AND operation_class.id=(SELECT operation_class_id FROM sys_user WHERE sys_user.`name`='"+userName+"') order by temp.create_time desc";
		}
		//System.out.println(sqlString+"****************************");
		List<Record> resultList = Db.find(sqlString);
		if(!resultList.isEmpty()){
			setAttr("notempty", true);
			setAttr("resultList", resultList);
		}else{
			setAttr("notempty", false);
		}
		renderJson();
	}
	//超温警告提示100秒后不再提示
	public void setTempStatus2() {
		String userName=this.getPara("username");
		int warnID = this.getParaToInt("warnID");
		String create_time = this.getPara("create_time");
		String sensor_code = this.getPara("sensor_code");
		String sqlString = "UPDATE warn SET warn.`status`=1 where warn.id=?";
		String tempSql =  "UPDATE temp SET temp.`status`=1 where temp_sensor_code=? AND create_time=?";
		/*if(SysUserRole.dao.isOp(userName)){
			sqlString = "UPDATE warn,platform_point SET warn.`status`=1 where warn.point_type=platform_point.point_type AND warn.sensor_code=platform_point.pp_sensor_code AND temp.max_temp>platform_point.warn_temp AND temp.status = 0";
		}else{
			sqlString = "UPDATE platform_point,warn,station,operation_class,building,sensor SET warn.`status`=1 WHERE operation_class.id=station.op_id AND station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND warn.point_type=platform_point.point_type AND warn.sensor_code=platform_point.pp_sensor_code AND warn.status = 0 AND operation_class.id=(SELECT operation_class_id FROM sys_user WHERE sys_user.`name`='"+userName+"')";
		}*/
		int b=Db.update(sqlString,warnID);
		if(create_time!=null && sensor_code!=null){
			Db.update(tempSql,sensor_code,create_time);
		}
		
		if(b!=0){
			setAttr("notempty", true);
		}else{
			setAttr("notempty", false);
		}
		renderJson();
	}
	
	//超温警告提示100秒后不再提示
	public void setTempCancel() {
		String userName=this.getPara("username");
		int warnID = this.getParaToInt("warnID");
		String create_time = this.getPara("create_time");
		String sensor_code = this.getPara("sensor_code");
		String sqlString = "UPDATE warn SET warn.cancel=1 where warn.id=?";
		String tempSql =  "UPDATE temp SET temp.cancel=1 where temp_sensor_code=? AND create_time=?";
		/*if(SysUserRole.dao.isOp(userName)){
			sqlString = "UPDATE warn,platform_point SET warn.`status`=1 where warn.point_type=platform_point.point_type AND warn.sensor_code=platform_point.pp_sensor_code AND temp.max_temp>platform_point.warn_temp AND temp.status = 0";
		}else{
			sqlString = "UPDATE platform_point,warn,station,operation_class,building,sensor SET warn.`status`=1 WHERE operation_class.id=station.op_id AND station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND warn.point_type=platform_point.point_type AND warn.sensor_code=platform_point.pp_sensor_code AND warn.status = 0 AND operation_class.id=(SELECT operation_class_id FROM sys_user WHERE sys_user.`name`='"+userName+"')";
		}*/
		int b=Db.update(sqlString,warnID);
		if(create_time!=null && sensor_code!=null){
			Db.update(tempSql,sensor_code,create_time);
		}
		
		if(b!=0){
			setAttr("notempty", true);
		}else{
			setAttr("notempty", false);
		}
		renderJson();
	}
	
	public void setTempCancelv2() {
		String userName=this.getPara("username");
		int warnID = this.getParaToInt("warnID");
		String create_time = this.getPara("create_time");
		String sensor_code = this.getPara("sensor_code");
		String sqlString = "UPDATE warn SET warn.cancel=1 where warn.id=?";
		String tempSql =  "UPDATE temp SET temp.cancel=1 where temp_sensor_code=? AND create_time=?";
		/*if(SysUserRole.dao.isOp(userName)){
			sqlString = "UPDATE warn,platform_point SET warn.`status`=1 where warn.point_type=platform_point.point_type AND warn.sensor_code=platform_point.pp_sensor_code AND temp.max_temp>platform_point.warn_temp AND temp.status = 0";
		}else{
			sqlString = "UPDATE platform_point,warn,station,operation_class,building,sensor SET warn.`status`=1 WHERE operation_class.id=station.op_id AND station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND warn.point_type=platform_point.point_type AND warn.sensor_code=platform_point.pp_sensor_code AND warn.status = 0 AND operation_class.id=(SELECT operation_class_id FROM sys_user WHERE sys_user.`name`='"+userName+"')";
		}*/
		int b=Db.update(sqlString,warnID);
		if((create_time!=null&&create_time!="") && (sensor_code!=null&&sensor_code!="")){
			Db.update(tempSql,sensor_code,create_time);
		}
		
		if(b!=0){
			this.renderJson(InvokeResult.success());
		}else{
			this.renderJson(InvokeResult.failure("失败"));
		}
	}
	
	//超温警告提示100秒后不再提示
	public void setTempStatus() {
		String sqlString=null;
		String userName=this.getPara("username");
		if(SysUserRole.dao.isOp(userName)){
			sqlString = "UPDATE temp,platform_point SET temp.`status`=1 where temp.point_type=platform_point.point_type AND temp.temp_sensor_code=platform_point.pp_sensor_code AND temp.max_temp>platform_point.warn_temp AND temp.status = 0";
		}else{
			sqlString = "UPDATE platform_point,temp,station,operation_class,building,sensor SET temp.`status`=1 WHERE operation_class.id=station.op_id AND station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND temp.point_type=platform_point.point_type AND temp.temp_sensor_code=platform_point.pp_sensor_code AND temp.max_temp>platform_point.warn_temp AND temp.status = 0 AND operation_class.id=(SELECT operation_class_id FROM sys_user WHERE sys_user.`name`='"+userName+"')";
		}
		int b=Db.update(sqlString);
		if(b!=0){
			setAttr("notempty", true);
		}else{
			setAttr("notempty", false);
		}
		renderJson();
	}

	@Clear(AuthorityInterceptor.class)
	public void login() {
		this.setAttr("url", this.getPara("url"));
		render("login.jsp");
	}
	@Clear(AuthorityInterceptor.class)
	public void dologin() {
		
		SysUser sysUser=null;
		
		/*String imageCode=this.getPara("imageCode");
		if(StrKit.notBlank(imageCode)){
			String imageCodeSession=(String)this.getSessionAttr("imageCode");
			if(!imageCodeSession.toLowerCase().equals(imageCode.trim().toLowerCase())){
				this.renderJson(InvokeResult.failure("验证码输入有误"));
				return;
			}
		}else{
			this.renderJson(InvokeResult.failure("请输入验证码"));
			return;
		}*/
		String ss = this.getPara("username");
		//String ss = this.getPara("username");
		System.out.println(ss+"*********************");
		sysUser=SysUser.me.getByName(this.getPara("username"));
		
		if(sysUser==null){
			//sysUser=SysUser.me.getByPhone(this.getPara("username"));
			   // if(sysUser==null){
			    	this.renderJson(InvokeResult.failure("用户不存在"));
					return;
			  //  }
		}
		//判断用户是否属于该运维班
		/*SysUser sysUser_op=SysUser.me.getByOp(this.getPara("username"),this.getParaToInt("op_class"));
		if(sysUser_op==null){
			this.renderJson(InvokeResult.failure("用户与运维班不匹配"));
			return;
		}*/
		
		if(SysLoginRecord.dao.hasOverLoginErrTimes(sysUser.getId())){
			this.renderJson(InvokeResult.failure("今天连续输入密码错误次数超过5次"));
			return;
		}
		if(!sysUser.getPwd().equals(MyDigestUtils.shaDigestForPasswrod(this.getPara("password")))){
			SysLoginRecord.dao.saveSysLoginRecord(sysUser.getId(),0);
			this.renderJson(InvokeResult.failure("用户密码输入有误"));
			return;
		}
		if(sysUser.getInt("status")==2){
			this.renderJson(InvokeResult.failure("用户被冻结，请联系管理员"));
			return;
		}
		Record rr = sysUser.toRecord();
		if(sysUser.getUserType() > 0){
			WorkArea wa = WorkArea.me.findById(sysUser.getWork_area_id());
			
			rr.set("area_name", wa.getArea());
			
			if(sysUser.getUserType() == 2){
				OperationClass op = OperationClass.me.findById(sysUser.getOperation_class_id());
				rr.set("op_name", op.getOpName());
			}else {
				rr.set("op_name","");
			}
		}
		
		Integer autoLogin=this.getParaToInt("autoLogin",0);
		IWebUtils.setCurrentLoginSysUser(this.getResponse(),this.getSession(),sysUser,autoLogin);
		SysLoginRecord.dao.saveSysLoginRecord(sysUser.getId(),1);
		this.renderJson(InvokeResult.success(rr));
	}
	
	public void loginOut() {
		IWebUtils.removeCurrentSysUser(getRequest(), getResponse());
		this.redirect("/login");
	}
	
	public void pwdSetting(){
		try {
			SysUser sysUser = IWebUtils.getCurrentSysUser(getRequest());
			this.setAttr("sysUser", sysUser);
			render("sys/pwd_setting.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	public void savePwdUpdate(){
		String oldPwd=MyDigestUtils.shaDigestForPasswrod(getPara("oldPwd"));
		String newPwd=MyDigestUtils.shaDigestForPasswrod(getPara("newPwd"));
		String pwdRepeat=MyDigestUtils.shaDigestForPasswrod(getPara("pwdRepeat"));
		try {
			SysUser sysUser = IWebUtils.getCurrentSysUser(getRequest());
			if(!sysUser.get("pwd").equals(oldPwd)){
				this.renderJson(InvokeResult.failure(-3, "旧密码不正确"));
			}else{
				if(newPwd.equals(pwdRepeat)){
					InvokeResult result=SysUser.me.savePwdUpdate(sysUser.getInt("id"), newPwd);
					this.renderJson(result);
				}else{ 
					this.renderJson(InvokeResult.failure(-1, "两次密码不一致"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}





