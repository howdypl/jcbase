package com.yanxin.iot.json2;

/**
 * Created by zhushiyuan on 2018/2/28.
 * 用户信息
 */

public class UserBean {
    private String userName;
    private String userPhone;
    private String password;
    private String ywb;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getYwb() {
        return ywb;
    }

    public void setYwb(String ywb) {
        this.ywb = ywb;
    }
}
