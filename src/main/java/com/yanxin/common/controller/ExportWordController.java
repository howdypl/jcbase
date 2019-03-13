package com.yanxin.common.controller;

import java.io.BufferedInputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.eclipse.jetty.util.ajax.JSONObjectConvertor;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jcbase.core.view.InvokeResult;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.yanxin.export.json.ImageUrls;
import com.yanxin.export.json.WordJson;
import com.yanxin.iot.Utils.ConstantsUtil;

import freemarker.cache.FileTemplateLoader;
import freemarker.cache.TemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import sun.misc.BASE64Encoder;

public class ExportWordController extends Controller {

	private static String seperator = System.getProperty("file.separator");
	
	/**
     * 获取网络图片流
     * 
     * @param url
     * @return
     */
	 public static InputStream getImageStream(String url) {
	        try {
	            HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();
	            connection.setReadTimeout(5000);
	            connection.setConnectTimeout(5000);
	            connection.setRequestMethod("POST");
	            if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {
	                InputStream inputStream = connection.getInputStream();
	                return inputStream;
	            }
	        } catch (IOException e) {
	            System.out.println("获取网络图片出现异常，图片路径为：" + url);
	            e.printStackTrace();
	        }
	        return null;
	    }
	

	// 存放导出word所需要的ftl文件的路径
	public static String getFtlBasePath() {
		String os = System.getProperty("os.name");
		String basePath = "";
		if (os.toLowerCase().startsWith("win")) {
			basePath = PropKit.get("export_word_temp_dir"); // ConstantsUtil.export_word_temp_dir;
		} else {
			// linux下的模板路径
			basePath = "/xx/xx/xx";
		}
		basePath = basePath.replace("/", seperator);
		return basePath;
	}

