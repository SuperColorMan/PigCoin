package com.server_0.service.content.impl;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.server_0.comm.config.FileConfigProperties;
import com.server_0.comm.enums.*;
import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.content.TCComment;
import com.server_0.dao.entity.content.TCContent;
import com.server_0.dao.entity.content.TCInteractionInfo;
import com.server_0.dao.entity.content.TCReply;
import com.server_0.dao.entity.gambit.TGGambit;
import com.server_0.dao.entity.record.TRecAt;
import com.server_0.dao.entity.record.TRecColl;
import com.server_0.dao.entity.record.TRecJoinGambit;
import com.server_0.dao.entity.user.TUUser;
import com.server_0.dao.mappers.content.TCCommentDao;
import com.server_0.dao.mappers.content.TCContentDao;
import com.server_0.dao.mappers.content.TCInteractionInfoDao;
import com.server_0.dao.mappers.content.TCReplyDao;
import com.server_0.dao.mappers.gambit.TGGambitDao;
import com.server_0.dao.mappers.record.TRecAtDao;
import com.server_0.dao.mappers.record.TRecJoinGambitDao;
import com.server_0.dao.mappers.user.TUInteractionInfoDao;
import com.server_0.dao.mappers.user.TUUserDao;
import com.server_0.queue.local.LocalMQconsumerHandle;
import com.server_0.queue.local.LocalMQconsumerThread;
import com.server_0.service.comm.CommService;
import com.server_0.service.content.CommentService;
import com.server_0.service.content.ContentService;
import com.server_0.utils.thread.ThreadPoolUtils;
import com.server_0.utils.time.TimeUtil;
import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.*;
import java.util.concurrent.CountDownLatch;
import java.util.stream.Collectors;

/**
 * @ClassName ContentServiceImpl
 * @Description 内容服务层接口实现类
 * @Author SuperColorMan
 * @Date 2021/1/4 10:01 上午
 * @ModifyDate 2021/1/4 10:01 上午
 * @Version 1.0
 */
@Service
public class ContentServiceImpl implements ContentService {

    /**
     * 日志工具
     */
    private static Logger logger = LoggerFactory.getLogger(ContentServiceImpl.class);

    @Autowired
    TCContentDao tcContentDao;
    @Autowired
    TRecAtDao tRecAtDao;
    @Autowired
    TCCommentDao tcCommentDao;
    @Autowired
    TCReplyDao tcReplyDao;
    @Autowired
    FileConfigProperties fileConfigProperties;
    @Autowired
    TGGambitDao tgGambitDao;
    @Autowired
    TUUserDao tuUserDao;
    @Autowired
    TUInteractionInfoDao tuInteractionInfoDao;
    @Autowired
    TCInteractionInfoDao tcInteractionInfoDao;
    @Autowired
    TRecJoinGambitDao tRecJoinGambitDao;
    @Autowired
    CommService commService;
    @Autowired
    CommentService commentService;

    /**
     * 获取指定id的内容
     *
     * @param id 内容id
     */
    @Override
    public ServerResponse getContentById(Long id, Long loginUserId) {
        if (Objects.isNull(id)) {
            return ServerResponse.error("内容id不能为空");
        }
        TCContent tcContent = tcContentDao.selectByPrimaryKey(id, loginUserId);
        tcContent.setDiffTime(TimeUtil.getTimeDiff(tcContent.getCreateTime()));
        if (Objects.isNull(tcContent)) {
            return ServerResponse.error("内容不存在");
        }
        return ServerResponse.success("ok", tcContent);
    }

