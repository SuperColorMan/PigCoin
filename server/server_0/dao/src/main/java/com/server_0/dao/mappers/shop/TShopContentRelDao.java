package com.server_0.dao.mappers.shop;


import com.server_0.dao.entity.shop.TShopContentRel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TShopContentRelDao {
    int deleteByPrimaryKey(Long id);

    int insert(TShopContentRel record);

    int insertSelective(TShopContentRel record);

    TShopContentRel selectByPrimaryKey(Long id);

    List<TShopContentRel> getContentRelCommodityList(@Param("contentId") Long contentId);

    int updateByPrimaryKeySelective(TShopContentRel record);

    int updateByPrimaryKey(TShopContentRel record);
}