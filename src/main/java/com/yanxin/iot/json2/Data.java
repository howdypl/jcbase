/**
 * 
 */
package com.yanxin.iot.json2;

/**
 * @author Cheng Guozhen
 * 
 */
public class Data<T> {
	
	private int totalPage;
	private int totalItem;
	private boolean isFirst;
	private boolean isLast;
	private T page;
	/**
	 * @return the totalPage
	 */
	public int getTotalPage() {
		return totalPage;
	}
	/**
	 * @param totalPage the totalPage to set
	 */
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	/**
	 * @return the totalItem
	 */
	public int getTotalItem() {
		return totalItem;
	}
	/**
	 * @param totalItem the totalItem to set
	 */
	public void setTotalItem(int totalItem) {
		this.totalItem = totalItem;
	}
	/**
	 * @return the page
	 */
	public T getPage() {
		return page;
	}
	/**
	 * @param page the page to set
	 */
	public void setPage(T page) {
		this.page = page;
	}
	/**
	 * @return the isFirst
	 */
	public boolean isFirst() {
		return isFirst;
	}
	/**
	 * @param isFirst the isFirst to set
	 */
	public void setFirst(boolean isFirst) {
		this.isFirst = isFirst;
	}
	/**
	 * @return the isLast
	 */
	public boolean isLast() {
		return isLast;
	}
	/**
	 * @param isLast the isLast to set
	 */
	public void setLast(boolean isLast) {
		this.isLast = isLast;
	}

}
