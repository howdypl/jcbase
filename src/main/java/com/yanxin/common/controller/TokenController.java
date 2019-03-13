/**
 * 
 */
package com.yanxin.common.controller;

import java.io.BufferedReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jcbase.core.util.IWebUtils;
import com.jcbase.core.view.InvokeResult;
import com.jcbase.model.HwPushStationYwb;
import com.jcbase.model.SysUser;
import com.yanxin.iot.Utils.ConstantsUtil;
import com.yanxin.iot.json2.BaseCallBackBean;
import com.yanxin.iot.json2.Data;
import com.yanxin.iot.json2.JSONParser;
import com.yanxin.iot.json3.HWPushBean;
import com.yanxin.iot.json3.ShieldRecordBean;
import com.yanxin.iot.json2.StationBean;

/**
 * @author Guozhen Cheng
 *
 */
public class TokenController extends Controller {

	/**
	 * old 保存token
	 */
	public void saveToken(){
		
		int ywb = 0;
		String token = getPara("token");
		BaseCallBackBean<Integer> result = new BaseCallBackBean<Integer>();

		if(getPara("ywb") != null  &&  !getPara("ywb").equals("")){
			try{
				ywb = Integer.parseInt(getPara("ywb"));
			} catch(Exception e){
				e.printStackTrace();
				this.renderJson(InvokeResult.failure("无效的参数"));
				
				return;
			}
		}else {
			this.renderJson(InvokeResult.failure("无效的参数"));
			
			return;
		}
		
		if(token == null  ||  token.equals("")){
			this.renderJson(InvokeResult.failure("无效的参数"));
			
			return;
		}
		
		//判断屏蔽设置是否已在,否则初始化为全部接收告警
		initShieldStaton(ywb,token);
		
		System.out.println("+++++++token:"+token);
		String sql = "select * from push_token where token = ?";
		List<Record> records = Db.find(sql, token);
		if(records != null && records.size() > 0){
			result.setStatus(3);
			result.setMsg("token已存在，无须添加");
			renderJson(result);
			return;
		}
		
		Record r = new Record().set("token", token).set("auth",1).set("ywb",ywb);
		
		Db.save("push_token", "id", r);
		
		result.setStatus(1);
		result.setMsg("添加成功");
		renderJson(result);
		return;
	}
	
	/**
	 * 初始化屏蔽变电站记录
	 */
	private void initShieldStaton(int ywb,String token){
		
		/*Record rr = (Record)this.getSession().getAttribute("currentuser");
		String username = "";
		if(this.getSession().getAttribute("currentuser")!= null){
			username = rr.getStr("username");
		}*/
		SysUser user = IWebUtils.getCurrentSysUser(this.getRequest());
		
		String username = "";
		if(null!= user){
			username = user.getName();// user.me.getName();
		}
		
		List<HwPushStationYwb> stationList = HwPushStationYwb.dao.find("select * from hw_push_station_ywb where ywb = ?", ywb);
		if(stationList == null || stationList.isEmpty()){
			//String time = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss").format(new Date());
			String sql = "select op_id ywb,id station_id,station_name,1 auth,'"+username+"' username,'"+token+"' token, now() create_time from station where station.op_id=?";
			
			List<Record> records = Db.find(sql, ywb);
			if(records != null && !records.isEmpty()){
				Db.batchSave("hw_push_station_ywb", records, 30);
				Db.batchSave("config_push_log", records, 30);
			}
		}
		return;
	}
	
