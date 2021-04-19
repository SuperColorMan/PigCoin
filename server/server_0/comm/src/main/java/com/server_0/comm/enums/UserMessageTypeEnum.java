package com.server_0.comm.enums;

/**
 * @ClassName UserMessageTypeEnum
 * @Description 用户消息类型枚举
 * @Author SuperColorMan
 * @Date 2021/1/8 5:16 下午
 * @ModifyDate 2021/1/8 5:16 下午
 * @Version 1.0
 */
public enum UserMessageTypeEnum {
    GOOD(0, "点赞消息"),
    COLLECT(1, "收藏消息"),
    COMMENT(2, "评论消息"),
    AT(3, "内容中@"),
    ATFORCOMMENT(4, "评论中@"),
    FANS(5, "新增粉丝消息");
    private int type;
    private String des;

    UserMessageTypeEnum(int type, String des) {
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
