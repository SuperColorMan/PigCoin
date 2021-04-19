package com.server_0.comm.enums;

/**
 * @ClassName CommoditySrcTypeEnum
 * @Description 商品来源类型枚举
 * @Author SuperColorMan
 * @Date 2021/2/4 10:43 上午
 * @ModifyDate 2021/2/4 10:43 上午
 * @Version 1.0
 */
public enum CommoditySrcTypeEnum {
    USER(0, "用户"),
    MERCHANT(1, "商家");
    /**
     * 类型
     */
    private int type;
    /**
     * 描述
     */
    private String des;

    CommoditySrcTypeEnum(int type, String des) {
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
