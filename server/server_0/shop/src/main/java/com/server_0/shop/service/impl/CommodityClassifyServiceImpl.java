package com.server_0.shop.service.impl;

import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.shop.TShopCommodityClassify;
import com.server_0.dao.mappers.shop.TShopCommodityClassifyDao;
import com.server_0.shop.service.CommodityClassifyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

/**
 * @ClassName CommodityClassifyServiceImpl
 * @Description 商品分类服务层接口实现类
 * @Author SuperColorMan
 * @Date 2021/2/2 2:15 下午
 * @ModifyDate 2021/2/2 2:15 下午
 * @Version 1.0
 */
@Service
public class CommodityClassifyServiceImpl implements CommodityClassifyService {
    @Autowired
    TShopCommodityClassifyDao tShopCommodityClassifyDao;

    /**
     * 获取商品分类树
     */
    @Override
    public ServerResponse getCommodityClassifyTree() {
        List<TShopCommodityClassify> tShopCommodityClassifyList = tShopCommodityClassifyDao.getCommodityClassifyTree();
        return ServerResponse.success("ok", tShopCommodityClassifyList);
    }

    /**
     * 获取今日更新最多的分类列表
     */
    @Override
    public ServerResponse getToDayMostCommodityClassifyList() {
        List<TShopCommodityClassify> tShopCommodityClassifyList = tShopCommodityClassifyDao.getToDayMostCommodityClassifyList();
        return ServerResponse.success("ok", tShopCommodityClassifyList);
    }

    /**
     * 获取指定大类下的小类列表
     */
    @Override
    public ServerResponse getSmallClassifyListByBigClassifyId(Long bigClassifyId) {
        List<TShopCommodityClassify> tShopCommodityClassifyList = tShopCommodityClassifyDao.getSmallClassifyListByBigClassifyId(bigClassifyId);
        return ServerResponse.success("ok", tShopCommodityClassifyList);
    }

    /**
     * 获取大类列表
     */
    @Override
    public ServerResponse getBigClassifyList() {
        List<TShopCommodityClassify> tShopCommodityClassifyList = tShopCommodityClassifyDao.getBigClassifyList();
        return ServerResponse.success("ok", tShopCommodityClassifyList);
    }
}
