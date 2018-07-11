package com.yanxin.common.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.jcbase.core.controller.JCBaseController;
import com.jcbase.core.model.Condition;
import com.jcbase.core.model.Operators;
import com.jcbase.core.util.CommonUtils;
import com.jcbase.core.view.InvokeResult;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;
import com.yanxin.common.model.OperationClass;
import com.yanxin.common.model.Point;
import com.yanxin.common.model.Station;

public class PointSetController extends JCBaseController{
	
	public void index() {
		render("point_index.jsp");
	}

	
	public void add() {
		Integer id=this.getParaToInt("id");
		if(id!=null){
			this.setAttr("item", Point.me.findById(id));
		}
		this.setAttr("id", id);
		render("point_add.jsp");
	}
	
	public void getListData() {
		String name=this.getPara("name");
		Set<Condition> conditions=new HashSet<Condition>();
		if(CommonUtils.isNotEmpty(name)){
			conditions.add(new Condition("platform_code",Operators.LIKE,name));
		}
		Page<Point> pageInfo=Point.me.getPage(this.getPage(), this.getRows(),conditions,this.getOrderby());
		this.renderJson(Point.me.toJqGridView(pageInfo)); 
	}
	
	
	public void deleteData(){
		Integer id=this.getParaToInt("id");
		InvokeResult invokeResult=Point.me.deleteData(id);
		this.renderJson(invokeResult);
	}
	
	public void save() throws IOException{
		String images=null;
		
		UploadFile uploadFile = getFile("images");
		if(uploadFile!=null) {
			String path="D:/backend/upload";
			File f=new File(path);
			if (!f.exists()) {
				f.mkdir();
			}
			FileOutputStream fos=new FileOutputStream(path+"\\"+uploadFile.getFileName());
			FileInputStream fis=new FileInputStream(uploadFile.getFile());
			byte[] buffer=new byte[1024];
			int len=0;
			while((len=fis.read(buffer))>0) {
				fos.write(buffer, 0, len);
			}
			fos.close();  
			images=uploadFile.getFileName();
		}
		else {
			images="0";
		}
		Integer warn_temp=this.getParaToInt("warn_temp");
		Integer point_type=this.getParaToInt("point_type");
		String pp_sensor_code=this.getPara("seneor_id");
		Integer id=this.getParaToInt("id");
		String platform_code=this.getPara("name");
		InvokeResult result=Point.me.save(id, pp_sensor_code,platform_code,images,warn_temp,point_type);
		this.renderJson(result); 
	}
	/**
	 * 获取所有的预设点类型  查询point表
	 */
	public void getPointType() {
		String pp_sensor_code=this.getPara("sensor");
		String sqlString = "select id, point_type from point where point_type not in (select point_type from platform_point where pp_sensor_code=?)";
		List<Record> stationRecords = Db.find(sqlString,pp_sensor_code);
		if(null!=stationRecords && !stationRecords.isEmpty()){
			setAttr("notempty", true);
			setAttr("stationRecords", stationRecords);
		}else{
			setAttr("notempty", false);
		}
		
		renderJson();
	}
	
}
