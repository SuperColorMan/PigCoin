package com.server_0.dao.mappers.shop;


import com.server_0.dao.entity.shop.TShopOrder;

public interface TShopOrderDao {
    int deleteByPrimaryKey(Long id);

    int insert(TShopOrder record);

    int insertSelective(TShopOrder record);

    TShopOrder selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TShopOrder record);

    int updateByPrimaryKey(TShopOrder record);
}