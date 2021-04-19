package com.server_0.dao.mappers.shop;


import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.shop.TShopCommodity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TShopCommodityDao {
    int deleteByPrimaryKey(Long id);

    int insert(TShopCommodity record);

    int insertSelective(TShopCommodity record);

    TShopCommodity selectByPrimaryKey(Long id);

    List<TShopCommodity> getCommodityListByUserId(@Param("userId") Long userId,
                                                    @Param("page") Long page,
                                                    @Param("pageSize") Long pageSize);

    List<TShopCommodity> getRelCommodityByContentId(@Param("contentId") Long contentId,
                                                    @Param("contentType") int contentType);

    List<TShopCommodity> getCommodityListByClassify(@Param("classifyId") Long classifyId,
                                                    @Param("searchKeyWord") String searchKeyWord,
                                                    @Param("page") Long page,
                                                    @Param("pageSize") Long pageSize);

    List<TShopCommodity> getCommodityListBySearchKeyWord(@Param("searchKeyWord") String searchKeyWord,
                                                         @Param("page") Long page,
                                                         @Param("pageSize") Long pageSize);

    List<TShopCommodity> getCommodityListByUserAttentionUser(@Param("userId") Long userId,
                                                             @Param("page") Long page,
                                                             @Param("pageSize") Long pageSize);

    List<TShopCommodity> getCommodityListByClassifyId(@Param("classifyIds") String classifyIds,
                                                      @Param("page") Long page,
                                                      @Param("pageSize") Long pageSize);

    List<TShopCommodity> getRecommendCommodityList(@Param("page") Long page,
                                                   @Param("pageSize") Long pageSize);

    int updateByPrimaryKeySelective(TShopCommodity record);

    int updateByPrimaryKey(TShopCommodity record);
}