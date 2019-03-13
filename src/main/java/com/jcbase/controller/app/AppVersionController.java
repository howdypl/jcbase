package com.jcbase.controller.app;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.google.common.collect.Maps;
import com.jcbase.core.auth.anno.RequiresPermissions;
import com.jcbase.core.controller.JCBaseController;
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
import com.yanxin.common.model.Point;
import com.yanxin.mobile.update.bean.UpBase;

public class AppVersionController extends JCBaseController {
	
	@RequiresPermissions(value={"/app"})
	public void index() {
		this.setAttr("static_url", PropKit.get("static_url"));
		render("index.jsp");
	}
	
	@RequiresPermissions(value={"/app"})
	public void getListData() {
		Page<AppVersion> pageInfo=AppVersion.dao.getPage(this.getPage(), this.getRows(),this.getOrderby());
		this.renderJson(JqGridModelUtils.toJqGridView(pageInfo)); 
	}
	
	@RequiresPermissions(value={"/app"})
	public void setVisible(){
		int visible=this.getParaToInt("visible");
		String ids=this.getPara("ids");
		InvokeResult result=AppVersion.dao.setVisible(ids, visible);
		this.renderJson(result);
	}
	@RequiresPermissions(value={"/app"})
	public void addApp(){
		Integer id=getParaToInt("id");
		String action="add";
		if(id!=null){
			this.setAttr("item", AppVersion.dao.findById(id));
			action="edit";
		}
		this.setAttr("action", action);
		render("app_add.jsp");
	}
	
	@RequiresPermissions(value={"/app"})
	public void update(){
		UpBase<Record> upInfo = new UpBase<Record>();
		upInfo.setState(0);
		upInfo.setMsg("不存在可升级的应用");
		String sqlstr = "SELECT app_version.id id,app_version.create_time sendTime,app_version.content descd,app_version.version_no code from app_version order by app_version.version_no desc";
		List<Record> recordList = Db.find(sqlstr);
		if(recordList!=null&&recordList.size()>0){
			Record r = recordList.get(0);
			r.set("uploadurl","http://116.255.207.148:33334/inf/app/download/"+r.getInt("id"));
			upInfo.setData(r);
			upInfo.setState(1);
			upInfo.setMsg("成功获取可升级的URL");
		}
		
		renderJson(upInfo);
	}
	
	@RequiresPermissions(value={"/app"})
	public void download(){
		Integer id = 0;
		try{
			id=getParaToInt();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(id==0){
			return;
		}
		AppVersion av = AppVersion.dao.findById(id);
		String[] wordStr = av.getLinkUrl().split("/");
		String fd = "";
		String timeStr = "";
		if(wordStr != null){
			timeStr = wordStr[wordStr.length-2];
		}
		fd = PropKit.get("uploadPath")+"/"+timeStr+"/"+av.getUrl();
		File apk = new File(fd);
		if(apk.isFile()){
			renderFile(apk);
		}
		// render("500.jsp");
		return;
	}
	
	@RequiresPermissions(value={"/app"})
	public void saveApp(){
		Integer id=getParaToInt("id");
		String content=getPara("content");
		String linkUrl=getPara("linkUrl");
		Integer natureNo=getParaToInt("natureNo");
		String os=getPara("os");
		String url=getPara("url");
		String versionNo=getPara("versionNo");
		Integer status=getParaToInt("status");
		Integer isForce=getParaToInt("isForce");
		
		InvokeResult result=AppVersion.dao.saveAppVersion(id, content, linkUrl,
				natureNo,os, url, versionNo, status, isForce);
		this.renderJson(result);
	}
	
	@RequiresPermissions(value={"/app"})
	public void uploadApk() {
		String dataStr=DateUtils.format(new Date(), "yyyyMMddHHmm");
		List<UploadFile> flist = this.getFiles("/temp", 1024*1024*50);
		Map<String,Object> data=Maps.newHashMap();
		if(flist.size()>0){
			UploadFile uf=flist.get(0);
			String status_url=PropKit.get("static_url");
			// String fileUrl=+"/"+uf.getFileName();
			String newFile=PropKit.get("uploadPath")+"/"+dataStr+"/"+uf.getFileName();;
			FileUtils.mkdir(newFile, false); 
			FileUtils.copy(uf.getFile(), new File(newFile), BUFFER_SIZE);
			uf.getFile().delete();
			status_url+="/"+dataStr+"/"+uf.getFileName();
			data.put("staticUrl",status_url);
			data.put("fileUrl",uf.getFileName());
			renderJson(data);
		}
	}
	
	@RequiresPermissions(value={"/app"})
	public void saveApp2(){
		
		String appName=null;
		
		UploadFile uploadFile = getFile("file_upload");
		String status_url=PropKit.get("static_url");
		
		if(uploadFile!=null) {
			
			String path= PropKit.get("uploadPath");// "e:/work/backend/upload/app/apk";
			String dataStr=DateUtils.format(new Date(), "yyyyMMddHHmm");
			String fileUrl="app/apk/"+dataStr+"/"+uploadFile.getFileName();
			
			path+="/"+dataStr;
			File f=new File(path);
			if (!f.exists()) {
				f.mkdir();
			}
			FileOutputStream fos;
			try {
				fos = new FileOutputStream(path+"\\"+uploadFile.getFileName());
				FileInputStream fis=new FileInputStream(uploadFile.getFile());
				byte[] buffer=new byte[1024];
				int len=0;
				while((len=fis.read(buffer))>0) {
					fos.write(buffer, 0, len);
				}
				fos.close();
			} catch (FileNotFoundException e) {
				
				e.printStackTrace();
			} catch (IOException e) {
				
				e.printStackTrace();
			}

			status_url+=fileUrl;
			appName=uploadFile.getFileName();
		}
		else {
			appName="0";
		}
		
		Integer id=getParaToInt("id");
		String content=getPara("content");
		// String linkUrl=getPara("linkUrl");
		Integer natureNo=getParaToInt("natureNo");
		String os=getPara("os");
		String url=getPara("url");
		String versionNo=getPara("versionNo");
		Integer status=getParaToInt("status");
		Integer isForce=getParaToInt("isForce");
		
		InvokeResult result=AppVersion.dao.saveAppVersion(id, content, status_url,
				natureNo,os, url, versionNo, status, isForce);
		this.renderJson(result);
	}
}