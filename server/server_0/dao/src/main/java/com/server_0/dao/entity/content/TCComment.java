package com.server_0.dao.entity.content;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.server_0.dao.entity.img.TImgInfo;
import com.server_0.dao.entity.user.TUUser;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * t_c_comment
 *
 * @author
 */
@Data
public class TCComment implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 所属内容id
     */
    private Long contentId;

    /**
     * 内容类型
     */
    private Integer contentType;

    /**
     * 用户id
     */
    private Long userId;

    /**
     * 被回复用户id
     */
    private Long byUserId;

    /**
     * 被回复用户名
     */
    private String byUserName;

    /**
     * 评论正文
     */
    private String body;

    /**
     * 内容创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date createTime;

    /**
     * 是否删除,0:否,1:是
     */
    private String isDel;

    /**
     * 是否合法,0:是,1:否
     */
    private String isLegal;

    /**
     * 所属内容信息
     */
    private TCContent tcContent;

    /**
     * 所属用户信息
     */
    private TUUser tuUser;

    /**
     * 图片列表
     */
    private List<TImgInfo> imgList;

    /**
     * 评论互动信息
     * */
    private TCInteractionInfo tcInteractionInfo=new TCInteractionInfo();

    /**
     * 是否点赞
     */
    private Integer isGood;
    /**
     * 是否点踩
     */
    private Integer isDiss;
    /**
     * 是否收藏
     */
    private Integer isColl;

    /**
     * 时间距今的差集时间
     */
    private String diffTime;

    /**
     * 所属该评论的神回复列表
     */
    private List<TCReply> hotReplyList;

    /**
     * 评论所属的内容的作者回复
     * */
    private List<TCReply> authorReplyList;

    private static final long serialVersionUID = 1L;
}