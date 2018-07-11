
package com.yanxin.iot.mqtt;

import com.jfinal.plugin.activerecord.Record;
import com.yanxin.iot.Utils.ConstantsUtil;
import com.yanxin.iot.json.DevicePayload;
import com.yanxin.iot.json.JsonParser;
import com.yanxin.iot.json.PlatformPayload;
import com.yanxin.iot.json.TimePayload;
import com.yanxin.iot.property.PropertiesUtil;

import org.eclipse.paho.client.mqttv3.MqttException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import static com.yanxin.iot.mqtt.MqttClientController.printHelp;

import java.text.SimpleDateFormat;
import java.util.concurrent.TimeUnit;
import java.util.*;

/**
 * Created by Guozhen Cheng on 2017/6/17.
 */
public class CmdLineParser {

    private static final Logger log = LoggerFactory.getLogger(CmdLineParser.class);

    private String[] args;

    private boolean quietMode;
    private String action;
    private String topic;
    private String message;
    private int qos;
    private String broker;
    private int port;
    private String clientId;
    private String clientIdPub;
    private String clientIdSub;
    private String clientIdTimePub;
    
    private String subTopic;
    private String pubTopic;
    
    private String pubTimeTopic;
    
    private String pubPlatformTopic;
    
    private boolean cleanSession; // Non durable subscriptions
    private boolean ssl;
    private String password;
    private String userName;
    private String protocol;

    //private String url = "tcp://192.168.1.100:61613";
    private String url = "tcp://localhost:61613";
    private MqttClientController Client;
    private MqttClientController switchPubClient;
    private MqttClientController timePubClient;


    public CmdLineParser(String[] args) {
        this.args = args;
        // timer = new java.util.Timer();
        ArgsParser(args);
        // startController2();
    }

