package com.server_0.dao.entity.im.chat;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * t_im_chat_content
 * @author 
 */
@Data
public class TImChatContent implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 发送者用户id
     */
    private Long userId;

    /**
     * 接受者用户id
     */
    private Long byUserId;

    /**
     * 内容正文
     */
    private String body;

    /**
     * 私信类型,根据枚举
     */
    private String type;

    /**
     * 操作时间
     */
    private Date time;

    /**
     * 是否删除,0:否,1:是
     */
    private String isDel;

    /**
     * 是否已读,0:否,1:是
     */
    private String isRead;

    private static final long serialVersionUID = 1L;
}