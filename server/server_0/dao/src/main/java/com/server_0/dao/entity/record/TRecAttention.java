package com.server_0.dao.entity.record;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.server_0.comm.enums.UserMessageTypeEnum;
import com.server_0.dao.entity.user.TUUser;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * t_rec_attention
 *
 * @author
 */
@Data
public class TRecAttention implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 发起关注用户id
     */
    private Long userId;

    /**
     * 发起关注用户信息
     */
    private TUUser userInfo;

    /**
     * 被关注用户id
     */
    private Long byUserId;

    /**
     * 被关注用户信息
     */
    private TUUser byUserInfo;

    /**
     * 发生时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date time;

    /**
     * 是否删除,0:否,1:是
     */
    private String isDel;

    /**
     * 用户所属的消息类型,仅作为用户消息时才有效
     */
    private int userMessType;

    private static final long serialVersionUID = 1L;
}