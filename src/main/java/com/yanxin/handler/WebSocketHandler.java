/**
 * 
 */
package com.yanxin.handler;

import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jfinal.handler.Handler;
import com.jfinal.kit.StrKit;

/**
 * @author Guozhen Cheng
 *
 */
public class WebSocketHandler extends Handler {
	
	private Pattern filterUrlRegxPattern;
	
	public WebSocketHandler(String filterUrlRegx) {
		if (StrKit.isBlank(filterUrlRegx))
			throw new IllegalArgumentException("The para filterUrlRegx can not be blank.");
		filterUrlRegxPattern = Pattern.compile(filterUrlRegx);
	}

	/* (non-Javadoc)
	 * @see com.jfinal.handler.Handler#handle(java.lang.String, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, boolean[])
	 */
	@Override
	public void handle(String target, HttpServletRequest request, HttpServletResponse response, boolean[] isHandled) {
		if (filterUrlRegxPattern.matcher(target).find()){
			return ;
		}else{
			next.handle(target, request, response, isHandled);
		}
	}

}
