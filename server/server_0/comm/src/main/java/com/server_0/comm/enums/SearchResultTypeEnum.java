package com.server_0.comm.enums;

/**
 * @ClassName SearchResultTypeEnum
 * @Description 搜索结果集分类枚举
 * @Author SuperColorMan
 * @Date 2021/1/11 10:42 上午
 * @ModifyDate 2021/1/11 10:42 上午
 * @Version 1.0
 */
public enum SearchResultTypeEnum {
    ALL(0, "综合"),
    HOT(1, "热门"),
    NEWS(2, "新鲜"),
    IMG(3, "图片"),
    TEXT(4, "文字"),
    USER(5, "用户"),
    GAMBIT(6, "话题");

    // 编码
    private int type;
    // 描述
    private String des;

    SearchResultTypeEnum(int type, String des) {
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
