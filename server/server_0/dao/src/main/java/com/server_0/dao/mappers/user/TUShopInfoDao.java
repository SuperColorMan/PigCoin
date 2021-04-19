package com.server_0.dao.mappers.user;


import com.server_0.dao.entity.user.TUShopInfo;

public interface TUShopInfoDao {
    int deleteByPrimaryKey(Long userId);

    int insert(TUShopInfo record);

    int insertSelective(TUShopInfo record);

    TUShopInfo selectByPrimaryKey(Long userId);

    int updateByPrimaryKeySelective(TUShopInfo record);

    int updateByPrimaryKey(TUShopInfo record);
}