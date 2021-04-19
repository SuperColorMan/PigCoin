package com.server_0.dao.entity.user;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.server_0.dao.entity.local.TLocalInfo;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * t_u_user
 *
 * @author
 */
@Data
public class TUUser implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 用户自定义id
     */
    private String uid;

    /**
     * 用户名
     */
    private String name;

    /**
     * 用户性别,0:女,1:男,2:未知
     */
    private String sex;

    /**
     * 手机号
     */
    private String phone;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 账号
     */
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String account;

    /**
     * 密码
     */
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String pass;

    /**
     * 简介
     */
    private String intro;

    /**
     * 注册时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date loginTime;

    /**
     * 信息更新时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date updateTime;

    /**
     * 是否删除,0:否,1:是
     */
    private String isDel;

    /**
     * 是否合法,0:是,1:否
     */
    private String isLegal;

    /**
     * 是否注销,0:否,1:是
     */
    private String isWo;

    /**
     * 用户信息
     */
    private TUInteractionInfo tuInteractionInfo;

    /**
     * 用户所在地信息
     */
    private TLocalInfo tLocalInfo;

    /**
     * 生日
     * */
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @JsonFormat(pattern="yyyy-MM-dd")
    private Date birthday;

    private static final long serialVersionUID = 1L;
}