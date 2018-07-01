/**
 * 
 */
package com.yanxin.cmd;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import com.jfinal.log.LogManager;

/**
 * @author Cheng Guozhen
 * 
 */
public class StreamGobbler extends Thread {
	
	InputStream is;
	
	String type;
	
	
	

	public StreamGobbler(InputStream is, String type) {
		super();
		this.is = is;
		this.type = type;
	}

	/* (non-Javadoc)
	 * @see java.lang.Thread#run()
	 */
	@Override
	public void run() {
		try {
			InputStreamReader isr = new InputStreamReader(is);
			BufferedReader bReader = new BufferedReader(isr);
			String line = null;
			while((line = bReader.readLine()) != null){
				if(type.equals("Error")){
					System.err.println(line);
				}else{
					System.out.println(line);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