    public void ArgsParser(String[] args){
        // Default settings:
    	log.info("Reading configuration from config file iclient.properties");
        quietMode 	= !PropertiesUtil.getStringByKey("mqtt_quietMode").equals("false");
        action 		= PropertiesUtil.getStringByKey("mqtt_action");
        topic 		= PropertiesUtil.getStringByKey("mqtt_topic");
        message 	= "Message from blocking Paho MQTTv3 Java client sample";
        qos 		= Integer.parseInt(PropertiesUtil.getStringByKey("mqtt_qos"));
        broker 		= PropertiesUtil.getStringByKey("mqtt_broker");
        port 		= Integer.parseInt(PropertiesUtil.getStringByKey("mqtt_port"));

        clientId 	= PropertiesUtil.getStringByKey("mqtt_client_id");
        clientIdPub 	= PropertiesUtil.getStringByKey("mqtt_client_id_pub");
        clientIdSub 	= PropertiesUtil.getStringByKey("mqtt_client_id_sub");
        clientIdTimePub = PropertiesUtil.getStringByKey("mqtt_client_id_time_pub");
        
        subTopic	= PropertiesUtil.getStringByKey("mqtt_sub_topic");
        pubTopic 	= PropertiesUtil.getStringByKey("mqtt_pub_topic");
        pubTimeTopic = PropertiesUtil.getStringByKey("mqtt_pub_time_topic");
        //转动云台的主题
        pubPlatformTopic = PropertiesUtil.getStringByKey("mqtt_pub_platform_topic");
        
        cleanSession= !PropertiesUtil.getStringByKey("mqtt_clean_session").equals("false"); // Non durable subscriptions
        ssl         = !PropertiesUtil.getStringByKey("mqtt_ssl").equals("false");
        password    = PropertiesUtil.getStringByKey("mqtt_password").contentEquals("")?null:PropertiesUtil.getStringByKey("mqtt_password");
        userName    = PropertiesUtil.getStringByKey("mqtt_userName").contentEquals("")?null:PropertiesUtil.getStringByKey("mqtt_userName");

        protocol    = PropertiesUtil.getStringByKey("mqtt_protocol");

        // Parse the arguments-
        
        if(null != args){
	        for (int i=0; i<args.length; i++) {
	            // Check this is a valid argument
	            if (args[i].length() == 2 && args[i].startsWith("-")) {
	                char arg = args[i].charAt(1);
	                // Handle arguments that take no-value
	                switch(arg) {
	                    case 'h': case '?':	printHelp(); return;
	                    case 'q': quietMode = true;	continue;
	                }
	
	                // Now handle the arguments that take a value and
	                // ensure one is specified
	                if (i == args.length -1 || args[i+1].charAt(0) == '-') {
	                    log.info("Missing value for argument: "+args[i]);
	                    printHelp();
	                    return;
	                }
	                switch(arg) {
	                    case 'a': action = args[++i];                 break;
	                    case 't': topic = args[++i];                  break;
	                    case 'm': message = args[++i];                break;
	                    case 's': qos = Integer.parseInt(args[++i]);  break;
	                    case 'b': broker = args[++i];                 break;
	                    case 'p': port = Integer.parseInt(args[++i]); break;
	                    case 'i': clientId = args[++i];				  break;
	                    case 'c': cleanSession = Boolean.valueOf(args[++i]).booleanValue();  break;
	                    case 'k': System.getProperties().put("javax.net.ssl.keyStore", args[++i]); break;
	                    case 'w': System.getProperties().put("javax.net.ssl.keyStorePassword", args[++i]); break;
	                    case 'r': System.getProperties().put("javax.net.ssl.trustStore", args[++i]); break;
	                    case 'v': ssl = Boolean.valueOf(args[++i]).booleanValue(); break;
	                    case 'u': userName = args[++i];               break;
	                    case 'z': password = args[++i];               break;
	                    default:
	                        log.info("Unrecognised argument: "+args[i]);
	                        printHelp();
	                        return;
	                }
	            } else {
	                log.info("Unrecognised argument: "+args[i]);
	                printHelp();
	                return;
	            }
	        }
        }

        // Validate the provided arguments
        if (!action.equals("publish") && !action.equals("subscribe")) {
            log.info("Invalid action: "+action);
            printHelp();
            return;
        }
        if (qos < 0 || qos > 2) {
            log.info("Invalid QoS: "+qos);
            printHelp();
            return;
        }
        if (topic.equals("")) {
            // Set the default topic according to the specified action
            if (action.equals("publish")) {
                topic = pubTopic;
            } else {
                topic = subTopic;
            }
        }

        if (ssl) {
            protocol = "ssl://";
        }

        url = protocol + broker + ":" + port;

        if (clientId == null || clientId.equals("")) {
            clientId = "IOT_backend_"+action;
        }
        
        log.info("Finished Reading configurations from config file iclient.properties");
    }

    public void startController(){
        try {
            // Create an instance of this class
        	log.info("starting connections to MQTT broker:"+url);
            Client = new MqttClientController(url, clientId+ConstantsUtil.getAuth(), cleanSession, quietMode,userName,password);

            // log.info("starting subscribe the topic "+subTopic+ " from MQTT Server or broker!");
            // 订阅视频
            Client.subscribe(subTopic,qos);
            // Perform the requested action
        } catch(MqttException me) {
            // Display full details of any exception that occurs
        	Client.close();
            log.info("reason "+me.getReasonCode());
            log.info("msg "+me.getMessage());
            log.info("loc "+me.getLocalizedMessage());
            log.info("cause "+me.getCause());
            log.info("excep "+me);
            me.printStackTrace();
        }
    }
    
