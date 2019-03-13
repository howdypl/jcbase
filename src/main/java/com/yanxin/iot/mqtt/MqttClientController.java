/*******************************************************************************
 * Copyright (c) 2009, 2014 IBM Corp.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * and Eclipse Distribution License v1.0 which accompany this distribution. 
 *
 * The Eclipse Public License is available at 
 *    http://www.eclipse.org/legal/epl-v10.html
 * and the Eclipse Distribution License is available at 
 *   http://www.eclipse.org/org/documents/edl-v10.php.
 *
 * Contributors:
 *    Dave Locke - initial API and implementation and/or initial documentation
 */

package com.yanxin.iot.mqtt;

import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.*;

import com.google.gson.JsonSyntaxException;
import com.jcbase.model.PlatformPoint;
import com.jfinal.plugin.activerecord.Db;
import com.yanxin.common.model.Sensor;
import com.yanxin.iot.Utils.ConstantsUtil;
import com.yanxin.iot.json.DeviceData;
import com.yanxin.iot.json.DevicePayload;
import com.yanxin.iot.json.JsonParser;
import org.eclipse.paho.client.mqttv3.*;
import org.eclipse.paho.client.mqttv3.persist.MqttDefaultFilePersistence;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * A sample application that demonstrates how to use the Paho MQTT v3.1 Client blocking API.
 *
 * It can be run from the command line in one of two modes:
 *  - as a publisher, sending a single message to a topic on the server
 *  - as a subscriber, listening for messages from the server
 *
 *  There are three versions of the sample that implement the same features
 *  but do so using using different programming styles:
 *  <ol>
 *  <li>Sample (this one) which uses the API which blocks until the operation completes</li>
 *  <li>SampleAsyncWait shows how to use the asynchronous API with waiters that block until
 *  an action completes</li>
 *  <li>SampleAsyncCallBack shows how to use the asynchronous API where events are
 *  used to notify the application when an action completes<li>
 *  </ol>
 *
 *  If the application is run with the -h parameter then info is displayed that
 *  describes all of the options / parameters.
 */
public class MqttClientController implements MqttCallback {

	private static Logger log = LoggerFactory.getLogger(MqttClientController.class);
	// Private instance variables
	private MqttClient 			client;

	private String 				brokerUrl;
	private boolean 			quietMode;
	private MqttConnectOptions 	conOpt;
	private boolean 			clean;
	private String password;
	private String userName;
		
	private final static short KEEPALIVE_INTERVAL = 120;

	private String jsonPayload;
	private JsonParser jsonParser;

	//private ExecutorService cachedThreadPool;
	private ScheduledExecutorService scheduler;
	
	//private ScheduledExecutorService cmdScheduler;
	
	private ScheduledExecutorService timeScheduler;

	public ScheduledExecutorService getScheduler() {
		return scheduler;
	}

	public void setScheduler(ScheduledExecutorService scheduler) {
		this.scheduler = scheduler;
	}

	/**
	 * Constructs an instance of the sample client wrapper
	 * @param brokerUrl the url of the server to connect to
	 * @param clientId the client id to connect with
	 * @param cleanSession clear state at end of connection or not (durable or non-durable subscriptions)
	 * @param quietMode whether debug should be printed to standard out
	 * @param userName the username to connect with
	 * @param password the password for the user
	 * @throws MqttException
	 */
    public MqttClientController(String brokerUrl, String clientId, boolean cleanSession, boolean quietMode, String userName, String password) throws MqttException {
    	this.brokerUrl = brokerUrl;
    	this.quietMode = quietMode;
    	this.clean 	   = cleanSession;
    	this.password = password;
    	this.userName = userName;
    	this.jsonParser = new JsonParser();
    	//This sample stores in a temporary directory... where messages temporarily
    	// stored until the message has been delivered to the server.
    	//..a real application ought to store them somewhere
    	// where they are not likely to get deleted or tampered with
    	String tmpDir = System.getProperty("java.io.tmpdir");
    	MqttDefaultFilePersistence dataStore = new MqttDefaultFilePersistence(tmpDir);

		//cachedThreadPool = Executors.newCachedThreadPool();
		scheduler = Executors.newScheduledThreadPool(2); // newSingleThreadScheduledExecutor();
		//cmdScheduler = Executors.newSingleThreadScheduledExecutor();
		timeScheduler = Executors.newSingleThreadScheduledExecutor();
		try {
    		// Construct the connection options object that contains connection parameters
    		// such as cleanSession and LWT
	    	conOpt = new MqttConnectOptions();
	    	conOpt.setCleanSession(clean);
	    	if(password != null ) {
	    	  conOpt.setPassword(this.password.toCharArray());
	    	}
	    	if(userName != null) {
	    	  conOpt.setUserName(this.userName);
	    	}

	    	conOpt.setAutomaticReconnect(true);
	    	conOpt.setKeepAliveInterval(KEEPALIVE_INTERVAL);
	    	conOpt.setConnectionTimeout(0);
    		// Construct an MQTT blocking mode client
			client = new MqttClient(this.brokerUrl,clientId, dataStore);

			// Set this wrapper as the callback handler
	    	client.setCallback(this);

		} catch (MqttException e) {
			e.printStackTrace();
			log.info("无法设置客户端: "+e.toString());
			System.exit(1);
		}
    }

