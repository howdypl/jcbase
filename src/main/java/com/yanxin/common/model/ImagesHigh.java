package com.yanxin.common.model;

import java.util.Date;
import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.model.base.BaseImages;

/**
 * Generated by JFinal.
 */

public class ImagesHigh extends BaseImages<ImagesHigh> {
	
	private static final long serialVersionUID = -4833191302759204212L; 
	public static final ImagesHigh me = new ImagesHigh();
	
	public Page<ImagesHigh> getImagesPage(int page, int rows, String op_class, String station, String building, String sensor,String createTimeString, String endTimeString,
			String orderbyStr) {
		StringBuffer sqlExceptSelect=new StringBuffer();
		if(station==null){
			sqlExceptSelect.append("FROM images_high, platform_point,sensor,building,station,operation_class WHERE operation_class.id=station.op_id AND operation_class.id="+op_class+" AND station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND images_high.point_type=platform_point.point_type AND images_high.im_sensor_code=sensor.sensor_code AND images_high.color_bar=1 AND images_high.create_time> '"+createTimeString+"' AND images_high.create_time< '"+endTimeString+"' ORDER BY images_high.create_time DESC");
		}else {
			if(building==null){
				sqlExceptSelect.append("FROM images_high, platform_point,sensor,building,station,operation_class WHERE operation_class.id=station.op_id AND station.id=building.station_id AND station.id="+station+" AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND images_high.point_type=platform_point.point_type AND images_high.im_sensor_code=sensor.sensor_code AND images_high.color_bar=1 AND images_high.create_time> '"+createTimeString+"' AND images_high.create_time< '"+endTimeString+"' ORDER BY images_high.create_time DESC");
			}else {
				if(sensor==null){
					sqlExceptSelect.append("FROM images_high, platform_point,sensor,building,station WHERE station.id=building.station_id AND building.id=sensor.building_id AND building.id="+building+" AND sensor.sensor_code=platform_point.pp_sensor_code AND images_high.point_type=platform_point.point_type AND images_high.im_sensor_code=sensor.sensor_code AND images_high.color_bar=1 AND images_high.create_time> '"+createTimeString+"' AND images_high.create_time< '"+endTimeString+"' ORDER BY images_high.create_time DESC");
				}else {
					String[] s=sensor.split("/");
					String sensorCodeString=s[0];
					String point_type=s[1];
					sqlExceptSelect.append("FROM images_high, platform_point,sensor,building,station WHERE station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND images_high.point_type=platform_point.point_type AND images_high.im_sensor_code=sensor.sensor_code AND images_high.color_bar=1 AND im_sensor_code = '"+sensorCodeString+"' AND images_high.point_type="+point_type+"  AND images_high.create_time> '"+createTimeString+"' AND images_high.create_time< '"+endTimeString+"' ORDER BY images_high.create_time DESC");
				}
			}
		}
		String select="SELECT DISTINCT building.building_name,station.station_name,images_high.url as url,images_high.max_temp as max, images_high.id as id, images_high.create_time as create_time, images_high.im_sensor_code as im_sensor_code,sensor.name as sensor_name,platform_point.warn_temp,platform_point.platform_code,platform_point.point_type ";
		//System.out.println(select+sqlExceptSelect.toString());
		return this.paginate(page, rows, select, sqlExceptSelect.toString());
	}
	
	public Page<ImagesHigh> getImagesPagev2(int page, int rows, String op_class, String station, String building, String sensor,String createTimeString, String endTimeString,
			String orderbyStr) {
		StringBuffer sqlExceptSelect=new StringBuffer();
		
		
		if(station==null){
			sqlExceptSelect.append("FROM images, temp, platform_point,sensor,building,station,operation_class WHERE operation_class.id=station.op_id AND operation_class.id="+op_class+" AND station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND temp.point_type=platform_point.point_type AND images.im_sensor_code = temp.temp_sensor_code AND images.create_time = temp.create_time AND images.im_sensor_code=sensor.sensor_code ");//  AND images.color_bar=1 ");
		}else {
			if(building==null){
				sqlExceptSelect.append("FROM images, temp, platform_point,sensor,building,station,operation_class WHERE operation_class.id=station.op_id AND station.id=building.station_id AND station.id="+station+" AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND temp.point_type=platform_point.point_type AND images.im_sensor_code = temp.temp_sensor_code AND images.create_time = temp.create_time AND images.im_sensor_code=sensor.sensor_code ");//  AND images.color_bar=1 ");
			}else {
				if(sensor==null){
					sqlExceptSelect.append("FROM images, temp, platform_point,sensor,building,station WHERE station.id=building.station_id AND building.id=sensor.building_id AND building.id="+building+" AND sensor.sensor_code=platform_point.pp_sensor_code AND temp.point_type=platform_point.point_type AND images.im_sensor_code = temp.temp_sensor_code AND images.create_time = temp.create_time AND images.im_sensor_code=sensor.sensor_code ");// AND images.color_bar=1 ");
				}else {
					String[] s=sensor.split("/");
					String sensorCodeString=s[0];
					String point_type=s[1];
					sqlExceptSelect.append("FROM images, temp, platform_point,sensor,building,station WHERE station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND temp.point_type=platform_point.point_type AND images.im_sensor_code = temp.temp_sensor_code AND images.create_time = temp.create_time AND images.im_sensor_code=sensor.sensor_code AND images.color_bar=1 AND im_sensor_code = '"+sensorCodeString+"' AND images.point_type=temp.point_type AND images.point_type='"+point_type+"'");
					
					//sqlExceptSelect.append("FROM images, temp, platform_point,sensor,building,station WHERE station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND temp.point_type=platform_point.point_type AND images.im_sensor_code = temp.temp_sensor_code AND images.create_time = temp.create_time AND images.im_sensor_code=sensor.sensor_code AND im_sensor_code = '"+sensor+"' AND images.point_type=temp.point_type "); // AND images.color_bar=1
				}
			}
		}
		String select="SELECT DISTINCT building.building_name,station.station_name,images.url as url, temp.av_temp as av, temp.max_temp as max, temp.min_temp as min, images.id as id, images.create_time as create_time, images.im_sensor_code as im_sensor_code,sensor.name as sensor_name,platform_point.warn_temp,platform_point.platform_code,platform_point.point_type";
		//System.out.println(select+sqlExceptSelect.toString());
		
		if(createTimeString==null||createTimeString.equals("")||endTimeString==null||endTimeString.equals("")){
			sqlExceptSelect.append("AND images.create_time>=(NOW() - interval 48 hour) ORDER BY images.create_time DESC");
		}else {
			sqlExceptSelect.append("  AND images.create_time> '"+createTimeString+"' AND images.create_time< '"+endTimeString+"' ORDER BY images.create_time DESC");
			
		}
		return this.paginate(page, rows, select, sqlExceptSelect.toString());
	}
	
