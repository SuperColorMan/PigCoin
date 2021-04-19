package com.server_0.service.interaction.impl;

import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.content.TCInteractionInfo;
import com.server_0.dao.entity.record.*;
import com.server_0.dao.entity.user.TUInteractionInfo;
import com.server_0.dao.mappers.content.TCInteractionInfoDao;
import com.server_0.dao.mappers.record.*;
import com.server_0.dao.mappers.user.TUInteractionInfoDao;
import com.server_0.dao.mappers.user.TUUserDao;
import com.server_0.queue.local.LocalMQconsumerThread;
import com.server_0.service.interaction.InteractionService;
import org.apache.tomcat.jni.Local;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


/**
 * @ClassName InteractionServiceImpl
 * @Description 互动服务层接口实现类
 * @Author SuperColorMan
 * @Date 2021/1/4 1:35 下午
 * @ModifyDate 2021/1/4 1:35 下午
 * @Version 1.0
 */
@Service
public class InteractionServiceImpl implements InteractionService {

    /**
     * 日志工具
     */
    private static Logger logger = LoggerFactory.getLogger(InteractionServiceImpl.class);

    @Autowired
    TCInteractionInfoDao tcInteractionInfoDao;
    @Autowired
    TUInteractionInfoDao tuInteractionInfoDao;
    @Autowired
    TRecGoodDao tRecGoodDao;
    @Autowired
    TRecDissDao tRecDissDao;
    @Autowired
    TRecLookDao tRecLookDao;
    @Autowired
    TRecCollDao tRecCollDao;
    @Autowired
    TRecAttentionDao tRecAttentionDao;
    @Autowired
    TUUserDao tuUserDao;

    /**
     * 点赞
     *
     * @param contentId   内容id
     * @param contentType 内容类型
     * @param loginUserId 登录用户id
     * @param byUserId    登录用户id
     */
    @Override
    public ServerResponse good(Long contentId, Integer contentType, Long loginUserId, Long byUserId) {
        try {
            //添加到队列中处理
            LocalMQconsumerThread.addQueueItem(() -> {
                logger.info("点赞");
                // 内容次数更新
                TCInteractionInfo tcInteractionInfo = new TCInteractionInfo();
                tcInteractionInfo.setGoodCount(1L);
                tcInteractionInfo.setContentId(contentId);
                tcInteractionInfo.setContentType(contentType);
                tcInteractionInfoDao.updateCountByPrimaryKeySelective(tcInteractionInfo);
                // 内容记录添加
                TRecGood tRecGood = new TRecGood();
                tRecGood.setResId(contentId);
                tRecGood.setUserId(loginUserId);
                tRecGood.setByUserId(byUserId);
                tRecGood.setType(contentType);
                tRecGoodDao.insertSelective(tRecGood);
            });
            return ServerResponse.success("ok");
        } catch (Exception e) {
            logger.error("点赞异常:", e.getMessage());
            return ServerResponse.error("点赞异常");
        }
    }

    /**
     * 取消点赞
     */
    @Override
    public ServerResponse cancelGood(Long contentId, Integer contentType, Long loginUserId, Long byUserId) {
        try {
            //添加到队列中处理
            LocalMQconsumerThread.addQueueItem(() -> {
                logger.info("取消点赞");
                // 内容次数更新
                TCInteractionInfo tcInteractionInfo = new TCInteractionInfo();
                tcInteractionInfo.setGoodCount(1L);
                tcInteractionInfo.setContentId(contentId);
                tcInteractionInfo.setContentType(contentType);
                tcInteractionInfoDao.updateSubCountByPrimaryKeySelective(tcInteractionInfo);
                // 内容记录删除
                TRecGood tRecGood = new TRecGood();
                tRecGood.setResId(contentId);
                tRecGood.setUserId(loginUserId);
                tRecGood.setByUserId(byUserId);
                tRecGood.setType(contentType);
                tRecGoodDao.deleteSelective(tRecGood);
            });
            return ServerResponse.success("ok");
        } catch (Exception e) {
            logger.error("点赞异常:", e.getMessage());
            return ServerResponse.error("点赞异常");
        }
    }

