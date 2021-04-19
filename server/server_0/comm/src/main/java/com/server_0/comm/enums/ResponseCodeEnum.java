package com.server_0.comm.enums;

/**
 * @ClassName ResponseCodeEnum
 * @Description 响应编码枚举
 * @Author SuperColorMan
 * @Date 2020/6/1 3:25 下午
 * @ModifyDate 2020/6/1 3:25 下午
 * @Version 1.0
 */
public enum ResponseCodeEnum {
    SUCCESS(0, "success"),
    ERROR(1, "error");
    private int code;
    private String mess;

    ResponseCodeEnum(int code, String mess) {
        this.code = code;
        this.mess = mess;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMess() {
        return mess;
    }

    public void setMess(String mess) {
        this.mess = mess;
    }
}
