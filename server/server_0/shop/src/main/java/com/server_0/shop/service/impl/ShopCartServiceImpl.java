package com.server_0.shop.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.shop.TShopCommodityCart;
import com.server_0.dao.mappers.shop.TShopCommodityCartDao;
import com.server_0.queue.local.LocalMQconsumerThread;
import com.server_0.shop.service.ShopCartService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

/**
 * @ClassName ShopCartServiceImpl
 * @Description 购物车服务层接口实现类
 * @Author SuperColorMan
 * @Date 2021/2/2 9:37 上午
 * @ModifyDate 2021/2/2 9:37 上午
 * @Version 1.0
 */
@Service
public class ShopCartServiceImpl implements ShopCartService {
    @Autowired
    TShopCommodityCartDao tShopCommodityCartDao;

    /**
     * 获取指定用户的购物车列表
     *
     * @param userId   用户id
     * @param page     页号
     * @param pageSize 页大小
     */
    @Override
    public ServerResponse getShopCartListByUserId(Long userId, Long page, Long pageSize) {
        List<TShopCommodityCart> tShopCommodityCartList = tShopCommodityCartDao.getShopCartListByUserId(userId, page, pageSize);
        return ServerResponse.success("ok", tShopCommodityCartList);
    }

    /**
     * 加入购物车
     *
     * @param userId      用户id
     * @param commodityId 商品id
     */
    @Override
    public ServerResponse addShopCart(Long userId, Long commodityId) {
        LocalMQconsumerThread.addQueueItem(() -> {
            TShopCommodityCart shopCart = new TShopCommodityCart();
            shopCart.setCommodityId(commodityId);
            shopCart.setUserId(userId);
            tShopCommodityCartDao.insertSelective(shopCart);
        });
        return ServerResponse.success("ok");
    }

    /**
     * 删除购物车
     *
     * @param userId      用户id
     * @param commodityIdArr 商品id数组
     */
    @Override
    public ServerResponse delShopCart(Long userId,String commodityIdArr) {
        LocalMQconsumerThread.addQueueItem(() -> {
            JSONArray filterIdArr = new JSONArray();
            if (StringUtils.isNotBlank(commodityIdArr)) {
                filterIdArr = JSONArray.parseArray(commodityIdArr);
            } else if (StringUtils.isBlank(commodityIdArr)) {
                filterIdArr.add(-1);
            }
            //过滤的评论条目id
            List<String> commodityIdList = filterIdArr.toJavaList(String.class);
            /// 批量删除
            tShopCommodityCartDao.delShopCart(userId,commodityIdList);
        });
        return ServerResponse.success("ok");
    }

}
