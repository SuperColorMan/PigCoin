package com.server_0.service.content;

import com.server_0.comm.web.ServerResponse;

import java.util.List;

/**
 * @ClassName ReplyService
 * @Description 回复服务层接口
 * @Author SuperColorMan
 * @Date 2021/1/29 9:29 上午
 * @ModifyDate 2021/1/29 9:29 上午
 * @Version 1.0
 */
public interface ReplyService {
    /**
     * 获取指定评论的神回复列表
     */
    ServerResponse getHotReplyListByCommentId(Long commentId, Long loginUserId, List<Long> contentIdList);

    /**
     * 获取指定用户在指定内容中的指定评论中的回复
     */
    ServerResponse getHotReplyListByContentAndCommentId(List<Long> userIdList,List<Long> contentIdList,List<Long> commentIdList, Long loginUserId);
    /**
     * 获取指定评论的回复列表
     */
    ServerResponse getReplyListByCommentId(Long contentId, Long loginUserId, Long commentId, Long page, Long pageSize);

    /**
     * 获取指定用户的被回复的列表
     */
    ServerResponse selectReplyListByUserId(Long userId, Long loginUserId, Long page, Long pageSize);

}
