package com.server_0.comm.enums;

/**
 * @ClassName MoneyUnitEnum
 * @Description 货币单位枚举
 * @Author SuperColorMan
 * @Date 2021/3/5 5:34 下午
 * @ModifyDate 2021/3/5 5:34 下午
 * @Version 1.0
 */
public enum MoneyUnitEnum {
    RMB("¥","人民币");
    /**
     * 单位
     * */
    private String unit;
    /**
     * 描述
     * */
    private String des;

    MoneyUnitEnum(String unit, String des) {
        this.unit = unit;
        this.des = des;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }
}
