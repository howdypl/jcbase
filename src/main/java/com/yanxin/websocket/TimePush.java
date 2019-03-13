/**
 * 
 */
package com.yanxin.websocket;

import java.io.IOException;
import java.util.List;
import java.util.concurrent.CopyOnWriteArraySet;

import org.apache.log4j.Logger;

import com.jcbase.model.SysUser;
import com.jcbase.model.SysUserRole;
import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

/**
 * @author Guozhen Cheng
 *
 */
public class TimePush implements Runnable {

	private static Logger log = Logger.getLogger(TimePush.class);
	/* (non-Javadoc)
	 * @see java.lang.Runnable#run()
	 */
	@Override
	public void run() {
		while(true){
			CopyOnWriteArraySet<WebSocketController> wsList = WebSocketController.getWebSocketSet();
			log.debug("告警推送巡检......");
			for(WebSocketController ws:wsList){
				String message = getTemp(ws.getName());
				if(message == null){
					continue;
				}
				try {
					ws.sendMessage(message);
				} catch (IOException e) {
					
					e.printStackTrace();
				}
			}
			try {
				Thread.sleep(60000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
	
	//检测温度进行预警,从告警表里获取
	public String getTemp(String name) {
		String sqlString=null;
		String userName=name;
		
		// SysUser user = SysUser.me.getUserOP(userName);
		
		SysUser user = SysUser.me.getByName(userName);
		if(user==null){
			return null;
		}else {
			if(user.getUserType().intValue()==0){//管理员
				sqlString = "select platform_point.*,warn.id warnID,warn.create_time AS warn_create_time,warn.max_temp,operation_class.op_name,station.station_name,building.building_name,sensor.`name` from platform_point,warn,station,operation_class,building,sensor where operation_class.id=station.op_id AND station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND warn.point_type=platform_point.point_type AND warn.sensor_code=platform_point.pp_sensor_code AND warn.status = 0 AND warn.cancel=0 order by warn.create_time desc";
			}else if(user.getUserType().intValue()==1){//工区
				sqlString = "select platform_point.*,warn.id warnID,warn.create_time AS warn_create_time,warn.max_temp,operation_class.op_name,station.station_name,building.building_name,sensor.`name` from platform_point,warn,station,operation_class,building,sensor where operation_class.id=station.op_id AND station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND warn.point_type=platform_point.point_type AND warn.sensor_code=platform_point.pp_sensor_code AND warn.status = 0 AND warn.cancel=0 AND operation_class.work_area_id=(SELECT work_area_id FROM sys_user WHERE sys_user.`name`='"+userName+"') order by warn.create_time desc";
			}else if(user.getUserType().intValue()==2){//运维班
				sqlString = "select platform_point.*,warn.id warnID,warn.create_time AS warn_create_time,warn.max_temp,operation_class.op_name,station.station_name,building.building_name,sensor.`name` from platform_point,warn,station,operation_class,building,sensor where operation_class.id=station.op_id AND station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND warn.point_type=platform_point.point_type AND warn.sensor_code=platform_point.pp_sensor_code AND warn.status = 0 AND warn.cancel=0 AND operation_class.id=(SELECT operation_class_id FROM sys_user WHERE sys_user.`name`='"+userName+"') order by warn.create_time desc";
			}
		}
		
		/*if(SysUserRole.dao.isOp(userName)){
			sqlString = "select platform_point.*,warn.id warnID,warn.create_time,warn.max_temp,operation_class.op_name,station.station_name,building.building_name,sensor.`name` from platform_point,warn,station,operation_class,building,sensor where operation_class.id=station.op_id AND station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND warn.point_type=platform_point.point_type AND warn.sensor_code=platform_point.pp_sensor_code AND warn.status = 0 AND warn.cancel=0 order by warn.create_time desc";
		}else{
			sqlString = "select platform_point.*,warn.id warnID,warn.create_time,warn.max_temp,operation_class.op_name,station.station_name,building.building_name,sensor.`name` from platform_point,warn,station,operation_class,building,sensor where operation_class.id=station.op_id AND station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND warn.point_type=platform_point.point_type AND warn.sensor_code=platform_point.pp_sensor_code AND warn.status = 0 AND warn.cancel=0 AND operation_class.id=(SELECT operation_class_id FROM sys_user WHERE sys_user.`name`='"+userName+"') order by warn.create_time desc";
		}*/
		//System.out.println(sqlString+"****************************");
		List<Record> resultList = Db.find(sqlString);
				
		if(resultList!=null && resultList.size()>0){
			return JsonKit.toJson(resultList);
		}else {
			return null;
		}
		
	}

}
