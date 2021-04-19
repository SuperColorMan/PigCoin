package com.server_0.dao.mappers.shop;


import com.server_0.dao.entity.shop.TShopInteractionInfo;

public interface TShopInteractionInfoDao {
    int insert(TShopInteractionInfo record);

    int insertSelective(TShopInteractionInfo record);
}