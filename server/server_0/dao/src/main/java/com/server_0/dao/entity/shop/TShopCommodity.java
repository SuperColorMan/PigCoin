package com.server_0.dao.entity.shop;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.server_0.dao.entity.user.TUUser;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * t_shop_commodity
 *
 * @author
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TShopCommodity implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 商品来源id,可以是用户或商家
     */
    private Long commoditySrcId;

    /**
     * 用户信息,商家或用户都使用用户数据结构
     * */
    private TUUser tuUser;

    /**
     * 商品来源类型,可以是用户或商家
     */
    private String commoditySrcType;

    /**
     * 商品名称
     */
    private String name;

    /**
     * 商品价格
     */
    private Double price;

    /**
     * 商品价格单位
     */
    private String priceUnit;

    /**
     * 商品运费
     */
    private Double freight;

    /**
     * 商品运费单位
     */
    private String freightUnit;

    /**
     * 商品描述
     */
    private String intro;

    /**
     * 商品分类id
     */
    private String classifyId;

    /**
     * 商品创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date createTime;

    /**
     * 商品更新时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date updateTime;

    /**
     * 商品分类
     */
    private TShopCommodityClassify tShopCommodityClassify;

    /**
     * 商品相关图片列表
     */
    private List<TShopImgInfo> tShopImgInfoList;

    /**
     * 商品型号列表
     */
    private List<TShopCommodityType> tShopCommodityTypeList;

    private static final long serialVersionUID = 1L;
}