		/**
         * Publish / send a message to an MQTT server
         * @param topicName the name of the topic to publish to
         * @param qos the quality of service to delivery the message at (0,1,2)
         * @param payload the set of bytes to send to the MQTT server
         * @throws MqttException
         */
    public void publish(String topicName, int qos, byte[] payload) throws MqttException {

    	// Connect to the MQTT server
    	
    	log.info("[发布命令客户端] 连接到： "+brokerUrl + "，客户端ID是:"+client.getClientId());
    	this.connect2();
		log.info("[发布命令客户端] 连接成功!!");
		
		// this.connect();

    	String time = new Timestamp(System.currentTimeMillis()).toString();
    	log.info("[发布命令客户端] 发布时间为: "+time+ "，主题为: \""+topicName+"\", qos为： "+qos);

    	// Create and configure a message
   		MqttMessage message = new MqttMessage(payload);
    	message.setQos(qos);

    	// Send the message to the server, control is not returned until
    	// it has been delivered to the server meeting the specified
    	// quality of service.
    	MqttTopic mqttTopic = client.getTopic(topicName);
    	
    	mqttTopic.publish(payload,0, false);
		
		// client.publish(topicName, message);

		// Disconnect the client
		// client.disconnect();
		// log.info("[publish client] Publishing client Disconnected");
    }

    /**
     * Subscribe to a topic on an MQTT server
     * Once subscribed this method waits for the messages to arrive from the server
     * that match the subscription. It continues listening for messages until the enter key is
     * pressed.
     * @param topicName to subscribe to (can be wild carded)
     * @param qos the maximum quality of service to receive messages at for this subscription
     * @throws MqttException
     */
    public void subscribe(String topicName, int qos) throws MqttException {

    	// Connect to the MQTT server
		log.info("[订阅消息客户端] 连接到 "+brokerUrl + " ，客户端ID为 "+client.getClientId());
		client.connect(conOpt);
    	log.info("[订阅消息客户端] 连接成功!!");

    	// Subscribe to the requested topic
    	// The QoS specified is the maximum level that messages will be sent to the client at.
    	// For instance if QoS 1 is specified, any messages originally published at QoS 2 will
    	// be downgraded to 1 when delivering to the client but messages published at 1 and 0
    	// will be received at the same level they were published at.
    	log.info("[订阅消息客户端] 订阅主题 \""+topicName+"\" qos "+qos);
    	client.subscribe(topicName, qos);
    	
    	timeScheduler.scheduleAtFixedRate(()->{try {
    												byte[] l =  {0x01};
													client.publish(topicName, l, qos, false);
												} catch (MqttException e) {
													e.printStackTrace();
												}
    										}, 1, 100, TimeUnit.SECONDS);
    	
    }
    
    public JsonParser getJsonParser() {
		return jsonParser;
	}

	public void setJsonParser(JsonParser jsonParser) {
		this.jsonParser = jsonParser;
	}

	/**
     * Utility method to handle logging. If 'quietMode' is set, this method does nothing
     * @param message the message to log
     */
    private void log(String message) {
    	if (!quietMode) {
    		System.out.println(message);
    	}
    }

	/****************************************************************/
	/* Methods to implement the MqttCallback interface              */
	/****************************************************************/

