/**
 * 
 */
package com.yanxin.common.controller;

import java.util.List;

import com.jcbase.core.controller.JCBaseController;
import com.jcbase.core.view.InvokeResult;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.common.model.Images;
import com.yanxin.common.model.ImagesHigh;

/**
 * @author hwtd
 *
 */
public class OtherGalleryController extends JCBaseController {

	public void index() {
		render("galleryother.jsp");
	}
	
	public void getImages() {
		String createTimeString = getPara("create_time");
		String endTimeString = getPara("end_time");
		String op_class=this.getPara("op_class");
		String station=this.getPara("station");
		String building=this.getPara("building");
		String sensor=this.getPara("sensor");
		int page=this.getParaToInt("page");
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
		Page<ImagesHigh> pageInfo=ImagesHigh.me.getImagesPage(page,20,op_class,station,building,sensor,createTimeString,endTimeString,this.getOrderbyStr());
		//System.out.println(pageInfo.getList().size()+"******************************8");
		Record 	info = new Record();
		info.set("count", pageInfo.getTotalRow()).set("pageIndex", pageInfo.getPageNumber()).set("pageCount", pageInfo.getTotalPage());
		if(pageInfo.getList() != null && pageInfo.getList().size()>0){
			setAttr("result", true);
			setAttr("imageList", pageInfo.getList());
			setAttr("pageInfo", info);
		}else{
			
			setAttr("result", false);
		}
		renderJson();
	}

	public void openGallery() {
		render("galleryother_wind.jsp");
	}
	public void getSingleImages() {
		String sensorCode = this.getPara("sensor_code");
		String createTime = this.getPara("create_time");
		String pointType = this.getPara("point_type");
		if(sensorCode==null || createTime==null || pointType==null){
			renderJson(InvokeResult.failure("没有数据"));
			return ;
		}
		
		String sql = "SELECT images_high.*,building.building_name,station.station_name,sensor.name AS sensor_name,platform_point.platform_code"
				+ " FROM images_high,building,station,sensor,platform_point "
				+ "WHERE images_high.im_sensor_code=sensor.sensor_code AND sensor.building_id=building.id "
				+ "AND building.station_id=station.id AND platform_point.pp_sensor_code=images_high.im_sensor_code "
				+ "AND platform_point.point_type=images_high.point_type AND images_high.point_type=? AND images_high.im_sensor_code=? AND images_high.create_time=?";
		List<Record> rList = Db.find(sql, pointType,sensorCode,createTime);
		if(rList!=null&&rList.size()>0){
			setAttr("result", true);
			setAttr("imageList", rList);
		}else {
			setAttr("result", false);
		}
		renderJson();
	}
}
