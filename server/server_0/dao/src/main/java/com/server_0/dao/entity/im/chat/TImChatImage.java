package com.server_0.dao.entity.im.chat;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * t_im_chat_image
 * @author 
 */
@Data
public class TImChatImage implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 对话id
     */
    private Long chatId;

    /**
     * 图片文件大小,单位:字节
     */
    private Integer fileSize;

    /**
     * 图片文件名称
     */
    private String fileName;

    /**
     * 图片文件类型
     */
    private String fileType;

    /**
     * 图片文件路径
     */
    private String filePath;

    /**
     * 图片文件所在服务器ip
     */
    private String ip;

    /**
     * 内容创建时间
     */
    private Date createTime;

    /**
     * 内容更新时间
     */
    private Date updateTime;

    /**
     * 是否删除,0:否。1:是
     */
    private String isDel;

    /**
     * 是否合法,0:是。1:否
     */
    private String isLegal;

    private static final long serialVersionUID = 1L;
}