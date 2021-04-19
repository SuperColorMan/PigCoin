package com.server_0.shop.service;

import com.server_0.comm.web.ServerResponse;
import org.springframework.web.bind.annotation.PostMapping;

/**
 * @ClassName CommodityClassifyService
 * @Description 商品分类服务层接口
 * @Author SuperColorMan
 * @Date 2021/2/2 2:15 下午
 * @ModifyDate 2021/2/2 2:15 下午
 * @Version 1.0
 */
public interface CommodityClassifyService {
    /**
     * 获取商品分类树
     */
    ServerResponse getCommodityClassifyTree();

    /**
     * 获取今日更新最多的分类列表
     */
    ServerResponse getToDayMostCommodityClassifyList();

    /**
     * 获取指定大类下的小类列表
     */
    ServerResponse getSmallClassifyListByBigClassifyId(Long bigClassifyId);

    /**
     * 获取大类列表
     */
    ServerResponse getBigClassifyList();
}