    /**
     * @see MqttCallback#connectionLost(Throwable)
     */
	public void connectionLost(Throwable cause) {
		// Called when the connection to the server has been lost.
		// An application may choose to implement reconnection
		// logic at this point. This sample simply exits.
		//log.debug("Connection to " + brokerUrl + " lost!" + cause);

		// 连接丢失后，一般在这里面进行重连
		log.debug("[MQTT] 连接断开"+brokerUrl+",原因是"+cause+". 30S之后尝试重连...,");
		while (true) {
			try {
				Thread.sleep(30000);
				this.reConnect();
				break;
			} catch (Exception e) {
				e.printStackTrace();
				continue;
			}
		}

	}

    /**
     * @see MqttCallback#deliveryComplete(IMqttDeliveryToken)
     */
	public void deliveryComplete(IMqttDeliveryToken token) {
		// Called when a message has been delivered to the
		// server. The token passed in here is the same one
		// that was passed to or returned from the original call to publish.
		// This allows applications to perform asynchronous
		// delivery without blocking until delivery completes.
		//
		// This sample demonstrates asynchronous deliver and
		// uses the token.waitForCompletion() call in the main thread which
		// blocks until the delivery has completed.
		// Additionally the deliveryComplete method will be called if
		// the callback is set on the client
		//
		// If the connection to the server breaks before delivery has completed
		// delivery of a message will complete after the client has re-connected.
		// The getPendingTokens method will provide tokens for any messages
		// that are still to be delivered.
	}

