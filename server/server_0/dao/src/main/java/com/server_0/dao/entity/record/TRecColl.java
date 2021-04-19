package com.server_0.dao.entity.record;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.server_0.comm.enums.UserMessageTypeEnum;
import com.server_0.dao.entity.content.TCContent;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * t_rec_coll
 *
 * @author
 */
@Data
public class TRecColl implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 操作用户id
     */
    private Long userId;

    /**
     * 被操作用户id
     */
    private Long byUserId;

    /**
     * 被操作资源id
     */
    private Long resId;

    /**
     * 被操作资源类型
     */
    private Integer type;

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
     * 被收藏内容
     */
    private TCContent tcContent;

    /**
     * 用户所属的消息类型,仅作为用户消息时才有效
     */
    private int userMessType;

    private static final long serialVersionUID = 1L;
}