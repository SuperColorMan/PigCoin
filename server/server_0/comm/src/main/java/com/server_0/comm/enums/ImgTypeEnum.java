package com.server_0.comm.enums;

/**
 * @ClassName ImgTypeEnum
 * @Description 图片类型枚举
 * @Author SuperColorMan
 * @Date 2021/1/4 2:31 下午
 * @ModifyDate 2021/1/4 2:31 下午
 * @Version 1.0
 */
public enum ImgTypeEnum {
    USERPIC(0, "用户头像"),
    USERBGPIC(1, "用户壁纸"),
    CONTENTIMG(2, "内容图片"),
    COMMENTIMG(3, "评论图片"),
    REPLYIMG(4, "回复图片"),
    GAMBITHEADPIC(5, "话题头像"),
    GAMBITBGPIC(6, "话题壁纸"),
    CHATIMG(7, "私信图片"),
    COMMODITYCLASSIFYPIC(8, "商品分类头像");
    private int type;
    private String des;

    ImgTypeEnum(int type, String des) {
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
