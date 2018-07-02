/**
 * 
 */
package com.yanxin.common.controller;

import java.util.List;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.iot.mqtt.CmdLineParser;

/**
 * @author Cheng Guozhen
 * 
 */
public class GalleryQueryController extends Controller {
	
	public void index() {
		
		System.out.println("============GalleryQueryController=================");
//		render("NewFile.jsp");
		render("galleryquery.jsp");
	}

	public void getSensorCode() {
		
		//long roomid = getParaToLong("room");
		long building_id = getParaToLong("building_id");
		
		List<Record> records = Db.find("select sensor_code,status,name from sensor where building_id = ?", building_id);
		
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
	
	public void getImages() {
		
		String sensorCodeString = getPara("sensor_code");
		String createTimeString = getPara("create_time");
		String endTimeString = getPara("end_time");
		String sqlString = "SELECT DISTINCT building.building_name,images.url as url, temp.av_temp as av, temp.max_temp as max, temp.min_temp as min, images.id as id, images.create_time as create_time, images.im_sensor_code as im_sensor_code,sensor.name as sensor_name FROM images, temp, sensor,building WHERE building.id=sensor.building_id AND images.im_sensor_code = temp.temp_sensor_code AND images.create_time = temp.create_time AND images.im_sensor_code=sensor.sensor_code AND im_sensor_code = ? AND images.create_time> ? AND images.create_time< ? ORDER BY images.create_time DESC LIMIT 150";
		List<Record> imageList = Db.find(sqlString,sensorCodeString,createTimeString,endTimeString);
		setAttr("imageList", imageList);
		if(imageList != null && imageList.size() > 0){
			setAttr("result", true);
		}else{
			setAttr("result", false);
		}
		
		renderJson();
		
	}

}
