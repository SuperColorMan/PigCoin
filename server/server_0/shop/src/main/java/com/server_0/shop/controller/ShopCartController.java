package com.server_0.shop.controller;

import com.server_0.comm.web.ServerResponse;
import com.server_0.shop.service.ShopCartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName ShopCartController
 * @Description 购物车控制器
 * @Author SuperColorMan
 * @Date 2021/2/2 9:36 上午
 * @ModifyDate 2021/2/2 9:36 上午
 * @Version 1.0
 */
@CrossOrigin
@RestController
@RequestMapping("/shopcart/")
public class ShopCartController {
    @Autowired
    ShopCartService shopCartService;

    /**
     * 获取指定用户的购物车列表
     *
     * @param userId   用户id
     * @param page     起始页
     * @param pageSize 页大小
     */
    @PostMapping("getShopCartListByUserId")
    public ServerResponse getShopCartListByUserId(Long userId, Long page, Long pageSize) {
        return shopCartService.getShopCartListByUserId(userId, page, pageSize);
    }

    /**
     * 加入购物车
     *
     * @param userId      用户id
     * @param commodityId 商品id
     */
    @PostMapping("addShopCart")
    public ServerResponse addShopCart(Long userId, Long commodityId) {
        return shopCartService.addShopCart(userId, commodityId);
    }

    /**
     * 删除购物车中商品
     *
     * @param userId      用户id
     * @param commodityIdArr 商品id数组
     */
    @PostMapping("delShopCart")
    public ServerResponse delShopCart(Long userId, String commodityIdArr) {
        return shopCartService.delShopCart(userId, commodityIdArr);
    }
}