    public void startController2(){

        // With a valid set of arguments, the real work of
        // driving the client API can begin
    	
        try {
            // Create an instance of this class
        	log.info("starting connections to MQTT broker:"+url);
            Client = new MqttClientController(url, clientId+ConstantsUtil.getAuth(), cleanSession, quietMode,userName,password);

            // log.info("starting subscribe the topic "+subTopic+ " from MQTT Server or broker!");
            // 订阅视频
            // Client.subscribe(subTopic,qos);
            // Perform the requested action
           /* if (action.equals("publish")) {
                Client.publish(topic,qos,message.getBytes());
            } else if (action.equals("subscribe")) {
                Client.subscribe(topic,qos);
            }*/
        } catch(MqttException me) {
            // Display full details of any exception that occurs
            log.info("reason "+me.getReasonCode());
            log.info("msg "+me.getMessage());
            log.info("loc "+me.getLocalizedMessage());
            log.info("cause "+me.getCause());
            log.info("excep "+me);
            me.printStackTrace();
        }
    }

    
	/**
	 * 开关指令API
	 * @param deviceId
	 * @param type
	 * @param value
	 * @param status: 0代表关闭指令，1代表打开指令
	 */
	public void startSwitchPublishController(final String deviceId, final long type, final String value, final long status) {

		final java.util.Timer timer = new java.util.Timer();
		final String  topic = this.getPubTopic();  // + "/"+ deviceId;
		final int qos = this.getQos();
		
		class videoPublish extends java.util.TimerTask{

			@Override
			public void run() {
				DevicePayload payload = Client.getJsonParser().getCommand(deviceId, (int)type, value, (int)status);
				try {
					Client.publish(topic, qos, Client.getJsonParser().getJsonData(payload));
					log.info("Publish a new command to switch: "+payload.toString());
					
					Client.close();
				} catch (MqttException e) {
					log.error("Errors happens when publishing time to sensors!");
					e.printStackTrace();
				}
				timer.cancel();
			}
		}
		
		timer.schedule(new videoPublish(), 4000);
		
	}
	
	
	/**
	 * 开关指令API
	 * @param deviceId
	 * @param type
	 * @param value
	 * @param status: 0代表关闭指令，1代表打开指令
	 * @param colour:色带
	 */
	public void startSwitchPublishController(final String deviceId, final long type, final String value, final long status, final int colour) {

		final java.util.Timer timer = new java.util.Timer();
		final String  topic = this.getPubTopic();  // + "/"+ deviceId;
		final int qos = this.getQos();
		
		
		class videoPublish extends java.util.TimerTask{

			@Override
			public void run() {
				JsonParser jp = Client.getJsonParser();
				DevicePayload payload = jp.getCommand(deviceId, (int)type, value, (int)status, colour);
				try {
					Client.publish(topic, qos, Client.getJsonParser().getJsonData(payload));
					log.info("Publish a new command to switch: "+payload.toString());
					
					Client.close();
				} catch (MqttException e) {
					log.error("Errors happens when publishing time to sensors!");
					e.printStackTrace();
				}
				timer.cancel();
			}
		}
		
		timer.schedule(new videoPublish(), 4000);
		
		// Client.getScheduler().scheduleAtFixedRate(runnable, 0, 10, TimeUnit.SECONDS);
	}
	
	/**
	 * 转换云台指令API
	 * @param deviceId
	 * @param type:02向右转，设置预设点03，
	 * @param value
	 */
	public void startSwitchPublishController(final String deviceId, final long type, final int selections) {

		final java.util.Timer timer = new java.util.Timer();
		final String  topic = this.getPubPlatformTopic();  // + "/"+ deviceId;
		final int qos = this.getQos();
		
		class videoPublish extends java.util.TimerTask{

			@Override
			public void run() {
				JsonParser jp = Client.getJsonParser();
				PlatformPayload payload = jp.getPlatform(deviceId, (int)type, selections);
				try {
					Client.publish(topic, qos, Client.getJsonParser().getJsonPlatformData(payload));
					log.info("Publish a new platform location to switch: "+payload.toString());
					log.info("发送消息到设备"+payload.getDeviceId());
					System.out.println("发送消息到设备"+payload.getDeviceId());
					Client.close();
				} catch (MqttException e) {
					log.error("Errors happens when publishing platform location to sensors!");
					e.printStackTrace();
				}
				timer.cancel();
			}
		}
		
		timer.schedule(new videoPublish(), 4000);
		
		// Client.getScheduler().scheduleAtFixedRate(runnable, 0, 10, TimeUnit.SECONDS);
	}
	
