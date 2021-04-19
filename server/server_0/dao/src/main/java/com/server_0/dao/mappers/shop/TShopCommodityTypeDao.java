package com.server_0.dao.mappers.shop;


import com.server_0.dao.entity.shop.TShopCommodityType;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TShopCommodityTypeDao {
    int deleteByPrimaryKey(Long id);

    int insert(TShopCommodityType record);

    int insertSelective(TShopCommodityType record);

    List<TShopCommodityType> selectListByCommodityId(@Param("commodityId") Long icommodityId);

    TShopCommodityType selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TShopCommodityType record);

    int updateByPrimaryKey(TShopCommodityType record);
}