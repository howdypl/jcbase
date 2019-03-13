package com.yanxin.common.controller;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

public class ExportExcelService {

	public List<Record> getList(String createTimeString, String endTimeString, String sensorCodeString, String point_type){
		
		
		String sqlString = "SELECT temp.*,CONCAT(sensor.`name`,platform_code) as sensorName,building.building_name,station.station_name,operation_class.op_name FROM temp,platform_point,sensor,building,station,operation_class WHERE temp.temp_sensor_code=sensor.sensor_code AND sensor.sensor_code=platform_point.pp_sensor_code AND temp.point_type=platform_point.point_type AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id AND temp_sensor_code = ? AND temp.point_type= ? AND temp.create_time>? AND temp.create_time<? ORDER BY temp.create_time ASC";
		
		List<Record> dataList = Db.find(sqlString,sensorCodeString,point_type,createTimeString,endTimeString);
		
		return dataList;
	}
	
}