	/**
	 * 批量下发多个摄像头的转换云台指令API
	 * @param deviceId
	 * @param type:02向右转，设置预设点03，
	 * @param value
	 */
	public void startBatchSwitchPublishController(final List<String> deviceIds, final long type, final int selections) {

		final java.util.Timer timer = new java.util.Timer();
		final String  topic = this.getPubPlatformTopic();  // + "/"+ deviceId;
		final int qos = this.getQos();
		
		class videoPublish extends java.util.TimerTask{

			@Override
			public void run() {
				JsonParser jp = Client.getJsonParser();
				// PlatformPayload payload = jp.getPlatform(deviceId, (int)type, selections);
				
				ArrayList<PlatformPayload> payloads = jp.getPlatformList(deviceIds,(int)type, selections);
				
				try {
					Client.publish(topic, qos, jp.getJsonPlatformDataList(payloads));
					
					log.info("批量发送指令到设备："+payloads.toString());
					Client.close();
				} catch (MqttException e) {
					log.error("发送云台命令是发生异常，未发送成功!");
					e.printStackTrace();
				}
				timer.cancel();
			}
		}
		
		timer.schedule(new videoPublish(), 4000);
		
		// Client.getScheduler().scheduleAtFixedRate(runnable, 0, 10, TimeUnit.SECONDS);
	}
	
	/**
	 * 转换云台指令API
	 * @param deviceId
	 * @param type:02向右转，设置预设点03，
	 * @param value
	 */
	public void startTimePublishController(final String deviceId, final int type, final List<Record> records) {

		final java.util.Timer timer = new java.util.Timer();
		final String  topic = this.getPubPlatformTopic();  // + "/"+ deviceId;
		final int qos = this.getQos();
		
		class videoPublish extends java.util.TimerTask{

			@Override
			public void run() {
				JsonParser jp = Client.getJsonParser();
				PlatformPayload payload = jp.getPlatform(deviceId, type,records);
				try {
					Client.publish(topic, qos, Client.getJsonParser().getJsonPlatformData(payload));
					log.info("Publish a new platform location to switch: "+payload.toString());
					
					Client.close();
				} catch (MqttException e) {
					log.error("Errors happens when publishing platform location to sensors!");
					e.printStackTrace();
				}
				timer.cancel();
			}
		}
		
		timer.schedule(new videoPublish(), 4000);
		
		// Client.getScheduler().scheduleAtFixedRate(runnable, 0, 10, TimeUnit.SECONDS);
	}
	

	 
	
