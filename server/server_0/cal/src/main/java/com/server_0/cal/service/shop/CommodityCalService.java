package com.server_0.cal.service.shop;

import com.server_0.comm.web.ServerResponse;
import org.springframework.web.bind.annotation.PostMapping;

/**
 * @ClassName CommodityService
 * @Description 商品数据计算服务层接口
 * @Author SuperColorMan
 * @Date 2021/2/8 4:49 下午
 * @ModifyDate 2021/2/8 4:49 下午
 * @Version 1.0
 */
public interface CommodityCalService {
    /**
     * 获取今日总体更新的商品数量
     */
    ServerResponse getSumToDayUpdateCommodityCount();

    /**
     * 获取指定用户关注的用户的今日更新的商品数量
     *
     * @param userId 用户id
     */
    ServerResponse getAttentionToDayUpdateCommodityCountByUserId(Long userId);

    /**
     * 获取指定用户总体卖出商品量
     *
     * @param userId 用户id
     */
    ServerResponse getSaleCommoditySumByUserId(Long userId);

    /**
     * 获取指定用户卖出商品的分类
     *
     * @param userId 用户id
     */
    ServerResponse getSaleCommodityClassifyByUserId(Long userId);

    /**
     * 获取指定用户发布的商品的总体分类
     *
     * @param userId 用户id
     */
    ServerResponse getCommodityClassifyByUserId(Long userId);

    /**
     * 获取用户周卖出量
     *
     * @param userId 用户id
     */
    ServerResponse getSaleCommoditySumByWeekByUserId(Long userId);

    /**
     * 获取用户月卖出量
     *
     * @param userId 用户id
     */
    ServerResponse getSaleCommoditySumByMonthByUserId(Long userId);

    /**
     * 获取用户年卖出量
     *
     * @param userId 用户id
     */
    ServerResponse getSaleCommoditySumByYearByUserId(Long userId);

    /** -------------------- 用户商品浏览量计算 start --------------------*/
    /**
     * 获取用户周浏览量
     *
     * @param userId 用户id
     */
    ServerResponse getLookCommoditySumByWeekByUserId(Long userId);

    /**
     * 获取用户月浏览量
     *
     * @param userId 用户id
     */
    ServerResponse getLookCommoditySumByMonthByUserId(Long userId);

    /**
     * 获取用户年浏览量
     *
     * @param userId 用户id
     */
    ServerResponse getLookCommoditySumByYearByUserId(Long userId);
    /** -------------------- 用户商品浏览量计算 end --------------------*/

    /** -------------------- 用户商品被加入购物车量计算 start --------------------*/
    /**
     * 获取用户周加入次数
     *
     * @param userId 用户id
     */
    ServerResponse getJoinShopCarCommoditySumByWeekByUserId(Long userId);

    /**
     * 获取用户月加入次数
     *
     * @param userId 用户id
     */
    ServerResponse getJoinShopCarCommoditySumByMonthByUserId(Long userId);

    /**
     * 获取用户年加入次数
     *
     * @param userId 用户id
     */
    ServerResponse getJoinShopCarCommoditySumByYearByUserId(Long userId);
    /** -------------------- 用户商品被加入购物车量计算 end --------------------*/

}
