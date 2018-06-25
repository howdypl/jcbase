package com.yanxin.common.controller;

import java.util.List;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

public class WarnDetilController extends Controller{

	
	public void index() {
		
		render("warndetil.jsp");
	}
	
	
	public void getWarnImageDetil() {
		String point_type=this.getPara("point_type");
		String sensor_code=this.getPara("sensor_code");
		String sqlString = "SELECT warn.*,images.url FROM warn,images WHERE warn.point_type=images.point_type AND warn.sensor_code=images.im_sensor_code AND warn.create_time=images.create_time AND warn.point_type=? AND warn.sensor_code=? ORDER BY warn.create_time DESC LIMIT 3";
		List<Record> imageList = Db.find(sqlString,point_type,sensor_code);
		setAttr("imageList", imageList);
		if(imageList != null && imageList.size() > 0){
			setAttr("result", true);
		}else{
			setAttr("result", false);
		}
		
		renderJson();

	}
	
	public void getTodayTemp() {
		String point_type=this.getPara("point_type");
		String sensor_code=this.getPara("sensor_code");
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
	
}
