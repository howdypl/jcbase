/**
 * 
 */
package com.yanxin.iot.Utils;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.List;
import java.util.Random;

import com.jfinal.plugin.activerecord.Record;
import com.yanxin.cmd.StreamGobbler;
import com.yanxin.iot.mqtt.CmdLineParser;

/**
 * @author Chengguozhen
 *
 */
public class ConstantsUtil {
	
	public static final int ALERT_TYPE_NO_AUTH = 1;
	public static final int ALERT_TYPE_SWITCH_FAILED = 2;
	
	public static final double CURRENT_MIN_THRESHOD = 0.5;
	
	public static final int SENSOR_CLOSE = 0;
	
	public static boolean bstart = false;
	
	public static final int SENSOR_OPEN = 1;
	
	public static final int SENSOR_TYPE_TEMPERATURE = 1;
	public static final int SENSOR_TYPE_humidity = 2;
	public static final int SENSOR_TYPE_SMOKE = 3;
	public static final int SENSOR_TYPE_LIGHT = 4;
	public static final int SENSOR_TYPE_FAN = 5;
	public static final int SENSOR_TYPE_AIR_CONDITIONER = 6;
	public static final int SENSOR_TYPE_WINDOWS = 7;
	public static final int SENSOR_TYPE_DOOR_BOARD = 8;
	public static final int SENSOR_TYPE_BATTERY = 9;
	public static final int SENSOR_TYPE_WATER_PUMP = 10;
	public static final int SENSOR_TYPE_LOCK = 11;
	public static final int SENSOR_TYPE_WATER = 12;
	public static final int SENSOR_TYPE_SWITCH = 13;
	public static final int SENSOR_TYPE_VIDEO = 14;
	
	public static final int PLATFORM_CMD_PRESET = 0x07;
	public static final int PLATFORM_CMD_PRESET_DEFAULT = 0x97;
	public static final int PLATFORM_CMD_TIMES = 0x99;
	
	public static final int PLATFORM_CMD_IMAGE_ALL = 0x9A;	
	
	public static final int PLATFORM_CMD_IMAGE_CREATE = 0x80;
	public static final int PLATFORM_CMD_IMAGE_COLOR = 0x81;
	
	// 阿里云
	public  static final String SERVER_IP = "192.168.1.100";
	
	public static final String CMD = "ffplay -f h264 udp://";
	
	private static final CmdLineParser parser = new CmdLineParser(null);

	
	public final static String[] PUBLISH_TOPICS = {
			"video/v1/cmd",
			"times/v1",
	};
	
	public static final int getPort(int min, int max) {

        Random random = new Random();

        int s = random.nextInt(max)%(max-min+1) + min;
        
        return s;
	}
	public static String getSwitchPubTopic(String prefix, String id){
		
		return prefix+"/"+id;
	}

	public static String getTimePubTopic(int region, int site, int room, int type){
		
		return "sensors/"+region+"/"+site+"/"+room+"/";
	}
	
	public static String url2file(String url){
       
        return null;
    }
	
	public static String file2url(String file) {
		
		return null;
	}
	
	public static void MQTTCommand(String sensorCode, long type, String value, long status) {
		
		final CmdLineParser parser = getParser();

        // parser.startController();
        
        parser.startSwitchPublishController(sensorCode,type,value,status);
        
       /*new Thread(){
    	   public void run() {
    		   System.out.println("==========="+ConstantsUtil.CMD+value);
    		   ConstantsUtil.execCMD(ConstantsUtil.CMD+value);
			}
       }.start();*/

	}
	
	public static void MQTTCommand(String sensorCode, long type, String value, long status, int colour) {
		
		final CmdLineParser parser = getParser();

        parser.startController();
        
        parser.startSwitchPublishController(sensorCode,type,value,status,colour);

	}
	
	
	public static void MQTTTimeCommand() {
		
		final CmdLineParser parser = getParser();
		parser.startController2();
		System.out.println("[MqttTimerListener]手动时间校准开始....");
        parser.startTimePublishControllerOnlyOne();
        System.out.println("[MqttTimerListener]手动时间校准完成....");
	}
	
	public static void MQTTImageAllCommand() {
		
		final CmdLineParser parser = getParser();
		parser.startController2();
        parser.startTimePublishControllerOnlyOne();
	}
	
