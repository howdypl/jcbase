/**
 * 
 */
package com.yanxin.common.controller;

import java.io.Serializable;
import java.util.List;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import net.sf.json.JSONObject;

/**
 * @author Cheng Guozhen
 * 
 */

public class SensorDataController extends Controller {

	public void index() {
		String sqlString = "select * from sensordataview ORDER BY create_time DESC LIMIT 0,1000";
		List<Record> sensorDataList = Db.findByCache("sensordata", "sensorDataList", sqlString);

		setAttr("sensorDataList", sensorDataList);
		
		// renderJson();
		
		render("sensordata.jsp");
	}
	
	public void getdata() {

		String sqlString = "select * from sensordataview";
		
		List<Record> records = Db.find(sqlString);
		Data datas = new Data(records);
		
		renderJson(datas);
	}
	
	class Data implements Serializable{

		/**
		 * 
		 */
		private static final long serialVersionUID = 1L;
		
		List<Record> aaData;

		
		public Data(List<Record> aaData) {
			super();
			this.aaData = aaData;
		}

		public List<Record> getAaData() {
			return aaData;
		}

		public void setAaData(List<Record> aaData) {
			this.aaData = aaData;
		}
		
		public String toJSONString() {
			 
	        return JSONObject.fromObject(this).toString();
	    }
	}
}
