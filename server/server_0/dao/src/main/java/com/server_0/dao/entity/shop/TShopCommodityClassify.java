package com.server_0.dao.entity.shop;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * t_shop_commodity_classify
 *
 * @author
 */
@Data
public class TShopCommodityClassify implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 分类名称
     */
    private String name;

    /**
     * 父级分类id
     */
    private Long parentId;

    /**
     * 分类等级:0:第一大类分类,1:第二中类分类,2:第三小类分类,
     */
    private Integer lvl;

    /**
     * 内容创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date createTime;

    /**
     * 内容更新时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date updateTime;

    /**
     * 所属中类集合
     */
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private List<TShopCommodityClassify> mediumClassifyList;

    /**
     * 所属小类集合
     */
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private List<TShopCommodityClassify> smallClassifyList;

    /**
     * 今日更新商品次数
     */
    private Long toUpdateCommodityCount;

    private static final long serialVersionUID = 1L;
}