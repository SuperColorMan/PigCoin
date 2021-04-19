package com.server_0.shop.controller;

import com.server_0.comm.web.ServerResponse;
import com.server_0.shop.service.CommodityClassifyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName CommodityClassifyController
 * @Description 商品分类控制器
 * @Author SuperColorMan
 * @Date 2021/2/2 1:53 下午
 * @ModifyDate 2021/2/2 1:53 下午
 * @Version 1.0
 */
@CrossOrigin
@RestController
@RequestMapping("/commodityclassify/")
public class CommodityClassifyController {

    @Autowired
    CommodityClassifyService commodityClassifyService;

    /**
     * 获取商品分类树
     */
    @PostMapping("getCommodityClassifyTree")
    public ServerResponse getCommodityClassifyTree() {
        return commodityClassifyService.getCommodityClassifyTree();
    }

    /**
     * 获取今日更新最多的分类列表
     */
    @PostMapping("getToDayMostCommodityClassifyList")
    public ServerResponse getToDayMostCommodityClassifyList() {
        return commodityClassifyService.getToDayMostCommodityClassifyList();
    }

    /**
     * 获取大类列表
     */
    @PostMapping("getBigClassifyList")
    public ServerResponse getBigClassifyList() {
        return commodityClassifyService.getBigClassifyList();
    }

    /**
     * 获取指定大类下的小类列表
     *
     * @param bigClassifyId 大类id
     */
    @PostMapping("getSmallClassifyListByBigClassifyId")
    public ServerResponse getSmallClassifyListByBigClassifyId(Long bigClassifyId) {
        return commodityClassifyService.getSmallClassifyListByBigClassifyId(bigClassifyId);
    }

}
