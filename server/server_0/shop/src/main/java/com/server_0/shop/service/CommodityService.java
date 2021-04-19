package com.server_0.shop.service;

import com.alibaba.fastjson.JSONArray;
import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.content.TCComment;
import com.server_0.dao.entity.shop.TShopCommodity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

/**
 * @ClassName CommodityService
 * @Description 商品服务层接口
 * @Author SuperColorMan
 * @Date 2021/2/1 10:19 上午
 * @ModifyDate 2021/2/1 10:19 上午
 * @Version 1.0
 */
public interface CommodityService {

    /**
     * 获取指定多个分类的商品
     *
     * @param commodityClassifyIds 分类id分类数组
     */
    ServerResponse getCommodityListByClassifys(String commodityClassifyIds, Long page, Long pageSize);

    /**
     * 获取指定内容的关联商品列表
     *
     * @param userId 用户id
     */
    ServerResponse getCommodityListByUserId(Long userId, Long page, Long pageSize);

    /**
     * 获取指定内容的关联商品列表
     *
     * @param contentId 内容id
     */
    ServerResponse getRelCommodityByContentId(Long contentId);

    /**
     * 根据指定的分类的商品
     *
     * @param commodityClassifyId 商品分类id
     * @param searchKeyWord       搜索关键字
     */
    ServerResponse getCommodityListByClassify(Long commodityClassifyId, String searchKeyWord, Long page, Long pageSize);

    /**
     * 搜索商品
     *
     * @param searchKeyWord 搜索关键字
     */
    ServerResponse getCommodityListBySearchKeyWord(String searchKeyWord, Long page, Long pageSize);

    /**
     * 获取指定用户关注的用户发布的商品
     *
     * @param userId 用户id
     */
    ServerResponse getCommodityListByUserAttentionUser(Long userId, Long page, Long pageSize);

    /**
     * 获取指定大类下的商品
     *
     * @param bigClassifyId 用户id
     */
    ServerResponse getCommodityListByBigClassifyId(Long bigClassifyId, Long page, Long pageSize);

    /**
     * 获取推荐商品
     */
    ServerResponse getRecommendCommodityList(Long page, Long pageSize);

    /**
     * 新增商品,以用户的身份
     *
     * @param tShopCommodity       商品信息
     * @param imgs                 文件
     * @param commodityClassifyArr 商品分类列表
     */
    ServerResponse addCommodityByUser(TShopCommodity tShopCommodity,
                                      MultipartFile[] imgs,
                                      Map<Integer, InputStream> imgSteamMap,
                                      JSONArray commodityClassifyArr);

    /** ------------------------------ 互动相关操作 start ------------------------------*/

    /**
     * 获取指定商品的评论列表
     *
     * @param commodityId 商品id
     * @param page        页号
     * @param pageSize    页大小
     * @param loginUserId 登录用户id
     */
    ServerResponse getCommentListByCommodityId(Long commodityId, Long page, Long pageSize, Long loginUserId);

    /**
     * 评论商品
     *
     * @param tcComment    评论信息
     * @param imgs         图片列表
     * @param atUserIdList @用户列表
     */
    ServerResponse commentCommodity(TCComment tcComment, List<String> atUserIdList, MultipartFile[] imgs, Map<Integer, InputStream> imgSteamMap);

    /** ------------------------------ 互动相关操作 end ------------------------------*/

}
