package com.server_0.dao.entity.shop;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * t_shop_content_rel
 *
 * @author
 */
@Data
public class TShopContentRel implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 关联创建者用户id
     */
    private Long userId;

    /**
     * 商品id
     */
    private Long commodityId;

    /**
     * 商品信息
     */
    private TShopCommodity tShopCommodity;

    /**
     * 内容id
     */
    private Long contentId;

    /**
     * 内容类型,默认为内容类型
     */
    private Long contentType;

    /**
     * 操作时间
     */
    private Date time;

    /**
     * 是否删除,0:否,1:是
     */
    private String isDel;

    private static final long serialVersionUID = 1L;
}