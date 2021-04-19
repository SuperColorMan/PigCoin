package com.server_0.dao.entity.message;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.server_0.dao.entity.content.TCComment;
import com.server_0.dao.entity.content.TCContent;
import com.server_0.dao.entity.content.TCReply;
import com.server_0.dao.entity.record.TRecAt;
import com.server_0.dao.entity.record.TRecAttention;
import com.server_0.dao.entity.record.TRecGood;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * t_mess_message
 *
 * @author
 */
@Data
public class TMessMessage implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 消息发送者用户id
     */
    private Long userId;

    /**
     * 需通知的用户id
     */
    private Long byUserId;

    /**
     * 消息来源id
     */
    private Long srcId;

    /**
     * 消息类型,由枚举决定
     */
    private String srcType;

    /**
     * 内容创建时间
     */
    private Date createTime;

    /**
     * 是否删除,0:否。1:是
     */
    private String isDel;

    /**
     * 系统通知
     * */
    private TMessSysInform tMessSysInform;

    /**
     * 私信消息
     * */


    private static final long serialVersionUID = 1L;
}