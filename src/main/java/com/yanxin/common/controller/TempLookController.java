/**
 * 
 */
package com.yanxin.common.controller;

import java.util.List;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.controller.SensorDataController.Data;
import com.yanxin.common.model.Temp;

/**
 * @author Cheng Guozhen
 * 
 */
public class TempLookController extends Controller {
	
	public void index() {
		
		render("temp_look.jsp");
	}

	public void getImages() {
		String op_class=this.getPara("op_class");
		String station=this.getPara("station");
		String building=this.getPara("building");
		String s[] = null;
		String sqlString=null;
		List<Record> imageList=null;
		//查询整个运维班的图片
		if(station.equals("0")) {
            sqlString="select su.*,sensor.`name`,station.station_name, (select temp.max_temp from temp where temp.point_type=su.point_type AND temp.temp_sensor_code=su.pp_sensor_code ORDER BY temp.create_time DESC LIMIT 1) as maxTemp FROM platform_point su,sensor,building,station,operation_class WHERE operation_class.id=station.op_id AND operation_class.id=? AND station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=su.pp_sensor_code";
			imageList = Db.find(sqlString,op_class);
		}else {
			//查询整个变电站的图片
			if(building.equals("0")) {
                sqlString="select su.*,sensor.`name`,station.station_name, (select temp.max_temp from temp where temp.point_type=su.point_type AND temp.temp_sensor_code=su.pp_sensor_code ORDER BY temp.create_time DESC LIMIT 1) as maxTemp FROM platform_point su,sensor,building,station,operation_class WHERE operation_class.id=station.op_id AND station.id=building.station_id AND station.id=? AND building.id=sensor.building_id AND sensor.sensor_code=su.pp_sensor_code";
				imageList = Db.find(sqlString,station);
			}else {
				sqlString="select su.*,sensor.`name`,station.station_name, (select temp.max_temp from temp where temp.point_type=su.point_type AND temp.temp_sensor_code=su.pp_sensor_code ORDER BY temp.create_time DESC LIMIT 1) as maxTemp FROM platform_point su,sensor,building,station,operation_class WHERE operation_class.id=station.op_id AND station.id=building.station_id AND building.id=sensor.building_id AND building.id=? AND sensor.sensor_code=su.pp_sensor_code";
				imageList = Db.find(sqlString,building);
			}
		}	
		setAttr("imageList", imageList);
		if(imageList != null && imageList.size() > 0){
			setAttr("result", true);
		}else{
			setAttr("result", false);
		}
		renderJson();
		
	}

}
