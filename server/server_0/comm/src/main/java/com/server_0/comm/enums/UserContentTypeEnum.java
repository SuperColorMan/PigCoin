package com.server_0.comm.enums;

/**
 * @ClassName UserContentTypeEnum
 * @Description 用户内容类型枚举
 * @Author SuperColorMan
 * @Date 2021/1/10 6:58 下午
 * @ModifyDate 2021/1/10 6:58 下午
 * @Version 1.0
 */
public enum UserContentTypeEnum {
    ALL(0, "全部"),
    CONTENT(1, "内容"),
    GOOD(2, "点赞"),
    COMMENT(3, "评论"),
    COLL(4, "收藏");
    private int type;
    private String des;

    UserContentTypeEnum(int type, String des) {
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
