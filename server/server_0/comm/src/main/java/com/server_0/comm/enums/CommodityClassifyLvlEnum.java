package com.server_0.comm.enums;

/**
 * @ClassName CommodityClassifyEnum
 * @Description 商品分类级别枚举
 * @Author SuperColorMan
 * @Date 2021/2/2 2:03 下午
 * @ModifyDate 2021/2/2 2:03 下午
 * @Version 1.0
 */
public enum CommodityClassifyLvlEnum {
    BIG(0, "大类"),
    MEDIUM(1, "中类"),
    SMALL(2, "小类");
    /**
     * 类型
     */
    private int type;
    /**
     * 描述
     */
    private String des;

    CommodityClassifyLvlEnum(int type, String des) {
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
