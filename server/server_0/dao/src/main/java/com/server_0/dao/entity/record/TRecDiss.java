package com.server_0.dao.entity.record;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * t_rec_diss
 * @author 
 */
@Data
public class TRecDiss implements Serializable {
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

    private static final long serialVersionUID = 1L;
}