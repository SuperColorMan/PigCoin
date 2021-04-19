package com.server_0.shop.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.server_0.comm.enums.CommoditySrcTypeEnum;
import com.server_0.comm.enums.ContentTypeEnum;
import com.server_0.comm.enums.ImgTypeEnum;
import com.server_0.comm.enums.MoneyUnitEnum;
import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.content.TCComment;
import com.server_0.dao.entity.content.TCInteractionInfo;
import com.server_0.dao.entity.record.TRecAt;
import com.server_0.dao.entity.record.TRecJoinGambit;
import com.server_0.dao.entity.shop.TShopCommodity;
import com.server_0.dao.entity.shop.TShopCommodityClassify;
import com.server_0.dao.entity.shop.TShopInteractionInfo;
import com.server_0.dao.mappers.content.TCCommentDao;
import com.server_0.dao.mappers.content.TCInteractionInfoDao;
import com.server_0.dao.mappers.content.TCReplyDao;
import com.server_0.dao.mappers.record.TRecAtDao;
import com.server_0.dao.mappers.shop.TShopCommodityClassifyDao;
import com.server_0.dao.mappers.shop.TShopCommodityDao;
import com.server_0.dao.mappers.shop.TShopInteractionInfoDao;
import com.server_0.queue.local.LocalMQconsumerThread;
import com.server_0.service.comm.CommService;
import com.server_0.service.content.impl.ContentServiceImpl;
import com.server_0.shop.service.CommodityService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @ClassName CommodityServiceImpl
 * @Description 商品服务层接口实现类
 * @Author SuperColorMan
 * @Date 2021/2/1 10:20 上午
 * @ModifyDate 2021/2/1 10:20 上午
 * @Version 1.0
 */
@Service
public class CommodityServiceImpl implements CommodityService {

    /**
     * 日志工具
     */
    private static Logger logger = LoggerFactory.getLogger(CommodityServiceImpl.class);

    @Autowired
    TShopCommodityDao tShopCommodityDao;
    @Autowired
    TCCommentDao tcCommentDao;
    @Autowired
    TShopInteractionInfoDao tShopInteractionInfoDao;
    @Autowired
    CommService commService;
    @Autowired
    TRecAtDao tRecAtDao;
    @Autowired
    TCInteractionInfoDao tcInteractionInfoDao;
    @Autowired
    TShopCommodityClassifyDao tShopCommodityClassifyDao;

    /**
     * 获取指定内容的关联商品列表
     *
     * @param userId 内容id
     */
    @Override
    public ServerResponse getCommodityListByUserId(Long userId, Long page, Long pageSize) {
        List<TShopCommodity> tShopCommodityList = tShopCommodityDao.getCommodityListByUserId(userId, page, pageSize);
        return ServerResponse.success("ok", tShopCommodityList);
    }

    /**
     * 获取指定内容的关联商品列表
     *
     * @param contentId 内容id
     */
    @Override
    public ServerResponse getRelCommodityByContentId(Long contentId) {
        List<TShopCommodity> tShopCommodityList = tShopCommodityDao.getRelCommodityByContentId(contentId, ContentTypeEnum.CONTENT.getType());
        return ServerResponse.success("ok", tShopCommodityList);
    }

    /**
     * ,根据指定的分类的商品
     *
     * @param commodityClassifyId 商品分类id
     * @param searchKeyWord       搜索关键字
     */
    @Override
    public ServerResponse getCommodityListByClassify(Long commodityClassifyId, String searchKeyWord, Long page, Long pageSize) {
        List<TShopCommodity> tShopCommodityList = tShopCommodityDao.getCommodityListByClassify(commodityClassifyId, searchKeyWord, page, pageSize);
        return ServerResponse.success("ok", tShopCommodityList);
    }

    /**
     * 搜索商品
     *
     * @param searchKeyWord 搜索关键字
     */
    @Override
    public ServerResponse getCommodityListBySearchKeyWord(String searchKeyWord, Long page, Long pageSize) {
        List<TShopCommodity> tShopCommodityList = tShopCommodityDao.getCommodityListBySearchKeyWord(searchKeyWord, page, pageSize);
        return ServerResponse.success("ok", tShopCommodityList);
    }

    /**
     * 获取指定用户关注的用户发布的商品
     *
     * @param userId 用户id
     */
    @Override
    public ServerResponse getCommodityListByUserAttentionUser(Long userId, Long page, Long pageSize) {
        List<TShopCommodity> tShopCommodityList = tShopCommodityDao.getCommodityListByUserAttentionUser(userId, page, pageSize);
        return ServerResponse.success("ok", tShopCommodityList);
    }

    /**
     * 获取指定多个分类的商品
     *
     * @param commodityClassifyIds 分类id分类数组
     */
    @Override
    public ServerResponse getCommodityListByClassifys(String commodityClassifyIds, Long page, Long pageSize) {
        List<TShopCommodity> tShopCommodityList = tShopCommodityDao.getCommodityListByClassifyId(commodityClassifyIds, page, pageSize);
        return ServerResponse.success("ok", tShopCommodityList);
    }

    /**
     * 获取指定大类下的商品
     *
     * @param bigClassifyId 用户id
     */
    @Override
    public ServerResponse getCommodityListByBigClassifyId(Long bigClassifyId, Long page, Long pageSize) {
        List<TShopCommodityClassify> tShopCommodityClassifyList = tShopCommodityClassifyDao.getSmallClassifyListByBigClassifyId(bigClassifyId);
        if (tShopCommodityClassifyList.size() == 0) {
            // 不存在所属小类
            return ServerResponse.success("ok", tShopCommodityClassifyList);
        }
        String classifyIds = tShopCommodityClassifyList.stream().map(e -> e.getId().toString()).collect(Collectors.joining("|"));
        List<TShopCommodity> tShopCommodityList = tShopCommodityDao.getCommodityListByClassifyId(classifyIds, page, pageSize);
        return ServerResponse.success("ok", tShopCommodityList);
    }

