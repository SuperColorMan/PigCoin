package com.server_0.service.content;

import com.server_0.comm.web.ServerResponse;

import java.util.List;

/**
 * @ClassName CommentService
 * @Description 评论服务层接口
 * @Author SuperColorMan
 * @Date 2021/1/29 9:29 上午
 * @ModifyDate 2021/1/29 9:29 上午
 * @Version 1.0
 */
public interface CommentService {
    /**
     * 获取指定用户发起评论的内容
     */
    ServerResponse getUserCommentContentListByUserId(Long userId, Long loginUserId, Long page, Long pageSize);

    /**
     * 获取指定内容的评论列表
     */
    ServerResponse getCommentListByContentId(Long contentId, Long loginUserId, Long page, Long pageSize, List<String> filterIdList);

    /**
     * 获取指定内容的神评论列表
     */
    ServerResponse getHotCommentListByContentId(Long contentId, Long loginUserId, List<Long> contentIdList);

    /**
     * 获取指定用户的被评论的列表
     *
     * @param userId      用户id
     * @param loginUserId 登录用户id
     * @param page        页号
     * @param pageSize    页大小
     */
     ServerResponse selectCommentListByUserId(Long userId, Long loginUserId, Long page, Long pageSize);

}
