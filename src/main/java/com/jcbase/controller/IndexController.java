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

import java.util.Date;
import java.util.List;

import org.apache.commons.codec.binary.Base64;

import com.jcbase.core.auth.anno.RequiresPermissions;
import com.jcbase.core.auth.interceptor.AuthorityInterceptor;
import com.jcbase.core.auth.interceptor.SysLogInterceptor;
import com.jcbase.core.util.DateUtils;
import com.jcbase.core.util.IWebUtils;
import com.jcbase.core.util.MD5Utils;
import com.jcbase.core.util.MyDigestUtils;
import com.jcbase.core.view.InvokeResult;
import com.jcbase.model.SysLoginRecord;
import com.jcbase.model.SysUser;
import com.jcbase.model.SysUserRole;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.oreilly.servlet.Base64Encoder;
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
	//检测温度进行预警
	public void getTemp() {
		String sqlString = "select max_temp, create_time from temp where max_temp>58 and status = 0";	
//		System.out.println(sqlString+"****************************");
		List<Record> resultList = Db.find(sqlString);
		if(!resultList.isEmpty()){
			setAttr("notempty", true);
			setAttr("oplist", resultList);
		}else{
			setAttr("notempty", false);
		}
		renderJson();
	}
	//超温警告提示100秒后不再提示
	public void setTempStatus() {
//		String sqlString = "update temp set status=1 where max_temp >60";	
//		System.out.println(sqlString+"****************************");
		int b=Db.update("update temp set status=? where max_temp >?",1,58);
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
		String imageCode=this.getPara("imageCode");
		if(StrKit.notBlank(imageCode)){
			String imageCodeSession=(String)this.getSessionAttr("imageCode");
			if(!imageCodeSession.toLowerCase().equals(imageCode.trim().toLowerCase())){
				this.renderJson(InvokeResult.failure("验证码输入有误"));
				return;
			}
		}else{
			this.renderJson(InvokeResult.failure("请输入验证码"));
			return;
		}
		SysUser sysUser=SysUser.me.getByName(this.getPara("username"));
		if(sysUser==null){
			this.renderJson(InvokeResult.failure("用户不存在"));
			return;
		}
		//判断用户是否属于该运维班
		SysUser sysUser_op=SysUser.me.getByOp(this.getPara("username"),this.getParaToInt("op_class"));
		if(sysUser_op==null){
			this.renderJson(InvokeResult.failure("用户与运维班不匹配"));
			return;
		}
		
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
		Integer autoLogin=this.getParaToInt("autoLogin",0);
		IWebUtils.setCurrentLoginSysUser(this.getResponse(),this.getSession(),sysUser,autoLogin);
		SysLoginRecord.dao.saveSysLoginRecord(sysUser.getId(),1);
		this.renderJson(InvokeResult.success());
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





