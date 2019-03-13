package com.jcbase.model;

import java.util.Date;


//由于JFinal db.find()方法 返回值为JSON类型
//为取出单条数据 需将其转换成对象然后通过get()方法取出数据
//使用jackson的ObjectMapper类的readValue()方法进行转换
public class WordJSON {
	private String url;
	private String platform_code;
	private String sensor_code;
	//private String station_level;
	private String station_name;
	private String name;
	private String create_time;
	//private Date op_time;
	
	
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getPlatform_code() {
		return platform_code;
	}
	public void setPlatform_code(String platform_code) {
		this.platform_code = platform_code;
	}
	public String getSensor_code() {
		return sensor_code;
	}
	public void setSensor_code(String sensor_code) {
		this.sensor_code = sensor_code;
	}
//	public String getStation_level() {
//		return station_level;
//	}
//	public void setStation_level(String station_level) {
//		this.station_level = station_level;
//	}
	public String getStation_name() {
		return station_name;
	}
	public void setStation_name(String station_name) {
		this.station_name = station_name;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCreate_time() {
		return create_time;
	}
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
	//public Date getOp_time() {
	//	return op_time;
	//}
	//public void setOp_time(Date op_time) {
	//	this.op_time = op_time;
	//}
	
	
}
