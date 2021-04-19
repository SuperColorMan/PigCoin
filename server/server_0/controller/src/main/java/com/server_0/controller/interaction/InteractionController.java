package com.server_0.controller.interaction;


import com.server_0.comm.enums.ContentTypeEnum;
import com.server_0.comm.web.ServerResponse;
import com.server_0.service.interaction.InteractionService;
import com.server_0.utils.id.IDUtils;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName InteractionController
 * @Description 互动接口
 * @Author SuperColorMan
 * @Date 2021/1/4 3:48 下午
 * @ModifyDate 2021/1/4 3:48 下午
 * @Version 1.0
 */
@CrossOrigin
@RestController
@RequestMapping("/interaction/")
public class InteractionController {
    @Autowired
    InteractionService interactionService;

    // -------------------------------- 点赞互动区域 start --------------------------------

    /**
     * 点赞内容
     */
    @PostMapping("goodContent")
    public ServerResponse goodContent(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.good(contentId, ContentTypeEnum.CONTENT.getType(), loginUserId, byUserId);
    }

    /**
     * 点赞评论
     */
    @PostMapping("goodComment")
    public ServerResponse goodComment(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.good(contentId, ContentTypeEnum.COMMENT.getType(), loginUserId, byUserId);
    }

    /**
     * 点赞回复
     */
    @PostMapping("goodReply")
    public ServerResponse goodReply(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.good(contentId, ContentTypeEnum.REPLY.getType(), loginUserId, byUserId);
    }

    /**
     * 取消点赞内容
     */
    @PostMapping("cancelGoodContent")
    public ServerResponse cancelGoodContent(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.cancelGood(contentId, ContentTypeEnum.CONTENT.getType(), loginUserId, byUserId);
    }

    /**
     * 取消点赞评论
     */
    @PostMapping("cancelGoodComment")
    public ServerResponse cancelGoodComment(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.cancelGood(contentId, ContentTypeEnum.COMMENT.getType(), loginUserId, byUserId);
    }

    /**
     * 取消点赞回复
     */
    @PostMapping("cancelGoodReply")
    public ServerResponse cancelGoodReply(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.cancelGood(contentId, ContentTypeEnum.REPLY.getType(), loginUserId, byUserId);
    }
    // -------------------------------- 点赞互动区域 end --------------------------------

    // -------------------------------- 点踩互动区域 start --------------------------------

    /**
     * 点踩
     */
    @PostMapping("dissContent")
    public ServerResponse dissContent(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.diss(contentId, ContentTypeEnum.CONTENT.getType(), loginUserId, byUserId);
    }

    /**
     * 点踩
     */
    @PostMapping("dissComment")
    public ServerResponse dissComment(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.diss(contentId, ContentTypeEnum.COMMENT.getType(), loginUserId, byUserId);
    }

    /**
     * 点踩
     */
    @PostMapping("dissReply")
    public ServerResponse dissReply(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.diss(contentId, ContentTypeEnum.REPLY.getType(), loginUserId, byUserId);
    }

    /**
     * 点踩
     */
    @PostMapping("cancelDissContent")
    public ServerResponse cancelDissContent(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.cancelDiss(contentId, ContentTypeEnum.COMMENT.getType(), loginUserId, byUserId);
    }

    /**
     * 点踩
     */
    @PostMapping("cancelDissComment")
    public ServerResponse cancelDissComment(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.cancelDiss(contentId, ContentTypeEnum.COMMENT.getType(), loginUserId, byUserId);
    }

    /**
     * 点踩
     */
    @PostMapping("cancelDissReply")
    public ServerResponse cancelDissReply(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.cancelDiss(contentId, ContentTypeEnum.REPLY.getType(), loginUserId, byUserId);
    }

    // -------------------------------- 点踩互动区域 end --------------------------------


    // -------------------------------- 收藏互动区域 start --------------------------------

    /**
     * 收藏
     */
    @PostMapping("collectContent")
    public ServerResponse collectContent(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.collect(contentId, ContentTypeEnum.CONTENT.getType(), loginUserId, byUserId);
    }

