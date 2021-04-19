package com.server_0.dao.entity.shop;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * t_shop_commodity_cart
 * @author 
 */
@Data
public class TShopCommodityCart implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 商品id
     */
    private Long commodityId;

    /**
     * 商品来源id,可以是用户或商家
     */
    private Long commoditySrcId;

    /**
     * 商品来源类型,可以是用户或商家
     */
    private String commodityType;

    /**
     * 购物车所属用户id
     */
    private Long userId;

    /**
     * 商品数量,最大99个
     */
    private Integer commodityCount;

    /**
     * 加入购物车时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date createTime;

    /**
     * 是否删除,0:否。1:是
     */
    private String isDel;

    /**
     * 相对应的商品
     * */
    TShopCommodity tShopCommodity;

    private static final long serialVersionUID = 1L;
}