	/**
	 * 
	 * @param sensorCode
	 * @param type
	 * @param value
	 */
	public static void MQTTPlatformCMD(String sensorCode, long type, int value) {
		
		final CmdLineParser parser = getParser();

        parser.startController2();
        
        parser.startSwitchPublishController(sensorCode,type,value);
	}
	
	public static void MQTTPlatformCMDPatch(List<String> sensorCodeList, long type, int value) {
		
		final CmdLineParser parser = getParser();

        parser.startController2();
        
        parser.startPatchSwitchPublishController(sensorCodeList, type, value);
        
	}
	
	
	public static void MQTTPlatformTimeCMD(String sensorCode, int type, List<Record> records) {
		
		final CmdLineParser parser = getParser();

        parser.startController2();
        
        parser.startTimePublishController(sensorCode, type, records);
	}
	
	// 未添加色带
	public static void execCMD(String sensorCode, long type, String value, int status) {
		try {

			Process p = Runtime.getRuntime().exec(ConstantsUtil.CMD+value);
			StreamGobbler errorgGobbler = new StreamGobbler(p.getErrorStream(), "Error");
			StreamGobbler outpuGobbler = new StreamGobbler(p.getInputStream(), "Output");
			errorgGobbler.start();
			outpuGobbler.start();
			System.out.println("============execCMD:"+ConstantsUtil.CMD+value);
			/*BufferedReader input = new BufferedReader(new InputStreamReader(p.getInputStream()));
			String line;
			while ((line = input.readLine()) != null) {
				System.out.println("COMMAND RESULT:"+line);
			}*/
			
			System.out.println("============================video receive end!");
			
			int exitVal= p.waitFor();
			System.out.println("=========== Prrocess exitValue:"+ exitVal);
			
			// input.close();

		} catch (Exception e) {
			e.printStackTrace();
			// System.out.println();
		}finally {
			System.out.println("============================发送关闭指令!");
			ConstantsUtil.MQTTCommand(sensorCode, type, value, status);
		}
	}
	
	// 添加色带
	public static void execCMD(String sensorCode, long type, String value, int status, int colour) {
		try {

			Process p = Runtime.getRuntime().exec(ConstantsUtil.CMD+value);
			StreamGobbler errorgGobbler = new StreamGobbler(p.getErrorStream(), "Error");
			StreamGobbler outpuGobbler = new StreamGobbler(p.getInputStream(), "Output");
			errorgGobbler.start();
			outpuGobbler.start();
			System.out.println("============execCMD:"+ConstantsUtil.CMD+value);
			/*BufferedReader input = new BufferedReader(new InputStreamReader(p.getInputStream()));
			String line;
			while ((line = input.readLine()) != null) {
				System.out.println("COMMAND RESULT:"+line);
			}*/
			
			System.out.println("============================video receive end!");
			
			int exitVal= p.waitFor();
			System.out.println("=========== Prrocess exitValue:"+ exitVal);
			
			// input.close();

		} catch (Exception e) {
			e.printStackTrace();
			// System.out.println();
		}finally {
			System.out.println("============================发送关闭指令!");
			ConstantsUtil.MQTTCommand(sensorCode, type, value, status, colour);
		}
	}
	
	/**
	 * @return the parser
	 */
	public static CmdLineParser getParser() {
		return parser;
	}
	
	public static final String getAuth(){
		
		int auth = (int)((Math.random()*9+1)*100000);
		
		return new Integer(auth).toString();
	}
	
	public static final int codeMask(Integer[] sIntegers) {
		int select = 0;
		if(null != sIntegers){
			for(int i=0; i<sIntegers.length; i++){
				if(sIntegers[i] > 0){
					int mask = 0x00000001<<i;
					select |= mask;
				}
			}
		}
		return select;
	}
	
	/*public static void main(String[] args) {
		Integer[] sIntegers = new Integer[5];
		sIntegers[0] = new Integer(1);
		sIntegers[1] = new Integer(0);
		sIntegers[2] = new Integer(0);
		sIntegers[3] = new Integer(0);
		sIntegers[4] = new Integer(0);
		
		System.out.println("tttt--"+ConstantsUtil.codeMask(sIntegers));
	}*/
}
