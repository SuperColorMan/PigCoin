package com.server_0.comm.enums;

/**
 * @ClassName IndexPageContentTypeEnum
 * @Description 首页内容类型枚举
 * @Author SuperColorMan
 * @Date 2021/2/18 4:37 下午
 * @ModifyDate 2021/2/18 4:37 下午
 * @Version 1.0
 */
public enum IndexPageContentTypeEnum {
    ATTENTION(0, "关注"),
    RECOMMEND(1, "推荐"),
    LOCALTION(2, "本地");
    private int type;
    private String des;

    IndexPageContentTypeEnum(int type, String des) {
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
