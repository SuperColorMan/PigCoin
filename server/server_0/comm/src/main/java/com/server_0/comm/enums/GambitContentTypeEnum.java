package com.server_0.comm.enums;
/**
 * @ClassName GambitContentTypeEnum
 * @Description 话题内容类型枚举
 * @Author SuperColorMan
 * @Date 2021/1/4 2:31 下午
 * @ModifyDate 2021/1/4 2:31 下午
 * @Version 1.0
 */
public enum GambitContentTypeEnum {
    NEW(0,"最新"),
    HOT(1,"最热"),
    HOTCOMMENT(2,"神评专区");
    /**
     * 类型
     */
    private int type;
    /**
     * 描述
     */
    private String des;

    GambitContentTypeEnum(int type, String des) {
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
