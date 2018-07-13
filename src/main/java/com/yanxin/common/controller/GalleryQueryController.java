/**
 * 
 */
package com.yanxin.common.controller;

import java.util.List;

import com.jcbase.core.controller.JCBaseController;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.model.Images;

/**
 * @author Cheng Guozhen
 * 
 */
public class GalleryQueryController extends JCBaseController {
	
	public void index() {
		
		System.out.println("============GalleryQueryController=================");
//		render("NewFile.jsp");
		render("galleryquery.jsp");
	}

	public void getSensorCode() {
		
		//long roomid = getParaToLong("room");
		long building_id = getParaToLong("building_id");
		
		List<Record> records = Db.find("select sensor_code,platform_point.platform_code,sensor.`name`,platform_point.point_type from platform_point,sensor where platform_point.pp_sensor_code=sensor.sensor_code AND building_id = ?", building_id);
		
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
	
/*	public void getImages() {
		String createTimeString = getPara("create_time");
		String endTimeString = getPara("end_time");
		String op_class=this.getPara("op_class");
		String station=this.getPara("station");
		String building=this.getPara("building");
		String sensor=this.getPara("sensor");
		String s[] = null;
		String sqlString=null;
		List<Record> imageList=null;
		//查询整个运维班的图片
		if(station.equals("0")) {
			sqlString = "SELECT DISTINCT building.building_name,images.url as url, temp.av_temp as av, temp.max_temp as max, temp.min_temp as min, images.id as id, images.create_time as create_time, images.im_sensor_code as im_sensor_code,sensor.name as sensor_name FROM images, temp, sensor,building,station,operation_class WHERE operation_class.id=station.op_id AND operation_class.id=? AND station.id=building.station_id AND building.id=sensor.building_id AND images.im_sensor_code = temp.temp_sensor_code AND images.create_time = temp.create_time AND images.im_sensor_code=sensor.sensor_code  AND images.create_time> ? AND images.create_time< ? ORDER BY images.create_time DESC LIMIT 150";
			imageList = Db.find(sqlString,op_class,createTimeString,endTimeString);
		}else {
			//查询整个变电站的图片
			if(building.equals("0")) {
				sqlString = "SELECT DISTINCT building.building_name,images.url as url, temp.av_temp as av, temp.max_temp as max, temp.min_temp as min, images.id as id, images.create_time as create_time, images.im_sensor_code as im_sensor_code,sensor.name as sensor_name FROM images, temp, sensor,building,station,operation_class WHERE operation_class.id=station.op_id AND station.id=building.station_id AND station.id=? AND building.id=sensor.building_id AND images.im_sensor_code = temp.temp_sensor_code AND images.create_time = temp.create_time AND images.im_sensor_code=sensor.sensor_code  AND images.create_time> ? AND images.create_time< ? ORDER BY images.create_time DESC LIMIT 150";
				imageList = Db.find(sqlString,station,createTimeString,endTimeString);
			}else {
				//查询整个设备间的图片
				if(sensor.equals("0")) {
					sqlString = "SELECT DISTINCT building.building_name,images.url as url, temp.av_temp as av, temp.max_temp as max, temp.min_temp as min, images.id as id, images.create_time as create_time, images.im_sensor_code as im_sensor_code,sensor.name as sensor_name FROM images, temp, sensor,building WHERE building.id=sensor.building_id AND building.id=? AND images.im_sensor_code = temp.temp_sensor_code AND images.create_time = temp.create_time AND images.im_sensor_code=sensor.sensor_code  AND images.create_time> ? AND images.create_time< ? ORDER BY images.create_time DESC LIMIT 150";
					imageList = Db.find(sqlString,building,createTimeString,endTimeString);
				}else {
					s=sensor.split("/");
					String sensorCodeString=s[0];
					String point_type=s[1];
					sqlString = "SELECT DISTINCT building.building_name,images.url as url, temp.av_temp as av, temp.max_temp as max, temp.min_temp as min, images.id as id, images.create_time as create_time, images.im_sensor_code as im_sensor_code,sensor.name as sensor_name FROM images, temp, sensor,building WHERE building.id=sensor.building_id AND images.im_sensor_code = temp.temp_sensor_code AND images.create_time = temp.create_time AND images.im_sensor_code=sensor.sensor_code AND im_sensor_code = ? AND images.point_type=temp.point_type AND images.point_type=?  AND images.create_time> ? AND images.create_time< ? ORDER BY images.create_time DESC LIMIT 150";
					imageList = Db.find(sqlString,sensorCodeString,point_type,createTimeString,endTimeString);	
				}
			}
		}	
		setAttr("imageList", imageList);
		if(imageList != null && imageList.size() > 0){
			setAttr("result", true);
		}else{
			setAttr("result", false);
		}
		renderJson();
		
	}*/
	
	public void getImages() {
		String createTimeString = getPara("create_time");
		String endTimeString = getPara("end_time");
		String op_class=this.getPara("op_class");
		String station=this.getPara("station");
		String building=this.getPara("building");
		String sensor=this.getPara("sensor");
		if(op_class.equals("0")) {
			op_class=null;
		}
		if(station.equals("0")) {
			station=null;
		}
		if(building.equals("0")) {
			building=null;
		}
		if(sensor.equals("0")) {
			sensor=null;
		}
		Page<Images> pageInfo=Images.me.getImagesPage(this.getPage(), this.getRows(),op_class,station,building,sensor,createTimeString,endTimeString,this.getOrderbyStr());
		setAttr("imageList", pageInfo.getList());
		if(pageInfo.getList() != null && pageInfo.getList().size()>0){
			setAttr("result", true);
		}else{
			setAttr("result", false);
		}
		renderJson();
	}
}
