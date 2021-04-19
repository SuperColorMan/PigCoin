package com.server_0.dao.mappers.shop;


import com.server_0.dao.entity.shop.TShopOrderPhysicalDistribution;

public interface TShopOrderPhysicalDistributionDao {
    int deleteByPrimaryKey(Long id);

    int insert(TShopOrderPhysicalDistribution record);

    int insertSelective(TShopOrderPhysicalDistribution record);

    TShopOrderPhysicalDistribution selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TShopOrderPhysicalDistribution record);

    int updateByPrimaryKey(TShopOrderPhysicalDistribution record);
}