/**
 * 
 */
package com.yanxin.iot.json2;

/**
 * @author YT
 *
 */
public class SimpleWorkTicketBean {
	
    private String ticketNumber;//工作票唯一编号，如果当时变电站有工作票正在进行
    private String person;//工作票负责人，是否为空同上
    private String phone;//负责人电话，是否为空同上
    
	public String getTicketNumber() {
		return ticketNumber;
	}
	public void setTicketNumber(String ticketNumber) {
		this.ticketNumber = ticketNumber;
	}
	public String getPerson() {
		return person;
	}
	public void setPerson(String person) {
		this.person = person;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
    
}
