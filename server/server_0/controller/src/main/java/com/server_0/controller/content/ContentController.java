package com.server_0.controller.content;

import com.alibaba.fastjson.JSONArray;
import com.google.common.collect.Maps;
import com.server_0.comm.enums.ContentTypeEnum;
import com.server_0.comm.enums.ImgTypeEnum;
import com.server_0.comm.global.GlobalConstant;
import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.content.TCComment;
import com.server_0.dao.entity.content.TCContent;
import com.server_0.dao.entity.content.TCReply;
import com.server_0.service.content.ContentService;
import com.server_0.utils.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * @ClassName ContentController
 * @Description 内容控制器
 * @Author SuperColorMan
 * @Date 2021/1/4 9:56 上午
 * @ModifyDate 2021/1/4 9:56 上午
 * @Version 1.0
 */
@CrossOrigin
@RestController
@RequestMapping("/c/")
public class ContentController {
    @Autowired
    ContentService contentService;

    /**
     * 获取指定id的内容
     */
    @PostMapping("getContentById")
    public ServerResponse getContentById(Long id, Long loginUserId) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        return contentService.getContentById(id, loginUserId);
    }

    /**
     * 获取用户全部的内容 getUserAllContentList
     */
    @PostMapping("getUserContentByClassify")
    public ServerResponse getUserContentByClassify(Long userId, String contentClassify, Long loginUserId, Long page, Long pageSize) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        return contentService.getUserContentByClassify(userId, contentClassify, loginUserId, page, pageSize);
    }

    /**
     * 获取指定分类的内容
     */
    @PostMapping("getContentByType")
    public ServerResponse getContentByType(String contentClassify, Long loginUserId, Long page, Long pageSize) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        return contentService.getContentByType(contentClassify, loginUserId, page, pageSize);
    }

    /**
     * 获取指定用户的内容
     */
    @PostMapping("getContentByUserId")
    public ServerResponse getContentByUserId(Long userId, Long loginUserId, Long page, Long pageSize) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        return contentService.getContentByUserId(userId, page, pageSize, loginUserId);
    }

    /**
     * 获取话题下的内容列表
     */
    @PostMapping("getContentListByGambitId")
    public ServerResponse getContentListByGambitId(Long gambitId,
                                                   Long loginUserId,
                                                   Long page,
                                                   Long pageSize,
                                                   int type) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        return contentService.getContentListByGambitId(gambitId, loginUserId, page, pageSize, type);
    }

    /**
     * 获取指定用户发起点赞的内容列表
     */
    @PostMapping("getGoodContentListByUserId")
    public ServerResponse getGoodContentListByUserId(Long userId, Long loginUserId, Long page, Long pageSize) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        return contentService.getGoodContentListByUserId(userId, loginUserId, page, pageSize);
    }

    /**
     * 获取指定用户被别人点赞的内容列表
     */
    @PostMapping("getByGoodContentListByUserId")
    public ServerResponse getByGoodContentListByUserId(Long userId, Long loginUserId, Long page, Long pageSize) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        return contentService.getByGoodContentListByUserId(userId, loginUserId, page, pageSize);
    }

    /**
     * 获取指定用户被收藏的内容
     */
    @PostMapping("getByCollectContentListByUserId")
    public ServerResponse getByCollectContentListByUserId(Long userId,
                                                          Long loginUserId,
                                                          Long page,
                                                          Long pageSize) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        return contentService.getByCollectContentListByUserId(userId, loginUserId, page, pageSize);
    }

    /**
     * 获取指定用户被点赞与收藏的内容
     */
    @PostMapping("getByCollectAndGoodContentListByUserId")
    public ServerResponse getByCollectAndGoodContentListByUserId(Long userId,
                                                                 Long loginUserId,
                                                                 Long page,
                                                                 Long pageSize) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        return contentService.getByCollectAndGoodContentListByUserId(userId, loginUserId, page, pageSize);
    }

    /**
     * 获取指定用户被评论与@的内容
     */
    @PostMapping("getByCommentAndAtContentListByUserId")
    public ServerResponse getByCommentAndAtContentListByUserId(Long userId,
                                                               Long loginUserId,
                                                               Long page,
                                                               Long pageSize) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        return contentService.getByCommentAndAtContentListByUserId(userId, loginUserId, page, pageSize);
    }

    /**
     * 获取搜索页结果集内容分类
     */
    @PostMapping("getSearchResultType")
    public ServerResponse getSearchResultType() {
        return contentService.getSearchResultType();
    }

    /**
     * 搜索内容
     */
    @PostMapping("searchContent")
    public ServerResponse searchContent(String keyWord,
                                        Long loginUserId,
                                        Long page,
                                        Long pageSize,
                                        int searchType) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        return contentService.searchContent(keyWord, loginUserId, page, pageSize, searchType);
    }


    /**
     * 获取指定用户的查看内容历史
     */
    @PostMapping("getLookContentHistoryByUserId")
    public ServerResponse getLookContentHistoryByUserId(String userId,
                                                        Long loginUserId,
                                                        Long page,
                                                        Long pageSize) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        return contentService.getLookContentHistoryByUserId(userId, loginUserId, page, pageSize);
    }

    /** ------------------------------ 内容上传处理区域 start ------------------------------*/

    /**
     * 上传内容
     *
     * @param tcContent           内容信息
     * @param imgs                文件
     * @param atUserIdListStr     @用户列表
     * @param joinGambitIdListStr 加入的话题列表
     */
    @PostMapping("upContent")
    public ServerResponse upContent(TCContent tcContent, String atUserIdListStr, String joinGambitIdListStr, MultipartFile[] imgs) {
        // 图片内存流
        Map<Integer, InputStream> imgSteamMap = Maps.newHashMap();
        if (!Objects.isNull(imgs) && imgs.length > 0) {
            imgSteamMap = IOUtils.mFileArr2StreamByArr(imgs);
        } else {
            imgSteamMap = null;
        }
        // @用户id list 字符串
        List<String> atUserIdList = !Objects.isNull(atUserIdListStr) ? JSONArray.parseArray(atUserIdListStr).toJavaList(String.class) : new ArrayList<String>();
        // 加入的话题id list 字符串
        List<String> joinGambitIdList = !Objects.isNull(joinGambitIdListStr) ? JSONArray.parseArray(joinGambitIdListStr).toJavaList(String.class) : new ArrayList<String>();
        return contentService.upContent(tcContent, atUserIdList, joinGambitIdList, imgs, imgSteamMap);
    }

    /**
     * 评论内容
     *
     * @param tcComment       评论信息
     * @param imgs            文件
     * @param atUserIdListStr @用户列表字符串
     */
    @PostMapping("commentContent")
    public ServerResponse commentContent(TCComment tcComment, String atUserIdListStr, MultipartFile[] imgs) {
        // 图片内存流
        Map<Integer, InputStream> imgSteamMap = Maps.newHashMap();
        if (!Objects.isNull(imgs) && imgs.length > 0) {
            imgSteamMap = IOUtils.mFileArr2StreamByArr(imgs);
        } else {
            imgSteamMap = null;
        }
        // @用户id list 字符串
        List<String> atUserIdList = !Objects.isNull(atUserIdListStr) ? JSONArray.parseArray(atUserIdListStr).toJavaList(String.class) : new ArrayList<String>();
        return contentService.commentContent(tcComment, atUserIdList, imgs, imgSteamMap);
    }

    /**
     * 回复
     *
     * @param tcReply         回复信息
     * @param imgs            文件
     * @param atUserIdListStr @用户列表字符串
     */
    @PostMapping("reply")
    public ServerResponse reply(TCReply tcReply, String atUserIdListStr, MultipartFile[] imgs) {
        // 图片内存流
        Map<Integer, InputStream> imgSteamMap = Maps.newHashMap();
        if (!Objects.isNull(imgs) && imgs.length > 0) {
            imgSteamMap = IOUtils.mFileArr2StreamByArr(imgs);
        } else {
            imgSteamMap = null;
        }
        // @用户id list 字符串
        List<String> atUserIdList = !Objects.isNull(atUserIdListStr) ? JSONArray.parseArray(atUserIdListStr).toJavaList(String.class) : new ArrayList<String>();
        return contentService.reply(tcReply, atUserIdList, imgs, imgSteamMap);
    }

    /** ------------------------------ 内容上传处理区域 end ------------------------------*/

}