    /**
     * 获取内容根据内容类型
     */
    @Override
    public ServerResponse getContentByType(String contentClassify, Long loginUserId, Long page, Long pageSize) {
        if (Integer.parseInt(contentClassify) == IndexRecommendPageTypeEnum.HOTCOMMENT.getType()) {
            // 获取推荐神评
            List<TCContent> tcContentList = tcContentDao.getRecommendHotCommentContentList(
                    page,
                    pageSize,
                    loginUserId);
            return ServerResponse.success("ok", tcContentList);
        } else if (Integer.parseInt(contentClassify) == IndexRecommendPageTypeEnum.NEW.getType()) {
            //最新
            List<TCContent> tcContentList = tcContentDao.getNewContent(
                    page,
                    pageSize,
                    loginUserId);
            CountDownLatch cD = new CountDownLatch(2);
            /// 时间差集处理
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
                List<TCComment> tcCommentList = (List<TCComment>) commentService.getHotCommentListByContentId(null, loginUserId, contentIdList).getData();
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
            }
            return ServerResponse.success("ok", tcContentList);
        } else if (Integer.parseInt(contentClassify) == IndexRecommendPageTypeEnum.HOT.getType()) {
            // 热门
            List<TCContent> tcContentList = tcContentDao.getHotContent(
                    page,
                    pageSize,
                    loginUserId);
            CountDownLatch cD = new CountDownLatch(2);
            /// 时间差集处理
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
                List<TCComment> tcCommentList = (List<TCComment>) commentService.getHotCommentListByContentId(null, loginUserId, contentIdList).getData();
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
            }
            return ServerResponse.success("ok", tcContentList);
        } else if (Integer.parseInt(contentClassify) == IndexRecommendPageTypeEnum.TEXT.getType()) {
            // 纯文字内容
            List<TCContent> tcContentList = tcContentDao.getTextContent(
                    page,
                    pageSize,
                    loginUserId);
            CountDownLatch cD = new CountDownLatch(2);
            /// 时间差集处理
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
                List<TCComment> tcCommentList = (List<TCComment>) commentService.getHotCommentListByContentId(null, loginUserId, contentIdList).getData();
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
            }
            return ServerResponse.success("ok", tcContentList);
        } else if (Integer.parseInt(contentClassify) == IndexRecommendPageTypeEnum.IMGANDTEXT.getType()) {
            // 图文内容
            List<TCContent> tcContentList = tcContentDao.getImgAndTextContent(
                    page,
                    pageSize,
                    loginUserId);
            CountDownLatch cD = new CountDownLatch(2);
            /// 时间差集处理
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
                List<TCComment> tcCommentList = (List<TCComment>) commentService.getHotCommentListByContentId(null, loginUserId, contentIdList).getData();
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
            }
            return ServerResponse.success("ok", tcContentList);
        } else {
            return ServerResponse.success("ok", Lists.newArrayList());
        }
    }

    /**
     * 获取指定用户的内容
     *
     * @param userId 用户id
     */
    @Override
    public ServerResponse getContentByUserId(Long userId, Long loginUserId, Long page, Long pageSize) {
        List<TCContent> tcContentList = tcContentDao.getContentListByUserId(userId, page, pageSize,
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
            List<TCComment> tcCommentList = (List<TCComment>) commentService.getHotCommentListByContentId(null, loginUserId, contentIdList).getData();
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
        }
        return ServerResponse.success("ok", tcContentList);
    }

    /**
     * 获取用户全部的内容
     *
     * @param userId 用户id
     */
    @Override
    public ServerResponse getUserContentByClassify(Long userId, String contentClassify, Long loginUserId, Long page, Long pageSize) {

        //用户全部内容
        List<TCContent> tcContentList = new ArrayList<>();
        if (String.valueOf(UserContentTypeEnum.ALL.getType()).equals(contentClassify)) {
            tcContentList = tcContentDao.getUserAllContentList(
                    userId,
                    page,
                    pageSize,
                    loginUserId);
        } else if (String.valueOf(UserContentTypeEnum.CONTENT.getType()).equals(contentClassify)) {
            tcContentList = tcContentDao.getContentListByUserId(
                    userId,
                    page,
                    pageSize,
                    loginUserId);
        } else if (String.valueOf(UserContentTypeEnum.GOOD.getType()).equals(contentClassify)) {
            tcContentList = tcContentDao.getGoodContentListByUserId(
                    userId,
                    page,
                    pageSize,
                    loginUserId);
        } else if (String.valueOf(UserContentTypeEnum.COLL.getType()).equals(contentClassify)) {
            tcContentList = tcContentDao.getCollectContentListByUserId(
                    userId,
                    page,
                    pageSize,
                    loginUserId);
        }

        CountDownLatch cD = new CountDownLatch(2);
        // 处理差集时间
        List<TCContent> finalTcContentList = tcContentList;
        ThreadPoolUtils.exe(() -> {
            finalTcContentList.stream().forEach(e -> {
                e.setDiffTime(TimeUtil.getTimeDiff(e.getCreateTime()));
            });
            cD.countDown();
        });
        // 处理神评论
        ThreadPoolUtils.exe(() -> {
            // 内容id列表
            List<Long> contentIdList = finalTcContentList.stream().map(e -> e.getId()).collect(Collectors.toList());
            contentIdList.add(-1L);
            // 查询神评论
            List<TCComment> tcCommentList = (List<TCComment>) commentService.getHotCommentListByContentId(null, loginUserId, contentIdList).getData();
            // 提取神评论
            finalTcContentList.stream().forEach(e -> {
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
        }
        return ServerResponse.success("ok", tcContentList);
    }

    /**
     * 获取指定用户发起点赞的内容列表
     */
    @Override
    public ServerResponse getGoodContentListByUserId(Long userId, Long loginUserId, Long page, Long pageSize) {
        List<TCContent> tcContentList = tcContentDao.getGoodContentListByUserId(
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
            List<TCComment> tcCommentList = (List<TCComment>) commentService.getHotCommentListByContentId(null, loginUserId, contentIdList).getData();
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
     * 获取指定用户被别人点赞的内容列表
     */
    @Override
    public ServerResponse getByGoodContentListByUserId(Long userId, Long loginUserId, Long page, Long pageSize) {
        List<TCContent> tcContentList = tcContentDao.getByGoodContentListByUserId(
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
            List<TCComment> tcCommentList = (List<TCComment>) commentService.getHotCommentListByContentId(null, loginUserId, contentIdList).getData();
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
     * 获取指定用户被收藏的内容
     */
    @Override
    public ServerResponse getByCollectContentListByUserId(Long userId, Long loginUserId, Long page, Long pageSize) {
        List<TCContent> tRecCollList = tcContentDao.getByCollectContentListByUserId(userId, loginUserId, page, pageSize);
        return ServerResponse.success("ok", tRecCollList);
    }

    /**
     * 获取指定用户被评论与@的内容
     */
    @Override
    public ServerResponse getByCommentAndAtContentListByUserId(Long userId,
                                                               Long loginUserId,
                                                               Long page,
                                                               Long pageSize) {
        List<TCContent> tcContentList = tcContentDao.getByCommentAndAtContentListByUserId(userId, page, pageSize, loginUserId);
        return ServerResponse.success("ok", tcContentList);
    }

    /**
     * 获取指定用户被点赞与收藏的内容
     */
    @Override
    public ServerResponse getByCollectAndGoodContentListByUserId(Long userId,
                                                                 Long loginUserId,
                                                                 Long page,
                                                                 Long pageSize) {
        List<TCContent> tcContentList = tcContentDao.getByCollectAndGoodContentListByUserId(userId, page, pageSize, loginUserId);
        return ServerResponse.success("ok", tcContentList);
    }

    /**
     * 获取搜索页结果集内容分类
     */
    @Override
    public ServerResponse getSearchResultType() {
        List<Map> list = Lists.newArrayList();
        SearchResultTypeEnum[] searchResultTypeEnumArr = SearchResultTypeEnum.values();
        for (SearchResultTypeEnum e : searchResultTypeEnumArr) {
            Map m = Maps.newHashMap();
            m.put("type", e.getType());
            m.put("des", e.getDes());
            list.add(m);
        }
        return ServerResponse.success("ok", list);
    }

    /**
     * 搜索内容
     */
    @Override
    public ServerResponse searchContent(String keyWord,
                                        Long loginUserId,
                                        Long page,
                                        Long pageSize,
                                        int searchType) {
        Map<String, Object> resMap = Maps.newHashMap();
        if (SearchResultTypeEnum.ALL.getType() == searchType) {
            // 搜索内容
            List<TCContent> contentList = tcContentDao.searchContent(
                    keyWord,
                    page,
                    pageSize,
                    loginUserId);
            contentList.stream().forEach(e -> {
                e.setDiffTime(TimeUtil.getTimeDiff(e.getCreateTime()));
            });
            // 搜索用户
            List<TUUser> userList = tuUserDao.searchUser(keyWord, null, null);
            // 搜索话题
            List<TGGambit> gambitList = tgGambitDao.searchGambit(keyWord, null, null);
            resMap.put("contentList", contentList);
            resMap.put("userList", userList);
            resMap.put("gambitList", gambitList);
        } else if (SearchResultTypeEnum.HOT.getType() == searchType) {
            // 搜索最热内容
            List<TCContent> contentList = tcContentDao.searchHotContent(
                    keyWord,
                    page,
                    pageSize,
                    loginUserId);
            contentList.stream().forEach(e -> {
                e.setDiffTime(TimeUtil.getTimeDiff(e.getCreateTime()));
            });
            resMap.put("contentList", contentList);
        } else if (SearchResultTypeEnum.NEWS.getType() == searchType) {
            // 搜索最新内容
            List<TCContent> contentList = tcContentDao.searchNewsContent(
                    keyWord,
                    page,
                    pageSize,
                    loginUserId);
            contentList.stream().forEach(e -> {
                e.setDiffTime(TimeUtil.getTimeDiff(e.getCreateTime()));
            });
            resMap.put("contentList", contentList);
        } else if (SearchResultTypeEnum.IMG.getType() == searchType) {
            // 搜索图片内容
            List<TCContent> contentList = tcContentDao.searchImageContent(
                    keyWord,
                    page,
                    pageSize,
                    loginUserId);
            contentList.stream().forEach(e -> {
                e.setDiffTime(TimeUtil.getTimeDiff(e.getCreateTime()));
            });
            resMap.put("contentList", contentList);
        } else if (SearchResultTypeEnum.TEXT.getType() == searchType) {
            // 搜索文字内容
            List<TCContent> contentList = tcContentDao.searchTextContent(
                    keyWord,
                    page,
                    pageSize,
                    loginUserId);
            CountDownLatch cD = new CountDownLatch(2);
            ThreadPoolUtils.exe(() -> {
                contentList.stream().forEach(e -> {
                    e.setDiffTime(TimeUtil.getTimeDiff(e.getCreateTime()));
                });
                cD.countDown();
            });
            // 处理神评论
            ThreadPoolUtils.exe(() -> {
                // 内容id列表
                List<Long> contentIdList = contentList.stream().map(e -> e.getId()).collect(Collectors.toList());
                contentIdList.add(-1L);
                // 查询神评论
                List<TCComment> tcCommentList = (List<TCComment>) commentService.getHotCommentListByContentId(null, loginUserId, contentIdList).getData();
                // 提取神评论
                contentList.stream().forEach(e -> {
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
            }
            resMap.put("contentList", contentList);
        } else if (SearchResultTypeEnum.USER.getType() == searchType) {
            // 搜索用户
            List<TUUser> userList = tuUserDao.searchUser(keyWord, 0L, 10L);
            resMap.put("userList", userList);
        } else if (SearchResultTypeEnum.GAMBIT.getType() == searchType) {
            // 搜索话题
            List<TGGambit> gambitList = tgGambitDao.searchGambit(keyWord, 0L, 10L);
            resMap.put("gambitList", gambitList);
        }
        return ServerResponse.success("ok", resMap);
    }

    /**
     * 查询指定话题下的内容
     *
     * @param gambitId    话题id
     * @param loginUserId 登录用户id
     * @param page        页号
     * @param pageSize    页大小
     * @param type        话题页内容类型,见枚举
     */
    @Override
    public ServerResponse getContentListByGambitId(
            Long gambitId,
            Long loginUserId,
            Long page,
            Long pageSize,
            int type) {
        List<TCContent> tcContentList = Lists.newArrayList();
        if (GambitContentTypeEnum.HOTCOMMENT.getType() == type) {
            tcContentList = tcContentDao.getHotCommentContentListByGambitId(
                    gambitId,
                    page,
                    pageSize,
                    loginUserId);
        } else {
            tcContentList = tcContentDao.getContentListByGambitIdAndType(
                    gambitId,
                    page,
                    pageSize,
                    loginUserId,
                    type);
        }
        CountDownLatch cD = new CountDownLatch(2);
        List<TCContent> finalTcContentList = tcContentList;
        ThreadPoolUtils.exe(() -> {
            finalTcContentList.stream().forEach(e -> {
                e.setDiffTime(TimeUtil.getTimeDiff(e.getCreateTime()));
            });
            cD.countDown();
        });
        // 处理神评论
        ThreadPoolUtils.exe(() -> {
            // 内容id列表
            List<Long> contentIdList = finalTcContentList.stream().map(e -> e.getId()).collect(Collectors.toList());
            contentIdList.add(-1L);
            // 查询神评论
            List<TCComment> tcCommentList = (List<TCComment>) commentService.getHotCommentListByContentId(null, loginUserId, contentIdList).getData();
            // 提取神评论
            finalTcContentList.stream().forEach(e -> {
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
        }
        return ServerResponse.success("ok", tcContentList);
    }

    /**
     * 获取指定用户的查看内容历史
     */
    @Override
    public ServerResponse getLookContentHistoryByUserId(String userId,
                                                        Long loginUserId,
                                                        Long page,
                                                        Long pageSize) {
        List<TCContent> tcContentList = tcContentDao.getLookContentHistoryByUserId(userId, page, pageSize, loginUserId);
        return ServerResponse.success("ok", tcContentList);
    }

    /** ---------------------------------------- 内容上传处理区域 start ----------------------------------------**/

    /**
     * 上传内容
     *
     * @param tcContent    内容信息
     * @param imgs         图片列表
     * @param atUserIdList @用户列表
     */
    @Override
    public ServerResponse upContent(TCContent tcContent, List<String> atUserIdList, List<String> joinGambitIdList, MultipartFile[] imgs, Map<Integer, InputStream> imgSteamMap) {
        LocalMQconsumerThread.addQueueItem(() -> {
            if (!Objects.isNull(tcContent)) {
                // 内容上传者用户id
                Long userId = tcContent.getUserId();
                // 插入内容
                tcContentDao.insertSelective(tcContent);
                // 插入互动数据
                TCInteractionInfo tcInteractionInfo = new TCInteractionInfo();
                tcInteractionInfo.setContentId(tcContent.getId());
                tcInteractionInfo.setContentType(ContentTypeEnum.CONTENT.getType());
                tcInteractionInfoDao.insertSelective(tcInteractionInfo);
                // 内容id
                Long contentId = tcContent.getId();
                // 处理at用户
                if (!Objects.isNull(atUserIdList)) {
                    for (String id : atUserIdList) {
                        Long byUserId = Long.parseLong(id);
                        TRecAt tRecAt = new TRecAt();
                        tRecAt.setUserId(userId);
                        tRecAt.setByUserId(byUserId);
                        tRecAt.setSrcId(contentId);
                        tRecAt.setSrcType(String.valueOf(ContentTypeEnum.CONTENT.getType()));
                        tRecAtDao.insertSelective(tRecAt);
                    }
                }
                // 处理加入话题
                if (!Objects.isNull(joinGambitIdList)) {
                    for (String id : joinGambitIdList) {
                        Long gambitId = Long.parseLong(id);
                        TRecJoinGambit tRecJoinGambit = new TRecJoinGambit();
                        tRecJoinGambit.setGambitId(gambitId);
                        tRecJoinGambit.setSrcId(contentId);
                        tRecJoinGambit.setSrcType(String.valueOf(ContentTypeEnum.CONTENT.getType()));
                        tRecJoinGambitDao.insertSelective(tRecJoinGambit);
                    }
                }
                if (!Objects.isNull(imgs)) {
                    // 处理图片上传
                    commService.imgUpLoadByArr(imgs, contentId, userId, imgSteamMap, ImgTypeEnum.CONTENTIMG);
                }
            }
            logger.info("内容上传");
        });
        return ServerResponse.success("ok");
    }

    /**
     * 评论内容
     *
     * @param tcComment    评论信息
     * @param imgs         图片列表
     * @param atUserIdList @用户列表
     */
    @Override
    public ServerResponse commentContent(TCComment tcComment, List<String> atUserIdList, MultipartFile[] imgs, Map<Integer, InputStream> imgSteamMap) {
        //添加到队列中处理
        LocalMQconsumerThread.addQueueItem(() -> {
            if (!Objects.isNull(tcComment)) {
                // 内容上传者用户id
                Long userId = tcComment.getUserId();
                // 指定被评论内容类型
                tcComment.setContentType(ContentTypeEnum.CONTENT.getType());
                // 插入内容
                tcCommentDao.insertSelective(tcComment);
                // 插入互动数据
                TCInteractionInfo tcInteractionInfo = new TCInteractionInfo();
                tcInteractionInfo.setContentId(tcComment.getId());
                tcInteractionInfo.setContentType(ContentTypeEnum.COMMENT.getType());
                tcInteractionInfoDao.insertSelective(tcInteractionInfo);
                // 内容id
                Long contentId = tcComment.getId();
                if (!Objects.isNull(atUserIdList)) {
                    // 处理at用户
                    for (String id : atUserIdList) {
                        Long byUserId = Long.parseLong(id);
                        TRecAt tRecAt = new TRecAt();
                        tRecAt.setUserId(userId);
                        tRecAt.setByUserId(byUserId);
                        tRecAt.setSrcId(contentId);
                        tRecAt.setSrcType(String.valueOf(ContentTypeEnum.COMMENT.getType()));
                        tRecAtDao.insertSelective(tRecAt);
                    }
                }
                if (!Objects.isNull(imgs)) {
                    // 处理图片上传
                    commService.imgUpLoadByArr(imgs, contentId, userId, imgSteamMap, ImgTypeEnum.COMMENTIMG);
                }
            }
            logger.info("评论");
        });
        return ServerResponse.success("ok");
    }

    /**
     * 回复
     *
     * @param tcReply      回复内容
     * @param imgs         图片列表
     * @param atUserIdList @用户列表
     */
    @Override
    public ServerResponse reply(TCReply tcReply, List<String> atUserIdList, MultipartFile[] imgs, Map<Integer, InputStream> imgSteamMap) {
        //添加到队列中处理
        LocalMQconsumerThread.addQueueItem(() -> {
            if (!Objects.isNull(tcReply)) {
                // 内容上传者用户id
                Long userId = tcReply.getUserId();
                // 插入内容
                tcReplyDao.insertSelective(tcReply);
                // 插入互动数据
                TCInteractionInfo tcInteractionInfo = new TCInteractionInfo();
                tcInteractionInfo.setContentId(tcReply.getId());
                tcInteractionInfo.setContentType(ContentTypeEnum.REPLY.getType());
                tcInteractionInfoDao.insertSelective(tcInteractionInfo);
                // 内容id
                Long contentId = tcReply.getId();
                if (!Objects.isNull(atUserIdList)) {
                    // 处理at用户
                    for (String id : atUserIdList) {
                        Long byUserId = Long.parseLong(id);
                        TRecAt tRecAt = new TRecAt();
                        tRecAt.setUserId(userId);
                        tRecAt.setByUserId(byUserId);
                        tRecAt.setSrcId(contentId);
                        tRecAt.setSrcType(String.valueOf(ContentTypeEnum.CONTENT.getType()));
                        tRecAtDao.insertSelective(tRecAt);
                    }
                }
                if (!Objects.isNull(imgs)) {
                    // 处理图片上传
                    commService.imgUpLoadByArr(imgs, contentId, userId, imgSteamMap, ImgTypeEnum.REPLYIMG);
                }
            }
            logger.info("回复");
        });
        return ServerResponse.success("ok");
    }

    /** ---------------------------------------- 内容上传处理区域 end ----------------------------------------**/

}
