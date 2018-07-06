package com.yanxin.common.controller;

import java.util.List;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

public class WarnDetilController extends Controller{

	
	public void index() {
		
		render("warndetil.jsp");
	}
	
	/**
	 * 得到轮播图片
	 */
	public void getWarnImageDetil() {
		String[] sensor=this.getPara("sensor").split("/");
		String sensor_code=sensor[0];
		String point_type=sensor[1];
		String sqlString = "SELECT images.* FROM images WHERE images.point_type=? AND images.im_sensor_code=? ORDER BY images.create_time DESC LIMIT 3";
		List<Record> imageList = Db.find(sqlString,point_type,sensor_code);
		setAttr("imageList", imageList);
		if(imageList != null && imageList.size() > 0){
			setAttr("result", true);
		}else{
			setAttr("result", false);
		}
		
		renderJson();

	}
	/**
	 * 得到今日最高和最低温度
	 */
	public void getTodayTemp() {
		String[] sensor=this.getPara("sensor").split("/");
		String sensor_code=sensor[0];
		String point_type=sensor[1];
		String sqlString = "select MAX(temp.max_temp) AS max,MIN(temp.min_temp) AS min from temp where temp.temp_sensor_code=? AND temp.point_type=? AND TO_DAYS(temp.create_time)=TO_DAYS(NOW())";
		List<Record> imageList = Db.find(sqlString,sensor_code,point_type);
		setAttr("imageList", imageList);
		if(imageList != null && imageList.size() > 0){
			setAttr("result", true);
		}else{
			setAttr("result", false);
		}
		
		renderJson();

	}
	
	/**
	 * 得到历史温度记录
	 */
	public void getHistogram() {
		String[] sensor=this.getPara("sensor").split("/");
		String sensor_code=sensor[0];
		String point_type=sensor[1];
		String sqlString = "select su.max_temp, (select MAX(temp.max_temp) from temp WHERE temp.temp_sensor_code=? AND temp.point_type=?) as zuigao ,(SELECT MAX(temp.max_temp) from temp where temp.temp_sensor_code=? AND temp.point_type=? AND temp.create_time between (SELECT DATE_ADD(now(),INTERVAL -1 MONTH)) and now()) AS yue from temp su WHERE su.temp_sensor_code=? AND su.point_type=? ORDER BY su.create_time DESC LIMIT 1";
		List<Record> imageList = Db.find(sqlString,sensor_code,point_type,sensor_code,point_type,sensor_code,point_type);
		setAttr("imageList", imageList);
		if(imageList != null && imageList.size() > 0){
			setAttr("result", true);
		}else{
			setAttr("result", false);
		}
		
		renderJson();

	}
	/**
	 * 得到温度曲线的图像
	 */
	public void getTempCurve() {
		String[] sensor=this.getPara("sensor").split("/");
		String sensor_code=sensor[0];
		String point_type=sensor[1];
		String sqlString = "SELECT temp.max_temp,temp.create_time from temp where temp.temp_sensor_code=? AND temp.point_type=? AND temp.create_time between (SELECT DATE_ADD(now(),INTERVAL -1 MONTH)) and now()";
		List<Record> imageList = Db.find(sqlString,sensor_code,point_type);
		setAttr("imageList", imageList);
		if(imageList != null && imageList.size() > 0){
			setAttr("result", true);
		}else{
			setAttr("result", false);
		}
		
		renderJson();

	}
}
