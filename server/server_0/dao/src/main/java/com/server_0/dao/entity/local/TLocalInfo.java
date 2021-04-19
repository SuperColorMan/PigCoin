package com.server_0.dao.entity.local;

import lombok.Data;

import java.io.Serializable;

/**
 * t_local_info
 * @author 
 */
@Data
public class TLocalInfo implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 来源id
     */
    private Long srcId;

    /**
     * 来源类型,由枚举决定
     */
    private String srcType;

    /**
     * 国家编码
     */
    private String countryCode;

    /**
     * 国家
     */
    private String country;

    /**
     * 市
     */
    private String city;

    /**
     * 省
     */
    private String provincial;

    /**
     * 区
     */
    private String district;

    /**
     * 街道
     */
    private String street;

    /**
     * 经度
     */
    private String longitude;

    /**
     * 纬度
     */
    private String latitude;

    private static final long serialVersionUID = 1L;
}