package com.server_0.service.content.impl;

import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.content.TCReply;
import com.server_0.dao.mappers.content.TCReplyDao;
import com.server_0.service.content.ReplyService;
import com.server_0.utils.time.TimeUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @ClassName ReplyServiceImpl
 * @Description 回复服务层接口实现类
 * @Author SuperColorMan
 * @Date 2021/1/29 9:30 上午
 * @ModifyDate 2021/1/29 9:30 上午
 * @Version 1.0
 */
@Service
public class ReplyServiceImpl implements ReplyService {
    /**
     * 日志工具
     */
    private static Logger logger = LoggerFactory.getLogger(ReplyServiceImpl.class);

    @Autowired
    TCReplyDao tcReplyDao;

    /**
     * 获取指定评论的神回复列表
     */
    @Override
    public ServerResponse getHotReplyListByCommentId(Long commentId, Long loginUserId, List<Long> commentIdList) {
        List<TCReply> hotReplyList = tcReplyDao.getHotReplyByCommentId(commentId, loginUserId, commentIdList);
        return ServerResponse.success("ok", hotReplyList);
    }

    /**
     * 获取指定用户在指定内容中的指定评论中的回复
     */
    @Override
    public ServerResponse getHotReplyListByContentAndCommentId(List<Long> userIdList, List<Long> contentIdList, List<Long> commentIdList, Long loginUserId) {
        List<TCReply> hotReplyList = tcReplyDao.getHotReplyListByContentAndCommentId(userIdList, contentIdList, commentIdList, loginUserId);
        return ServerResponse.success("ok", hotReplyList);
    }


    /**
     * 获取指定评论的回复列表
     */
    @Override
    public ServerResponse getReplyListByCommentId(Long contentId, Long loginUserId, Long commentId, Long page, Long pageSize) {
        //回复列表
        List<TCReply> tcReplyList = tcReplyDao.selectReplyListByCommentId(
                contentId, commentId,
                page, pageSize,
                loginUserId);
        tcReplyList.stream().forEach(e -> {
            e.setDiffTime(TimeUtil.getTimeDiff(e.getCreateTime()));
        });
        return ServerResponse.success("ok", tcReplyList);
    }

    /**
     * 获取指定用户的被回复的列表
     *
     * @param userId      用户id
     * @param loginUserId 登录用户id
     * @param page        页号
     * @param pageSize    页大小
     */
    @Override
    public ServerResponse selectReplyListByUserId(Long userId, Long loginUserId, Long page, Long pageSize) {
        List<TCReply> tcReplyList = tcReplyDao.selectReplyListByUserId(userId, page, pageSize, loginUserId);
        return ServerResponse.success("ok", tcReplyList);
    }
}
