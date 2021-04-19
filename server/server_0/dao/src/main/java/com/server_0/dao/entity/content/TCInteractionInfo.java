package com.server_0.dao.entity.content;

import lombok.Data;

import java.io.Serializable;

/**
 * t_c_interaction_info
 * @author 
 */
@Data
public class TCInteractionInfo implements Serializable {
    /**
     * 内容id
     */
    private Long contentId;

    /**
     * 内容类型
     */
    private Integer contentType;

    /**
     * 点赞数
     */
    private Long goodCount;

    /**
     * 点踩数
     */
    private Long dissCount;

    /**
     * 评论数
     */
    private Long commentCount;

    /**
     * 收藏数
     */
    private Long collCount;

    /**
     * 内容查看数
     */
    private Long lookCount;

    /**
     * 回复数
     */
    private Long replyCount;

    private static final long serialVersionUID = 1L;
}