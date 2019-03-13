package com.yanxin.common.mobil.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.jcbase.core.controller.JCBaseController;
import com.jcbase.core.util.JqGridModelUtils;
import com.jcbase.core.view.InvokeResult;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.model.Sensor;
import com.yanxin.common.model.Warn;

public class WarnListController extends JCBaseController {
	
	public void getListData() {
		String work_area_id = this.getPara("work_area_id");
		String op_class = this.getPara("op_class");
		String station = this.getPara("station");
		String building = this.getPara("building");
		int sensor = 0;
		String status = this.getPara("status");
		String order = this.getPara("order");
		
		if(work_area_id==null || work_area_id=="" || work_area_id.equals("0")) {
			work_area_id = null;
		}
		if(work_area_id==null){
			this.renderJson(InvokeResult.failure("参数错误"));
			return;
		}
		if(op_class==null || op_class=="" || op_class.equals("0")) {
			op_class = null;
		}

		
		if(station==null || station=="" ||station.equals("0")) {
			station = null;
		}
		if(building==null || building=="" || building.equals("0")) {
			building = null;
		}
		if(this.getPara("sensor")==null || this.getPara("sensor")=="" || this.getPara("sensor").equals("0")) {
			sensor = 0;
		}else {
			sensor = this.getParaToInt("sensor");
		}
		if(status==null || status=="") {
			status = "2";
		}
		if(order==null || order=="") {
			order = "1";
		}
		
		Page<Warn> pageInfo = Warn.me.getWarnPageMobile2(this.getPage(), this.getRows(), work_area_id,op_class, station, building, sensor,Integer.parseInt(status),order,
				this.getOrderbyStr());
		long nonconfirm =  Warn.me.getWarnNonConfirm(op_class, station, building, sensor,0);
		this.renderJson(InvokeResult.success(JqGridModelUtils.toJqGridView(pageInfo, nonconfirm)));
	}
	
