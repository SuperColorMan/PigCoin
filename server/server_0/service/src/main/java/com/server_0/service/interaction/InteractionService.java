package com.server_0.service.interaction;

import com.server_0.comm.web.ServerResponse;
import org.springframework.web.bind.annotation.PostMapping;

/**
 * @ClassName InteractionService
 * @Description 互动服务层接口
 * @Author SuperColorMan
 * @Date 2021/1/4 1:35 下午
 * @ModifyDate 2021/1/4 1:35 下午
 * @Version 1.0
 */
public interface InteractionService {
    /**
     * 点赞
     */
    ServerResponse good(Long contentId, Integer contentType, Long loginUserId, Long byUserId);

    /**
     * 取消点赞
     */
    ServerResponse cancelGood(Long contentId, Integer contentType, Long loginUserId, Long byUserId);

    /**
     * 点踩
     */
    ServerResponse diss(Long contentId, Integer contentType, Long loginUserId, Long byUserId);

    /**
     * 取消点踩
     */
    ServerResponse cancelDiss(Long contentId, Integer contentType, Long loginUserId, Long byUserId);

    /**
     * 收藏
     */
    ServerResponse collect(Long contentId, Integer contentType, Long loginUserId, Long byUserId);

    /**
     * 取消收藏
     */
    ServerResponse cancelCollect(Long contentId, Integer contentType, Long loginUserId, Long byUserId);

    /**
     * 查看
     */
    ServerResponse look(Long contentId, Integer contentType, Long loginUserId, Long byUserId);

    /**
     * 取消查看
     */
    ServerResponse cancelLook(Long contentId, Integer contentType, Long loginUserId, Long byUserId);

    /**
     * 关注
     *
     * @param userId   发起关注用户id
     * @param byUserId 被关注用户id
     */
    ServerResponse attention(Long userId, Long byUserId);

    /**
     * 取消关注
     *
     * @param userId   发起关注用户id
     * @param byUserId 被关注用户id
     */
    ServerResponse cancelAttention(Long userId, Long byUserId);
}
