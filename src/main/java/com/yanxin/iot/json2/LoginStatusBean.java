package com.yanxin.iot.json2;

public class LoginStatusBean {
	
	// 1:成功，2错误
	private int login;

	public LoginStatusBean() {
		
	}
	
	public LoginStatusBean(int login) {
		this.login = login;
	}

	public int getLogin() {
		return login;
	}

	public void setLogin(int login) {
		this.login = login;
	}

	
}
