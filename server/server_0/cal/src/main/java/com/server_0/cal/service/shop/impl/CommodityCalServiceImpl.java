package com.server_0.cal.service.shop.impl;

import com.google.common.collect.Maps;
import com.server_0.cal.service.shop.CommodityCalService;
import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.mappers.cal.commodity.CommodityCalDao;
import com.server_0.utils.time.TimeUtil;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Month;
import java.time.Year;
import java.util.*;
import java.util.concurrent.TimeUnit;

/**
 * @ClassName CommodityServiceImpl
 * @Description 商品数据计算服务层接口实现类
 * @Author SuperColorMan
 * @Date 2021/2/8 4:49 下午
 * @ModifyDate 2021/2/8 4:49 下午
 * @Version 1.0
 */
@Service
public class CommodityCalServiceImpl implements CommodityCalService {
    @Autowired
    CommodityCalDao commodityCalDao;

    private final String[] numberOfTextArr = {"一", "二", "三", "四", "五", "六", "七", "八", "九"};

    /**
     * 获取今日总体更新的商品数量
     */
    @Override
    public ServerResponse getSumToDayUpdateCommodityCount() {
        return ServerResponse.success("ok", commodityCalDao.getSumToDayUpdateCommodityCount());
    }

    /**
     * 获取指定用户关注的用户的今日更新的商品数量
     */
    @Override
    public ServerResponse getAttentionToDayUpdateCommodityCountByUserId(Long userId) {
        return ServerResponse.success("ok", commodityCalDao.getAttentionToDayUpdateCommodityCountByUserId(0L));
    }


    /**
     * 获取指定用户总体卖出商品量
     *
     * @param userId 用户id
     */
    @Override
    public ServerResponse getSaleCommoditySumByUserId(Long userId) {
        return ServerResponse.success("ok", commodityCalDao.getSaleCommoditySumByUserId(userId));
    }

    /**
     * 获取指定用户卖出商品的分类
     *
     * @param userId 用户id
     */
    @Override
    public ServerResponse getSaleCommodityClassifyByUserId(Long userId) {
        return ServerResponse.success("ok", commodityCalDao.getSaleCommodityClassifyByUserId(userId));

    }

    /**
     * 获取指定用户发布的商品的总体分类
     *
     * @param userId 用户id
     */
    @Override
    public ServerResponse getCommodityClassifyByUserId(Long userId) {
        return ServerResponse.success("ok", commodityCalDao.getCommodityClassifyByUserId(userId));
    }

    /** -------------------- 用户卖出量计算 start --------------------*/

    /**
     * 获取用户周卖出量
     *
     * @param userId 用户id
     */
    @Override
    public ServerResponse getSaleCommoditySumByWeekByUserId(Long userId) {
        List<Map> list = commodityCalDao.getSaleCommoditySumByWeekByUserId(userId);
        List<Map> resList = new ArrayList<Map>();
        for (int i = 0; i < 6; i++) {
            int finalI = i;
            resList.add(new HashMap() {{
                put("value", "0");
                put("index", String.valueOf((finalI + 1)));
            }});
        }
        for (Map m : list) {
            for (int i = 0; i < resList.size(); i++) {
                if (m.get("weekday").toString().equals(String.valueOf(i))) {
                    resList.get(i).put("value", m.get("count").toString());
                }
            }
        }
        return ServerResponse.success("ok", resList);
    }


    /**
     * 获取用户月卖出量
     *
     * @param userId 用户id
     */
    @Override
    public ServerResponse getSaleCommoditySumByMonthByUserId(Long userId) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM");
        // 一个月有多少天
        int days = 30;
        try {
            days = TimeUtil.getDaysOfMonth(simpleDateFormat.parse(String.valueOf(TimeUtil.cal.get(Calendar.MONTH) + 1)));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        List<Map> list = commodityCalDao.getSaleCommoditySumByMonthByUserId(userId);
        List<Map> resList = new ArrayList<Map>();
        // 月份数据初始化
        for (int i = 0; i < days; i++) {
            int finalI = i;
            resList.add(new HashMap() {{
                put("value", "0");
                put("index", String.valueOf((finalI + 1)));
            }});
        }
        for (Map m : list) {
            for (int i = 0; i < resList.size(); i++) {
                if (m.get("dayofmonth").toString().equals(String.valueOf(i))) {
                    resList.get(i).put("value", m.get("count").toString());
                }
            }
        }
        return ServerResponse.success("ok", resList);
    }

    /**
     * 获取用户年卖出量
     *
     * @param userId 用户id
     */
    @Override
    public ServerResponse getSaleCommoditySumByYearByUserId(Long userId) {
        List<Map> list = commodityCalDao.getSaleCommoditySumByYearByUserId(userId);
        List<Map> resList = new ArrayList<Map>();
        // 月份数据初始化
        for (int i = 0; i < 12; i++) {
            int finalI = i;
            resList.add(new HashMap() {{
                put("value", "0");
                put("index", String.valueOf((finalI + 1)));
            }});
        }
        for (Map m : list) {
            for (int i = 0; i < resList.size(); i++) {
                if (m.get("month").toString().equals(String.valueOf(i + 1))) {
                    resList.get(i).put("value", m.get("count").toString());
                }
            }
        }
        return ServerResponse.success("ok", resList);
    }
    /** -------------------- 用户卖出量计算 end --------------------*/


