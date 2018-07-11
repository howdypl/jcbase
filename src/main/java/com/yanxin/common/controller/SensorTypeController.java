/**
 * 
 */
package com.yanxin.common.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.model.SensorType;

/**
 * @author Cheng Guozhen
 * 
 */
public class SensorTypeController extends Controller {
	
	public void index() {
		String sqlString = "select * from sensor_type";
		
		List<Record> sensorTypeList = new ArrayList<Record>();
		
		sensorTypeList = Db.find(sqlString);
				
		setAttr("sensorTypeList", sensorTypeList);
		render("sensortypelist.jsp");
	}
	
	public void isExisting() {
		String sensorTypeString = getPara("sensortype");
		String sqlString = "select * from sensor_type where type_name=?";
		
		List<Record> sensorType = Db.find(sqlString,sensorTypeString);
		if(!sensorType.isEmpty()){
			setAttr("hasExisting", 1);
		}else{
			setAttr("hasExisting", 0);
		}
		renderJson();
	}
	
	public void addItem() {
		String sensorTypeString = getPara("sensortype");
		
		SensorType sType = new SensorType();
		sType.setTypeName(sensorTypeString);
		sType.setCreateTime(new Date());
		
		boolean result = Db.save("sensor_type", sType.toRecord());
		
		setAttr("result", result);
		this.redirect("/sensortype",false);
	}
	
	public void deleteSensorType(){
		int id = getParaToInt("sensorTypeId");
		
		boolean result = Db.deleteById("sensor_type", id);
		
		setAttr("result",result);
		renderJson();
		
	}

}
