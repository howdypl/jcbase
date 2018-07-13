/**
 * 
 */
package com.yanxin.common.controller;

import java.util.List;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;


/**
 * @author Cheng Guozhen
 * 
 */
public class CommandController extends Controller {
	
	public void index() {
		
		render("command.jsp");
	}

	public void getSensorCode() {
		
		long roomid = getParaToLong("room");
		long sensor_type = getParaToLong("sensor_type");
		
		List<Record> records = Db.find("select sensor_code,status from sensor where affiliation=4 and owner_id=? and type_id = ?", roomid,sensor_type);
		
		if (records != null && !records.isEmpty()) {
			setAttr("records", records);
			setAttr("result", true);
			renderJson();
		}else {
			setAttr("result", false);
			renderJson();
		}
		
	}
	
	public void getSensorType() {
		
		// String sqlString = "select * from sensor_type where id<>11 and id <>10";
		String sqlString = "select * from sensor_type";
		List<Record> sensorTypeList = Db.find(sqlString);
		setAttr("sensorTypeList", sensorTypeList);
		renderJson();
	}
	
	public void getSensorStatus() {
		
		String sensor_code = getPara("sensor_code");
		
		Record record = Db.findById("sensor", "sensor_code", sensor_code);
		
		setAttr("record", record);
		
		renderJson();
		
	}
	
	
	
	public void installCmd1() {
		
		String sensorCodeString = getPara("sensor_code");
		long sensorType = getParaToLong("type");
		long status = getParaToLong("status");
		
		int result = Db.update("update sensor set status=? where sensor_code =?", status,sensorCodeString);
		
		// command(sensorCodeString, sensorType, 0, status);
		
		if(result > 0){
			
			setAttr("result", true);
			
		}else{
			setAttr("result", false);
		}
		
		renderJson();
		
	}
	
}