    /** -------------------- 用户商品浏览量计算 start --------------------*/
    /**
     * 获取用户周浏览量
     *
     * @param userId 用户id
     */
    @Override
    public ServerResponse getLookCommoditySumByWeekByUserId(Long userId) {
        List<Map> list = commodityCalDao.getLookCommoditySumByWeekByUserId(userId);
        List<Map> resList = new ArrayList<Map>();
        for (int i = 0; i < 6; i++) {
            int finalI = i;
            resList.add(new HashMap() {{
                put("value", "0");
                put("index", String.valueOf((finalI + 1)));
            }});
        }
        for (Map m : list) {
            for (int i = 0; i < resList.size(); i++) {
                if (m.get("weekday").toString().equals(String.valueOf(i))) {
                    resList.get(i).put("value", m.get("count").toString());
                }
            }
        }
        return ServerResponse.success("ok", resList);
    }

    /**
     * 获取用户月浏览量
     *
     * @param userId 用户id
     */
    @Override
    public ServerResponse getLookCommoditySumByMonthByUserId(Long userId) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM");
        // 一个月有多少天
        int days = 30;
        try {
            days = TimeUtil.getDaysOfMonth(simpleDateFormat.parse(String.valueOf(TimeUtil.cal.get(Calendar.MONTH) + 1)));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        List<Map> list = commodityCalDao.getLookCommoditySumByMonthByUserId(userId);
        List<Map> resList = new ArrayList<Map>();
        // 月份数据初始化
        for (int i = 0; i < days; i++) {
            int finalI = i;
            resList.add(new HashMap() {{
                put("value", "0");
                put("index", String.valueOf((finalI + 1)));
            }});
        }
        for (Map m : list) {
            for (int i = 0; i < resList.size(); i++) {
                if (m.get("dayofmonth").toString().equals(String.valueOf(i))) {
                    resList.get(i).put("value", m.get("count").toString());
                }
            }
        }
        return ServerResponse.success("ok", resList);
    }

    /**
     * 获取用户年浏览量
     *
     * @param userId 用户id
     */
    @Override
    public ServerResponse getLookCommoditySumByYearByUserId(Long userId) {
        List<Map> list = commodityCalDao.getLookCommoditySumByYearByUserId(userId);
        List<Map> resList = new ArrayList<Map>();
        // 月份数据初始化
        for (int i = 0; i < 12; i++) {
            int finalI = i;
            resList.add(new HashMap() {{
                put("value", "0");
                put("index", String.valueOf((finalI + 1)));
            }});
        }
        for (Map m : list) {
            for (int i = 0; i < resList.size(); i++) {
                if (m.get("month").toString().equals(String.valueOf(i + 1))) {
                    resList.get(i).put("value", m.get("count").toString());
                }
            }
        }
        return ServerResponse.success("ok", resList);
    }
    /** -------------------- 用户商品浏览量计算 end --------------------*/

    /** -------------------- 用户商品被加入购物车量计算 start --------------------*/
    /**
     * 获取用户商品周被加入购物车次数
     *
     * @param userId 用户id
     */
    @Override
    public ServerResponse getJoinShopCarCommoditySumByWeekByUserId(Long userId) {
        List<Map> list = commodityCalDao.getJoinShopCarCommoditySumByWeekByUserId(userId);
        List<Map> resList = new ArrayList<Map>();
        for (int i = 0; i < 6; i++) {
            int finalI = i;
            resList.add(new HashMap() {{
                put("value", "0");
                put("index", String.valueOf((finalI + 1)));
            }});
        }
        for (Map m : list) {
            for (int i = 0; i < resList.size(); i++) {
                if (m.get("weekday").toString().equals(String.valueOf(i))) {
                    resList.get(i).put("value", m.get("count").toString());
                }
            }
        }
        return ServerResponse.success("ok", resList);
    }

    /**
     * 获取用户商品月被加入购物车次数
     *
     * @param userId 用户id
     */
    @Override
    public ServerResponse getJoinShopCarCommoditySumByMonthByUserId(Long userId) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM");
        // 一个月有多少天
        int days = 30;
        try {
            days = TimeUtil.getDaysOfMonth(simpleDateFormat.parse(String.valueOf(TimeUtil.cal.get(Calendar.MONTH) + 1)));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        List<Map> list = commodityCalDao.getJoinShopCarCommoditySumByMonthByUserId(userId);
        List<Map> resList = new ArrayList<Map>();
        // 月份数据初始化
        for (int i = 0; i < days; i++) {
            int finalI = i;
            resList.add(new HashMap() {{
                put("value", "0");
                put("index", String.valueOf((finalI + 1)));
            }});
        }
        for (Map m : list) {
            for (int i = 0; i < resList.size(); i++) {
                if (m.get("dayofmonth").toString().equals(String.valueOf(i))) {
                    resList.get(i).put("value", m.get("count").toString());
                }
            }
        }
        return ServerResponse.success("ok", resList);
    }

    /**
     * 获取用户商品年被加入购物车次数
     *
     * @param userId 用户id
     */
    @Override
    public ServerResponse getJoinShopCarCommoditySumByYearByUserId(Long userId) {
        List<Map> list = commodityCalDao.getJoinShopCarCommoditySumByYearByUserId(userId);
        List<Map> resList = new ArrayList<Map>();
        // 月份数据初始化
        for (int i = 0; i < 12; i++) {
            int finalI = i;
            resList.add(new HashMap() {{
                put("value", "0");
                put("index", String.valueOf((finalI + 1)));
            }});
        }
        for (Map m : list) {
            for (int i = 0; i < resList.size(); i++) {
                if (m.get("month").toString().equals(String.valueOf(i + 1))) {
                    resList.get(i).put("value", m.get("count").toString());
                }
            }
        }
        return ServerResponse.success("ok", resList);
    }
    /** -------------------- 用户商品被加入购物车量计算 end --------------------*/


}
