package com.server_0.dao.entity.user;

import lombok.Data;

import java.io.Serializable;

/**
 * t_u_interaction_info
 * @author 
 */
@Data
public class TUInteractionInfo implements Serializable {
    /**
     * 用户id
     */
    private Long userId;

    /**
     * 关注数
     */
    private Long attentionCount;

    /**
     * 粉丝数
     */
    private Long fansCount;

    /**
     * 内容发送数
     */
    private Long contentCount;

    /**
     * 获赞数
     */
    private Long byGoodCount;

    /**
     * 收藏数
     */
    private Long collectCount;

    /**
     * 被收藏数
     */
    private Long byCollectCount;

    private static final long serialVersionUID = 1L;
}