	/**
	 * 旧：按用户屏蔽变电站
	 */
	public void configPushList(){
		BaseCallBackBean<Integer> back = new BaseCallBackBean<Integer>();
		
		try {
			HWPushBean beans = getRequestObject(HWPushBean.class);
			if(beans != null){
				if(beans.getToken()!= null && beans.getYwbId()!=0){
					Db.update("delete from hw_push_station where token = ?", beans.getToken());
					if(beans.getData() != null && !beans.getData().isEmpty()){
						// Db.update("update push_token set auth=0 where token = ?",beans.getToken());
						for(StationBean b: beans.getData()){
							Record record = new Record();
							record.set("token", beans.getToken());
							record.set("ywb", beans.getYwbId());
							record.set("station_id", b.getStationId());
							record.set("station_name", b.getStationName());
							Db.save("hw_push_station", record);
						}
					}else {
						//Db.update("update push_token set auth=1 where token = ?",beans.getToken());
						Record record = new Record();
						record.set("token", beans.getToken());
						record.set("ywb", beans.getYwbId());
						Db.save("hw_push_station", record);
					}
					back.setStatus(1);
					back.setMsg("设置成功");
				}else{
					back.setStatus(2);
					back.setMsg("参数错误");
				}
			}else {
				back.setStatus(2);
				back.setMsg("参数错误");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		renderJson(back);
		return;
	}
	
	
	/**
	 * 按运维班屏蔽变电站
	 */
	public void insertShieldRecode(){
		BaseCallBackBean<Integer> back = new BaseCallBackBean<Integer>();
		// getSession().getAttribute("")
		try {
			HWPushBean beans = getRequestObject(HWPushBean.class);
			if(beans != null){
				if(beans.getToken()!= null && beans.getYwbId()!=0){
					Db.update("delete from hw_push_station_ywb where ywb = ?", beans.getYwbId());
					if(beans.getData() != null && !beans.getData().isEmpty()){
						// Db.update("update push_token set auth=0 where token = ?",beans.getToken());
						for(StationBean b: beans.getData()){
							Record record = new Record();
							record.set("token", beans.getToken());
							record.set("ywb", beans.getYwbId());
							record.set("username", beans.getUsername());
							record.set("station_id", b.getStationId());
							record.set("station_name", b.getStationName());
							if(b.isAccept()){
								record.set("auth", ConstantsUtil.ACCEPT_NOTIFICATION); //接收消息
							}else{
								record.set("auth", ConstantsUtil.UNACCEPT_NOTIFICATION); //屏蔽消息
							}
							record.set("create_time", new Date());
							
							Db.save("hw_push_station_ywb", record);
							Db.save("config_push_log", record);
						}
					}else {
						//Db.update("update push_token set auth=1 where token = ?",beans.getToken());
						Record record = new Record();
						record.set("token", beans.getToken());
						record.set("ywb", beans.getYwbId());
						record.set("username", beans.getUsername());
						Db.save("hw_push_station_ywb", record);
						Db.save("config_push_log", record);
					}
					back.setStatus(1);
					back.setMsg("设置成功");
				}else{
					back.setStatus(2);
					back.setMsg("参数错误");
				}
			}else {
				back.setStatus(2);
				back.setMsg("参数错误");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		renderJson(back);
		return;
	}
	
	/**
	 * 移动端，查询屏蔽记录
	 */
	public void queryShieldRecode(){
		BaseCallBackBean<List<ShieldRecordBean>> result = new BaseCallBackBean<List<ShieldRecordBean>>();
		
		int ywb = 0;
		int page = 1;
		int pageSize = 20;
		if(getPara("ywb") != null  &&  getPara("ywb") != ""){
			try{
				ywb = Integer.parseInt(getPara("ywb"));
			} catch(Exception e){
				e.printStackTrace();
				result.setStatus(2);
				result.setMsg("无效的参数");
				//renderJson(result);
				return;
			}
		}else {
			result.setStatus(2);
			result.setMsg("无效的参数");
			renderJson(result);
			return;
		}
		if(getPara("page") != null  &&  getPara("page") != ""){
			try{
				page = Integer.parseInt(getPara("page"));
			} catch(Exception e){
				e.printStackTrace();
				result.setStatus(2);
				result.setMsg("无效的参数");
				//renderJson(result);
				return;
			}
		}else {
			result.setStatus(2);
			result.setMsg("无效的参数");
			renderJson(result);
			return;
		}
		
		// List<Record> records = Db.find("select station_id,station_name from hw_push_station where ywb=?", ywb);
		Page<Record> pageRecords = Db.paginate(page, pageSize,"select cpl.ywb ywbId,oc.op_name, username,auth, station_id,station_name,cpl.create_time","from config_push_log cpl,operation_class oc where oc.id=cpl.ywb and cpl.ywb=? order by cpl.create_time desc",ywb);
		
		if(null == pageRecords){
			result.setStatus(1);
			result.setMsg("无数据");
		}else{
			List<Record> records2 = pageRecords.getList();
			if(records2.isEmpty()){
				result.setStatus(1);
				result.setMsg("无数据");
			}else {
				result.setStatus(1);
				result.setMsg("获取信息成功");
				List<ShieldRecordBean> beans = new ArrayList<ShieldRecordBean>();
				for (Record record: records2) {
					ShieldRecordBean bean = new ShieldRecordBean();
					bean.setYwbName(record.getStr("op_name"));
					bean.setStationName(record.getStr("station_name"));
					bean.setUsername(record.getStr("username"));
					if(record.get("ywbId")!=null){
						bean.setYwbId(record.getInt("ywbId"));
					}
					if(record.get("station_id")!=null){
						bean.setStationId(record.getInt("station_id"));
					}
					if(record.get("auth")!=null){
						if(record.getInt("auth") == 1){
							bean.setAccept(true);
						}else if(record.getInt("auth") == 0){
							bean.setAccept(false);
						}
					}
					bean.setCreateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(record.getDate("create_time")));	
					beans.add(bean);
				}
				result.setData(beans);
			}
		}
		renderJson(result);
		return;
	}
	
	/**
	 * web端查询屏蔽记录的接口
	 */
	public void queryShieldRecode4web(){
		BaseCallBackBean<Data<List<ShieldRecordBean>>> result = new BaseCallBackBean<Data<List<ShieldRecordBean>>>();
		
		int ywb = 0;
		int page = 1;
		int pageSize = 20;
		if(getPara("ywb") != null  &&  getPara("ywb") != ""){
			try{
				ywb = Integer.parseInt(getPara("ywb"));
			} catch(Exception e){
				e.printStackTrace();
				result.setStatus(2);
				result.setMsg("无效的参数");
				//renderJson(result);
				return;
			}
		}else {
			result.setStatus(2);
			result.setMsg("无效的参数");
			renderJson(result);
			return;
		}
		if(getPara("page") != null  &&  getPara("page") != ""){
			try{
				page = Integer.parseInt(getPara("page"));
			} catch(Exception e){
				e.printStackTrace();
				result.setStatus(2);
				result.setMsg("无效的参数");
				//renderJson(result);
				return;
			}
		}else {
			result.setStatus(2);
			result.setMsg("无效的参数");
			renderJson(result);
			return;
		}
		
		if(getPara("pageSize") != null  &&  getPara("pageSize") != ""){
			try{
				pageSize = Integer.parseInt(getPara("pageSize"));
			} catch(Exception e){
				e.printStackTrace();
				result.setStatus(2);
				result.setMsg("无效的参数");
				//renderJson(result);
				return;
			}
		}
		
		Data<List<ShieldRecordBean>> data = new Data<List<ShieldRecordBean>>();
		
		// List<Record> records = Db.find("select station_id,station_name from hw_push_station where ywb=?", ywb);
		Page<Record> pageRecords = Db.paginate(page, pageSize,"select cpl.ywb ywbId,oc.op_name, username,auth, station_id,station_name,cpl.create_time","from config_push_log cpl,operation_class oc where oc.id=cpl.ywb and cpl.ywb=? order by cpl.create_time desc",ywb);
		
		if(null == pageRecords){
			data.setTotalItem(0);
			data.setTotalPage(0);
			data.setFirst(false);
			data.setLast(false);
			result.setStatus(1);
			result.setMsg("无数据");
		}else{
			data.setTotalItem(pageRecords.getTotalRow());
			data.setTotalPage(pageRecords.getTotalPage());
			data.setFirst(pageRecords.isFirstPage());
			data.setLast(pageRecords.isLastPage());
			
			List<Record> records2 = pageRecords.getList();
			if(records2.isEmpty()){
				result.setStatus(1);
				result.setMsg("无数据");
			}else {
				result.setStatus(1);
				result.setMsg("获取信息成功");
				List<ShieldRecordBean> beans = new ArrayList<ShieldRecordBean>();
				for (Record record: records2) {
					ShieldRecordBean bean = new ShieldRecordBean();
					bean.setYwbName(record.getStr("op_name"));
					bean.setStationName(record.getStr("station_name"));
					bean.setUsername(record.getStr("username"));
					if(record.get("ywbId")!=null){
						bean.setYwbId(record.getInt("ywbId"));
					}
					if(record.get("station_id")!=null){
						bean.setStationId(record.getInt("station_id"));
					}
					if(record.get("auth")!=null){
						if(record.getInt("auth") == 1){
							bean.setAccept(true);
						}else if(record.getInt("auth") == 0){
							bean.setAccept(false);
						}
					}
					bean.setCreateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(record.getDate("create_time")));	
					beans.add(bean);
				}
				data.setPage(beans);
				result.setData(data);
			}
		}
		renderJson(result);
		return;
	}
	
	/**
	 * 查询被屏蔽的变电站
	 */
	public void queryShieldStation(){
		BaseCallBackBean<List<ShieldRecordBean>> result = new BaseCallBackBean<List<ShieldRecordBean>>();
		
		int ywb = 0;
		if(getPara("ywb") != null  &&  getPara("ywb") != ""){
			try{
				ywb = Integer.parseInt(getPara("ywb"));
			} catch(Exception e){
				e.printStackTrace();
				result.setStatus(2);
				result.setMsg("无效的参数");
				//renderJson(result);
				return;
			}
		}else {
			result.setStatus(2);
			result.setMsg("无效的参数");
			renderJson(result);
			return;
		}
		
		List<Record> lists = Db.find("select hpsy.ywb ywbId,oc.op_name, username,auth, station_id,station_name,hpsy.create_time from hw_push_station_ywb hpsy,operation_class oc where oc.id=hpsy.ywb and hpsy.ywb=?",ywb);
		List<ShieldRecordBean> beans = new ArrayList<>();
		if(lists!=null && !lists.isEmpty()){
			for(Record record:lists){
				ShieldRecordBean bean = new ShieldRecordBean();
				bean.setYwbName(record.getStr("op_name"));
				bean.setStationName(record.getStr("station_name"));
				bean.setUsername(record.getStr("username"));
				if(record.get("ywbId")!=null){
					bean.setYwbId(record.getInt("ywbId"));
				}
				if(record.get("station_id")!=null){
					bean.setStationId(record.getInt("station_id"));
				}
				if(record.get("auth")!=null){
					if(record.getInt("auth") == 1){
						bean.setAccept(true);
					}else if(record.getInt("auth") == 0){
						bean.setAccept(false);
					}
				}
				bean.setCreateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(record.getDate("create_time")));	
				beans.add(bean);
			}
		}else {
			result.setStatus(2);
			result.setMsg("无屏蔽数据");
		}
		result.setData(beans);
		renderJson(result);
	}
	
	
	/**
	 * 取Request中的数据对象
	 * 
	 * @param valueType
	 * @return 返回fastjson解析的数据
	 * @throws Exception
	 */
	protected <T> T getRequestObject(Class<T> valueType) throws Exception {
		StringBuilder json = new StringBuilder();
		BufferedReader reader = this.getRequest().getReader();
		String line = null;
		while ((line = reader.readLine()) != null) {
			json.append(line);
		}
		reader.close();
		//System.out.println("====================");
		System.out.println(json.toString());
		// JSONObject object = JSONObject.fromObject(json.toString());
		T t = JSONParser.gson.fromJson(json.toString(), valueType);
		
		return t;
	}
}
