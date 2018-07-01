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
public class GalleryController extends Controller {
	
	public void index() {
		String sqlString2 = "SELECT images.id as id, images.url as url, images.create_time as create_time,sensor.name as sensor_name, building.building_name as building_name,station.station_name as station_name, operation_class.op_name as op_name FROM images, sensor,building,station,operation_class where images.im_sensor_code = sensor.sensor_code AND sensor.building_id=building.id AND station.id = building.station_id AND station.op_id=operation_class.id ORDER BY images.create_time DESC LIMIT 100";
		List<Record> imageList = Db.find(sqlString2);
		setAttr("imageList", imageList);
		
		render("gallery.jsp");
	}

}
