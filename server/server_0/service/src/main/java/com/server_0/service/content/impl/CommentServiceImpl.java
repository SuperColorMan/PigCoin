package com.server_0.service.content.impl;

import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.content.TCComment;
import com.server_0.dao.entity.content.TCContent;
import com.server_0.dao.entity.content.TCReply;
import com.server_0.dao.mappers.content.TCCommentDao;
import com.server_0.dao.mappers.content.TCContentDao;
import com.server_0.dao.mappers.content.TCReplyDao;
import com.server_0.queue.local.LocalMQconsumerHandle;
import com.server_0.service.content.CommentService;
import com.server_0.service.content.ReplyService;
import com.server_0.utils.thread.ThreadPoolUtils;
import com.server_0.utils.time.TimeUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.CountDownLatch;
import java.util.stream.Collectors;

/**
 * @ClassName CommentService
 * @Description 评论服务层接口实现类
 * @Author SuperColorMan
 * @Date 2021/1/29 9:30 上午
 * @ModifyDate 2021/1/29 9:30 上午
 * @Version 1.0
 */
@Service
public class CommentServiceImpl implements CommentService {

    /**
     * 日志工具
     */
    private static Logger logger = LoggerFactory.getLogger(CommentServiceImpl.class);

    @Autowired
    TCContentDao tcContentDao;
    @Autowired
    TCCommentDao tcCommentDao;
    @Autowired
    ReplyService replyService;
    @Autowired
    TCReplyDao tcReplyDao;

    /**
     * 获取指定用户发起评论的内容
     */
    @Override
    public ServerResponse getUserCommentContentListByUserId(Long userId, Long loginUserId, Long page, Long pageSize) {
        List<TCContent> tcContentList = tcContentDao.getUserCommentContentListByUserId(
                userId,
                page,
                pageSize,
                loginUserId);
        CountDownLatch cD = new CountDownLatch(2);
        ThreadPoolUtils.exe(() -> {
            tcContentList.stream().forEach(e -> {
                e.setDiffTime(TimeUtil.getTimeDiff(e.getCreateTime()));
            });
            cD.countDown();
        });
        // 处理神评论
        ThreadPoolUtils.exe(() -> {
            // 内容id列表
            List<Long> contentIdList = tcContentList.stream().map(e -> e.getId()).collect(Collectors.toList());
            contentIdList.add(-1L);
            // 查询神评论
            List<TCComment> tcCommentList = (List<TCComment>) getHotCommentListByContentId(null, loginUserId, contentIdList).getData();
            // 提取神评论
            tcContentList.stream().forEach(e -> {
                List<TCComment> hotCommentList = tcCommentList.stream().filter(ele -> e.getId().equals(ele.getContentId())).collect(Collectors.toList());
                e.setHotCommentList(hotCommentList);
            });
            cD.countDown();
        });
        try {
            cD.await();
        } catch (Exception e) {
            logger.error("闭锁释放异常:", e);
            e.printStackTrace();
            return ServerResponse.success("error", e);
        }
        return ServerResponse.success("ok", tcContentList);
    }

