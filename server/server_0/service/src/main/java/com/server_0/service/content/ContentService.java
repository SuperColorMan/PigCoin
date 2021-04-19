package com.server_0.service.content;

import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.content.TCComment;
import com.server_0.dao.entity.content.TCContent;
import com.server_0.dao.entity.content.TCReply;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

/**
 * @ClassName ContentServiceImpl
 * @Description 内容服务层接口
 * @Author SuperColorMan
 * @Date 2021/1/4 10:01 上午
 * @ModifyDate 2021/1/4 10:01 上午
 * @Version 1.0
 */
public interface ContentService {
    /**
     * 获取指定id的内容
     *
     * @param id 内容id
     */
    ServerResponse getContentById(Long id, Long loginUserId);

    /**
     * 获取指定用户的内容
     *
     * @param userId 用户id
     */
    ServerResponse getContentByUserId(Long userId, Long loginUserId, Long page, Long pageSize);

    /**
     * 获取用户全部的内容
     *
     * @param userId 用户id
     */
    ServerResponse getUserContentByClassify(Long userId, String contentClassify, Long loginUserId, Long page, Long pageSize);

    /**
     * 查询指定话题下的内容
     *
     * @param gambitId    话题id
     * @param loginUserId 登录用户id
     * @param page        页号
     * @param pageSize    页大小
     * @param type        话题页内容类型,见枚举
     */
    ServerResponse getContentListByGambitId(Long gambitId,
                                            Long loginUserId,
                                            Long page,
                                            Long pageSize,
                                            int type);

    /**
     * 获取内容根据内容类型
     */
    ServerResponse getContentByType(String contentClassify, Long loginUserId, Long page, Long pageSize);

    /**
     * 获取指定用户发起点赞的内容列表
     */
    ServerResponse getGoodContentListByUserId(Long userId, Long loginUserId, Long page, Long pageSize);

    /**
     * 获取指定用户被别人点赞的内容列表
     */
    ServerResponse getByGoodContentListByUserId(Long userId, Long loginUserId, Long page, Long pageSize);

    /**
     * 获取指定用户被收藏的内容
     */
    ServerResponse getByCollectContentListByUserId(Long userId, Long loginUserId, Long page, Long pageSize);

    /**
     * 获取指定用户被评论与@的内容
     */
    ServerResponse getByCommentAndAtContentListByUserId(Long userId,
                                                        Long loginUserId,
                                                        Long page,
                                                        Long pageSize);

    /**
     * 获取指定用户被点赞与收藏的内容
     */
    ServerResponse getByCollectAndGoodContentListByUserId(Long userId,
                                                          Long loginUserId,
                                                          Long page,
                                                          Long pageSize);

    /**
     * 获取搜索页结果集内容分类
     */
    ServerResponse getSearchResultType();

    /**
     * 搜索内容
     */
    ServerResponse searchContent(String keyWord,
                                 Long loginUserId,
                                 Long page,
                                 Long pageSize,
                                 int searchType);

    /**
     * 获取指定用户的查看内容历史
     */
    ServerResponse getLookContentHistoryByUserId(String userId,
                                                 Long loginUserId,
                                                 Long page,
                                                 Long pageSize);

    /** ------------------------------ 内容上传处理区域 start ------------------------------*/

    /**
     * 上传内容
     *
     * @param tcContent    内容信息
     * @param imgs         文件
     * @param atUserIdList @用户列表
     */
    ServerResponse upContent(TCContent tcContent, List<String> atUserIdList, List<String> joinGambitIdList, MultipartFile[] imgs, Map<Integer, InputStream> imgSteamMap);

    /**
     * 评论
     *
     * @param tcComment    评论信息
     * @param imgs         文件
     * @param atUserIdList @用户列表
     */
    public ServerResponse commentContent(TCComment tcComment, List<String> atUserIdList, MultipartFile[] imgs, Map<Integer, InputStream> imgSteamMap);

    /**
     * 回复
     *
     * @param tcReply      回复信息
     * @param imgs         文件
     * @param atUserIdList @用户列表
     */
    public ServerResponse reply(TCReply tcReply, List<String> atUserIdList, MultipartFile[] imgs, Map<Integer, InputStream> imgSteamMap);

    /** ------------------------------ 内容上传处理区域 end ------------------------------*/

}