    /**
     * 点踩
     *
     * @param contentId   内容id
     * @param contentType 内容类型
     * @param loginUserId 用户id
     * @param byUserId    登录用户id
     */
    @Override
    public ServerResponse diss(Long contentId, Integer contentType, Long loginUserId, Long byUserId) {
        try {
            //添加到队列中处理
            LocalMQconsumerThread.addQueueItem(() -> {
                logger.info("点踩");
                // 内容次数更新
                TCInteractionInfo tcInteractionInfo = new TCInteractionInfo();
                tcInteractionInfo.setDissCount(1L);
                tcInteractionInfo.setContentId(contentId);
                tcInteractionInfo.setContentType(contentType);
                tcInteractionInfoDao.updateCountByPrimaryKeySelective(tcInteractionInfo);
                // 内容记录添加
                TRecDiss tRecDiss = new TRecDiss();
                tRecDiss.setResId(contentId);
                tRecDiss.setUserId(loginUserId);
                tRecDiss.setByUserId(byUserId);
                tRecDiss.setType(contentType);
                tRecDissDao.insertSelective(tRecDiss);
            });
            return ServerResponse.success("ok");
        } catch (Exception e) {
            logger.error("点踩异常:", e.getMessage());
            return ServerResponse.error("点踩异常");
        }
    }

    /**
     * 取消点踩
     */
    @Override
    public ServerResponse cancelDiss(Long contentId, Integer contentType, Long loginUserId, Long byUserId) {
        try {
            //添加到队列中处理
            LocalMQconsumerThread.addQueueItem(() -> {
                logger.info("取消点踩");
                // 内容次数更新
                TCInteractionInfo tcInteractionInfo = new TCInteractionInfo();
                tcInteractionInfo.setDissCount(1L);
                tcInteractionInfo.setContentId(contentId);
                tcInteractionInfo.setContentType(contentType);
                tcInteractionInfoDao.updateSubCountByPrimaryKeySelective(tcInteractionInfo);
                // 内容记录添加
                TRecDiss tRecDiss = new TRecDiss();
                tRecDiss.setResId(contentId);
                tRecDiss.setUserId(loginUserId);
                tRecDiss.setByUserId(byUserId);
                tRecDiss.setType(contentType);
                tRecDissDao.deleteSelective(tRecDiss);
            });
            return ServerResponse.success("ok");
        } catch (Exception e) {
            logger.error("点踩异常:", e.getMessage());
            return ServerResponse.error("点踩异常");
        }
    }

    /**
     * 收藏
     *
     * @param contentId   内容id
     * @param contentType 内容类型
     * @param loginUserId 用户id
     * @param byUserId    登录用户id
     */
    @Override
    public ServerResponse collect(Long contentId, Integer contentType, Long loginUserId, Long byUserId) {
        try {
            //添加到队列中处理
            LocalMQconsumerThread.addQueueItem(() -> {
                logger.info("收藏");
                // 内容次数更新
                TCInteractionInfo tcInteractionInfo = new TCInteractionInfo();
                tcInteractionInfo.setCollCount(1L);
                tcInteractionInfo.setContentId(contentId);
                tcInteractionInfo.setContentType(contentType);
                tcInteractionInfoDao.updateCountByPrimaryKeySelective(tcInteractionInfo);
                // 内容记录添加
                TRecColl tRecColl = new TRecColl();
                tRecColl.setResId(contentId);
                tRecColl.setUserId(loginUserId);
                tRecColl.setByUserId(byUserId);
                tRecColl.setType(contentType);
                tRecCollDao.insertSelective(tRecColl);
            });
            return ServerResponse.success("ok");
        } catch (Exception e) {
            logger.error("收藏异常:", e.getMessage());
            return ServerResponse.error("收藏异常");
        }
    }

    /**
     * 取消收藏
     */
    @Override
    public ServerResponse cancelCollect(Long contentId, Integer contentType, Long loginUserId, Long byUserId) {
        try {
            //添加到队列中处理
            LocalMQconsumerThread.addQueueItem(() -> {
                logger.info("收藏");
                // 内容次数更新
                TCInteractionInfo tcInteractionInfo = new TCInteractionInfo();
                tcInteractionInfo.setCollCount(1L);
                tcInteractionInfo.setContentId(contentId);
                tcInteractionInfo.setContentType(contentType);
                tcInteractionInfoDao.updateSubCountByPrimaryKeySelective(tcInteractionInfo);
                // 内容记录添加
                TRecColl tRecColl = new TRecColl();
                tRecColl.setResId(contentId);
                tRecColl.setUserId(loginUserId);
                tRecColl.setByUserId(byUserId);
                tRecColl.setType(contentType);
                tRecCollDao.deleteSelective(tRecColl);
            });
            return ServerResponse.success("ok");
        } catch (Exception e) {
            logger.error("收藏异常:", e.getMessage());
            return ServerResponse.error("收藏异常");
        }
    }

