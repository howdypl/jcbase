package com.yanxin.common.mobil.controller;

import java.util.List;

import com.jcbase.core.view.InvokeResult;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

public class SensorTempDetailsController extends Controller{

	/**
	 * 得到轮播图片
	 */
	public void getWarnImageDetil() {
		
		String sensor_code=this.getPara("sensor_code");
		String point_type=this.getPara("point_type");
		if(sensor_code==null || sensor_code=="" || point_type==null || point_type==""){
			InvokeResult.failure("参数错误！");
		}
		String sqlString = "SELECT images.*,temp.max_temp FROM images,temp WHERE temp.create_time=images.create_time AND images.im_sensor_code=temp.temp_sensor_code AND images.point_type=temp.point_type AND images.point_type=? AND images.im_sensor_code=? AND images.color_bar BETWEEN 0 AND 2 ORDER BY images.create_time DESC LIMIT 3";
		List<Record> imageList = Db.find(sqlString,point_type,sensor_code);
				
		this.renderJson(InvokeResult.success(imageList));
	}
	
	public void getAnormalImages() {
		String sensor_code=this.getPara("sensor_code");
		String point_type=this.getPara("point_type");
		if(sensor_code==null || sensor_code=="" || point_type==null || point_type==""){
			InvokeResult.failure("参数错误！");
		}
		String sqlString = "SELECT warnimages.url,warnimages.create_time,temp.max_temp FROM warnimages,temp WHERE temp.create_time=warnimages.create_time AND warnimages.im_sensor_code=temp.temp_sensor_code AND warnimages.point_type=temp.point_type AND warnimages.point_type=? AND warnimages.im_sensor_code=?  ORDER BY warnimages.create_time DESC LIMIT 6";
		//String sqlString = "SELECT url FROM warnimages WHERE warnimages.point_type=? AND warnimages.im_sensor_code=?  ORDER BY warnimages.create_time DESC LIMIT 6";
		List<Record> imageList = Db.find(sqlString,point_type,sensor_code);
		this.renderJson(InvokeResult.success(imageList));
	}
	/**
	 * 得到今日最高和最低温度
	 */
	public void getTodayTemp() {
		String sensor_code=this.getPara("sensor_code");
		String point_type=this.getPara("point_type");
		String sqlString = "select IFNULL(MAX(temp.max_temp),0) AS max,IFNULL(MIN(temp.min_temp),0) AS min from temp where temp.status=0 AND temp.temp_sensor_code=? AND temp.point_type=? AND TO_DAYS(temp.create_time)=TO_DAYS(NOW())";
		List<Record> imageList = Db.find(sqlString,sensor_code,point_type);
		
		this.renderJson(InvokeResult.success(imageList));

	}
	
	/**
	 * 得到历史温度记录
	 */
	public void getHistogram() {
		String sensor_code=this.getPara("sensor_code");
		String point_type=this.getPara("point_type");
		String sqlString = "select su.max_temp, (select MAX(temp.max_temp) from temp WHERE temp.status=0 AND temp.temp_sensor_code=? AND temp.point_type=?) as zuigao ,(SELECT MAX(temp.max_temp) from temp where temp.status=0 AND temp.temp_sensor_code=? AND temp.point_type=? AND temp.create_time between (SELECT DATE_ADD(now(),INTERVAL -1 MONTH)) and now()) AS yue from temp su WHERE su.status=0 AND su.temp_sensor_code=? AND su.point_type=? ORDER BY su.create_time DESC LIMIT 1";
		List<Record> imageList = Db.find(sqlString,sensor_code,point_type,sensor_code,point_type,sensor_code,point_type);
		
		this.renderJson(InvokeResult.success(imageList));

	}
	
	/**
	 * 得到温度曲线的图像
	 */
	public void getTempCurve() {
		String sensor_code=this.getPara("sensor_code");
		String point_type=this.getPara("point_type");
		String sqlString = "SELECT IFNULL(max(temp.max_temp),0) AS maxTemp,date_format(temp.create_time,'%d') AS dateNum from temp where temp.status=0 AND temp.temp_sensor_code=? AND temp.point_type=? AND date_format(temp.create_time,'%Y-%m-%d')>=DATE_FORMAT(DATE_ADD(sysdate(),INTERVAL -29 day),'%Y-%m-%d') group by date_format(temp.create_time,'%Y-%m-%d'),temp.point_type,temp.temp_sensor_code";
		List<Record> imageList = Db.find(sqlString,sensor_code,point_type);
		
		this.renderJson(InvokeResult.success(imageList));
	}
	
	public void get24HoursCurve() {
		
		String sensor_code=this.getPara("sensor_code");
		String point_type=this.getPara("point_type");
		
		String sqlString = "SELECT temp.*,CONCAT(sensor.`name`,platform_code) as sensorName,building.building_name,station.station_name,operation_class.op_name FROM temp,platform_point,sensor,building,station,operation_class WHERE temp.temp_sensor_code=sensor.sensor_code AND sensor.sensor_code=platform_point.pp_sensor_code AND temp.point_type=platform_point.point_type AND sensor.building_id=building.id AND building.station_id=station.id AND station.op_id=operation_class.id AND temp_sensor_code = ? AND temp.point_type= ? AND temp.create_time>DATE_SUB(NOW(),INTERVAL 24 HOUR) ORDER BY temp.create_time DESC";
		
		List<Record> dataList = Db.find(sqlString,sensor_code,point_type);
		
		
		this.renderJson(InvokeResult.success(dataList));
		
	}
	
	
}
