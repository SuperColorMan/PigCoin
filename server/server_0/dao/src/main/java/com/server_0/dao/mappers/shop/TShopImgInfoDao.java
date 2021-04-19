package com.server_0.dao.mappers.shop;


import com.server_0.dao.entity.shop.TShopImgInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TShopImgInfoDao {
    int deleteByPrimaryKey(Long id);

    int insert(TShopImgInfo record);

    int insertSelective(TShopImgInfo record);

    TShopImgInfo selectByPrimaryKey(Long id);

    List<TShopImgInfo> selectListByCommodityId(@Param("commodityId") Long commodityId);

    int updateByPrimaryKeySelective(TShopImgInfo record);

    int updateByPrimaryKey(TShopImgInfo record);
}