    /**
     * 查看
     *
     * @param contentId   内容id
     * @param contentType 内容类型
     * @param loginUserId 用户id
     * @param byUserId    登录用户id
     */
    @Override
    public ServerResponse look(Long contentId, Integer contentType, Long loginUserId, Long byUserId) {
        try {
            //添加到队列中处理
            LocalMQconsumerThread.addQueueItem(() -> {
                // 内容次数更新
                TCInteractionInfo tcInteractionInfo = new TCInteractionInfo();
                tcInteractionInfo.setLookCount(1L);
                tcInteractionInfo.setContentId(contentId);
                tcInteractionInfo.setContentType(contentType);
                tcInteractionInfoDao.updateCountByPrimaryKeySelective(tcInteractionInfo);
                // 内容记录添加
                TRecLook tRecLook = new TRecLook();
                tRecLook.setSrcId(contentId);
                tRecLook.setUserId(loginUserId);
                tRecLook.setByUserId(byUserId);
                tRecLook.setSrcType(contentType.toString());
                tRecLookDao.insertSelective(tRecLook);
            });
            return ServerResponse.success("ok");
        } catch (Exception e) {
            logger.error("查看异常:", e.getMessage());
            return ServerResponse.error("查看异常");
        }
    }

    /**
     * 取消查看
     */
    @Override
    public ServerResponse cancelLook(Long contentId, Integer contentType, Long loginUserId, Long byUserId) {
        try {
            //添加到队列中处理
            LocalMQconsumerThread.addQueueItem(() -> {
                // 内容次数更新
                TCInteractionInfo tcInteractionInfo = new TCInteractionInfo();
                tcInteractionInfo.setLookCount(1L);
                tcInteractionInfo.setContentId(contentId);
                tcInteractionInfo.setContentType(contentType);
                tcInteractionInfoDao.updateSubCountByPrimaryKeySelective(tcInteractionInfo);
                // 内容记录添加
                TRecLook tRecLook = new TRecLook();
                tRecLook.setSrcId(contentId);
                tRecLook.setUserId(loginUserId);
                tRecLook.setByUserId(byUserId);
                tRecLook.setSrcType(contentType.toString());
                tRecLookDao.deleteSelective(tRecLook);
            });
            return ServerResponse.success("ok");
        } catch (Exception e) {
            logger.error("查看异常:", e.getMessage());
            return ServerResponse.error("查看异常");
        }
    }

    /**
     * 关注
     *
     * @param userId   发起关注用户id
     * @param byUserId 被关注用户id
     */
    @Override
    public ServerResponse attention(Long userId, Long byUserId) {
        try {
            LocalMQconsumerThread.addQueueItem(() -> {
                /// 添加关注记录
                TRecAttention tRecAttention = new TRecAttention();
                tRecAttention.setUserId(userId);
                tRecAttention.setByUserId(byUserId);
                tRecAttentionDao.insertSelective(tRecAttention);
                // 自增数据
                TUInteractionInfo userInfo = new TUInteractionInfo();
                userInfo.setUserId(userId);
                userInfo.setAttentionCount(1L);
                TUInteractionInfo byUserInfo = new TUInteractionInfo();
                byUserInfo.setUserId(userId);
                byUserInfo.setAttentionCount(1L);
                tuInteractionInfoDao.updateCountByPrimaryKeySelective(userInfo);
                tuInteractionInfoDao.updateCountByPrimaryKeySelective(byUserInfo);
            });
            return ServerResponse.success("ok");
        } catch (Exception e) {
            logger.error("查看异常:", e.getMessage());
            return ServerResponse.error("查看异常");
        }
    }

    /**
     * 取消关注
     *
     * @param userId   发起关注用户id
     * @param byUserId 被关注用户id
     */
    @Override
    public ServerResponse cancelAttention(Long userId, Long byUserId) {
        try {
            LocalMQconsumerThread.addQueueItem(() -> {
                /// 删除关注记录
                TRecAttention tRecAttention = new TRecAttention();
                tRecAttention.setUserId(userId);
                tRecAttention.setByUserId(byUserId);
                tRecAttentionDao.deleteSelective(tRecAttention);
                // 自增数据
                TUInteractionInfo userInfo = new TUInteractionInfo();
                userInfo.setUserId(userId);
                userInfo.setAttentionCount(1L);
                TUInteractionInfo byUserInfo = new TUInteractionInfo();
                byUserInfo.setUserId(userId);
                byUserInfo.setAttentionCount(1L);
                tuInteractionInfoDao.updateSubCountByPrimaryKeySelective(userInfo);
                tuInteractionInfoDao.updateSubCountByPrimaryKeySelective(byUserInfo);
            });
            return ServerResponse.success("ok");
        } catch (Exception e) {
            logger.error("查看异常:", e.getMessage());
            return ServerResponse.error("查看异常");
        }
    }


}
