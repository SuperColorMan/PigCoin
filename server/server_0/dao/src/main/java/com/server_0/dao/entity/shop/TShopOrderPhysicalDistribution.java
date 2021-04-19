package com.server_0.dao.entity.shop;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * t_shop_order_physical_distribution
 * @author 
 */
@Data
public class TShopOrderPhysicalDistribution implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 商品id
     */
    private Long commodityId;

    /**
     * 订单id
     */
    private Long orderId;

    /**
     * 订单创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date createTime;

    /**
     * 订单更新时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date updateTime;

    /**
     * 物流状态,0:待发货。1:运送中。2:已签收。
     */
    private String physicalDistributionStatus;

    /**
     * 是否删除,0:否。1:是
     */
    private String isDel;

    private static final long serialVersionUID = 1L;
}