package com.server_0.dao.entity.message;

import com.server_0.dao.entity.content.TCContent;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * t_mess_sys_inform
 * @author 
 */
@Data
public class TMessSysInform implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 消息发送者用户id
     */
    private Long userId;

    /**
     * 消息来源id,一般是一个内容id
     */
    private Long srcId;

    /**
     * 内容创建时间
     */
    private Date createTime;

    /**
     * 是否删除,0:否。1:是
     */
    private String isDel;

    /**
     * 内容
     * */
    private TCContent tcContent;

    private static final long serialVersionUID = 1L;
}