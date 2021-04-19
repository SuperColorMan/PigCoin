package com.server_0.comm.enums;

/**
 * @ClassName IndexRecommendPageTypeEnum
 * @Description 首页推荐页内容类型枚举
 * @Author SuperColorMan
 * @Date 2021/2/18 4:32 下午
 * @ModifyDate 2021/2/18 4:32 下午
 * @Version 1.0
 */
public enum IndexRecommendPageTypeEnum {
    HOT(0, "热门"),
    NEW(1, "最新"),
    IMGANDTEXT(2, "图文"),
    TEXT(3, "段子"),
    HOTCOMMENT(4, "神评");
    private int type;
    private String des;

    IndexRecommendPageTypeEnum(int type, String des) {
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
