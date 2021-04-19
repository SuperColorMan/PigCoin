package com.server_0.dao.entity.user;

import lombok.Data;

import java.io.Serializable;

/**
 * t_u_inform_setting
 * @author 
 */
@Data
public class TUInformSetting implements Serializable {
    /**
     * 用户id
     */
    private Long userId;

    /**
     * 是否推送热门内容,0:否,1:是
     */
    private String isHotContentPush;

    /**
     * 是否推送关注的人更新的内容,0:否,1:是
     */
    private String isAttUserUpdatePush;

    /**
     * 评论是否通知,0:否,1:是
     */
    private String isCommentInform;

    /**
     * 点赞是否通知,0:否,1:是
     */
    private String isGoodInform;

    /**
     * 关注该用户是否通知,0:否,1:是
     */
    private String isAttInform;

    /**
     * @该用户是否通知,0:否,1:是
     */
    private String isAtInform;

    /**
     * 私信是否通知,0:否,1:是
     */
    private String isChatInform;

    private static final long serialVersionUID = 1L;
}