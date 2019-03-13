package com.yanxin.iot.json2;

import java.util.List;

/**
 * Created by zhushiyuan on 2018/2/26.
 */

public class RegionBean {
    private String regionName;
    private List<PassageEquipBean> equipList;

    public String getRegionName() {
        return regionName;
    }

    public void setRegionName(String regionName) {
        this.regionName = regionName;
    }

    public List<PassageEquipBean> getEquipList() {
        return equipList;
    }

    public void setEquipList(List<PassageEquipBean> equipList) {
        this.equipList = equipList;
    }
}
