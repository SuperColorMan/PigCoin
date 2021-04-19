package com.server_0.shop.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Maps;
import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.content.TCComment;
import com.server_0.dao.entity.content.TCContent;
import com.server_0.dao.entity.shop.TShopCommodity;
import com.server_0.shop.service.CommodityService;
import com.server_0.utils.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @ClassName CommodityController
 * @Description 商品相关控制器
 * @Author SuperColorMan
 * @Date 2021/2/1 10:21 上午
 * @ModifyDate 2021/2/1 10:21 上午
 * @Version 1.0
 */
@CrossOrigin
@RestController
@RequestMapping("/commodity/")
public class CommodityController {
    @Autowired
    CommodityService commodityService;

    /**
     * 获取指定用户的商品
     *
     * @param userId 用户id
     */
    @PostMapping("getCommodityListByUserId")
    public ServerResponse getCommodityListByUserId(Long userId, Long page, Long pageSize) {
        return commodityService.getCommodityListByUserId(userId, page, pageSize);
    }

    /**
     * 获取指定内容的关联商品列表
     *
     * @param contentId 内容id
     */
    @PostMapping("getRelCommodityByContentId")
    public ServerResponse getRelCommodityByContentId(Long contentId) {
        return commodityService.getRelCommodityByContentId(contentId);
    }

    /**
     * 根据指定的分类的商品
     *
     * @param commodityClassifyId 商品分类id
     * @param searchKeyWord       搜索关键字
     */
    @PostMapping("getCommodityListByClassify")
    public ServerResponse getCommodityListByClassify(Long commodityClassifyId, String searchKeyWord, Long page, Long pageSize) {
        return commodityService.getCommodityListByClassify(commodityClassifyId, searchKeyWord, page, pageSize);
    }

    /**
     * 获取指定多个分类的商品
     *
     * @param commodityClassifyIds 分类id分类数组
     */
    @PostMapping("getCommodityListByClassifys")
    public ServerResponse getCommodityListByClassifys(String commodityClassifyIds, Long page, Long pageSize) {
        // 商品分类信息列表
        List<JSONObject> commodityClassifyList = JSONArray.parseArray(commodityClassifyIds).toJavaList(JSONObject.class);
        // 商品分类id列表
        String classifyIds = commodityClassifyList.stream().map(e -> e.getString("id")).collect(Collectors.joining("|"));
        return commodityService.getCommodityListByClassifys(classifyIds, page, pageSize);
    }

    /**
     * 搜索商品
     *
     * @param searchKeyWord 搜索关键字
     */
    @PostMapping("getCommodityListBySearchKeyWord")
    public ServerResponse getCommodityListBySearchKeyWord(String searchKeyWord, Long page, Long pageSize) {
        return commodityService.getCommodityListBySearchKeyWord(searchKeyWord, page, pageSize);
    }

    /**
     * 获取指定用户关注的用户发布的商品
     *
     * @param userId 用户id
     */
    @PostMapping("getCommodityListByUserAttentionUser")
    public ServerResponse getCommodityListByUserAttentionUser(Long userId, Long page, Long pageSize) {
        return commodityService.getCommodityListByUserAttentionUser(userId, page, pageSize);
    }

    /**
     * 获取指定大类id的商品
     *
     * @param bigClassifyId 用户id
     */
    @PostMapping("getCommodityListByBigClassifyId")
    public ServerResponse getCommodityListByBigClassifyId(Long bigClassifyId, Long page, Long pageSize) {
        return commodityService.getCommodityListByBigClassifyId(bigClassifyId, page, pageSize);
    }

    /**
     * 获取推荐商品
     */
    @PostMapping("getRecommendCommodityList")
    public ServerResponse getRecommendCommodityList(Long page, Long pageSize) {
        return commodityService.getRecommendCommodityList(page, pageSize);
    }

    /** ------------------------------ 发布相关操作 start ------------------------------*/

    /**
     * 新增商品,以用户的身份
     *
     * @param tShopCommodity 商品信息
     * @param imgs           文件
     * @param classifyList   分类列表
     */
    @PostMapping("addCommodityByUser")
    public ServerResponse addCommodityByUser(TShopCommodity tShopCommodity,
                                             MultipartFile[] imgs,
                                             @RequestParam(value = "classifyList") String classifyList) {
        // 图片内存流
        Map<Integer, InputStream> imgSteamMap = Maps.newHashMap();
        if (!Objects.isNull(imgs) && imgs.length > 0) {
            imgSteamMap = IOUtils.mFileArr2StreamByArr(imgs);
        } else {
            imgSteamMap = null;
        }
        // 商品所属分类id列表
        JSONArray commodityClassifyArr = JSONArray.parseArray(classifyList);
        return commodityService.addCommodityByUser(tShopCommodity, imgs, imgSteamMap, commodityClassifyArr);
    }
    /** ------------------------------ 发布相关操作 end ------------------------------*/

    /** ------------------------------ 互动相关操作 start ------------------------------*/

    /**
     * 获取指定商品的评论列表
     *
     * @param commodityId 商品id
     * @param page        页号
     * @param pageSize    页大小
     * @param loginUserId 登录用户id
     */
    @PostMapping("getCommentListByCommodityId")
    public ServerResponse getCommentListByCommodityId(Long commodityId, Long page, Long pageSize, Long loginUserId) {
        return commodityService.getCommentListByCommodityId(commodityId, page, pageSize, loginUserId);
    }

    /**
     * 评论商品
     *
     * @param tcComment       评论信息
     * @param imgs            文件
     * @param atUserIdListStr @用户列表字符串
     */
    @PostMapping("commentCommodity")
    public ServerResponse commentCommodity(TCComment tcComment, String atUserIdListStr, MultipartFile[] imgs) {
        // 图片内存流
        Map<Integer, InputStream> imgSteamMap = Maps.newHashMap();
        if (!Objects.isNull(imgs) && imgs.length > 0) {
            imgSteamMap = IOUtils.mFileArr2StreamByArr(imgs);
        } else {
            imgSteamMap = null;
        }
        // @用户id list 字符串
        List<String> atUserIdList = !Objects.isNull(atUserIdListStr) ? JSONArray.parseArray(atUserIdListStr).toJavaList(String.class) : new ArrayList<String>();
        return commodityService.commentCommodity(tcComment, atUserIdList, imgs, imgSteamMap);
    }
    /** ------------------------------ 互动相关操作 end ------------------------------*/

}
