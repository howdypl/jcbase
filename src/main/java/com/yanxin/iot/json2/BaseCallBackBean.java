package com.yanxin.iot.json2;

/**
 * Created by zhushiyuan on 2017/12/4.
 */

public class BaseCallBackBean<T> {
    /**
     * status : 1
     * msg : 成功
     * data :
     */
    private int status;
    private String msg;
    private T data;

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
