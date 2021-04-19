package com.server_0.shop.service;

import com.server_0.comm.web.ServerResponse;
import org.springframework.web.bind.annotation.PostMapping;

/**
 * @ClassName ShopCartService
 * @Description 购物车服务层接口
 * @Author SuperColorMan
 * @Date 2021/2/2 9:37 上午
 * @ModifyDate 2021/2/2 9:37 上午
 * @Version 1.0
 */
public interface ShopCartService {
    /**
     * 获取指定用户的购物车列表
     *
     * @param userId   用户id
     * @param page     页号
     * @param pageSize 页大小
     */
    ServerResponse getShopCartListByUserId(Long userId, Long page, Long pageSize);

    /**
     * 加入购物车
     *
     * @param userId      用户id
     * @param commodityId 商品id
     */
    ServerResponse addShopCart(Long userId, Long commodityId);

    /**
     * 删除购物车
     *
     * @param userId         用户id
     * @param commodityIdArr 商品id数组
     */
    ServerResponse delShopCart(Long userId, String commodityIdArr);
}
