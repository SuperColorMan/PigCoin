package com.server_0.dao.entity.user;

import lombok.Data;

import java.io.Serializable;

/**
 * t_u_shop_info
 * @author 
 */
@Data
public class TUShopInfo implements Serializable {
    /**
     * 用户id
     */
    private Long userId;

    /**
     * 发布的商品数
     */
    private Long commodityCount;

    /**
     * 收藏的商品数
     */
    private Long collectCommodityCount;

    /**
     * 被收藏的商品数
     */
    private Long byCollectCommodityCount;

    /**
     * 卖出的商品数量
     */
    private Long sellCount;

    /**
     * 买进的商品数量
     */
    private Long buyCount;

    private static final long serialVersionUID = 1L;
}