	public Page<ImagesHigh> getImagesPagev3(int page, int rows, String op_class, String station, String building, String sensor,String createTimeString, String endTimeString,
			String orderbyStr) {
		StringBuffer sqlExceptSelect=new StringBuffer();
			
		if(station==null){
			sqlExceptSelect.append("FROM platform_point,sensor,building,station,operation_class WHERE operation_class.id=station.op_id AND operation_class.id="+op_class+" AND station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code ");//  AND images.color_bar=1 ");
		}else {
			if(building==null){
				sqlExceptSelect.append("FROM platform_point,sensor,building,station,operation_class WHERE operation_class.id=station.op_id AND station.id=building.station_id AND station.id="+station+" AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code ");//  AND images.color_bar=1 ");
			}else {
				if(sensor==null){
					sqlExceptSelect.append("FROM platform_point,sensor,building,station WHERE station.id=building.station_id AND building.id=sensor.building_id AND building.id="+building+" AND sensor.sensor_code=platform_point.pp_sensor_code ");// AND images.color_bar=1 ");
				}else {
					String[] s=sensor.split("/");
					String sensorCodeString=s[0];
					String point_type=s[1];
					sqlExceptSelect.append("FROM images, temp, platform_point,sensor,building,station WHERE station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND temp.point_type=platform_point.point_type AND images.im_sensor_code = temp.temp_sensor_code AND images.create_time = temp.create_time AND images.im_sensor_code=sensor.sensor_code AND images.color_bar=1 AND im_sensor_code = '"+sensorCodeString+"' AND images.point_type=temp.point_type AND images.point_type="+point_type+" ");
					
					sqlExceptSelect.append("FROM platform_point,sensor,building,station WHERE station.id=building.station_id AND building.id=sensor.building_id AND sensor.sensor_code=platform_point.pp_sensor_code AND sensor_code = '"+sensor+"'"); // AND images.color_bar=1
				}
			}
		}
		
		String select="SELECT building.id AS building_id,building.building_name,station.station_name,sensor.name as sensor_name,sensor.sensor_code, platform_point.warn_temp,platform_point.platform_code,platform_point.point_type ";
		
		//List<Record> rList = Db.find(select+sqlExceptSelect.toString());
		Page<ImagesHigh> gallerys = this.paginate(page, rows, select, sqlExceptSelect.toString());
		
		
		if(gallerys!=null){
			String sqls = "Select images.url as url, temp.av_temp as av, temp.max_temp as max, temp.min_temp as min, images.id as id, images.create_time as create_time from images,temp where images.im_sensor_code = temp.temp_sensor_code AND images.create_time = temp.create_time AND images.point_type=temp.point_type AND "
					+ " images.im_sensor_code=? AND images.point_type=? ";
			for(ImagesHigh rr:gallerys.getList()){
				List<Record> images = Db.find(sqls,rr.get("sensor_code"),rr.get("point_type"));
				if(images!=null){
					rr.set("images", images.toArray(new Record[0]));
				}
			}
		}
		
		
		if(createTimeString==null||createTimeString.equals("")||endTimeString==null||endTimeString.equals("")){
			sqlExceptSelect.append("AND images.create_time>=(NOW() - interval 48 hour) ORDER BY images.create_time DESC");
		}else {
			sqlExceptSelect.append("  AND images.create_time> '"+createTimeString+"' AND images.create_time< '"+endTimeString+"' ORDER BY images.create_time DESC");
			
		}
		
		return this.paginate(page, rows, select, sqlExceptSelect.toString());
	}

}