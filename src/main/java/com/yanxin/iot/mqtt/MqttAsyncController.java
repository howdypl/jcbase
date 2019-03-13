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

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;

import org.eclipse.paho.client.mqttv3.IMqttActionListener;
import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.IMqttToken;
import org.eclipse.paho.client.mqttv3.MqttAsyncClient;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.eclipse.paho.client.mqttv3.MqttTopic;
import org.eclipse.paho.client.mqttv3.persist.MqttDefaultFilePersistence;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.JsonSyntaxException;
import com.jfinal.plugin.activerecord.Db;
import com.yanxin.common.model.Sensor;
import com.yanxin.iot.Utils.ConstantsUtil;
import com.yanxin.iot.json.DeviceData;
import com.yanxin.iot.json.DevicePayload;
import com.yanxin.iot.json.JsonParser;

/**
 * A sample application that demonstrates how to use the Paho MQTT v3.1 Client API in
 * non-blocking callback/notification mode.
 *
 * It can be run from the command line in one of two modes:
 *  - as a publisher, sending a single message to a topic on the server
 *  - as a subscriber, listening for messages from the server
 *
 *  There are three versions of the sample that implement the same features
 *  but do so using using different programming styles:
 *  <ol>
 *  <li>Sample which uses the API which blocks until the operation completes</li>
 *  <li>SampleAsyncWait shows how to use the asynchronous API with waiters that block until
 *  an action completes</li>
 *  <li>SampleAsyncCallBack (this one) shows how to use the asynchronous API where events are
 *  used to notify the application when an action completes<li>
 *  </ol>
 *
 *  If the application is run with the -h parameter then info is displayed that
 *  describes all of the options / parameters.
 */
public class MqttAsyncController implements MqttCallback {

	int state = BEGIN;

	static final int BEGIN = 0;
	static final int CONNECTED = 1;
	static final int PUBLISHED = 2;
	static final int SUBSCRIBED = 3;
	static final int DISCONNECTED = 4;
	static final int FINISH = 5;
	static final int ERROR = 6;
	static final int DISCONNECT = 7;

	private static Logger log = LoggerFactory.getLogger(MqttClientController.class);
	
	private String 				brokerUrl;
	private boolean 			quietMode;
	private MqttConnectOptions 	conOpt;
	private boolean 			clean;
	private String password;
	private String userName;
		
	private final static short KEEPALIVE_INTERVAL = 120;

	private String jsonPayload;
	private JsonParser jsonParser;

	private ExecutorService cachedThreadPool;
	private ScheduledExecutorService scheduler;
	
	private ScheduledExecutorService cmdScheduler;
	
	private ScheduledExecutorService timeScheduler;
	
	// Private instance variables
	MqttAsyncClient 	client;
	Throwable 			ex = null;
	Object 				waiter = new Object();
	boolean 			donext = false;


