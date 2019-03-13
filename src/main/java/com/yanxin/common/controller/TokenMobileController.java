/**
 * 
 */
package com.yanxin.common.controller;

import java.util.List;

import com.jcbase.core.controller.JCBaseController;
import com.jcbase.core.util.IWebUtils;
import com.jcbase.core.view.InvokeResult;
import com.jcbase.model.HwPushStationYwb;
import com.jcbase.model.SysUser;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.iot.json2.BaseCallBackBean;

/**
 * @author Guozhen Cheng
 *
 */
public class TokenMobileController extends JCBaseController {
	
	/**
	 * old 保存token
	 */
	public void saveToken(){
		String token = getPara("token");
		String username = getPara("username");
		//BaseCallBackBean<Integer> result = new BaseCallBackBean<Integer>();
		if(token == null  ||  token.equals("")){
			this.renderJson(InvokeResult.failure("无效的参数"));
			
			return;
		}
		if(username==null){
			this.renderJson(InvokeResult.failure("无效的参数"));
			return;
		}
		SysUser user = SysUser.me.getByName(username);
		
		//SysUser user = IWebUtils.getCurrentSysUser(this.getRequest());
		
		
		
		//判断屏蔽设置是否已在,否则初始化为全部接收告警
		// initShieldStaton(ywb,token);
		
		System.out.println("手机token注册:"+token);
		String sql = "delete from push_token where token = ?";
		Db.update(sql, token);
		
		Record r = new Record().set("token", token).set("auth",1).set("ywb",user.getOperation_class_id()).set("area", user.getWork_area_id());
		
		Db.save("push_token", "id", r);
		
		this.renderJson(InvokeResult.success());
		return;
	}
	
	/**
	 * 初始化屏蔽变电站记录
	 */
	private void initShieldStaton(int area,int ywb,String token){
		
		/*Record rr = (Record)this.getSession().getAttribute("currentuser");
		String username = "";
		if(this.getSession().getAttribute("currentuser")!= null){
			username = rr.getStr("username");
		}*/
		SysUser user = IWebUtils.getCurrentSysUser(this.getRequest());
		
		String username = "";
		if(null!= user){
			username = user.getName();// user.me.getName();
		}
		
		/*if(user.getUserType()>0){
			
		}*/
		
		
		List<HwPushStationYwb> stationList = HwPushStationYwb.dao.find("select * from hw_push_station_ywb where ywb = ?", ywb);
		if(stationList == null || stationList.isEmpty()){
			//String time = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss").format(new Date());
			String sql = "select op_id ywb,id station_id,station_name,1 auth,'"+username+"' username,'"+token+"' token, now() create_time from station where station.op_id=?";
			
			List<Record> records = Db.find(sql, ywb);
			if(records != null && !records.isEmpty()){
				Db.batchSave("hw_push_station_ywb", records, 30);
				Db.batchSave("config_push_log", records, 30);
			}
		}
		return;
	}
	
	
	/**
	 * 初始化屏蔽变电站记录
	 */
	private void initShieldStaton(int ywb,String token){
		
		/*Record rr = (Record)this.getSession().getAttribute("currentuser");
		String username = "";
		if(this.getSession().getAttribute("currentuser")!= null){
			username = rr.getStr("username");
		}*/
		SysUser user = IWebUtils.getCurrentSysUser(this.getRequest());
		
		String username = "";
		if(null!= user){
			username = user.getName();// user.me.getName();
		}
		
		List<HwPushStationYwb> stationList = HwPushStationYwb.dao.find("select * from hw_push_station_ywb where ywb = ?", ywb);
		if(stationList == null || stationList.isEmpty()){
			//String time = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss").format(new Date());
			String sql = "select op_id ywb,id station_id,station_name,1 auth,'"+username+"' username,'"+token+"' token, now() create_time from station where station.op_id=?";
			
			List<Record> records = Db.find(sql, ywb);
			if(records != null && !records.isEmpty()){
				Db.batchSave("hw_push_station_ywb", records, 30);
				Db.batchSave("config_push_log", records, 30);
			}
		}
		return;
	}
	

}
