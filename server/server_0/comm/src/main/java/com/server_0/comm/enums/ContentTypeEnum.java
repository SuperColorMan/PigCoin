package com.server_0.comm.enums;

/**
 * @ClassName ContentTypeEnum
 * @Description 内容类型枚举
 * @Author SuperColorMan
 * @Date 2021/1/4 2:31 下午
 * @ModifyDate 2021/1/4 2:31 下午
 * @Version 1.0
 */
public enum ContentTypeEnum {
    CONTENT(0, "内容"),
    COMMENT(1, "评论"),
    REPLY(2, "回复"),
    COMMODITY(3, "商品");
    /**
     * 类型
     */
    private int type;
    /**
     * 描述
     */
    private String des;

    ContentTypeEnum(int type, String des) {
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
