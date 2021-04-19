package com.server_0.comm.enums;

/**
 * @ClassName LocalInfoTypeEnum
 * @Description 地理信息类型枚举
 * @Author SuperColorMan
 * @Date 2021/1/4 2:31 下午
 * @ModifyDate 2021/1/4 2:31 下午
 * @Version 1.0
 */
public enum LocalInfoTypeEnum {
    USER(0, "用户"),
    CONTENT(1, "内容");
    private int type;
    private String des;

    LocalInfoTypeEnum(int type, String des) {
        this.type = type;
        this.des = des;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }
}
