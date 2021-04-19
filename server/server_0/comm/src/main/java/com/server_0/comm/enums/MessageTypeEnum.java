package com.server_0.comm.enums;

/**
 * @ClassName MessageTypeEnum
 * @Description 消息类型枚举
 * @Author SuperColorMan
 * @Date 2021/2/18 9:54 上午
 * @ModifyDate 2021/2/18 9:54 上午
 * @Version 1.0
 */
public enum MessageTypeEnum {
    SYS(0, "系统通知"),
    CHAT(1, "私信消息");
    private int type;
    private String des;

    MessageTypeEnum(int type, String des) {
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
