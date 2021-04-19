package com.server_0.dao.entity.shop;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * t_shop_order
 * @author 
 */
@Data
public class TShopOrder implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 商品id
     */
    private Long commodityId;

    /**
     * 物流信息id
     */
    private Long physicalDistributionId;

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
     * 订单状态,0:下单,待付款。1:已付款,未发货。2:商品运送中。3:已签收。4:订单正常流程完成。5:退换处理中。6:退换处理完成。7:订单结束,不论以哪种方式结束,这是订单的最终状态。
     */
    private String orderStatus;

    /**
     * 是否删除,0:否。1:是
     */
    private String isDel;

    private static final long serialVersionUID = 1L;
}