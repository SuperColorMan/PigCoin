package com.server_0.dao.mappers.shop;


import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.shop.TShopCommodityClassify;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TShopCommodityClassifyDao {

    int isExistData();

    int deleteByPrimaryKey(Long id);

    int insert(TShopCommodityClassify record);

    int insertSelective(TShopCommodityClassify record);

    List<TShopCommodityClassify> getCommodityClassifyTree();

    List<TShopCommodityClassify> getToDayMostCommodityClassifyList();

    List<TShopCommodityClassify> getSmallClassifyListByBigClassifyId(@Param("bigClassifyId") Long bigClassifyId);

    /**
     * 获取大类列表
     */
    List<TShopCommodityClassify> getBigClassifyList();

    TShopCommodityClassify selectByPrimaryKey(Long id);

    List<TShopCommodityClassify> getMediumClassifyList(@Param("bigClassifyId") Long bigClassifyId);

    List<TShopCommodityClassify> getSmallClassifyList(@Param("mediumClassifyId") Long mediumClassifyId);

    int updateByPrimaryKeySelective(TShopCommodityClassify record);

    int updateByPrimaryKey(TShopCommodityClassify record);
}