    public void startTimePublishControllerTest(){
    	
    	/*try {
    		log.info("starting connections to MQTT broker:"+url);
			timePubClient = new MqttClientController(url, clientIdTimePub, cleanSession, quietMode,userName,password);
		} catch (MqttException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}*/

       	Runnable runnable1 = new Runnable(){       		
    		public void run(){
    			TimePayload payload = new TimePayload(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
    			try {
    				Client.publish(pubTimeTopic,qos,timePubClient.getJsonParser().getJsonTimeData(payload));
					log.info("Publish a new time update to sensors: "+payload.toString());
				} catch (MqttException e) {
					// TODO Auto-generated catch block
					log.error("Errors happens when publishing time to sensors!");
					e.printStackTrace();
				}
    			
    		}
        };
        //timePubClient.getScheduler().scheduleAtFixedRate(runnable, 0, 2, TimeUnit.HOURS);
        Client.getScheduler().scheduleAtFixedRate(runnable1, 0, 100, TimeUnit.SECONDS);

    }
	
    public void startTimePublishController(){
        System.out.println("运行到这........");
        // With a valid set of arguments, the real work of
        // driving the client API can begin
        try {
            // Create an instance of this class
        	timePubClient = new MqttClientController(url, clientIdTimePub+ConstantsUtil.getAuth(), cleanSession, quietMode,userName,password);
        	
        	Runnable runnable = new Runnable(){
        		public void run(){
        			TimePayload payload = new TimePayload(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        			try {
						timePubClient.publish(pubTimeTopic,qos,timePubClient.getJsonParser().getJsonTimeData(payload));
						log.info("Publish a new time update to sensors: "+payload.toString());
						System.out.println("Publish a new time update to sensors: "+payload.toString());
					} catch (MqttException e) {
						// TODO Auto-generated catch block
						log.error("Errors happens when publishing time to sensors!");
						e.printStackTrace();
					}
        		}
        	};
        	
        	//timePubClient.getScheduler().scheduleAtFixedRate(runnable, 0, 2, TimeUnit.HOURS);
        	timePubClient.getScheduler().scheduleAtFixedRate(runnable, 0, 3600*2, TimeUnit.SECONDS);
        	
            // Perform the requested action
        	//timePubClient.publish(pubTimeTopic,qos,message.getBytes());
        } catch(MqttException me) {
            // Display full details of any exception that occurs
            log.info("reason "+me.getReasonCode());
            log.info("msg "+me.getMessage());
            log.info("loc "+me.getLocalizedMessage());
            log.info("cause "+me.getCause());
            log.info("excep "+me);
            me.printStackTrace();
        }
    }
    
    public void startTimePublishControllerOnlyOne(){

        // With a valid set of arguments, the real work of
        // driving the client API can begin
        try {
            // Create an instance of this class
        	timePubClient = new MqttClientController(url, clientIdTimePub+ConstantsUtil.getAuth(), cleanSession, quietMode,userName,password);
        	
        	Runnable runnable = new Runnable(){
        		public void run(){
        			TimePayload payload = new TimePayload(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        			try {
						timePubClient.publish(pubTimeTopic,qos,timePubClient.getJsonParser().getJsonTimeData(payload));
						log.info("Publish a new time update to sensors: "+payload.toString());
					} catch (MqttException e) {
						// TODO Auto-generated catch block
						log.error("Errors happens when publishing time to sensors!");
						e.printStackTrace();
					}
        		}
        	};
        	
        	new Thread(runnable).start();

        } catch(MqttException me) {
            // Display full details of any exception that occurs
            log.info("reason "+me.getReasonCode());
            log.info("msg "+me.getMessage());
            log.info("loc "+me.getLocalizedMessage());
            log.info("cause "+me.getCause());
            log.info("excep "+me);
            me.printStackTrace();
        }
    }


    public boolean isQuietMode() {
        return quietMode;
    }

    public void setQuietMode(boolean quietMode) {
        this.quietMode = quietMode;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getQos() {
        return qos;
    }

    public void setQos(int qos) {
        this.qos = qos;
    }

    public String getBroker() {
        return broker;
    }

    public void setBroker(String broker) {
        this.broker = broker;
    }

    public int getPort() {
        return port;
    }

    public void setPort(int port) {
        this.port = port;
    }

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public String getSubTopic() {
        return subTopic;
    }

    public void setSubTopic(String subTopic) {
        this.subTopic = subTopic;
    }

    public String getPubTopic() {
        return pubTopic;
    }

    public void setPubTopic(String pubTopic) {
        this.pubTopic = pubTopic;
    }

    public boolean isCleanSession() {
        return cleanSession;
    }

    public void setCleanSession(boolean cleanSession) {
        this.cleanSession = cleanSession;
    }

    public boolean isSsl() {
        return ssl;
    }

    public void setSsl(boolean ssl) {
        this.ssl = ssl;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getProtocol() {
        return protocol;
    }

    public void setProtocol(String protocol) {
        this.protocol = protocol;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public MqttClientController getClient() {
        return Client;
    }

    public void setClient(MqttClientController client) {
        Client = client;
    }

	/**
	 * @return the pubPlatformTopic
	 */
	public String getPubPlatformTopic() {
		return pubPlatformTopic;
	}

	/**
	 * @param pubPlatformTopic the pubPlatformTopic to set
	 */
	public void setPubPlatformTopic(String pubPlatformTopic) {
		this.pubPlatformTopic = pubPlatformTopic;
	}
    
    
}

