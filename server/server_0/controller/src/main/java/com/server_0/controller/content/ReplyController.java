package com.server_0.controller.content;

import com.server_0.comm.web.ServerResponse;
import com.server_0.service.content.ContentService;
import com.server_0.service.content.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Objects;

/**
 * @ClassName ReplyController
 * @Description 回复控制器
 * @Author SuperColorMan
 * @Date 2021/1/29 9:28 上午
 * @ModifyDate 2021/1/29 9:28 上午
 * @Version 1.0
 */
@CrossOrigin
@RestController
@RequestMapping("/reply/")
public class ReplyController {

    @Autowired
    ReplyService replyService;

    /**
     * 获取指定评论的回复列表
     */
    @PostMapping("getReplyListByCommentId")
    public ServerResponse getReplyListByCommentId(Long contentId, Long loginUserId, Long commentId, Long page, Long pageSize) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        return replyService.getReplyListByCommentId(contentId, loginUserId, commentId, page, pageSize);
    }


    /**
     * 获取指定评论的神回复列表
     */
    @PostMapping("getHotReplyListByCommentId")
    public ServerResponse getHotReplyListByCommentId(Long commentId, Long loginUserId) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        return replyService.getHotReplyListByCommentId(commentId, loginUserId, null);
    }

    /**
     * 获取指定用户的被回复的列表
     *
     * @param userId      用户id
     * @param loginUserId 登录用户id
     * @param page        页号
     * @param pageSize    页大小
     */
    @PostMapping("selectReplyListByUserId")
    public ServerResponse selectReplyListByUserId(Long userId, Long loginUserId, Long page, Long pageSize) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        userId = Objects.isNull(userId) ? 0 : userId;
        return replyService.selectReplyListByUserId(userId, loginUserId, page, pageSize);
    }
}
