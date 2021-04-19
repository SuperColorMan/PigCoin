package com.server_0.dao.entity.content;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.server_0.dao.entity.gambit.TGGambit;
import com.server_0.dao.entity.img.TImgInfo;
import com.server_0.dao.entity.shop.TShopCommodity;
import com.server_0.dao.entity.user.TUUser;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * t_c_content
 *
 * @author
 */
@Data
public class TCContent implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 用户id
     */
    private Long userId;

    /**
     * 用户信息
     */
    private TUUser tuUser;

    /**
     * 内容正文
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
     * 内容所属的图片列表
     */
    private List<TImgInfo> imgList;

    /**
     * 内容互动信息
     */
    private TCInteractionInfo tcInteractionInfo = new TCInteractionInfo();

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
     * 是否评论
     */
    private Integer isComment;

    /**
     * 在使用评论id反查的时候使用,其他时候不使用
     */
    private TCComment tcComment;

    /**
     * 用于标记内容在用户页中的类型
     */
    private int userContentType;

    /**
     * 所属该内容的神评论列表
     */
    private List<TCComment> hotCommentList;

    /**
     * 内容加入的话题列表
     */
    private List<TGGambit> joinGambitList;

    /**
     * 与内容绑定的商品列表
     */
    private List<TShopCommodity> commodityList;

    /**
     * 时间距今的差集时间
     */
    private String diffTime;

    /**
     * 用户所属的消息类型,仅作为用户消息时才有效
     */
    private int userMessType;
    /**
     * 用户所属的消息时间,仅作为用户消息时才有效
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date userMessTime;

    private static final long serialVersionUID = 1L;
}