    /**
     * 获取指定内容的评论列表
     */
    @Override
    public ServerResponse getCommentListByContentId(Long contentId, Long loginUserId, Long page, Long pageSize, List<String> filterIdList) {
        //评论列表
        List<TCComment> tcCommentList = tcCommentDao.selectCommentListByContentId(contentId, page, pageSize, loginUserId, filterIdList);
        CountDownLatch cD = new CountDownLatch(2);
        // 时间文本处理
        ThreadPoolUtils.exe(() -> {
            tcCommentList.stream().forEach(e -> {
                e.setDiffTime(TimeUtil.getTimeDiff(e.getCreateTime()));
            });
            cD.countDown();
        });
        // 处理神回复
//        ThreadPoolUtils.exe(() -> {
//            // 内容id列表
//            List<Long> commentIdList = tcCommentList.stream().map(e -> e.getId()).collect(Collectors.toList());
//            commentIdList.add(-1L);
//            // 获取神回复
//            List<TCReply> tcReplyList = tcReplyDao.getHotReplyByCommentId(null, loginUserId, commentIdList);
//            tcCommentList.stream().forEach(e -> {
//                List<TCReply> hotReplyList = tcReplyList.stream().filter(ele -> e.getId().equals(ele.getCommentId())).collect(Collectors.toList());
//                e.setHotReplyList(hotReplyList);
//            });
//            cD.countDown();
//        });
        // 处理作者回复
        ThreadPoolUtils.exe(() -> {
            // 评论所属内容发送者id列表
            List<Long> cUserIdList = tcCommentList.stream().map(e -> e.getTcContent().getUserId()).collect(Collectors.toList());
            // 评论所属内容id列表
            List<Long> cIdList = tcCommentList.stream().map(e -> e.getTcContent().getId()).collect(Collectors.toList());
            // 评论内容id列表
            List<Long> commentIdList = tcCommentList.stream().map(e -> e.getId()).collect(Collectors.toList());
            // 作者回复列表
            List<TCReply> tcReplyList = (List<TCReply>) replyService.getHotReplyListByContentAndCommentId(cUserIdList, cIdList, commentIdList, loginUserId).getData();
            tcCommentList.stream().forEach(e -> {
                e.setAuthorReplyList(tcReplyList);
            });
            cD.countDown();
        });
        try {
            cD.await();
        } catch (Exception e) {
            logger.error("闭锁释放异常:", e);
            e.printStackTrace();
            return ServerResponse.success("error", e);
        }
        return ServerResponse.success("ok", tcCommentList);
    }


    /**
     * 获取指定内容的神评论列表
     */
    @Override
    public ServerResponse getHotCommentListByContentId(Long contentId, Long loginUserId, List<Long> contentIdList) {
        List<TCComment> tcCommentList = tcCommentDao.getHotCommentListByContentId(
                contentId,
                loginUserId,
                contentIdList);
        CountDownLatch cD = new CountDownLatch(2);
        // 时间文本处理
        ThreadPoolUtils.exe(() -> {
            tcCommentList.stream().forEach(e -> {
                e.setDiffTime(TimeUtil.getTimeDiff(e.getCreateTime()));
            });
            cD.countDown();
        });
        // 处理神回复
//        ThreadPoolUtils.exe(() -> {
//            // 内容id列表
//            List<Long> commentIdList = tcCommentList.stream().map(e -> e.getId()).collect(Collectors.toList());
//            commentIdList.add(-1L);
//            // 获取神回复
//            List<TCReply> tcReplyList = tcReplyDao.getHotReplyByCommentId(null, loginUserId, commentIdList);
//            tcCommentList.stream().forEach(e -> {
//                List<TCReply> hotReplyList = tcReplyList.stream().filter(ele -> e.getId().equals(ele.getCommentId())).collect(Collectors.toList());
//                e.setHotReplyList(hotReplyList);
//            });
//            cD.countDown();
//        });
        // 处理作者回复
        ThreadPoolUtils.exe(() -> {
            // 评论所属内容发送者id列表
            List<Long> cUserIdList = tcCommentList.stream().map(e -> e.getTcContent().getUserId()).collect(Collectors.toList());
            // 评论所属内容id列表
            List<Long> cIdList = tcCommentList.stream().map(e -> e.getTcContent().getId()).collect(Collectors.toList());
            // 评论内容id列表
            List<Long> commentIdList = tcCommentList.stream().map(e -> e.getId()).collect(Collectors.toList());
            // 作者回复列表
            List<TCReply> tcReplyList = (List<TCReply>) replyService.getHotReplyListByContentAndCommentId(cUserIdList, cIdList, commentIdList, loginUserId).getData();
            tcCommentList.stream().forEach(e -> {
                e.setAuthorReplyList(tcReplyList);
            });
            cD.countDown();
        });
        try {
            cD.await();
        } catch (Exception e) {
            logger.error("闭锁释放异常:", e);
            e.printStackTrace();
            return ServerResponse.success("error", e);
        }
        return ServerResponse.success("ok", tcCommentList);
    }

    /**
     * 获取指定用户的被评论的列表
     *
     * @param userId      用户id
     * @param loginUserId 登录用户id
     * @param page        页号
     * @param pageSize    页大小
     */
    @Override
    public ServerResponse selectCommentListByUserId(Long userId, Long loginUserId, Long page, Long pageSize) {
        List<TCComment> tcCommentList = tcCommentDao.selectCommentListByUserId(userId, loginUserId, page, pageSize);
        return ServerResponse.success("ok", tcCommentList);
    }

}
