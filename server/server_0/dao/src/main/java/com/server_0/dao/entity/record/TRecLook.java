package com.server_0.dao.entity.record;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * t_rec_look
 * @author 
 */
@Data
public class TRecLook implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 用户id
     */
    private Long userId;

    /**
     * 被操作用户id
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

    private static final long serialVersionUID = 1L;
}