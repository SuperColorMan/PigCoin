package com.server_0.dao.mappers.cal.commodity;

import com.server_0.comm.web.ServerResponse;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @ClassName CommodityCalDao
 * @Description 商品数据计算Dao层
 * @Author SuperColorMan
 * @Date 2021/2/9 9:20 上午
 * @ModifyDate 2021/2/9 9:20 上午
 * @Version 1.0
 */
public interface CommodityCalDao {
    /**
     * 获取今日总体更新的商品数量
     */
    Long getSumToDayUpdateCommodityCount();

    /**
     * 获取指定用户关注的用户的今日更新的商品数量
     */
    Long getAttentionToDayUpdateCommodityCountByUserId(@Param("userId") Long userId);

    /**
     * 获取指定用户总体卖出商品量
     *
     * @param userId 用户id
     */
    Long getSaleCommoditySumByUserId(@Param("userId") Long userId);

    /**
     * 获取指定用户卖出商品的分类
     *
     * @param userId 用户id
     */
    List<Map> getSaleCommodityClassifyByUserId(@Param("userId") Long userId);

    /**
     * 获取指定用户发布的商品的总体分类
     *
     * @param userId 用户id
     */
    List<Map> getCommodityClassifyByUserId(Long userId);

    /** -------------------- 用户商品卖出量计算 start --------------------*/
    /**
     * 获取用户周卖出量
     *
     * @param userId 用户id
     */
    List<Map> getSaleCommoditySumByWeekByUserId(@Param("userId") Long userId);

    /**
     * 获取用户月卖出量
     *
     * @param userId 用户id
     */
    List<Map> getSaleCommoditySumByMonthByUserId(@Param("userId") Long userId);

    /**
     * 获取用户年卖出量
     *
     * @param userId 用户id
     */
    List<Map> getSaleCommoditySumByYearByUserId(@Param("userId") Long userId);
    /** -------------------- 用户商品卖出量计算 end --------------------*/


    /** -------------------- 用户商品浏览量计算 start --------------------*/
    /**
     * 获取用户周浏览量
     *
     * @param userId 用户id
     */
    List<Map> getLookCommoditySumByWeekByUserId(Long userId);

    /**
     * 获取用户月浏览量
     *
     * @param userId 用户id
     */
    List<Map> getLookCommoditySumByMonthByUserId(Long userId);

    /**
     * 获取用户年浏览量
     *
     * @param userId 用户id
     */
    List<Map> getLookCommoditySumByYearByUserId(Long userId);
    /** -------------------- 用户商品浏览量计算 end --------------------*/


    /** -------------------- 用户商品加入购物车量计算 start --------------------*/
    /**
     * 获取用户周加入购物车量
     *
     * @param userId 用户id
     */
    List<Map> getJoinShopCarCommoditySumByWeekByUserId(Long userId);

    /**
     * 获取用户月加入购物车量
     *
     * @param userId 用户id
     */
    List<Map> getJoinShopCarCommoditySumByMonthByUserId(Long userId);

    /**
     * 获取用户年加入购物车量
     *
     * @param userId 用户id
     */
    List<Map> getJoinShopCarCommoditySumByYearByUserId(Long userId);
    /** -------------------- 用户商品加入购物车量计算 end --------------------*/
}
