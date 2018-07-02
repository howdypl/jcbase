/**
 * 
 */
package com.yanxin.common.controller;

import java.util.ArrayList;
import java.util.List;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

/**
 * @author Cheng Guozhen
 * 
 */
public class AlertInfoController extends Controller {
	
	public void index() {
		// TODO Auto-generated method stub
		String sqlString = "SELECT operation_class.op_name, station.station_name,NULL building_name, NULL layer_name, NULL room_name,sensor_type.type_name,alert_type.alert_type, alert.alert_obj_code,alert.`desc`,alert.`status`,alert.create_time FROM alert,alert_type,operation_class, station,sensor,sensor_type WHERE alert.type_id=alert_type.id AND alert.alert_obj_code = sensor.sensor_code AND sensor.type_id=sensor_type.id AND sensor.affiliation=1 AND sensor.owner_id=station.id AND station.op_id=operation_class.id "
				+ " UNION ALL "
				+ "SELECT operation_class.op_name, station.station_name, building.building_name, NULL layer_name, NULL room_name,sensor_type.type_name,alert_type.alert_type, alert.alert_obj_code,alert.`desc`,alert.`status`,alert.create_time FROM alert,alert_type,operation_class, station,building,sensor,sensor_type WHERE alert.type_id=alert_type.id AND alert.alert_obj_code = sensor.sensor_code AND sensor.type_id=sensor_type.id AND sensor.affiliation=2 AND sensor.owner_id=building.id AND station.id=building.station_id AND station.op_id=operation_class.id "
				+ " UNION ALL "
				+ "SELECT operation_class.op_name, station.station_name, building.building_name, layer.layer_name, NULL room_name,sensor_type.type_name,alert_type.alert_type, alert.alert_obj_code,alert.`desc`,alert.`status`,alert.create_time FROM alert,alert_type,operation_class, station,building,layer,sensor,sensor_type WHERE alert.type_id=alert_type.id AND alert.alert_obj_code = sensor.sensor_code AND sensor.type_id=sensor_type.id AND sensor.affiliation=3 AND sensor.owner_id=layer.id AND building.id=layer.building_id AND station.id=building.station_id AND station.op_id=operation_class.id "
				+ " UNION ALL "
				+ "SELECT operation_class.op_name, station.station_name, building.building_name, layer.layer_name, room.room_name,sensor_type.type_name,alert_type.alert_type, alert.alert_obj_code,alert.`desc`,alert.`status`,alert.create_time FROM alert,alert_type,operation_class, station,building,layer,room,sensor,sensor_type WHERE alert.type_id=alert_type.id AND alert.alert_obj_code = sensor.sensor_code AND sensor.type_id=sensor_type.id AND sensor.affiliation=4 AND sensor.owner_id=room.id AND layer.id = room.layer_id AND building.id=layer.building_id AND station.id=building.station_id AND station.op_id=operation_class.id ";
		
		List<Record> alertInfoList = new ArrayList<Record>();
		
		alertInfoList = Db.find(sqlString);
		
		//List<Record> sensorDataList = Db.paginate(1, 10, select, sqlExcepionString).getList();
		
		setAttr("alertInfoList", alertInfoList);
		render("alertdata.jsp");
	}
	
	
}
