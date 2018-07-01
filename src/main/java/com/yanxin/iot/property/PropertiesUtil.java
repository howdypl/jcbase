package com.yanxin.iot.property;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

/**
 * Created by Guozhen Cheng on 2017/6/11.
 */
public class PropertiesUtil {

    private static final Logger log = LoggerFactory.getLogger(PropertiesUtil.class);

    private static ResourceLoader loader = ResourceLoader.getInstance();
    private static ConcurrentMap<String, String> configMap = new ConcurrentHashMap<String, String>();
    private static final String DEFAULT_CONFIG_FILE = "iclient.properties";

    private static Properties prop = null;

    public static String getStringByKey(String key, String propName) {
        try {
            prop = loader.getPropFromProperties(propName);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        key = key.trim();
        if (!configMap.containsKey(key)) {
            if (prop.getProperty(key) != null) {
                configMap.put(key, prop.getProperty(key));
            }
        }
        return configMap.get(key);
    }

    public static String getStringByKey(String key) {
        return getStringByKey(key, DEFAULT_CONFIG_FILE);
    }

    public static Properties getProperties() {
        try {
            return loader.getPropFromProperties(DEFAULT_CONFIG_FILE);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
/*
 * test configure file
 *     public static void main( String[] args ){
    	String str = PropertiesUtil.getStringByKey("mqtt_quietMode");
    	
    	if(null != str){
    		log.info("get quietmode"+str);
    	}
    }*/
}