    /**
     * @see MqttCallback#messageArrived(String, MqttMessage)
     */
	public void messageArrived(String topic, MqttMessage message) throws MqttException {
		// Called when a message arrives from the server that matches any
		// subscription made by the client
		
		String[] unpackTopic = null;
		
		if(null != topic){
			unpackTopic= topic.split("/");
		}
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time = format.format(new Date());

		byte[] data = message.getPayload();
		
		if(unpackTopic!=null && unpackTopic[0].equals("heart") && null != data && data.length>2){
			// System.out.println("==============send Time update and data is not null!!!!!1111");
			// ConstantsUtil.getParser().startTimePublishControllerOnlyOne();
			
			// final DevicePayload dp =devicePayload;
			new Thread(new Runnable(){

				@Override
				public void run() {
					DevicePayload devicePayload = null;
					log.debug("收到心跳消息，主体为："+topic+" !");
					try {
						jsonPayload = new String(data, "UTF-8");
					} catch (UnsupportedEncodingException e) {
						log.error("不支持的编码异常!");
						e.printStackTrace();
					}
					try{
						log.debug("解析心跳载荷...");
						devicePayload = jsonParser.getGson().fromJson(jsonPayload, DevicePayload.class);
						
					} catch (JsonSyntaxException e) {
						e.printStackTrace();
					}
					
					if(null == devicePayload){
						log.warn("收到无法识别的 心跳载荷!");
						return;
					}
					
					for(DeviceData dd:devicePayload.getData()){
					
						switch(dd.getType()){
						case ConstantsUtil.HEART_TYPE_EMITTANCE: //辐射率
							Db.update("update sensor set emittance=? where sensor_code =?", dd.getValue(),devicePayload.getDeviceId());
							break;
						case ConstantsUtil.HEART_TYPE_ALERT_TEMP:  // 守望点告警温度
							Db.update("update sensor set threshold=? where sensor_code =?", dd.getValue(),devicePayload.getDeviceId());
							break;
						case ConstantsUtil.HEART_TYPE_DEFAULT_POINT: // 守望点
							Db.update("update platform_point set defaul=? where pp_sensor_code =? and point_type=?", 1,devicePayload.getDeviceId(),dd.getValue());
							break;
						case ConstantsUtil.HEART_TYPE_TOTAL_POINT: 
							int totalNum = Integer.parseInt(dd.getValue());
							//List<PlatformPoint> ppList = PlatformPoint.dao.find("select * from platform_point where pp_sensor_code=?", devicePayload.getDeviceId());
							Db.update("update sensor set point_num=? where sensor_code=?", totalNum,devicePayload.getDeviceId());
							break;
							default:break;
						}
					}
					long now = System.currentTimeMillis();
					Sensor.me.update(devicePayload.getDeviceId(),0,"0",1,now); //在线更新
					log.debug("更新设备状态为在线："+devicePayload.getDeviceId());
				}
			}).start();
			
			/*for(int i = 0; i<devicePayload.getData().size();i++){
	    		String value = devicePayload.getData().get(i).getValue();
	    		int status = devicePayload.getData().get(i).getStatus();
	    		int type = devicePayload.getData().get(i).getType();
	    		Sensor.me.update(devicePayload.getDeviceId(),type,value,0); // 在线更新
			}*/
		}
	}

	
	/**
	 *  用来连接服务器 有问题
	 */
	private void connect() {

		try {
			if(null != conOpt){
				this.startReconnect();
			}else {
				log.info("The client has not initialized yet!");
				return;
			}

			//topic11 = client.getTopic(TOPIC);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	private void connect2() {

		try {
			if(null != conOpt){
				try {
					if (!client.isConnected()) {
						client.connect(conOpt);
					}
				} catch (MqttSecurityException e) {
					e.printStackTrace();
				} catch (MqttException e) {
					e.printStackTrace();
				} 
			}else {
				log.info("The client has not initialized yet!");
				return;
			}

			//topic11 = client.getTopic(TOPIC);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void reConnect() throws Exception {
         if(null != client) {
             client.connect(conOpt);
         }
     }

	public void	close(){
		if (client != null && client.isConnected()) {
			try {
				client.disconnect();
				scheduler.shutdown();
			} catch (MqttException e) {
				log.info("MQTT 客户端断开连接异常了!");
				e.printStackTrace();
			}
		}
	}

	public void startReconnect() {
		scheduler.scheduleAtFixedRate(new Runnable() {
			public void run() {
				if (!client.isConnected()) {
					try {
						client.connect(conOpt);
					} catch (MqttSecurityException e) {
						e.printStackTrace();
					} catch (MqttException e) {
						e.printStackTrace();
					}
				}
			}
		}, 0, 30* 1000, TimeUnit.MILLISECONDS);
	}

	/****************************************************************/
	/* End of MqttCallback methods                                  */
	/****************************************************************/

	   static void printHelp() {
	      System.out.println(
	          "Syntax:\n\n" +
	              "    Sample [-h] [-a publish|subscribe] [-t <topic>] [-m <message text>]\n" +
	              "            [-s 0|1|2] -b <hostname|IP address>] [-p <brokerport>] [-i <clientID>]\n\n" +
	              "    -h  Print this help text and quit\n" +
	              "    -q  Quiet mode (default is false)\n" +
	              "    -a  Perform the relevant action (default is publish)\n" +
	              "    -t  Publish/subscribe to <topic> instead of the default\n" +
	              "            (publish: \"Sample/Java/v3\", subscribe: \"Sample/#\")\n" +
	              "    -m  Use <message text> instead of the default\n" +
	              "            (\"Message from MQTTv3 Java client\")\n" +
	              "    -s  Use this QoS instead of the default (2)\n" +
	              "    -b  Use this name/IP address instead of the default (m2m.eclipse.org)\n" +
	              "    -p  Use this port instead of the default (1883)\n\n" +
	              "    -i  Use this client ID instead of SampleJavaV3_<action>\n" +
	              "    -c  Connect to the server with a clean session (default is false)\n" +
	              "     \n\n Security Options \n" +
	              "     -u Username \n" +
	              "     -z Password \n" +
	              "     \n\n SSL Options \n" +
	              "    -v  SSL enabled; true - (default is false) " +
	              "    -k  Use this JKS format key store to verify the client\n" +
	              "    -w  Passpharse to verify certificates in the keys store\n" +
	              "    -r  Use this JKS format keystore to verify the server\n" +
	              " If javax.net.ssl properties have been set only the -v flag needs to be set\n" +
	              "Delimit strings containing spaces with \"\"\n\n" +
	              "Publishers transmit a single message then disconnect from the server.\n" +
	              "Subscribers remain connected to the server and receive appropriate\n" +
	              "messages until <enter> is pressed.\n\n"
	          );
    }

		/**
		 * @return the client
		 */
		public MqttClient getClient() {
			return client;
		}

		/**
		 * @param client the client to set
		 */
		public void setClient(MqttClient client) {
			this.client = client;
		}

}
