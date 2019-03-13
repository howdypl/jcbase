/**
 * 
 */
package com.yanxin.mobile.update.bean;

/**
 * @author hwtd
 *
 */
public class UpdateInfo {

	private int id;
	private String code;
	private String ywbIdStr;
	private String desc;
	private boolean isimport;
	
	private String uploadurl;
	private String sendtime;
	private String msg;
	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}
	/**
	 * @return the code
	 */
	public String getCode() {
		return code;
	}
	/**
	 * @param code the code to set
	 */
	public void setCode(String code) {
		this.code = code;
	}
	/**
	 * @return the ywbIdStr
	 */
	public String getYwbIdStr() {
		return ywbIdStr;
	}
	/**
	 * @param ywbIdStr the ywbIdStr to set
	 */
	public void setYwbIdStr(String ywbIdStr) {
		this.ywbIdStr = ywbIdStr;
	}
	/**
	 * @return the desc
	 */
	public String getDesc() {
		return desc;
	}
	/**
	 * @param desc the desc to set
	 */
	public void setDesc(String desc) {
		this.desc = desc;
	}
	/**
	 * @return the isimport
	 */
	public boolean isIsimport() {
		return isimport;
	}
	/**
	 * @param isimport the isimport to set
	 */
	public void setIsimport(boolean isimport) {
		this.isimport = isimport;
	}
	/**
	 * @return the uploadurl
	 */
	public String getUploadurl() {
		return uploadurl;
	}
	/**
	 * @param uploadurl the uploadurl to set
	 */
	public void setUploadurl(String uploadurl) {
		this.uploadurl = uploadurl;
	}
	/**
	 * @return the sendtime
	 */
	public String getSendtime() {
		return sendtime;
	}
	/**
	 * @param sendtime the sendtime to set
	 */
	public void setSendtime(String sendtime) {
		this.sendtime = sendtime;
	}
	/**
	 * @return the msg
	 */
	public String getMsg() {
		return msg;
	}
	/**
	 * @param msg the msg to set
	 */
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
}
