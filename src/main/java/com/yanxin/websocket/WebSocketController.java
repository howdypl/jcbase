/**
 * 
 */
package com.yanxin.websocket;

import java.io.IOException;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * @author Guozhen Cheng
 * @ServerEndpoint 注解是一个类层次的注解，它的功能主要是将目前的类定义成一个websocket服务器端,
 * 注解的值将被用于监听用户连接的终端访问URL地址,客户端可以通过这个URL来连接到WebSocket服务器端
 */
@ServerEndpoint(value="/websocket/{username}")
public class WebSocketController {
	//静态变量，用来记录当前在线连接数。应该把它设计成线程安全的。
	private static int onlineCount = 0;
	private final static Logger log = LoggerFactory.getLogger(WebSocketController.class);
	private static CopyOnWriteArraySet<WebSocketController> webSocketSet = new CopyOnWriteArraySet<WebSocketController>();
    // private static ConcurrentHashMap<String, WSBean> webSocketMap = new  ConcurrentHashMap<String, WSBean>();
    
    //与某个客户端的连接会话，需要通过它来给客户端发送数据
    private Session session;
    private String name;
    /**
      * 连接建立成功调用的方法
      * @param username 
      * @param session  可选的参数。session为与某个客户端的连接会话，需要通过它来给客户端发送数据
      */
	@OnOpen
	public void onOpen(@PathParam("username") String username,Session session) {
		
		this.session = session;
		// bean.setWsc(this);
		this.setName(username);
		WebSocketController.webSocketSet.add(this); //加入set中
		// bean.setName(username);
		addOnlineCount();
		log.info("websocket username="+username);
		
		log.info("有新连接加入！当前在线人数为" + getOnlineCount());
       
	}	
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	@OnClose
	public void onClose(Session session) {
		subOnlineCount();
		WebSocketController.webSocketSet.remove(this);  //从set中删除
	}	
	@OnMessage
	public void onMessage(String requestJson, Session session) {		
		try {
			
			session.getBasicRemote().sendText(requestJson);
		} catch (IOException e) {
			
			e.printStackTrace();
		}
	}
	
	public void sendMessage(String message) throws IOException {
        this.session.getBasicRemote().sendText(message);
    }
	
	 /**
     * 群发自定义消息
     * */
    public static void sendInfo(String message) throws IOException {
        for (WebSocketController item : WebSocketController.webSocketSet) {
            try {
            	item.sendMessage(message);
            } catch (IOException e) {
                continue;
            }
        }
    }
	/**
	 * @return the webSocketSet
	 */
	public static CopyOnWriteArraySet<WebSocketController> getWebSocketSet() {
		return WebSocketController.webSocketSet;
	}

	/**
	 * @param webSocketSet
	 * the webSocketSet to set
	 */
	public static void setWebSocketSet(CopyOnWriteArraySet<WebSocketController> webSocketSet) {
		WebSocketController.webSocketSet = webSocketSet;
	}

	public static synchronized int getOnlineCount() {
		return onlineCount;
	}

	public static synchronized void addOnlineCount() {
		onlineCount++;
	}

	public static synchronized void subOnlineCount() {
		WebSocketController.onlineCount--;
	}

}
