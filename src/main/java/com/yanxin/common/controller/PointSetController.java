package com.yanxin.common.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.google.common.collect.Maps;
import com.jcbase.core.auth.anno.RequiresPermissions;
import com.jcbase.core.controller.JCBaseController;
import com.jcbase.core.model.Condition;
import com.jcbase.core.model.Operators;
import com.jcbase.core.util.CommonUtils;
import com.jcbase.core.util.DateUtils;
import com.jcbase.core.util.FileUtils;
import com.jcbase.core.util.JqGridModelUtils;
import com.jcbase.core.view.InvokeResult;
import com.jcbase.model.AppVersion;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;
import com.yanxin.common.model.OperationClass;
import com.yanxin.common.model.Point;
import com.yanxin.common.model.Station;

public class PointSetController extends JCBaseController{
	
	/**
	 * 
	 */
	public void index() {
		render("point_index.jsp");
	}
	
	public void add() {
		/*Integer id=this.getParaToInt("id");
		if(id!=null){
			this.setAttr("item", Point.me.findById(id));
		}
		this.setAttr("id", id);*/
		render("point_add.jsp");
	}
	
	public void upload() {
		Integer id=this.getParaToInt("id");
		if(id!=null){
			this.setAttr("item", Point.me.findById(id));
		}
		this.setAttr("id", id);
		render("point_upload.jsp");
	}
	
	public void getListData() {
		String keyword=this.getPara("name");
		String username=this.getPara("username");
		Page<Point> pageInfo=Point.me.getPointPage(getPage(), this.getRows(),keyword,username,this.getOrderbyStr());
		this.renderJson(JqGridModelUtils.toJqGridView(pageInfo)); 
	}
	
	public void getListDataNew() {
		String username=this.getPara("username");
		int area = this.getParaToInt("workarea");
		int opID = this.getParaToInt("op_id");
		int station = this.getParaToInt("station");
		int building = this.getParaToInt("building");
		int sensor = this.getParaToInt("sensor_code");
		
		Page<Point> pageInfo=Point.me.getPointPageNew(getPage(), this.getRows(),username,area,opID,station,building,sensor,this.getOrderbyStr());
		this.renderJson(JqGridModelUtils.toJqGridView(pageInfo)); 
	}

    public void setVisible(){
		Integer visible=this.getParaToInt("visible");
		String bids=this.getPara("ids");
		InvokeResult result=Point.me.setVisible(bids, visible);
		this.renderJson(result);
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
			/*String path="e:/work/backend/upload";
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
			fos.close();*/
			images=uploadFile.getFileName();
		}else {
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
			setAttr("result", true);
			setAttr("content", stationRecords);
		}else{
			setAttr("result", false);
		}
		
		renderJson();
	}
	
	/**
	 * 未使用
	 */
	public void saveInf(){
		
		Integer warn_temp=this.getParaToInt("warn_temp");
		Integer point_type=this.getParaToInt("point_type");
		String pp_sensor_code=this.getPara("seneor_id");
		Integer id=this.getParaToInt("id");
		String platform_code=this.getPara("name");
		String images = this.getPara("file_upload");
		if(images == null){
			images = "0";
		}
		InvokeResult result=Point.me.save(id, pp_sensor_code,platform_code,images,warn_temp,point_type);
		this.renderJson(result); 
		
	}
	/**
	 * 未使用
	 */
	public void uploadImage() {
		//String dataStr=DateUtils.format(new Date(), "yyyyMMddHHmm");
		List<UploadFile> flist = this.getFiles("/temp", 1024*1024*50);
		String path="e:/work/backend/upload";
		String status_url= "http://116.255.207.148:33334/backenduploadinf/";
		Map<String,Object> data=Maps.newHashMap();
		if(flist.size()>0){
			UploadFile uf=flist.get(0);
			
			// String fileUrl=+"/"+uf.getFileName();
			String newFile=path+"/"+uf.getFileName();;
			FileUtils.mkdir(newFile, false); 
			FileUtils.copy(uf.getFile(), new File(newFile), BUFFER_SIZE);
			uf.getFile().delete();
			data.put("staticUrl",status_url+uf.getFileName());
			data.put("fileUrl",uf.getFileName());
			renderJson(data);
		}
	}
	
	protected String getOrderbyStr(){
		String sord=this.getPara("sord");
		String sidx=this.getPara("sidx");
		String order = "";
		if(CommonUtils.isNotEmpty(sidx)){
			if(sidx.equals("sensor_name")){
				order= " order by sensor.name "+sord;
			}else if(sidx.equals("create_time")){
				order= " order by platform_point."+ sidx+" "+sord;
			}else if(sidx.equals("defaul")){
				order= " order by platform_point."+ sidx+" "+sord;
			}else if(sidx.equals("building_name")){
				order= " order by building."+ sidx+" "+sord;
			}else if(sidx.equals("station_name")){
				order= " order by station."+ sidx+" "+sord;
			}else if(sidx.equals("op_name")){
				order= " order by operation_class."+ sidx+" "+sord;
			}else if(sidx.equals("islook")){
				order= " order by platform_point."+ sidx+" "+sord;
			}else if(sidx.equals("platform_code")){
				order= " order by platform_point."+ sidx+" "+sord;
			}	
			
		}
		return order;
	}

}
