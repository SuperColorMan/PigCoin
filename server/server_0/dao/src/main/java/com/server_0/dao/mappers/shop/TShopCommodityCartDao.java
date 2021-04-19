package com.server_0.dao.mappers.shop;


import com.server_0.dao.entity.shop.TShopCommodityCart;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TShopCommodityCartDao {
    int deleteByPrimaryKey(Long id);

    int insert(TShopCommodityCart record);

    int insertSelective(TShopCommodityCart record);

    TShopCommodityCart selectByPrimaryKey(Long id);

    List<TShopCommodityCart> getShopCartListByUserId(@Param("userId") Long userId,
                                                     @Param("page") Long page,
                                                     @Param("pageSize") Long pageSize);

    int delShopCart(
            @Param("userId") Long userId,
            @Param("commodityIdList") List<String> commodityIdList);

    int updateByPrimaryKeySelective(TShopCommodityCart record);

    int updateByPrimaryKey(TShopCommodityCart record);
}