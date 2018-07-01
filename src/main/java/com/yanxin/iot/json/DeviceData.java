package com.yanxin.iot.json;

/**
 * Created by Guozhen Cheng on 2017/6/18.
 */
public class DeviceData {
    private int type;
    private String value;
    private int status;
    private int colour;

    public DeviceData(int type, String value) {
        this.type = type;
        this.value = value;
    }
    
    public DeviceData(int type, String value, int status) {
        this.type = type;
        this.value = value;
        this.status = status;
    }
    
    public DeviceData(int type, String value, int status, int colour) {
        this.type = type;
        this.value = value;
        this.status = status;
        this.colour = colour;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    

    public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
	/**
	 * @return the colour
	 */
	public int getColour() {
		return colour;
	}

	/**
	 * @param colour the colour to set
	 */
	public void setColour(int colour) {
		this.colour = colour;
	}

	@Override
    public String toString() {
        StringBuilder sb = new StringBuilder();

        sb.append("(type="+getType()+" ");
        sb.append("value="+getValue()+" ");
        sb.append("status="+getStatus()+"),");
        sb.append("colour="+getColour()+"),");
        return sb.toString();
    }
}
