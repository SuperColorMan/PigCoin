package com.server_0.comm.enums;

/**
 * @ClassName YesAndNoEnum
 * @Description 系统是否枚举
 * @Author SuperColorMan
 * @Date 2021/1/8 5:16 下午
 * @ModifyDate 2021/1/8 5:16 下午
 * @Version 1.0
 */
public enum YesAndNoEnum {
    Y(1,"是"),
    N(0,"否");
    private int code;
    private String des;

    YesAndNoEnum(int code, String des) {
        this.code = code;
        this.des = des;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }
}
