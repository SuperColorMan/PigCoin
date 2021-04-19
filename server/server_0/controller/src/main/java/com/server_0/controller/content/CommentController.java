package com.server_0.controller.content;

import com.alibaba.fastjson.JSONArray;
import com.server_0.comm.web.ServerResponse;
import com.server_0.service.content.CommentService;
import com.server_0.service.content.ContentService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Objects;

/**
 * @ClassName CommentController
 * @Description 评论控制器
 * @Author SuperColorMan
 * @Date 2021/1/29 9:26 上午
 * @ModifyDate 2021/1/29 9:26 上午
 * @Version 1.0
 */
@CrossOrigin
@RestController
@RequestMapping("/comment/")
public class CommentController {
    @Autowired
    CommentService commentService;

    /**
     * 获取指定内容的评论列表
     */
    @PostMapping("getHotCommentListByContentId")
    public ServerResponse getHotCommentListByContentId(Long contentId, Long loginUserId) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        return commentService.getHotCommentListByContentId(contentId, loginUserId, null);
    }

    /**
     * 获取指定内容的评论列表
     *
     * @param filter 需要被过滤的评论条目id数组
     */
    @PostMapping("getCommentListByContentId")
    public ServerResponse getCommentListByContentId(Long contentId, Long loginUserId, Long page, Long pageSize, String filter) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        JSONArray filterIdArr = new JSONArray();
        if (StringUtils.isNotBlank(filter)) {
            filterIdArr = JSONArray.parseArray(filter);
        } else if (StringUtils.isBlank(filter)) {
            filterIdArr.add(-1);
        }
        //过滤的评论条目id
        List<String> filterIdList = filterIdArr.toJavaList(String.class);
        return commentService.getCommentListByContentId(contentId, loginUserId, page, pageSize, filterIdList);
    }

    /**
     * 获取指定用户发起评论的内容
     */
    @PostMapping("getUserCommentContentListByUserId")
    public ServerResponse getUserCommentContentListByUserId(Long userId, Long loginUserId, Long page, Long pageSize) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        userId = Objects.isNull(userId) ? 0 : userId;
        return commentService.getUserCommentContentListByUserId(userId, loginUserId, page, pageSize);
    }


    /**
     * 获取指定用户的被评论的列表
     *
     * @param userId      用户id
     * @param loginUserId 登录用户id
     * @param page        页号
     * @param pageSize    页大小
     */
    @PostMapping("selectCommentListByUserId")
    public ServerResponse selectCommentListByUserId(Long userId, Long loginUserId, Long page, Long pageSize) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        userId = Objects.isNull(userId) ? 0 : userId;
        return commentService.getUserCommentContentListByUserId(userId, loginUserId, page, pageSize);
    }

}
