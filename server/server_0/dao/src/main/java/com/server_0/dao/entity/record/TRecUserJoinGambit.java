package com.server_0.dao.entity.record;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * t_rec_user_join_gambit
 * @author 
 */
@Data
public class TRecUserJoinGambit implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 话题id
     */
    private Long gambitId;

    /**
     * 用户id
     */
    private Long userId;

    /**
     * 操作时间
     */
    private Date time;

    /**
     * 是否删除,0:否,1:是
     */
    private String isDel;

    private static final long serialVersionUID = 1L;
}