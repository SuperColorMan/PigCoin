package com.server_0.cal.controller.shop;

import com.server_0.cal.service.shop.CommodityCalService;
import com.server_0.comm.web.ServerResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName CommodityCalController
 * @Description 商品计算控制器
 * @Author SuperColorMan
 * @Date 2021/2/25 1:45 下午
 * @ModifyDate 2021/2/25 1:45 下午
 * @Version 1.0
 */
@CrossOrigin
@RestController
@RequestMapping("/cal/commodity/")
public class CommodityCalController {

    @Autowired
    CommodityCalService commodityCalService;

    /**
     * 获取今日总体更新的商品数量
     */
    @PostMapping("getSumToDayUpdateCommodityCount")
    public ServerResponse getSumToDayUpdateCommodityCount() {
        return commodityCalService.getSumToDayUpdateCommodityCount();
    }

    /**
     * 获取指定用户关注的用户的今日更新的商品数量
     */
    @PostMapping("getAttentionToDayUpdateCommodityCountByUserId")
    public ServerResponse getAttentionToDayUpdateCommodityCountByUserId(Long userId) {
        return commodityCalService.getAttentionToDayUpdateCommodityCountByUserId(userId);
    }

    /**
     * 获取指定用户总体卖出商品量
     *
     * @param userId 用户id
     */
    @PostMapping("getSaleCommoditySumByUserId")
    public ServerResponse getSaleCommoditySumByUserId(Long userId) {
        return commodityCalService.getSaleCommoditySumByUserId(userId);
    }

    /**
     * 获取指定用户发布的商品的总体分类
     *
     * @param userId 用户id
     */
    @PostMapping("getCommodityClassifyByUserId")
    public ServerResponse getCommodityClassifyByUserId(Long userId) {
        return commodityCalService.getCommodityClassifyByUserId(userId);
    }

    /**
     * 获取指定用户卖出商品的分类
     *
     * @param userId 用户id
     */
    @PostMapping("getSaleCommodityClassifyByUserId")
    public ServerResponse getSaleCommodityClassifyByUserId(Long userId) {
        return commodityCalService.getSaleCommodityClassifyByUserId(userId);
    }

    /** -------------------- 用户卖出量计算 start --------------------*/
    /**
     * 获取用户周卖出量
     *
     * @param userId 用户id
     */
    @PostMapping("getSaleCommoditySumByWeekByUserId")
    public ServerResponse getSaleCommoditySumByWeekByUserId(Long userId) {
        return commodityCalService.getSaleCommoditySumByWeekByUserId(userId);
    }

    /**
     * 获取用户月卖出量
     *
     * @param userId 用户id
     */
    @PostMapping("getSaleCommoditySumByMonthByUserId")
    public ServerResponse getSaleCommoditySumByMonthByUserId(Long userId) {
        return commodityCalService.getSaleCommoditySumByMonthByUserId(userId);
    }

    /**
     * 获取用户年卖出量
     *
     * @param userId 用户id
     */
    @PostMapping("getSaleCommoditySumByYearByUserId")
    public ServerResponse getSaleCommoditySumByYearByUserId(Long userId) {
        return commodityCalService.getSaleCommoditySumByYearByUserId(userId);
    }
    /** -------------------- 用户卖出量计算 start --------------------*/

    /** -------------------- 用户商品浏览量计算 start --------------------*/
    /**
     * 获取用户商品周浏览量
     *
     * @param userId 用户id
     */
    @PostMapping("getLookCommoditySumByWeekByUserId")
    public ServerResponse getLookCommoditySumByWeekByUserId(Long userId) {
        return commodityCalService.getSaleCommoditySumByWeekByUserId(userId);
    }

    /**
     * 获取用户商品月浏览量
     *
     * @param userId 用户id
     */
    @PostMapping("getLookCommoditySumByMonthByUserId")
    public ServerResponse getLookCommoditySumByMonthByUserId(Long userId) {
        return commodityCalService.getSaleCommoditySumByMonthByUserId(userId);
    }

    /**
     * 获取用户商品年浏览量
     *
     * @param userId 用户id
     */
    @PostMapping("getLookCommoditySumByYearByUserId")
    public ServerResponse getLookCommoditySumByYearByUserId(Long userId) {
        return commodityCalService.getSaleCommoditySumByYearByUserId(userId);
    }
    /** -------------------- 用户商品浏览量计算 end --------------------*/


    /** -------------------- 用户商品被加入购物车量计算 start --------------------*/
    /**
     * 获取用户周被加入购物车次数
     *
     * @param userId 用户id
     */
    @PostMapping("getJoinShopCarCommoditySumByWeekByUserId")
    public ServerResponse getJoinShopCarCommoditySumByWeekByUserId(Long userId) {
        return commodityCalService.getSaleCommoditySumByWeekByUserId(userId);
    }

    /**
     * 获取用户月被加入购物车次数
     *
     * @param userId 用户id
     */
    @PostMapping("getJoinShopCarCommoditySumByMonthByUserId")
    public ServerResponse getJoinShopCarCommoditySumByMonthByUserId(Long userId) {
        return commodityCalService.getSaleCommoditySumByMonthByUserId(userId);
    }

    /**
     * 获取用户年被加入购物车次数
     *
     * @param userId 用户id
     */
    @PostMapping("getJoinShopCarCommoditySumByYearByUserId")
    public ServerResponse getJoinShopCarCommoditySumByYearByUserId(Long userId) {
        return commodityCalService.getSaleCommoditySumByYearByUserId(userId);
    }
    /** -------------------- 用户商品被加入购物车量计算 end --------------------*/
}