	/**
	 * Constructs an instance of the sample client wrapper
	 * @param brokerUrl the url to connect to
	 * @param clientId the client id to connect with
	 * @param cleanSession clear state at end of connection or not (durable or non-durable subscriptions)
	 * @param quietMode whether debug should be printed to standard out
	 * @param userName the username to connect with
	 * @param password the password for the user
	 * @throws MqttException
	 */
	public MqttAsyncController(String brokerUrl, String clientId, boolean cleanSession, boolean quietMode,
			String userName, String password) throws MqttException {
		this.brokerUrl = brokerUrl;
		this.quietMode = quietMode;
		this.clean = cleanSession;
		this.password = password;
		this.userName = userName;
		// This sample stores in a temporary directory... where messages
		// temporarily
		// stored until the message has been delivered to the server.
		// ..a real application ought to store them somewhere
		// where they are not likely to get deleted or tampered with
		String tmpDir = System.getProperty("java.io.tmpdir");
		MqttDefaultFilePersistence dataStore = new MqttDefaultFilePersistence(tmpDir);

		//cachedThreadPool = Executors.newCachedThreadPool();
		scheduler = Executors.newScheduledThreadPool(2); // newSingleThreadScheduledExecutor();
		//cmdScheduler = Executors.newSingleThreadScheduledExecutor();
		timeScheduler = Executors.newSingleThreadScheduledExecutor();
		
		try {
			// Construct the object that contains connection parameters
			// such as cleanSession and LWT
			conOpt = new MqttConnectOptions();
			conOpt.setCleanSession(clean);
			if (password != null) {
				conOpt.setPassword(this.password.toCharArray());
			}
			if (userName != null) {
				conOpt.setUserName(this.userName);
			}

			// Construct the MqttClient instance
			client = new MqttAsyncClient(this.brokerUrl, clientId, dataStore);

			// Set this wrapper as the callback handler
			client.setCallback(this);

		} catch (MqttException e) {
			e.printStackTrace();
			log("无法设置客户端: " + e.toString());
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
    public void publish(String topicName, int qos, byte[] payload) throws Throwable {
    	// Use a state machine to decide which step to do next. State change occurs
    	// when a notification is received that an MQTT action has completed
    	while (state != FINISH) {
    		switch (state) {
    			case BEGIN:
    				// Connect using a non-blocking connect
    		    	MqttConnector con = new MqttConnector();
    		    	con.doConnect();
    				break;
    			case CONNECTED:
    				// Publish using a non-blocking publisher
    				Publisher pub = new Publisher();
    				pub.doPublish(topicName, qos, payload);
    				break;
    			case PUBLISHED:
    				state = DISCONNECT;
    				donext = true;
    				break;
    			case DISCONNECT:
    				Disconnector disc = new Disconnector();
    				disc.doDisconnect();
    				break;
    			case ERROR:
    				throw ex;
    			case DISCONNECTED:
    				state = FINISH;
    				donext = true;
    				break;
    		}

//    		if (state != FINISH) {
    			// Wait until notified about a state change and then perform next action
    			waitForStateChange(10000);
//    		}
    	}
    }

    /**
     * Wait for a maximum amount of time for a state change event to occur
     * @param maxTTW  maximum time to wait in milliseconds
     * @throws MqttException
     */
	private void waitForStateChange(int maxTTW ) throws MqttException {
		synchronized (waiter) {
    		if (!donext ) {
    			try {
					waiter.wait(maxTTW);
				} catch (InterruptedException e) {
					log("超时");
					e.printStackTrace();
				}

				if (ex != null) {
					throw (MqttException)ex;
				}
    		}
    		donext = false;
    	}
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
    public void subscribe(String topicName, int qos) throws Throwable {
    	// Use a state machine to decide which step to do next. State change occurs
    	// when a notification is received that an MQTT action has completed
    	while (state != FINISH) {
    		switch (state) {
    			case BEGIN:
    				// Connect using a non-blocking connect
    		    	MqttConnector con = new MqttConnector();
    		    	con.doConnect();
    				break;
    			case CONNECTED:
    				// Subscribe using a non-blocking subscribe
    				Subscriber sub = new Subscriber();
    				sub.doSubscribe(topicName, qos);
    				break;
    			case SUBSCRIBED:
    		    	// Block until Enter is pressed allowing messages to arrive
    		    	/*log("Press <Enter> to exit");
    				try {
    					System.in.read();
    				} catch (IOException e) {
    					//If we can't read we'll just exit
    				}*/
    				state = DISCONNECT;
    				donext = true;
    				break;
    			case DISCONNECT:
    				Disconnector disc = new Disconnector();
    				disc.doDisconnect();
    				break;
    			case ERROR:
    				throw ex;
    			case DISCONNECTED:
    				state = FINISH;
    				donext = true;
    				break;
    		}

    		if (state != FINISH && state != DISCONNECT) {
    			waitForStateChange(10000);
    		}
    	}
    }

    /**
     * Utility method to handle logging. If 'quietMode' is set, this method does nothing
     * @param message the message to log
     */
    void log(String message) {
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
		log("Connection to " + brokerUrl + " lost!" + cause);
		System.exit(1);
	}

    /**
     * @see MqttCallback#deliveryComplete(IMqttDeliveryToken)
     */
	public void deliveryComplete(IMqttDeliveryToken token) {
		// Called when a message has been delivered to the
		// server. The token passed in here is the same one
		// that was returned from the original call to publish.
		// This allows applications to perform asynchronous
		// delivery without blocking until delivery completes.
		//
		// This sample demonstrates asynchronous deliver, registering
		// a callback to be notified on each call to publish.
		//
		// The deliveryComplete method will also be called if
		// the callback is set on the client
		//
		// note that token.getTopics() returns an array so we convert to a string
		// before printing it on the console
		log("Delivery complete callback: Publish Completed "+Arrays.toString(token.getTopics()));
	}

    /**
     * @see MqttCallback#messageArrived(String, MqttMessage)
     */
	public void messageArrived(String topic, MqttMessage message) throws MqttException {
		// Called when a message arrives from the server that matches any
		// subscription made by the client
		String time = new Timestamp(System.currentTimeMillis()).toString();
		System.out.println("Time:\t" +time +
                           "  Topic:\t" + topic +
                           "  Message:\t" + new String(message.getPayload()) +
                           "  QoS:\t" + message.getQos());
		
		
		String[] unpackTopic = null;
		
		if(null != topic){
			unpackTopic= topic.split("/");
		}
		
		byte[] data = message.getPayload();
		
		if(unpackTopic!=null && unpackTopic[0].equals("heart") && null != data){
			// System.out.println("==============send Time update and data is not null!!!!!1111");
			// ConstantsUtil.getParser().startTimePublishControllerOnlyOne();
			
			// final DevicePayload dp =devicePayload;
			new Thread(new Runnable(){

				@Override
				public void run() {
					DevicePayload devicePayload = null;
					log.info("收到心跳消息，主体为："+topic+" !");
					try {
						jsonPayload = new String(data, "UTF-8");
					} catch (UnsupportedEncodingException e) {
						log.error("不支持的编码异常!");
						e.printStackTrace();
					}
					try{
						log.info("解析心跳载荷...");
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
					Sensor.me.update(devicePayload.getDeviceId(),0,"0",0,now); //在线更新
					log.info("更新设备状态为在线："+devicePayload.getDeviceId());
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

	/****************************************************************/
	/* End of MqttCallback methods                                  */
	/****************************************************************/
    static void printHelp() {
      System.out.println(
          "Syntax:\n\n" +
              "    SampleAsyncCallBack [-h] [-a publish|subscribe] [-t <topic>] [-m <message text>]\n" +
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
	 * Connect in a non-blocking way and then sit back and wait to be
	 * notified that the action has completed.
	 */
    public class MqttConnector {

		public MqttConnector() {
		}

		public void doConnect() {
	    	// Connect to the server
			// Get a token and setup an asynchronous listener on the token which
			// will be notified once the connect completes
	    	log("连接到 "+brokerUrl + " ，客户端ID为 "+client.getClientId());

	    	IMqttActionListener conListener = new IMqttActionListener() {
				public void onSuccess(IMqttToken asyncActionToken) {
			    	log.info("连接成功！");
			    	state = CONNECTED;
			    	carryOn();
				}

				public void onFailure(IMqttToken asyncActionToken, Throwable exception) {
					ex = exception;
					state = ERROR;
					log.info("连接失败了" +exception);
					carryOn();
				}

				public void carryOn() {
			    	synchronized (waiter) {
			    		donext=true;
			    		waiter.notifyAll();
			    	}
				}
			};

	    	try {
	    		// Connect using a non-blocking connect
	    		client.connect(conOpt,"Connect sample context", conListener);
			} catch (MqttException e) {
				// If though it is a non-blocking connect an exception can be
				// thrown if validation of parms fails or other checks such
				// as already connected fail.
				state = ERROR;
				donext = true;
				ex = e;
			}
		}
	}

	/**
	 * Publish in a non-blocking way and then sit back and wait to be
	 * notified that the action has completed.
	 */
	public class Publisher {
		public void doPublish(String topicName, int qos, byte[] payload) {
		 	// Send / publish a message to the server
			// Get a token and setup an asynchronous listener on the token which
			// will be notified once the message has been delivered
	   		MqttMessage message = new MqttMessage(payload);
	    	message.setQos(qos);


	    	String time = new Timestamp(System.currentTimeMillis()).toString();
	    	log.info("在时间: "+time+ " 发布到主题 \""+topicName+"\" qos "+qos);

	    	// Setup a listener object to be notified when the publish completes.
	    	//
	    	IMqttActionListener pubListener = new IMqttActionListener() {
				public void onSuccess(IMqttToken asyncActionToken) {
					log.info("发布完成...");
			    	state = PUBLISHED;
			    	carryOn();
				}

				public void onFailure(IMqttToken asyncActionToken, Throwable exception) {
					ex = exception;
					state = ERROR;
					log.info("发布失败了..." +exception);
					carryOn();
				}

				public void carryOn() {
			    	synchronized (waiter) {
			    		donext=true;
			    		waiter.notifyAll();
			    	}
				}
			};

	    	try {
		    	// Publish the message
	    		
	    		client.publish(topicName, message, "发布文示例上下文", pubListener);
	    	} catch (MqttException e) {
				state = ERROR;
				donext = true;
				ex = e;
			}
		}
	}

	/**
	 * Subscribe in a non-blocking way and then sit back and wait to be
	 * notified that the action has completed.
	 */
	public class Subscriber {
		public void doSubscribe(String topicName, int qos) {
		 	// Make a subscription
			// Get a token and setup an asynchronous listener on the token which
			// will be notified once the subscription is in place.
			log.info("订阅到主题 \""+topicName+"\"的消息， qos "+qos);

	    	IMqttActionListener subListener = new IMqttActionListener() {
				public void onSuccess(IMqttToken asyncActionToken) {
					log.info("订阅完成...");
			    	state = SUBSCRIBED;
			    	carryOn();
				}

				public void onFailure(IMqttToken asyncActionToken, Throwable exception) {
					ex = exception;
					state = ERROR;
					log.info("订阅失败了..." +exception);
					carryOn();
				}

				public void carryOn() {
			    	synchronized (waiter) {
			    		donext=true;
			    		waiter.notifyAll();
			    	}
				}
			};

	    	try {
	    		client.subscribe(topicName, qos, "订阅示例上下文", subListener);
	    	} catch (MqttException e) {
				state = ERROR;
				donext = true;
				ex = e;
			}
		}
	}

	/**
	 * Disconnect in a non-blocking way and then sit back and wait to be
	 * notified that the action has completed.
	 */
	public class Disconnector {
		public void doDisconnect() {
	    	// Disconnect the client
			log.info("断开连接了...");

	    	IMqttActionListener discListener = new IMqttActionListener() {
				public void onSuccess(IMqttToken asyncActionToken) {
					log.info("断开连接完成了...");
			    	state = DISCONNECTED;
			    	carryOn();
				}

				public void onFailure(IMqttToken asyncActionToken, Throwable exception) {
					ex = exception;
					state = ERROR;
					log.info("断开连接失败了..." +exception);
					carryOn();
				}
				public void carryOn() {
			    	synchronized (waiter) {
			    		donext=true;
			    		waiter.notifyAll();
			    	}
				}
			};

	    	try {
	    		client.disconnect("断开连接示例上下文", discListener);
	    	} catch (MqttException e) {
				state = ERROR;
				donext = true;
				ex = e;
			}
		}
	}
	public ScheduledExecutorService getCmdScheduler() {
		return cmdScheduler;
	}

	public void setCmdScheduler(ScheduledExecutorService cmdScheduler) {
		this.cmdScheduler = cmdScheduler;
	}

	public ScheduledExecutorService getTimeScheduler() {
		return timeScheduler;
	}

	public void setTimeScheduler(ScheduledExecutorService timeScheduler) {
		this.timeScheduler = timeScheduler;
	}

	public ExecutorService getCachedThreadPool() {
		return cachedThreadPool;
	}

	public void setCachedThreadPool(ExecutorService cachedThreadPool) {
		this.cachedThreadPool = cachedThreadPool;
	}
	

	public ScheduledExecutorService getScheduler() {
		return scheduler;
	}

	public void setScheduler(ScheduledExecutorService scheduler) {
		this.scheduler = scheduler;
	}
	
    public JsonParser getJsonParser() {
		return jsonParser;
	}

	public void setJsonParser(JsonParser jsonParser) {
		this.jsonParser = jsonParser;
	}
	
	/**
	 * The main entry point of the sample.
	 *
	 * This method handles parsing the arguments specified on the
	 * command-line before performing the specified action.
	 */
	public static void main(String[] args) {

		// Default settings:
		boolean quietMode 	= false;
		String action 		= "publish";
		String topic 		= "";
		String message 		= "Message from async callback Paho MQTTv3 Java client sample";
		int qos 			= 0;
		String broker 		= "localhost";
		int port 			= 61613;
		String clientId 	= null;
		String subTopic		= "Sample/#";
		String pubTopic 	= "Sample/Java/v3";
		boolean cleanSession = true;			// Non durable subscriptions
		boolean ssl = false;
		String password = "password";
		String userName = "admin";

		// Parse the arguments -
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
					System.out.println("Missing value for argument: "+args[i]);
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
          case 'v': ssl = Boolean.valueOf(args[++i]).booleanValue();  break;
          case 'u': userName = args[++i];               break;
          case 'z': password = args[++i];               break;
					default:
						System.out.println("Unrecognised argument: "+args[i]);
						printHelp();
						return;
				}
			} else {
				System.out.println("Unrecognised argument: "+args[i]);
				printHelp();
				return;
			}
		}

		// Validate the provided arguments
		if (!action.equals("publish") && !action.equals("subscribe")) {
			System.out.println("Invalid action: "+action);
			printHelp();
			return;
		}
		if (qos < 0 || qos > 2) {
			System.out.println("Invalid QoS: "+qos);
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

		String protocol = "tcp://";

    if (ssl) {
      protocol = "ssl://";
    }

    String url = protocol + broker + ":" + port;

		if (clientId == null || clientId.equals("")) {
			clientId = "SampleJavaV3_"+action;
		}

		// With a valid set of arguments, the real work of
		// driving the client API can begin
		try {
			// Create an instance of the Sample client wrapper
			MqttAsyncController sampleClient = new MqttAsyncController(url,clientId,cleanSession, quietMode,userName,password);

			// Perform the specified action
			if (action.equals("publish")) {
				sampleClient.publish(topic,qos,message.getBytes());
			} else if (action.equals("subscribe")) {
				sampleClient.subscribe(topic,qos);
			}
		} catch(MqttException me) {
			// Display full details of any exception that occurs
			System.out.println("reason "+me.getReasonCode());
			System.out.println("msg "+me.getMessage());
			System.out.println("loc "+me.getLocalizedMessage());
			System.out.println("cause "+me.getCause());
			System.out.println("excep "+me);
			me.printStackTrace();
		} catch (Throwable th) {
			System.out.println("Throwable caught "+th);
			th.printStackTrace();
		}
	}
	
	
	
	
	
	
}