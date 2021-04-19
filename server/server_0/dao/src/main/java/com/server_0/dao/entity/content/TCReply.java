package com.server_0.dao.entity.content;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.server_0.dao.entity.img.TImgInfo;
import com.server_0.dao.entity.user.TUUser;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * t_c_reply
 *
 * @author
 */
@Data
public class TCReply implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 所属内容id
     */
    private Long contentId;

    /**
     * 被回复评论id
     */
    private Long commentId;

    /**
     * 被回复回复id
     */
    private Long replyId;

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
     * 回复
     */
    private String body;

    /**
     * 回复类型,0:回复评论,1:回复回复
     */
    private Integer byType;

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
     * 发起回复用户信息
     */
    private TUUser userInfo;

    /**
     * 被回复的回复条目的发送者信息
     */
    private TUUser byUserInfo;

    /**
     * 所属内容信息
     */
    private TCContent tcContent;

    /**
     * 所属评论信息
     */
    private TCComment tcComment;

    /**
     * 回复回复信息
     */
    private TCReply byTcReply;

    /**
     * 图片列表
     */
    private List<TImgInfo> imgList;

    /**
     * 回复互动信息
     * */
    private TCInteractionInfo tcInteractionInfo;

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

    private static final long serialVersionUID = 1L;
}