	public void lookWord() throws JsonParseException, JsonMappingException, IOException {
		if(this.getPara("id")==null){
			this.renderJson(InvokeResult.failure("参数错误"));
			return;
		}
		Integer id = this.getParaToInt("id");
		Record rr = null;
		if (id != null) {
			String sqlString = "SELECT IFNULL(warn.confirm_time,'') AS confirm_time,warn.cancel,IFNULL(warn.confirm_user,'') AS confirm_user"
					+ ",warn.create_time,IFNULL(warn.humidity,'') AS humidity,warn.id,warn.max_temp,warn.point_type,IFNULL(warn.reason,'') AS reason,IFNULL(warn.remark,'') AS remark,warn.sensor_code,warn.`status`,"
					+ "IFNULL(warn.suggestion,'') AS suggestion,IFNULL(warn.weather,'') AS weather,IFNULL(warn.weather_temp,'') AS weather_temp,IFNULL(warn.wind,'') AS wind,temp.min_temp, IFNULL(warn.image_num,'') AS image_num, IFNULL(warn.audit,'') AS audit, "
					+ "IFNULL(warn.allow,'') AS allow, IFNULL(warn.detector,'') AS detector, IFNULL(warn.current,'') AS current, IFNULL(warn.voltage,'') AS voltage, station.station_name,building.building_name,platform_point.platform_code,platform_point.warn_temp,platform_point.user_name,sensor.name,IFNULL(sensor.sensor_model,'') AS sensor_model,sensor.emittance,sensor.distance,sensor.create_time sensor_maintence_time,IFNULL(sensor.update_time ,NOW()) AS sensor_create_time FROM temp,warn,sensor,station,platform_point,building WHERE warn.sensor_code=temp.temp_sensor_code AND warn.sensor_code = sensor.sensor_code AND platform_point.pp_sensor_code = sensor.sensor_code AND platform_point.point_type = warn.point_type AND sensor.building_id = building.id AND building.station_id = station.id AND temp.point_type=warn.point_type AND warn.create_time=temp.create_time AND warn.id=?";
			String sqlString2 = "SELECT images.url,images.color_bar from warn,images WHERE warn.sensor_code=images.im_sensor_code AND warn.create_time=images.create_time AND warn.id = ? order by images.color_bar ASC";
			
			rr = Db.findFirst(sqlString, id);
			
			List<Record> urls = Db.find(sqlString2,id);
			
			if(urls!=null && urls.size()>0){
				rr.set("urls", urls.toArray(new Record[0]));
			}
		}
		if(rr!=null){
			this.renderJson(InvokeResult.success(rr));
		}else {
			this.renderJson(InvokeResult.failure("可能出错了！"));
		}
	}
	public void setThreshold(){
		String sensor_code = this.getPara("sensor_code");
		String point_type = this.getPara("point_type");
		String temp = this.getPara("warn_temp");
		String username = this.getPara("user_name");
		if(temp==null){
			this.renderJson(InvokeResult.failure("参数错误"));
			return;
		}
		int threshold = Integer.parseInt(temp);
		Db.update("UPDATE platform_point SET warn_temp=?,user_name=? WHERE pp_sensor_code=? AND point_type=?", threshold,username,sensor_code,point_type);
		this.renderJson(InvokeResult.success("处理成功"));
	}
	
	
	public void saveSuggestion(){
		if(this.getPara("id")==null){
			this.renderJson(InvokeResult.failure("参数错误"));
			return;
		}
		String reason = this.getPara("reason")==null?"":this.getPara("reason");
		String suggestion = this.getPara("suggestion")==null?"":this.getPara("reason");
		String remark = this.getPara("remark")==null?"":this.getPara("reason");
		String sensor_model= this.getPara("sensor_model")==null?"":this.getPara("sensor_model"); //仪器型号
		String current= this.getPara("current")==null?"":this.getPara("current"); //电流
		String voltage= this.getPara("voltage")==null?"":this.getPara("voltage"); //电压
		String image_num= this.getPara("image_num")==null?"":this.getPara("image_num"); //图像编号
		String detector= this.getPara("detector")==null?"":this.getPara("detector"); //检测员
		String allow = this.getPara("allow")==null?"":this.getPara("allow");  //批准人
		String audit= this.getPara("audit")==null?"":this.getPara("audit");  //审核

		Integer id = this.getParaToInt("id");
		
		if (id != null) {
			Warn warn = Warn.me.findById(id);
			
			warn.set("status", 1)
				.set("current", current)
				.set("voltage", voltage)
				.set("image_num", image_num)
				.set("detector", detector)
				.set("allow", allow)
				.set("audit", audit)
				.set("reason", reason)
				.set("suggestion", suggestion)
				.set("remark", remark).update();
			
			Db.update("UPDATE sensor SET sensor_model=? WHERE sensor.sensor_code=?", sensor_model,warn.getSensorCode());
			/*Sensor sensor = Sensor.me.findFirst("select * from sensor where sensor.sensor_code=?",warn.getSensorCode());
			if(sensor!=null){
				sensor.set("sensor_model",sensor_model).update();
			}*/
			
			this.renderJson(InvokeResult.success("处理成功"));
		}else{
			this.renderJson(InvokeResult.failure("处理失败"));
		}
	}
	
	// 消除告警
	public void setVisible() {
		Integer visible = this.getParaToInt("visible");
		String bids = this.getPara("ids");
		String userName = this.getPara("username");
		String payload = this.getPara("payload");
		Date dd = new Date();
		// SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd  HH:mm:ss");
		InvokeResult result = Warn.me.setVisibleWithName(bids, payload,visible,userName,dd);
		this.renderJson(result);
	}
	
	public void deleteWarn() {
		
		String id = this.getPara("id");
		if(id==null){
			this.renderJson(InvokeResult.failure("参数有误"));
			return;
		}
		InvokeResult invokeResult = Warn.me.deleteData(id);
		this.renderJson(invokeResult);
	}

}
