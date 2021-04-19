package com.server_0.comm.web;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.server_0.comm.enums.ResponseCodeEnum;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;

/**
 * @ClassName ServerResponse
 * @Description 标准服务响应体
 * @Author SuperColorMan
 * @Date 2020/6/1 3:25 下午
 * @ModifyDate 2020/6/1 3:25 下午
 * @Version 1.0
 */
@Data
@NoArgsConstructor
@ToString
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ServerResponse<T> implements Serializable {
    private int code;
    private String mess;
    private T data;

    public ServerResponse(String mess, T data) {
        this.mess = mess;
        this.data = data;
    }

    public ServerResponse(int code, String mess, T data) {
        this.code = code;
        this.mess = mess;
        this.data = data;
    }

    public ServerResponse(int code, String mess) {
        this.code = code;
        this.mess = mess;
    }

    public static <T> ServerResponse<T> success(String mess, T data) {
        return new ServerResponse<>(ResponseCodeEnum.SUCCESS.getCode(), mess, data);
    }

    public static <T> ServerResponse<T> success(String mess) {
        return new ServerResponse<>(ResponseCodeEnum.SUCCESS.getCode(), mess);
    }

    public static <T> ServerResponse<T> error(String mess) {
        return new ServerResponse<>(ResponseCodeEnum.ERROR.getCode(), mess);
    }
}
