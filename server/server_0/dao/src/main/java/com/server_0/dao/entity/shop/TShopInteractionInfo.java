package com.server_0.dao.entity.shop;

import lombok.Data;

import java.io.Serializable;

/**
 * t_shop_interaction_info
 * @author 
 */
@Data
public class TShopInteractionInfo implements Serializable {
    /**
     * 商品id
     */
    private Long commodityId;

    /**
     * 购买次数
     */
    private Long buyCount;

    /**
     * 评论数
     */
    private Long commentCount;

    /**
     * 收藏数
     */
    private Long collCount;

    /**
     * 商品查看数
     */
    private Long lookCount;

    /**
     * 商品加入购物车次数
     */
    private Long joinShopCartCount;

    private static final long serialVersionUID = 1L;
}