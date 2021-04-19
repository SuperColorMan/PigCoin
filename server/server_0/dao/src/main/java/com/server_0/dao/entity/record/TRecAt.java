package com.server_0.dao.entity.record;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.server_0.comm.enums.UserMessageTypeEnum;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * t_rec_at
 *
 * @author
 */
@Data
public class TRecAt implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 发起@用户id
     */
    private Long userId;

    /**
     * 被@用户id
     */
    private Long byUserId;

    /**
     * 来源id
     */
    private Long srcId;

    /**
     * 来源类型,由枚举决定
     */
    private String srcType;

    /**
     * 操作时间
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