    /**
     * 获取推荐商品
     */
    @Override
    public ServerResponse getRecommendCommodityList(Long page, Long pageSize) {
        List<TShopCommodity> tShopCommodityList = tShopCommodityDao.getRecommendCommodityList(page, pageSize);
        return ServerResponse.success("ok", tShopCommodityList);
    }

    /**
     * 新增商品,以用户的身份
     *
     * @param tShopCommodity       商品信息
     * @param imgs                 文件
     * @param commodityClassifyArr 商品分类列表
     */
    @Override
    public ServerResponse addCommodityByUser(TShopCommodity tShopCommodity,
                                             MultipartFile[] imgs,
                                             Map<Integer, InputStream> imgSteamMap,
                                             JSONArray commodityClassifyArr) {

        LocalMQconsumerThread.addQueueItem(() -> {
            if (!Objects.isNull(tShopCommodity)) {
                // 商品上传者用户id
                Long userId = tShopCommodity.getCommoditySrcId();
                // 设置商品来源类型
                tShopCommodity.setCommoditySrcType(String.valueOf(CommoditySrcTypeEnum.USER.getType()));
                //设置分类
                StringBuffer commodityClassifyStr = new StringBuffer();
                for (int i = 0; i < commodityClassifyArr.size(); i++) {
                    JSONObject commodityClassify = commodityClassifyArr.getJSONObject(i);
                    commodityClassifyStr.append(commodityClassify.getString("id"));
                    if (i < commodityClassifyArr.size() - 1) {
                        commodityClassifyStr.append(",");
                    }
                }
                tShopCommodity.setClassifyId(commodityClassifyStr.toString());
                // 设置货币单位
                tShopCommodity.setFreightUnit(MoneyUnitEnum.RMB.getUnit());
                tShopCommodity.setPriceUnit(MoneyUnitEnum.RMB.getUnit());
                // 插入内容
                tShopCommodityDao.insertSelective(tShopCommodity);
                // 商品id
                Long commodityId = tShopCommodity.getId();
                // 插入商品互动数据
                TShopInteractionInfo tShopInteractionInfo = new TShopInteractionInfo();
                tShopInteractionInfo.setCommodityId(commodityId);
                tShopInteractionInfoDao.insertSelective(tShopInteractionInfo);
                if (!Objects.isNull(imgs)) {
                    // 处理图片上传
                    commService.commodityImgUpLoadByArr(imgs, commodityId, userId, imgSteamMap);
                }
            }
            logger.info("内容上传");
        });
        return ServerResponse.success("ok");
    }

    /** ------------------------------ 互动相关操作 start ------------------------------*/
    /**
     * 获取指定商品的评论列表
     *
     * @param commodityId 商品id
     * @param page        页号
     * @param pageSize    页大小
     * @param loginUserId 登录用户id
     */
    @Override
    public ServerResponse getCommentListByCommodityId(Long commodityId, Long page, Long pageSize, Long loginUserId) {
        List<TCComment> tcCommentList = tcCommentDao.selectCommentListByCommodityId(commodityId, page, pageSize, loginUserId);
        return ServerResponse.success("ok", tcCommentList);
    }

    /**
     * 评论商品
     *
     * @param tcComment    评论信息
     * @param imgs         图片列表
     * @param atUserIdList @用户列表
     */
    @Override
    public ServerResponse commentCommodity(TCComment tcComment, List<String> atUserIdList, MultipartFile[] imgs, Map<Integer, InputStream> imgSteamMap) {
        //添加到队列中处理
        LocalMQconsumerThread.addQueueItem(() -> {
            if (!Objects.isNull(tcComment)) {
                // 内容上传者用户id
                Long userId = tcComment.getUserId();
                // 指定被评论内容类型
                tcComment.setContentType(ContentTypeEnum.COMMODITY.getType());
                // 插入内容
                tcCommentDao.insertSelective(tcComment);
                // 插入互动数据
                TCInteractionInfo tcInteractionInfo = new TCInteractionInfo();
                tcInteractionInfo.setContentId(tcComment.getId());
                tcInteractionInfo.setContentType(ContentTypeEnum.COMMENT.getType());
                tcInteractionInfoDao.insertSelective(tcInteractionInfo);
                // 内容id
                Long contentId = tcComment.getId();
                if (!Objects.isNull(atUserIdList)) {
                    // 处理at用户
                    for (String id : atUserIdList) {
                        Long byUserId = Long.parseLong(id);
                        TRecAt tRecAt = new TRecAt();
                        tRecAt.setUserId(userId);
                        tRecAt.setByUserId(byUserId);
                        tRecAt.setSrcId(contentId);
                        tRecAt.setSrcType(String.valueOf(ContentTypeEnum.COMMENT.getType()));
                        tRecAtDao.insertSelective(tRecAt);
                    }
                }
                if (!Objects.isNull(imgs)) {
                    // 处理图片上传
                    commService.imgUpLoadByArr(imgs, contentId, userId, imgSteamMap, ImgTypeEnum.COMMENTIMG);
                }
            }
            logger.info("评论");
        });
        return ServerResponse.success("ok");
    }
    /** ------------------------------ 互动相关操作 end ------------------------------*/

}