    /**
     * 收藏评论
     */
    @PostMapping("collectComment")
    public ServerResponse collectComment(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.collect(contentId, ContentTypeEnum.COMMENT.getType(), loginUserId, byUserId);
    }

    /**
     * 收藏回复
     */
    @PostMapping("collectReply")
    public ServerResponse collectReply(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.collect(contentId, ContentTypeEnum.REPLY.getType(), loginUserId, byUserId);
    }

    /**
     * 取消收藏
     */
    @PostMapping("cancelCollectContent")
    public ServerResponse cancelCollectContent(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.cancelCollect(contentId, ContentTypeEnum.CONTENT.getType(), loginUserId, byUserId);
    }

    /**
     * 取消收藏评论
     */
    @PostMapping("cancelCollectComment")
    public ServerResponse cancelCollectComment(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.cancelCollect(contentId, ContentTypeEnum.COMMENT.getType(), loginUserId, byUserId);
    }

    /**
     * 取消收藏回复
     */
    @PostMapping("cancelCollectReply")
    public ServerResponse cancelCollectReply(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.cancelCollect(contentId, ContentTypeEnum.REPLY.getType(), loginUserId, byUserId);
    }

    // -------------------------------- 收藏互动区域 end --------------------------------


    // -------------------------------- 查看互动区域 end --------------------------------

    /**
     * 查看内容
     */
    @PostMapping("lookContent")
    public ServerResponse lookContent(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.look(contentId, ContentTypeEnum.CONTENT.getType(), loginUserId, byUserId);
    }

    /**
     * 查看评论
     */
    @PostMapping("lookComment")
    public ServerResponse lookComment(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.look(contentId, ContentTypeEnum.COMMENT.getType(), loginUserId, byUserId);
    }

    /**
     * 查看回复
     */
    @PostMapping("lookReply")
    public ServerResponse lookReply(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.look(contentId, ContentTypeEnum.REPLY.getType(), loginUserId, byUserId);
    }

    /**
     * 查看内容
     */
    @PostMapping("cancelLookContent")
    public ServerResponse cancelLookContent(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.cancelLook(contentId, ContentTypeEnum.CONTENT.getType(), loginUserId, byUserId);
    }

    /**
     * 查看评论
     */
    @PostMapping("cancelLookComment")
    public ServerResponse cancelLookComment(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.cancelLook(contentId, ContentTypeEnum.COMMENT.getType(), loginUserId, byUserId);
    }

    /**
     * 查看回复
     */
    @PostMapping("cancelLookReply")
    public ServerResponse cancelLookReply(Long contentId, Long loginUserId, Long byUserId) {
        // id为0不做任何处理
        if (IDUtils.idIsNull(contentId, loginUserId, byUserId)) {
            return ServerResponse.success("ok");
        }
        return interactionService.cancelLook(contentId, ContentTypeEnum.REPLY.getType(), loginUserId, byUserId);
    }

    // -------------------------------- 查看互动区域 end --------------------------------


    /**
     * 关注
     *
     * @param userId   发起关注用户id
     * @param byUserId 被关注用户id
     */
    @PostMapping("attention")
    public ServerResponse attention(Long userId, Long byUserId) {
        return interactionService.attention(userId, byUserId);
    }

    /**
     * 取消关注
     *
     * @param userId   发起关注用户id
     * @param byUserId 被关注用户id
     */
    @PostMapping("cancelAttention")
    public ServerResponse cancelAttention(Long userId, Long byUserId) {
        return interactionService.cancelAttention(userId, byUserId);
    }

    /**
     * 评论
     */
    @PostMapping("comment")
    public ServerResponse comment(Long contentId, Long loginUserId, Long byUserId) {
        return interactionService.good(contentId, ContentTypeEnum.REPLY.getType(), loginUserId, byUserId);
    }

    /**
     * 回复
     */
    @PostMapping("reply")
    public ServerResponse reply(Long contentId, Long loginUserId, Long byUserId) {
        return interactionService.good(contentId, ContentTypeEnum.REPLY.getType(), loginUserId, byUserId);
    }
}
