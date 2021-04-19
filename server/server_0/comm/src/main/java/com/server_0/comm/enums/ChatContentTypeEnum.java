package com.server_0.comm.enums;

/**
 * @ClassName ChatContentTypeEnum
 * @Description 对话内容类型枚举
 * @Author SuperColorMan
 * @Date 2021/2/20 9:04 上午
 * @ModifyDate 2021/2/20 9:04 上午
 * @Version 1.0
 */
public enum ChatContentTypeEnum {
    TEXT(0, "纯文字"),
    LOCALIMG(1, "本地图片"),
    NETIMG(2, "网络图片"),
    COMMODITY(3, "商品");
    /**
     * 类型
     */
    private int type;
    /**
     * 描述
     */
    private String des;

    ChatContentTypeEnum(int type, String des) {
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