	// 将图片转换成BASE64字符串
	public static String getImageStr(String str) {
		String imgFile = str;
		InputStream in = null;
		String url = "http://116.255.207.148:33334/backendimageinf/b827ebf99398/2018-12-24/2018-12-24%2021&01&11~b827ebf99398~4.5~9.2~61.0~1~2.jpg";//"http://116.255.207.148:33334/backendimageinf/2018-09-14%2012&32&15~b827ebe3f3c7~27.9~29.2~59.1~0~4.jpg";
		
		if(str!=null){
			url=str.replace(" ", "%20");
		}
		
		InputStream inputStream = getImageStream(url);
		// FileInputStream finput = (FileInputStream) input;
		byte[] data = new byte[1024];
		int len = 0;
		FileOutputStream fileOutputStream = null;
		Date date = new Date();
		SimpleDateFormat dateWordFormat = new SimpleDateFormat("yyyy-MM-dd-hh-mm-ss");
		String imageName = dateWordFormat.format(date);
		try {
			fileOutputStream = new FileOutputStream(PropKit.get("export_img_temp_dir") + imageName + ".jpg");
			while ((len = inputStream.read(data)) != -1) {
				fileOutputStream.write(data, 0, len);

			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {

			if (inputStream != null) {
				try {
					inputStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (fileOutputStream != null) {
				try {
					fileOutputStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		byte[] data2 = null;
		try {
			// URL url = new URL(str);
			// in = new BufferedInputStream(url.openStream());

			in = new FileInputStream(PropKit.get("export_img_temp_dir") + imageName + ".jpg");
			data2 = new byte[in.available()];
			in.read(data2);
			in.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		BASE64Encoder encoder = new BASE64Encoder();
		return encoder.encode(data2);
	}

	public void downloadExcel() throws JsonParseException, JsonMappingException, IOException {
		if(this.getPara("id")==null){
			this.renderJson(InvokeResult.failure("参数错误"));
			return;
		}
		Integer id = this.getParaToInt("id");
		Record rr = null;
		// 生成文件的路径及文件名。
		Date date = new Date();
		
		if (id != null) {
			boolean result = true;
			String sqlString = "SELECT IFNULL(warn.confirm_time,'') AS confirm_time,warn.cancel,IFNULL(warn.confirm_user,'') AS confirm_user"
					+ ",warn.create_time,IFNULL(warn.humidity,'') AS humidity,warn.id,warn.max_temp,warn.point_type,IFNULL(warn.reason,'') AS reason,IFNULL(warn.remark,'') AS remark,warn.sensor_code,warn.`status`,"
					+ "IFNULL(warn.suggestion,'') AS suggestion,IFNULL(warn.weather,'') AS weather,IFNULL(warn.weather_temp,'') AS weather_temp,IFNULL(warn.wind,'') AS wind,temp.min_temp, IFNULL(warn.image_num,'') AS image_num, IFNULL(warn.audit,'') AS audit, "
					+ "IFNULL(warn.allow,'') AS allow, IFNULL(warn.detector,'') AS detector, IFNULL(warn.current,'') AS current, IFNULL(warn.voltage,'') AS voltage, IFNULL(warn.maintence_time,'') AS maintence_time,IFNULL(warn.op_time,'') AS op_time,station.station_name,building.building_name,platform_point.platform_code,sensor.name,sensor.sensor_id, IFNULL(sensor.sensor_model,'') AS sensor_model,sensor.emittance,sensor.distance,sensor.create_time sensor_maintence_time,IFNULL(sensor.update_time ,NOW()) AS sensor_create_time FROM temp,warn,sensor,station,platform_point,building WHERE warn.sensor_code=temp.temp_sensor_code AND warn.sensor_code = sensor.sensor_code AND platform_point.pp_sensor_code = sensor.sensor_code AND platform_point.point_type = warn.point_type AND sensor.building_id = building.id AND building.station_id = station.id AND temp.point_type=warn.point_type AND warn.create_time=temp.create_time AND warn.id=?";
			String sqlString2 = "SELECT images.url,images.color_bar from warn,images WHERE warn.sensor_code=images.im_sensor_code AND warn.create_time=images.create_time AND warn.id = ? order by images.color_bar ASC";
			
			rr = Db.findFirst(sqlString, id);
			
			List<Record> urls = Db.find(sqlString2,id);
			
			if(urls!=null&&urls.size()>0){
				rr.set("urls", urls.toArray(new Record[0]));
			}
			WordJson wordJson = new WordJson();
			ObjectMapper object = new ObjectMapper();
			
			wordJson = object.readValue(rr.toJson(), WordJson.class);
			
			// rr.getColumns()
			String imageURLPrefix = PropKit.get("image_url_prefix");//"http://116.255.207.148:33334/backendimageinf/";
			
			for(ImageUrls iu:wordJson.getUrls()){
				iu.setUrl(imageURLPrefix+iu.getUrl());
			}
			
			Map<String, Object> cont = new HashMap<String, Object>();// 存储数据

			//向word文档中写入数据
			//电力设备名称
			cont.put("device_name", wordJson.getName()+" "+wordJson.getPlatform_code());
			
			//电压等级
			cont.put("station_level", "");
			//变电站
			cont.put("station_name", wordJson.getStation_name()+"-"+wordJson.getBuilding_name());
			//运行编号
			cont.put("device_name", wordJson.getName()+" "+wordJson.getPlatform_code());
			
			//出厂日期
			cont.put("create_time", wordJson.getMaintence_time());
			//投运日期
			cont.put("op_time", wordJson.getOp_time());
			//仪器型号
			//cont.put("sensor_model", wordJson.getSensor_model());
			cont.put("sensor_model", "IR-160W");
			
			//仪器编号
			//cont.put("sensor_code", wordJson.getSensor_code());
			if(wordJson.getSensor_id()==null){
				cont.put("sensor_id", "0");
			}else {
				cont.put("sensor_id", wordJson.getSensor_id());
			}
			
			//cont.put("image_num", wordJson.getSensor_code()+"-"+wordJson.getPoint_type()+wordJson.getMax_temp()+wordJson.getCreate_time());
			cont.put("image_num", wordJson.getCreate_time());
			if(wordJson.getCurrent()==null){
				cont.put("icurrent", "-");
			}else {
				cont.put("icurrent", wordJson.getCurrent());
			}
			
			if(wordJson.getEmittance()!=null&&wordJson.getEmittance()!=""){
				try{
					Integer em = Integer.parseInt(wordJson.getEmittance());
					
					DecimalFormat df2 = new DecimalFormat("0.00");
					
					String em3 = df2.format(em/(float)1000.0);
					
					cont.put("emittance", em3);
				}catch(NumberFormatException nfe){
					nfe.printStackTrace();
				}
			}else {
				cont.put("emittance", "-");
			}
			//cont.put("emittance", wordJson.getEmittance());
			cont.put("distance", wordJson.getDistance());
			
			//模版以BASE64字符串存储图片，因此需要将文件流进行转换
			cont.put("image1",getImageStr(wordJson.getUrls().get(1).getUrl()));// 红外
			cont.put("image2",getImageStr(wordJson.getUrls().get(0).getUrl()));// 高清
			//cont.put("imgStr1","");
			//cont.put("imgStr2","");
			cont.put("weather", wordJson.getWeather());
			cont.put("weather_temp", wordJson.getWeather_temp());
			cont.put("humidity", wordJson.getHumidity());
			cont.put("wind", wordJson.getWind());
			cont.put("detect_time", wordJson.getCreate_time());
			
			cont.put("reason", wordJson.getReason());
			cont.put("suggestion", wordJson.getSuggestion());
			cont.put("remark", wordJson.getRemark());
			cont.put("detector", wordJson.getConfirm_user());
			cont.put("audit", wordJson.getAudit());
			cont.put("allow", wordJson.getAllow());
			SimpleDateFormat dateWordFormat2 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			cont.put("export_time", dateWordFormat2.format(date));
			
			try {
				// 模板的路径
				File fir = new File(getFtlBasePath());
				SimpleDateFormat dateWordFormat = new SimpleDateFormat("yyyy-MM-dd");
				String wordName = "测温异常报告"+dateWordFormat.format(date);
				File outFile = new File(PropKit.get("export_word_temp_dir") + wordName + ".doc");

				Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFile), "UTF-8"));

				// 使用FileTemplateLoader
				// 指定模板路径
				TemplateLoader templateLoader = null;
				templateLoader = new FileTemplateLoader(fir);
				String tempname = "foo.ftl";

				Configuration cfg = new Configuration();
				cfg.setTemplateLoader(templateLoader);
				Template t = cfg.getTemplate(tempname, "UTF-8");

				t.process(cont, out);
				out.flush();
				out.close();
				result = true;
				this.setAttr("result", result);
				renderFile(outFile);
					
			} catch (Exception e) {
				e.printStackTrace();
				result = false;
				this.setAttr("result", result);
				renderJson();
			}
		}
		return;
	}
}
